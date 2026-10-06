<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_IntegrationSetup.aspx.vb" Inherits="PbNIT.PM_IntegrationSetup" %>

<!DOCTYPE html>

<html>
            <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
          <%CommonFunctions.General.PlotPageHeadTag("Project setting")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project setting</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
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
        div#NoProjectDivID {
            width: 60%;
            margin: 100px auto;
            text-align: center;
            background-color: #fff;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px 0px #ddd;
        }

        #NoProjectDivID i {
            font-size: 30px;
            vertical-align: middle;
            margin-right: 10px;
            color: #ed1c24;
        }

        .map-tbl thead th, .map-tbl tbody td {
            text-align: left !important;
        }

        .bor-div {
            padding: 0px;
        }

        .note-wrap.note-wrap-full.map-value-head {
            margin: 0;
        }

        .half-width.bor-div {
            width: 49.8%;
            display: inline-block;
            margin: 2px 0px;
        }

        .bor-div {
            border: 1px solid #ddd;
        }

        .half-width.bor-div .note-wrap {
            padding: 10px 15px 5px;
        }

            .half-width.bor-div .note-wrap p {
                font-weight: 600;
            }

        .define-attr-wrap {
            background-color: #efefef;
            text-align: right;
            padding: 8px 8px 6px;
            border-top: 1px solid #ddd;
            box-shadow: none;
            margin-top: -2px;
        }

        .issue-inner-tbl {
            max-height: 250px;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .inner-tabing-inmodal {
            margin-top: 0px;
            border-top: 0px;
            text-align: left;
        }

            .inner-tabing-inmodal .table th, .inner-tabing-inmodal .table td, .val-map-tbl thead th, .val-map-tbl tbody td {
                text-align: left;
            }

        .attr-slt li {
            text-align: left;
            width: 100% !important;
        }

        .blue-txt {
            padding: 5px 15px 1px;
            color: #0000ff;
            font-weight: 500;
        }

            .blue-txt p {
                font-size: 14px;
            }

        .tbl-head-blue {
            background-color: #f5f5f5;
            font-weight: 500;
        }

        .map-tbl tbody td:first-child {
            padding-left: 30px;
        }

        .pl-10 {
            padding-left: 10px !important;
        }

        .note-wrap.note-wrap-full.map-value-head {
            width: 100% !important;
        }

        .custom_chckbox input[type=checkbox][disabled] + label:before {
            margin-right: 15px;
            CURSOR: NOT-ALLOWED;
        }

        /*New css added by pradip on 28-11-2019*/
        .value-map-row {
            column-count: 2;
            margin: 0 15px;
        }

            .value-map-row .half-width.bor-div {
                margin: 7px 0;
                width: 100%;
                border-radius: 2px;
            }

            .value-map-row .half-width table th {
                background: none;
                padding: 8px;
            }

            .value-map-row .half-width.bor-div .mar-10 {
                min-height: 150px;
            }

        #integrationSetupHistorytbl table.dataTable thead .sorting:after {
            top: 10px;
        }

        .modal, .modal-backdrop {
            margin: 0;
            padding: 0;
        }

        #valueMaptblbody .tbl-head-blue {
            background: none;
        }

        #attrValueMap > ul {
            padding: 0px 20px;
        }

        .note-wrap-txt {
            width: 97% !important;
            margin: 15px auto;
            display: flex;
        }

        .map-tbl {
            width: 97%;
            margin: 0 auto 20px;
        }

        .modal-body .note-wrap-txt {
            width: 100% !important;
            margin-top: 0px;
            display: block;
        }

        .alertify-notifier {
            z-index: 9999 !important;
        }
        .custmodal .modal-content .modal-header .close {
    background: transparent;
    top: 4px!important;
}
    </style>


<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="pstblintegrationsetupBody">
    <% If m_blnISViewAccess = True Then %>
    <div class="tab-pane pstbl_custom pt-0 practicesettinglist in active" id="pstblintegrationsetup">
        <div class="modalpgHead pt-1 pb-1 col-sm-12 mb-10">
            <span><%= MyBase.GetResourceString("C_IntegrationSetup") %></span>
        </div>
        <h5 class="float-start pl-20 clearfix">Project Name : <span id="spanProjectName"></span></h5>
        <div class="right-side-save mb-10">
            <% If m_blnISAddAccess = True Or m_blnISEditAccess = True Then %>
            <a href="javascript:;" class="btn btnyellow mr-5" onclick="SaveIntegrationDetails()"><%= MyBase.GetResourceString("C_Save") %></a>
            <% End If  %>
            <a href="javascript:;" class="btn borderbtn" onclick="GetIntegrationHistoryList()" id="IntegrationHistoryTab"><%= MyBase.GetResourceString("C_ShowHistory") %></a>
        </div>


        <div class="col-sm-12 pl-20">
            <div class="row pt-1 pb-1 bgwhite">
                <div class="col-sm-4 mb-10">

                    <label><%= MyBase.GetResourceString("C_SourceType") %> <span style="color: red">*</span></label>
                    <% CommonFunctions.HTMLControls.DrawComboBox("cboSourceType", "usp_Whizible2_sel_tbl_FCI_SystemMaster",,, "class='form-select '",,,) %>
                </div>
                <div class="col-sm-4 mb-10">

                    <label><%= MyBase.GetResourceString("C_TimeZone") %> <span style="color: red">*</span></label>
                    <% CommonFunctions.HTMLControls.DrawComboBox("cboTimeZone", "usp_Whizible2_Sel_tbl_FCI_ZoneGMTSettingss",,, "class='form-select '",,,) %>
                </div>
                <div class="col-sm-4 mb-10">
                    <label>&nbsp;</label>
                    <div class="custom_chckbox">
                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsSinglField", "chkIsSinglField") %>
                        <label for="chkIsSinglField"><%= MyBase.GetResourceString("C_SingleFieldForDateTime") %></label>
                    </div>
                </div>
                <div class="col-sm-12 mb-10">
                    <label>&nbsp;</label>
                    <div class="custom_chckbox">
                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsIssueAssignment", "chkIsIssueAssignment") %>
                        <label for="chkIsIssueAssignment"><%= MyBase.GetResourceString("C_DisableReassignment") %></label>
                    </div>
                </div>

            </div>
        </div>
        <div class="inner-tabing" id="attrValueMap" style="width: 100%!important">
            <ul class="nav nav-tabs">
                <li class=""><a class="active" data-bs-toggle="tab" href="#attrMap" aria-expanded="true" id="attrMapTab" onclick="ActiveViewTabs(this.id)"><%= MyBase.GetResourceString("C_AttributeMapping") %></a></li>
                <li class=""><a data-bs-toggle="tab" href="#valMap" aria-expanded="false" id="valueMapTab" onclick="ActiveViewTabs(this.id)"><%= MyBase.GetResourceString("C_ValueMapping") %></a></li>
            </ul>
            <div class="tab-content">
                <div id="attrMap" class="tab-pane fade active in show">
                    <div class="row">
                        <div class="col-sm-3 pl-30">
                            <label><%= MyBase.GetResourceString("C_ShowActiveAttributes") %></label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboActiveAttr", "usp_Whizible2_Sel_tbl_UI_ControlTagMaster_SPForCheckBox ",,, "class='form-select' onChange='javascript:Attribute_OnChange(this.value);'",,,) %>
                        </div>
                        <% If m_blnISAddAccess = True Or m_blnISEditAccess = True Then %>
                        <div class="col-sm-9">
                            <div class="right-side-save">
                                <a href="javascript:;" class="btn borderbtn" id="" onclick="MapAttributes_Onclick()"><%= MyBase.GetResourceString("C_MapAttributes") %></a>
                            </div>
                        </div>
                        <% End If %>
                    </div>
                    <div class="note-wrap note-wrap-txt text-end blue-txt">
                        <p><%= MyBase.GetResourceString("C_InactiveAttributsNote") %></p>
                    </div>
                   
                    <table class="table table-stripped table-bordered map-tbl">
                        <thead>
                            <tr>
                                <th class="text-start">PMLifeLine Attribute</th>
                                <th>System Attribute</th>
                            </tr>
                            <tr>
                                <th colspan="2">Issue Attributes</th>
                            </tr>
                        </thead>
                        <tbody id="attrMaptblBody">
                        </tbody>

                        <thead id="theadcustomattrMap">
                            <tr>
                                <th colspan="2">Custom Attributes</th>
                            </tr>
                        </thead>
                        <tbody id="customattrMaptblBody">
                        </tbody>


                    </table>

                </div>
                <div id="valMap" class="tab-pane fade">
                    <div class="value-map-row" id="divvalMaprow">
                    </div>
                </div>
            </div>
        </div>



        <!--Page modal start here-->

        <!--System Attribute modal start here -->
        <div class="modal custmodal fade" id="sysAttrModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_AttributeMapping") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group mb-3">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_WhizibleAttribute") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtWhizibleAttribute", "txtWhizibleAttribute", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_SystemAttribute") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtSystemAttribute", "txtSystemAttribute", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4 pt-20">
                                <div class="custom_chckbox modal-inn-check">
                                    <%--<input type="checkbox" id="IsActive" class="chckHead complexitychck">--%>
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsActive", "chkIsActive") %>
                                    <label for="chkIsActive"></label>
                                </div>
                                <label><%= MyBase.GetResourceString("C_IsActive") %></label>
                            </div>
                        </div>
                        <div class="btn-grp-new">
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                            <% If m_blnISAddAccess = True Or m_blnISEditAccess = True Then %>
                            <a href="javascript:;" class="btn btnyellow" onclick="SaveAttribute_Onclick()" id="btnSaveAttribute"><%= MyBase.GetResourceString("C_Save") %></a>
                            <% End If  %>
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5" onclick="GetAttributeHistoryList()" id="AttributeHistoryTab"><%= MyBase.GetResourceString("C_ShowHistory") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--System Attribute modal end here -->

        <!--Map Attribute modal start here -->
        <div class="modal custmodal fade" id="mapAttrModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_MapAttributes") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group inner-tabing inner-tabing-inmodal">
                            <ul class="nav nav-tabs">
                                <li class="active"><a class="active" data-bs-toggle="tab" href="#issueAttrinModal" aria-expanded="true" id="issueAttrTab" onclick="ActiveViewTabs(this.id)"><%= MyBase.GetResourceString("C_IssueAttributes") %></a></li>
                                <li class=""><a data-bs-toggle="tab" href="#custAttrinModal" aria-expanded="false" id="custAttrTab" onclick="ActiveViewTabs(this.id)"><%= MyBase.GetResourceString("C_CustomAttributes") %></a></li>
                            </ul>

                            <div class="page-main-head">
                                <h4><%= MyBase.GetResourceString("C_AttributeMapping") %></h4>
                            </div>
                            <div class="tab-content">
                                <div id="issueAttrinModal" class="tab-pane fade active in show">
                                    <div class="row pt-10 mb-20">
                                        <div class="col-sm-4">
                                            <label><%= MyBase.GetResourceString("C_WhizibleAttribute") %></label>
                                            <input type="text" placeholder="Search..." id="txtSearchWhizibleAttribute" class="form-control live-search" onkeyup="WhizibleIssueAttrSearch(this)" aria-describedby="search-icon5" tabindex="1" />
                                        </div>
                                    </div>
                                    <div class="issue-inner-tbl slim-scroll mb-3">
                                        <table class="table table-bordered table-stripped" id="issueAttrtbl">
                                            <thead>
                                                <tr>
                                                    <th><%= MyBase.GetResourceString("C_WhizibleAttribute") %></th>
                                                    <th><%= MyBase.GetResourceString("C_SystemAttribute") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="issueAttrtbody">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div id="custAttrinModal" class="tab-pane fade">
                                    <div class="issue-inner-tbl slim-scroll">
                                        <div class="row pt-10 mb-20">
                                            <div class="col-sm-4">
                                                <label><%= MyBase.GetResourceString("C_WhizibleAttribute") %></label>
                                                <input type="text" placeholder="Search..." id="txtSearchWhizibleAttr" class="form-control live-search" onkeyup="WhizibleCustomAttrSearch(this)" aria-describedby="search-icon5" tabindex="1" />
                                            </div>
                                        </div>
                                        <table class="table table-bordered table-stripped" id="CustomAttrtbl">
                                            <thead>
                                                <tr>
                                                    <th><%= MyBase.GetResourceString("C_WhizibleAttribute") %></th>
                                                    <th><%= MyBase.GetResourceString("C_SystemAttribute") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="customAttrtbody">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="btn-grp-new">
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" class="btn btnyellow" onclick="AddAttribute_Onclick()" id="btnAddAttribute"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Map Attribute modal end here -->

        <!--Value Mapping modal start here -->
        <div class="modal custmodal fade" id="valueMapModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ValueMapping") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group issue-inner-tbl">
                            <table class="table table-bordered table-stripped val-map-tbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_WhizibleAttribute") %></th>
                                        <th><%= MyBase.GetResourceString("C_WhizibleValue") %></th>
                                        <th><%= MyBase.GetResourceString("C_SystemValue") %></th>
                                        <th><%= MyBase.GetResourceString("C_ShowHistory") %></th>
                                    </tr>
                                </thead>
                                <tbody id="valueMaptblbody">
                                </tbody>
                            </table>
                        </div>
                        <div class="btn-grp-new">
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                            <% If m_blnISAddAccess = True Or m_blnISEditAccess = True Then %>
                            <a href="javascript:;" class="btn btnyellow" onclick="ValueMappedSave()" id="btnValuemapSave"><%= MyBase.GetResourceString("C_Save") %></a>
                            <% End If %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Value Mapping modal end here -->

        <!--Show History modal for value map start here -->
        <div class="modal custmodal fade" id="valMapHistory" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_History") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="page-main-head">
                            <h4><%= MyBase.GetResourceString("C_ValueMappingAuditTrail") %></h4>
                        </div>
                        <div class="issue-inner-tbl">
                            <table class="table table-bordered table-stripped" id="valMapHistorytbl" style="width: 100%!important">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_ModifiedDate") %></th>
                                        <th><%= MyBase.GetResourceString("C_ModifiedField") %></th>
                                        <th><%= MyBase.GetResourceString("C_OldValue") %></th>
                                        <th><%= MyBase.GetResourceString("C_NewValue") %></th>
                                        <th><%= MyBase.GetResourceString("C_ModifiedBy") %></th>
                                    </tr>
                                </thead>
                                <tbody id="valMapHistoryBody">
                                </tbody>
                            </table>
                        </div>
                        <div class="text-center">
                            <a href="javascript:;" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#valueMapModal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Show History modal for value map end here -->

        <!--Show History modal for Attribute start here -->
        <div class="modal custmodal fade" id="attrMapHistory" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_History") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="page-main-head">
                            <h4><span class="text-start"><%= MyBase.GetResourceString("C_AuditTrail") %>&nbsp;&nbsp;</span><span class="fl-right"><%= MyBase.GetResourceString("C_AttributeMapping") %></span></h4>
                        </div>
                        <div class="issue-inner-tbl">
                            <table class="table table-bordered table-stripped" id="attrMapHistorytbl" style="width: 100%!important">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_ModifiedDate") %></th>
                                        <th><%= MyBase.GetResourceString("C_ModifiedField") %></th>
                                        <th><%= MyBase.GetResourceString("C_OldValue") %></th>
                                        <th><%= MyBase.GetResourceString("C_NewValue") %></th>
                                        <th><%= MyBase.GetResourceString("C_ModifiedBy") %></th>
                                    </tr>
                                </thead>
                                <tbody id="attrMapHistorytblBody">
                                    <%--<tr>
                                                        <td colspan="4">There are no items to show in this view.</td>
                                                    </tr>--%>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-center">
                            <a href="javascript:;" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#sysAttrModal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Show History modal for Attribute end here -->


        <!--integration Details History modal start here-->
        <div class="modal custmodal fade" id="integrationSetupHistory" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_History") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="note-wrap note-wrap-txt pt-10">
                            <h5><span class="text-start"><%= MyBase.GetResourceString("C_AuditTrail") %>&nbsp;&nbsp;</span><span class="fl-right"><%= MyBase.GetResourceString("C_IntegrationSetup") %></span></h5>
                        </div>
                        <table class="table table-stripped table-bordered" id="integrationSetupHistorytbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_ModifiedDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_ModifiedField") %></th>
                                    <th><%= MyBase.GetResourceString("C_OldValue") %></th>
                                    <th><%= MyBase.GetResourceString("C_NewValue") %></th>
                                    <th><%= MyBase.GetResourceString("C_ModifiedBy") %></th>
                                </tr>
                            </thead>
                            <tbody id="integrationSetupHistorytblbody">
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <div class="text-center">
                            <a data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Integration Details History modal end here-->

        <!--Page modal end here-->

    </div>
    <% ELSE %>
    <div id="NotAuthorized">
        <h4><%= MyBase.GetResourceString("C_NotAuthorized") %></h4>
    </div>
    <% End If %>
    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i><%= MyBase.GetResourceString("C_NoProject") %></h4>
    </div>



    <!-- REQUIRED JS SCRIPTS -->
            <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->

 <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script> 
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- alertify -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>

    <script>
        //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        //var ProjectID = '<%= ProjectID %>';      
        var ajaxResult = "";
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var blnISAddAccess = "<%=m_blnISAddAccess%>";
        var blnISEditAccess = "<%=m_blnISEditAccess%>";
        var blnISDeleteAccess = "<%= m_blnISDeleteAccess%>";
        var blnISViewAccess = "<%= m_blnISViewAccess%>";
        var IntegrationID = 0;
        var NewIntegrationID = "";
        var NewWhizSysAttributeID = 0;
        var NewAttributeID = 0;
        var Flag = 0;
        var IsCustomField;
        var NewInsWhizAttributeName = "";
        var NewAttributeName = "";
        var ProjectID;

        $(document).ready(function () {
           
            $("#docCatSltAll").click(function () {
                $(".doc-chck").prop('checked', $(this).prop('checked'));
            });

            $(".doc-chck").change(function () {
                if (!$(this).prop("checked")) {
                    $("#docCatSltAll").prop("checked", false);
                }
            });

            params = getParams();
            ProjectID = unescape(params["ProjectID"]);
           
            GetProjectName(ProjectID);
          
            if (ProjectID != 0) {
                ProjectID = ProjectID;
                GetIntegrationDetailsInEdit(ProjectID);
                //alert(NewIntegrationID);
                if (NewIntegrationID != "") {
                    $("#IntegrationHistoryTab").css('display', 'inline-block');
                    $("#attrValueMap").css('display', 'inline-block');
                    var curTab = $('.inner-tabing .nav-tabs>li.active>a').attr('id');
                    ActiveViewTabs(curTab);

                }
                else {
                    $("#IntegrationHistoryTab").css('display', 'none');
                    $("#attrValueMap").css('display', 'none');

                }

            }
            else {
                $("#NoProjectDivID").show();
                $("#pstblintegrationsetup").hide();

            }

        });

        //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
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

        function getURLParameter(url, name) {
            return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
        }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_IntegrationSetup%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_IntegrationSetup%>');
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
        //Add and Edit Integration Setup
        function SaveIntegrationDetails() {
            var CheckResult = ValidateIntegrationDetails();
            if (CheckResult == true) {
                var SystemID = $("#cboSourceType :selected").val();
                var TimeZoneID = $("#cboTimeZone :selected").val();
                var FilePath = "";
                if ($('#chkIsSinglField').is(":checked")) {
                    var IsSingleFLDForDateTime = true;
                }
                else {
                    var IsSingleFLDForDateTime = false;
                }
                if ($('#chkIsIssueAssignment').is(":checked")) {
                    var DisableReassignment = true;
                }
                else {
                    var DisableReassignment = false;
                }
                if (NewIntegrationID == 0 || NewIntegrationID == "") { NewIntegrationID = "Null"; }
                else { NewIntegrationID = NewIntegrationID; }
                var ConfigParameters = {
                    IntegrationID: encodeURI(NewIntegrationID),
                    SystemID: encodeURI(SystemID),
                    ProjectID: encodeURI(ProjectID),
                    FilePath: encodeURI(FilePath),
                    TimeZoneID: encodeURI(TimeZoneID),
                    IsSingleFLDForDateTime: encodeURI(IsSingleFLDForDateTime),
                    DisableReassignment: encodeURI(DisableReassignment),
                    UserName: encodeURI(UserName)

                }
                var paramater = JSON.stringify(ConfigParameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/SaveIntegrationDetails", paramater, false);
                if (strResult != "" && strResult != null && strResult != undefined) {
                    strResult = strResult.split("||");
                    var IntegrationID = strResult[1];
                    if (strResult[0] != "") {
                        alertify.success(strResult[0]);
                    }
                    if (IntegrationID != "") {
                        NewIntegrationID = IntegrationID;
                        GetIntegrationDetailsInEdit(ProjectID);
                        $("#IntegrationHistoryTab").css('display', 'inline-block');
                        $("#attrValueMap").css('display', 'inline-block');
                    }
                    ActiveViewTabs("attrMapTab");
                    refreshMyParent();
                }
            }
        }

        //Get Integration Details data in Edit Mode
        function GetIntegrationDetailsInEdit(ProjectID) {
       
            StartLoader("#pstblintegrationsetupBody");
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),

            }
           
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetIntegrationDetails", paramater, false);
            for (var i = 0; i < strResult.length; i++) {
                var IntegrationID = strResult[i].IntegrationID;
                var SourceType = strResult[i].SystemID;
                var TimeZone = strResult[i].TimeZoneID;
                var SingleFLDForDAteTime = strResult[i].IsSingleFLDForDAteTime;
                var DisableReassignment = strResult[i].DisableReassignment;

                $("#cboSourceType").val(SourceType);
                $("#cboTimeZone").val(TimeZone);
                if (SingleFLDForDAteTime == true) {
                    $("#chkIsSinglField").prop('checked', true);
                }
                else {
                    $("#chkIsSinglField").prop('checked', false);
                }
                if (DisableReassignment == true) {
                    $("#chkIsIssueAssignment").prop('checked', true);
                }
                else {
                    $("#chkIsIssueAssignment").prop('checked', false);
                }

                NewIntegrationID = IntegrationID;
            }
            StopAjaxLoader("#pstblintegrationsetupBody");
        }

        //Function for validate Integration Controls
        function ValidateIntegrationDetails() {
            var objSourceType = $("#cboSourceType :selected").val();
            if (objSourceType == 0) { objSourceType = ""; }
            var objTimeZone = $("#cboTimeZone :selected").val();
            if (objTimeZone == 0) { objTimeZone = ""; }
            if (isBlank(objSourceType)) {
                alertify.error("<%= MyBase.GetResourceString("A_SourceType") %>");
                $('#cboSourceType').focus();
                return false;
            }
            if (isBlank(objTimeZone)) {
                alertify.error("<%= MyBase.GetResourceString("A_TimeZone") %>");
                $('#cboTimeZone').focus();
                return false;
            }
            return true;
        }

        //History Tab In Integration Details

        //History data
        function GetIntegrationHistoryList() {
            $("#integrationSetupHistory").modal('show');
            var TagID = 8056;
            var ConfigParameters = {
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                IntegrationID: encodeURI(NewIntegrationID),
            }
            $("#integrationSetupHistorytbl").dataTable().fnDestroy();
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetIntegrationHistoryDetails", paramater, false);
            $("#integrationSetupHistorytblbody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                StartLoader("#pstblintegrationsetupBody");
                for (var i = 0; i < strResult.length; i++) {
                    var ModifiedField = strResult[i]["FieldName"];
                    var ModifiedDate = strResult[i]["ModifiedDate"];
                    var OldValue = strResult[i]["Value"];
                    var NewValue = strResult[i]["NewValue"];
                    var ModifiedBy = strResult[i]["ModifiedBy"];
                    if (OldValue == null) { OldValue = ""; }
                    if (NewValue == null) { NewValue = ""; }
                    strHTML += '<tr>'
                    strHTML += '<td>' + ModifiedDate
                    strHTML += '</td>'
                    strHTML += '<td>' + ModifiedField
                    strHTML += '</td>'
                    strHTML += '<td>' + OldValue
                    strHTML += '</td>'
                    strHTML += '<td>' + NewValue
                    strHTML += '</td>'
                    strHTML += '<td>' + ModifiedBy
                    strHTML += '</td>'
                    strHTML += '</tr>'

                }
            }
            else {

                <%--alert(1);
                strHTML += '<tr>'
                strHTML += '<td colspan="5" class="text-center"><%= MyBase.GetResourceString("C_NoData") %></td>'
                strHTML += '</tr>'--%>
            }
            $("#integrationSetupHistorytblbody").html('');
            $("#integrationSetupHistorytblbody").append(strHTML);

            StopAjaxLoader("#pstblintegrationsetupBody");
            PaginationHistory("#integrationSetupHistorytbl");
            if (strHTML == "") {
                $("#integrationSetupHistorytblbody tr td").prop("colspan", 5);
            }
        }

        function Attribute_OnChangeold(ChangedAttribute) {
            //alert(NewIntegrationID);
            // alert(ChangedAttribute);
            StartLoader("#pstblintegrationsetupBody");
            var ConfigParameters = {
                IntegrationID: encodeURI(NewIntegrationID),
                IsActiveAttribute: encodeURI(ChangedAttribute)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetAttributeMappingData", paramater, false);
            $("#attrMaptblBody").html('');
            $("#customattrMaptblBody").html('');
            var strHTML = "";
            var strHTML1 = "";
            var WhizAttributeName = "";
            for (var i = 0; i < strResult.length; i++) {
                var WhizSysAttributeID = strResult[i].WhizSysAttributeID;
                var UserFriendlyName = strResult[i].UserFriendlyName;
                var SysAttributeName = strResult[i].SysAttributeName;
                WhizAttributeName = strResult[i].WhizAttributeName;
                var IsCustomField = strResult[i].IsCustomField;
                var IsActive = strResult[i].IsActive;

                if (IsCustomField == true) {
                    WhizAttributeName = WhizAttributeName;
                }
                else {
                    WhizAttributeName = UserFriendlyName;
                }
                if (IsCustomField == true) {
                    $("#theadcustomattrMap").css({ 'display': 'TABLE-HEADER-GROUP' });

                    strHTML1 += '<tr>'
                    strHTML1 += '<td class="text-start">' + WhizAttributeName + '</td>'
                    if (IsActive == false) {
                        strHTML1 += '<td>'
                        strHTML1 += '<a href="javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')" style="font color:blue">' + SysAttributeName + '</a >'
                        strHTML1 += '</td>'
                    }
                    else {
                        strHTML1 += '<td>'
                        strHTML1 += '<a href="javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')">' + SysAttributeName + '</a >'
                        strHTML1 += '</td>'

                    }
                    strHTML1 += '</tr>'
                }
                else {
                    $("#theadcustomattrMap").css('display', 'none');
                    strHTML += '<tr>'
                    //added by omkar 08/01/2020 issue 21188
                    if (UserFriendlyName != null) {
                        strHTML += '<td class="text-start">' + UserFriendlyName + '</td>'
                    } else {
                        strHTML += '<td class="text-start"> </td>'
                    }
                    //end of added by omkar 08/01/2020 issue 21188
                    //strHTML += '<td class="text-start">' + UserFriendlyName + '</td>' 
                    if (IsActive == false) {
                        strHTML += '<td>'
                        strHTML += '<a href = "javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')" style="font color:blue">' + SysAttributeName + '</a >'
                        strHTML += '</td>'
                    }
                    else {
                        strHTML += '<td>'
                        strHTML += '<a href = "javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')">' + SysAttributeName + '</a >'
                        strHTML += '</td>'

                    }
                    strHTML += '</tr>'
                }

            }
            $("#attrMaptblBody").html("");
            $("#attrMaptblBody").html(strHTML);
            $("#customattrMaptblBody").html("");
            $("#customattrMaptblBody").html(strHTML1);
            StopAjaxLoader("#pstblintegrationsetupBody");
        }



        function Attribute_OnChange(ChangedAttribute) {
            StartLoader("#pstblintegrationsetupBody");
            var ConfigParameters = {
                IntegrationID: encodeURI(NewIntegrationID),
                IsActiveAttribute: encodeURI(ChangedAttribute)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetAttributeMappingData", paramater, false);
            $("#attrMaptblBody").html('');
            $("#customattrMaptblBody").html('');
            var strHTML = "";
            var strHTML1 = "";
            var WhizAttributeName = "";


            for (var i = 0; i < strResult.length; i++) {
                var WhizSysAttributeID = strResult[i].WhizSysAttributeID;
                var UserFriendlyName = strResult[i].UserFriendlyName;
                var SysAttributeName = strResult[i].SysAttributeName;
                WhizAttributeName = strResult[i].WhizAttributeName;
                var IsCustomField = strResult[i].IsCustomField;
                var IsActive = strResult[i].IsActive;

                if (IsCustomField == true) {
                    WhizAttributeName = WhizAttributeName;
                }
                else {
                    WhizAttributeName = UserFriendlyName;
                }
                if (IsCustomField == true) {
                    $("#theadcustomattrMap").css({ 'display': 'TABLE-HEADER-GROUP' });

                    strHTML1 += '<tr>'

                    if (IsActive == false) {
                        strHTML1 += '<td class="text-start" style="color:blue">' + WhizAttributeName + '</td>'
                        strHTML1 += '<td>'
                        strHTML1 += '<a href="javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')" style="color:blue">' + SysAttributeName + '</a >'
                        strHTML1 += '</td>'
                    }
                    else {
                        strHTML1 += '<td class="text-start">' + WhizAttributeName + '</td>'
                        strHTML1 += '<td>'
                        strHTML1 += '<a href="javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')">' + SysAttributeName + '</a >'
                        strHTML1 += '</td>'
                    }
                    strHTML1 += '</tr>'
                }
                else {
                    $("#theadcustomattrMap").css('display', 'none');
                    strHTML += '<tr>'

                    if (IsActive == false) {
                        strHTML += '<td class="text-start" style="color:blue">' + UserFriendlyName + '</td>'
                        strHTML += '<td>'
                        strHTML += '<a href = "javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')" style="color:blue">' + SysAttributeName + '</a >'
                        strHTML += '</td>'
                    }
                    else {
                        strHTML += '<td class="text-start">' + UserFriendlyName + '</td>'
                        strHTML += '<td>'
                        strHTML += '<a href = "javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')">' + SysAttributeName + '</a >'
                        strHTML += '</td>'
                    }
                    strHTML += '</tr>'
                }

            }
            $("#attrMaptblBody").html("");
            $("#attrMaptblBody").html(strHTML);
            $("#customattrMaptblBody").html("");
            $("#customattrMaptblBody").html(strHTML1);
            StopAjaxLoader("#pstblintegrationsetupBody");
        }

        //Get Attribute mapping Data
        function GetAttributeMappingData() {
            StartLoader("#pstblintegrationsetupBody");
            var ConfigParameters = {
                IntegrationID: encodeURI(NewIntegrationID),

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetAttributeMappingData", paramater, false);
            $("#attrMaptblBody").html('');
            $("#customattrMaptblBody").html('');
            var strHTML = "";
            var strHTML1 = "";
            var WhizAttributeName = "";
            for (var i = 0; i < strResult.length; i++) {
                var WhizSysAttributeID = strResult[i].WhizSysAttributeID;
                var UserFriendlyName = strResult[i].UserFriendlyName;
                var SysAttributeName = strResult[i].SysAttributeName;
                WhizAttributeName = strResult[i].WhizAttributeName;
                var IsCustomField = strResult[i].IsCustomField;
                var IsActive = strResult[i].IsActive;

                if (IsCustomField == true) {
                    WhizAttributeName = WhizAttributeName;
                }
                else {
                    WhizAttributeName = UserFriendlyName;
                }
                if (IsCustomField == true) {
                    $("#theadcustomattrMap").css({ 'display': 'TABLE-HEADER-GROUP' });

                    strHTML1 += '<tr>'

                    if (IsActive == false) {
                        strHTML1 += '<td class="text-start" style="color:blue">' + WhizAttributeName + '</td>'
                        strHTML1 += '<td>'
                        strHTML1 += '<a href="javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')" style="color:blue">' + SysAttributeName + '</a >'
                        strHTML1 += '</td>'
                    }
                    else {
                        strHTML1 += '<td class="text-start">' + WhizAttributeName + '</td>'
                        strHTML1 += '<td>'
                        strHTML1 += '<a href="javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')">' + SysAttributeName + '</a >'
                        strHTML1 += '</td>'
                    }
                    strHTML1 += '</tr>'
                }
                else {
                    $("#theadcustomattrMap").css('display', 'none');
                    strHTML += '<tr>'

                    if (IsActive == false) {
                        strHTML += '<td class="text-start" style="color:blue">' + UserFriendlyName + '</td>'
                        strHTML += '<td>'
                        strHTML += '<a href = "javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')" style="color:blue">' + SysAttributeName + '</a >'
                        strHTML += '</td>'
                    }
                    else {
                        strHTML += '<td class="text-start">' + UserFriendlyName + '</td>'
                        strHTML += '<td>'
                        strHTML += '<a href = "javascript:;" onclick="SysAttributeName_OnClick(' + WhizSysAttributeID + ')">' + SysAttributeName + '</a >'
                        strHTML += '</td>'
                    }
                    strHTML += '</tr>'
                }

            }
            $("#attrMaptblBody").html("");
            $("#attrMaptblBody").html(strHTML);
            $("#customattrMaptblBody").html("");
            $("#customattrMaptblBody").html(strHTML1);
            StopAjaxLoader("#pstblintegrationsetupBody");
        }

        //Edit Attribute on Name Click

        function SysAttributeName_OnClick(WhizSysAttributeID) {
            NewWhizSysAttributeID = WhizSysAttributeID;
            $("#sysAttrModal").modal('show');
            var IsHistory = IsAttrHistoryData();
            if (IsHistory == true) {
                $("#AttributeHistoryTab").css('display', 'inline-block');
            }
            else {
                $("#AttributeHistoryTab").css('display', 'none');
            }
            StartLoader("#pstblintegrationsetupBody");
            var ConfigParameters = {
                WhizSysAttributeID: encodeURI(NewWhizSysAttributeID),

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetAttributeNameData", paramater, false);
            for (var i = 0; i < strResult.length; i++) {
                WhizSysAttributeID = strResult[i]["WhizSysAttributeID"];
                var WhizAttributeName = strResult[i]["WhizAttributeName"];
                var SysAttributeName = strResult[i]["SysAttributeName"];
                var UserFriendlyName = strResult[i]["UserFriendlyName"];
                var IsActive = strResult[i]["IsActive"];
                var Mandatory = strResult[i]["Mandatory"];

                $("#txtWhizibleAttribute").val(WhizAttributeName);
                $("#txtWhizibleAttribute").prop('disabled', true);
                $("#txtSystemAttribute").val(SysAttributeName);
                if (IsActive == true) {
                    $("#chkIsActive").prop('checked', true);
                }
                else {
                    $("#chkIsActive").prop('checked', false);
                }

                if (Mandatory == "1") {
                    $("#chkIsActive").prop('disabled', true);
                }
                else {
                    $("#chkIsActive").prop('disabled', false);
                }
            }
            StopAjaxLoader("#pstblintegrationsetupBody");
        }

        //Update Attribute And Save
        function SaveAttribute_Onclick() {
            StartLoader("#pstblintegrationsetupBody");
$("#btnSaveAttribute").removeAttr("data-bs-dismiss");

            var WhizibleAttribute = $("#txtWhizibleAttribute").val();
            var SystemAttribute = $("#txtSystemAttribute").val();
            if ($('#chkIsActive').is(":checked")) {
                var IsActive = "1";
            }
            else {
                var IsActive = "0";
            }
            //Added By Usha Pandit On 21.04.2020 For adding validation for blank System Attribute
            if (SystemAttribute.toString().trim() == "") {
                $("#txtSystemAttribute").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("System Attribute should not be left blank"); 
		StopAjaxLoader("#pstblintegrationsetupBody");               
                return;
            }
            //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
            SysAttr = $("#txtSystemAttribute").val();
            if (checkSpecialCharacter(SysAttr, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('System Attribute should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtSystemAttribute").focus();
                return;
            }//End of comment
            //End Of Added By Usha Pandit On 21.04.2020 For adding validation for blank System Attribute
            StartLoader("#pstblintegrationsetupBody");
            var ConfigParameters = {
                SysAttributeName: encodeURI(SystemAttribute),
                IsActiveAttribute: encodeURI(IsActive),
                UserName: encodeURI(UserName),
                WhizSysAttributeID: encodeURI(NewWhizSysAttributeID),

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/SaveAttribute", paramater, false);
            if (strResult != undefined) {
                alertify.success(strResult);
            }
            $("#btnSaveAttribute").attr('data-bs-dismiss', 'modal');
            GetAttributeMappingData();
            //add by omkar 14/1/2020
            var getvalue = jQuery("#cboActiveAttr option:selected").val();

            Attribute_OnChange(getvalue);
            //end of add by omkar 14/1/2020

            StopAjaxLoader("#pstblintegrationsetupBody");
        }

        //Map Attributes On_Click
        function MapAttributes_Onclick() {
            $("#mapAttrModal").modal('show');
            var curTab = $('.inner-tabing-inmodal .nav-tabs>li.active>a').attr('id');
            ActiveViewTabs(curTab);

        }

        function ActiveViewTabs(id) {
            if (id == "attrMapTab") {
                GetAttributeMappingData();
            }
            else if (id == "valueMapTab") {
                GetValueMappingData();
            }
            else if (id == "issueAttrTab") {
                IsCustomField = "0";
                GetIssueAttributeData(IsCustomField);

            }
            else if (id == "custAttrTab") {
                IsCustomField = "1";
                GetCustomAttributeData(IsCustomField);
            }

        }

        //Get Issue Attribute data
        function GetIssueAttributeData(IsCustomField) {

            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
                IntegrationID: encodeURI(NewIntegrationID),
                IsCustomeField: encodeURI(IsCustomField)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetMapAttributesData", paramater, false);
            $("#issueAttrtbody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                for (var i = 0; i < strResult.length; i++) {
                    var RNum = strResult[i].RNum;
                    var WhizAttributeName = strResult[i].WhizAttributeName;
                    NewInsWhizAttributeName = strResult[i].InsWhizAttributeName;

                    strHTML += '<tr>'
                    strHTML += '<td>' + WhizAttributeName + '</td>'
                    var inputTextBox = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtSysAttribute_" + "SysAttributeID", "txtSysAttribute_" + "SysAttributeID", "form-control checkissueid", ,,,, , , ToBeInserted:="PlaceHolder='Enter System Value (Maxlength 100 Char)' autocomplete='Off' maxlength='100'", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputTextBox = inputTextBox.replace(/SysAttributeID/g, RNum);
                    strHTML += '<td>' + inputTextBox + '</td>'
                    strHTML += '</tr>'


                }
            }
            else {
                strHTML += '<tr>'
                strHTML += '<td colspan="5" class="text-center"><%= MyBase.GetResourceString("C_NoData") %></td>'
                strHTML += '</tr>'
            }

            $("#issueAttrtbody").html('');
            $("#issueAttrtbody").html(strHTML);
        }

        //Get Custom Attribute data
        function GetCustomAttributeData(IsCustomField) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
                IntegrationID: encodeURI(NewIntegrationID),
                IsCustomeField: encodeURI(IsCustomField)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetMapAttributesData", paramater, false);
            $("#customAttrtbody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                for (var i = 0; i < strResult.length; i++) {
                    var RNum = strResult[i].RNum;
                    var WhizAttributeName = strResult[i].WhizAttributeName;
                    var InsWhizAttributeName = strResult[i].InsWhizAttributeName;

                    strHTML += '<tr>'
                    strHTML += '<td>' + WhizAttributeName + '</td>'
                    <%--var inputTextBox = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtSysAttribute_" + "SysAttributeID", "txtSysAttribute_" + "SysAttributeID", "form-control checkcustomid", ,,,, , ,, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';--%>
                    var inputTextBox = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtSysCusAttribute_" + "SysAttributeID", "txtSysCusAttribute_" + "SysAttributeID", "form-control checkcustomid", ,,,, , ,, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputTextBox = inputTextBox.replace(/SysAttributeID/g, RNum);
                    strHTML += '<td >' + inputTextBox + '</td>'
                    strHTML += '</tr>'

                }
            }
            else {
                strHTML += '<tr>'
                strHTML += '<td colspan="5" class="text-center"><%= MyBase.GetResourceString("C_NoData") %></td>'
                strHTML += '</tr>'
            }
            $("#customAttrtbody").html('');
            $("#customAttrtbody").html(strHTML);
        }

        //Function for Add Attribute
        var GlobalAttributeName = "";
        var GlobalOrderNumber = "";
        var iscustom = "";
        function AddAttribute_Onclick() {
            var flag = true;
            var ids;
            if (IsCustomField == 0) {
                ids = $('.checkissueid').map(function () {
                    return $(this).attr('id');
                });
            } else {
                ids = $('.checkcustomid').map(function () {
                    return $(this).attr('id');
                });
            }

        // Commented & Added By Rutuja D. on 20 March 2020 For adding blank system attribute values issueid = 
            for (var i = 0; i < ids.length; i++) {

                var id = ids[i];
               
                var IsCustomFieldValue = $("#" + id).hasClass('checkcustomid');
                if (IsCustomFieldValue == true) {
                    IsCustomFieldValue = 1;
                } else {
                    IsCustomFieldValue = 0;
                }
                var Sysvalue = $("#" + id).val();
               
                if (Sysvalue.trim() != '') {
                 var ExistingValue =  GetExistingSystemValues(Sysvalue, IsCustomFieldValue);
                   // console.log(ExistingValue);
                    if (checkSpecialCharacter(Sysvalue, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('System Value should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#" + id).focus();
                        flag = false;
                        return false;
                    }//End of comment
                    if (ExistingValue == true)
                    {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("System Value '" + Sysvalue + "' already exists.");
                        flag = false;
                        ids = [];
                        $("#btnAddAttribute").removeAttr("data-bs-dismiss", "modal");
                        return false;
                    }
                }

            }
            // End Commented & Added By Rutuja D. on 20 March 2020 For adding blank system attribute values issueid = 
            //Added By Usha Pandit On 22.04.2020 To prevent duplicate values insertion
	        var blnDuplicateExists = false;
            var product_ids = [];
            $('*[id*=txtSysAttribute_]').each(function () {
                var current_val = $(this).val();

                for (var ind = 0; ind < product_ids.length; ind++) {
                    if (product_ids[ind] == current_val) {
                        blnDuplicateExists = true;
                    }
                }
                if (current_val != "") {
                    product_ids.push(current_val);
                }
            });

            var Cusproduct_ids = [];
            $('*[id*=txtSysCusAttribute_]').each(function () {
                var current_val = $(this).val();

                for (var Cusind = 0; Cusind < Cusproduct_ids.length; Cusind++) {
                    if (Cusproduct_ids[Cusind] == current_val) {
                        blnDuplicateExists = true;
                    }
                }
                if (current_val != "") {
                    Cusproduct_ids.push(current_val);
                }
            });

            if (blnDuplicateExists == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Duplicate system values are not allowed");
                flag = false;
                return false;
            }
            //End Of Added By Usha Pandit On 22.04.2020 To prevent duplicate values insertion
            //var strResult1 = "";
            if (flag == true) {
                for (var i = 0; i < ids.length; i++) {
                    var id = ids[i];
                    var SysAttributeName = $("#" + id).val();
                    if (IsCustomField == 1) {
                        var strOrderNo = ids[i].replace('txtSysCusAttribute_', '');
                    } else {
                        var strOrderNo = ids[i].replace('txtSysAttribute_', '');
                    }
                    var ConfigParameters = {
                        ProjectID: encodeURI(ProjectID),
                        IntegrationID: encodeURI(NewIntegrationID),
                        IsCustomeField: encodeURI(IsCustomField),
                        strOrderNo: encodeURI(strOrderNo),
                    }
                    var paramater = JSON.stringify(ConfigParameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/AddDataForAddAttribute", paramater, false);
                    var orderNo = strResult.strOrderNo;
                    var IsMandatory = strResult.IsMandatory;
                    var InsWhizAttributeName = strResult.InsWhizAttributeName;
                    //Adedd By Dipali v On 29th Jun 2020 For Page Crash Issues
                    if (InsWhizAttributeName != undefined) {
                        InsWhizAttributeName = InsWhizAttributeName;
                        GlobalAttributeName = InsWhizAttributeName;
                    }
                    else {
                        InsWhizAttributeName = GlobalAttributeName;

                    }


                     if (orderNo != undefined) {
                       
                         GlobalOrderNumber = orderNo;
                          orderNo = orderNo;
                    }
                    else {
                        orderNo = GlobalOrderNumber;

                    }


                    if (IsMandatory != undefined) {
                        IsMandatory = IsMandatory;
                         iscustom=IsMandatory
                    }
                    else {
                        IsMandatory = iscustom;;

                    }

                     //End of Adedd By Dipali v On 29th Jun 2020 For Page Crash Issues

                    if (SysAttributeName != "") {
                        var ConfigParameters = {
                            WhizAttributeName: encodeURI(InsWhizAttributeName),
                            SysAttributeName: encodeURI(SysAttributeName),
                            IntegrationID: encodeURI(NewIntegrationID),
                            ProjectID: encodeURI(ProjectID),
                            IsMandatory: encodeURI(IsMandatory),
                            strOrderNo: encodeURI(orderNo),
                            IsCustomeField: encodeURI(IsCustomField)

                        }
                        var paramater = JSON.stringify(ConfigParameters);

                        //Commented & Added By Rutuja D. on 20 March 2020 For adding blank system attribute values issueid = 23145
                        // var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/AddNewAttribute", paramater, false);
                        var strResult1 = AJAXCallWithResult("/api/PM_ProjectSettings/AddNewAttribute", paramater, false);
                        //End Commented & Added By Rutuja D. on 20 March 2020 For adding blank system attribute values issueid = 23145
                    }
                }

                // Commented & Added By Rutuja D. on 20 March 2020 For adding blank system attribute values issueid = 23145

           <%-- if (strResult != undefined) {
                alertify.success("<%= MyBase.GetResourceString("A_AttributeMapped") %>");
            }

            $("#btnAddAttribute").attr('data-bs-dismiss', 'modal');
            GetAttributeMappingData();--%>
                if (strResult1 != undefined) {
                    alertify.success("<%= MyBase.GetResourceString("A_AttributeMapped") %>");

                    //$("#btnAddAttribute").attr('data-bs-dismiss', 'modal');//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                    GetAttributeMappingData();
                } else {
                    alertify.error("Please Enter At Least One System Value. ");
                    $("#btnAddAttribute").removeAttr("data-bs-dismiss", "modal");
                }
            }
           //End Commented & Added By Rutuja D. on 20 March 2020 For adding blank system attribute values issueid = 23145

        }

        //Attribute History Section Start here 
        function IsAttrHistoryData() {
            var TagID = 8061;
            var ConfigParameters = {
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                UniqueID: encodeURI(NewWhizSysAttributeID),
            }
            $("#attrMapHistorytbl").dataTable().fnDestroy();
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetattrMapHistoryData", paramater, false);
            if (strResult.length > 0) {
                return true;
            }
            else {
                return false;
            }
        }
        function GetAttributeHistoryList() {
            $("#attrMapHistory").modal('show');
            var TagID = 8061;
            var ConfigParameters = {
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                UniqueID: encodeURI(NewWhizSysAttributeID),
            }
            $("#attrMapHistorytbl").dataTable().fnDestroy();
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetattrMapHistoryData", paramater, false);
            $("#attrMapHistorytblBody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                StartLoader("#pstblintegrationsetupBody");
                for (var i = 0; i < strResult.length; i++) {
                    //Add by omkar 08/01/2020 issue 21179
                    if (strResult[i]["ModifiedBy"] != null) {
                        // end of Add by omkar 08/01/2020 issue 21179
                        var ModifiedField = strResult[i]["FieldName"];
                        var ModifiedDate = strResult[i]["ModifiedDate"];
                        var OldValue = strResult[i]["Value"];
                        var NewValue = strResult[i]["NewValue"];
                        var ModifiedBy = strResult[i]["ModifiedBy"];
                        if (OldValue == null) { OldValue = ""; }
                        if (NewValue == null) { NewValue = ""; }
                        strHTML += '<tr>'
                        strHTML += '<td>' + ModifiedDate
                        strHTML += '</td>'
                        strHTML += '<td>' + ModifiedField
                        strHTML += '</td>'
                        strHTML += '<td>' + OldValue
                        strHTML += '</td>'
                        strHTML += '<td>' + NewValue
                        strHTML += '</td>'
                        strHTML += '<td>' + ModifiedBy
                        strHTML += '</td>'
                        strHTML += '</tr>'
                        // Add by omkar 08/01/2020 issue 21179
                    }
                    // end of Add by omkar 08/01/2020 issue 21179
                }
                $("#attrMapHistorytblBody").html('');
                $("#attrMapHistorytblBody").append(strHTML);
                StopAjaxLoader("#pstblintegrationsetupBody");
                PaginationHistory("#attrMapHistorytbl");
            }
        }

        //Attribute History Section End here

        //Get Value mapping Data in Grid
        function GetValueMappingData() {

            StartLoader("#pstblintegrationsetupBody");
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetAttributeValueMappingData", paramater, false);
            $("#divvalMaprow").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var UserFriendlyName = strResult[i].UserFriendlyName;
                var WhizSysAttributeID = strResult[i].WhizSysAttributeID;

                strHTML += '<div class="half-width bor-div">'
                strHTML += '<div class="note-wrap note-wrap-full map-value-head">'
                strHTML += '<p>' + UserFriendlyName + '</p>'
                strHTML += '</div>'
                strHTML += '<div class="mar-10">'
                strHTML += '<table class="table val-map-tbl mb-0">'
                strHTML += '<thead>'
                strHTML += '<tr>'
                strHTML += '<th> Whizible Values </th>'
                strHTML += '<th> System Values </th>'
                strHTML += '</tr>'
                strHTML += '</thead>'
                strHTML += '<tbody id="valMapRowtblBody_' + WhizSysAttributeID + '">'
                strHTML += '</tbody>'
                strHTML += '</table>'
                strHTML += '</div>'
                strHTML += '<div class="define-attr-wrap">'
                strHTML += '<a href="javascript:;" onclick="DefineAttributeValue_Onclick(' + WhizSysAttributeID + ')">Define attribute value mapping...</a>'
                strHTML += '</div>'
                strHTML += '</div>'

                $("#divvalMaprow").html("");
                $("#divvalMaprow").append(strHTML);


            }
            for (var i = 0; i < strResult.length; i++) {
                var WhizSysAttributeID = strResult[i].WhizSysAttributeID;
                ValueMappingDataInEdit(WhizSysAttributeID);
            }

            StopAjaxLoader("#pstblintegrationsetupBody");
        }

        function ValueMappingDataInEdit(WhizSysAttributeID) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
                WhizSysAttributeID: encodeURI(WhizSysAttributeID),

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetAttributeValueMappingData", paramater, false);
            var mapid = "#divvalMaprow > div > div > table>#valMapRowtblBody_" + WhizSysAttributeID;
            $(mapid).html('');
            var strHTML = "";
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    var WhizValue = strResult[i].WhizValue;
                    var SysValue = strResult[i].SysValue;

                    strHTML += '<tr>'
                    strHTML += '<td>' + WhizValue + '</td>'
                    strHTML += '<td>' + SysValue + '</td>'
                    strHTML += '</tr>'
                }
            }

            $(mapid).html('');
            $(mapid).append(strHTML);
        }

        var array = [];
        function DefineAttributeValue_Onclick(WhizSysAttributeID) {

            NewAttributeID = WhizSysAttributeID;
            $("#valueMapModal").modal('show');
            var ConfigParameters = {
                WhizSysAttributeID: encodeURI(NewAttributeID),
                ProjectID: encodeURI(ProjectID),
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetDefineValueMappedData", paramater, false);
            $("#valueMaptblbody").html('');
            var strHTML = "";
            var intCnt = 0;
            //by Vishal Mahajan 25-10-2019
            array = [];
            //by Vishal Mahajan 25-10-2019
            if (strResult.length > 0) {
                for (var i = 0; i < strResult.length; i++) {

                    var WhizAttributeName = strResult[i].WhizAttributeName;
                    var WhizValue = strResult[i].WhizValue;
                    var SysValue = strResult[i].SysValue;
                    var WhizSysValueID = strResult[i].WhizSysValueID;
                    array.push(WhizValue);
                    strHTML += '<tr>'
                    if (i == 0) {
                        strHTML += '<td colspan="4" class="text-start tbl-head-blue">' + WhizAttributeName + '</td>'
                    }
                    else {
                        strHTML += '<td colspan="4" class="text-start tbl-head-blue"></td>'
                    }
                    strHTML += '</tr>'
                    strHTML += '<tr>'
                    strHTML += '<td></td>'
                    strHTML += '<td>' + WhizValue + '</td>'
                    var inputTextBox = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtvalueMap_" + "intCnt", "txtvalueMap_" + "intCnt", "form-control checkvalueid", ,,,, , ,, ToBeInserted:="PlaceHolder='Enter System Value (Maxlength 100 Char)' autocomplete='Off' maxlength='100'", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputTextBox = inputTextBox.replace(/intCnt/g, intCnt);
                    strHTML += '<td>' + inputTextBox + '</td>'
                    strHTML += '<td><a href="javascript:;" data-bs-dismiss="modal" onclick="ValMapShowHistory(' + NewAttributeID + ',' + WhizSysValueID + ')">Show History</a></td>'
                    strHTML += '</tr>'

                    intCnt++;

                }
            }
            else {
                strHTML += '<tr>'
                strHTML += '<td colspan="5" style="text-align:center!important;" class="text-center">Data Not Available In This View.</td>'
                strHTML += '</tr>'
            }
            $("#valueMaptblbody").html('');
            $("#valueMaptblbody").html(strHTML);
            var Cnt = 0;
            for (var i = 0; i < strResult.length; i++) {
                var SysValue = strResult[i].SysValue;
                if (SysValue != "") {
                    $("#txtvalueMap_" + Cnt).val(SysValue);
                }
                Cnt++;
            }
        }
        // added by omkar 08/01/2020
        var textboxvalue = [];
        // end of added by omkar 08/01/2020
        function ValueMappedSave() {
            // added by omkar 08/01/2020
            var flag = true;
            textboxvalue = [];
            // end of added by omkar 08/01/2020
            var ids = $('.checkvalueid').map(function () {
                return $(this).attr('id');
            });

            // added by omkar 08/01/2020 issue 21180
            for (var i = 0; i < ids.length; i++) {

                var id = ids[i];
                var Sysvalue = $("#" + id).val();
                //alert(Sysvalue);
                if (checkSpecialCharacter(Sysvalue, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('System Value should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#" + id).focus();
                    flag = false;
                    return false;
                }//End of comment
                if (Sysvalue.length > 0 && textboxvalue.indexOf(Sysvalue.toLowerCase()) == -1) {
                    textboxvalue.push(Sysvalue.toLowerCase());
                } else {
                    if (i == 0) {
                        textboxvalue.push(Sysvalue);
                    } else {

                        if (Sysvalue.length > 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                            alertify.error("System Value '" + Sysvalue + "' already exists.");
                            flag = false;
                            textboxvalue = [];
                            ids = [];
                            return false;
                        }
                    }
                }

               
            }
            //end of added by omkar 08/01/2020 issue 21180

            // added by omkar 08/01/2020
            if (flag == true) {
                //Added By Rutuja D. on 20 March 2020 For Avoid blank system values inserting issueid = 23141
                var systextboxvalue = [];
                //End Added By Rutuja D. on 20 March 2020 For Avoid blank system values inserting issueid = 23141
                //end of  added by omkar 08/01/2020
                for (var i = 0; i < ids.length; i++) {
                    var id = ids[i];
                    var Sysvalue = $("#" + id).val();
                    var WhizValue = array[i];
                    //Commented if condition by Nilesh on 08-01-2020-
                    //if (Sysvalue != "") {
                    //End Of Commented if condition by Nilesh on 08-01-2020-


                    //Added By Rutuja D. on 20 March 2020 For Avoid blank system values inserting issueid = 23141
                    Sysvalue = Sysvalue.trim();
                    if (Sysvalue != '') {
                        //End Added By Rutuja D. on 20 March 2020 For Avoid blank system values inserting issueid = 23141

                        var ConfigParameters = {
                            WhizSysAttributeID: encodeURI(NewAttributeID),
                            IntegrationID: encodeURI(NewIntegrationID),
                            SysAttributeName: encodeURI(Sysvalue),
                            WhizAttributeName: encodeURI(WhizValue),
                            ProjectID: encodeURI(ProjectID),
                            UserID: encodeURI(UserID)

                        }
                        var paramater = JSON.stringify(ConfigParameters);
                        var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/ValueMappedSave", paramater, false);
                        //Added By Rutuja D. on 20 March 2020 For Avoid blank system values inserting issueid = 23141
                    } else {

                        var sysvalueblank = systextboxvalue.push(Sysvalue);

                    }
                    //End Added By Rutuja D. on 20 March 2020 For Avoid blank system values inserting issueid = 23141

                 
                }

                //added by omkar 08/01/2020
                if (strResult != "" && strResult != undefined && strResult != null) {
                    alertify.success(strResult);

                    $("#valueMapModal").modal('hide');

                    GetValueMappingData();
                }

                if (systextboxvalue.length == ids.length) {
                    alertify.error("Please Enter At Least One System Value.");
                    systextboxvalue = [];
                    $("#valueMapModal").modal('show');
                }


                //End Commented & Added By Rutuja D. on 20 March 2020 For Avoid blank system values inserting issueid = 23141

            }
            //end of  added by omkar 08/01/2020
        }
        function ValMapShowHistory(NewAttributeID, WhizSysValueID) {
            $("#valMapHistory").modal('show');
            var ConfigParameters = {
                WhizSysAttributeID: encodeURI(NewAttributeID),
                ProjectID: encodeURI(ProjectID),
                UniqueID: encodeURI(WhizSysValueID),
            }
            $("#valMapHistorytbl").dataTable().fnDestroy();
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetValMapHistoryData", paramater, false);
            $("#valMapHistoryBody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                StartLoader("#pstblintegrationsetupBody");
                for (var i = 0; i < strResult.length; i++) {
                    var ModifiedField = strResult[i]["FieldName"];
                    var ModifiedDate = strResult[i]["ModifiedDate"];
                    var OldValue = strResult[i]["Value"];
                    var NewValue = strResult[i]["NewValue"];
                    var ModifiedBy = strResult[i]["ModifiedBy"];
                    if (OldValue == null) { OldValue = ""; }
                    if (NewValue == null) { NewValue = ""; }
                    strHTML += '<tr>'
                    strHTML += '<td>' + ModifiedDate
                    strHTML += '</td>'
                    strHTML += '<td>' + ModifiedField
                    strHTML += '</td>'
                    strHTML += '<td>' + OldValue
                    strHTML += '</td>'
                    strHTML += '<td>' + NewValue
                    strHTML += '</td>'
                    strHTML += '<td>' + ModifiedBy
                    strHTML += '</td>'
                    strHTML += '</tr>'

                }

            }
            else {
             
            }
            $("#valMapHistoryBody").html('');
            $("#valMapHistoryBody").append(strHTML);
            StopAjaxLoader("#pstblintegrationsetupBody");
            PaginationHistory("#valMapHistorytbl");
            if (strHTML == "") {
                $("#valMapHistorytbl tr td").prop("colspan", 5);
            }
        }


        function getParams() {
            var params = {},
                pairs = document.URL.split('?')
                    .pop()
                    .split('&');
            for (var i = 0, p; i < pairs.length; i++) {
                p = pairs[i].split('=');
                params[p[0]] = p[1];
            }
            return params;
        }


        function GetProjectName(ProjectID) {
            //var ProjectID = ProjectID;
            var Parameter = { ProjectId: ProjectID }
            
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                method: 'Post',
                data: JSON.stringify(Parameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (result) {
                    $("#spanProjectName").text(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }
        //Search function in Map Attributes
        function WhizibleIssueAttrSearch(element) {
            var filter, table, tr, td, i, txtValue;
            filter = $(element).val().toUpperCase();
            table = document.getElementById("issueAttrtbl");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function WhizibleCustomAttrSearch(element) {
            var filter, table, tr, td, i, txtValue;
            filter = $(element).val().toUpperCase();
            table = document.getElementById("CustomAttrtbl");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function PaginationHistory(PageID) {
            var stdTable1 = $(PageID).DataTable({
                "pageLength": 3,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "columnDefs": [{
                    'width': '15%',
                    "orderable": false
                },]
            });
            stdTable1.columns.adjust().draw();
            $('#integrationSetupHistory').on('shown.bs.modal', function () {
                if ($.fn.dataTable.tables({ visible: true, api: true }).columns != undefined && $.fn.dataTable.tables({ visible: true, api: true }).columns != null) {
                    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                }
            });
        }
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {

                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        function GetExistingSystemValues(SystemValue, IsCustomFieldValue) {
            var Query = "select SysAttributeName from tbl_FCI_ExternalSysAttribute_Mapping where IsCustomField = " + IsCustomFieldValue + " And ProjectID = " + ProjectID;
            var param = JSON.stringify(Query);
            var result = AJAXCallWithResult("/api/PM_ProjectSettings/GetExistingSystemValues", param, false);
            
            if (result != undefined) {                
                for(var i = 0; i < result.length; i++) {
                    if (SystemValue == result[i].SysAttributeName) {
                        return true;
                    }
                }
            }
        }
    </script>


</body>

</html>
