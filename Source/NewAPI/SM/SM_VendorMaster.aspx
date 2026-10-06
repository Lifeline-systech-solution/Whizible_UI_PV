<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_VendorMaster.aspx.vb" Inherits="Whizible.SM_VendorMaster" %>
<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Vendor Master")%>
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><%=MyBase.GetResourceString("C_PageCaption") %></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css" />
    <style type="text/css">
        .vendor-active-wrap .custom_chckbox label {
            margin-left: 6px;
        }

        #vendorDetailsOffcanvas {
            --bs-offcanvas-width: 81%;
        }

        #vendorDetailsOffcanvas .vendor-form-panel {
            min-height: 300px;
            border: 0 !important;
            border-radius: 0;
            padding: 14px 0 0 0 !important;
        }

        #vendorDetailsOffcanvas input[type='text'],
        #vendorDetailsOffcanvas input[type='email'],
        #vendorDetailsOffcanvas input[type='number'],
        #vendorDetailsOffcanvas select,
        #vendorDetailsOffcanvas textarea {
            max-width: 290px;
        }

        #vendorDetailsOffcanvas .bootstrap-select,
        #vendorDetailsOffcanvas .bootstrap-select .dropdown-toggle {
            max-width: 290px !important;
        }

        #vendorDetailsOffcanvas #vendorTabHeader {
            background: #fff;
            border: 0;
            border-bottom: 1px solid #e5e7eb;
            padding: 0;
            margin: 0 0 14px 0;
            display: flex;
            flex-wrap: wrap;
            gap: 0;
            overflow-x: hidden;
            white-space: nowrap;
        }

        #vendorDetailsOffcanvas #vendorTabHeader > li {
            float: none;
            margin: 0;
          /* margin-left: -4px;*/
        }

        #vendorDetailsOffcanvas #vendorTabHeader > li > a {
            border: 0 !important;
            border-bottom: 2px solid transparent !important;
            border-radius: 0 !important;
            background: transparent !important;
            color: #374151 !important;
            font-size: 12px;
            font-weight: 500;
            padding: 10px 14px;
            line-height: 1.2;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .me-1 {
            margin-right:0.25em !important;
        }

        #vendorDetailsOffcanvas #vendorTabHeader > li > a i {
            font-size: 12px;
            color: #6b7280;
        }

        #vendorDetailsOffcanvas #vendorTabHeader > li.active > a,
        #vendorDetailsOffcanvas #vendorTabHeader > li > a:hover,
        #vendorDetailsOffcanvas #vendorTabHeader > li > a:focus {
            color: #2563eb !important;
            border-bottom: 2px solid #2563eb !important;
            background: transparent !important;
        }

        #vendorDetailsOffcanvas #vendorTabHeader > li.active > a i,
        #vendorDetailsOffcanvas #vendorTabHeader > li > a:hover i,
        #vendorDetailsOffcanvas #vendorTabHeader > li > a:focus i {
            color: #2563eb !important;
        }

        .vendor-action-dot {
            cursor: pointer;
            color: #888888;
            font-size: 16px;
            line-height: 1;
        }

        .tooltip .tooltip-inner {
            font-size: 11.5px;
            line-height: 1.2;
        }

        #vendorDetailsOffcanvas #vendorTabHeader > li.vendor-tab-locked > a {
            pointer-events: none;
            opacity: 0.45;
            cursor: not-allowed !important;
        }

        /* ── Vendor Document Grid (tabDocuments, Edit mode only) ───────────── */
        #vendorDocGrid {
            margin-top: 18px;
        }
        #tblVendorDocList {
            width: 100%;
            border-collapse: collapse;
        }
        #tblVendorDocList thead th {
            font-size: 12px;
            font-weight: 600;
            color: #374151;
            background: #f9fafb;
            border-bottom: 1px solid #e5e7eb;
            padding: 8px 10px;
            white-space: nowrap;
        }
        #tblVendorDocList tbody td {
            font-size: 11.5px;
            color: #374151;
            padding: 7px 10px;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
        }
        #tblVendorDocList tbody tr:hover td {
            background: #f0f4ff;
        }
        #vendorDocGrid .vdoc-download-link {
            color: #2563eb;
            font-size: 12px;
            text-decoration: none;
        }
        #vendorDocGrid .vdoc-download-link:hover {
            text-decoration: underline;
        }

        /* ── Delete checkbox + select-all ─────────────────────────────────── */
        .vendor-del-check {
            width: 14px;
            height: 14px;
            cursor: pointer;
            vertical-align: middle;
        }
        .vendor-del-check:disabled {
            cursor: not-allowed;
            opacity: 0.45;
        }

        /* ── Delete confirm modal ─────────────────────────────────────────── */
        .vendor-delete-modal .modal-dialog  { max-width: 420px; margin: 30px auto; }
        .vendor-delete-modal .modal-content { border-radius: 10px; overflow: hidden; border: 1px solid #d1d5db; }
        .vendor-delete-modal .modal-header  { background: #4564bd; color: #ffffff; padding: 8px 14px; border-bottom: none; }
        .vendor-delete-modal .modal-title   { color: #ffffff !important; font-size: 14px; font-weight: 400; margin: 0 auto; }
        .vendor-delete-modal .modal-body    { text-align: center; font-size: 11.5px; padding: 22px 16px 14px; }
        .vendor-delete-modal .modal-footer  { border-top: none; display: flex; justify-content: space-between; align-items: center; flex-wrap: nowrap; gap: 0; width: 100%; padding: 0 18px 16px; }
        .vendor-delete-modal-close-btn      { background: transparent; border: none; color: #ffffff; font-size: 14px; font-weight: 800; cursor: pointer; opacity: 1; }

        /* ── Close button in offcanvas header ─────────────────────────────── */
        .vendor-offcanvas-close-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 4px 6px;
            background: transparent;
            border: none;
            color: #374151;
            font-size: 16px;
            line-height: 1;
            cursor: pointer;
            opacity: 0.65;
            transition: opacity 0.15s;
        }
        .vendor-offcanvas-close-btn:hover { opacity: 1; background: transparent; }
        .alertify-notifier { z-index: 20000 !important; }
        .alertify-notifier .ajs-message { z-index: 20001 !important; }
        h5.pgtitle {
    margin: 6px 0 0;
    font-weight: 700;
    color: #1e40af;
    font-size: 18px;
}
    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <form id="form1" runat="server">
        <%If m_blnViewAccess = True Then%>
        <%If m_blnEditAccess = True Then%><span id="canEditVendorMasterFlag" style="display:none"></span><%End If%>
        <%If m_blnDeleteAccess = True Then%><span id="canDeleteVendorMasterFlag" style="display:none"></span><%End If%>
        <div class="bgwhite">
            <div class="container-fluid py-2 graybg">
                <%--<h5 class="pgtitle">Vendor Master</h5>--%>
                <h5 class="pgtitle d-flex align-items-center mb-1" style="justify-content:flex-start; float:none;">
            <i class="fas fa-building me-2" style="font-size:18px;"></i>
            <%=MyBase.GetResourceString("C_PageCaption") %>
        </h5> 

                <p class="mb-0" style="color:#6b7280; font-size:13px;">
            <%=MyBase.GetResourceString("C_PageNote") %>
        </p>
            </div>

            <div class="content pt-0 px-2">
                <div class="d-flex justify-content-end pt-2">

                    <button type="button" class="btn btnyellow me-1" id="btnSearchVendor"><%=MyBase.GetResourceString("C_Search") %></button>
                    <button type="button" class="btn borderbtn me-1" id="btnResetVendor"><%=MyBase.GetResourceString("C_Reset") %></button>
                    <%If m_blnAddAccess = True Then%>
                    <a class="btn borderbtn addbtn" id="btnShowAddVendor" href="javascript:;">
                        <i class="fas fa-plus me-1"></i> Add
                    </a>
                    <%End If%>
                    <%If m_blnDeleteAccess = True Then%>
                    <button type="button" class="btn borderbtn ms-1" id="btnDeleteSelectedVendors" onclick="deleteSelectedVendors()">Delete</button>
                    <%End If%>
                </div>

                <div class="TopFilters lightGrey py-2 mb-1 mt-2">
                    <div class="form-group mb-0">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="row form-group">
                                    <label for="txtVendorCodeFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_VendorCode") %></label>
                                    <div class="col-sm-8">
                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtVendorCodeFilter", "txtVendorCodeFilter", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='30' oninput='if(this.value.length>30)this.value=this.value.slice(0,30);'",,, True,,,, True) %>--%>
                                        <input type="text"
                                               id="txtVendorCodeFilter"
                                               name="txtVendorCodeFilter"
                                               class="form-control form-control-sm"
                                               placeholder="Search Vendor Code"
                                               autocomplete="off"
                                               maxlength="30"
                                               onpaste="return true;"
                                               oninput="if(this.value.length>30)this.value=this.value.slice(0,30);" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="row form-group">
                                    <label for="txtVendorNameFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_VendorName") %></label>
                                    <div class="col-sm-8">
                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtVendorNameFilter", "txtVendorNameFilter", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='60' oninput='if(this.value.length>60)this.value=this.value.slice(0,60);'",,, True,,,, True) %>--%>
                                        <input type="text"
                                               id="txtVendorNameFilter"
                                               name="txtVendorNameFilter"
                                               class="form-control form-control-sm"
                                               placeholder="Search Vendor Name"
                                               autocomplete="off"
                                               maxlength="60"
                                               onpaste="return true;"
                                               oninput="if(this.value.length>60)this.value=this.value.slice(0,60);" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="row form-group">
                                    <label for="ddlVendorTypeFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_VendorType") %></label>
                                    <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("ddlVendorTypeFilter", "usp_Whizible2_Sel_VendorType_DrpDwn",,, "class='form-control selectpicker' data-live-search='true'",,, ) %>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="row form-group">
                                    <label for="ddlStatusFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Status") %></label>
                                    <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("ddlStatusFilter", "usp_Whizible2_Sel_Vendor_Status_DrpDwn",,, "class='form-control selectpicker' data-live-search='true'",,, ) %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--<div class="text-end mt-2">
                            <button type="button" class="btn btnyellow me-1" id="btnSearchVendor">Search</button>
                            <button type="button" class="btn borderbtn" id="btnResetVendor">Reset</button>
                        </div>--%>
                    </div>
                </div>

                <div class="mt-3">
                    <table class="table" id="tblVendorList" style="width: 100%;">
                        <thead class="stickyTblHeader">
                            <tr>
                                <th><%=MyBase.GetResourceString("C_VendorCode") %></th>
                                <th><%=MyBase.GetResourceString("C_VendorName") %></th>
                                <th><%=MyBase.GetResourceString("C_VendorType") %></th>
                                <th><%=MyBase.GetResourceString("C_ContactPerson") %></th>
                                <th>Active</th>
                                <th><%=MyBase.GetResourceString("C_Action") %></th>
                                <th class="text-center" style="width:50px;">
                                    <input type="checkbox" class="vendor-del-check" id="chkSelectAllVendors"
                                           title="Select All" data-bs-toggle="tooltip" data-bs-placement="top" />
                                </th>
                            </tr>
                        </thead>
                        <tbody id="tblVendorListBody"></tbody>
                    </table>
                    <div class="d-flex justify-content-end align-items-center gap-2 mt-2">
                        <span id="totalRecords" style="color: #6b7280; font-size: 11.5px;"><%=MyBase.GetResourceString("C_TotalRecords") %>: 0</span>
                        <div style="display: flex; gap: 0.5rem;">
                            <button type="button" class="btn borderbtn" id="vendorPrevBtn" onclick="goToPrevVendorPage()" data-bs-toggle="tooltip" data-bs-title="<%=MyBase.GetResourceString("C_PreviousPage") %>"><i class="fas fa-angle-double-left"></i></button>
                            <button type="button" class="btn borderbtn" id="vendorNextBtn" onclick="goToNextVendorPage()" data-bs-toggle="tooltip" data-bs-title="<%=MyBase.GetResourceString("C_NextPage") %>"><i class="fas fa-angle-double-right"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="offcanvas offcanvas-end shadow" data-bs-scroll="false" tabindex="-1" id="vendorDetailsOffcanvas">
            <div class="offcanvas-header graybg py-2">
                <h5 class="offcanvas-title txt_Blue font-weight-600 mb-0" style="color: #1e40af;">Vendor Details</h5>
                <div class="d-flex gap-2">
                    <button type="button"
                            class="vendor-offcanvas-close-btn"
                            data-bs-dismiss="offcanvas"
                            id="btnCancelVendorTop"
                            data-bs-toggle="tooltip"
                            data-bs-placement="left"
                            title="Close"
                            aria-label="Close">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </div>
            <div class="offcanvas-body">
                <ul id="vendorTabHeader" class="nav nav-tabs detailsubtabs">
                    <li class="active"><a href="#tabBasicInfo" data-bs-toggle="tab"><i class="far fa-id-card me-1"></i><%=MyBase.GetResourceString("C_BasicInformation") %></a></li>
                    <li><a href="#tabContact" data-bs-toggle="tab"><i class="far fa-address-book me-1"></i><%=MyBase.GetResourceString("C_ContactDetails") %></a></li>
                    <li><a href="#tabAddress" data-bs-toggle="tab"><i class="fas fa-map-marker-alt me-1"></i><%=MyBase.GetResourceString("C_AddressDetails") %></a></li>
                    <li><a href="#tabTax" data-bs-toggle="tab"><i class="far fa-file-alt me-1"></i><%=MyBase.GetResourceString("C_TaxAndCompliance") %></a></li>
                    <li><a href="#tabBank" data-bs-toggle="tab"><i class="fas fa-university me-1"></i><%=MyBase.GetResourceString("C_BankDetails") %></a></li>
                    <li><a href="#tabCommercial" data-bs-toggle="tab"><i class="fas fa-briefcase me-1"></i><%=MyBase.GetResourceString("C_CommercialDetails") %></a></li>
                    <li><a href="#tabDocuments" data-bs-toggle="tab"><i class="far fa-folder me-1"></i><%=MyBase.GetResourceString("C_Documents") %></a></li>
                    <li><a href="#tabShowHistory" data-bs-toggle="tab"><i class="far fa-clock me-1"></i><%=MyBase.GetResourceString("C_ShowHistory") %></a></li>
                </ul>

                <div class="tab-content vendor-form-panel">
                    <div class="tab-pane active" id="tabBasicInfo">
                        <div class="d-flex justify-content-end mb-2 vendor-tab-save-row">
                            <button type="button" class="btn btnyellow vendor-tab-save-btn"><%=MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <label for="txtVendorCode"><%=MyBase.GetResourceString("C_VendorCode") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtVendorCode", "txtVendorCode", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='30' oninput='if(this.value.length>30)this.value=this.value.slice(0,30);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtVendorName"><%=MyBase.GetResourceString("C_VendorName") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtVendorName", "txtVendorName", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="ddlVendorType"><%=MyBase.GetResourceString("C_VendorType") %> <span class="text-danger">*</span></label>
                                <select id="ddlVendorType" class="form-control selectpicker" data-live-search="true">
                                    <option value=""><%=MyBase.GetResourceString("C_SelectVendorType") %></option>
                                </select>
                            </div>
                        </div>
                        <div class="row form-group">
                            <%--<div class="col-sm-4">
                            <label for="txtContactPerson">
                                <%=MyBase.GetResourceString("C_ContactPerson") %> <span class="text-danger">*</span>
                            </label>
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtContactPerson", "txtContactPerson", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                        </div>--%>

                            <div class="col-sm-4">
                                <label for="txtVendorDescription"><%=MyBase.GetResourceString("C_Description") %></label>
                              <%--  Commneted & Added By Dipali V On 14th May 2026 For Vendor Description Maxlenght --%>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtVendorDescription", "txtVendorDescription", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='300' oninput='if(this.value.length>300)this.value=this.value.slice(0,300);'",,, True,,,, True) %>--%>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtVendorDescription", "txtVendorDescription", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='500' oninput='if(this.value.length>500)this.value=this.value.slice(0,500);'",,, True,,,, True) %>--%>
                             <textarea id="txtVendorDescription" class="form-control" rows="3" maxlength="500"></textarea>
                                <%--Commneted & Added By Dipali V On 14th May 2026 For Vendor Description Maxlenght--%> 
                            </div>

                            <div class="col-sm-4 vendor-active-wrap">
                                <%--<label class="d-block"><%=MyBase.GetResourceString("C_Status") %></label>--%>
                                <div class="d-flex align-items-center mt-2">
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkVendorActive", "chkVendorActive", "",,,, "") %>
                                        <label for="chkVendorActive"><%=MyBase.GetResourceString("C_Active") %></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabContact">
                        <div class="d-flex justify-content-end mb-2 vendor-tab-save-row">
                            <button type="button" class="btn btnyellow vendor-tab-save-btn"><%=MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <label for="txtPrimaryContactName"><%=MyBase.GetResourceString("C_PrimaryContactPersonName") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPrimaryContactName", "txtPrimaryContactName", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtDesignation"><%=MyBase.GetResourceString("C_Designation") %></label>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtDesignation", "txtDesignation", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='60' oninput='if(this.value.length>60)this.value=this.value.slice(0,60);'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("txtDesignation", "usp_Whizible2_Sel_VendorDesignation_Drpdwn",,, "class='form-control selectpicker' data-live-search='true'",,, ) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtEmailID"><%=MyBase.GetResourceString("C_EmailID") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtEmailID", "txtEmailID", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label for="txtMobileNumber"><%=MyBase.GetResourceString("C_MobileNumber") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtMobileNumber", "txtMobileNumber", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='15' oninput='validateContactNumber(this);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtAlternateContactNumber"><%=MyBase.GetResourceString("C_AlternateContactNumber") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAlternateContactNumber", "txtAlternateContactNumber", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='15' oninput='validateContactNumber(this);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtWebsite"><%=MyBase.GetResourceString("C_Website") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtWebsite", "txtWebsite", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='150' oninput='if(this.value.length>15)this.value=this.value.slice(0,15);'",,, True,,,, True) %>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabAddress">
                        <div class="d-flex justify-content-end mb-2 vendor-tab-save-row">
                            <button type="button" class="btn btnyellow vendor-tab-save-btn"><%=MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <label for="txtAddressLine1"><%=MyBase.GetResourceString("C_AddressLine1") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAddressLine1", "txtAddressLine1", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='150' oninput='if(this.value.length>150)this.value=this.value.slice(0,150);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtAddressLine2"><%=MyBase.GetResourceString("C_AddressLine2") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAddressLine2", "txtAddressLine2", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='150' oninput='if(this.value.length>150)this.value=this.value.slice(0,150);'",,, True,,,, True) %>
                            </div>
                            <%-- Added By Dipali V On 14th May 2026 For blocking numeric key entry in City field at keypress/keydown --%>
                            <div class="col-sm-4">
                                <label for="txtCity"><%=MyBase.GetResourceString("C_City") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCity", "txtCity", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='60' onkeypress='return vendorCityStateKeypress(event);' onkeydown='return vendorCityStateKeydownDigits(event);' oninput='if(this.value.length>60)this.value=this.value.slice(0,60);'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="row form-group">
                            <%-- Added By Dipali V On 14th May 2026 For blocking numeric key entry in State field at keypress/keydown --%>
                            <div class="col-sm-4">
                                <label for="txtState"><%=MyBase.GetResourceString("C_State") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtState", "txtState", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='60' onkeypress='return vendorCityStateKeypress(event);' onkeydown='return vendorCityStateKeydownDigits(event);' oninput='if(this.value.length>60)this.value=this.value.slice(0,60);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtCountry"><%=MyBase.GetResourceString("C_Country") %> <span class="text-danger">*</span></label>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtCountry", "txtCountry", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='60' oninput='if(this.value.length>60)this.value=this.value.slice(0,60);'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("txtCountry", "usp_Whizible2_Sel_VendorCountry_Drpdwn",,, "class='form-control selectpicker' data-live-search='true'",,, ) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtPincode"><%=MyBase.GetResourceString("C_Pincode") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPincode", "txtPincode", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='10' oninput='if(this.value.length>10)this.value=this.value.slice(0,10);'",,, True,,,, True) %>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabTax">
                        <div class="d-flex justify-content-end mb-2 vendor-tab-save-row">
                            <button type="button" class="btn btnyellow vendor-tab-save-btn"><%=MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <label for="txtPANNumber"><%=MyBase.GetResourceString("C_PANNumber") %> <span class="text-danger">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPANNumber", "txtPANNumber", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='10' oninput='if(this.value.length>10)this.value=this.value.slice(0,10);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtGSTIN"><%=MyBase.GetResourceString("C_GSTIN") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtGSTIN", "txtGSTIN", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='15' oninput='if(this.value.length>15)this.value=this.value.slice(0,15);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtTANNumber"><%=MyBase.GetResourceString("C_TANNumber") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtTANNumber", "txtTANNumber", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='10' oninput='if(this.value.length>10)this.value=this.value.slice(0,10);'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <label for="txtCIN"><%=MyBase.GetResourceString("C_CIN") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCIN", "txtCIN", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='21' oninput='if(this.value.length>21)this.value=this.value.slice(0,21);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label class="d-block">&nbsp;</label>
                                <div class="custom_chckbox mt-2">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkMSMERegistered", "chkMSMERegistered", "",,,, "onchange='toggleMSMENumber();'") %>
                                    <label for="chkMSMERegistered"><%=MyBase.GetResourceString("C_MSMERegistered") %></label>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtMSMENumber"><%=MyBase.GetResourceString("C_MSMENumber") %> <span class="text-danger">*</span></label>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtMSMENumber", "txtMSMENumber", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='19' oninput='if(this.value.length>19)this.value=this.value.slice(0,19);'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtMSMENumber", "txtMSMENumber", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='19' oninput='validateMSMENumber(this);'",,, True,,,, True) %>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabBank">
                        <div class="d-flex justify-content-end mb-2 vendor-tab-save-row">
                            <button type="button" class="btn btnyellow vendor-tab-save-btn"><%=MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <label for="txtBankName"><%=MyBase.GetResourceString("C_BankName") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtBankName", "txtBankName", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtAccountHolderName"><%=MyBase.GetResourceString("C_AccountHolderName") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAccountHolderName", "txtAccountHolderName", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtAccountNumber"><%=MyBase.GetResourceString("C_AccountNumber") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAccountNumber", "txtAccountNumber", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='18' oninput='if(this.value.length>18)this.value=this.value.slice(0,18);'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label for="txtIFSCCode"><%=MyBase.GetResourceString("C_IFSCCode") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtIFSCCode", "txtIFSCCode", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='11' oninput='if(this.value.length>11)this.value=this.value.slice(0,11);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtBranchName"><%=MyBase.GetResourceString("C_BranchName") %></label>
                                <%--Commented & Added By Dipali V On 13th May 2026 For Maxlength Change from 80 to 100 as per new requirement--%>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtBranchName", "txtBranchName", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='80' oninput='if(this.value.length>80)this.value=this.value.slice(0,80);'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtBranchName", "txtBranchName", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                            <%--End of Commented & Added By Dipali V On 13th May 2026 For Maxlength Change from 80 to 100 as per new requirement--%>
                            </div>
                            <div class="col-sm-4">
                                <label for="txtUPIID"><%=MyBase.GetResourceString("C_UPIID") %></label>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtUPIID", "txtUPIID", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtUPIID", "txtUPIID", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='60' oninput='validateUPIID(this)';",,, True,,,, True) %>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabCommercial">
                        <div class="d-flex justify-content-end mb-2 vendor-tab-save-row">
                            <button type="button" class="btn btnyellow vendor-tab-save-btn"><%=MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-3">
                                <label for="txtPaymentTerms"><%=MyBase.GetResourceString("C_PaymentTerms") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPaymentTerms", "txtPaymentTerms", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-3">
                                <%-- Added By Dipali V On 14th May 2026 For Credit Limit accepting decimal values (see sanitizeDecimalInput in bindVendorInputValidations) --%>
                                <label for="txtCreditLimit"><%=MyBase.GetResourceString("C_CreditLimit") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCreditLimit", "txtCreditLimit", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='20' onkeydown='return blockInvalidCreditLimitKey(event);' oninput='formatCreditLimit(this);'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-3">
                                <label for="ddlCurrency"><%=MyBase.GetResourceString("C_Currency") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("ddlCurrency", "usp_Whizible2_Sel_VendorCurrency_Drpdwn",,, "class='form-control selectpicker' data-live-search='true'",,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("ddlCurrency", "ddlCurrency", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='100' oninput='if(this.value.length>100)this.value=this.value.slice(0,100);'",,, True,,,, True) %>--%>
                            </div>
                            <%--<div class="col-sm-3">
                                <label class="d-block">Rate Contract Available</label>
                                <div class="custom_chckbox mt-2">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkRateContractAvailable", "chkRateContractAvailable", "",,,, "") %>
                                    <label for="chkRateContractAvailable">Yes</label>
                                </div>
                            </div>--%>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabDocuments">
                        <div class="d-flex justify-content-end mb-2 vendor-tab-save-row">
                            <button type="button" class="btn btnyellow vendor-tab-save-btn"><%=MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <label for="filePANDocument"><%=MyBase.GetResourceString("C_PANDocumentUpload") %></label>
                                <input type="file" id="filePANDocument" class="form-control form-control-sm" />
                            </div>
                            <div class="col-sm-4">
                                <label for="fileGSTCertificate"><%=MyBase.GetResourceString("C_GSTCertificateUpload") %></label>
                                <input type="file" id="fileGSTCertificate" class="form-control form-control-sm" />
                            </div>
                            <div class="col-sm-4">
                                <label for="fileCancelledCheque"><%=MyBase.GetResourceString("C_CancelledChequeUpload") %></label>
                                <input type="file" id="fileCancelledCheque" class="form-control form-control-sm" />
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label for="fileAgreementContract"><%=MyBase.GetResourceString("C_AgreementContractUpload") %></label>
                                <input type="file" id="fileAgreementContract" class="form-control form-control-sm" />
                            </div>
                            <div class="col-sm-4">
                                <label for="fileOtherSupportDocs"><%=MyBase.GetResourceString("C_OtherSupportingDocuments") %></label>
                                <input type="file" id="fileOtherSupportDocs" class="form-control form-control-sm" />
                            </div>
                            <div class="col-sm-4"></div>
                        </div>

                        <%-- Vendor Document Grid: Edit mode only — hidden in Add mode --%>
                        <div id="vendorDocGrid" style="display:none;">
                            <div class="mt-2">
                                <table class="table" id="tblVendorDocList">
                                    <thead class="stickyTblHeader">
                                        <tr>
                                            <th>Document Type</th>
                                            <th>File Name</th>
                                            <%--<th>Document Type</th>--%>
                                            <th>Uploaded By</th>
                                            <th>Uploaded Date</th>
                                            <th>Download</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblVendorDocListBody">
                                        <tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoRecordsToView") %></td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="d-flex justify-content-end align-items-center gap-2 mt-2">
                                <span id="vendorDocTotalRecords" style="color:#6b7280; font-size:11.5px;"><%=MyBase.GetResourceString("C_TotalRecords") %>: 0</span>
                                <div style="display:flex; gap:0.5rem;">
                                    <button type="button" class="btn borderbtn" id="vendorDocPrevBtn"
                                            onclick="goToPrevVendorDocPage()"
                                            data-bs-toggle="tooltip"
                                            data-bs-title="<%=MyBase.GetResourceString("C_PreviousPage") %>">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button type="button" class="btn borderbtn" id="vendorDocNextBtn"
                                            onclick="goToNextVendorDocPage()"
                                            data-bs-toggle="tooltip"
                                            data-bs-title="<%=MyBase.GetResourceString("C_NextPage") %>">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabShowHistory">
                        <div class="row form-group mb-2 align-items-center">
                            <div class="col-sm-2 text-end">
                                <label for="ddlVendorHistoryModifiedBy" class="mb-0"><%=MyBase.GetResourceString("C_ModifiedBy") %></label>
                            </div>
                            <div class="col-sm-3">
                                <select id="ddlVendorHistoryModifiedBy" class="form-control selectpicker w-100" data-live-search="true" title="<%=MyBase.GetResourceString("C_SelectModifiedBy") %>">
                                    <option value=""><%=MyBase.GetResourceString("C_SelectModifiedBy") %></option>
                                </select>
                            </div>
                            <div class="col-sm-2 text-end">
                                <label for="ddlVendorHistoryModifiedField" class="mb-0"><%=MyBase.GetResourceString("C_ModifiedField") %></label>
                            </div>
                            <div class="col-sm-3">
                                <select id="ddlVendorHistoryModifiedField" class="form-control selectpicker w-100" data-live-search="true" title="<%=MyBase.GetResourceString("C_SelectModifiedField") %>">
                                    <option value=""><%=MyBase.GetResourceString("C_SelectModifiedField") %></option>
                                </select>
                            </div>
                        </div>

                        <div class="table-responsive mt-2">
                            <table class="table table-bordered table-sm" id="tblVendorHistory" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_FieldName") %></th>
                                        <th><%=MyBase.GetResourceString("C_OldValue") %></th>
                                        <th><%=MyBase.GetResourceString("C_NewValue") %></th>
                                        <th><%=MyBase.GetResourceString("C_ModifiedBy") %></th>
                                        <th><%=MyBase.GetResourceString("C_ModifiedDate") %></th>
                                    </tr>
                                </thead>
                                <tbody id="tblVendorHistoryBody">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoRecordsToView") %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="d-flex justify-content-end align-items-center gap-2 mt-2">
                            <span id="historyTotalRecords" style="color: #6b7280; font-size: 11.5px;"><%=MyBase.GetResourceString("C_TotalRecords") %>: 0</span>
                            <div style="display: flex; gap: 0.5rem;">
                                <button type="button" class="btn borderbtn" id="historyPrevBtn" onclick="goToPrevVendorHistoryPage()" data-bs-toggle="tooltip" data-bs-title="<%=MyBase.GetResourceString("C_PreviousPage") %>"><i class="fas fa-angle-double-left"></i></button>
                                <button type="button" class="btn borderbtn" id="historyNextBtn" onclick="goToNextVendorHistoryPage()" data-bs-toggle="tooltip" data-bs-title="<%=MyBase.GetResourceString("C_NextPage") %>"><i class="fas fa-angle-double-right"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end mt-2 pt-2" style="border-top: 1px solid #e5e7eb;">
                    <%--<button type="button" class="btn borderbtn" data-bs-dismiss="offcanvas">Cancel</button>--%>
                    <div>
                        <button type="button" class="btn borderbtn me-2" id="btnPreviousTab"><%=MyBase.GetResourceString("C_Previous") %></button>
                        <button type="button" class="btn btn-primary" id="btnNextTab"><%=MyBase.GetResourceString("C_Next") %> <i class="fas fa-arrow-right ms-1"></i></button>
                    </div>
                </div>
            </div>
        </div>
        <%-- Delete Confirmation Modal --%>
        <div class="modal fade vendor-delete-modal" id="vendorMasterDeleteModal" tabindex="-1" aria-labelledby="vendorMasterDeleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="vendorMasterDeleteModalLabel">Are You Sure You Want to delete?</h5>
                        <button type="button"
                        class="vendor-delete-modal-close-btn"
                        data-bs-dismiss="modal"
                        data-bs-toggle="tooltip"
                        data-bs-placement="top"
                        title="Close"
                        aria-label="Close">
                    &#x2715;
                </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete the selected vendor(s)?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn borderbtn" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btnyellow" id="confirmVendorDeleteBtn" onclick="confirmDeleteVendors()">Yes</button>
                    </div>
                </div>
            </div>
        </div>

        <%Else %>
        <div id="ViewAccess" class="tab-pane" style="height: 448px">
            <div style="text-align: center">
                <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NotAuthorizedToViewPage") %></p>
            </div>
        </div>
        <%End If%>
    </form>

    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var vendorTabs = ["#tabBasicInfo", "#tabContact", "#tabAddress", "#tabTax", "#tabBank", "#tabCommercial", "#tabDocuments"];
        var vendorCurrentPage = 1;
        var vendorPageSize = 5;
        var vendorHistoryCurrentPage = 1;
        var vendorHistoryPageSize = 5;
        var vendorHistoryAllRows = [];
        var vendorHistoryTotalCount = 0;
        var selectedVendorId = 0;
        var isVendorEditMode = false;
        var canVendorMasterEdit   = !!document.getElementById("canEditVendorMasterFlag");
        var canVendorMasterAdd    = !!document.getElementById("btnShowAddVendor");
        var canVendorMasterDelete = !!document.getElementById("canDeleteVendorMasterFlag");

        // Delete state
        var vendorMasterSelectedIds      = [];  // IDs explicitly selected by the user (across all pages)
        var vendorMasterExcludedIds      = [];  // unused — kept for compatibility
        var vendorMasterSelectAllMode    = false;
        var vendorMasterDeleteQueue      = [];
        var vendorMasterDeleteId         = 0;
        // Total number of selectable (non-disabled / not-in-use) vendors across ALL pages.
        // Updated on every bindVendorGrid call so the header checkbox knows when
        // every record on every page has been individually checked.
        var vendorTotalSelectableCount   = 0;

        // Vendor Document Grid (Edit mode, tabDocuments only)
        var vendorDocCurrentPage = 1;
        var vendorDocPageSize    = 5;
        var vendorDocTotalCount  = 0;

        // Added By Dipali V On 14th May 2026 For blocking numeric key entry in City and State fields at keypress/keydown (including numpad)
        function vendorCityStateKeypress(e) {
            e = e || window.event;
            if (e.ctrlKey || e.metaKey || e.altKey) return true;
            var k = (typeof e.which !== "undefined" && e.which !== null) ? e.which : e.keyCode;
            if (!k || k === 8 || k === 9 || k === 13 || k === 27 || k === 46) return true;
            if (k < 32) return true;
            var ch = String.fromCharCode(k);
            if (/[0-9]/.test(ch)) {
                if (e.preventDefault) e.preventDefault();
                return false;
            }
            return true;
        }
        function vendorCityStateKeydownDigits(e) {
            e = e || window.event;
            if (e.ctrlKey || e.metaKey || e.altKey) return true;
            var c = e.keyCode != null ? e.keyCode : e.which;
            if ((c >= 48 && c <= 57) || (c >= 96 && c <= 105)) {
                if (e.preventDefault) e.preventDefault();
                return false;
            }
            return true;
        }

        // Single source of truth for vendor document types: input <-> preview <-> docType (must match server values).
        var vendorDocumentTypeConfigs = [
            { inputId: "filePANDocument", previewId: "docPreviewPANDocument", docType: "PAN Document", aliases: ["pan document", "pan"] },
            { inputId: "fileGSTCertificate", previewId: "docPreviewGSTCertificate", docType: "GST Certificate", aliases: ["gst certificate", "gst"] },
            { inputId: "fileCancelledCheque", previewId: "docPreviewCancelledCheque", docType: "Cancelled Cheque", aliases: ["cancelled cheque", "cancel cheque", "cancel", "cheque"] },
            { inputId: "fileAgreementContract", previewId: "docPreviewAgreementContract", docType: "Agreement/Contract", aliases: ["agreement/contract", "agreement contract", "agreement", "contract"] },
            { inputId: "fileOtherSupportDocs", previewId: "docPreviewOtherSupportDocs", docType: "Other Supporting Document", aliases: ["other supporting document", "other supporting documents", "other"] }
        ];

        // Map of docType -> existing { vendorDocumentID, fileName, filePath, ... } loaded in Edit mode.
        var vendorExistingDocuments = {};
        var vendorBaselineRequest = null;
        var vendorSuppressDirtyTracking = false;
        var vendorTabDirty = {};
        // Tracks which tabs have been successfully saved (used for sequential tab unlock in Add mode)
        var vendorTabSaved = {};

        function resetVendorTabSavedFlags() {
            for (var di = 0; di < vendorTabs.length; di++) {
                vendorTabSaved[vendorTabs[di]] = false;
            }
        }

        // Returns true if tabId is reachable based on save-based sequential logic
        function isVendorTabSavedReachable(href) {
            if (!isVendorWizardStrictMode()) return true;
            var visible = getVisibleVendorTabs();
            var idx = visible.indexOf(href);
            if (idx <= 0) return true; // First tab always reachable
            // Tab is reachable only if ALL previous tabs have been saved
            for (var i = 0; i < idx; i++) {
                var prevTab = visible[i];
                // History and optional tabs (no save btn) are always considered "passed"
                if (prevTab === "#tabShowHistory") continue;
                if (!vendorTabSaved[prevTab]) return false;
            }
            return true;
        }

        function resetVendorTabDirtyFlags() {
            for (var di = 0; di < vendorTabs.length; di++) {
                vendorTabDirty[vendorTabs[di]] = false;
            }
        }

        function markVendorTabDirtyFromElement(el) {
            if (vendorSuppressDirtyTracking) return;
            var $pane = $(el).closest(".tab-pane");
            if (!$pane.length) return;
            var pid = $pane.attr("id");
            if (pid) vendorTabDirty["#" + pid] = true;
        }

        function setVendorTab(tabId, force) {
            if (!tabId) return false;
            var current = $("#vendorTabHeader li.active a").attr("href");
            if (tabId === current) return true;
            // Removed: "Modified details are not saved. Do you want to continue?" confirm dialog
            if (!force && !isVendorTabSavedReachable(tabId)) {
                alertify.set("notifier", "position", "top-right");
                alertify.warning("Please save the current tab before proceeding to the next tab.");
                return false;
            }
            $("#vendorTabHeader li").removeClass("active");
            $('#vendorTabHeader a[href="' + tabId + '"]').parent().addClass("active");
            $(".tab-content .tab-pane").removeClass("active");
            $(tabId).addClass("active");
            refreshVendorTabWizardLocks();
            return true;
        }

        function getVisibleVendorTabs() {
            var visible = [];
            for (var i = 0; i < vendorTabs.length; i++) {
                var $li = $('#vendorTabHeader a[href="' + vendorTabs[i] + '"]').parent();
                if ($li.length > 0 && $li.is(":visible")) {
                    visible.push(vendorTabs[i]);
                }
            }
            return visible;
        }

        function isVendorWizardStrictMode() {
            // Strict sequential tab locking applies in BOTH Add and Edit mode.
            // In Edit mode, tabs are selectively unlocked based on existing API data.
            return true;
        }

        function applyVendorMasterSaveButtonVisibility() {
            var show = false;
            if (isVendorEditMode) {
                show = !!canVendorMasterEdit;
            } else {
                show = !!canVendorMasterAdd;
            }
            $(".vendor-tab-save-btn").css("display", show ? "" : "none");
        }

        function applyVendorFormFieldsReadOnly(readOnly) {
            var $panel = $("#vendorDetailsOffcanvas .vendor-form-panel");
            if (!$panel.length) return;
            $panel.find("input,select,textarea").not('[type="hidden"]').prop("disabled", !!readOnly);
            try {
                $panel.find(".selectpicker").selectpicker("refresh");
            } catch (ex) { }
            if (!readOnly) {
                toggleMSMENumber();
            }
        }

        function isVendorTabHrefReachable(href) {
            if (!isVendorWizardStrictMode()) return true;
            var visible = getVisibleVendorTabs();
            var idx = visible.indexOf(href);
            if (idx <= 0) return true;
            for (var i = 0; i < idx; i++) {
                if (!validateVendorSingleTab(visible[i], false)) return false;
            }
            return true;
        }

        function refreshVendorTabWizardLockedClasses() {
            var $header = $("#vendorTabHeader");
            if (!$header.length) return;
            // Always apply save-based locking (both Add and Edit mode)
            var visible = getVisibleVendorTabs();
            for (var i = 0; i < visible.length; i++) {
                var href = visible[i];
                var reachable = isVendorTabSavedReachable(href);
                $header.find('a[href="' + href + '"]').parent().toggleClass("vendor-tab-locked", !reachable);
            }
        }

        function refreshVendorTabWizardLocks() {
            refreshVendorTabWizardLockedClasses();
            setVendorNavState();
        }

        function setVendorNavState() {
            var current = $("#vendorTabHeader li.active a").attr("href");
            var visibleTabs = getVisibleVendorTabs();
            var idx = visibleTabs.indexOf(current);
            $("#btnPreviousTab").prop("disabled", idx <= 0);
            var atLast = idx === -1 || idx >= visibleTabs.length - 1;
            var nextDisabled = atLast;
            // Next is disabled until the current tab has been saved (both Add and Edit mode)
            if (!nextDisabled) {
                nextDisabled = !vendorTabSaved[current];
            }
            $("#btnNextTab").prop("disabled", nextDisabled);
        }

        function toggleMSMENumber() {
            var isChecked = $("#chkMSMERegistered").is(":checked");
            $("#txtMSMENumber").prop("disabled", !isChecked);

            //if (!isChecked) {
            //    $("#txtMSMENumber").val("");
            //}
        }

        function getVendorTypeName(vendorTypeID) {
            var typeMap = {
                1: "IT Vendor",
                2: "Consulting Partner",
                3: "Contractor",
                4: "Staffing Agency",
                5: "System Integrator",
                6: "Other Vendor"
            };
            return typeMap[parseInt(vendorTypeID) || 0] || "";
        }

        function updateVendorPaginationButtons(totalCount) {
            var totalPages = Math.ceil(totalCount / vendorPageSize);
            var prev = document.getElementById('vendorPrevBtn');
            var next = document.getElementById('vendorNextBtn');
            if (!prev || !next) return;

            var disablePrev = vendorCurrentPage <= 1 || totalCount === 0;
            prev.disabled = disablePrev;
            prev.style.opacity = disablePrev ? '0.5' : '1';
            prev.style.cursor = disablePrev ? 'no-drop' : 'pointer';

            var disableNext = vendorCurrentPage >= totalPages || totalCount === 0;
            next.disabled = disableNext;
            next.style.opacity = disableNext ? '0.5' : '1';
            next.style.cursor = disableNext ? 'no-drop' : 'pointer';
        }

        function escapeVendorGridText(value) {
            return String(value || "")
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#39;");
        }

        function formatVendorGridTextCell(value, maxLength) {
            var text = String(value || "");
            var escapedFull = escapeVendorGridText(text);
            if (text.length > maxLength) {
                var shortText = escapeVendorGridText(text.substring(0, maxLength) + "...");
                return '<td title="' + escapedFull + '" data-bs-toggle="tooltip" data-bs-placement="top">' + shortText + '</td>';
            }
            return '<td>' + escapedFull + '</td>';
        }

        //Added by vikas T at the time of comparison with W26
       // Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody     

       <%-- function bindVendorGrid(pageNumber, pageSize) {
            debugger
            pageNumber = pageNumber || 1;
            pageSize = pageSize || vendorPageSize;
            vendorPageSize = pageSize;

            var vendorCode = $.trim($("#txtVendorCodeFilter").val() || "");
            var vendorName = $.trim($("#txtVendorNameFilter").val() || "");

            var vendorTypeVal = $("#ddlVendorTypeFilter").val();
            var vendorTypeId = (vendorTypeVal && parseInt(vendorTypeVal) > 0)
                ? parseInt(vendorTypeVal)
                : null;

            var isActiveVal = $.trim($("#ddlStatusFilter").val() || "");
            var isActive = isActiveVal !== "" ? parseInt(isActiveVal) : null;

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: null,
                PageNumber: pageNumber,
                PageSize: pageSize,
                VendorCode: vendorCode,
                VendorName: vendorName,
                VendorTypeId: vendorTypeId,
                IsActive: isActive
            });

            var result = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorMaster",
                payload,
                false
            );
        

        
            var tbody = $("#tblVendorListBody");
            tbody.empty();

            var vendorList = [];
            if (result && result.data && result.data.data) {
                vendorList = result.data.data.vendorMaster || result.data.data.VendorMaster || result.data.data.RM_VendorMaster || [];
            } else if (result && result.data) {
                vendorList = result.data.vendorMaster || result.data.VendorMaster || result.data.RM_VendorMaster || [];
            }

            if (vendorList && vendorList.length > 0) {
                for (var i = 0; i < vendorList.length; i++) {
                    var item = vendorList[i];
                    var vid = parseInt(item.vendorID || 0, 10);
                    var isInUse = (item.vendorInUse === true || item.vendorInUse === 1 ||
                                   item.VendorInUse === true || item.VendorInUse === 1 ||
                                   String(item.vendorInUse).toLowerCase() === 'true' ||
                                   String(item.VendorInUse).toLowerCase() === 'true');

                    // Determine checkbox state:
                    // vendorMasterSelectedIds is always the single source of truth —
                    // both for individually-ticked rows and for the select-all case
                    // (where the header handler populates it with all IDs up-front).
                    var isChecked = (!isInUse && vid > 0 && vendorMasterSelectedIds.indexOf(vid) > -1);
                    var isActiveText = (
                        item.isActive === true ||
                        item.isActive === 1 ||
                        item.IsActive === true ||
                        item.IsActive === 1 ||
                        String(item.isActive).toLowerCase() === "true" ||
                        String(item.IsActive).toLowerCase() === "true"
                    ) ? "Yes" : "No";

                    var chkCell = '';
                    if (isInUse) {
                        chkCell = '<td class="text-center"><span data-bs-toggle="tooltip" data-bs-placement="top" title="Vendor is in use, cannot be deleted"><input type="checkbox" class="vendor-del-check" disabled /></span></td>';
                    } else if (canVendorMasterDelete) {
                        chkCell = '<td class="text-center"><input type="checkbox" class="vendor-del-check vendor-master-row-check" data-id="' + vid + '"'
                                  + (isChecked ? ' checked' : '')
                            + ' onchange="onVendorMasterRowCheckChanged(this,' + vid + ')" ' +
                            ' data-bs-toggle="tooltip" title="Delete" /></td>';
                    } else {
                        chkCell = '<td></td>';
                    }

                    var row = '<tr>' +
                        '<td>' + escapeVendorGridText(item.vendorCode || "") + '</td>' +
                        formatVendorGridTextCell(item.vendorName || "", 35) +
                        '<td>' + escapeVendorGridText(item.vendorTypeName || getVendorTypeName(item.vendorTypeID)) + '</td>' +
                        '<td>' + escapeVendorGridText(item.contactPerson || "") + '</td>' +
                        '<td>' + isActiveText + '</td>' +
                        '<td><a href="javascript:;" class="txt_hover" onclick="editVendor(' + vid + ');"><i class="fas fa-ellipsis-v vendor-action-dot" data-bs-toggle="tooltip" data-bs-title="View Details"></i></a></td>' +
                        chkCell +
                        '</tr>';
                    tbody.append(row);
                }

                vendorCurrentPage = pageNumber;
                var totalCount = vendorList[0].totalCount || vendorList.length;
                $("#totalRecords").text('<%=MyBase.GetResourceString("C_TotalRecords") %>: ' + totalCount);
                updateVendorPaginationButtons(totalCount);

                // ── Compute the exact selectable count across ALL pages ──────────
                // vendorTotalSelectableCount must equal the number of non-in-use
                // vendors matching the current filters across ALL pages — not just
                // the current page and not totalCount (which includes in-use rows).
                //
                // We fetch all records once (pageSize=99999) whenever the count is
                // not yet known (0) so that manually ticking every row on every page
                // causes vendorMasterSelectedIds.length to reach this exact number
                // and the header checkbox checks itself automatically.
                //
                // This fetch is cheap: it is only triggered when vendorTotalSelectableCount
                // is 0, i.e. on first load and after Search / Reset / Delete.
                if (vendorTotalSelectableCount === 0) {
                    var _vc   = $.trim($("#txtVendorCodeFilter").val() || "");
                    var _vn   = $.trim($("#txtVendorNameFilter").val() || "");
                    var _vtv  = $("#ddlVendorTypeFilter").val();
                    var _vti  = (_vtv && parseInt(_vtv) > 0) ? parseInt(_vtv) : null;
                    var _ia   = $.trim($("#ddlStatusFilter").val() || "");

                    var _allUrl = "/api/VendorMaster/GetVendorMaster?vendorId=&pageNumber=1&pageSize=99999" +
                        "&vendorCode=" + encodeURIComponent(_vc) +
                        "&vendorName=" + encodeURIComponent(_vn) +
                        "&vendorTypeId=" + (_vti === null ? "" : _vti) +
                        "&isActive=" + _ia;

                    var _allRes = AJAXCallWithResult(_allUrl, null, false);
                    var _allList = [];
                    if (_allRes && _allRes.data && _allRes.data.data) {
                        _allList = _allRes.data.data.vendorMaster || _allRes.data.data.VendorMaster || _allRes.data.data.RM_VendorMaster || [];
                    } else if (_allRes && _allRes.data) {
                        _allList = _allRes.data.vendorMaster || _allRes.data.VendorMaster || _allRes.data.RM_VendorMaster || [];
                    }

                    var _selectable = 0;
                    for (var _si = 0; _si < _allList.length; _si++) {
                        var _sr = _allList[_si];
                        var _sInUse = (_sr.vendorInUse === true || _sr.vendorInUse === 1 ||
                                       _sr.VendorInUse === true || _sr.VendorInUse === 1 ||
                                       String(_sr.vendorInUse).toLowerCase() === "true" ||
                                       String(_sr.VendorInUse).toLowerCase() === "true");
                        if (!_sInUse) _selectable++;
                    }
                    // Store the exact non-in-use count as our denominator.
                    // This means vendorMasterSelectedIds.length === vendorTotalSelectableCount
                    // will be true only when every deletable vendor is checked.
                    vendorTotalSelectableCount = _selectable;
                }

                updateVendorSelectAllHeaderState();
            } else {
                tbody.append('<tr><td colspan="6" class="text-center"><%=MyBase.GetResourceString("C_NoRecordsToView") %></td></tr>');
                vendorCurrentPage = 1;
                $("#totalRecords").text('<%=MyBase.GetResourceString("C_TotalRecords") %>: 0');
                updateVendorPaginationButtons(0);
            }
            initializeTooltips();
        }--%>


        // Added By Vyankat B. on 28th May 2026 for converting FromQuery to FromBody

        function bindVendorGrid(pageNumber, pageSize) {

           // debugger

            pageNumber = pageNumber || 1;
            pageSize = pageSize || vendorPageSize;
            vendorPageSize = pageSize;

            var vendorCode = $.trim($("#txtVendorCodeFilter").val() || "");
            var vendorName = $.trim($("#txtVendorNameFilter").val() || "");

            var vendorTypeVal = $("#ddlVendorTypeFilter").val();
            var vendorTypeId = (vendorTypeVal && parseInt(vendorTypeVal) > 0)
                ? parseInt(vendorTypeVal)
                : null;

            var isActiveVal = $.trim($("#ddlStatusFilter").val() || "");
            var isActive = isActiveVal !== "" ? parseInt(isActiveVal) : null;

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: null,
                PageNumber: pageNumber,
                PageSize: pageSize,
                VendorCode: vendorCode,
                VendorName: vendorName,
                VendorTypeId: vendorTypeId,
                IsActive: isActive
            });

            var result = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorMaster",
                payload,
                false
            );

            var tbody = $("#tblVendorListBody");
            tbody.empty();

            var vendorList = [];

            if (result && result.data && result.data.data) {
                vendorList = result.data.data.vendorMaster ||
                    result.data.data.VendorMaster ||
                    result.data.data.RM_VendorMaster || [];
            }
            else if (result && result.data) {
                vendorList = result.data.vendorMaster ||
                    result.data.VendorMaster ||
                    result.data.RM_VendorMaster || [];
            }

            if (vendorList && vendorList.length > 0) {

                for (var i = 0; i < vendorList.length; i++) {

                    var item = vendorList[i];

                    var vid = parseInt(item.vendorID || 0, 10);

                    var isInUse =
                        (item.vendorInUse === true ||
                            item.vendorInUse === 1 ||
                            item.VendorInUse === true ||
                            item.VendorInUse === 1 ||
                            String(item.vendorInUse).toLowerCase() === 'true' ||
                            String(item.VendorInUse).toLowerCase() === 'true');

                    // Determine checkbox state:
                    // vendorMasterSelectedIds is always the single source of truth —
                    // both for individually-ticked rows and for the select-all case
                    // (where the header handler populates it with all IDs up-front).

                    var isChecked =
                        (!isInUse &&
                            vid > 0 &&
                            vendorMasterSelectedIds.indexOf(vid) > -1);

                    var isActiveText =
                        (
                            item.isActive === true ||
                            item.isActive === 1 ||
                            item.IsActive === true ||
                            item.IsActive === 1 ||
                            String(item.isActive).toLowerCase() === "true" ||
                            String(item.IsActive).toLowerCase() === "true"
                        )
                            ? "Yes"
                            : "No";

                    var chkCell = '';

                    if (isInUse) {

                        chkCell =
                            '<td class="text-center">' +
                            '<span data-bs-toggle="tooltip" data-bs-placement="top" title="Vendor is in use, cannot be deleted">' +
                            '<input type="checkbox" class="vendor-del-check" disabled />' +
                            '</span>' +
                            '</td>';

                    }
                    else if (canVendorMasterDelete) {

                        chkCell =
                            '<td class="text-center">' +
                            '<input type="checkbox" class="vendor-del-check vendor-master-row-check" ' +
                            'data-id="' + vid + '"' +
                            (isChecked ? ' checked' : '') +
                            ' onchange="onVendorMasterRowCheckChanged(this,' + vid + ')" ' +
                            ' data-bs-toggle="tooltip" title="Delete" />' +
                            '</td>';

                    }
                    else {

                        chkCell = '<td></td>';
                    }

                    var row =
                        '<tr>' +
                        '<td>' + escapeVendorGridText(item.vendorCode || "") + '</td>' +
                        formatVendorGridTextCell(item.vendorName || "", 35) +
                        '<td>' + escapeVendorGridText(item.vendorTypeName || getVendorTypeName(item.vendorTypeID)) + '</td>' +
                        '<td>' + escapeVendorGridText(item.contactPerson || "") + '</td>' +
                        '<td>' + isActiveText + '</td>' +
                        '<td>' +
                        '<a href="javascript:;" class="txt_hover" onclick="editVendor(' + vid + ');">' +
                        '<i class="fas fa-ellipsis-v vendor-action-dot" data-bs-toggle="tooltip" data-bs-title="View Details"></i>' +
                        '</a>' +
                        '</td>' +
                        chkCell +
                        '</tr>';

                    tbody.append(row);
                }

                vendorCurrentPage = pageNumber;

                var totalCount = vendorList[0].totalCount || vendorList.length;

                $("#totalRecords").text(
            '<%=MyBase.GetResourceString("C_TotalRecords") %>: ' + totalCount
        );

        updateVendorPaginationButtons(totalCount);

        // ── Compute the exact selectable count across ALL pages ──────────

        if (vendorTotalSelectableCount === 0) {

            var _vc = $.trim($("#txtVendorCodeFilter").val() || "");
            var _vn = $.trim($("#txtVendorNameFilter").val() || "");

            var _vtv = $("#ddlVendorTypeFilter").val();

            var _vti = (_vtv && parseInt(_vtv) > 0)
                ? parseInt(_vtv)
                : null;

            var _iaVal = $.trim($("#ddlStatusFilter").val() || "");

            var _ia = _iaVal !== ""
                ? parseInt(_iaVal)
                : null;

            // FromBody Payload

            var _allPayload = JSON.stringify({
                VendorId: null,
                PageNumber: 1,
                PageSize: 99999,
                VendorCode: _vc,
                VendorName: _vn,
                VendorTypeId: _vti,
                IsActive: _ia
            });

            var _allRes = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorMaster",
                _allPayload,
                false
            );

            var _allList = [];

            if (_allRes && _allRes.data && _allRes.data.data) {

                _allList =
                    _allRes.data.data.vendorMaster ||
                    _allRes.data.data.VendorMaster ||
                    _allRes.data.data.RM_VendorMaster || [];

            }
            else if (_allRes && _allRes.data) {

                _allList =
                    _allRes.data.vendorMaster ||
                    _allRes.data.VendorMaster ||
                    _allRes.data.RM_VendorMaster || [];
            }

            var _selectable = 0;

            for (var _si = 0; _si < _allList.length; _si++) {

                var _sr = _allList[_si];

                var _sInUse =
                    (_sr.vendorInUse === true ||
                        _sr.vendorInUse === 1 ||
                        _sr.VendorInUse === true ||
                        _sr.VendorInUse === 1 ||
                        String(_sr.vendorInUse).toLowerCase() === "true" ||
                        String(_sr.VendorInUse).toLowerCase() === "true");

                if (!_sInUse) {
                    _selectable++;
                }
            }

            // Store the exact non-in-use count as our denominator

            vendorTotalSelectableCount = _selectable;
        }

        updateVendorSelectAllHeaderState();

    }
    else {

        tbody.append(
            '<tr>' +
            '<td colspan="6" class="text-center">' +
            '<%=MyBase.GetResourceString("C_NoRecordsToView") %>' +
            '</td>' +
            '</tr>'
        );

        vendorCurrentPage = 1;

        $("#totalRecords").text(
            '<%=MyBase.GetResourceString("C_TotalRecords") %>: 0'
        );

                updateVendorPaginationButtons(0);
            }

            initializeTooltips();
        }

// End of Added By Vyankat B. on 28th May 2026 for converting FromQuery to FromBody

        // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody
//Ended by vikas T at the time of comparison with W26

        function goToPrevVendorPage() {
            if (vendorCurrentPage > 1) {
                vendorCurrentPage--;
                bindVendorGrid(vendorCurrentPage, vendorPageSize);
            }
        }

        function goToNextVendorPage() {

            bindVendorGrid(vendorCurrentPage + 1, vendorPageSize);
        }

        function updateVendorHistoryPaginationButtons(totalCount) {
            var totalPages = Math.ceil(totalCount / vendorHistoryPageSize);
            var prev = document.getElementById('historyPrevBtn');
            var next = document.getElementById('historyNextBtn');
            if (!prev || !next) return;

            var disablePrev = vendorHistoryCurrentPage <= 1 || totalCount === 0;
            prev.disabled = disablePrev;
            prev.style.opacity = disablePrev ? '0.5' : '1';
            prev.style.cursor = disablePrev ? 'no-drop' : 'pointer';

            var disableNext = vendorHistoryCurrentPage >= totalPages || totalCount === 0;
            next.disabled = disableNext;
            next.style.opacity = disableNext ? '0.5' : '1';
            next.style.cursor = disableNext ? 'no-drop' : 'pointer';
        }

        function renderVendorHistoryPage(pageNumber) {
            var totalCount = vendorHistoryTotalCount || (Array.isArray(vendorHistoryAllRows) ? vendorHistoryAllRows.length : 0);
            var totalPages = Math.ceil(totalCount / vendorHistoryPageSize);

            if (totalPages === 0) {
                vendorHistoryCurrentPage = 1;
            } else if (pageNumber < 1) {
                vendorHistoryCurrentPage = 1;
            } else if (pageNumber > totalPages) {
                vendorHistoryCurrentPage = totalPages;
            } else {
                vendorHistoryCurrentPage = pageNumber;
            }

            vendorRenderHistoryGrid(vendorHistoryAllRows);
            $("#historyTotalRecords").text('<%=MyBase.GetResourceString("C_TotalRecords") %>: ' + totalCount);
            updateVendorHistoryPaginationButtons(totalCount);
        }

        function goToPrevVendorHistoryPage() {
            if (vendorHistoryCurrentPage > 1) {
                bindVendorHistoryGrid(vendorHistoryCurrentPage - 1, vendorHistoryPageSize);
            }
        }

        function goToNextVendorHistoryPage() {
            bindVendorHistoryGrid(vendorHistoryCurrentPage + 1, vendorHistoryPageSize);
        }
        //Added by vikas T at the time of comparison with W26
        // Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


     

        function bindVendorHistoryGrid(pageNumber, pageSize) {

            //debugger

            pageNumber = pageNumber || 1;
            pageSize = pageSize || vendorHistoryPageSize;

            vendorHistoryPageSize = pageSize;

            var selectedBy = $.trim($("#ddlVendorHistoryModifiedBy").val() || "");
            var selectedField = $.trim($("#ddlVendorHistoryModifiedField").val() || "");

            // Use selectedVendorId directly — it is valid after both Edit open and Save/Update.

            var vendorId = (selectedVendorId > 0)
                ? selectedVendorId
                : null;

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: vendorId,
                PageNumber: pageNumber,
                PageSize: pageSize,
                ModifiedField: selectedField,
                ModifiedBy: selectedBy
            });

            var $tbody = $("#tblVendorHistoryBody");

            $tbody.empty().append(
                '<tr>' +
                '<td colspan="5" class="text-center text-muted">' +
        '<%=MyBase.GetResourceString("C_LoadingHistory") %>' +
        '</td>' +
        '</tr>'
    );

            var response = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorHistory",
                payload,
                false
            );
//Ended by vikas T at the time of comparison with W26
            var rows = [];

            if (response && response.data && response.data.data) {
                rows = response.data.data;
            } else if (response && response.data && Array.isArray(response.data)) {
                rows = response.data;
            } else if (response && Array.isArray(response)) {
                rows = response;
            }

            if (!Array.isArray(rows)) {
                rows = [];
            }

            vendorHistoryAllRows = rows;
            var parsedTotalCount = 0;
            if (rows.length > 0) {
                parsedTotalCount = parseInt(vendorHistoryGetValue(rows[0], ["totalCount", "TotalCount"]), 10);
                if (isNaN(parsedTotalCount) || parsedTotalCount < 0) {
                    parsedTotalCount = rows.length;
                }
            }
            vendorHistoryTotalCount = parsedTotalCount;
            renderVendorHistoryPage(pageNumber);
        }

        // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


        function clearVendorForm() {
            vendorSuppressDirtyTracking = true;
            resetVendorTabDirtyFlags();
            resetVendorTabSavedFlags();
            selectedVendorId = 0;
            isVendorEditMode = false;
            $("#btnPreviousTab").html('<%=MyBase.GetResourceString("C_Previous") %>');
            $("#txtVendorCode,#txtVendorName,#txtContactPerson,#txtVendorDescription,#txtPrimaryContactName,#txtEmailID,#txtMobileNumber,#txtAlternateContactNumber,#txtWebsite,#txtAddressLine1,#txtAddressLine2,#txtCity,#txtState,#txtPincode,#txtPANNumber,#txtGSTIN,#txtTANNumber,#txtCIN,#txtMSMENumber,#txtBankName,#txtAccountHolderName,#txtAccountNumber,#txtIFSCCode,#txtBranchName,#txtUPIID,#txtPaymentTerms,#txtCreditLimit").val("");
            $("#ddlVendorType,#ddlCurrency,#txtDesignation,#txtCountry").val("0").selectpicker("refresh");
            $("#chkVendorActive").prop("checked", true);
            resetVendorActiveInUseTooltipUI();
            $("#chkMSMERegistered,#chkRateContractAvailable").prop("checked", false);
            $("#filePANDocument,#fileGSTCertificate,#fileCancelledCheque,#fileAgreementContract,#fileOtherSupportDocs").val("");
            $("#docPreviewPANDocument,#docPreviewGSTCertificate,#docPreviewCancelledCheque,#docPreviewAgreementContract,#docPreviewOtherSupportDocs").empty();
            vendorExistingDocuments = {};
            vendorBaselineRequest = null;
            $("#ddlVendorHistoryModifiedBy,#ddlVendorHistoryModifiedField").val("");
            $("#tblVendorHistoryBody").html('<tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoRecordsToView") %></td></tr>');
            vendorHistoryAllRows = [];
            vendorHistoryTotalCount = 0;
            vendorHistoryCurrentPage = 1;
            $("#historyTotalRecords").text('<%=MyBase.GetResourceString("C_TotalRecords") %>: 0');
            updateVendorHistoryPaginationButtons(0);
            vendorRefreshSelectpicker("#ddlVendorHistoryModifiedBy");
            vendorRefreshSelectpicker("#ddlVendorHistoryModifiedField");
            toggleMSMENumber();
            // Reset document grid (only shown in Edit mode)
            clearVendorDocGrid();
            vendorSuppressDirtyTracking = false;
        }

        function ensureDocumentPreviewContainers() {
            var previewMap = [
                { inputId: "filePANDocument", previewId: "docPreviewPANDocument" },
                { inputId: "fileGSTCertificate", previewId: "docPreviewGSTCertificate" },
                { inputId: "fileCancelledCheque", previewId: "docPreviewCancelledCheque" },
                { inputId: "fileAgreementContract", previewId: "docPreviewAgreementContract" },
                { inputId: "fileOtherSupportDocs", previewId: "docPreviewOtherSupportDocs" }
            ];

            for (var i = 0; i < previewMap.length; i++) {
                var map = previewMap[i];
                if ($("#" + map.previewId).length > 0) continue;
                $("#" + map.inputId).after('<div id="' + map.previewId + '" class="mt-1 small text-muted"></div>');
            }
        }

        function findVendorDocumentConfigByType(documentType) {
            var t = String(documentType || "").trim().toLowerCase();
            if (!t) return null;

            for (var i = 0; i < vendorDocumentTypeConfigs.length; i++) {
                if (vendorDocumentTypeConfigs[i].docType.toLowerCase() === t) {
                    return vendorDocumentTypeConfigs[i];
                }
            }

            for (var j = 0; j < vendorDocumentTypeConfigs.length; j++) {
                var aliases = vendorDocumentTypeConfigs[j].aliases || [];
                for (var k = 0; k < aliases.length; k++) {
                    if (t === aliases[k] || t.indexOf(aliases[k]) >= 0) {
                        return vendorDocumentTypeConfigs[j];
                    }
                }
            }

            // Fallback to "Other Supporting Document"
            return vendorDocumentTypeConfigs[vendorDocumentTypeConfigs.length - 1];
        }

        function bindVendorDocuments(documents) {
            //ensureDocumentPreviewContainers();
            $("#docPreviewPANDocument,#docPreviewGSTCertificate,#docPreviewCancelledCheque,#docPreviewAgreementContract,#docPreviewOtherSupportDocs").empty();
            vendorExistingDocuments = {};

            if (!documents || !documents.length) return;

            function toDocumentUrl(path) {
                if (!path) return "";
                if (/^https?:\/\//i.test(path)) return path;
                return encodeURI(strUrl.replace(/\/+$/, "") + "/" + String(path).replace(/^\/+/, ""));
            }

            // Group documents by their resolved (canonical) docType, retaining only the latest
            // record per type (highest VendorDocumentID = most recently inserted) so the same
            // file is never rendered multiple times in the same section.
            var docsByCanonicalType = {};

            for (var i = 0; i < documents.length; i++) {
                var doc = documents[i] || {};
                var rawType = doc.documentType || doc.DocumentType || "";
                var config = findVendorDocumentConfigByType(rawType);
                if (!config) continue;

                var docId = parseInt(doc.vendorDocumentID || doc.VendorDocumentID || 0, 10);
                if (isNaN(docId)) docId = 0;

                var existing = docsByCanonicalType[config.docType];
                if (existing && (existing.vendorDocumentID || 0) >= docId) continue;

                docsByCanonicalType[config.docType] = {
                    vendorDocumentID: docId || null,
                    documentType: config.docType,
                    fileName: doc.fileName || doc.FileName || "",
                    filePath: doc.filePath || doc.FilePath || "",
                    fileExtension: doc.fileExtension || doc.FileExtension || "",
                    fileSize: doc.fileSize || doc.FileSize || 0,
                    remarks: doc.remarks || doc.Remarks || ""
                };
            }

            for (var canonicalType in docsByCanonicalType) {
                if (!Object.prototype.hasOwnProperty.call(docsByCanonicalType, canonicalType)) continue;

                var info = docsByCanonicalType[canonicalType];
                vendorExistingDocuments[canonicalType] = info;

                var cfg = findVendorDocumentConfigByType(canonicalType);
                if (!cfg) continue;

                var fileUrl = toDocumentUrl(info.filePath);
                var displayName = info.fileName || '<%=MyBase.GetResourceString("C_Document") %>';
                var idAttr = info.vendorDocumentID ? ' data-vendor-document-id="' + info.vendorDocumentID + '"' : '';

                if (fileUrl) {
                    $("#" + cfg.previewId).append('<div' + idAttr + '><a href="' + fileUrl + '" target="_blank" rel="noopener">' + displayName + '</a></div>');
                } else {
                    $("#" + cfg.previewId).append('<div' + idAttr + '>' + displayName + '</div>');
                }
            }
        }

        function openVendorOffcanvas() {
            var offcanvasEl = document.getElementById("vendorDetailsOffcanvas");
            var offcanvasObj = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            offcanvasObj.show();
        }
        //Added by vikas T at the time of comparison with W26
        // Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


        //function vendorHasHistoryRecords(vendorId) {
        //    if (!vendorId) return false;

        //    var url = "/api/VendorMaster/GetVendorHistory?vendorId=" + encodeURIComponent(vendorId) +
        //        "&pageNumber=1&pageSize=5&modifiedField=&modifiedBy=";

        //    var response = AJAXCallWithResult(url, null, false);

        function vendorHasHistoryRecords(vendorId) {

            if (!vendorId) return false;

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: vendorId,
                PageNumber: 1,
                PageSize: 5,
                ModifiedField: "",
                ModifiedBy: ""
            });

            var response = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorHistory",
                payload,
                false
            );

            // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody

//Ended by vikas T at the time of comparison with W26
            var rows = [];

            if (response && response.data && response.data.data) {
                rows = response.data.data;
            } else if (response && response.data && Array.isArray(response.data)) {
                rows = response.data;
            } else if (response && Array.isArray(response)) {
                rows = response;
            }

            if (!Array.isArray(rows)) return false;

            if (rows.length === 0) return false;

            var totalCount = parseInt(vendorHistoryGetValue(rows[0], ["totalCount", "TotalCount"]), 10);
            if (!isNaN(totalCount) && totalCount > 0) return true;

            return rows.length > 0;
        }
        //Added by vikas T at the time of comparison with W26

        // Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


       <%-- function editVendor(vendorId) {
            if (!vendorId) return;

            clearVendorForm();

            $("#chkVendorActive").prop("disabled", false);
            $("#btnPreviousTab").html('<i class="fas fa-arrow-left me-1"></i> <%=MyBase.GetResourceString("C_Previous") %>');
            selectedVendorId = vendorId;
            isVendorEditMode = true;

            if (vendorHasHistoryRecords(vendorId)) {
                $('#vendorTabHeader a[href="#tabShowHistory"]').parent().show();
                populateVendorHistoryFilters();
            } else {
                $('#vendorTabHeader a[href="#tabShowHistory"]').parent().hide();
            }

            setVendorTab("#tabBasicInfo");

            vendorSuppressDirtyTracking = true;
            var url = "/api/VendorMaster/GetVendorMaster?vendorId=" + vendorId + "&pageNumber=1&pageSize=1";
            var result = AJAXCallWithResult(url, null, false);--%>

        function editVendor(vendorId) {

            if (!vendorId) return;

            clearVendorForm();

            $("#chkVendorActive").prop("disabled", false);

            $("#btnPreviousTab").html(
        '<i class="fas fa-arrow-left me-1"></i> <%=MyBase.GetResourceString("C_Previous") %>'
    );

            selectedVendorId = vendorId;
            isVendorEditMode = true;

            if (vendorHasHistoryRecords(vendorId)) {

                $('#vendorTabHeader a[href="#tabShowHistory"]').parent().show();

                populateVendorHistoryFilters();

            } else {

                $('#vendorTabHeader a[href="#tabShowHistory"]').parent().hide();
            }

            setVendorTab("#tabBasicInfo");

            vendorSuppressDirtyTracking = true;

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: vendorId,
                PageNumber: 1,
                PageSize: 1,
                VendorCode: "",
                VendorName: "",
                VendorTypeId: null,
                IsActive: null
            });

            var result = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorMaster",
                payload,
                false
            );

            // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody

//Ended by vikas T at the time of comparison with W26
            var payload = (result && result.data && result.data.data) ? result.data.data :
                ((result && result.data) ? result.data : {});

            function toArray(value) {
                if (!value) return [];
                return Array.isArray(value) ? value : [value];
            }

            function getFirst(keys) {
                for (var i = 0; i < keys.length; i++) {
                    var key = keys[i];
                    if (payload && Object.prototype.hasOwnProperty.call(payload, key)) {
                        var arr = toArray(payload[key]);
                        if (arr.length > 0) return arr[0];
                    }
                }
                return {};
            }

            function val(obj, keys) {
                if (!obj) return "";
                for (var i = 0; i < keys.length; i++) {
                    var key = keys[i];
                    if (obj[key] !== undefined && obj[key] !== null) return obj[key];
                }
                return "";
            }

            // Edit mode: pass actual VendorID so API returns relevant dropdown
            bindVendorTypeDropdown(vendorId);
            var master = getFirst(["vendorMaster", "VendorMaster", "RM_VendorMaster"]);
            var contact = getFirst(["contactDetails", "ContactDetails", "RM_VendorContactDetails"]);
            var address = getFirst(["addressDetails", "AddressDetails", "RM_VendorAddressDetails"]);
            var tax = getFirst(["taxCompliance", "TaxCompliance", "RM_VendorTaxCompliance"]);
            var bank = getFirst(["bankDetails", "BankDetails", "RM_VendorBankDetails"]);
            var commercial = getFirst(["commercialDetails", "CommercialDetails", "RM_VendorCommercialDetails"]);
            var documents = toArray(payload.documents || payload.Documents || payload.vendorDocuments || payload.VendorDocuments || payload.VendorDocument || []);

            $("#txtVendorCode").val(val(master, ["vendorCode", "VendorCode"]));
            $("#txtVendorName").val(val(master, ["vendorName", "VendorName"]));
            $("#txtContactPerson").val(val(master, ["contactPerson", "ContactPerson"]));
            $("#txtVendorDescription").val(val(master, ["description", "Description"]));
            // NOTE: ddlVendorType value is applied after applyVendorFormFieldsReadOnly below
            var vendorTypeVal = val(master, ["vendorTypeID", "VendorTypeID", "vendorTypeId", "VendorTypeId"]);
            $("#chkVendorActive").prop("checked", val(master, ["isActive", "IsActive"]) === true || val(master, ["isActive", "IsActive"]) === 1 || val(master, ["isActive", "IsActive"]) === "1");

            $("#txtPrimaryContactName").val(val(contact, ["primaryContactPersonName", "PrimaryContactPersonName"]));
            //$("#txtDesignation").val(val(contact, ["designationID", "DesignationID"]));
            // NOTE: txtDesignation value is applied after applyVendorFormFieldsReadOnly below
            var designationVal = val(contact, ["designationID", "DesignationID"]);
            $("#txtEmailID").val(val(contact, ["emailID", "EmailID"]));
            $("#txtMobileNumber").val(val(contact, ["mobileNumber", "MobileNumber"]));
            $("#txtAlternateContactNumber").val(val(contact, ["alternateContactNumber", "AlternateContactNumber"]));
            $("#txtWebsite").val(val(contact, ["website", "Website"]));

            $("#txtAddressLine1").val(val(address, ["addressLine1", "AddressLine1"]));
            $("#txtAddressLine2").val(val(address, ["addressLine2", "AddressLine2"]));
            $("#txtCity").val(val(address, ["city", "City"]));
            $("#txtState").val(val(address, ["state", "State"]));
            //$("#txtCountry").val(val(address, ["countryID", "CountryID"]));
            // NOTE: txtCountry value is applied after applyVendorFormFieldsReadOnly below
            var countryVal = val(address, ["countryID", "CountryID"]);
            $("#txtPincode").val(val(address, ["pinCode", "PinCode", "pincode", "Pincode"]));

            $("#txtPANNumber").val(val(tax, ["PANNumber", "panNumber"]));
            $("#txtGSTIN").val(val(tax, ["GSTIN", "gstin"]));
            $("#txtTANNumber").val(val(tax, ["TANNumber", "tanNumber"]));
            $("#txtCIN").val(val(tax, ["CIN", "cin"]));
            $("#txtMSMENumber").val(val(tax, ["MSMENumber", "msmeNumber"]));

            //var msmeVal = val(tax, ["MSMERegistered", "msmeRegistered", "MSMENumber", "msmeNumber"]);
            //var isMsmeChecked = msmeVal !== "" && msmeVal !== null && msmeVal !== false && msmeVal !== 0 && msmeVal !== "0";
            //$("#chkMSMERegistered").prop("checked", isMsmeChecked);
            //$("#txtMSMENumber").val((typeof msmeVal === "string" || typeof msmeVal === "number") ? msmeVal : "");
            var msmeVal = val(tax, ["MSMERegistered", "msmeRegistered"]);

            var isMsmeChecked =
                msmeVal === true ||
                msmeVal === 1 ||
                msmeVal === "1";

            var isInUse =
                val(master, ["vendorInUse", "VendorInUse"]) === true ||
                val(master, ["vendorInUse", "VendorInUse"]) === 1 ||
                val(master, ["vendorInUse", "VendorInUse"]) === "1";

            $("#chkMSMERegistered").prop("checked", isMsmeChecked);
            $("#txtBankName").val(val(bank, ["bankName", "BankName"]));
            $("#txtAccountHolderName").val(val(bank, ["accountHolderName", "AccountHolderName"]));
            $("#txtAccountNumber").val(val(bank, ["accountNumber", "AccountNumber"]));
            $("#txtIFSCCode").val(val(bank, ["ifscCode", "IFSCCode"]));
            $("#txtBranchName").val(val(bank, ["branchName", "BranchName"]));
            $("#txtUPIID").val(val(bank, ["upiid", "UPIID", "upiId", "UPIId"]));

            $("#txtPaymentTerms").val(val(commercial, ["paymentTerms", "PaymentTerms"]));
            $("#txtCreditLimit").val(val(commercial, ["creditLimit", "CreditLimit"]));
            // NOTE: ddlCurrency value is applied after applyVendorFormFieldsReadOnly below
            var currencyEditVal = val(commercial, ["currencyID", "CurrencyID"]);
            //$("#ddlCurrency").val(val(commercial, ["currencyID", "CurrencyID"]));
            $("#chkRateContractAvailable").prop("checked", val(commercial, ["rateContractAvailable", "RateContractAvailable"]) === true || val(commercial, ["rateContractAvailable", "RateContractAvailable"]) === 1 || val(commercial, ["rateContractAvailable", "RateContractAvailable"]) === "1");
            bindVendorDocuments(documents);

            applyVendorFormFieldsReadOnly(!canVendorMasterEdit && isVendorEditMode);
            applyVendorMasterSaveButtonVisibility();
            resetVendorActiveInUseTooltipUI();

            // ── Apply all selectpicker dropdowns AFTER applyVendorFormFieldsReadOnly ──
            // This ensures Bootstrap Select re-renders with the correct value AFTER the
            // disabled state is finalised, preventing the "Nothing selected" blank display.
            $("#ddlVendorType").val((vendorTypeVal && String(vendorTypeVal) !== "0") ? String(vendorTypeVal) : "0");
            $("#txtDesignation").val((designationVal && String(designationVal) !== "0") ? String(designationVal) : "0");
            $("#txtCountry").val((countryVal && String(countryVal) !== "0") ? String(countryVal) : "0");
            $("#ddlCurrency").val((currencyEditVal && String(currencyEditVal) !== "0") ? String(currencyEditVal) : "0");
            // Single refresh pass for all four dropdowns at once
            try { $("#ddlVendorType,#txtDesignation,#txtCountry,#ddlCurrency").selectpicker("refresh"); } catch (ex) { }
            //if (canVendorMasterEdit && isInUse) {
            //    $("#chkVendorActive").prop("disabled", true);
            //    var $activeWrap = $("#chkVendorActive").closest(".custom_chckbox");
            //    if ($activeWrap.length) {
            //        $activeWrap
            //            .attr("title", "Vendor is in use.")
            //            .attr("data-bs-toggle", "tooltip")
            //            .attr("data-bs-placement", "top")
            //            .css("cursor", "help");
            //    }
            //} else if (canVendorMasterEdit && !isInUse) {
            //    $("#chkVendorActive").prop("disabled", false);
            //}

            vendorBaselineRequest = cloneVendorMasterRequest(buildVendorMasterRequestFromDom());
            vendorSuppressDirtyTracking = false;
            resetVendorTabDirtyFlags();

            // ── Edit-mode tab unlock logic ──────────────────────────────────────
            // Unlock each tab only when the PREVIOUS section already has data
            // in the API response (so an empty Contact section keeps Address locked).
            // Basic Information is always present once a vendor exists, so it is
            // always marked saved.  Every subsequent tab is unlocked only when the
            // section that gates it is non-empty.

            // Helper: does the raw payload array/object for a section have real data?
            function sectionHasData(raw) {
                if (!raw) return false;
                if (Array.isArray(raw)) return raw.length > 0;
                // object – check at least one non-null own value
                var keys = Object.keys(raw);
                for (var ki = 0; ki < keys.length; ki++) {
                    if (raw[keys[ki]] !== null && raw[keys[ki]] !== undefined && raw[keys[ki]] !== "") return true;
                }
                return false;
            }

            // Raw arrays/objects from the payload (before getFirst collapses them)
            function getRawSection(keys) {
                for (var ki = 0; ki < keys.length; ki++) {
                    if (payload && Object.prototype.hasOwnProperty.call(payload, keys[ki])) {
                        return payload[keys[ki]];
                    }
                }
                return null;
            }

            var rawContact    = getRawSection(["contactDetails", "ContactDetails", "RM_VendorContactDetails"]);
            var rawAddress    = getRawSection(["addressDetails", "AddressDetails", "RM_VendorAddressDetails"]);
            var rawTax        = getRawSection(["taxCompliance", "TaxCompliance", "RM_VendorTaxCompliance"]);
            var rawBank       = getRawSection(["bankDetails", "BankDetails", "RM_VendorBankDetails"]);
            var rawCommercial = getRawSection(["commercialDetails", "CommercialDetails", "RM_VendorCommercialDetails"]);
            var rawDocuments  = toArray(payload.documents || payload.Documents || payload.vendorDocuments || payload.VendorDocuments || payload.VendorDocument || []);

            var hasContact    = sectionHasData(rawContact);
            var hasAddress    = sectionHasData(rawAddress);
            var hasTax        = sectionHasData(rawTax);
            var hasBank       = sectionHasData(rawBank);
            var hasCommercial = sectionHasData(rawCommercial);
            var hasDocuments  = rawDocuments.length > 0;

            // BasicInfo is always saved (vendor exists); each subsequent tab unlocks
            // only when its prerequisite section has data.
            vendorTabSaved["#tabBasicInfo"]   = true;
            vendorTabSaved["#tabContact"]     = hasContact;                            // unlocks Address
            vendorTabSaved["#tabAddress"]     = hasContact && hasAddress;              // unlocks Tax
            // Change 1 (edit mode): once Tax has data, Bank/Commercial/Documents are all
            // unlocked together because they have no mandatory fields of their own.
            vendorTabSaved["#tabTax"]         = hasContact && hasAddress && hasTax;   // unlocks Bank+Commercial+Documents
            vendorTabSaved["#tabBank"]        = hasContact && hasAddress && hasTax;   // was: && hasBank
            vendorTabSaved["#tabCommercial"]  = hasContact && hasAddress && hasTax;   // was: && hasBank && hasCommercial
            vendorTabSaved["#tabDocuments"]   = hasContact && hasAddress && hasTax;   // was: && hasBank && hasCommercial
            // Change 2: Show History tab is always accessible in edit mode (history check
            // already done above via vendorHasHistoryRecords before loading the form).
            vendorTabSaved["#tabShowHistory"] = true;
            // ────────────────────────────────────────────────────────────────────

            initializeTooltips();
            toggleMSMENumber();
            refreshVendorTabWizardLocks();
            
            openVendorOffcanvas();
            $('.selectpicker').selectpicker('refresh');

            // Load document grid for Edit mode
            bindVendorDocGrid(1, vendorDocPageSize);
        }

        function validateVendorBasicInfo() {
            var vendorCode = $.trim($("#txtVendorCode").val() || "");
            var vendorName = $.trim($("#txtVendorName").val() || "");
            var vendorType = $.trim($("#ddlVendorType").val() || "");
            var ContactPerson = $.trim($("#txtContactPerson").val() || "");

            alertify.set('notifier', 'position', 'top-right');

            if (!vendorCode) {
                alertify.error('<%=MyBase.GetResourceString("A_VendorCodeRequired") %>');
                $("#txtVendorCode").focus();
                return false;
            }
            if (!vendorName) {
                alertify.error('<%=MyBase.GetResourceString("A_VendorNameRequired") %>');
                $("#txtVendorName").focus();
                return false;
            }
            if (!vendorType || vendorType === "0") {
                alertify.error('<%=MyBase.GetResourceString("A_VendorTypeRequired") %>');
                $("#ddlVendorType").focus();
                return false;
            }

            if (!ContactPerson || ContactPerson === "0") {
                alertify.error('<%=MyBase.GetResourceString("A_ContactPersonRequired") %>');
                $("#txtContactPerson").focus();
                return false;
            }
            return true;
        }

        function sanitizeNumericInput(value, maxLength) {
            var cleaned = String(value || "").replace(/\D/g, "");
            if (maxLength && cleaned.length > maxLength) {
                cleaned = cleaned.slice(0, maxLength);
            }
            return cleaned;
        }

        // Added By Dipali V On 14th May 2026 For allowing decimal values in Credit Limit field (digits and single decimal point only)
        function sanitizeDecimalInput(value, maxLength) {
            var s = String(value || "").replace(/[^\d.]/g, "");
            var parts = s.split(".");
            if (parts.length > 2) {
                s = parts[0] + "." + parts.slice(1).join("");
            }
            if (maxLength && s.length > maxLength) {
                s = s.slice(0, maxLength);
            }
            return s;
        }

        function sanitizeAlphanumericInput(value, maxLength, forceUpper) {
            var cleaned = String(value || "").replace(/[^a-zA-Z0-9]/g, "");
            if (forceUpper) {
                cleaned = cleaned.toUpperCase();
            }
            if (maxLength && cleaned.length > maxLength) {
                cleaned = cleaned.slice(0, maxLength);
            }
            return cleaned;
        }

        function bindVendorInputValidations() {
            // Added By Dipali V On 14th May 2026 For Credit Limit: allowDecimal uses sanitizeDecimalInput; other numeric fields remain digits-only
            var numericRules = [
                //{ selector: "#txtMobileNumber", maxLength: 10 },
                //{ selector: "#txtAlternateContactNumber", maxLength: 15 },
                { selector: "#txtPincode", maxLength: 10 },
                //{ selector: "#txtCreditLimit", maxLength: 15 },
                { selector: "#txtAccountNumber", maxLength: 18 }
            ];

            var alphaNumericRules = [
                { selector: "#txtPANNumber", maxLength: 10 },
                { selector: "#txtGSTIN", maxLength: 15 },
                { selector: "#txtTANNumber", maxLength: 10 },
                { selector: "#txtCIN", maxLength: 21 }
                //{ selector: "#txtMSMENumber", maxLength: 19 }
            ];

            for (var i = 0; i < numericRules.length; i++) {
                (function (rule) {
                    var $input = $(rule.selector);
                    $input.attr("maxlength", rule.maxLength);
                    $input.on("input", function () {
                        if (rule.allowDecimal) {
                            this.value = sanitizeDecimalInput(this.value, rule.maxLength);
                        } else {
                            this.value = sanitizeNumericInput(this.value, rule.maxLength);
                        }
                    });
                })(numericRules[i]);
            }

            for (var j = 0; j < alphaNumericRules.length; j++) {
                (function (rule) {
                    var $input = $(rule.selector);
                    $input.attr("maxlength", rule.maxLength);
                    $input.on("input", function () {
                        this.value = sanitizeAlphanumericInput(this.value, rule.maxLength, false);
                    });
                })(alphaNumericRules[j]);
            }

            $("#txtIFSCCode").attr("maxlength", 11).on("input", function () {
                this.value = sanitizeAlphanumericInput(this.value, 11, true);
            });
        }

        function showVendorValidationError(message, tabId, controlId) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(message);
            if (tabId) setVendorTab(tabId, true);
            if (controlId) $(controlId).focus();
            return false;
        }

        function validateVendorSingleTab(tabId, showErrors) {
            if (tabId === "#tabShowHistory" || tabId === "#tabCommercial" || tabId === "#tabDocuments") {
                return true;
            }
            if (tabId === "#tabBasicInfo") {
                if (!$.trim($("#txtVendorCode").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_VendorCodeRequired") %>', "#tabBasicInfo", "#txtVendorCode");
                    return false;
                }
                if (!$.trim($("#txtVendorName").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_VendorNameRequired") %>', "#tabBasicInfo", "#txtVendorName");
                    return false;
                }
                if (!$.trim($("#ddlVendorType").val() || "") || $("#ddlVendorType").val() === "0") {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_VendorTypeRequired") %>', "#tabBasicInfo", "#ddlVendorType");
                    return false;
                }
                return true;
            }
            if (tabId === "#tabContact") {
                if (!$.trim($("#txtPrimaryContactName").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_PrimaryContactPersonNameRequired") %>', "#tabContact", "#txtPrimaryContactName");
                    return false;
                }
                if (!$.trim($("#txtEmailID").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_EmailIDRequired") %>', "#tabContact", "#txtEmailID");
                    return false;
                }
                if ($.trim($("#txtEmailID").val() || "") &&
                    !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test($.trim($("#txtEmailID").val() || ""))) {
                    if (showErrors) {
                        return showVendorValidationError(
                            'Please Enter Valid Emailid',
                            "#tabContact",
                            "#txtEmailID"
                        );
                    }
                    return false;
                }
                if (!$.trim($("#txtMobileNumber").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_MobileNumberRequired") %>', "#tabContact", "#txtMobileNumber");
                    return false;
                }
                var mobileNumber = $.trim($("#txtMobileNumber").val() || "");
                if (mobileNumber.length < 10 || mobileNumber.length > 15) {
                    if (showErrors) {
                        return showVendorValidationError(
                            '<%=MyBase.GetResourceString("A_MobileNumberLength") %>',
                            "#tabContact",
                            "#txtMobileNumber"
                        );
                    }
                    return false;
                }
                var website = $.trim($("#txtWebsite").val() || "");
                if (website !== "") {
                    var websiteRegex = /^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(\/.*)?$/;
                    if (!websiteRegex.test(website)) {
                        if (showErrors) {
                            return showVendorValidationError(
                                'Please enter valid Website.',
                                "#tabContact",
                                "#txtWebsite"
                            );
                        }
                        return false;
                    }
                }
                return true;
            }
            if (tabId === "#tabAddress") {
                if (!$.trim($("#txtAddressLine1").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_AddressLine1Required") %>', "#tabAddress", "#txtAddressLine1");
                    return false;
                }
                if (!$.trim($("#txtCity").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_CityRequired") %>', "#tabAddress", "#txtCity");
                    return false;
                }
                if (!$.trim($("#txtState").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_StateRequired") %>', "#tabAddress", "#txtState");
                    return false;
                }
                if (!$.trim($("#txtCountry").val() || "") || $("#txtCountry").val() === "0") {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_CountryRequired") %>', "#tabAddress", "#txtCountry");
                    return false;
                }
                if (!$.trim($("#txtPincode").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_PincodeRequired") %>', "#tabAddress", "#txtPincode");
                    return false;
                }
                return true;
            }
            if (tabId === "#tabTax") {
                if (!$.trim($("#txtPANNumber").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_PANNumberRequired") %>', "#tabTax", "#txtPANNumber");
                    return false;
                }
                if ($.trim($("#txtPANNumber").val() || "").length !== 10) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_PANNumberLength") %>', "#tabTax", "#txtPANNumber");
                    return false;
                }
                if ($.trim($("#txtGSTIN").val() || "") && $.trim($("#txtGSTIN").val() || "").length !== 15) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_GSTINLength") %>', "#tabTax", "#txtGSTIN");
                    return false;
                }
                if ($.trim($("#txtTANNumber").val() || "") && $.trim($("#txtTANNumber").val() || "").length !== 10) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_TANNumberLength") %>', "#tabTax", "#txtTANNumber");
                    return false;
                }
                if ($.trim($("#txtCIN").val() || "") && $.trim($("#txtCIN").val() || "").length !== 21) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_CINLength") %>', "#tabTax", "#txtCIN");
                    return false;
                }
                if ($("#chkMSMERegistered").is(":checked") && !$.trim($("#txtMSMENumber").val() || "")) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_MSMENumberRequired") %>', "#tabTax", "#txtMSMENumber");
                    return false;
                }
                if ($("#chkMSMERegistered").is(":checked") && $.trim($("#txtMSMENumber").val() || "").length !== 19) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_MSMENumberLength") %>', "#tabTax", "#txtMSMENumber");
                    return false;
                }
                return true;
            }
            if (tabId === "#tabBank") {
                if ($.trim($("#txtIFSCCode").val() || "") && $.trim($("#txtIFSCCode").val() || "").length !== 11) {
                    if (showErrors) return showVendorValidationError('<%=MyBase.GetResourceString("A_IFSCCodeLength") %>', "#tabBank", "#txtIFSCCode");
                    return false;
                }
                // Change 3: UPI ID validation – show exact alertify.error message and block save
                var upiVal = $.trim($("#txtUPIID").val() || "");
                if (upiVal !== "" && !isUPIIDValueValid(upiVal)) {
                    if (showErrors) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Please enter valid UPIID");
                        $("#txtUPIID").focus();
                        return false;
                    }
                    return false;
                }
                return true;
            }
            return true;
        }

        function validateVendorAllRequiredFields() {
            var order = ["#tabBasicInfo", "#tabContact", "#tabAddress", "#tabTax", "#tabBank", "#tabCommercial", "#tabDocuments"];
            for (var oi = 0; oi < order.length; oi++) {
                if (!validateVendorSingleTab(order[oi], true)) return false;
            }
            return true;
        }

        function getVendorSaveResult(response) {
            if (!response) return "";

            function rowResult(row) {
                if (!row) return "";
                return row.result || row.Result || row.RESULT || "";
            }

            var d = response.data;
            if (d) {
                var rows = d.data;
                if (rows && !Array.isArray(rows) && rows.CommonResultEntity) {
                    rows = rows.CommonResultEntity;
                }
                if (Array.isArray(rows) && rows.length > 0) {
                    var r = rowResult(rows[0]);
                    if (r) return r;
                }
                if (d.CommonResultEntity && d.CommonResultEntity.length > 0) {
                    var r2 = rowResult(d.CommonResultEntity[0]);
                    if (r2) return r2;
                }
                if (d.message && typeof d.message === "string") {
                    var m = d.message;
                    if (/already exists/i.test(m) || /^Error:/i.test(m)) return m;
                    if (m === "Inserted" || m === "Updated") return m;
                }
            }
            if (response.message && response.message.CommonResultEntity && response.message.CommonResultEntity.length > 0) {
                return rowResult(response.message.CommonResultEntity[0]);
            }
            return "";
        }

        function getTrimValue(selector) {
            return $.trim($(selector).val() || "");
        }

        function toNullableString(value) {
            return value ? value : null;
        }

        function toNullableInt(value) {
            var parsed = parseInt(value, 10);
            return isNaN(parsed) || parsed <= 0 ? null : parsed;
        }

        function toNullableDecimal(value) {
            var parsed = parseFloat(value);
            return isNaN(parsed) ? null : parsed;
        }

        function vendorHistoryGetValue(item, keys) {
            if (!item) return "";
            for (var i = 0; i < keys.length; i++) {
                if (item[keys[i]] !== undefined && item[keys[i]] !== null) {
                    return item[keys[i]];
                }
            }
            return "";
        }

        function vendorRefreshSelectpicker(selector) {
            if (!$.fn.selectpicker) return;
            var $ddl = $(selector);
            if (!$ddl.parent().hasClass("bootstrap-select")) {
                $ddl.selectpicker();
            }
            $ddl.selectpicker("refresh");
        }

        //function bindVendorHistoryDropdown(selector, apiUrl, labelKeys, valueKeys, placeholderText) {
        //    debugger
        //    var vendorId = (isVendorEditMode && selectedVendorId > 0) ? selectedVendorId : "";
        //    var selectedVal = $(selector).val() || "";
        //    var response = AJAXCallWithResult(apiUrl + "?VendorID=" + encodeURIComponent(vendorId), null, false);
        //    var rows = [];
        //    var optionsHtml = '<option value="">' + placeholderText + '</option>';

        //    if (response && response.data && response.data.data) {
        //        rows = response.data.data;
        //    } else if (response && response.data && Array.isArray(response.data)) {
        //        rows = response.data;
        //    } else if (response && Array.isArray(response)) {
        //        rows = response;
        //    }

        //    if (!Array.isArray(rows)) rows = [];

        //    for (var i = 0; i < rows.length; i++) {
        //        var row = rows[i] || {};
        //        var label = vendorHistoryGetValue(row, labelKeys);
        //        var value = vendorHistoryGetValue(row, valueKeys);
        //        if (label === "" && value !== "") label = value;
        //        if (value === "" && label !== "") value = label;
        //        if (label === "" && value === "") continue;
        //        optionsHtml += '<option value="' + value + '">' + label + '</option>';
        //    }

        //    $(selector).html(optionsHtml);
        //    $(selector).val(selectedVal);
        //    vendorRefreshSelectpicker(selector);
        //}

      
       <%-- function bindVendorHistoryDropdown(selector, apiUrl, labelKeys, valueKeys, placeholderText) {

            // Use selectedVendorId regardless of mode — after an update in Add mode
            // selectedVendorId is already set by tryApplyNewVendorIdFromSaveResponse.
            var vendorId = (selectedVendorId > 0) ? selectedVendorId : "";
            var selectedVal = $(selector).val() || "";

            var response = AJAXCallWithResult(
                apiUrl + "?VendorID=" + encodeURIComponent(vendorId),
                null,
                false
            );

            var rows = [];
            var optionsHtml = '<option value="">' + placeholderText + '</option>';

            if (response && response.data) {

                // Handle RM_VendorModifiedBy
                if (response.data.RM_VendorModifiedBy) {
                    rows = response.data.RM_VendorModifiedBy;
                }

                // Handle RM_VendorModifiedField
                else if (response.data.RM_VendorModifiedField) {
                    rows = response.data.RM_VendorModifiedField;
                }

                // Generic array handling
                else if (Array.isArray(response.data)) {
                    rows = response.data;
                }
            }
            else if (Array.isArray(response)) {
                rows = response;
            }

            if (!Array.isArray(rows)) {
                rows = [];
            }

            for (var i = 0; i < rows.length; i++) {

                var row = rows[i] || {};

                var label = vendorHistoryGetValue(row, labelKeys);
                var value = vendorHistoryGetValue(row, valueKeys);

                if (label === "" && value !== "") {
                    label = value;
                }

                if (value === "" && label !== "") {
                    value = label;
                }

                if (label === "" && value === "") {
                    continue;
                }

                optionsHtml += '<option value="' + value + '">' + label + '</option>';
            }

            $(selector).html(optionsHtml);
            $(selector).val(selectedVal);

            vendorRefreshSelectpicker(selector);
        }

        function populateVendorHistoryFilters() {
            bindVendorHistoryDropdown(
                "#ddlVendorHistoryModifiedBy",
                "/api/VendorMaster/GetVendorModifiedBy",
                ["modifiedBy", "ModifiedBy", "name", "Name", "text", "Text", "value", "Value"],
                ["modifiedBy", "ModifiedBy", "value", "Value", "name", "Name", "text", "Text"],
                '<%=MyBase.GetResourceString("C_SelectModifiedBy") %>'
            );

            bindVendorHistoryDropdown(
                "#ddlVendorHistoryModifiedField",
                "/api/VendorMaster/GetVendorModifiedField",
                ["modifiedField", "ModifiedField", "fieldName", "FieldName", "tableName", "TableName", "name", "Name", "text", "Text", "value", "Value"],
                ["modifiedField", "ModifiedField", "fieldName", "FieldName", "tableName", "TableName", "value", "Value", "name", "Name", "text", "Text"],
                '<%=MyBase.GetResourceString("C_SelectModifiedField") %>'
            );
        }--%>



        function bindVendorHistoryDropdown(selector, apiUrl, labelKeys, valueKeys, placeholderText) {

            // Use selectedVendorId regardless of mode — after an update in Add mode
            // selectedVendorId is already set by tryApplyNewVendorIdFromSaveResponse.

            var vendorId = (selectedVendorId > 0)
                ? selectedVendorId
                : null;

            var selectedVal = $(selector).val() || "";

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: vendorId
            });

            var response = AJAXCallWithResult(
                apiUrl,
                payload,
                false
            );

            var rows = [];

            var optionsHtml =
                '<option value="">' + placeholderText + '</option>';

            if (response && response.data) {

                // Handle RM_VendorModifiedBy

                if (response.data.RM_VendorModifiedBy) {

                    rows = response.data.RM_VendorModifiedBy;
                }

                // Handle RM_VendorModifiedField

                else if (response.data.RM_VendorModifiedField) {

                    rows = response.data.RM_VendorModifiedField;
                }

                // Generic array handling

                else if (Array.isArray(response.data)) {

                    rows = response.data;
                }
            }
            else if (Array.isArray(response)) {

                rows = response;
            }

            if (!Array.isArray(rows)) {

                rows = [];
            }

            for (var i = 0; i < rows.length; i++) {

                var row = rows[i] || {};

                var label = vendorHistoryGetValue(row, labelKeys);
                var value = vendorHistoryGetValue(row, valueKeys);

                if (label === "" && value !== "") {

                    label = value;
                }

                if (value === "" && label !== "") {

                    value = label;
                }

                if (label === "" && value === "") {

                    continue;
                }

                optionsHtml +=
                    '<option value="' + value + '">' + label + '</option>';
            }

            $(selector).html(optionsHtml);

            $(selector).val(selectedVal);

            vendorRefreshSelectpicker(selector);
        }

        function populateVendorHistoryFilters() {

            bindVendorHistoryDropdown(
                "#ddlVendorHistoryModifiedBy",
                "/api/VendorMaster/GetVendorModifiedBy",
                ["modifiedBy", "ModifiedBy", "name", "Name", "text", "Text", "value", "Value"],
                ["modifiedBy", "ModifiedBy", "value", "Value", "name", "Name", "text", "Text"],
        '<%=MyBase.GetResourceString("C_SelectModifiedBy") %>'
    );

    bindVendorHistoryDropdown(
        "#ddlVendorHistoryModifiedField",
        "/api/VendorMaster/GetVendorModifiedField",
        ["modifiedField", "ModifiedField", "fieldName", "FieldName", "tableName", "TableName", "name", "Name", "text", "Text", "value", "Value"],
        ["modifiedField", "ModifiedField", "fieldName", "FieldName", "tableName", "TableName", "value", "Value", "name", "Name", "text", "Text"],
        '<%=MyBase.GetResourceString("C_SelectModifiedField") %>'
    );
}


        // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


        function vendorRenderHistoryGrid(historyRows) {
            var $tbody = $("#tblVendorHistoryBody");
            $tbody.empty();

            if (!Array.isArray(historyRows) || historyRows.length === 0) {
                $tbody.append('<tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoRecordsToView") %></td></tr>');
                return;
            }

            for (var i = 0; i < historyRows.length; i++) {
                var row = historyRows[i] || {};
                var rowHtml = "<tr>" +
                    "<td>" + (vendorHistoryGetValue(row, ["fieldName", "FieldName", "modifiedField", "ModifiedField"]) || "") + "</td>" +
                    formatVendorGridTextCell(vendorHistoryGetValue(row, ["oldValue", "OldValue"]) || "", 35) +
                    formatVendorGridTextCell(vendorHistoryGetValue(row, ["newValue", "NewValue"]) || "", 35) +
                    "<td>" + (vendorHistoryGetValue(row, ["modifiedBy", "ModifiedBy"]) || "") + "</td>" +
                    "<td>" + (vendorHistoryGetValue(row, ["modifiedDate", "ModifiedDate"]) || "") + "</td>" +
                    "</tr>";
                $tbody.append(rowHtml);
            }

            initializeTooltips();
        }

        function loadVendorHistory() {
            vendorHistoryCurrentPage = 1;
            bindVendorHistoryGrid(vendorHistoryCurrentPage, vendorHistoryPageSize);
        }

        function cloneVendorMasterRequest(req) {
            if (!req) return null;
            return $.extend(true, {}, req);
        }

        function buildVendorMasterRequestFromDom() {
            var vendorTypeId = toNullableInt($("#ddlVendorType").val());
            var currency = toNullableInt($("#ddlCurrency").val());
            currency = (currency && currency !== "0") ? currency : null;

            var contactDetails = [{
                PrimaryContactPersonName: toNullableString(getTrimValue("#txtPrimaryContactName")),
                DesignationID: toNullableInt($("#txtDesignation").val()),
                EmailID: toNullableString(getTrimValue("#txtEmailID")),
                MobileNumber: toNullableString(getTrimValue("#txtMobileNumber")),
                AlternateContactNumber: toNullableString(getTrimValue("#txtAlternateContactNumber")),
                Website: toNullableString(getTrimValue("#txtWebsite")),
                UserName: '<%=Session("strUserName")%>'
            }];

            var addressDetails = [{
                AddressLine1: toNullableString(getTrimValue("#txtAddressLine1")),
                AddressLine2: toNullableString(getTrimValue("#txtAddressLine2")),
                City: toNullableString(getTrimValue("#txtCity")),
                State: toNullableString(getTrimValue("#txtState")),
                CountryID: toNullableInt($("#txtCountry").val()),
                PinCode: toNullableString(getTrimValue("#txtPincode")),
                UserName: '<%=Session("strUserName")%>'
            }];

            var bankDetails = [{
                BankName: toNullableString(getTrimValue("#txtBankName")),
                AccountHolderName: toNullableString(getTrimValue("#txtAccountHolderName")),
                AccountNumber: toNullableString(getTrimValue("#txtAccountNumber")),
                IFSCCode: toNullableString(getTrimValue("#txtIFSCCode")),
                BranchName: toNullableString(getTrimValue("#txtBranchName")),
                UPIID: toNullableString(getTrimValue("#txtUPIID")),
                UserName: '<%=Session("strUserName")%>'
            }];

            var isMsmeRegistered = $("#chkMSMERegistered").is(":checked");
            var taxCompliance = {
                PANNumber: toNullableString(getTrimValue("#txtPANNumber")),
                GSTIN: toNullableString(getTrimValue("#txtGSTIN")),
                TANNumber: toNullableString(getTrimValue("#txtTANNumber")),
                CIN: toNullableString(getTrimValue("#txtCIN")),
                MSMERegistered: isMsmeRegistered,
                MSMENumber: toNullableString(getTrimValue("#txtMSMENumber")),
                UserName: '<%=Session("strUserName")%>'
            };

            var commercialDetails = {
                PaymentTerms: toNullableString(getTrimValue("#txtPaymentTerms")),
                CreditLimit: toNullableString(getTrimValue("#txtCreditLimit")),
                CurrencyID: currency,
                UserName: '<%=Session("strUserName")%>'
            };

            return {
                VendorID: (selectedVendorId > 0) ? selectedVendorId : null,
                VendorCode: getTrimValue("#txtVendorCode"),
                VendorName: getTrimValue("#txtVendorName"),
                VendorTypeID: vendorTypeId,
                ContactPerson: toNullableString(getTrimValue("#txtContactPerson")),
                Description: toNullableString(getTrimValue("#txtVendorDescription")),
                IsActive: $("#chkVendorActive").is(":checked"),
                UserName: '<%=Session("strUserName")%>',
                // Change 5: also pass UserID during update API calls
                UserID: '<%=Session("strUserName")%>',
                SaveTabFlag: 0,
                ContactDetails: contactDetails,
                AddressDetails: addressDetails,
                TaxCompliance: taxCompliance,
                BankDetails: bankDetails,
                CommercialDetails: commercialDetails
            };
        }

        function vendorTabIdToSaveTabFlag(tabId) {
            switch (tabId) {
                case "#tabBasicInfo": return 1;
                case "#tabContact": return 2;
                case "#tabAddress": return 3;
                case "#tabTax": return 4;
                case "#tabBank": return 5;
                case "#tabCommercial": return 6;
                case "#tabDocuments": return 7;
                default: return 0;
            }
        }

        function mergeVendorRequestForTabSave(tabId, baseline, domRequest) {
            if (!baseline) {
                return cloneVendorMasterRequest(domRequest);
            }
            var merged = cloneVendorMasterRequest(baseline);
            if (!merged) {
                merged = cloneVendorMasterRequest(domRequest);
            }

            merged.UserName = domRequest.UserName;
            // Always use the most up-to-date VendorID (set by tryApplyNewVendorIdFromSaveResponse
            // after Tab 1 insert in Add mode) so tabs 2-7 never send a null VendorID.
            if (domRequest.VendorID != null && parseInt(domRequest.VendorID, 10) > 0) {
                merged.VendorID = domRequest.VendorID;
            } else if (selectedVendorId > 0) {
                merged.VendorID = selectedVendorId;
            }

            if (tabId === "#tabBasicInfo") {
                merged.VendorCode = domRequest.VendorCode;
                merged.VendorName = domRequest.VendorName;
                merged.VendorTypeID = domRequest.VendorTypeID;
                merged.ContactPerson = domRequest.ContactPerson;
                merged.Description = domRequest.Description;
                merged.IsActive = domRequest.IsActive;
            } else if (tabId === "#tabContact") {
                merged.ContactDetails = $.extend(true, [], domRequest.ContactDetails || []);
            } else if (tabId === "#tabAddress") {
                merged.AddressDetails = $.extend(true, [], domRequest.AddressDetails || []);
            } else if (tabId === "#tabTax") {
                merged.TaxCompliance = $.extend(true, {}, domRequest.TaxCompliance || {});
            } else if (tabId === "#tabBank") {
                merged.BankDetails = $.extend(true, [], domRequest.BankDetails || []);
            } else if (tabId === "#tabCommercial") {
                merged.CommercialDetails = $.extend(true, {}, domRequest.CommercialDetails || {});
            }

            return merged;
        }

        function tryApplyNewVendorIdFromSaveResponse(response) {
            if (!response || !response.data) return;
            var d = response.data;
            var raw = null;
            if (d.vendorID != null && d.vendorID !== "") raw = d.vendorID;
            else if (d.VendorID != null && d.VendorID !== "") raw = d.VendorID;

            var rows = d.data;
            if (rows && !Array.isArray(rows) && rows.CommonResultEntity) {
                rows = rows.CommonResultEntity;
            }
            if ((raw === null || raw === undefined || raw === "") && Array.isArray(rows) && rows.length > 0) {
                var row0 = rows[0];
                raw = row0.vendorID != null && row0.vendorID !== "" ? row0.vendorID : row0.VendorID;
            }
            if ((raw === null || raw === undefined || raw === "") && d.data && !Array.isArray(d.data)) {
                raw = d.data.vendorID != null && d.data.vendorID !== "" ? d.data.vendorID : d.data.VendorID;
            }
            if ((raw === null || raw === undefined || raw === "") && d.CommonResultEntity && d.CommonResultEntity.length > 0) {
                var row = d.CommonResultEntity[0];
                raw = row.vendorID != null && row.vendorID !== "" ? row.vendorID : row.VendorID;
            }
            var id = parseInt(raw, 10);
            if (isNaN(id) || id <= 0) return;
            selectedVendorId = id;
        }

        function isVendorTabSaveSuccessMessage(saveResult) {
            if (!saveResult) return false;
            var msg = String(saveResult);
            if (msg === "Inserted" || msg === "Updated" || msg === "Saved") return true;
            if (msg.toLowerCase().indexOf("successfully") >= 0) return true;
            return false;
        }

        //Added by vikas T at the time of comparison with W26
        // Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


      <%--  function saveVendorMasterForTab(tabId) {
            if (!tabId) return false;
            if (isVendorEditMode && !canVendorMasterEdit) return false;
            if (!isVendorEditMode && !canVendorMasterAdd) return false;

            // Guard: tabs 2-7 require a valid VendorID from Tab 1 save (Add mode)
            //if (tabId !== "#tabBasicInfo" && (!selectedVendorId || selectedVendorId <= 0)) {
            //    alertify.set("notifier", "position", "top-right");
            //    alertify.warning("Please save Basic Information first before saving other sections.");
            //    return false;
            //}

            if (!validateVendorSingleTab(tabId, true)) return false;

            var domRequest = buildVendorMasterRequestFromDom();

            // Always stamp the current (possibly freshly-returned) VendorID onto the request
            // so tabs 2-7 never send VendorID = null after a Tab 1 insert in Add mode.
            if (selectedVendorId > 0) {
                domRequest.VendorID = selectedVendorId;
            }

            var merged = mergeVendorRequestForTabSave(tabId, vendorBaselineRequest, domRequest);
            merged.SaveTabFlag = vendorTabIdToSaveTabFlag(tabId);

            // Ensure VendorID is always present in the final merged payload
            if (selectedVendorId > 0) {
                merged.VendorID = selectedVendorId;
            }

            var response = saveVendorMasterWithDocuments(merged);
            if (response && response.validationFailed) {
                return false;
            }
            var saveResult = getVendorSaveResult(response);

            alertify.set('notifier', 'position', 'top-right');

            if (isVendorTabSaveSuccessMessage(saveResult)) {
                // Capture VendorID returned by the SP FIRST (critical for Tab 1 Add mode
                // and so that the history check below uses the correct/freshly-returned VendorID)
                tryApplyNewVendorIdFromSaveResponse(response);

                if (saveResult === "Inserted" || saveResult === "Saved") {
                    alertify.success('<%=MyBase.GetResourceString("A_VendorSavedSuccessfully") %>');
                    bindVendorDocGrid(1, vendorDocPageSize);
                } else if (saveResult === "Updated") {
                    alertify.success('<%=MyBase.GetResourceString("A_VendorUpdatedSuccessfully") %>');
                    if (selectedVendorId > 0) {
                        if (vendorHasHistoryRecords(selectedVendorId)) {
                            $('#vendorTabHeader a[href="#tabShowHistory"]').parent().show();
                            vendorTabSaved["#tabShowHistory"] = true;
                            // Rebind Modified By / Modified Field dropdowns exactly as in Edit mode
                            populateVendorHistoryFilters();
                            // Rebind history grid so it is up-to-date immediately after update
                            bindVendorHistoryGrid(1, vendorHistoryPageSize);
                        } else {
                            $('#vendorTabHeader a[href="#tabShowHistory"]').parent().hide();
                        }
                    }
                } else {
                    alertify.success(saveResult);
                }

                // (tryApplyNewVendorIdFromSaveResponse already called above)

                // Rebuild baseline with the now-correct selectedVendorId
                vendorBaselineRequest = cloneVendorMasterRequest(buildVendorMasterRequestFromDom());
                if (selectedVendorId > 0) {
                    vendorBaselineRequest.VendorID = selectedVendorId;
                }

                resetVendorTabDirtyFlags();
                // Mark current tab as saved to unlock the next tab
                vendorTabSaved[tabId] = true;

                // Change 1: Tax & Compliance has no mandatory fields after it, so once it is
                // saved, immediately unlock Bank Details, Commercial Details, and Documents
                // (they have no mandatory fields themselves so can all be reached freely).
                if (tabId === "#tabTax") {
                    vendorTabSaved["#tabBank"]       = true;
                    vendorTabSaved["#tabCommercial"] = true;
                    vendorTabSaved["#tabDocuments"]  = true;
                }

                // Change 2: After any successful save (insert or update) in edit mode, check
                // whether history records now exist and show/hide the Show History tab.
                if (isVendorEditMode && selectedVendorId > 0) {
                    if (vendorHasHistoryRecords(selectedVendorId)) {
                        $('#vendorTabHeader a[href="#tabShowHistory"]').parent().show();
                        vendorTabSaved["#tabShowHistory"] = true;
                        refreshVendorTabWizardLocks();
                    }
                }
                // Change 2 (Add mode): after Basic Info is saved for the first time and
                // selectedVendorId is now set, also check history (edge-case: re-save of
                // an existing vendor that was opened via Add path — keep safe to call).
                if (!isVendorEditMode && tabId === "#tabBasicInfo" && selectedVendorId > 0) {
                    if (vendorHasHistoryRecords(selectedVendorId)) {
                        $('#vendorTabHeader a[href="#tabShowHistory"]').parent().show();
                        vendorTabSaved["#tabShowHistory"] = true;
                    }
                }

                if (tabId === "#tabDocuments" && selectedVendorId > 0) {
                    // Refresh the document grid so newly uploaded files appear immediately
                    // in both Add mode and Edit mode.
                    bindVendorDocGrid(1, vendorDocPageSize);

                    // In Add mode, vendorExistingDocuments is never populated by the
                    // open-vendor flow (that only runs in Edit mode). After the first
                    // Documents save, the file inputs still hold their selected files,
                    // so the next Save would re-upload the same files as new rows.
                    //
                    // Fix: fetch the freshly saved documents from the API, pass them
                    // to bindVendorDocuments so vendorExistingDocuments is updated with
                    // the correct VendorDocumentIDs, and clear every file input so only
                    // newly chosen files are uploaded on subsequent saves.
                    var freshDocUrl = "/api/VendorMaster/GetVendorDocuments?vendorId=" +
                        encodeURIComponent(selectedVendorId) + "&pageNumber=1&pageSize=999";
                    var freshDocRes = AJAXCallWithResult(freshDocUrl, null, false);--%>



        function saveVendorMasterForTab(tabId) {

            if (!tabId) return false;

            if (isVendorEditMode && !canVendorMasterEdit) return false;

            if (!isVendorEditMode && !canVendorMasterAdd) return false;

            // Guard: tabs 2-7 require a valid VendorID from Tab 1 save (Add mode)

            //if (tabId !== "#tabBasicInfo" && (!selectedVendorId || selectedVendorId <= 0)) {
            //    alertify.set("notifier", "position", "top-right");
            //    alertify.warning("Please save Basic Information first before saving other sections.");
            //    return false;
            //}

            if (!validateVendorSingleTab(tabId, true)) return false;

            var domRequest = buildVendorMasterRequestFromDom();

            // Always stamp the current (possibly freshly-returned) VendorID onto the request
            // so tabs 2-7 never send VendorID = null after a Tab 1 insert in Add mode.

            if (selectedVendorId > 0) {

                domRequest.VendorID = selectedVendorId;
            }

            var merged = mergeVendorRequestForTabSave(
                tabId,
                vendorBaselineRequest,
                domRequest
            );

            merged.SaveTabFlag = vendorTabIdToSaveTabFlag(tabId);

            // Ensure VendorID is always present in the final merged payload

            if (selectedVendorId > 0) {

                merged.VendorID = selectedVendorId;
            }

            var response = saveVendorMasterWithDocuments(merged);

            if (response && response.validationFailed) {

                return false;
            }

            var saveResult = getVendorSaveResult(response);

            alertify.set('notifier', 'position', 'top-right');

            if (isVendorTabSaveSuccessMessage(saveResult)) {

                // Capture VendorID returned by the SP FIRST (critical for Tab 1 Add mode
                // and so that the history check below uses the correct/freshly-returned VendorID)

                tryApplyNewVendorIdFromSaveResponse(response);

                if (saveResult === "Inserted" || saveResult === "Saved") {

                    alertify.success(
                '<%=MyBase.GetResourceString("A_VendorSavedSuccessfully") %>'
            );

            bindVendorDocGrid(1, vendorDocPageSize);

        }
        else if (saveResult === "Updated") {

            alertify.success(
                '<%=MyBase.GetResourceString("A_VendorUpdatedSuccessfully") %>'
            );

            if (selectedVendorId > 0) {

                if (vendorHasHistoryRecords(selectedVendorId)) {

                    $('#vendorTabHeader a[href="#tabShowHistory"]')
                        .parent()
                        .show();

                    vendorTabSaved["#tabShowHistory"] = true;

                    // Rebind Modified By / Modified Field dropdowns exactly as in Edit mode

                    populateVendorHistoryFilters();

                    // Rebind history grid so it is up-to-date immediately after update

                    bindVendorHistoryGrid(1, vendorHistoryPageSize);

                } else {

                    $('#vendorTabHeader a[href="#tabShowHistory"]')
                        .parent()
                        .hide();
                }
            }
        }
        else {

            alertify.success(saveResult);
        }

        // (tryApplyNewVendorIdFromSaveResponse already called above)

        // Rebuild baseline with the now-correct selectedVendorId

        vendorBaselineRequest = cloneVendorMasterRequest(
            buildVendorMasterRequestFromDom()
        );

        if (selectedVendorId > 0) {

            vendorBaselineRequest.VendorID = selectedVendorId;
        }

        resetVendorTabDirtyFlags();

        // Mark current tab as saved to unlock the next tab

        vendorTabSaved[tabId] = true;

        // Change 1: Tax & Compliance has no mandatory fields after it, so once it is
        // saved, immediately unlock Bank Details, Commercial Details, and Documents
        // (they have no mandatory fields themselves so can all be reached freely).

        if (tabId === "#tabTax") {

            vendorTabSaved["#tabBank"] = true;
            vendorTabSaved["#tabCommercial"] = true;
            vendorTabSaved["#tabDocuments"] = true;
        }

        // Change 2: After any successful save (insert or update) in edit mode, check
        // whether history records now exist and show/hide the Show History tab.

        if (isVendorEditMode && selectedVendorId > 0) {

            if (vendorHasHistoryRecords(selectedVendorId)) {

                $('#vendorTabHeader a[href="#tabShowHistory"]')
                    .parent()
                    .show();

                vendorTabSaved["#tabShowHistory"] = true;

                refreshVendorTabWizardLocks();
            }
        }

        // Change 2 (Add mode): after Basic Info is saved for the first time and
        // selectedVendorId is now set, also check history (edge-case: re-save of
        // an existing vendor that was opened via Add path — keep safe to call).

        if (!isVendorEditMode &&
            tabId === "#tabBasicInfo" &&
            selectedVendorId > 0) {

            if (vendorHasHistoryRecords(selectedVendorId)) {

                $('#vendorTabHeader a[href="#tabShowHistory"]')
                    .parent()
                    .show();

                vendorTabSaved["#tabShowHistory"] = true;
            }
        }

        if (tabId === "#tabDocuments" && selectedVendorId > 0) {

            // Refresh the document grid so newly uploaded files appear immediately
            // in both Add mode and Edit mode.

            bindVendorDocGrid(1, vendorDocPageSize);

            // In Add mode, vendorExistingDocuments is never populated by the
            // open-vendor flow (that only runs in Edit mode). After the first
            // Documents save, the file inputs still hold their selected files,
            // so the next Save would re-upload the same files as new rows.
            //
            // Fix: fetch the freshly saved documents from the API, pass them
            // to bindVendorDocuments so vendorExistingDocuments is updated with
            // the correct VendorDocumentIDs, and clear every file input so only
            // newly chosen files are uploaded on subsequent saves.

            // FromBody Payload

            var freshDocPayload = JSON.stringify({
                VendorId: selectedVendorId,
                PageNumber: 1,
                PageSize: 999
            });

            var freshDocRes = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorDocuments",
                freshDocPayload,
                false
            );


            // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody

            //Ended by vikas T at the time of comparison with W26
                    var freshDocs = [];
                    if (freshDocRes && freshDocRes.data && freshDocRes.data.RM_VendorDocuments) {
                        freshDocs = freshDocRes.data.RM_VendorDocuments;
                    } else if (freshDocRes && freshDocRes.data && Array.isArray(freshDocRes.data)) {
                        freshDocs = freshDocRes.data;
                    } else if (freshDocRes && Array.isArray(freshDocRes)) {
                        freshDocs = freshDocRes;
                    }
                    if (freshDocs.length > 0) {
                        // Update vendorExistingDocuments so subsequent saves know which
                        // VendorDocumentID belongs to each type and do UPDATE not INSERT
                        bindVendorDocuments(freshDocs);
                    }

                    // Clear all file inputs so already-uploaded files are not sent again
                    // on the next Save click (only newly chosen files should be uploaded)
                    for (var ci = 0; ci < vendorDocumentTypeConfigs.length; ci++) {
                        var inp = document.getElementById(vendorDocumentTypeConfigs[ci].inputId);
                        if (inp) inp.value = "";
                    }
                }

                bindVendorGrid(vendorCurrentPage, vendorPageSize);
                refreshVendorTabWizardLocks();

                return true;
            }
            
            if (saveResult === "Vendor Code already exists") {
                alertify.error('<%=MyBase.GetResourceString("A_VendorCodeAlreadyExists") %>');
                $("#txtVendorCode").focus();
                return false;
            }
            if (saveResult === "Vendor Name already exists") {
                alertify.error('<%=MyBase.GetResourceString("A_VendorNameAlreadyExists") %>');
                $("#txtVendorName").focus();
                return false;
            }

            if (response.data[0].result === "PAN Number already exists") {
                alertify.error('PAN Number already exists');
                $("#txtPANNumber").focus();
                return false;
            }

            if (response.data[0].result === "GSTIN already exists") {
                alertify.error('GSTIN already exists');
                $("#txtGSTIN").focus();
                return false;
            }

            if (response.data[0].result === "TAN Number already exists") {
                alertify.error('TAN Number already exists');
                $("#txtTANNumber").focus();
                return false;
            }

            if (response.data[0].result === "CIN already exists") {
                alertify.error('CIN already exists');
                $("#txtCIN").focus();
                return false;
            }

            if (response.data[0].result === "MSME Number already exists") {
                alertify.error('MSME Number already exists');
                $("#txtMSMENumber").focus();
                return false;
            }

            alertify.error((response && response.data && response.data.message) ? response.data.message : '<%=MyBase.GetResourceString("A_ErrorOccurredWhileSavingVendor") %>');
            return false;
        }

        // Added by Dipali V on 18th May 2026 - Purpose:-Vendor document upload validation (mirrors ValidateAttachment of PM_Resource_Selection.aspx): special characters, FileExtensionDisallow allow-list, double extension, file name length, MinFileSize.
        function validateVendorDocuments() {
            alertify.set('notifier', 'position', 'top-right');
            var intMinFileSize = parseInt('<%=ConfigurationManager.AppSettings("MinFileSize")%>', 10) || 0;
            var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>';
            var validateExtensions = (strFileExtension && strFileExtension.length > 0) ? strFileExtension.split(",") : [];

            for (var i = 0; i < vendorDocumentTypeConfigs.length; i++) {
                var input = document.getElementById(vendorDocumentTypeConfigs[i].inputId);
                if (!input || !input.files || input.files.length === 0) continue;

                var file = input.files[0];
                if (!file || !file.name) continue;

                if (typeof disallowSpecialCharacters === 'function') {
                    if (disallowSpecialCharacters(input, 'Special character # is not allowed', true, '#')) { return false; }
                    if (disallowSpecialCharacters(input, 'Single quotation mark is not allowed in file name', true, "'")) { return false; }
                } else {
                    if (file.name.indexOf('#') !== -1) {
                        alertify.error('Special character # is not allowed');
                        return false;
                    }
                    if (file.name.indexOf("'") !== -1) {
                        alertify.error('Single quotation mark is not allowed in file name');
                        return false;
                    }
                }

                if (strFileExtension.length > 0) {
                    var allowSubmit = false;
                    var extension = file.name.slice(file.name.lastIndexOf('.') + 1).toLowerCase();
                    for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                        var strExtn = validateExtensions[cnt];
                        if (strExtn && strExtn.trim().toLowerCase() === extension) {
                            allowSubmit = true;
                            break;
                        }
                    }
                    if (!allowSubmit) {
                        alertify.error("Only files with extensions " + validateExtensions.join(", ").toUpperCase() + " are  allowed!!!");
                        return false;
                    }
                }

                var countOfDot = file.name.split(".").length - 1;
                if (countOfDot > 1) {
                    alertify.error('File with two or more extensions is not allowed!');
                    return false;
                }

                var fileNameCharCount = file.name.split(".")[0].length;
                if (fileNameCharCount > 120) {
                    alertify.error('File name should not exceed 120 characters!');
                    return false;
                }

                if (intMinFileSize > 0 && file.size < intMinFileSize) {
                    alertify.error('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
                    return false;
                }
            }
            return true;
        }

        function saveVendorMasterWithDocuments(request) {
            // Added by Dipali V on 18th May 2026 - Purpose:-Validate new document uploads before save (see validateVendorDocuments / PM_Resource_Selection ValidateAttachment).
            if (!validateVendorDocuments()) {
                return { validationFailed: true };
            }

            // Always include the existing documents (with their VendorDocumentIDs) in the request,
            // so even when no new files are uploaded, the backend SP receives the existing IDs
            // and can perform proper UPDATE-by-ID instead of inserting duplicates with null IDs.
            var existingDocsList = [];
            for (var key in vendorExistingDocuments) {
                if (!Object.prototype.hasOwnProperty.call(vendorExistingDocuments, key)) continue;
                var existing = vendorExistingDocuments[key];
                if (!existing) continue;
                existingDocsList.push({
                    VendorDocumentID: existing.vendorDocumentID || null,
                    DocumentType: existing.documentType || key,
                    FileName: existing.fileName || "",
                    FilePath: existing.filePath || "",
                    FileExtension: existing.fileExtension || "",
                    FileSize: existing.fileSize || 0,
                    Remarks: existing.remarks || "",
                    UserName: '<%=Session("strUserName")%>'
                });
            }

            var requestWithDocs = $.extend({}, request, { Documents: existingDocsList });

            var formData = new FormData();
            var hasFiles = false;

            formData.append("VendorDataJson", JSON.stringify(requestWithDocs));

            for (var i = 0; i < vendorDocumentTypeConfigs.length; i++) {
                var map = vendorDocumentTypeConfigs[i];
                var input = document.getElementById(map.inputId);
                if (!input || !input.files || input.files.length === 0) continue;

                var file = input.files[0];
                if (!file) continue;

                // If we have an existing document for this type (Edit mode), pass its
                // VendorDocumentID so the backend updates that exact record; otherwise
                // pass an empty string and the backend should insert a new record.
                var existingDoc = vendorExistingDocuments[map.docType] || {};
                var existingDocId = ((isVendorEditMode || selectedVendorId > 0) && existingDoc.vendorDocumentID) ? existingDoc.vendorDocumentID : "";

                hasFiles = true;
                formData.append("Files", file);
                formData.append("DocumentTypes", map.docType);
                formData.append("Remarks", "");
                formData.append("VendorDocumentIDs", existingDocId);
            }

            if (!hasFiles) {
                return AJAXCallWithResult("/api/VendorMaster/SaveVendorMaster", JSON.stringify(requestWithDocs), false);
            }

            var multipartResult = null;
            $.ajax({
                url: encodeURI(strUrl) + "api/VendorMaster/SaveVendorMasterWithDocuments",
                type: "POST",
                data: formData,
                async: false,
                processData: false,
                contentType: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (data) {
                    multipartResult = data;
                },
                error: function (err) {
                    console.log(err);
                    multipartResult = null;
                }
            });

            return multipartResult;
        }

        $(document).ready(function () {
            function syncTooltipForInput(selector) {
                var $field = $(selector);
                if ($field.length === 0) return;
                var value = $.trim($field.val() || "");
                if (value.length > 35) {
                    $field.attr("title", value).attr("data-bs-toggle", "tooltip").attr("data-bs-placement", "top");
                } else {
                    $field.removeAttr("title").removeAttr("data-bs-toggle").removeAttr("data-bs-placement");
                }
            }

            $("#txtVendorName,#txtVendorDescription").on("input blur", function () {
                syncTooltipForInput("#" + this.id);
                initializeTooltips();
            });

            // Select-all header checkbox
            // When CHECKED   → fetch every selectable VendorID across ALL pages
            //                  (using current filters, pageSize=99999), add them all
            //                  to vendorMasterSelectedIds, then re-render the current
            //                  page so visible rows immediately reflect the selection.
            // When UNCHECKED → clear vendorMasterSelectedIds entirely, re-render.
            // This ensures the header state is always driven by the persistent
            // selectedIds set, not by what checkboxes happen to be in the DOM.
            //Added by vikas T at the time of comparison with W26
            // Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody
 
            //$(document).on("change", "#chkSelectAllVendors", function () {
            //    debugger
            //    var checked = this.checked;
            //    vendorMasterSelectAllMode = checked;
            //    vendorMasterSelectedIds   = [];
            //    vendorMasterExcludedIds   = [];

            //    if (checked) {
            //        // Fetch ALL records with current filters to get every selectable ID
            //        var vendorCode    = $.trim($("#txtVendorCodeFilter").val() || "");
            //        var vendorName    = $.trim($("#txtVendorNameFilter").val() || "");
            //        var vendorTypeVal = $("#ddlVendorTypeFilter").val();
            //        var vendorTypeId  = (vendorTypeVal && parseInt(vendorTypeVal) > 0) ? parseInt(vendorTypeVal) : null;
            //        var isActive      = $.trim($("#ddlStatusFilter").val() || "");

            //        var allUrl = "/api/VendorMaster/GetVendorMaster?vendorId=&pageNumber=1&pageSize=99999" +
            //            "&vendorCode=" + encodeURIComponent(vendorCode) +
            //            "&vendorName=" + encodeURIComponent(vendorName) +
            //            "&vendorTypeId=" + (vendorTypeId === null ? "" : vendorTypeId) +
            //            "&isActive=" + isActive;

            //        var allResult = AJAXCallWithResult(allUrl, null, false);



            $(document).on("change", "#chkSelectAllVendors", function () {
                var checked = this.checked;

                vendorMasterSelectAllMode = checked;
                vendorMasterSelectedIds = [];
                vendorMasterExcludedIds = [];

                if (checked) {

                    // Fetch ALL records with current filters to get every selectable ID

                    var vendorCode = $.trim($("#txtVendorCodeFilter").val() || "");
                    var vendorName = $.trim($("#txtVendorNameFilter").val() || "");

                    var vendorTypeVal = $("#ddlVendorTypeFilter").val();
                    var vendorTypeId = (vendorTypeVal && parseInt(vendorTypeVal) > 0)
                        ? parseInt(vendorTypeVal)
                        : null;

                    var isActiveVal = $.trim($("#ddlStatusFilter").val() || "");
                    var isActive = isActiveVal !== "" ? parseInt(isActiveVal) : null;

                    // FromBody Payload

                    var payload = JSON.stringify({
                        VendorId: null,
                        PageNumber: 1,
                        PageSize: 99999,
                        VendorCode: vendorCode,
                        VendorName: vendorName,
                        VendorTypeId: vendorTypeId,
                        IsActive: isActive
                    });

                    var allResult = AJAXCallWithResult(
                        "/api/VendorMaster/GetVendorMaster",
                        payload,
                        false
                    );

                    // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody
//Ended by vikas T at the time of comparison with W26

                    var allList = [];
                    if (allResult && allResult.data && allResult.data.data) {
                        allList = allResult.data.data.vendorMaster || allResult.data.data.VendorMaster || allResult.data.data.RM_VendorMaster || [];
                    } else if (allResult && allResult.data) {
                        allList = allResult.data.vendorMaster || allResult.data.VendorMaster || allResult.data.RM_VendorMaster || [];
                    }

                    // Collect only selectable (not-in-use) IDs
                    for (var i = 0; i < allList.length; i++) {
                        var r   = allList[i];
                        var rid = parseInt(r.vendorID || 0, 10);
                        if (rid <= 0) continue;
                        var inUse = (r.vendorInUse === true || r.vendorInUse === 1 ||
                                     r.VendorInUse === true || r.VendorInUse === 1 ||
                                     String(r.vendorInUse).toLowerCase() === "true" ||
                                     String(r.VendorInUse).toLowerCase() === "true");
                        if (!inUse) vendorMasterSelectedIds.push(rid);
                    }
                    // Keep the selectable count in sync
                    vendorTotalSelectableCount = vendorMasterSelectedIds.length;
                }

                // Re-render current page — bindVendorGrid uses vendorMasterSelectedIds
                // to set each row checkbox and calls updateVendorSelectAllHeaderState()
                bindVendorGrid(vendorCurrentPage, vendorPageSize);
            });

            $("#btnShowAddVendor").on("click", function () {
                clearVendorForm();

                $('#vendorTabHeader a[href="#tabShowHistory"]').parent().hide();
                setVendorTab("#tabBasicInfo");
                applyVendorFormFieldsReadOnly(false);
                // Disable checkbox in Add mode (after re-enabling form fields)
                $("#chkVendorActive").prop("disabled", true);
                applyVendorMasterSaveButtonVisibility();
                refreshVendorTabWizardLocks();
                openVendorOffcanvas();
                resetVendorTabDirtyFlags();
                // Add mode: pass VendorID = 0
                bindVendorTypeDropdown(0);
            });

            $("#vendorTabHeader a[data-bs-toggle='tab']").on("click", function (e) {
                e.preventDefault();
                var href = $(this).attr("href");
                if (setVendorTab(href) === false) return;
            });

            $("#btnPreviousTab").on("click", function () {
                var current = $("#vendorTabHeader li.active a").attr("href");
                var visibleTabs = getVisibleVendorTabs();
                var idx = visibleTabs.indexOf(current);
                if (idx > 0) setVendorTab(visibleTabs[idx - 1]);
            });

            $("#btnNextTab").on("click", function () {
                var current = $("#vendorTabHeader li.active a").attr("href");
                if (!vendorTabSaved[current]) {
                    alertify.set("notifier", "position", "top-right");
                    alertify.warning("Please save the current tab before proceeding to the next tab.");
                    return false;
                }
                var visibleTabs = getVisibleVendorTabs();
                var idx = visibleTabs.indexOf(current);
                if (idx !== -1 && idx < visibleTabs.length - 1) setVendorTab(visibleTabs[idx + 1], true);
            });

            $("#btnResetVendor").on("click", function () {
                $("#txtVendorCodeFilter,#txtVendorNameFilter").val("");
                $("#ddlVendorTypeFilter,#ddlStatusFilter").val("0").selectpicker("refresh");
                // Reset all selection state on filter change
                vendorCurrentPage            = 1;
                vendorMasterSelectedIds      = [];
                vendorMasterExcludedIds      = [];
                vendorMasterSelectAllMode    = false;
                vendorTotalSelectableCount   = 0;
                bindVendorGrid(1, vendorPageSize);
            });

            $("#btnSearchVendor").on("click", function () {
                // Reset all selection state on new search
                vendorCurrentPage            = 1;
                vendorMasterSelectedIds      = [];
                vendorMasterExcludedIds      = [];
                vendorMasterSelectAllMode    = false;
                vendorTotalSelectableCount   = 0;
                bindVendorGrid(1, vendorPageSize);
            });

            $("#vendorDetailsOffcanvas").on("click", ".vendor-tab-save-btn", function () {
                var $pane = $(this).closest(".tab-pane");
                var pid = $pane.attr("id");
                var tabHref = pid ? ("#" + pid) : "";
                saveVendorMasterForTab(tabHref);
            });

            $("#ddlVendorHistoryModifiedBy,#ddlVendorHistoryModifiedField").on("change", function () {
                loadVendorHistory();
            });

            $('#vendorTabHeader a[href="#tabShowHistory"]').on("shown.bs.tab", function () {
                populateVendorHistoryFilters();
                loadVendorHistory();
            });

            $(".selectpicker").selectpicker();
            bindVendorInputValidations();
            setVendorNavState();
            resetVendorTabSavedFlags();
            toggleMSMENumber();
            updateVendorHistoryPaginationButtons(0);
            bindVendorGrid(1, vendorPageSize);
            applyVendorMasterSaveButtonVisibility();

            $("#vendorDetailsOffcanvas").on("input change blur", ".vendor-form-panel input, .vendor-form-panel textarea, .vendor-form-panel select", function () {
                markVendorTabDirtyFromElement(this);
            });
            $("#vendorDetailsOffcanvas").on("change", ".vendor-form-panel input[type='file']", function () {
                markVendorTabDirtyFromElement(this);
            });
            $("#vendorDetailsOffcanvas").on("changed.bs.select", ".vendor-form-panel .selectpicker", function () {
                markVendorTabDirtyFromElement(this);
            });
            $("#chkMSMERegistered").on("change", function () {
                markVendorTabDirtyFromElement(this);
            });
        });

        function resetVendorActiveInUseTooltipUI() {
            var cb = document.getElementById("chkVendorActive");
            if (!cb || !cb.closest) return;
            var wrap = cb.closest(".custom_chckbox");
            if (wrap) {
                try {
                    if (typeof bootstrap !== "undefined" && bootstrap.Tooltip) {
                        var inst = bootstrap.Tooltip.getInstance(wrap);
                        if (inst) inst.dispose();
                    }
                } catch (e) { }
                wrap.removeAttribute("title");
                wrap.removeAttribute("data-bs-toggle");
                wrap.removeAttribute("data-bs-placement");
                wrap.style.cursor = "";
            }
            cb.removeAttribute("title");
            cb.removeAttribute("data-bs-toggle");
            cb.removeAttribute("data-bs-placement");
        }

        function initializeTooltips() {
            if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
            var triggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
            triggerList.forEach(function (el) {
                try {
                    var existing = bootstrap.Tooltip.getInstance(el);
                    if (existing) existing.dispose();
                } catch (e) { }

                var tip = new bootstrap.Tooltip(el, {
                    trigger: 'hover',
                    container: 'body'
                });

                // Ensure tooltip never "sticks" after click/focus
                if (!el.dataset.tooltipBound) {
                    el.addEventListener('mouseleave', function () { try { tip.hide(); } catch (e) { } });
                    el.addEventListener('blur', function () { try { tip.hide(); } catch (e) { } });
                    el.addEventListener('click', function () { try { tip.hide(); } catch (e) { } });
                    el.dataset.tooltipBound = '1';
                }
            });
        }

        function validateContactNumber(input) {
            // Allow only numbers, + and -
            input.value = input.value.replace(/[^0-9+-]/g, '');

            // Restrict length to 15 characters
            if (input.value.length > 15) {
                input.value = input.value.slice(0, 15);
            }
        }

        function validateMSMENumber(input, event) {
            
            // Allow alphabets, numbers and hyphen
            input.value = input.value.replace(/[^A-Za-z0-9-]/g, '');

            // Restrict length to 19 characters
            if (input.value.length > 19) {
                input.value = input.value.slice(0, 19);
            }
        }

        //function validateUPIID(input) {

        //    // Allow alphabets, numbers, @, - and _
        //    //input.value = input.value.replace(/[^a-zA-Z0-9@_-]/g, '');

        //    //// Restrict maximum length to 60
        //    //if (input.value.length > 60) {
        //    //    input.value = input.value.substring(0, 60);
        //    //}

        //    //if (input.value.startsWith('@')) {
        //    //    input.value = input.value.substring(1);
        //    //}
        //    // Allow alphabets, numbers, @, ., - and _
        //    let value = input.value.replace(/[^a-zA-Z0-9@._-]/g, '');

        //    // Allow only one dot
        //    value = value.replace(/(\..*)\./g, '$1');

        //    // Restrict maximum length to 60
        //    if (value.length > 60) {
        //        value = value.substring(0, 60);
        //    }

        //    // Prevent @ at first position
        //    if (value.startsWith('@')) {
        //        value = value.substring(1);
        //    }

        //    input.value = value;
        //}

        function validateUPIID(input) {
            // UPI ID format: <username>@<bankhandle>
            //   Both parts allow: letters, digits, dots, hyphens, underscores
            //   e.g. Rajesh.Kumar@OKAXIS, john.doe@oksbi, jane-doe@upi
            //
            // Key regex fix: hyphen (-) MUST be at the END of the character class
            // to be treated as a literal hyphen. Placing it between characters
            // (like ._-) creates an invalid ASCII range and silently breaks the
            // pattern in some browsers — causing the dot to be stripped.

            // Step 1: strip every character that is not legal in a UPI ID.
            //         Hyphen placed LAST inside [] to avoid range-operator ambiguity.
            let value = input.value.replace(/[^a-zA-Z0-9@._-]/g, '');

            // Step 2: allow at most one @
            //         Keep everything up to and including the first @,
            //         then strip any extra @ signs from the handle part.
            var atIdx = value.indexOf('@');
            if (atIdx !== -1) {
                value = value.substring(0, atIdx + 1)
                    + value.substring(atIdx + 1).replace(/@/g, '');
            }

            // Step 3: prevent @ in the very first position
            if (value.charAt(0) === '@') {
                value = value.substring(1);
            }

            // Step 4: enforce max length of 60
            if (value.length > 60) {
                value = value.substring(0, 60);
            }

            input.value = value;
        }

        //function isUPIIDValueValid(str) {
        //    var v = $.trim(str || "");
        //    if (v === "") return true;
        //    var parts = v.split("@");
        //    if (parts.length !== 2 || !parts[0] || !parts[1]) return false;
        //    if (parts[0].length > 60 || parts[1].length > 60) return false;
        //    if (!/^[a-zA-Z0-9_-]+$/.test(parts[0])) return false;
        //    if (!/^[a-zA-Z0-9_-]+$/i.test(parts[1])) return false;
        //    return true;
        //}

        function isUPIIDValueValid(str) {
            // Validates a UPI ID at submit time.
            // Both username and handle allow: letters, digits, dots, hyphens, underscores.
            // Hyphen placed LAST in [] to avoid invalid range interpretation.
            // Examples that must pass: Rajesh.Kumar@OKAXIS, john.doe@oksbi, jane-doe@upi
            var v = $.trim(str || "");
            if (v === "") return true;
            var parts = v.split("@");
            if (parts.length !== 2 || !parts[0] || !parts[1]) return false;
            if (v.length > 60) return false;
            if (!/^[a-zA-Z0-9._-]+$/.test(parts[0])) return false;
            if (!/^[a-zA-Z0-9._-]+$/.test(parts[1])) return false;
            return true;
        }

        function blockInvalidCreditLimitKey(e) {
            // Allow: backspace, delete, tab, escape, enter, home, end, arrow keys
            var allowedKeys = [8, 9, 13, 27, 46, 35, 36, 37, 38, 39, 40];
            if (allowedKeys.indexOf(e.keyCode) !== -1) return true;
            // Allow Ctrl/Cmd + A/C/V/X/Z
            if ((e.ctrlKey || e.metaKey) && [65, 67, 86, 88, 90].indexOf(e.keyCode) !== -1) return true;
            var key = e.key || String.fromCharCode(e.keyCode);
            // Allow digits (0-9) from main keyboard and numpad
            if ((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105)) return true;
            // Allow dot (.) — but only if there is no dot already in the value
            if (key === '.' || e.keyCode === 110 || e.keyCode === 190) {
                var currentVal = e.target.value || '';
                // Prevent leading decimal
                var cleanVal = currentVal.replace(/,/g, '');
                if (cleanVal === '' || e.target.selectionStart === 0) {
                    if (e.preventDefault) e.preventDefault();
                    return false;
                }
                // Prevent duplicate decimal
                if (currentVal.indexOf('.') !== -1) {
                    if (e.preventDefault) e.preventDefault();
                    return false;
                }
                return true;
            }
            // Block everything else
            if (e.preventDefault) e.preventDefault();
            return false;
        }

        function formatCreditLimit(input) {
            // Called oninput — strip disallowed chars, enforce single dot, auto-comma
            let value = input.value;

            // Remove all chars except digits, comma and dot (comma is re-added below)
            value = value.replace(/[^0-9,.]/g, '');

            // Strip commas for arithmetic operations
            value = value.replace(/,/g, '');

            // Prevent leading decimal point
            if (value.charAt(0) === '.') {
                value = value.substring(1);
            }

            // Allow only one decimal point — keep only the first occurrence
            let dotIndex = value.indexOf('.');
            if (dotIndex !== -1) {
                value = value.substring(0, dotIndex + 1) + value.substring(dotIndex + 1).replace(/\./g, '');
            }

            // Split integer and decimal part
            let parts = value.split('.');
            let integerPart = parts[0];
            let hasDecimal = parts.length > 1;
            let decimalPart = hasDecimal ? parts[1] : '';

            // Add commas on input (Indian/international comma formatting)
            integerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, ',');

            // Rebuild final value
            if (hasDecimal) {
                input.value = integerPart + '.' + decimalPart;
            } else {
                input.value = integerPart;
            }
        }


        /* ================================================================
           VENDOR DOCUMENT GRID  — Edit mode, tabDocuments only
           API: POST /api/VendorMaster/GetVendorDocuments
                ?vendorId=&pageNumber=&pageSize=
        ================================================================ */

        function updateVendorDocPaginationButtons(totalCount) {
            var totalPages = Math.max(1, Math.ceil(totalCount / vendorDocPageSize));
            var prev = document.getElementById('vendorDocPrevBtn');
            var next = document.getElementById('vendorDocNextBtn');
            if (!prev || !next) return;

            var disablePrev = vendorDocCurrentPage <= 1 || totalCount === 0;
            prev.disabled      = disablePrev;
            prev.style.opacity = disablePrev ? '0.5' : '1';
            prev.style.cursor  = disablePrev ? 'no-drop' : 'pointer';

            var disableNext = vendorDocCurrentPage >= totalPages || totalCount === 0;
            next.disabled      = disableNext;
            next.style.opacity = disableNext ? '0.5' : '1';
            next.style.cursor  = disableNext ? 'no-drop' : 'pointer';
        }

        function goToPrevVendorDocPage() {
            if (vendorDocCurrentPage > 1) {
                bindVendorDocGrid(vendorDocCurrentPage - 1, vendorDocPageSize);
            }
        }

        function goToNextVendorDocPage() {
            bindVendorDocGrid(vendorDocCurrentPage + 1, vendorDocPageSize);
        }

        function buildVendorDocFileUrl(filePath) {
            if (!filePath) return "";
            if (/^https?:\/\//i.test(filePath)) return filePath;
            return encodeURI(strUrl.replace(/\/+$/, "") + "/" + String(filePath).replace(/^\/+/, ""));
        }

        function clearVendorDocGrid() {
            vendorDocCurrentPage = 1;
            vendorDocTotalCount  = 0;
            $("#tblVendorDocListBody").html(
                '<tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoRecordsToView") %></td></tr>'
            );
            $("#vendorDocTotalRecords").text('<%=MyBase.GetResourceString("C_TotalRecords") %>: 0');
            updateVendorDocPaginationButtons(0);
            $("#vendorDocGrid").hide();
        }
        //Added by vikas T at the time of comparison with W26
        // Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


        //function bindVendorDocGrid(pageNumber, pageSize) {
        //    pageNumber = pageNumber || 1;
        //    pageSize   = pageSize   || vendorDocPageSize;
        //    vendorDocPageSize = pageSize;

        //    // Requires a valid VendorID — works in both Add mode (after Tab 1 save
        //    // assigns selectedVendorId) and Edit mode.
        //    if (!(selectedVendorId > 0)) {
        //        clearVendorDocGrid();
        //        return;
        //    }

        //    // Show the grid section
        //    $("#vendorDocGrid").show();

        //    var url = "/api/VendorMaster/GetVendorDocuments?vendorId=" +
        //              encodeURIComponent(selectedVendorId) +
        //              "&pageNumber=" + pageNumber +
        //              "&pageSize="   + pageSize;

        //    var response = AJAXCallWithResult(url, null, false);

        function bindVendorDocGrid(pageNumber, pageSize) {

            pageNumber = pageNumber || 1;
            pageSize = pageSize || vendorDocPageSize;

            vendorDocPageSize = pageSize;

            // Requires a valid VendorID — works in both Add mode (after Tab 1 save
            // assigns selectedVendorId) and Edit mode.
            if (!(selectedVendorId > 0)) {
                clearVendorDocGrid();
                return;
            }

            // Show the grid section
            $("#vendorDocGrid").show();

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: selectedVendorId,
                PageNumber: pageNumber,
                PageSize: pageSize
            });

            var response = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorDocuments",
                payload,
                false
            );

            // End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody
            //Ended by vikas T at the time of comparison with W26

            // Normalise response — mirrors pattern used by other grids on this page
            var rows = [];
            if (response && response.data && response.data.RM_VendorDocuments) {
                rows = response.data.RM_VendorDocuments;
            } else if (response && response.data && Array.isArray(response.data)) {
                rows = response.data;
            } else if (response && Array.isArray(response)) {
                rows = response;
            }
            if (!Array.isArray(rows)) rows = [];

            var $tbody = $("#tblVendorDocListBody");
            $tbody.empty();

            if (rows.length === 0) {
                $tbody.append('<tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoRecordsToView") %></td></tr>');
                vendorDocTotalCount  = 0;
                vendorDocCurrentPage = 1;
                $("#vendorDocTotalRecords").text('<%=MyBase.GetResourceString("C_TotalRecords") %>: 0');
                updateVendorDocPaginationButtons(0);
                return;
            }

            // totalCount is embedded in row[0] by the DB-level pagination SP
            var totalCount = parseInt(
                rows[0].totalCount  || rows[0].TotalCount  ||
                rows[0].total_count || rows[0].Total_Count || rows.length, 10
            );
            if (isNaN(totalCount) || totalCount < 0) totalCount = rows.length;

            vendorDocTotalCount  = totalCount;
            vendorDocCurrentPage = pageNumber;

            for (var i = 0; i < rows.length; i++) {
                var doc = rows[i] || {};

                var fileName     = escapeVendorGridText(
                    doc.fileName     || doc.FileName     || "");
                var docType      = escapeVendorGridText(
                    doc.documentType || doc.DocumentType || "");
                var uploadedBy   = escapeVendorGridText(
                    doc.createdBy    || doc.CreatedBy    ||
                    doc.uploadedBy   || doc.UploadedBy   || "");
                var uploadedDate = escapeVendorGridText(
                    doc.createdDate  || doc.CreatedDate  ||
                    doc.uploadedDate || doc.UploadedDate || "");

                var filePath    = doc.filePath || doc.FilePath || "";
                var downloadUrl = buildVendorDocFileUrl(filePath);

                var downloadCell = downloadUrl
                    ? '<a href="' + downloadUrl + '" target="_blank" rel="noopener" ' +
                      'class="vdoc-download-link" title="Download ' + fileName + '">' +
                      '<i class="fas fa-download me-1"></i>Download</a>'
                    : '<span class="text-muted">—</span>';

                var row = "<tr>" +                    
                    "<td>" + docType + "</td>" +
                    "<td>" + fileName + "</td>" +
                    "<td>" + uploadedBy   + "</td>" +
                    "<td>" + uploadedDate + "</td>" +
                    "<td>" + downloadCell + "</td>" +
                    "</tr>";
                $tbody.append(row);
            }

            $("#vendorDocTotalRecords").text('<%=MyBase.GetResourceString("C_TotalRecords") %>: ' + totalCount);
            updateVendorDocPaginationButtons(totalCount);
            initializeTooltips();
        }

        /* ================================================================
           VENDOR MASTER — Delete functionality + VendorType dropdown
        ================================================================ */

        // ── Select-all header checkbox state sync ─────────────────────────
        // The header is checked ONLY when every selectable vendor across ALL
        // pages has been individually selected (vendorMasterSelectedIds covers
        // every selectable record).  Checking the header on page 2 after
        // selecting all rows on page 2 alone must NOT check the header.
        function updateVendorSelectAllHeaderState() {
            var $hdr = $("#chkSelectAllVendors");
            if (!$hdr.length) return;
            var allChecked = (
                vendorTotalSelectableCount > 0 &&
                vendorMasterSelectedIds.length >= vendorTotalSelectableCount
            );
            $hdr.prop("checked", allChecked).prop("indeterminate", false);
        }

        // ── Per-row checkbox change ───────────────────────────────────────
        // Always operates on vendorMasterSelectedIds directly (no exclusion mode).
        // Checking a row   → add its ID to the persistent selected set.
        // Unchecking a row → remove its ID from the persistent selected set, and
        //                    also turn off vendorMasterSelectAllMode so the header
        //                    checkbox becomes unchecked (one row deselected means
        //                    "not all selected").
        function onVendorMasterRowCheckChanged(chk, vid) {
            vid = parseInt(vid, 10) || 0;
            if (!vid) return;

            if (chk.checked) {
                // Add to selected set
                if (vendorMasterSelectedIds.indexOf(vid) === -1) {
                    vendorMasterSelectedIds.push(vid);
                }
            } else {
                // Remove from selected set
                var idx = vendorMasterSelectedIds.indexOf(vid);
                if (idx > -1) vendorMasterSelectedIds.splice(idx, 1);
                // If we were in "all selected" mode, leaving it means not all are
                // selected any more — turn off the mode flag so the header unchecks.
                vendorMasterSelectAllMode = false;
            }

            updateVendorSelectAllHeaderState();
        }

        // ── Delete selected ───────────────────────────────────────────────
        function deleteSelectedVendors() {
            if (!canVendorMasterDelete) return;
            // vendorMasterSelectedIds always holds the authoritative set of every
            // selected ID across all pages — no exclusion mode needed any more.
            var ids = vendorMasterSelectedIds.filter(function (v, i, a) {
                return v > 0 && a.indexOf(v) === i;
            });

            if (ids.length === 0) {
                alertify.set("notifier", "position", "top-right");
                alertify.notify("Please select at least one vendor to delete.", "error", 5);
                return;
            }
            vendorMasterDeleteQueue = ids.slice();
            vendorMasterDeleteId    = vendorMasterDeleteQueue.shift();
            var modalEl = document.getElementById("vendorMasterDeleteModal");
            if (modalEl && typeof bootstrap !== "undefined") {
                bootstrap.Modal.getOrCreateInstance(modalEl).show();
            }
        }

        // ── Confirm delete (Yes button in modal) ──────────────────────────
        //function confirmDeleteVendors() {
        //    var allIds = [vendorMasterDeleteId].concat(vendorMasterDeleteQueue)
        //                  .filter(function(v) { return parseInt(v, 10) > 0; });
        //    var uniqueIds = allIds.filter(function(v, i, a) { return a.indexOf(v) === i; });
        //    var idCsv = uniqueIds.join(",");

        //    //var url = "/api/VendorMaster/DeleteVendor?vendorIds=" + encodeURIComponent(idCsv);
        //    //var result = AJAXCallWithResult(url, null, false);
        //    var url = "/api/VendorMaster/DeleteVendor";

        //    var result = AJAXCallWithResult(
        //        url,
        //        JSON.stringify(idCsv),
        //        false,
        //        "POST",
        //        "application/json"
        //    );
        //    //var status  = 0;
        //    //var message = "";
        //    //if (result && result.data) {
        //    //    var d = result.data.data || result.data;
        //    //    if (d && d.result !== undefined) {
        //    //        status  = (d.result === "Deleted" || d.result === 1 || d.result === "1") ? 1 : 0;
        //    //        message = d.message || d.result || "";
        //    //    } else if (Array.isArray(d) && d.length > 0) {
        //    //        status  = (d[0].result === "Deleted" || d[0].result === 1 || d[0].result === "1") ? 1 : 0;
        //    //        message = d[0].message || d[0].result || "";
        //    //    }
        //    //}
        //    var status = 0;
        //    var message = "";

        //    if (result && result.data && result.data.data) {

        //        var d = result.data.data;

        //        if (Array.isArray(d) && d.length > 0) {

        //            status = d[0].Status;
        //            message = d[0].Message;
        //        }
        //    }
        //    var modalEl = document.getElementById("vendorMasterDeleteModal");
        //    if (modalEl && typeof bootstrap !== "undefined") {
        //        bootstrap.Modal.getOrCreateInstance(modalEl).hide();
        //    }

        //    alertify.set("notifier", "position", "top-right");
        //    if (status === 1 || (result && result.data && (result.data.message === "Deleted" || result.data.result === "Deleted"))) {
        //        alertify.success(message || "Vendor(s) deleted successfully.");
        //    } else {
        //        alertify.error(message || "Unable to delete the selected vendor(s).");
        //        return;
        //    }

        //    // Reset delete state
        //    vendorMasterDeleteId     = 0;
        //    vendorMasterDeleteQueue  = [];
        //    vendorMasterSelectedIds  = [];
        //    vendorMasterExcludedIds  = [];
        //    vendorMasterSelectAllMode = false;
        //    var hdr = document.getElementById("chkSelectAllVendors");
        //    if (hdr) { hdr.checked = false; hdr.indeterminate = false; }

        //    bindVendorGrid(vendorCurrentPage, vendorPageSize);
        //}

        //function confirmDeleteVendors() {
        //    //debugger
        //    var allIds = [vendorMasterDeleteId]
        //        .concat(vendorMasterDeleteQueue)
        //        .filter(function (v) {
        //            return parseInt(v, 10) > 0;
        //        });

        //    var uniqueIds = allIds.filter(function (v, i, a) {
        //        return a.indexOf(v) === i;
        //    });

        //    var idCsv = uniqueIds.join(",");

        //    if (!idCsv) {
        //        alertify.error("Please select vendor(s) to delete.");
        //        return;
        //    }

        //    var url = "/api/VendorMaster/DeleteVendor";

        //    var result = AJAXCallWithResult(
        //        url,
        //        JSON.stringify(idCsv),
        //        false,
        //        "POST",
        //        "application/json"
        //    );




        function confirmDeleteVendors() {
            //debugger
            var allIds = [vendorMasterDeleteId]
                .concat(vendorMasterDeleteQueue)
                .filter(function (v) {
                    return parseInt(v, 10) > 0;
                });

            var uniqueIds = allIds.filter(function (v, i, a) {
                return a.indexOf(v) === i;
            });

            var idCsv = uniqueIds.join(",");

            if (!idCsv) {
                alertify.error("Please select vendor(s) to delete.");
                return;
            }

            // FromBody Payload

            var payload = JSON.stringify(idCsv);

            var result = AJAXCallWithResult(
                "/api/VendorMaster/DeleteVendor",
                payload,
                false,
                "POST",
                "application/json"
            );
// End of Commented and Added By Vyankat B. on 28th May 2026 for converting API parameter binding from FromQuery to FromBody


            var status = 0;
            var message = "";

            if (
                result &&
                result.data &&
                result.data.RM_CommonResponse &&
                Array.isArray(result.data.RM_CommonResponse) &&
                result.data.RM_CommonResponse.length > 0
            ) {

                var d = result.data.RM_CommonResponse[0];

                status = d.status;
                message = d.message;
            }

            if (status == 1) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(message);

                // Full selection reset after successful delete
                vendorMasterDeleteQueue      = [];
                vendorMasterDeleteId         = 0;
                vendorMasterSelectedIds      = [];
                vendorMasterExcludedIds      = [];
                vendorMasterSelectAllMode    = false;
                vendorTotalSelectableCount   = 0;

                $("#chkSelectAllVendors").prop("checked", false);
                $("#vendorMasterDeleteModal").modal("hide");
                bindVendorGrid(1, vendorPageSize);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(message || "Unable to delete vendor.");
            }

            $("#vendorMasterDeleteModal").modal("hide");
        }

        function bindVendorTypeDropdown(vendorId) {

            vendorId = parseInt(vendorId, 10) || 0;

            // FromBody Payload

            var payload = JSON.stringify({
                VendorId: vendorId
            });

            var result = AJAXCallWithResult(
                "/api/VendorMaster/GetVendorTypeDropdown",
                payload,
                false
            );

            var list = [];
            if (result && result.data && result.data.RM_VendorTypeDropdown) {
                list = result.data.RM_VendorTypeDropdown;
            } else if (result && result.data && Array.isArray(result.data)) {
                list = result.data;
            } else if (result && Array.isArray(result)) {
                list = result;
            }
            if (!Array.isArray(list)) list = [];

            var opts = '<option value="">Select Vendor Type</option>';
            for (var i = 0; i < list.length; i++) {
                var r   = list[i] || {};
                var val = r.vendorTypeID || r.VendorTypeID || r.value || r.Value || "";
                var lbl = r.vendorTypeName || r.VendorTypeName || r.text || r.Text || r.label || r.Label || val;
                if (val !== "") {
                    opts += '<option value="' + escapeVendorGridText(String(val)) + '">' + escapeVendorGridText(String(lbl)) + '</option>';
                }
            }

            var $ddl = $("#ddlVendorType");
            var prevVal = $ddl.val();
            $ddl.html(opts);
            if (prevVal) $ddl.val(prevVal);
            try { $ddl.selectpicker("refresh"); } catch (ex) { }
        }

       
        //Added by vikas T at the time of comparison with W26
        // Added By Vyankat B. on 28th May 2026 for fetching the data
        function AJAXCallWithResult(url, param, async) {
            var result = null;

            var fullUrl = strUrl.replace(/\/$/, '') + '/' + url.replace(/^\//, '');

            $.ajax({
                url: fullUrl,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset=utf-8",

                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    result = data;
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        alertify.set('notifier', 'position', 'top-right');

                        alertify.notify('<%=MyBase.GetResourceString("A_AuthenticationFailed")%>', 'error', 5);

                    } else {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                    }
                }
            });

            if (!async) {
                return result;
            }

            return AjaxResult;
        }
         // End of Added By Vyankat B. on 28th May 2026 for fetching the data
         //Ended by vikas T at the time of comparison with W26
    </script>
</body>
</html>
