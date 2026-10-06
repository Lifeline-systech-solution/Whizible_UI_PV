<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_RequestedResources.aspx.vb" Inherits="Whizible.PM_RequestedResources" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Resource request")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource request</title>--%>

    <!-- Tell the browser to be responsive to screen width -->
    <!--<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">-->
    <%--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
    <link href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <%--alertify Css--%>
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>



    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery -->
     <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>

    <!--datatable_js-->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>

    <!-- alertify -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

    <!--Added for loader-->
    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>

</head>

    <style type="text/css">
        .content {
            padding: 10px;
        }

        .sidebarcontainer_header .row > .col-sm-4 {
            padding-top: 8px;
            display: block;
        }

        div#RRdetailpanel {
            clear: both;
            margin: 40px -10px;
        }

        #txtResourceToDate, #txtResourceFromDate, #cboResourceProjects {
            background-color: white;
        }


        .resourcereqtbl span.idlabel {
            min-width: 60px;
            display: block;
            max-width: 80px;
            margin: 0 auto;
        }

        label.btn.btn-yellow.btn-xs {
            color: #464a4c;
            display: block;
            font-weight: 500;
        }

        a.disabled {
            pointer-events: none;
            cursor: not-allowed;
        }

        .preponereleaseinfo label {
            min-width: 160px;
        }

        .preponereleaseinfo p {
            margin: 0px;
        }

        .subcontainerbody {
            padding: 10px 15px;
        }

        .sidebarcontainer_header .row > .col-sm-4 {
            padding-top: 8px;
            display: block;
        }

        .detailpanelheadlinks ul {
            padding: 0;
            margin: 0;
        }

        .detailpanelheadlinks > ul > li {
            display: inline-block;
            vertical-align: middle;
        }

        .inst-wrap {
            padding: 10px;
            background-color: #f5f5f5;
            font-weight: 500;
            margin: 20px 10px;
        }

            .inst-wrap p {
                margin-bottom: 0px;
            }

        body {
            background: #fff;
        }

        .alertify-notifier {
            z-index: 9999;
        }

        .act-stas-main.disabled + .action-status {
            cursor: no-drop !important;
        }

        .btn-xs {
            width: 100%;
        }

        .ratecardtble tbody tr td.dataTables_empty {
            text-align: center !important;
        }

        label.req-new.required:after {
            position: absolute;
        }
        /*New css added by pradip on 10-12-2019*/

        #RejectCommentsBody tr th, #RejectCommentsBody td {
            padding: 8px;
        }

        #RejectCommentsBody td {
            text-align: left;
        }

        #RejectCommentsBody tr th {
            background: #e7edf0;
        }

        .note-wrap-txt {
            width: 100% !important;
            margin: 0px auto 15px;
            display: block;
        }

        .note-wrap {
            background: #e7edf0;
            padding: 1px 15px 1px;
        }

        /*.fl-right {
            float: right;
        }

        .pad-side-20 {
            padding: 10px 20px;
        }

        .mar-side-20 {
            margin: 20px 30px;
        }

        .mar-20 {
            margin: 0px 20px;
        }

        .mar-15 {
            margin: 10px 15px;
        }*/

        /*new css added by pradip on 08-01-2019*/
        table.dataTable thead .sorting:after, table.dataTable thead .sorting_asc:after, table.dataTable thead .sorting_desc:after {
            margin-left: 6px;
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        #AssignedResourcesTbl th {
            vertical-align: middle;
            min-width: 70px;
        }


        div#RRchangeallocation_Detail {
            min-height: 80vh;
        }

        .content {
    padding: 10px!important;
}
        .btn-xs{font-size:11.5px;margin-bottom:0!important}
        #WarningJDAttachment .modal-content {
            width: 81%;
            height: 249px;
        }

        .borderbtn {
            border-color: white
        }
        /* JD attachment button — prevent long filenames from breaking layout */
        #btndownloadfile span#FILENAME0 {
            display: inline-block;
            max-width: 220px;
            white-space: normal;
            word-break: break-all;
            vertical-align: middle;
            text-align: left;
        }
       .fa-download {
           color:darkgray;
        }

        .fa-paperclip{
            color: darkgray;
        }
        #txtResourceNatureofRequest {
            width: 122px !important;
        }

        #CloseRequestomodal .modal-header {
            display: table-cell;
        }

        #CloseRequestomodal .borderbtn {
                border-color: rgb(19, 89, 166)!important;
        }
        #WarningJDAttachment .modal-header {
            display: inline-block;
        }
        .TopClsNote {
            color:red;
        }
    </style>


<body class="hold-transition fixed" id="RequestBody">

    <div class="wrapper">
        <% If m_blnViewAccess = True Then %>
        <!-- Content Wrapper. Contains page content -->

        <div class="resource_allocation" id="StartRequrstresourceDiv">
            <!-- Content Header (Page header) -->
            <div class="graybg container-fluid pt-1 pb-1">
                <div class="row">
                    <div class="col-sm-12" id="MainResourceRequest">

                        <div class="col-sm-3">
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceProjects", "Select ''",,, "class='form-control'",,, ) %>
                        </div>
                        <div class="col-sm-8 text-right" style="margin: auto;">
                           <span class="TopClsNote">Note : - Open Request(s) will display on the top.</span>
                        </div>
                        <div class="col-sm-1 text-right">
                            <button style="margin-top: 4px;" class="btn borderbtn nobtnstyle-xs canclebtn" id="BackBtn">Back</button>
                        </div>

                    </div>
                </div>
            </div>
            <!-- Main content -->
            <section class="content p-0">
                <!--tablist-->
                <div class="graybg milestonetabheader container-fluid pt-1 pb-1">
                    <div class="row">
                        <div class="col-sm-4">
                            <ul class="nav nav-tabs main_graybgtbs">
                                <li>
                                    <a href="#RRallocationrequest" class="active" rol="tab" data-bs-toggle="tab" onclick="GetRequestedResourcesList(ProjectID);"><%= MyBase.GetResourceString("C_AllocationRequest") %></a>
                                </li>
                                <li class="">
                                    <a href="#RRchangerequest" rol="tab" data-bs-toggle="tab" onclick="GetChangeRequestList();"><%= MyBase.GetResourceString("C_ChangeRequest") %></a>
                                </li>

                            </ul> </div>
                            
                        <div class="col-sm-8">
                            <!-- Added by Dipali V on 6th May 2026 for vendor management - keep all list filters inline in single row -->
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="control-label pr-1"><%= MyBase.GetResourceString("C_RequestStatus") %></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_Sel_RequestStatus",,, "class='form-control' onchange = cboStatus_OnChange()", True,,,, ) %>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label pr-1">Vendor</label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboVendorFilter", "usp_Whizible2_Sel_tbl_Whizible2_VendorMaster_Active",,, "class='form-control' onchange = cboStatus_OnChange()", True,,,, ) %>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label pr-1"><%= MyBase.GetResourceString("C_SearchRequest") %></label>
                                    <div class="input-group add-on" style="width: 150px;">
                                        <input class="form-control input-sm" placeholder="Request ID" name="search" id="txtSearch" onPaste='return false' Autocomplete='off' type="text" onkeypress="return restrictAlphabets(event)">
                                        <div class="input-group-btn">
                                            <button class="btn btn-default" type="submit" style="padding: 4px 6px 7px 6px; height: 30px;"><i onclick="myFunction()" class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--tablist-end-->

                <div class="tab-content mt-1">
                    <div id="RRallocationrequest" class="tab-pane active">
                        <div class="listpanelcontent resizewrap_main">

                            <table class="table bgwhite table-bordered table-fixed-header resourcereqtbl" id="Requestedtbl" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <%--Commented And Added By Usha Pandit On 18.06.2020 For correct heading for Request Id--%>
                                        <%--<th class="reqid"><%= MyBase.GetResourceString("C_RequestID") %></th>--%>
                                        <th class="reqid"> Request ID</th>
                                        <%--End Of Added By Usha Pandit On 18.06.2020 For correct heading for Request Id--%>
                                        <th><%= MyBase.GetResourceString("C_Role") %></th>
                                        <th><%= MyBase.GetResourceString("C_NoOfResources") %></th>
                                        <th id="Prorequestdate"><%= MyBase.GetResourceString("C_RequestDate") %><i class=""></i></th>
                                        <th id="ProFromdate"><%= MyBase.GetResourceString("C_FromDate") %> <i class=""></i></th>
                                        <th id="ProTodate"><%= MyBase.GetResourceString("C_ToDate") %><i class=""></i></th>
                                        <th><%= MyBase.GetResourceString("C_WorksHours") %></th>
                                        <th><%= MyBase.GetResourceString("C_AllocationType") %></th>
                                        <th><%= MyBase.GetResourceString("C_Status") %></th>
                                    </tr>


                                </thead>
                                <tbody id="Requestedtblbody">
                                </tbody>

                            </table>

                            <div class="clearfix"></div>
                        </div>
                    </div>

                    <div id="RRchangerequest" class="tab-pane">
                        <div class="listpanelcontent">
                            <table id="chngresourcereqtbl" class="table bgwhite table-bordered table-fixed-header resourcereqtbl" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <%--Commented And Added By Usha Pandit On 18.06.2020 For correct heading for Request Id--%>
                                        <%--<th width="8%" class="reqid"><%= MyBase.GetResourceString("C_RequestID") %></th>--%>
                                        <th width="8%" class="reqid">Request ID</th>
                                        <%--End Of Added By Usha Pandit On 18.06.2020 For correct heading for Request Id--%>
                                        <th><%= MyBase.GetResourceString("C_EmployeeName") %></th>
                                        <th><%= MyBase.GetResourceString("C_RequestDate") %></th>
                                        <th><%= MyBase.GetResourceString("C_FromDate") %></th>
                                        <th><%= MyBase.GetResourceString("C_ToDate") %></th>
                                        <th><%= MyBase.GetResourceString("C_WorksHours") %></th>
                                        <th><%= MyBase.GetResourceString("C_AllocationType") %></th>
                                        <th><%= MyBase.GetResourceString("C_RequestType") %></th>
                                        <%--<th>No of Resources</th>--%>
                                        <th><%= MyBase.GetResourceString("C_Status") %></th>
                                    </tr>

                                </thead>
                                <tbody id="chngRequestedtblbody">
                                </tbody>

                            </table>

                        </div>
                    </div>


                </div>
                <!--sidebar-panel-->
                <div class="listdetailcontent" id="RRdetailpanel" style="display: none;">

                    <div class="sidebarcontainer_header">
                        <div class="subcontainerbody">
                            <div class="row">
                                <div class="col-sm-6">

                                    <div class="sitename pull-left"><span id="SpanRole"></span></div>
                                    <span class="idlabel ml-1"><span id="SpanRoleId"></span></span>
                                </div>

                                <div class="col-sm-6 text-right detailpanelheadlinks">
                                    <ul>
                                        <!--modified by pradip on 08-01-2020-->
                                        <li>
                                            <button data-bs-toggle="tooltip" data-placement="bottom" data-container="body" data-bs-original-title="Hide Detail panel" class="btn borderbtn pull-right closedetailpanel">
                                                Cancel
                                            </button>
                                        </li>
                                        <li>
                                            <button class="btn btnyellow" id="SendEmail" onclick="SendEmailClick();"><%= MyBase.GetResourceString("C_SendEmail") %></button>
                                        </li>
                                        <%If m_blnEditAccess = True Then %>
                                        <li>
                                            <button class="btn btnyellow" id="SaveRequest" onclick="AddRequestClick();"><%= MyBase.GetResourceString("C_Save") %></button>
                                        </li>
                                        <% End If %>

                                        <li>
                                            <button class="btn btnyellow" id="DeclineComment" onclick="DeclineComment();"><%= MyBase.GetResourceString("C_DeclineRequest") %></button>
                                        </li>

                                        <%If m_blnViewAccess = True Then%>
                                        <li>
                                            <%--<button class="btn btnyellow" id="CloseRequest" onclick="ShowCloseModal();"><%= MyBase.GetResourceString("C_CloseRequest") %></button>--%>
                                            <button class="btn btnyellow" id="CloseRequest" onclick="ShowCloseModal();"><%= MyBase.GetResourceString("C_CloseRequest") %></button>
                                        </li>
                                        <% End If %>
                                    </ul>

                                </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>

                    <div class="formbody">
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-3">
                                    <label class="control-label"><%= MyBase.GetResourceString("C_ProjectRole") %></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceRequestor", "usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo ",,, "class='form-control '",,, ) %>
                                </div>
                                <div class="col-sm-3">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_Type") %></label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceType", "Select ''",,, "class='form-control  '",,, ) %>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_WorksHours") %></label>
                                            <%--<input class="form-control" type="text" placeholder="" name="" id="siteshortname">--%>
                                            <%-- //Commented and added by Chetan M on 14th Jan 2020 for issue id = 21364 --%>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtResourceWorkHours", "txtResourceWorkHours", "form-control",,,,,,,,,, "autocomplete='off' maxlength='4'",,, True,,,, True) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceWorkHours", "txtResourceWorkHours", "form-control",,,,,,,,,, "autocomplete='off' maxlength='6'",,, True,,,, True) %>
                                            <%-- End of Commented and added by Chetan M on 14th Jan 2020 for issue id = 21364 --%>
                                        </div>

                                    </div>

                                </div>
                                <div class="col-sm-3">
                                    <label class="control-label required"><%= MyBase.GetResourceString("C_FromDate") %></label>
                                    <div class="input-group datefielddiv">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceFromDate", "txtResourceFromDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false' ",,, True,,,, True) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <label class="control-label required"><%= MyBase.GetResourceString("C_ToDate") %></label>
                                    <div class="input-group datefielddiv">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceToDate", "txtResourceToDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false' ",,, True,,,, True) %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>


                                <div class="clearfix"></div>
                            </div>

                            <%--Added By Dipali V On 15th Nov 2022 For Sonata Customzation--%>
                             <div class="form-group">
                                <div class="col-sm-3">
                                  <label class="required" id="lblTypeOfReq">Type of Requirement </label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceTypeofRequirement", "usp_Whizible2_Sel_TypeOfRequirement",,, "Onchange='ValidateReEmployeeName(this.value)' class='form-control'",,, ) %>
                                </div>

                                   <div class="col-sm-3">
                                    <div class="row">
                                        
                                           <div class="col-sm-6">
                                           <label class="required" id="lbllocation">Location </label>
                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceLocationID", "usp_Whizible2_Sel_tbl_PM_LocationMaster",,, "class='form-control'",,, ) %>
                                           </div>

                                        <div class="col-sm-6">
                                             <label class="required" id="lbldepartment">Department </label>
                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceDepartmentID", "usp_Whizible2_Sel_tbl_PM_DepartmentMaster",,, "class='form-control'",,, ) %>
                                        </div>
                                    </div>
                                   </div>

                                 <div class="col-sm-3">
                                            <label class="">Replacement Employee Name <span id="spncboRRProjectRepEmployeeName" style="display:none;color:red">*</span></label>
                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceReplacementEmployeeName", "usp_Whizible2_Sel_ProjectAllocateActiveResource " & Session("intProjectID") & "",,, "class='form-control' disabled",,, ) %>
                                        </div>

                                   <div class="col-sm-3">
                                    <div class="row">
                                        <div class="col-sm-12">
                                             <label class="required" id="lblEngagementModel">Engagement Model </label>
                                              <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceEngagementModel", "usp_Whizible2_Sel_EngagementModel",,, "class='form-control'",,, ) %>
                                        </div>
                                       
                                    </div>
                                   </div>
                                 <div class="clearfix"></div>
                             </div>

                            
                            

                              <div class="form-group">
                                   <div class="col-sm-3">
                                    <label class="">Vendor </label>
                                    <% 'Added by Dipali V on 6th May 2026 - Purpose:-Allow optional vendor selection in request raise/edit flow. %>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceVendorID", "usp_Whizible2_Sel_tbl_Whizible2_VendorMaster_Active",,, "class='form-control'",,, ) %>
                                  </div>

                                   <div class="col-sm-3">
                                    <label class="required" id="lblBillablePosition">Billable Position </label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceBillablePosition", "usp_Whizible2_Sel_BillablePosition",,, "Onchange='ValidateBillingStartDate(this.value)' class='form-control'",,, ) %>
                                  </div>

                                    <div class="col-sm-3">
                                    <label class="control-label required" style="white-space:nowrap" id="lblbillingstartdate">Billing Start Date</label>
                                    <div class="input-group datefielddiv">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceBillingStartDate", "txtResourceBillingStartDate", "form-control",,,,,,, True, "White",, "onchange='ValidateNatureofRequest()' autocomplete='off' onPaste='return false' ",,, True,,,, True) %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>


                                   <div class="col-sm-3">
                                    <div class="row">
                                        <div class="col-sm-6">
                                              <label class="required" id="lblSOWAv">SOW Available</label>
                                               <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceSOWAvailable", "usp_Whizible2_Sel_SOWAvailable",,, "onchange='ValidateNatureofRequest()' class='form-control'",,, ) %>
                                        </div>
                                        <div class="col-sm-6">
                                              <label class="" style="white-space:nowrap">Nature of Request</label>
                                              <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceNatureofRequest", "txtResourceNatureofRequest", "form-control",,,,, "",,,,, "autocomplete='off' disabled",,, True,,,, True) %>
                                        </div>
                                    </div>
                                   </div>

                               
                                   <div class="clearfix"></div>
                             </div>


                            <%--End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation--%>



                            <div class="form-group">
                                <div class="col-sm-3">
                                    <%--Commented & Added By Rutuja D. 9 Jan 2020 For Adding New Id--%>
                                    <%--<label class="control-label "><%= MyBase.GetResourceString("C_ResourcePool") %></label>--%>
                                    <label class="control-label " id="lblResourcePool"><%= MyBase.GetResourceString("C_ResourcePool") %></label>
                                    <%--End Commented & Added By Rutuja D. 9 Jan 2020 For Adding New Id--%>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceResourcePool", "Select ''",,, "class='form-control  '",,, ) %>
                                </div>
                                <div class="col-sm-3">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Priority") %></label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourcePriority", "Select ''",,, "class='form-control '",,, ) %>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="control-label req-new required" style="white-space:nowrap"><%= MyBase.GetResourceString("C_NoOfResources") %></label>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceNoOfResources", "txtResourceNoOfResources", "form-control",,,,,,,,,, "autocomplete='off' maxlength='3'",,, True,,,, True) %>
                                        </div>

                                    </div>

                                </div>

                              

                                <div class="col-sm-6">
                                    <label class="control-label"><%= MyBase.GetResourceString("C_SpecialRequest") %></label>
                                    <% CommonFunctions.HTMLControls.DrawTextArea("txtResourceSpecialRequest", "txtResourceSpecialRequest", "Enter Special Request (Maxlenth 300 Char)", "form-control",,,,, , , 300,,,,,,,, "placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete='Off' maxlength='300'",,,,,,,,,,) %>
                                </div>
                               <%-- End of Commented & Added By Dipali V On 15th Nov 2022 For Sonata Customzation--%>
                                <div class="clearfix"></div>
                            </div>


                          
                          
                            <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <label class="control-label" id="lblCloseComment"><%= MyBase.GetResourceString("C_CloseComments") %></label>
                                    <% CommonFunctions.HTMLControls.DrawTextArea("txtResourceCancelComment", "txtResourceCancelComment", "Enter Close Request Comment(Maxlenth 500 Char)", "form-control",,,,, , , 500,,,,,,,, "placeholder='Enter Close Request Comment(Maxlength 500 Char)' autocomplete='Off' maxlength='500'",,,,,,,,,,) %>
                                </div>
                                <div class="col-sm-6">
                                  <div class="attacment-file">
                                     <%--  <label class="col-sm-4 required">JD Attachment</label>--%>
                                       <div class="col-sm-8" style="float:right; padding-left:0" id="DivJDattahcment">
                                              <div class="form-group">
                                              <div id="FileControlUploadDiv" style="float:right">
                                               <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none !important;' class='clsFileControl'", False, True)%>
                                               </div>
                                                    <div class="input-group col-xs-12">
                                                         
                                                         <span class="input-group-btn">
                                                            <button class="btn borderbtn" id="btndownloadfile"  type="button" title="Donwload JD Attachments" data-toggle="tooltip" onclick="DownloadJDAttachement();"><i class="fas fa-download" data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Download"></i> <span id="FILENAME0"></span></button>
                                                             <button class="btn borderbtn" id="btnSelectFile" filecount="0" onclick="Warningattachment();" type="button" title="Upload JD Attachments" data-toggle="tooltip"><i class="fa fa-paperclip mr-1" data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Download"></i></button>
                                                          </span>
                                                   
                                                       </div>
                                                   </div>
                                     
                                            <div id="divAttachments" class="bottom-bar" style="">
                                                <div class="row">
                                                    <div class="col-sm-12 ">
                                                        <table id="tblFiles" style="display: none; width:100%; margin-top: -5%; margin-left:3px" class="clsGridTable table mb-0" >
                                                
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                     </div>
                                  </div>
                                 </div>
                            </div>
                            <% End If %>
                          

                        </div>

                    </div>


                    <div class="formbody">
                        <div class="container-fluid" style="background-color: #e7edf0;">
                            <div class="row pt-1">
                                <div class="col-sm-6">
                                    <h5><%= MyBase.GetResourceString("C_AssignedResources") %></h5>

                                </div>
                                <div class="col-sm-6 text-right">
                                    <h5><%= MyBase.GetResourceString("C_Status") %> : <span id="StatusString"></span></h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%If m_blnViewAccess = True Then%>
                    <div class="table-responsive formbody">
                        <table class="table table-stripped table-bordered ratecardtble bgwhite" id="AssignedResourcesTbl" style="width: 100%;">
                            <!--added table bordered class by pradip on 08-01-2020-->
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_ResourceName") %></th>
                                    <%--Commented & Added By RUtuja D. For Change Caption--%>
                                    <%--<th><%= MyBase.GetResourceString("C_CorporateRole") %></th>--%>
                                    <th><%= MyBase.GetResourceString("C_ProjecRole") %></th>

                                    <%--End Commented & Added By RUtuja D. For Change Caption--%>


                                    <th><%= MyBase.GetResourceString("C_FromDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_ToDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_CurrentLoading") %></th>
                                    <th><%= MyBase.GetResourceString("C_WorkHoursPerDay") %></th>
                                    <th><%= MyBase.GetResourceString("C_Resume") %></th>
                                    <th><%= MyBase.GetResourceString("C_TotalWorkHrs") %></th>
                                    <th><%= MyBase.GetResourceString("C_AllocationPer") %></th>
                                    <%If m_blnDeleteAccess = True Then%>
                                    <th><%= MyBase.GetResourceString("C_Action") %></th>
                                    <% End If %>
                                    <th><%= MyBase.GetResourceString("C_Status") %></th>
                                </tr>
                            </thead>
                            <tbody id="AssignedResourcesTblBody">
                            </tbody>
                        </table>
                    </div>

                    <% Else %>
                    <div id="" class="tab-pane active" style="height: 448px">
                        <div style="text-align: center" class="box box-solid">
                            <p>You are not authorized to view this record. </p>
                        </div>
                    </div>
                    <% End If %>
                </div>
                <!--sidebar-panel-end-->

            </section>
            <!-- Modal -->

            <div class="modal custmodal  fade" id="resourcerequest" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ResourceRequest") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                        </div>

                        <!-- /.content -->

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
            <!--modal-end-here-->

            <!-- Resume Modal -->
            <div class="modal custmodal  fade" id="resumepopupbox" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Resume") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            ...



                        </div>

                        <!-- /.content -->

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
            <!--modal-end-here-->

            <!-- Close Request Modal Start here-->
            <div id="CloseRequestinfomodal" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modalsmall">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><%= MyBase.GetResourceString("C_CloseRequest") %></h4>
                        </div>

                        <div class="modal-body">
                            <span id="TagId"></span>
                            <span id="DeleteId"></span>
                            <span id="DeleteDocumnetId"></span>

                            <%If m_blnViewAccess = False Then%>
                            <p align="center">You are saving Close Request Comment. But you are not authorize to close this request.</p>

                            <% else%>
                            <p align="center">You are saving Close Request Comment. Are you sure you want to close this request ?</p>
                            <% End If %>

                            <%If m_blnViewAccess = True Then%>
                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                        <%-- Commented and added by Chetan M on 12th Jan 2020 for IssueID 21255 --%>
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="UpdateRequest(true);"><%= MyBase.GetResourceString("C_No") %></button>
                                        <%--<button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_No") %></button>--%>
                                        <%-- End of added by Chetan M on 12th Jan 2020 --%>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <%-- Commented and added by Chetan M on 12th Jan 2020 for IssueID 21255 --%>
                                        <button class="btn btnyellow ml-1 pull-right" onclick=" UpdateRequest(false);" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                                        <%--                       <button class="btn btnyellow ml-1 pull-right" onclick=" CloseRequestFunction();" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>--%>
                                        <%-- End of added by Chetan M on 12th Jan 2020 --%>
                                    </div>

                                </div>
                            </div>
                            <% Else %>
                            <div class="form-group mt-4">
                                <div class="row">
                                    <div style="text-align: center">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="UpdateRequest(true);"><%= MyBase.GetResourceString("C_Save") %></button>
                                    </div>

                                </div>
                            </div>
                            <% End If %>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <!-- Close Request Modal End here-->

            <!-- Reject Resources Modal Start here-->
            <div id="RejectRequestinfomodal" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modalsmall">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><%= MyBase.GetResourceString("C_RejectResource") %></h4>
                        </div>

                        <div class="modal-body">

                            <div>
                                <table class="table table-bordered">
                                    <tbody id="RejectCommentsBody" style="align">
                                    </tbody>
                                </table>
                            </div>

                            <div class="form-group">

                                <label class="control-label required"><%= MyBase.GetResourceString("C_RejectComments") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtResourceRejectComment", "txtResourceRejectComment", "Enter Reject Resource Comment (Maxlenth 500 Char)", "form-control",,,,, , , 500,,,,,,,, "placeholder='Enter Reject Resource Comment (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",,,,,,,,,,) %>
                            </div>
                            <div class="clearfix"></div>
                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_No") %></button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <%-- Commented and added by Chetan M on 9th Jan 2020 --%>
                                        <%--<button class="btn btnyellow ml-1 pull-right" onclick="ApplyRejectResource();" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>--%>
                                        <button class="btn btnyellow ml-1 pull-right" onclick="ApplyRejectResource();"><%= MyBase.GetResourceString("C_Yes") %></button>
                                        <%-- End of addded by Chetan M on 9th Jan 2020 --%>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <!--Reject Resources Modal End here-->

            <!-- Close Request Modal Start here-->
            <div id="DeclineRequestinfomodal" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modalsmall">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><%= MyBase.GetResourceString("C_DeclineRequest") %></h4>
                        </div>

                        <div class="modal-body">
                            <div class="note-wrap note-wrap-txt">
                                <h5>Declined Comments	<span class="fl-right">Status: Declined</span></h5>
                            </div>
                            <div class="row form-group">
                                <div class="col-sm-12">
                                    <label>Comments</label>
                                    <% CommonFunctions.HTMLControls.DrawTextArea("txtDeclineComment", "txtDeclineComment", "Enter Special Request (Maxlenth 300 Char)", "form-control",,,,, , , 300,,,,,,,, "placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete='Off' maxlength='300'",,,,,,,,,,) %>
                                </div>
                            </div>
                            <div class="text-center">
                                <button class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></button>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <!-- Close Request Modal End here-->


            <div class="clearfix"></div>

            <!-- Prepone request detail panel start here-->
            <div id="RRpreponerequest_Detail" class="listdetailcontent" style="display: none; margin-top: 40px;">
                <div class="sidebarcontainer_header">
                    <div class="subcontainerbody">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="sitename pull-left"><%= MyBase.GetResourceString("C_PreponeReleaseDetails") %></div>
                            </div>
                            <div class="col-sm-2"></div>
                            <div class="col-sm-6 text-right detailpanelheadlinks">
                                <ul>
                                    <li>
                                        <button data-bs-toggle="tooltip" data-placement="bottom" data-container="body" data-bs-original-title="Hide Detail panel" class="btn borderbtn pull-right closedetailpanel">
                                            <%--<img src="../../../Whizible2.0-new/dist/img/close-gray.svg" alt="" width="16px">--%>
                                            Cancel
                                        </button>
                                    </li>
                                    <% If m_blnEditAccess = True Then %>
                                    <li>
                                        <button class="btn btnyellow" onclick=" SavePreponeRequest();"><%= MyBase.GetResourceString("C_Save") %></button>

                                    </li>
                                    <% End If %>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>

                <div class="formbody">
                    <div class="preponereleaseinfo">
                        <div class="note-wrap note-wrap-txt">
                            <h5>Current Details</h5>
                        </div>
                        <div class="row pad-side-20">

                            <div class="col-sm-6 form-horizontal">
                                <p>
                                    <label><%= MyBase.GetResourceString("C_EmployeeName") %>:</label>
                                    <span id="SpanEmpName"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationStartDate") %>:</label>
                                    <span id="SpanAllstartDate"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationType") %>:</label>
                                    <span id="SpanAllType"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_WorkHoursonProject") %>:</label>
                                    <span id="SpanWHProject"></span>
                                </p>

                            </div>

                            <div class="col-sm-6 form-horizontal">
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationEndDate") %>:</label>
                                    <span id="SpanAllEndDate"></span>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationValue") %>:</label>
                                    <span id="SpanAllValue"></span>
                                </p>

                            </div>


                        </div>
                    </div>
                </div>
                <div class="pad-side-20">
                    <div class="note-wrap note-wrap-txt">
                        <h5>Prepone Release Details</h5>
                    </div>
                    <div class="formbody row">
                        <div class="col-sm-3">
                            <label class="required"><%= MyBase.GetResourceString("C_NewEndDate") %>:</label>
                            <div class="input-group">
                                <%--<input id="PRnewdt" type="text" class="form-control" name="" />--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPrEndDate", "txtPrEndDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false'",,, True,,,, True) %>

                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="inst-wrap mar-15">
                        If you want to change allocation, Please enter the following details
                    </div>
                    <div class="clearfix"></div>
                    <div class="formbody">
                        <div class="row">
                            <div class="col-sm-3">
                                <%--Added and modified by Dipali V On 18th March 2025 to disable controls New % of Day and Effective Date --%>
                                <label class="control-label" id="lblNewPerOfday">:</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPrPerOfDay", "txtPrPerOfDay", "form-control",,,,,,,,,, "autocomplete='off' maxlength='6' disabled",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_EffectiveDate") %>:</label>
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtPrEffeDate", "txtPrEffeDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false' disabled",,, True,,,, True) %>
                                <%--End of Added and modified by Dipali V On 18th March 2025 to disable controls New % of Day and Effective Date --%>
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_NewWorkHours") %>:</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPrNewWorkHour", "txtPrNewWorkHour", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>

                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_SpecialRequest") %>: </label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtPrSpeRequest", "txtPrSpeRequest", "Enter Special Request (Maxlenth 300 Char)", "form-control",,,,, , , 300,,,,,,,, "placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete='Off' maxlength='300'",,,,,,,,,,) %>
                            </div>

                        </div>

                    </div>
                </div>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtPrevAllocationPercentage", "txtPrevAllocationPercentage",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtProjEndDate", "txtProjEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtToday", "txtToday",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtHiddenRequestType", "txtHiddenRequestType",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtEmpID", "txtEmpID",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtTotalWorkHours", "txtTotalWorkHours",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtPercentage", "txtPercentage",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrsPerDay", "txtWorkHrsPerDay",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtReqStartDate", "txtReqStartDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtReqEndDate", "txtReqEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("hiddentxtPrPerOfDay", "hiddentxtPrPerOfDay",, IsHidden:=True, EnableHTMLEncode:=True) %>




                <div class="clearfix"></div>
            </div>
            <!-- Prepone request detail panel end here-->

            <!-- Change request detail panel start here-->
            <div id="RRchangeallocation_Detail" class="listdetailcontent" style="display: none; margin-top: 40px;">
                <div class="sidebarcontainer_header">
                    <div class="subcontainerbody">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="sitename pull-left"><%= MyBase.GetResourceString("C_ChangeAllocation") %></div>
                            </div>
                            <div class="col-sm-2"></div>
                            <div class="col-sm-6 text-right detailpanelheadlinks">
                                <ul>
                                    <!--modified by pradip on 08-01-2020-->
                                    <li>
                                        <button data-bs-toggle="tooltip" data-placement="bottom" data-container="body" data-bs-original-title="Hide Detail panel" class="btn borderbtn pull-right closedetailpanel">
                                            Cancel
                                        </button>
                                    </li>
                                    <% If m_blnEditAccess = True Then %>
                                    <li>
                                        <%--Commented And Added By Reshma on 11th jan 2020 For IssueID-21335--%>
                                        <%-- <button class="btn btnyellow" onclick="UpdateChangeAllocation()"><%= MyBase.GetResourceString("C_Save") %></button></li> --%>
                                        <button class="btn btnyellow" onclick="UpdateChangeAllocation()" id="SaveChangeAllocation"><%= MyBase.GetResourceString("C_Save") %></button></li>
                                    <%--End Added By Reshma on 11th jan 2020 For IssueID-21335--%>
                                    <% End If %>
                                    <%--Added By Rutuja D. 16 Jan 2020 For Reject Request--%>
                                    <li>
                                        <button data-bs-toggle="tooltip" data-placement="bottom" data-container="body" class="btn btnyellow pull-right closedetailpanel" id="cancelRequest" onclick="CancelRequest();">
                                            Cancel Request
                                        </button>
                                    </li>
                                    <%--End Added By Rutuja D. 16 Jan 2020 For Reject Request--%>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>

                <%--Prepone Request Detail Panal--%>
                <div class="formbody">
                    <div class="preponereleaseinfo">
                        <div class="page-main-head">
                            <div class="note-wrap note-wrap-txt">
                                <h5><%= MyBase.GetResourceString("C_CurrentDetails") %></h5>
                            </div>
                        </div>
                        <div class="row pad-side-20">
                            <div class="col-sm-6 form-horizontal">
                                <p>
                                    <label><%= MyBase.GetResourceString("C_EmployeeName") %>:</label>
                                    <span id="SpanChngEmpName"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationStartDate") %>:</label>
                                    <span id="SpanChngAllstartDate"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationType") %>:</label>
                                    <span id="SpanChngAllType"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_WorkHoursonProject") %>:</label>
                                    <span id="SpanChngWHProject"></span>
                                </p>
                            </div>
                            <div class="col-sm-6 form-horizontal">
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationEndDate") %>:</label>
                                    <span id="SpanChngAllEndDate"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationValue") %>:</label>
                                    <span id="SpanChngAllValue"></span>
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
                <%--END Prepone Request Detail Panal--%>

                <%--Change Allocation Detail Panal--%>
                <%--Added By Reshma om 11th Jan 2020 For IssueID-21325--%>
                <div id="Divchangedetails">
                    <%--Added By Reshma om 11th Jan 2020 For IssueID-21325--%>
                    <div class="formbody">
                        <div class="note-wrap note-wrap-txt">
                            <h5><%= MyBase.GetResourceString("C_ChangeAllocationDetails") %></h5>
                        </div>
                        <div class="row pad-side-20">
                            <div class="col-sm-3">
                                <label class="control-label required" id="LblChngAllPerDay">:</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtChngNewPerDay", "txtChngNewPerDay", "form-control",,,,,,,,,, "autocomplete='off' maxlength='6'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label required"><%= MyBase.GetResourceString("C_EffectiveFromDate") %>:</label>
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtChngEffeDate", "txtChngEffeDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false' ",,, True,,,, True) %>

                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_NewWorkHours") %>:</label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtChngNewWorkHour", "txtChngNewWorkHour", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_SpecialRequest") %>:</label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtChngSpecialRequest", "txtChngSpecialRequest", "Enter Special Request (Maxlenth 300 Char)", "form-control",,,,, , , 300,,,,,,,, "placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete='Off' maxlength='300'",,,,,,,,,,) %>
                            </div>
                        </div>
                    </div>
                    <%--Added By Reshma om 11th Jan 2020 For IssueID-21325--%>
                </div>
                <%--//End Added By Reshma om 11th Jan 2020 For IssueID-21325--%>
                <%--Change Allocation Detail Panal--%>



                <%CommonFunctions.HTMLControls.DrawTextBox("txtChngEndDate", "txtChngEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtChngStartDate", "txtChngStartDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtChngReqWorkHours", "txtChngReqWorkHours",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtChngHours", "txtChngHours",, IsHidden:=True, EnableHTMLEncode:=True) %>
                <%CommonFunctions.HTMLControls.DrawTextBox("txtChngReqEndDate", "txtChngReqEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>


                <div class="clearfix"></div>
            </div>
            <!-- Change request detail panel end here-->

            <%--Extend Request Detail Panal--%>
            <div id="RRExtendRequest_Detail" class="listdetailcontent" style="display: none; margin-top: 40px;">
                <div class="sidebarcontainer_header">
                    <div class="subcontainerbody">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="sitename pull-left"><%= MyBase.GetResourceString("C_ExtendedBooking") %></div>
                            </div>
                            <div class="col-sm-2"></div>
                            <div class="col-sm-6 text-right detailpanelheadlinks">
                                <ul>
                                    <!--modified by pradip on 08-01-2020-->
                                    <li>
                                        <button data-bs-toggle="tooltip" data-placement="bottom" data-container="body" data-bs-original-title="Hide Detail panel" class="btn borderbtn pull-right closedetailpanel">
                                            Cancel
                                        </button>
                                    </li>
                                    <% If m_blnEditAccess = True Then %>
                                    <li>
                                        <%--  Commented And Added By Reshma on 13th jan 2020--%>
                                        <%--<button class="btn btnyellow" onclick="UpdateExtendedRequest()">Save</button>--%>
                                        <button class="btn btnyellow" onclick="UpdateExtendedRequest()" id="btnExtendedRequest">Save</button>
                                        <%-- End Added By Reshma on 13th jan 2020--%>

                                    </li>
                                    <% End If %>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="formbody">
                    <div class="preponereleaseinfo">
                        <div class="note-wrap note-wrap-txt">
                            <h5><%= MyBase.GetResourceString("C_CurrentDetails") %></h5>
                        </div>
                        <div class="row pad-side-20">
                            <div class="col-sm-6 form-horizontal">
                                <p>
                                    <label><%= MyBase.GetResourceString("C_EmployeeName") %>:</label>
                                    <span id="SpanExtEmpName"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationStartDate") %>:</label>
                                    <span id="SpanExtAllstartDate"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationType") %>:</label>
                                    <span id="SpanExtPerDay"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_WorkHoursonProject") %>:</label>
                                    <span id="SpanExtWHProject"></span>
                                </p>
                            </div>
                            <div class="col-sm-6 form-horizontal">
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationEndDate") %>:</label>
                                    <span id="SpanExtAllEndDate"></span>
                                </p>
                                <p>
                                    <label><%= MyBase.GetResourceString("C_AllocationValue") %>:</label>
                                    <span id="SpanExtAllovalue"></span>
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
                <%--Added By Reshma on 20th Jan 2020 For IssueID-21335--%>
                <div id="DivExtendRequestDetails">
                    <%--End Added By Reshma on 20th Jan 2020 For IssueID-21335--%>
                    <div class="formbody">
                        <div class="note-wrap note-wrap-txt">
                            <h5><%= MyBase.GetResourceString("C_ExtendedRequestDetails") %></h5>
                        </div>
                        <div class="row pad-side-20">
                            <div class="col-sm-3">
                                <label class="control-label required"><%= MyBase.GetResourceString("C_NewEndDate") %>:</label>
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtExtResourceFromDate", "txtExtResourceFromDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false' ",,, True,,,, True) %>
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="inst-wrap">
                            <p>If you want to change allocation, please enter following details</p>
                        </div>
                        <div class="row pad-side-20">
                            <div class="col-sm-3">
                                <label class="control-label required"><%= MyBase.GetResourceString("C_NewAllocation") %>: </label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtExtResourceNewAllocation", "txtExtResourceNewAllocation", "form-control",,,,, "width:77%; display:inline-block",,,,, "autocomplete='off' maxlength='6'",,, True,,,, True) %>
                                <span id="SpanExtNewAllocation"></span>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_NewTotalWorkHours") %>: </label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtExtResourceNewWorkHours", "txtExtResourceNewWorkHours", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label required"><%= MyBase.GetResourceString("C_NewEffectiveDate") %>: </label>
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtExtResourceToDate", "txtExtResourceToDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false' ",,, True,,,, True) %>

                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_SpecialRequest") %>: </label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtExtResourceSpecialRequest", "txtExtResourceSpecialRequest", "Enter Special Request (Maxlenth 300 Char)", "form-control",,,,, , , 300,,,,,,,, "placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete='Off' maxlength='300'",,,,,,,,,,) %>
                            </div>
                        </div>
                    </div>
                    <%--Added By Reshma on 20th Jan 2020 For IssueID-21335--%>
                </div>
                <%--Added By Reshma on 20th Jan 2020 For IssueID-21335--%>
                <div class="clearfix"></div>
            </div>
            <%--END Extend Request Detail Panal--%>

            <!--confrimation modal start here -->
            <div class="modal custmodal fade" id="confirmationmodal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="HResourceSite"><%= MyBase.GetResourceString("C_ConfirmationAlert") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>"You can not Prepone release this resource with Extra Hrs requirement as Resource is not free"</p>
                            <br />
                            <br />
                            <p id="AlertMsg"></p>
                            <br />
                            <div class="text-center">
                                <a href="javascript:;" data-bs-dismiss="modal" class="btn btnyellow">OK</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- confrimation modal -->


            <!-- Close Request Comment Modal Start here-->
            <div id="CloseRequestomodal" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modalsmall">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><%= MyBase.GetResourceString("C_CloseRequest") %></h4>
                        </div>

                        <div class="modal-body">

                            <p align="center">Do you really want to close the 'Resource Request' ?</p>
                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_No") %></button>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="CloseRequest();" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                                    </div>

                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <!-- Close Request Comment Modal End here-->

             <!--confrimation modal start here -->
            <div class="modal custmodal fade" id="WarningJDAttachment" aria-hidden="true" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Warning</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>JD Attachment already present, Do you want to replace it?</p>
                            <p>Then Select The File And <B>[Save]</B> The Request</p>
                        
                            <p id="AlertMsgWarningJDAttachment"></p>
                            <br />
                            <div class="text-center">
                                <a href="javascript:;"  class="btn btnyellow" onclick="SelectFile();">Yes/Select</a>
                                <a href="javascript:;" data-bs-dismiss="modal" class="btn btnyellow">No</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <!-- /.content-wrapper -->
        <% Else %>
        <div id="NotAuthorized">
            <br />
            <br />
            <center><h4>You are not authorized to view this record. </h4></center>
        </div>
        <% End If %>
    </div>

    <!-- ./wrapper -->



    <script>

        //dynamically set height
        function resizeSection(tag) {
            //var tblhieght = $(window).height();
            //$('#contentfull .table-outer').css({ 'height': tblhieght - 155, "overflow-y": "auto" });

            // var tblouterhieght = $(window).height();
            //$('.resizewrap_main').css({ 'height': tblouterhieght - 140, "overflow-y": "auto" });

            var tblbodyheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblbodyheight - 250, "overflow-y": "auto" });

        }



        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });






        //datepicker
        $('#txtResourceToDate, #txtResourceFromDate, #txtPrEffeDate, #txtPrEndDate, #txtToday, #txtChngEffeDate,#txtExtResourceFromDate,#txtExtResourceToDate,#txtResourceBillingStartDate').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'
        });


    </script>
    <!--filter-table-->



    <script>

     
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        var SessionProjectID = "";
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var ajaxResult = "";
        var SessionProjectName = "";
        var ProjectID = "";
        var Parameters = "";
        var RequestID = "";
        var RestrictByMinHours = "";
        var MinHoursForDAEntry = "";
        var ObjRequestValues = [];
        var EmployeeID = "";
        var AddAccess = "<%=m_blnAddAccess%>";
        var EditAccess = "<%=m_blnEditAccess%>";
        var DeleteAccess = "<%=m_blnDeleteAccess%>";
        var ViewAccess = "<%=m_blnViewAccess%>";
        var ProjectName = "";
        var ChngEmployeeID = "";
        var ProjectEmployeeRoleID = "";
        var GlobalRequestType = "";
        m_OldAllocation = "";
        Priority = "";
        var RequestType = "";
        var ResourcePoolIsMandatory = "";
        /* Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/
        var Count_Request_ResourceSkill = '<%=Count_Request_ResourceSkill%>';
        var IsRequestResourceSkillMandatory = '<%=IsRequestResourceSkillMandatory%>';
        var IsResourceSkillCoreCompetencyMandatory = '<%=IsResourceSkillCoreCompetencyMandatory%>';
        var IsResourceRequestsplittingbased = '<%=IsResourceRequestsplittingbased%>';
        var IsResourceRequestNewFieldsManatory = '<%=IsResourceRequestNewFieldsManatory%>';
        /* End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/

        var selectedAddedDate = "";
        //Added by Dipali V on 6th May 2026 for vendor management - bind request vendor filter and request vendor dropdown from API
        function FillVendorFilterDropdown() {
            var currentProjectID = parseInt($("#cboResourceProjects").find(':selected').val(), 10) || 0;
            var requestParameters = { IncludeVendorID: 0, ProjectID: currentProjectID };
            var vendorResult = AJAXCallWithResult("/api/PM_RequestedResources/GetVendorDropdown", JSON.stringify(requestParameters), false);
            var ddl = $("#cboVendorFilter");
            ddl.empty();
            ddl.append($("<option/>", { value: "0", text: "Select Vendor" }));
            if (vendorResult != null) {
                for (var i = 0; i < vendorResult.length; i++) {
                    ddl.append($("<option/>", { value: vendorResult[i].VendorID, text: vendorResult[i].VendorName }));
                }
            }
            ddl.val("0");
        }
        //Added by Dipali V on 6th May 2026 for vendor management - include mapped inactive vendor in edit dropdown, active only for normal load
        function FillRequestVendorDropdown(includeVendorID, selectedVendorID) {
            var currentProjectID = parseInt($("#cboResourceProjects").find(':selected').val(), 10) || 0;
            var requestParameters = { IncludeVendorID: includeVendorID || 0, ProjectID: currentProjectID };
            var vendorResult = AJAXCallWithResult("/api/PM_RequestedResources/GetVendorDropdown", JSON.stringify(requestParameters), false);
            var ddl = $("#cboResourceVendorID");
            ddl.empty();
            ddl.append($("<option/>", { value: "0", text: "Select Vendor" }));
            if (vendorResult != null) {
                for (var i = 0; i < vendorResult.length; i++) {
                    ddl.append($("<option/>", { value: vendorResult[i].VendorID, text: vendorResult[i].VendorName }));
                }
            }
            ddl.val((selectedVendorID || 0).toString());
        }
        $(document).ready(function () {
           // debugger;
            //Added by Omkar T on 10-01-2020
            $(".modal").scroll(function () {
                $('#ui-datepicker-div').hide();
            });
            Parameters = getParameters();
            SessionProjectID = unescape(Parameters["ProjectID"]);
            SessionProjectName = unescape(Parameters["ProjectName"]);
            //var selsHTML = ('<option value=' + SessionProjectID + ' >' + SessionProjectName + '</option>');

            const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            const today = new Date();
            today.setDate(today.getDate() + 30);
            const yyyy = today.getFullYear();
            let mm = month[today.getMonth()]; // Months start at 0!
            let dd = today.getDate();

            if (dd < 10) dd = '0' + dd;
            if (mm < 10) mm = '0' + mm;
            const formattedToday = dd + ' ' + mm + ' ' + yyyy;
            $("#txtResourceBillingStartDate").val(formattedToday);
            selectedAddedDate = formattedToday;


            /* Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/
            if (IsResourceRequestNewFieldsManatory == 0 || IsResourceRequestNewFieldsManatory == "False") {
                $("#lblTypeOfReq").removeClass("required");
                $("#spncboRRProjectRepEmployeeName").css("display", "none");
                $("#lbldepartment").removeClass("required");
                $("#lbllocation").removeClass("required");
                $("#lblEngagementModel").removeClass("required");
                $("#lblBillablePosition").removeClass("required");
                $("#lblSOWAv").removeClass("required");
                $("#spnRRillingStartDate").css("display", "none");
                $("#SpnJDMandatory").css("display", "none");
            }
            /* End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/


            FillProjectCombox();
            //debugger;
            FillVendorFilterDropdown();
            FillRequestVendorDropdown(0, 0);
            
            $('#txtToday').datepicker('setDate', new Date());
            $("#cboResourceProjects").change(function () {

                ProjectID = $(this).find(':selected').val();
                ProjectName = $('#cboResourceProjects option:selected').text();
                FillVendorFilterDropdown();
                FillRequestVendorDropdown(0, 0);
                //debugger;
                GetRequestedResourcesList(ProjectID);
                GetChangeRequestList();
                //$("#RRdetailpanel").hide('fast');
                //$("td.reqid.sorting_1,.milestonetabheader ").css('pointer-events', 'auto');
                //$("td.reqid").css('pointer-events', 'auto');


                //$($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();

            });
           
            GetPriority();
            GetResourcePool();
            //GetResourceType();
         

        });
    </script>
    <script>
        //Added By Riddhesh Patil on 18-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        //Project Drop Down Binding
        function FillProjectCombox() {
            var sessionproj = 0;
            sessionproj = SessionProjectID;
            if (SessionProjectID == "") {
                sessionproj = 0;
            }

            var RequestParameters = {
                UserID: encodeURI(UserID),
                ProjectID: encodeURI(sessionproj),
                LoginType: encodeURI(LoginType)
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetProjectID", param, false);

            var objCbo1 = document.getElementById("cboResourceProjects");
            $("#cboResourceProjects option").remove();

            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {

                    var ObjAccessProj = strResult[i];

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);

                    if (SessionProjectID == ObjAccessProj.ProjectID) {
                        objOption.text = ObjAccessProj.ProjectName;
                        objOption.value = ObjAccessProj.ProjectID;
                    }
                    else {
                        objOption.text = ObjAccessProj.ProjectName;
                        objOption.value = ObjAccessProj.ProjectID;
                    }
                    if (ObjAccessProj.ProjectID == "0") {
                        objOption.text = "Select Project";
                    }
                }
            }

            if (SessionProjectID != null && SessionProjectID != undefined && SessionProjectID != "") {
                //$("#cboProjects").val(SessionProjectID);
                jQuery("select#cboResourceProjects option[value=" + SessionProjectID + " ]").attr("selected", "selected");
                ProjectID = SessionProjectID;
                GetRequestedResourcesList(ProjectID);
            }
        }

        //Resquest QueryString Parameter
        function getParameters() {

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

        var GlobalSelectedStatus = "";
        //Displying Detail Panel
        //Commented & Added By Rutuja D. 15 Jan 2020 For Get New Parameter Status 
        //function RequestIDClick(EditEmployeeID, EditProjectEmployeeRoleID, EditRequestID, EditRequestType) {
        function RequestIDClick(EditEmployeeID, EditProjectEmployeeRoleID, EditRequestID, EditRequestType, Status) {
            //End Commented & Added By Rutuja D. 15 Jan 2020 For Get New Parameter Status
            //debugger;
            $('[data-toggle="tooltip"]').tooltip();
            ProjectEmployeeRoleID = EditProjectEmployeeRoleID;
            RequestID = EditRequestID;
            ChngEmployeeID = EditEmployeeID;
           // debugger;
             RequestType = unescape(EditRequestType).trim();
            var selectedRequestStatus = unescape(Status).trim();
            GlobalSelectedStatus = selectedRequestStatus;
            if (RequestType == 'Change Allocation') {
                $("#RRdetailpanel").hide('fast');
                $("#RRchangeallocation_Detail").show('fast');
                $('html, body').animate({
                    scrollTop: $("#RRchangeallocation_Detail").offset().top -= 60
                }, 500);
                if ($('#RRchangeallocation_Detail').is(':visible')) {
                    $(".dataTables_paginate ").css("pointer-events", "none");
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                    //$("#MainResourceRequest").css("pointer-events", "none");
                    $("#cboResourceProjects").prop('disabled', true);
                    $("#BackBtn").prop('disabled', true);

                }
                GetResourceType(RequestID);
                EditChangeAllocation(EditProjectEmployeeRoleID, RequestID);
            }
            else if (RequestType == 'Prepone Requests') {
                $("#RRdetailpanel").hide('fast');
                $("#RRpreponerequest_Detail").show('fast');
                $('html, body').animate({
                    scrollTop: $("#RRpreponerequest_Detail").offset().top -= 60
                }, 500);
                if ($('#RRpreponerequest_Detail').is(':visible')) {
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                    $(".dataTables_paginate ").css("pointer-events", "none");
                    //$("#MainResourceRequest").css("pointer-events", "none");
                    $("#cboResourceProjects").prop('disabled', true);
                    $("#BackBtn").prop('disabled', true);
                }
                GetResourceType(RequestID);
                EditPreponeRequest(EditProjectEmployeeRoleID, RequestID);
            }
            else if (RequestType == 'Extend Requests') {
                //Commented By Rutuja D. 15 Jan 2020 For Conditionally plot Panal 
                //$("#RRdetailpanel").hide('fast');
                //$("#RRExtendRequest_Detail").show('fast');
                //End Commented By Rutuja D. 15 Jan 2020 For Conditionally plot Panal

                //Commented & Added By Rutuja D. 15 Jan 2020 For Status is Ready for Assignment that RRdetailpanel Show
                //  EditExtendRequest(EditEmployeeID, EditProjectEmployeeRoleID, EditRequestID)
                if (selectedRequestStatus == 'Ready for Assignment') {
                    $("#RRdetailpanel").show('fast');
                    $("#RRExtendRequest_Detail").hide('fast');
                    //$("#RRdetailpanel").show('fast');
                    $('html, body').animate({
                        scrollTop: $("#RRdetailpanel").offset().top -= 60
                    }, 500);
                    GetResourceType(RequestID);
                    EditRequestResource(RequestID, RequestType);

                    if ($('#RRdetailpanel').is(':visible')) {
                        $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                        $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                        $(".dataTables_paginate ").css("pointer-events", "none");
                        // $("#MainResourceRequest").css("pointer-events", "none");
                        $("#cboResourceProjects").prop('disabled', true);
                        $("#BackBtn").prop('disabled', true);
                    }
                }
                else if (selectedRequestStatus == 'Closed') {
                    $("#RRdetailpanel").show('fast');
                    $("#RRExtendRequest_Detail").hide('fast');
                    $("#RRdetailpanel").show('fast');
                        $('html, body').animate({
                            scrollTop: $("#RRdetailpanel").offset().top -= 60
                        }, 500);
                    GetResourceType(RequestID);
                    EditRequestResource(RequestID, RequestType);

                    if ($('#RRdetailpanel').is(':visible')) {
                        $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                        $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                        $(".dataTables_paginate ").css("pointer-events", "none");
                        // $("#MainResourceRequest").css("pointer-events", "none");
                        $("#cboResourceProjects").prop('disabled', true);
                        $("#BackBtn").prop('disabled', true);
                    }
                } else {
                    $("#RRdetailpanel").hide('fast');
                    $("#RRExtendRequest_Detail").show('fast');
                    $('html, body').animate({
                        scrollTop: $("#RRExtendRequest_Detail").offset().top -= 60
                    }, 500);
                    GetResourceType(EditRequestID);
                    EditExtendRequest(EditEmployeeID, EditProjectEmployeeRoleID, EditRequestID)

                    if ($('#RRExtendRequest_Detail').is(':visible')) {
                        $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                        $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                        $(".dataTables_paginate ").css("pointer-events", "none");
                        //$("#MainResourceRequest").css("pointer-events", "none");
                        $("#cboResourceProjects").prop('disabled', true);
                        $("#BackBtn").prop('disabled', true);

                    }
                }
                //End Commented & Added By Rutuja D. 15 Jan 2020 For Status is Ready for Assignment that RRdetailpanel Show
                 //$("#RRExtendRequest_Detail").show('fast');
                
            }
            else {

                $("#RRdetailpanel").show('fast');
                $('html, body').animate({
                    scrollTop: $("#RRdetailpanel").offset().top -= 60
                }, 500);
                if ($('#RRdetailpanel').is(':visible')) {
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                    $(".dataTables_paginate ").css("pointer-events", "none");
                    // $("#MainResourceRequest").css("pointer-events", "none");
                    $("#cboResourceProjects").prop('disabled', true);
                    $("#BackBtn").prop('disabled', true);
                }
                GetResourceType(RequestID);
                EditRequestResource(RequestID, RequestType);
            }
             setTimeout(function(){
        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
            }, 350);  //Added by pradip on 17-01-2020


           
        }

         //New code added by pradip on 17-01-2020 for disabled and enabled table


         $('#chngresourcereqtbl').on('draw.dt', function () {
            
            if ($('#RRpreponerequest_Detail').is(':visible')) {
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                    $(".dataTables_paginate ").css("pointer-events", "none");
                       //$("#MainResourceRequest").css("pointer-events", "none");
                       $("#cboResourceProjects").prop('disabled', true);
                    $("#BackBtn").prop('disabled', true);
            }
             else if ($('#RRExtendRequest_Detail').is(':visible')) {
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                    $(".dataTables_paginate ").css("pointer-events", "none");
                       //$("#MainResourceRequest").css("pointer-events", "none");
                       $("#cboResourceProjects").prop('disabled', true);
                    $("#BackBtn").prop('disabled', true);
            }
                 else if ($('#RRchangeallocation_Detail').is(':visible')) {
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                    $(".dataTables_paginate ").css("pointer-events", "none");
                       //$("#MainResourceRequest").css("pointer-events", "none");
                       $("#cboResourceProjects").prop('disabled', true);
                    $("#BackBtn").prop('disabled', true);
            }
                else if ($('#RRdetailpanel').is(':visible')) {
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "none");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                    $(".dataTables_paginate ").css("pointer-events", "none");
                       //$("#MainResourceRequest").css("pointer-events", "none");
                       $("#cboResourceProjects").prop('disabled', true);
                    $("#BackBtn").prop('disabled', true);
                }

            else {
                    $("td.reqid.sorting_1,.milestonetabheader ").css("pointer-events", "auto");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "auto");
                    $(".dataTables_paginate ").css("pointer-events", "auto");
                       //$("#MainResourceRequest").css("pointer-events", "none");
                       $("#cboResourceProjects").prop('disabled', false);
                    $("#BackBtn").prop('disabled', false);

                }

        });

         $('#Requestedtbl').on('draw.dt', function () {
           
            if ($('#RRdetailpanel').is(':visible')) {
                $("td.reqid.sorting_1,.milestonetabheader").css("pointer-events", "none");
                $("td.reqid,.milestonetabheader ").css("pointer-events", "none");
                $(".dataTables_paginate ").css("pointer-events", "none");
                // $("#MainResourceRequest").css("pointer-events", "none");
                $("#cboResourceProjects").prop('disabled', true);
                $("#BackBtn").prop('disabled', true);

            }
            //else {
            //        $("td.reqid.sorting_1,.milestonetabheader, .RreqID ").css("pointer-events", "auto");
            //        $("td.reqid,.milestonetabheader ").css("pointer-events", "auto");
            //        $(".dataTables_paginate ").css("pointer-events", "auto");
            //          // $("#MainResourceRequest").css("pointer-events", "none"); 
            //           $("#cboResourceProjects").prop('disabled', false);
            //        $("#BackBtn").prop('disabled', false);

            //    }
    //This will get called when data table data gets redrawn to the      table.
        });

        //New code End added by pradip on 17-01-2020 for disabled and enabled table





        //////////////////////////////////////////// Extend Booking///////////////////////////////////////////////////////////

        function EditExtendRequest(EmployeeID, ProjectEmployeeRoleID, RequestID) {
            StartLoader("#RequestBody");
            if (ProjectEmployeeRoleID != 0) {
                GetCurrentAllocationDetails(EmployeeID, ProjectEmployeeRoleID, RequestID);

            }
            if (m_strType == "TH") {
                var ConvertDecimalToHourViceVersa = m_dblTotalWorkHrs;
            } else if (m_strType == "P") {
                var ConvertDecimalToHourViceVersa = m_dblPercentage;
            } else {
                var ConvertDecimalToHourViceVersa = m_dblWorkHrsPerDay;
            }

            var RequestParameters = {
                WorkHrs: encodeURI(ConvertDecimalToHourViceVersa),
                Flag: encodeURI(1),
            }
            var param = JSON.stringify(RequestParameters);
            var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

            var RequestParameters = {
                WorkHrs: encodeURI(m_dblTotalWorkHrs),
                Flag: encodeURI(1),
            }
            var param = JSON.stringify(RequestParameters);
            var dblTotalWorkHrs = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

            //Commented And Added By Reshma on 12th Jan 2020 For IssueID-21335
            //$("#SpanExtEmpName").text(strEmployeeName);
            //$("#txtEmpID").val(m_intEmployeeID);
            //$("#SpanExtAllstartDate").text(strCurrentStartDate);
            //$("#txtStartDate").val(strCurrentStartDate);
            //$("#SpanExtAllEndDate").text(strCurrentEndDate);
            //$("#txtEndDate").val(strCurrentEndDate);
            if (m_strStatus.trim() != "A") {

                $("#Divchangedetails").hide();
                $("#btnExtendedRequest").show();
                $("#DivPreponerequestDetails").show();

                $("#SpanExtEmpName").text(strEmployeeName);
                $("#txtEmpID").val(m_intEmployeeID);
                $("#SpanExtAllstartDate").text(strCurrentStartDate);
                $("#txtStartDate").val(strCurrentStartDate);
                $("#SpanExtAllEndDate").text(strCurrentEndDate);
                $("#txtEndDate").val(strCurrentEndDate);

            }
            else {
                $("#Divchangedetails").hide();
                $("#btnExtendedRequest").hide();
                $("#DivPreponerequestDetails").hide();

                $("#SpanExtEmpName").text(strEmployeeName);
                $("#txtEmpID").val(m_intEmployeeID);
                $("#SpanExtAllstartDate").text(strCurrentStartDate);
                $("#txtStartDate").val(strCurrentStartDate);
                $("#SpanExtAllEndDate").text(strCurrentEndDate);
                $("#txtEndDate").val(strCurrentEndDate);

            }
            //End Added By Reshma on 12th Jan 2020 For IssueID-21335

            if (m_strType == "TH") {
                $("#SpanExtPerDay").text("Total Hours");
                //Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                var RequestParameters = {
                               WorkHrs: encodeURI(m_dblPrevTotalWorkHrs),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
                m_dblPrevTotalWorkHrs = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
             //End of Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                $("#SpanExtAllovalue").text(m_dblPrevTotalWorkHrs + " Hrs");
                $("#txtExtResourceNewAllocation").val(NewAllocationValue);
                $("#SpanExtNewAllocation").text(" Hrs");
                //Added By reshma on 29th Dec 2021 for Showing blank value for Extend Request

                // $("#DivtxtExtResourceNewWorkHours").hide();
                 $("#txtExtResourceNewWorkHours").val(m_dblPrevTotalWorkHrs);                
                //End of Added By reshma on 29th Dec 2021 for Showing blank value for Extend Request
            }
            else if (m_strType == "P") {
                //Added By reshma on 29th Dec 2021 for Showing blank value for Extend Request
               // $("#DivtxtExtResourceNewWorkHours").show();
                //End of Added By reshma on 29th Dec 2021 for Showing blank value for Extend Request
                $("#SpanExtPerDay").text("% Of Day");
                $("#SpanExtAllovalue").text(m_dblPrevPercentage + " %");
                $("#txtExtResourceNewAllocation").val(m_dblPercentage);
                $("#SpanExtNewAllocation").text(" %");
                $("#txtExtResourceNewWorkHours").val(dblTotalWorkHrs);
                //$("#txtExtResourceNewWorkHours").val(NewAllocationValue);
            } else {
                //Added By reshma on 29th Dec 2021 for Showing blank value for Extend Request
                //$("#DivtxtExtResourceNewWorkHours").show();
                //End of Added By reshma on 29th Dec 2021 for Showing blank value for Extend Request
                $("#SpanExtPerDay").text("Per Day");
                //Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                var RequestParameters = {
                               WorkHrs: encodeURI(m_dblPrevWorkHrsPerDay),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
                m_dblPrevWorkHrsPerDay = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                //End of Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                $("#SpanExtAllovalue").text(m_dblPrevWorkHrsPerDay + " Hrs/Day");
                //$("#txtExtResourceNewAllocation").val(dblTotalWorkHrs);
                //$("#SpanExtNewAllocation").text(" Hrs/Day");
                //Commented And Added By Reshma on 12th Jan 2020
                ////$("#txtExtResourceNewWorkHours").val(m_dblTotalWorkHrs);
                //$("#txtExtResourceNewWorkHours").val(NewAllocationValue);
                //$("#txtExtResourceNewAllocation").val(dblTotalWorkHrs);
                $("#SpanExtNewAllocation").text(" Hrs/Day");
                $("#txtExtResourceNewWorkHours").val(dblTotalWorkHrs);
                $("#txtExtResourceNewAllocation").val(NewAllocationValue);
                //Commented And Added By Reshma on 12th Jan 2020
            }

            if (dblCurrentHours == '' || dblCurrentHours == null || dblCurrentHours == undefined) {
                dblCurrentHours = 0;
            }
            else {
                dblCurrentHours = dblCurrentHours;
            }
            //Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                var RequestParameters = {
                               WorkHrs: encodeURI(dblCurrentHours),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
                dblCurrentHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
             //End of Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471



            $("#SpanExtWHProject").text(dblCurrentHours);
            $("#txtExtResourceFromDate").val(m_strRequestedEndDate);
            $("#txtReqEndDate").val(m_strRequestedEndDate);
            $("#txtExtResourceToDate").val(m_strRequestedStartDate);
            $("#txtReqStartDate").val(m_strRequestedStartDate);

            $("#txtTotalWorkHours").val(m_dblTotalWorkHrs);
            $("#txtProjEndDate").val(ProjectDate);

            $("#txtExtResourceSpecialRequest").val(m_strSpecialRequest);
            $("#txtPercentage").val(m_dblPercentage);

            $("#txtWorkHrsPerDay").val(m_dblWorkHrsPerDay);
            $("#txtExtResourceNewWorkHours").prop("disabled", true);
            StopAjaxLoader("#RequestBody");
			$('html, body').animate({
            scrollTop: $("#RRExtendRequest_Detail").offset().top -= 60
        }, 500);
        }

        var strCurrentStartDate = "";
        var strCurrentEndDate = "";
        var strCurrentResourcePercentage = "";
        var dblCurrentHours = "";
        var strEmployeeName = "";
        var m_intEmployeeID = "";
        var m_strRequestedStartDate = "";
        var intRoleID = "";
        var intResourcepoolID = "";
        var m_intResourcepoolID = "";
        var m_strRequestedEndDate = "";
        var m_strSpecialRequest = "";
        var m_intPriority = "";
        var m_strStatus = "";
        var m_dblWorkHrsPerDay = "";
        var m_dblTotalWorkHrs = "";
        var m_dblPercentage = "";
        var m_strType = "";
        var m_RequestType = "";
        var m_strRequestDate = "";
        var m_intProjectEmployeeRoleId = "";
        var strProjectID = "";
        var m_dblPrevWorkHrsPerDay = "";
        var m_dblPrevTotalWorkHrs = "";
        var m_dblPrevPercentage = "";
        var ProjectDate = "";
        //To get current allocation details of resource
        function GetCurrentAllocationDetails(EmployeeID, ProjectEmployeeRoleID, RequestID) {

            var RequestParameters = {
                ProjectEmployeeRoleID: encodeURI(ProjectEmployeeRoleID),
                RequestID: encodeURI(RequestID),
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID),
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetExtendRequesttData", param, false);

            ProjectDate = strResult.ProjectEndDate;
            var ProjectEmployeeRole = strResult.drProjectEmployee;
            for (var i = 0; i < ProjectEmployeeRole.length; i++) {
                strCurrentStartDate = ProjectEmployeeRole[i]["ExpectedStartDate"];
                strCurrentEndDate = ProjectEmployeeRole[i]["ExpectedEndDate"];
                strCurrentResourcePercentage = ProjectEmployeeRole[i]["ResourcePercentage"];
                dblCurrentHours = ProjectEmployeeRole[i]["BudgetedHours"];
                strEmployeeName = ProjectEmployeeRole[i]["EmployeeName"];
                m_intEmployeeID = ProjectEmployeeRole[i]["EmployeeID"];
                m_strRequestedStartDate = ProjectEmployeeRole[i]["ExpectedEndDate"];
                intRoleID = ProjectEmployeeRole[i]["RoleID"];

            }

            var m_intResourcepoolID = strResult.drResourcePoolAndRoleId;

            // Extend Booking Detail
            var ExtendBookingDetail = strResult.drExtendBookingDetail;
            if (RequestID != 0) {

                for (var i = 0; i < ExtendBookingDetail.length; i++) {
                    m_strRequestedStartDate = ExtendBookingDetail[i]["FromDate"];
                    m_strRequestedEndDate = ExtendBookingDetail[i]["ToDate"];
                    m_strSpecialRequest = ExtendBookingDetail[i]["SpecialRequest"];
                    m_intPriority = ExtendBookingDetail[i]["Priority"];
                    m_strStatus = ExtendBookingDetail[i]["Status"];
                    m_dblWorkHrsPerDay = ExtendBookingDetail[i]["WorkHours"];
                    m_dblTotalWorkHrs = ExtendBookingDetail[i]["TotalRequestedHrs"];
                    m_dblPercentage = ExtendBookingDetail[i]["PercentageAllocation"];
                    m_strType = ExtendBookingDetail[i]["Type"];
                    m_RequestType = ExtendBookingDetail[i]["RequestType"];

                    strCurrentStartDate = ExtendBookingDetail[i]["ExpectedStartDate"];
                    strCurrentEndDate = ExtendBookingDetail[i]["ExpectedEndDate"];
                    strCurrentResourcePercentage = ExtendBookingDetail[i]["ResourcePercentage"];
                    dblCurrentHours = ExtendBookingDetail[i]["BudgetedHours"];
                    strEmployeeName = ExtendBookingDetail[i]["EmployeeName"];
                    m_intEmployeeID = ExtendBookingDetail[i]["EmployeeID"];
                    intRoleID = ExtendBookingDetail[i]["RoleID"];
                    m_intResourcepoolID = ExtendBookingDetail[i]["ResourcePoolID"];
                    m_strRequestDate = ExtendBookingDetail[i]["RequestDate"];
                    m_intProjectEmployeeRoleId = ExtendBookingDetail[i]["ProjectEmployeeRoleID"];
                    strProjectID = ExtendBookingDetail[i]["ProjectID"];
                    intResourcepoolID = m_intResourcepoolID;
                }
            }
            else {
                for (var i = 0; i < ExtendBookingDetail.length; i++) {

                    var m_strRequestedStartDate1 = "";
                    m_strRequestedStartDate1 = ExtendBookingDetail[i]["FromDate"];
                    if (m_strRequestedStartDate < m_strRequestedStartDate1) {
                        m_strRequestedStartDate = m_strRequestedStartDate1;
                    }

                    m_strRequestedEndDate = ExtendBookingDetail[i]["ToDate"];
                    m_strSpecialRequest = ExtendBookingDetail[i]["SpecialRequest"];
                    m_intPriority = ExtendBookingDetail[i]["Priority"];
                    m_strStatus = ExtendBookingDetail[i]["Status"];
                    m_strType = ExtendBookingDetail[i]["Type"];


                }
            }



            //Get previous allocation details
            var ExtendBookingOldAllocationDetail = strResult.GetOldAllocationDetails;
            var Result = ExtendBookingOldAllocationDetail;
            for (var i = 0; i < Result.length; i++) {
                if (RequestID != 0) {
                    m_dblPrevWorkHrsPerDay = Result[i]["ApprovedWorkHours"];
                    m_dblPrevTotalWorkHrs = Result[i]["ApprovedTotalRequestedHrs"];
                    m_dblPrevPercentage = Result[i]["ApprovedPercentageAllocation"];
                }
                else {
                    m_dblPrevWorkHrsPerDay = Result[i]["WorkHours"];
                    m_dblPrevTotalWorkHrs = Result[i]["TotalRequestedHrs"];
                    m_dblPrevPercentage = Result[i]["PercentageAllocation"];

                    if (m_strType == "TH") {
                        m_dblTotalWorkHrs = m_dblPrevTotalWorkHrs
                    }
                    else if (m_strType == "HPD") {
                        m_dblWorkHrsPerDay = m_dblPrevWorkHrsPerDay
                    }
                    else {
                        m_dblPercentage = m_dblPrevPercentage
                    }

                }
            }

        }

        function ValidExtendRequest() {

            var objReqStartDate = $("#txtExtResourceToDate").val();
            var objReqEndDate = $("#txtExtResourceFromDate").val();
            var objEndDate = $("#txtEndDate").val();
            var objProjEndDate = $("#txtProjEndDate").val();
            var objUnit = $("#txtExtResourceNewAllocation").val();
            var objUnitNew = document.getElementById("txtExtResourceNewAllocation");

            var objPercentage = $("#txtPercentage").val();
            var objTotalWorkHours = $("#txtTotalWorkHours").val();
            var objWorkHrsPerDay = $("#txtWorkHrsPerDay").val();
            var objSpanTotalWorkHours = $("#txtExtResourceNewWorkHours").val();

            var RequestParameters = {
                RequestType: encodeURI(m_strType),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(RequestParameters);
            var strResult1 = AJAXCallWithResult("/api/PM_RequestedResources/GetMaxUnits", param, false);
            var m_strMaxUnits = strResult1;

            if (isBlank(objReqEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_NewEndDate") %>");
                $("#txtExtResourceFromDate").focus();
                return false;
            }
            if (isBlank(objUnit)) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocation") %>");
                $("#txtExtResourceNewAllocation").focus();
                return false;

            }
            if (isBlank(objReqStartDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_NewEffectiveDate") %>");
                $("#txtExtResourceToDate").focus();
                return false;
            }
            if (Date.parse(objProjEndDate) < Date.parse(objReqEndDate)) {
                alertify.error("'New End Date' should not be greater than 'Project End Date' (" + objProjEndDate + ")");
                $('#txtExtResourceFromDate').focus();
                return false;
            }
            if (Date.parse(objReqEndDate) < Date.parse(objReqStartDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_NewEndDateGraterThanEffectiveDate") %>");
                $('#txtExtResourceFromDate').focus();
                return false;
            }

            if (m_strType != "P") {

                if (WorkHoursValidation("txtExtResourceNewAllocation") == true) {

                    var NewAllocation = $("#txtExtResourceNewAllocation").val();
                    if (NewAllocation.indexOf(":") > -1) {

                        var RequestParameters = {
                            WorkHrs: encodeURI(NewAllocation),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                        var objUnit = $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                        objUnit = $("#hiddentxtPrPerOfDay").val();
                    }

                }
                else {
                    return false;
                }


            } else {

                var NewAllocationValue = $("#txtExtResourceNewAllocation").val();
                $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                objUnit = $("#hiddentxtPrPerOfDay").val();


                if (isNumeric(NewAllocationValue) == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericValueForNewAllocation") %>");
                    $('#txtExtResourceNewAllocation').focus();
                    return false;
                }

            }


            if (objUnit != '' && objUnit == 0) {
                alertify.error('<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>');
                $('#txtExtResourceNewAllocation').focus();
                return false;
            }



            if (m_strMaxUnits != 0 && m_strType == "TH") {

                if (objPercentage > m_strMaxUnits) {
                    var NewAllocation = $("#txtExtResourceNewAllocation").val();
                    alertify.error('Calculated percentage for &#39;' + NewAllocation + ' Hrs &#39; should be less than or equal to &#39;' + m_strMaxUnits + '%&#39;');
                    $('#txtExtResourceNewAllocation').focus();
                    return false;
                }


            }
            if (m_strMaxUnits != 0 && m_strType == "HPD") {
                if (objUnit > m_strMaxUnits) {
                    alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGetMaxUniits") %> " + m_strMaxUnits);
                    $('#txtExtResourceNewAllocation').focus();
                    return false;
                }
            }

            if (m_strMaxUnits != 0 && m_strType == "P") {
                if (objUnit > m_strMaxUnits || objUnit < 1) {
                    alertify.error("<%= MyBase.GetResourceString("A_NewAllocationPercenteage") %>" + m_strMaxUnits);
                    $('#txtExtResourceNewAllocation').focus();
                    return false;
                }
            }

            if (Date.parse(objReqStartDate) <= Date.parse(objEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffectiveDateGreterEndDate") %>");
                $('#txtExtResourceToDate').focus();
                return false;
            }

            if (Trim(objUnit) != '' && objUnit == 0) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>");
                $('#txtExtResourceNewAllocation').focus();
                return false;
            }



            //if (WorkHoursValidation("txtExtResourceNewAllocation") == false) {
            //    return false;
            //}
           <%-- if (disallowNegativeNumeric(objUnitNew)) {
                alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericValueForNewAllocation") %>");
                $('#txtExtResourceNewAllocation').focus();
                return false;
            }--%>

            if (Trim(objReqStartDate) == '' || Trim(objReqEndDate.value) == '' || Trim(objUnit) == '') {
                return false;
            }

            return true;
        }


        function UpdateExtendedRequest() {
            var Flag = "";
            //Added By Rutuja D. 16 Jan 2020 For Declare Flag Value
            Flag = 0;
            //End Added By Rutuja D. 16 Jan 2020 For Declare Flag Value
            if (ValidExtendRequest() == true) {

                var m_strRequestedStartDate = $("#txtExtResourceToDate").val();
                var m_strRequestedEndDate = $("#txtExtResourceFromDate").val();
                var SpecialRequest = $("#txtExtResourceSpecialRequest").val();
                var NewAllocationValue = $("#txtExtResourceNewAllocation").val();
                //Added By Rutuja D. 16 Jan 2020 For Get Total Work Hours
                var objTotalWorkHours = $("#txtTotalWorkHours").val();
                //End Added By Rutuja D. 16 Jan 2020 For Get Total Work Hours

                if (m_strType != "P") {
                    if (NewAllocationValue.indexOf(":") > -1) {

                        var RequestParameters = {
                            WorkHrs: encodeURI(NewAllocationValue),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                    }
                }
                else {
                    NewAllocationValue = $("#txtExtResourceNewAllocation").val();
                }

                if (m_strType == "HPD") {
                    var m_dblWorkHrsPerDay = NewAllocationValue;
                    var m_dblPercentage = $("#txtPercentage").val();
                    var m_dblTotalWorkHrs = $("#txtTotalWorkHours").val();
                }
                else if (m_strType == "TH") {
                    var m_dblTotalWorkHrs = NewAllocationValue;
                    var m_dblPercentage = $("#txtPercentage").val();
                    var m_dblWorkHrsPerDay = $("#txtWorkHrsPerDay").val();
                }
                else {
                    var m_dblPercentage = NewAllocationValue;
                    var m_dblTotalWorkHrs = $("#txtTotalWorkHours").val();
                    var m_dblWorkHrsPerDay = $("#txtWorkHrsPerDay").val();
                }

                var RequestParameters = {
                    RequestedStartDate: encodeURI(m_strRequestedStartDate),
                    RequestedEndDate: encodeURI(m_strRequestedEndDate),
                    EmployeeID: encodeURI(m_intEmployeeID),
                    ProjectID: encodeURI(ProjectID),
                }
                var param = JSON.stringify(RequestParameters);
                var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetFreeHoursForExtendedBooking", param, false);

                for (var i = 0; i < strResult.length; i++) {
                    var m_dblFreeHours = strResult[i]["FreeHours"];
                    var dblMinAvailablePerDayHrs = strResult[i]["MinAvailablePerDayHrs"];
                    var dblMinAvailablePercentage = strResult[i]["MinAvailablePercentage"];

                }
                if (m_dblFreeHours == null || m_dblFreeHours == '' || m_dblFreeHours == undefined) {
                    m_dblFreeHours = 0;
                }
                if (dblMinAvailablePerDayHrs == null || dblMinAvailablePerDayHrs == '' || dblMinAvailablePerDayHrs == undefined) {
                    dblMinAvailablePerDayHrs = 0;
                }
                if (dblMinAvailablePercentage == null || dblMinAvailablePercentage == '' || dblMinAvailablePercentage == undefined) {
                    dblMinAvailablePercentage = 0;
                }

                if (m_strType == "HPD") {
                    if (m_dblWorkHrsPerDay > dblMinAvailablePerDayHrs) {
                        Flag = 1;
                        alertify.error("Resource available work hours per day (" + dblMinAvailablePerDayHrs + ") are less than the requested. ");

                    }
                }
                //Added By Rutuja D. 15 Jan 2020 For strType Wrong
                //else if (m_strType == "p") {
                else if (m_strType == "P") {
                    //End Added By Rutuja D. 15 Jan 2020 For strType Wrong
                    if (m_dblPercentage > dblMinAvailablePercentage) {
                        Flag = 1;
                        alertify.error("Resource available percentage ( " + dblMinAvailablePercentage + "%) is less than the requested.");
                    }
                } else {
                    //Commented & Added By Rutuja D. 16 Jan 2020 For Alert Extend Request
                    //  Flag = 0;
                    if (m_dblFreeHours < objTotalWorkHours) {
                        Flag = 1;
                        alertify.error('Resource Free Hrs are less than the hours you are assigning him/her for project');
                    }
                    //End Commented & Added By Rutuja D. 16 Jan 2020 For Alert Extend Request
                }

                if (Flag != 1) {
                    if (RequestID != 0) {
                        var RequestParameters = {
                            RequestedStartDate: encodeURI(m_strRequestedStartDate),
                            RequestedEndDate: encodeURI(m_strRequestedEndDate),
                            Hours: encodeURI(m_dblWorkHrsPerDay),
                            Specialrequest: encodeURI(SpecialRequest),
                            UserName: encodeURI(UserName),
                            UserID: encodeURI(UserID),
                            ResourcePoolID: encodeURI(intResourcepoolID),
                            RoleID: encodeURI(intRoleID),
                            TotalWorkHrs: encodeURI(m_dblTotalWorkHrs),
                            Percentage: encodeURI(m_dblPercentage),
                            RequestType: encodeURI(m_strType),
                            ProjectEmployeeRoleID: encodeURI(m_intProjectEmployeeRoleId),
                            RequestID: encodeURI(RequestID),
                            ProjectID: encodeURI(ProjectID),
                            Priority: encodeURI(m_intPriority),
                        }
                        var param = JSON.stringify(RequestParameters);

                        var strResult = AJAXCallWithResult("/api/PM_RequestedResources/UpdateExtendedRequest", param, false);
                        //var Result = strResult.split("||");
                        //alertify.success(Result[0]);
                        RequestID = strResult
                        if (RequestID != '' || RequestID != null || RequestID != undefined) {
                            alertify.success("Extended Request Updated Successfully.");
                            EditExtendRequest(m_intEmployeeID, m_intProjectEmployeeRoleId, RequestID)

                        }
                    }
                }
            }
        }

        ////////////////////////////////////////////End Extend Booking///////////////////////////////////////////////////////////

        // Resource Request List Plotting
        //var GlobalSelectedStatus = "";
        function GetRequestedResourcesList(ProjectID) {
          //  debugger;
            StartLoader("#RequestBody");
            $("#Requestedtbl").dataTable().fnDestroy();
            var param = JSON.stringify(encodeURI(ProjectID));
            var Status = $("#cboStatus").find(':selected').val();
            var SearchID = $("#txtSearch").val();
            var VendorID = $("#cboVendorFilter").find(':selected').val();

            if (Status == "") {
                Status = "0";
            }

            if (SearchID == "") {
                SearchID = "0";
            }
            if (VendorID == "") {
                VendorID = "0";
            }
            var FilterParameter = {
                ProjectID: encodeURI(ProjectID),
                Status: encodeURI(Status), 
                SearchID: encodeURI(SearchID),
                VendorID: encodeURI(VendorID)
            }
            var param = JSON.stringify(FilterParameter);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetRequestedResourcesList", param, false);

            $("#Requestedtblbody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var RequestID = strResult[i]["RequestID"]
                var Requestor = strResult[i]["Requestor"];
                var NoOfResources = strResult[i]["NoOfResources"];
                var FromDate = strResult[i]["FromDate"];
                var ToDate = strResult[i]["ToDate"];
                var WorkHours = strResult[i]["WorkHours"];
                var RequestDate = strResult[i]["RequestDate"];
                var AllocationType = strResult[i]["AllocationType"];
                //Added By Rutuja D. 8 Jan 2020 For Get Role 
                var RoleDescription = strResult[i]["RoleDescription"];
                //End Added By Rutuja D. 8 Jan 2020 For Get Role 

                //Added by Chetan M on 13th Jan 202 for IssueID = 21225
                if (RoleDescription == null) {
                    RoleDescription = '';
                }
                //End of Added by Chetan M on 13th Jan 202 for IssueID = 21225
                var RequestType = "";
                var EmployeeID = "";
                var ProjectEmployeeRoleID = '';
                if (RequestID != undefined || RequestID != null || RequestID != '') {
                    var Status = ResourceRequest_GetStatusString(RequestID);
                }
               // GlobalSelectedStatus = Status;
                strHTML += '<tr>'
                  <% If m_blnEditAccess = True Then %>
                strHTML += '<td class="reqid">'
                //Commeneted & Added By Rutuja D. 15 Jan 2020 For Get New Parameter Status
                // strHTML += '<a href="javascript:;" class="RreqID" style="text-decoration:underline" onclick=RequestIDClick(&quot;' + EmployeeID + '&quot;,&quot;' + ProjectEmployeeRoleID + '&quot;,' + RequestID + ',&quot;' + escape(RequestType) + '&quot;)><span data-bs-toggle="tooltip" title="View Detail" data-placement="bottom" class="idlabel">' + RequestID + '</span></a>'
                strHTML += '<a href="javascript:;" class="RreqID" style="text-decoration:underline" onclick=RequestIDClick(&quot;' + EmployeeID + '&quot;,&quot;' + ProjectEmployeeRoleID + '&quot;,' + RequestID + ',&quot;' + escape(RequestType) + '&quot;' + ',&quot;' + escape(Status) + '&quot;)><span data-bs-toggle="tooltip" title="View Detail" data-placement="bottom" class="idlabel">' + RequestID + '</span></a>'
                //End Commeneted & Added By Rutuja D. 15 Jan 2020 For Get New Parameter Status

                strHTML += '</td>'
                 <% Else %>
                strHTML += '<td class="reqid">'
                strHTML += '<span data-bs-toggle="tooltip" class="idlabel">' + RequestID + '</span>'
                strHTML += '</td>'
                <% End If %>
                //Commented & Added By Rutuja D. For Display Role
                //strHTML += '<td>' + Requestor
                strHTML += '<td>' + RoleDescription
                //End Commented & Added By Rutuja D. For Display Role
                strHTML += '</td>'
                strHTML += '<td>' + NoOfResources
                strHTML += '</td>'
                strHTML += '<td>' + RequestDate
                strHTML += '</td>'
                strHTML += '<td>' + FromDate
                strHTML += '</td>'
                strHTML += '<td>' + ToDate
                strHTML += '</td>'
                strHTML += '<td>' + WorkHours
                strHTML += '</td>'
                strHTML += '<td>' + AllocationType
                strHTML += '</td>'
                strHTML += '<td><label class="btn btn-yellow btn-xs" autocomplete="off">' + Status + '</label>'
                strHTML += '</td>'

                strHTML += '</tr>'

            }
            $("#Requestedtblbody").html("")
            $("#Requestedtblbody").html(strHTML);

            StopAjaxLoader("#RequestBody");
            var stdTable1 = $("#Requestedtbl").DataTable({
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "retrieve": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "columnDefs": [{
                    'width': '10%',
                    "orderSequence": ["desc", "asc"],
                    'targets': [8], /* column index */
                    'orderable': false, /* true or false */
                }],
                "order": [[0, 'desc']],
                "drawCallback": function (settings) {
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }


            });
            stdTable1.columns.adjust().draw();
            $(".dataTables_scrollHeadInner").css({ "width": "100%" });
            $(".table ").css({ "width": "100%" });

            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
                setTimeout(function () {
                    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                }, 350); //Added by pradip on 17-01-2020
            });
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 350);

            if (strHTML == "") {
                $("#Requestedtbl tbody tr td").prop("colspan", 9);

            }

        }

        ////////////////////////////////////////////////Change Allocation ////////////////////////////////////

        var GblResourceEndDate = '';
        // Edit Change Allocation Request 
        function EditChangeAllocation(EditProjectEmployeeRoleID, RequestID) {
            $("#txtChngNewWorkHour").prop("disabled", true);
            //StartLoader("#RequestBody");
            RequestParameters = {
                ProjectEmployeeRoleID: encodeURI(EditProjectEmployeeRoleID),
                ProjectID: encodeURI(ProjectID),
                RequestID: encodeURI(RequestID),
                EmployeeID: encodeURI(ChngEmployeeID),
            }
            var param = JSON.stringify(RequestParameters);
            Result = AJAXCallWithResult("/api/PM_RequestedResources/GetChangeAllocationRequestData", param, false);

            var lngRegHours = 0;
            var AllocationType = "";
            var strRequestType = "";
            var strStatus = "";

            var strResult1 = Result.drProjectEmployee;
            //debugger;
            for (var i = 0; i < strResult1.length; i++) {
                var strStartDate = strResult1[i]["ExpectedStartDate"];
                var strEndDate = strResult1[i]["ExpectedEndDate"];
                var lngHours = strResult1[i]["BudgetedHours"];
                var strEmployeeName = strResult1[i]["EmployeeName"];
                var strEmployeeID = strResult1[i]["EmployeeID"];
                //Commented and Added By Reshma on 11th Jan 2020 For IssueID-21335
                //strRequestType = strResult1[i]["Type"];
                strRequestType = strResult1[i]["RequestType"];
                //End Added By Reshma on 11th Jan 2020 For IssueID-21335
                strStatus = strResult1[i]["Status"];
                GblResourceEndDate = strEndDate;
                if (lngHours == '' || lngHours == null || lngHours == undefined) {
                    lngHours = 0;
                }
                else {
                    lngHours = lngHours;
                }

                //Added By Dipali V on 23rd April 2020 For Project Work Hours In HH:MM
                var RequestParameters = {
                               WorkHrs: encodeURI(lngHours),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
                lngHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                 //End of Added By Dipali V on 23rd April 2020 For Project Work Hours In HH:MM


                //alert(strStatus);
                if (strStatus == "A") {

                    //Added By Rutuja D. 16 Jan 2020 For Hide Cancel Request
                    $("#cancelRequest").show();
                    //End Added By Rutuja D. 16 Jan 2020 For Hide Cancel Request

                    //Added By Reshma om 11th Jan 2020 For IssueID-21325  
                    //Commented And Added By Usha Pandit On 16.06.2020 For javascript error
                    //$("#SaveChangeAllocationRequestParametershide();
                    $("#SaveChangeAllocation").hide();
                    //End Of Added By Usha Pandit On 16.06.2020 For javascript error
                    $("#Divchangedetails").hide();
                    $("#DivExtendRequestDetails").hide();
                    $("#DivPreponerequestDetails").hide();
                    //End Added By Reshma om 11th Jan 2020 For IssueID-21325

                    //var strRequestedEffectiveFromDate = strResult[i]["FromDate"];
                    //var strRequestedEndDate = strResult[i]["ToDate"];
                    //var lngHours = strResult[i]["TotalRequestedHrs"];
                    var strRequestedEffectiveFromDate = strResult1[i]["FromDate"];
                    var strRequestedEndDate = strResult1[i]["ToDate"];
                    var lngHours = strResult1[i]["TotalRequestedHrs"];

                    $("#SpanChngAllstartDate").text(strRequestedEffectiveFromDate);
                    $("#txtChngStartDate").val(strRequestedEffectiveFromDate);
                    $("#SpanChngAllEndDate").text(strRequestedEndDate);
                    $("#txtChngEndDate").val(strRequestedEndDate);
                    $("#SpanChngWHProject").text(lngHours);
                    //Added By Reshma om 11th Jan 2020 For IssueID-21325
                    $("#SpanChngEmpName").text(strEmployeeName);
                    //Added By Reshma om 11th Jan 2020 For IssueID-21325

                } else {

                    //Added By Rutuja D. 16 Jan 2020 For Hide Cancel Request
                    $("#cancelRequest").hide();
                    //End Added By Rutuja D. 16 Jan 2020 For Hide Cancel Request

                    //Added By Reshma om 11th Jan 2020 For IssueID-21325
                    $("#SaveChangeAllocation").show();
                    $("#Divchangedetails").show();
                    $("#DivExtendRequestDetails").show();
                    $("#DivPreponerequestDetails").show();
                    //End Added By Reshma om 11th Jan 2020 For IssueID-21325

                    $("#SpanChngAllstartDate").text(strStartDate);
                    $("#txtChngStartDate").val(strStartDate);
                    $("#SpanChngWHProject").text(lngHours);
                    $("#SpanChngAllEndDate").text(strEndDate);
                    $("#txtChngEndDate").val(strEndDate);
                    //Added By Reshma om 11th Jan 2020 For IssueID-21325
                    $("#SpanChngEmpName").text(strEmployeeName);
                    //Added By Reshma om 11th Jan 2020 For IssueID-21325
                }


                if (strRequestType == 'HPD') {
                    lngRegHours = strResult1[i]["WorkHours"];
                    AllocationType = "Hours Per Day";

                    //Added By Dipali V On 23rd April 2020 For Time should be in HH:MM Formate
                   var RequestParameters = {
                               WorkHrs: encodeURI(lngRegHours),
                               Flag: encodeURI(1),
                   }
                    var param = JSON.stringify(RequestParameters);
                    lngRegHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                   //End of Added By Dipali V On 23rd April 2020 For Time should be in HH:MM Formate

                    $("#SpanChngAllValue").text(lngRegHours + " Hrs/Day");

                }
                else if (strRequestType == 'P') {
                    lngRegHours = strResult1[i]["PercentageAllocation"];
                    //AllocationType = "% Per Day";
                    AllocationType = "% of Day";
                    $("#SpanChngAllValue").text(lngRegHours + '%');
                }
                else {
                    lngRegHours = strResult1[i]["TotalRequestedHrs"];
                  //Added By Dipali V On 23rd April 2020 For Time should be in HH:MM Formate
                      var RequestParameters = {
                                   WorkHrs: encodeURI(lngRegHours),
                                   Flag: encodeURI(1),
                      }
                      var param = JSON.stringify(RequestParameters);
                      lngRegHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
               //End of Added By Dipali V On 23rd April 2020 For Time should be in HH:MM Formate

                    AllocationType = "Total Hours";
                    $("#SpanChngAllValue").text(lngRegHours);

                }
            }


            var strResult = Result.drProjectEmployeeRole;
            if (strStatus != "A") {
                for (var i = 0; i < strResult.length; i++) {

                    var strRequestedEffectiveFromDate = strResult[i]["FromDate"];
                    var strRequestedEndDate = strResult[i]["ToDate"];
                    var m_strSpecialRequest = strResult[i]["SpecialRequest"];
                    Priority = strResult[i]["Priority"];
                    var strHours = strResult[i]["WorkHours"];
                    var strEmployeeName = strResult[i]["EmployeeName"];
                    var strStartDate = strResult[i]["ExpectedStartDate"];
                    var strRequestedEffectiveFromDate = strResult[i]["FromDate"];
                    var strEndDate = strResult[i]["ExpectedEndDate"];
                    var strRequestedEndDate = strResult[i]["ToDate"];
                    var strStatus = strResult[i]["Status"];
                    strRequestType = strResult[i]["Type"];
                    var lngHours = strResult[i]["BudgetedHours"];
                    var m_strSpecialRequest = strResult[i]["SpecialRequest"];
                    Priority = strResult[i]["Priority"];
                    GlobalRequestType = strRequestType;
                    if (lngHours == '' || lngHours == null || lngHours == undefined) {
                        lngHours = 0;
                    }
                    else {
                        lngHours = lngHours;
                    }
                    //Added By Imran 2022 For Change Allocation Request Issue
                    var Flag = 1;
                    if (lngHours.indexOf(":") > -1) {
                        Flag = 2;
                    }
                     //End of Added By Imran 2022 For Change Allocation Request Issue
                    //Added By Rutuja D On 17 Dec 2021 For Time should be in HH:MM Formate
                    var RequestParameters = {
                        WorkHrs: encodeURI(lngHours),
                        Flag: encodeURI(Flag),
                    }
                    var param = JSON.stringify(RequestParameters);
                    lngHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                    //End of Added By Rutuja D On 17 Dec 2021 For Time should be in HH:MM Formate
                   

                    if (strStatus == "A") {
                        var strRequestedEffectiveFromDate = strResult[i]["FromDate"];
                        var strRequestedEndDate = strResult[i]["ToDate"];
                        var lngHours = strResult[i]["TotalRequestedHrs"];

                        $("#SpanChngAllstartDate").text(strRequestedEffectiveFromDate);
                        $("#txtChngStartDate").val(strRequestedEffectiveFromDate);
                        $("#SpanChngAllEndDate").text(strRequestedEndDate);
                        $("#txtChngEndDate").val(strRequestedEndDate);
                        $("#SpanChngWHProject").text(lngHours);
                    }
                    else {

                        $("#SpanChngEmpName").text(strEmployeeName);
                        $("#SpanChngAllEndDate").text(strEndDate);
                        $("#txtChngEndDate").val(strEndDate);
                        $("#txtChngStartDate").val(strStartDate);
                        $("#SpanChngAllstartDate").text(strStartDate);
                        $("#SpanChngWHProject").text(lngHours);
                        $("#txtChngEffeDate").val(strRequestedEffectiveFromDate);
                        $("#txtChngSpecialRequest").val(m_strSpecialRequest);
                    }

                }

                var OldAllocationDetail = Result.GetOldAllocationDetails;

                for (var i = 0; i < OldAllocationDetail.length; i++) {
                    //debugger;
                    var mstrhrsperday = OldAllocationDetail[i]["WorkHours"];
                    var mstrtotal = OldAllocationDetail[i]["TotalRequestedHrs"];
                    var mstrApprovedhrsperday = OldAllocationDetail[i]["ApprovedWorkHours"];
                    var mstrApprovedPercentageperday = OldAllocationDetail[i]["ApprovedPercentageAllocation"];
                    var mstrApprovedtotal = OldAllocationDetail[i]["ApprovedTotalRequestedHrs"];
                    var mstrPercentageperday = OldAllocationDetail[i]["PercentageAllocation"];
                    var m_strHours = mstrtotal

                    if (strRequestType == "TH") {

                        lngRegHours = mstrApprovedtotal;
                        var ConvertDecimalToHourViceVersa = mstrtotal;
                        AllocationType = "Total Hours";
                     //Remove Commented By Dipali V  For WH IssueID-23471
                     var RequestParameters = {
                        WorkHrs: encodeURI(lngRegHours),
                        Flag: encodeURI(1),
                    }
                    var param = JSON.stringify(RequestParameters);
                    lngRegHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
					//End Added By Dipali v on 16th March 2020 For WH IssueID-23471

                        $("#SpanChngAllValue").text(lngRegHours);

                    }
                    else if (strRequestType == "P") {

                        lngRegHours = mstrApprovedPercentageperday;
                        var ConvertDecimalToHourViceVersa = mstrPercentageperday;
                        //AllocationType = "% Per Day";
                        AllocationType = "% of Day";
                        //Added By Rutuja D. on 5 Jan 2022 For rounded by  2 decimal digits
                        if (lngRegHours == null || lngRegHours == undefined || lngRegHours == "") {                           
                        }
                        else {
                            lngRegHours = lngRegHours.toFixed(2);
                        }   
                        // End of Added By Rutuja D. on 5 Jan 2022 For rounded by  2 decimal digits
                        
                        $("#SpanChngAllValue").text(lngRegHours + '%');

                    }
                    else {

                       lngRegHours = mstrApprovedhrsperday;
                        //  lngRegHours = mstrhrsperday;
                     var ConvertDecimalToHourViceVersa = mstrhrsperday;
                     //Remove Commented By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                     var RequestParameters = {
                        WorkHrs: encodeURI(lngRegHours),
                        Flag: encodeURI(1),
                    }
                    var param = JSON.stringify(RequestParameters);
                    lngRegHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
					//Endof Remove Commented By Reshma Chavan on 16th March 2020 For WH IssueID-23471

                        AllocationType = "Hours Per Day";
                        $("#SpanChngAllValue").text(lngRegHours + " Hrs/Day");
                    }

                    if (ConvertDecimalToHourViceVersa != undefined) {
                        if (strRequestType != "P") {
                            var RequestParameters = {
                                WorkHrs: encodeURI(ConvertDecimalToHourViceVersa),
                                Flag: encodeURI(1),
                            }
                            var param = JSON.stringify(RequestParameters);
                            var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                        }
                    }

                    if (strRequestType == 'HPD') {
                        lngRegHours = OldAllocationDetail[i]["ApprovedWorkHours"];
                        $("#LblChngAllPerDay").text("New Hrs Per Day: ");
                        $("#txtChngNewPerDay").val(NewAllocationValue);
                        $("#hiddentxtPrPerOfDay").val(mstrhrsperday);
                        $("#txtChngReqWorkHours").val(lngRegHours);
                    }
                    else if (strRequestType == 'P') {
                        lngRegHours = OldAllocationDetail[i]["ApprovedPercentageAllocation"];
                        $("#LblChngAllPerDay").text("New % Of Day: ");
                        $("#txtChngNewPerDay").val(mstrPercentageperday);
                        $("#hiddentxtPrPerOfDay").val(mstrPercentageperday);
                        $("#txtChngReqWorkHours").val(lngRegHours);

                    }
                    else {
                        lngRegHours = OldAllocationDetail[i]["ApprovedTotalRequestedHrs"];
                        $("#LblChngAllPerDay").text("NEW Work Hours: ");
                        $("#txtChngReqWorkHours").val(lngRegHours);
                        $("#txtChngNewPerDay").val(NewAllocationValue);
                        $("#hiddentxtPrPerOfDay").val(mstrtotal);
                    }

                    if (m_strHours != '') {
                        var RequestParameters = {
                            WorkHrs: encodeURI(m_strHours),
                            Flag: encodeURI(1),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue1 = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                        $("#txtChngNewWorkHour").val(NewAllocationValue1);

                    } else {
                        $("#txtChngNewWorkHour").val(m_strHours);
                    }

                    $("#txtHours").val(m_strHours);
                    m_OldAllocation = lngRegHours;
                    $("#SpanChngAllType").text(AllocationType);
                    $("#txtChngReqEndDate").val(strEndDate);

                }
                var StdAllocationPercentage = Result.SettingValue;
                $("#txtPrevAllocationPercentage").val(StdAllocationPercentage);

                var ProjectEndDate = Result.ProjectEndDate;
                $("#txtProjEndDate").val(ProjectEndDate);
                //StopAjaxLoader("#RequestBody");
            }

            //Added By Reshma om 11th Jan 2020 For IssueID-21325
            else {
                for (var i = 0; i < strResult.length; i++) {
                    var strRequestedEffectiveFromDate = strResult[i]["FromDate"];
                    var strRequestedEndDate = strResult[i]["ToDate"];
                    strRequestType = strResult[i]["Type"];
                }
                if (strRequestType == "TH") {
                    AllocationType = "Total Hours";

                }
                else if (strRequestType == "P") {
                   // AllocationType = "% Per Day";
                    AllocationType = "% of Day";

                }
                else {
                    AllocationType = "Hours Per Day";
                }
                $("#SpanChngAllType").text(AllocationType);
                $("#SpanChngAllstartDate").text(strRequestedEffectiveFromDate);
                $("#SpanChngAllEndDate").text(strRequestedEndDate);
            }
            //End Added By Reshma om 11th Jan 2020 For IssueID-21325

        }

        //$("#txtChngNewPerDay").change(function () {

        //In Change Allocation New Allocation On change Function
        function ChangeAllocationNewPerDay() {

            if (GlobalRequestType != 'P') {
                if (WorkHoursValidation("txtChngNewPerDay") == true) {

                    var NewAllocation = $("#txtChngNewPerDay").val();
                    if (GlobalRequestType != 'HPD') {
                        $("#txtChngNewWorkHour").val(NewAllocation);
                        $("#txtChngNewWorkHour").prop("disabled", true);
                        $("#txtChngHours").val(NewAllocation);
                    }
                    var ValuetxtPrPerOfDay = $("#txtChngNewPerDay").val()
                    $("#hiddentxtPrPerOfDay").val(ValuetxtPrPerOfDay);
                    var WorkHours = $("#hiddentxtPrPerOfDay").val();
                    if (WorkHours.indexOf(":") > -1) {

                        var RequestParameters = {
                            WorkHrs: encodeURI(WorkHours),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                        var ValuehiddentxtPrPerOfDay = $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                    }

                    else {
                        return true;
                    }

                }
                else {
                    return false;
                }
            }
            var NewAllocation = $("#txtChngNewPerDay").val();
            $("#hiddentxtPrPerOfDay").val(NewAllocation);

            return true;
        }

        //});

        //$("#txtPrPerOfDay").change(function () {
        function txtPrPerOfDayOnchange() {


            if (p_strType != "P") {
                <%--if (GlobalRequestType == 'HPD') {   
                    var RequestParameters = {
                            WorkHrs: encodeURI(<%=CommonFunctions.Application.MinHoursForDAEntry%>),
                            Flag: encodeURI(1),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                    var objHMEffort = ""; 
                    var objNewAllocation = document.getElementById("txtPrPerOfDay"); 
                    if (objNewAllocation.value.indexOf(":") > -1) {
                        objHMEffort = objNewAllocation.value.replace(":", ".");
                    }
                    else {
                        objHMEffort = objNewAllocation.value;
                    }
                    

                    strMsg = 'New Work Hours per day should be in the range of ' + NewAllocationValue + ' To 24:00';
                    if (isNumeric(objHMEffort) == false) {
                        alertify.error(strMsg);
                        objNewAllocation.value = '';
                        return false;
                    }

                    if (objHMEffort.indexOf('.')>-1) {
                        alertify.error("Please enter New Work Hours per day in H:M format.");
                        objNewAllocation.value = '';
                        return false;
                    }

                    if (NewAllocationValue > objNewAllocation.value) {
                         if (disallowValueRangeViolation(objNewAllocation, NewAllocationValue, 24+':00', '')) {
                        alertify.error(strMsg);
                        objNewAllocation.value = '';
                        return false;
                    }
                    }
                       
                }--%>
                if (WorkHoursValidation("txtPrPerOfDay") == true) {

                    var NewAllocation = $("#txtPrPerOfDay").val();
                    if (p_strType != "HPD") {
                        $("#txtPrNewWorkHour").val(NewAllocation);
                        $("#txtPrNewWorkHour").prop("disabled", true);
                        $("#hiddentxtPrPerOfDay").val(NewAllocation);
                        var WorkHours = $("#hiddentxtPrPerOfDay").val();
                    }
                    else {
                        $("#txtPrNewWorkHour").prop("disabled", true);
                        $("#hiddentxtPrPerOfDay").val(NewAllocation);
                        var WorkHours = $("#hiddentxtPrPerOfDay").val();
                    }

                    if (WorkHours.indexOf(":") > -1) {

                        var RequestParameters = {
                            WorkHrs: encodeURI(WorkHours),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                        var ValuehiddentxtPrPerOfDay = $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                    }

                }
                else {
                    return false;
                }

            }
            return true;

        }
        //});

        // validate Change Allocation Request Field
        function ValidChangeAllocation() {
            var NewAllocation = $("#hiddentxtPrPerOfDay").val();
            var objNewAllocation = document.getElementById("hiddentxtPrPerOfDay");
            var StdAllocationPercentage = $("#txtPrevAllocationPercentage").val();
            var objEffctiveFrmDate = $("#txtChngEffeDate").val();
            var objCurrentDate = $("#txtToday").val();
            var objEndDate = $("#txtChngEndDate").val();
            var objProjEndDate = $("#txtProjEndDate").val();
            var objReqEndDate = $("#txtChngReqEndDate").val();
            var objStartDate = $("#txtChngStartDate").val();
            var dblstrHours1 = $("#txtHours").val();
            //var NewAllocation = $("#txtChngNewPerDay").val();

            if (GlobalRequestType != 'P') {
                if (NewAllocation.indexOf(":") > -1) {

                    var RequestParameters = {
                        WorkHrs: encodeURI(NewAllocation),
                        Flag: encodeURI(2),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                    $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                    NewAllocation = $("#hiddentxtPrPerOfDay").val();
                }
            }

            RequestParameters = {
                RequestedStartDate: encodeURI(objEffctiveFrmDate),
                RequestedEndDate: encodeURI(GblResourceEndDate),
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(ChngEmployeeID),
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/PM_RequestedResources/GetFreeHoursForChangeAllocation", param, false);

            for (var i = 0; i < Result.length; i++) {
                var c_dblFreeHours = Result[i]["FreeHours"];
                var c_dblFreeMinWorkperday = Result[i]["MinimumPerDay"];
                var c_dblFreeMinWorkpercentage = Result[i]["MinimumPercentage"];

            }
            if (c_dblFreeHours == null) {
                c_dblFreeHours = 0;
            }
            if (c_dblFreeMinWorkperday == null) {
                c_dblFreeMinWorkperday = 0;
            }
            if (c_dblFreeMinWorkpercentage == null) {
                c_dblFreeMinWorkpercentage = 0;
            }

            //var FreeHours = GetFreeHoursForChangeAllocation(objEffctiveFrmDate);
            var m_strerr = "";

            if (isBlank(NewAllocation)) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocation") %>");
                $('#txtChngNewPerDay').focus();
                return false;
            }
            <%--else if (isInteger(NewAllocation) == false) {
                alertify.error("<%= MyBase.GetResourceString("A_WorkHoursInteger") %>");
                $('#txtChngNewPerDay').focus();
                return false;
            }--%>

            if (isBlank(objEffctiveFrmDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffectivefromDate") %>");
                $('#txtChngEffeDate').focus();
                return false;
            }
            if (Date.parse(objStartDate) > Date.parse(objEffctiveFrmDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffeDateGreStartDate") %>");
                $('#txtChngEffeDate').focus();

                return false;
            }
            if (Date.parse(objEffctiveFrmDate) > Date.parse(objReqEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffedatenotLessEndDate") %>");
                $('#txtChngEffeDate').focus();

                return false;
            }
            if (Date.parse(objEffctiveFrmDate) > Date.parse(GblResourceEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffectiveDateGreEndDate") %>");
                $('#txtChngEffeDate').focus();
                return false;
            }

           <%-- if (c_dblFreeHours < NewAllocation) {
                alertify.error("<%= MyBase.GetResourceString("A_resourcesFreeHours") %>");
                $('#txtChngNewPerDay').focus();
                return false;
            }--%>
            if (NewAllocation < 0) {
                alertify.error("<%= MyBase.GetResourceString("A_PositiveValueNewAllo") %>");
                $('#txtChngNewPerDay').focus();
                return false;
            }

            if (NewAllocation == 0) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>");
                $('#txtChngNewPerDay').focus();
                return false;
            }
            if (NewAllocation == m_OldAllocation) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAlloDiffCurrentAllo") %>");
                $('#txtChngNewPerDay').focus();
                return false;
            }
            //else if (WorkHoursValidation("txtChngNewPerDay") == false) {
            //    return false;
            //}
            if (GlobalRequestType == 'P') {
                if (disallowValueRangeViolation(objNewAllocation, 1, StdAllocationPercentage, '')) {
                    alertify.error("<%= MyBase.GetResourceString("A_NewAllocationPercenteage") %>" + StdAllocationPercentage)
                    objNewAllocation.value = '';
                    return false;
                }
            }
            if (GlobalRequestType == 'HPD') {
                if (disallowValueRangeViolation(objNewAllocation, 1, 24, '')) {
                    alertify.error("<%= MyBase.GetResourceString("A_WorkHoursPerDay") %>")
                    objNewAllocation.value = '';
                    return false;
                }
            }
            if (Date.parse(objCurrentDate) > Date.parse(objEffctiveFrmDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffeDateNotLessCurrentDate") %>");
                $('#txtChngEffeDate').focus();
                return false;
            }
            if (Date.parse(objEffctiveFrmDate) > Date.parse(objEndDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffecDateNotGreEndDate") %>");
                $('#txtChngEffeDate').focus();
                return false;
            }
            if (Date.parse(objEffctiveFrmDate) > Date.parse(objProjEndDate)) {
                alertify.error("Effctive From Date Should Not Be Greater Than Project End Date (" + objProjEndDate + ")");
                $('#txtChngEffeDate').focus();
                return false;
            }


            if (c_dblFreeHours < dblstrHours1) {

                alertify.error("Resource Free Hrs are less than the hours you are requesting.");
                $('#txtChngNewPerDay').focus();
                return false;
            }
            if (GlobalRequestType == "P") {
                if (NewAllocation > c_dblFreeMinWorkpercentage) {
                    alertify.error("Resource available percentage ( " + c_dblFreeMinWorkpercentage + "%) is less than the requested.");
                    $('#txtChngNewPerDay').focus();
                    return false;
                }
            }
            if (GlobalRequestType == "HPD") {
                if (NewAllocation > c_dblFreeMinWorkperday) {

                    alertify.error("Resource available  work hours per day (" + c_dblFreeMinWorkperday + ") are less than the requested. ");
                    $('#txtChngNewPerDay').focus();
                    return false;
                }
            }
            return true;
        }

        function GetFreeHoursForChangeAllocation(StartDate) {
            RequestParameters = {
                RequestedStartDate: encodeURI(StartDate),
                RequestedEndDate: encodeURI(GblResourceEndDate),
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(ChngEmployeeID),
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/PM_RequestedResources/GetFreeHoursForChangeAllocation", param, false);
            if (Result.length != 0) {
                return Result[0].FreeHours;
            }
            else {
                return 0;
            }
        }

        //For Update Change Allocation
        function UpdateChangeAllocation() {
             var NewAllocationValue = "";
            //Added By Reshma C. 16 Jan 2020 For Update Functionality
            //var NewAllocation = $("#txtChngNewPerDay").val();
            //if (NewAllocation.indexOf(":") == -1) {
            //    NewAllocation = NewAllocation + ":00";
            //}
            //else {
            //    NewAllocation = NewAllocation;
            //}

            //if (GlobalRequestType != "P") {
            //    var RequestParameters = {
            //        WorkHrs: encodeURI(NewAllocation),
            //        Flag: encodeURI(2),
            //    }
            //    var param = JSON.stringify(RequestParameters);
            //    var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
            //}
            //End Added By Reshma C. 16 Jan 2020 For Update Functionality

            if (ChangeAllocationNewPerDay() == true) {

                if (ValidChangeAllocation() == true) {

                    var ResourcePoolID = "";
                    var RoleID = "";

                    RequestParameters = {
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                    }

                    var param = JSON.stringify(RequestParameters);
                    Result = AJAXCallWithResult("/api/PM_RequestedResources/GetResourcePoolAndRoleId", param, false);
                    for (var i = 0; i < Result.length; i++) {
                        ResourcePoolID = Result[i]["ResourcePoolID"];
                        RoleID = Result[i]["RoleID"];

                    }
                       // Added By Reshma on 17th Jan 2020
                      var NewAllocation = $("#txtChngNewPerDay").val();
                        
                    if (GlobalRequestType != "P") {   
                        if (NewAllocation.indexOf(":") == -1) {
                            NewAllocation = NewAllocation + ":00";
                         }
                          else {
                             NewAllocation = NewAllocation;
                          }
                        var RequestParameters = {
                            WorkHrs: encodeURI(NewAllocation),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                    }
                  
                    else{
                       NewAllocationValue = NewAllocation;
                     }
                    //End Added By Reshma on 17th Jan 2020


                    //Commented By Reshma c. 16 Jan 2020 For Changeallocation Upadation
                    // var NewAllocation = $("#txtChngNewPerDay").val();
                    //  var NewAllocation = $("#hiddentxtPrPerOfDay").val();
                    //End Commented By Reshma c. 16 Jan 2020 For Changeallocation Upadation
                    var EffectiveFromDate = $("#txtChngEffeDate").val();
                    var NewWorkHour = $("#txtChngNewWorkHour").val();
                    var SpecialRequest = $("#txtChngSpecialRequest").val();
                    var objEndDate = $("#txtChngEndDate").val();

                    RequestParameters = {
                        RequestID: encodeURI(RequestID),
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                        RequestedStartDate: encodeURI(EffectiveFromDate),
                        RequestedEndDate: encodeURI(objEndDate),
                        //Commented By Reshma c. 16 Jan 2020 For Changeallocation Upadation
                        //WorkHour: encodeURI(NewAllocation),                        
                        WorkHour: encodeURI(NewAllocationValue),
                        //End Commented By Reshma c. 16 Jan 2020 For Changeallocation Upadation

                        Specialrequest: encodeURI(SpecialRequest),
                        Priority: encodeURI(Priority),
                        UserName: encodeURI(UserName),
                        UserID: encodeURI(UserID),
                        RequestType: encodeURI(GlobalRequestType),
                        ProjectEmployeeRoleID: encodeURI(ProjectEmployeeRoleID),
                        ResourcePoolID: encodeURI(ResourcePoolID),
                        RoleID: encodeURI(RoleID)

                    }

                    var param = JSON.stringify(RequestParameters);
                    StrResult = AJAXCallWithResult("/api/PM_RequestedResources/UpdateChangeAllocation", param, false);

                    if (StrResult != '') {
                        alertify.success("<%= MyBase.GetResourceString("A_ChangeAllocationDetails") %>");

                        EditChangeAllocation(ProjectEmployeeRoleID, RequestID);

                    }
                }
            }
        }


        $('html, body').animate({
            scrollTop: $("#RRchangeallocation_Detail").offset().top -= 100
        }, 500);



        //////////////////////////////////////////////// End Change Allocation ////////////////////////////////////


        ////////////////////////////////////////////////Prepone Request  ////////////////////////////////////
        var p_StdAllocationPercentage = "";
        var p_IsProjectResourceAllocation = "";
        var p_strType = "";
        var p_strStartDate = "";
        var p_strEndDate = "";
        var p_strStatus = "-1";
        var p_lngHours = "";
        var p_strEmployeeName = "";
        var p_intEmployeeID = "";
        var p_lngRegHours = "";
        var p_mstrhrsperday = "";
        var p_mstrPercentageperday = "";
        var p_mstrtotal = "";
        var p_mstrApprovedhrsperday = "";
        var p_mstrApprovedPercentageperday = "";
        var p_mstrApprovedtotal = "";
        var strRequestedStartDate = "";
        var p_strRequestedEndDate = "";
        var p_strRequestedStartDate = "";
        var p_lngHours = "";
        var p_strHours = "";
        var p_strSpecialRequest = "";
        var p_intPriority = "";
        var p_intRequestID = "";
        var p_strPercentageperday = "";
        var p_RequestType = "";
        var p_strProjectID = "";
        var p_intResourcepoolID = "";
        var p_intRoleID = "";
        var p_flResourcePercentage = "";

        //Edit Prepone Request
        function EditPreponeRequest(EditProjectEmployeeRoleID, RequestID) {

            StartLoader("#RequestBody");
            ProjectEmployeeRoleID = EditProjectEmployeeRoleID;
            RequestParameters = {
                ProjectEmployeeRoleID: encodeURI(EditProjectEmployeeRoleID),
                ProjectID: encodeURI(ProjectID),
                RequestID: encodeURI(RequestID),
            }
            var param = JSON.stringify(RequestParameters);
            Result = AJAXCallWithResult("/api/PM_RequestedResources/GetPreponeRequestList", param, false);
            var Status = "";
            var RequestType = "";
            var lngRegHours = 0;
            p_StdAllocationPercentage = Result.SettingValue;
            $("#txtPrevAllocationPercentage").val(p_StdAllocationPercentage);

            p_IsProjectResourceAllocation = Result.drProjectResourceAllocation;

            if (p_IsProjectResourceAllocation == 1) {
                p_strType = 'P';
            }

            if (ProjectEmployeeRoleID != 0) {
                var strResult = Result.ProjectEmployeeRolePrepone;
                for (var i = 0; i < strResult.length; i++) {
                    p_strStartDate = strResult[i]["ExpectedStartDate"];
                    p_strEndDate = strResult[i]["ExpectedStartDate"];
                    p_lngHours = strResult[i]["BudgetedHours"];
                    p_strEmployeeName = strResult[i]["EmployeeName"];
                    p_intEmployeeID = strResult[i]["EmployeeID"];
                    p_strType = strResult[i]["RequestType"];


                    if (p_strType == "HPD") {
                        p_lngRegHours = strResult[i]["WorkHours"];
                        p_mstrApprovedhrsperday = p_lngRegHours;
                    }
                    else if (p_strType == "TH") {
                        p_lngRegHours = strResult[i]["TotalRequestedHrs"];
                        p_mstrApprovedtotal = p_lngRegHours;
                    }
                    else {
                        p_lngRegHours = strResult[i]["PercentageAllocation"];
                        p_mstrApprovedPercentageperday = p_lngRegHours;
                    }

                    p_strStatus = strResult[i]["Status"];

                    if (p_strStatus == "A") {
                        p_strRequestedStartDate = strResult[i]["FromDate"];
                        p_strRequestedEndDate = strResult[i]["ToDate"];
                        p_lngHours = strResult[i]["TotalRequestedHrs"];
                    }
                }
            }

            var strResult1 = Result.ResourceRequestPreponeType;
            //Added By Reshma on 14th Jan 2020 For IssueID-21323
            if (strResult1.length > 0) {
                //End Added By Reshma on 14th Jan 2020 For IssueID-21323
                if (Status != 'A') {
                    if (strResult1 != undefined || strResult1 != '' || strResult1 != null) {
                        for (var i = 0; i < strResult1.length; i++) {

                            p_strRequestedStartDate = strResult1[i]["FromDate"];
                            p_strRequestedEndDate = strResult1[i]["ToDate"];
                            p_strSpecialRequest = strResult1[i]["SpecialRequest"];
                            p_strHours = strResult1[i]["TotalRequestedHrs"];
                            p_intPriority = strResult1[i]["Priority"];
                            p_intRequestID = strResult1[i]["RequestID"];
                            p_strType = strResult1[i]["Type"];


                            if (p_strType == 'TH') {
                                p_strtotal = strResult1[i]["TotalRequestedHrs"];
                                //$("#SpanAllType").text("Hours Per Day");
                            }
                            else if (p_strType == "P") {
                                p_strPercentageperday = strResult1[i]["PercentageAllocation"];
                                $("#SpanAllType").text("% of Day");
                            }
                            else {
                                p_strhrsperday = strResult1[i]["WorkHours"];
                                $("#SpanAllType").text("Hours Per Day");
                            }
                        }
                    }

                    else {
                        var StartDate = $('#txtPrEndDate').datepicker('setDate', new Date());
                        p_strRequestedStartDate = StartDate;
                    }

                }
                else {

                    p_RequestType = strResult1[i]["RequestType"];
                }
                //Added By Reshma on 14th Jan 2020 For IssueID-21323
            }
            //End Added By Reshma on 14th Jan 2020 For IssueID-21323

            var PreponeRequestDetail = Result.drPreponeRequestDetail;
            if (RequestID != 0) {
                if (PreponeRequestDetail != '' || PreponeRequestDetail != undefined || PreponeRequestDetail != null) {
                    //Added By Reshma on 14th Jan 2020 For IssueID-21323
                    if (PreponeRequestDetail!= undefined) {
                        if (PreponeRequestDetail.length > 0) {
                            //End Added By Reshma on 14th Jan 2020 For IssueID-21323
                            for (var i = 0; i < PreponeRequestDetail.length; i++) {
                                p_strRequestedStartDate = PreponeRequestDetail[i]["FromDate"];
                                p_strRequestedEndDate = PreponeRequestDetail[i]["ToDate"];
                                p_strSpecialRequest = PreponeRequestDetail[i]["SpecialRequest"];
                                p_strHours = PreponeRequestDetail[i]["WorkHours"];
                                p_intPriority = PreponeRequestDetail[i]["Priority"];
                                p_intRequestID = PreponeRequestDetail[i]["RequestID"];
                                p_RequestType = PreponeRequestDetail[i]["RequestType"];
                                p_strStartDate = PreponeRequestDetail[i]["ExpectedStartDate"];
                                p_strEndDate = PreponeRequestDetail[i]["ExpectedEndDate"];
                                p_strRequestDate = PreponeRequestDetail[i]["RequestDate"];
                                p_intProjectEmployeeRoleId = PreponeRequestDetail[i]["ProjectEmployeeRoleID"];
                                p_strStatus = PreponeRequestDetail[i]["Status"];
                                p_intEmployeeID = PreponeRequestDetail[i]["EmployeeID"];
                                p_lngHours = PreponeRequestDetail[i]["BudgetedHours"];
                                p_strEmployeeName = PreponeRequestDetail[i]["EmployeeName"];
                                p_strProjectID = PreponeRequestDetail[i]["ProjectID"];
                                p_intResourcepoolID = PreponeRequestDetail[i]["ResourcePoolID"];
                                p_intRoleID = PreponeRequestDetail[i]["RoleID"];
                                p_strType = PreponeRequestDetail[i]["Type"];
                                p_flResourcePercentage = PreponeRequestDetail[i]["ResourcePercentage"];


                            }
                        }
                    }
                }
            }

            var OldAllocationDetails = Result.GetOldAllocationDetails;
            if (OldAllocationDetails != '' || OldAllocationDetails != undefined || OldAllocationDetails != null) {

                for (var i = 0; i < OldAllocationDetails.length; i++) {


                    if (RequestID != 0) {
                        p_mstrhrsperday = OldAllocationDetails[i]["WorkHours"];
                        p_mstrPercentageperday = OldAllocationDetails[i]["PercentageAllocation"];
                        p_mstrtotal = OldAllocationDetails[i]["TotalRequestedHrs"];
                        p_mstrApprovedhrsperday = OldAllocationDetails[i]["ApprovedWorkHours"];
                        p_mstrApprovedPercentageperday = OldAllocationDetails[i]["ApprovedPercentageAllocation"];
                        p_mstrApprovedtotal = OldAllocationDetails[i]["ApprovedTotalRequestedHrs"];
                        p_strHours = p_mstrtotal
                    }
                    else {
                        p_mstrhrsperday = OldAllocationDetails[i]["WorkHours"];
                        p_mstrPercentageperday = OldAllocationDetails[i]["PercentageAllocation"];
                        p_mstrtotal = OldAllocationDetails[i]["TotalRequestedHrs"];
                        p_mstrApprovedhrsperday = p_mstrhrsperday
                        p_mstrApprovedPercentageperday = p_mstrPercentageperday
                        p_mstrApprovedtotal = p_mstrtotal
                    }

                }

            }
            else {
                if (p_IsProjectResourceAllocation == 1) {
                    p_mstrPercentageperday = p_lngRegHours
                    p_mstrApprovedPercentageperday = p_lngRegHours
                } else {
                    if (p_mstrPercentageperday == '' || p_mstrPercentageperday == undefined || p_mstrPercentageperday == null) {
                        p_mstrPercentageperday = p_mstrApprovedPercentageperday;
                    }
                }
            }

            if (p_lngRegHours == 0) {
                for (var i = 0; i < OldAllocationDetails.length; i++) {

                    if (p_strType == "TH") {
                        p_lngRegHours = OldAllocationDetails[i]["ApprovedTotalRequestedHrs"];
                    }
                    else if (p_strType == "P") {
                        p_lngRegHours = OldAllocationDetails[i]["ApprovedPercentageAllocation"];
                    } else {
                        p_lngRegHours = OldAllocationDetails[i]["ApprovedWorkHours"];
                    }
                    if (p_lngHours == 0) {
                        p_lngHours = OldAllocationDetails[i]["ApprovedTotalRequestedHrs"];
                    }

                }
            }

            var ProjectEndDate = Result.ProjectEndDate;
            GlobalRequestType = p_strType;
            $("#txtProjEndDate").val(ProjectEndDate);
            $('#txtToday').datepicker('setDate', new Date());

            $("#SpanEmpName").text(p_strEmployeeName);
            $("#txtEmpID").val(p_intEmployeeID);

            if (p_strStatus != 'A') {
                $("#SpanAllstartDate").text(p_strStartDate);
                $("#txtStartDate").val(p_strStartDate);

                $("#SpanAllEndDate").text(p_strEndDate);
                $("#txtEndDate").val(p_strEndDate);

            }
            else {
                $("#SpanAllstartDate").text(p_strRequestedStartDate);

                $("#SpanAllEndDate").text(p_strRequestedEndDate);

            }

            if (p_strType == "TH") {
                $("#SpanAllType").text("Total Hours");
                //Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                var RequestParameters = {
                               WorkHrs: encodeURI(p_lngRegHours),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
                  p_lngRegHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                //End of Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                $("#SpanAllValue").text(p_lngRegHours);
                var ConvertDecimalToHourViceVersa = p_mstrtotal;
            }
            else if (p_strType == "P") {
                   //Commented & Added By Dipali V On 12th may 2023 For caption Change
                //$("#SpanAllType").text("% Per Day");
                $("#SpanAllType").text("% of Day");
                   //End of Commented & Added By Dipali V On 12th may 2023 For caption Change

                $("#SpanAllValue").text(p_lngRegHours + " %");

            }
            else {
                $("#SpanAllType").text("Hours Per Day");
                //Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                var RequestParameters = {
                               WorkHrs: encodeURI(p_lngRegHours),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
                  p_lngRegHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                //End of Added By Reshma Chavan on 16th March 2020 For WH IssueID-23471
                $("#SpanAllValue").text(p_lngRegHours + " Hrs/Day");
                var ConvertDecimalToHourViceVersa = p_mstrhrsperday;
            }
            if (p_lngHours == '' || p_lngHours == null || p_lngHours == undefined) {
                p_lngHours = 0;
            }
            else {
                p_lngHours = p_lngHours;
            }

            //Added By Dipali V On 23rd April 2020
             var WorkOnProject = p_lngHours;
            if (WorkOnProject == null || WorkOnProject == undefined || WorkOnProject == "") {
                WorkOnProject = WorkOnProject;
            }
            else {
                WorkOnProject = WorkOnProject.toFixed(2);
            }
			
                var RequestParameters = {
                               WorkHrs: encodeURI(WorkOnProject),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
                WorkOnProject = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
              //End of Added By Dipali V On 23rd April 2020

            //$("#SpanWHProject").text(p_lngHours)
            //$("#SpanWHProject").val(p_lngHours)
            $("#SpanWHProject").text(WorkOnProject)
            $("#SpanWHProject").val(WorkOnProject)
            $("#txtPrEndDate").val(p_strRequestedEndDate);

            if (p_strType != "P") {
                var RequestParameters = {
                    WorkHrs: encodeURI(ConvertDecimalToHourViceVersa),
                    Flag: encodeURI(1),
                }
                var param = JSON.stringify(RequestParameters);
                var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
            }

            if (p_strType == "TH") {
                $("#txtPrevAllocation").val(p_mstrApprovedtotal);
                p_strOldAllocation = parseFloat(p_mstrtotal);
                $("#txtPrPerOfDay").val(NewAllocationValue);
                $("#hiddentxtPrPerOfDay").val(NewAllocationValue);

                $("#lblNewPerOfday").text("New Work Hours: ");
            }

            else if (p_strType == "HPD") {
                $("#txtPrevAllocation").val(p_mstrApprovedhrsperday);
                p_strOldAllocation = parseFloat(p_mstrhrsperday);
                $("#txtPrPerOfDay").val(NewAllocationValue);
                $("#hiddentxtPrPerOfDay").val(NewAllocationValue);
                $("#lblNewPerOfday").text("New Hrs Per Day: ");
            }

            else {
                $("#txtPrevAllocation").val(p_mstrApprovedPercentageperday);
                p_strOldAllocation = parseFloat(p_mstrPercentageperday);
                // alert(p_mstrPercentageperday);
                //Added By Dipali V On 15th Dec 2020 For toFixed 
                if (p_mstrPercentageperday != null || p_mstrPercentageperday != "") {
                    p_mstrPercentageperday = p_mstrPercentageperday.toFixed(2);
                } else {
                    p_mstrPercentageperday = p_mstrPercentageperday;
                }
                //End of Added By Dipali V On 15th Dec 2020 For toFixed 
                $("#txtPrPerOfDay").val(p_mstrPercentageperday);
                $("#hiddentxtPrPerOfDay").val(p_mstrPercentageperday);
                $("#lblNewPerOfday").text("<%= MyBase.GetResourceString("C_NewPerofDay") %>:");
            }

            $("#txtPrEffeDate").val(p_strRequestedStartDate);
            var RequestParameters = {
                WorkHrs: encodeURI(p_mstrtotal),
                Flag: encodeURI(1),
            }
            var param = JSON.stringify(RequestParameters);
            var Data = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
            $("#txtPrNewWorkHour").val(Data);

            //$("#txtPrNewWorkHour").val(p_mstrtotal);
            $("#txtHours").val(p_mstrtotal);
            $("#txtPrSpeRequest").val(p_strSpecialRequest);
            $("#txtPrNewWorkHour").prop("disabled", true);
            StopAjaxLoader("#RequestBody");
        }

        //Validate Prepone Allocation
        function ValidPreponeAllocation() {

            var Checkval = false;
            if (p_strType != "P") {
                var objNewAllocation = document.getElementById("hiddentxtPrPerOfDay");
            }
            else {
                var objNewAllocation = document.getElementById("txtPrPerOfDay");
            }
            var objPrevAllocation = document.getElementById("txtPrevAllocation");
            var objReqEffectiveDate = document.getElementById("txtPrEffeDate");
            var AllocationPercentage = $("#txtPrevAllocationPercentage").val();
            var objReqEndDate = document.getElementById("txtPrEndDate");
            var objEndDate = document.getElementById("txtEndDate");
            var objProjEndDate = document.getElementById("txtProjEndDate");
            var objStartDate = document.getElementById("txtStartDate");
            var objWorkHours = document.getElementById("txtHours");
            var lngHours = $("#SpanWHProject").val();
            var m_strHours = $("#txtHours").val();
            var StrEndDate = $("#txtEndDate").val();
            var strStartDate = $("#txtStartDate").val();
            var SpclRequest = $("#txtPrSpeRequest").val();
            if (SpclRequest == "") {
                SpclRequest = "0";
            }
            Hours = parseFloat(lngHours) - parseFloat(m_strHours);
          
            if (lngHours == "") {
                lngHours = "0";
            }
            if (lngHours.indexOf(':') > -1) {
                lngHours = lngHours.split(":")
                lngHours = lngHours[0];

            }
            RequestParameters = {
                RequestedStartDate: strStartDate,
                RequestedEndDate: txtPrEndDate.value,
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(ChngEmployeeID),
                WorkHour: encodeURI(lngHours),
                StrEndDate: StrEndDate,
            }
            var param = JSON.stringify(RequestParameters);
            console.log(param);

            var Result = AJAXCallWithResult("/api/PM_RequestedResources/GetAllWorkHours", param, false);

            for (var i = 0; i < Result.length; i++) {
                var m_PreponeHours = Result[i]["WorkHours"];
                var ActualHours = Result[i]["ActualHours"];
                var WorkingDays = Result[i]["WorkingDays"];

            }

            var strMsg, strmsg1;

            if (objReqEndDate.value == '') {
                //Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
                // objWorkHours.value = '';
                //End Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
                alertify.error("<%= MyBase.GetResourceString("A_ReqEndDate") %>");
                document.getElementById("txtPrEndDate").focus();//added by dipali V On 2nd Jan 2020
                return false;
            }

            //Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
           <%-- if (objWorkHours.value == '') {
                alertify.error("<%= MyBase.GetResourceString("A_ReqWorkHours") %>");
                    document.getElementById("txtHours").focus();//added by dipali V On 2nd Jan 2020
                return false;
            }--%>
            //End Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
            if (objNewAllocation.value != objPrevAllocation.value) {
                if (disallowBlank(objReqEffectiveDate, '') == true) {
                    alertify.error("<%= MyBase.GetResourceString("A_EffDateBlank") %>");
                    document.getElementById("txtPrEffeDate").focus();//added by dipali V On 2nd Jan 2020
                    return false;
                }

            }
            //if (Date.parse(objReqEndDate.value) == Date.parse(objEndDate.value)) {

            if (Date.parse(objReqEndDate.value) >= Date.parse(objEndDate.value)) {

                alertify.error("<%= MyBase.GetResourceString("A_ReqEndDateLessEndDate") %>");
                document.getElementById("txtPrEndDate").focus();//added by dipali V On 2nd Jan 2020
                return false;

                if (Date.parse(objStartDate.value) < Date.parse(objReqEndDate.value)) {

                    alertify.error("<%= MyBase.GetResourceString("A_ReqEndDateLessStartDate") %>");
                    document.getElementById("txtStartDate").focus();//added by dipali V On 2nd Jan 2020
                    return false;
                }
            }
            //}

            if (isBlank(objNewAllocation.value)) {

                alertify.error("<%= MyBase.GetResourceString("A_EnterNewAllocation") %>");
                $("#txtPrPerOfDay").focus();
                return false;
            }

            if (objNewAllocation.value < 0) {

                alertify.error("<%= MyBase.GetResourceString("A_NewAllocationBlank") %>");
                objNewAllocation.value = '';
                $("#txtPrPerOfDay").focus();
                return false;
            }
            if (objNewAllocation.value == 0) {
                alertify.error("<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>");
                $("#txtPrPerOfDay").focus();
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(SpclRequest, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Special Request should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPrSpeRequest").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            
            //if (p_strType != "P") {
            //    if (WorkHoursValidation("txtPrPerOfDay") == false) {
            //        return false;
            //    }
            //}
            //if (result == true) {
            //Commented By Rutuja D. 8 Jan 2020
           <%-- if (WorkingDays == 0) {
                alertify.error("<%= MyBase.GetResourceString("A_PreReleaseWorkingDay") %>");
                return false;
            }--%>
           <%-- if (ActualHours != 0) {
                if (Hours <= ActualHours) {
                    alertify.error("<%= MyBase.GetResourceString("A_PreResourceRelease") %>")
                    return false;
                }
            }--%>
            //Commented By Rutuja D. 8 Jan 2020
            if (GlobalRequestType == 'P') {

                strMsg = "<%= MyBase.GetResourceString("A_NewAllocationPercenteage") %>  " + AllocationPercentage;
                if (disallowValueRangeViolation(objNewAllocation, 1, AllocationPercentage, '')) {
                    alertify.error(strMsg);
                    objNewAllocation.value = '';
                    return false;
                }

            }
            if (GlobalRequestType == 'HPD') {
                strMsg = 'New Work Hours per day should be in the range of <%=CommonFunctions.Application.MinHoursForDAEntry%> To 24';
                if (disallowValueRangeViolation(objNewAllocation, '<%=CommonFunctions.Application.MinHoursForDAEntry%>', 24, '')) {
                    alertify.error(strMsg);
                    objNewAllocation.value = '';
                    return false;
                }
            }
            if (validWorkHoursAndPrevAllocation() == true) {
                 //added by rutuja on 17th jan 2020 for alter missing
                if (objNewAllocation.value == objPrevAllocation.value) {
                    var objEffectiveDate = document.getElementById("txtPrEffeDate");
                    var objStartDate = document.getElementById("txtStartDate");
                    if (objEffectiveDate.value != objStartDate.value) {
                        alertify.error('As Allocation is same resetting the effective date to Allocation Start Date.');
                        objEffectiveDate.value=objStartDate.value;
                        return false;
                    }
                }
                   //End of added by rutuja on 17th jan 2020 for alter missing




                if (objNewAllocation.value > objPrevAllocation.value) {
                    RequestParameters = {
                        RequestedStartDate: encodeURI(objReqEffectiveDate.value),
                        RequestedEndDate: encodeURI(txtPrEndDate.value),
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var Result = AJAXCallWithResult("/api/PM_RequestedResources/GetFreeHours", param, false);

                    for (var i = 0; i < Result.length; i++) {
                        var m_dblFreeHours = Result[i]["FreeHours"];
                        var m_dblFreeMinWorkperday = Result[i]["MinimumPerDay"];
                        var m_dblFreeMinWorkpercentage = Result[i]["MinimumPercentage"];

                    }

                    RequestParameters = {
                        RequestedStartDate: encodeURI(objReqEffectiveDate.value),
                        RequestedEndDate: encodeURI(txtPrEndDate.value),
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                        PrevAllocation: encodeURI(objPrevAllocation.value),
                        NewAllocation: encodeURI(objNewAllocation.value),
                        RequestType: encodeURI(GlobalRequestType),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var m_extrahrsRequired = AJAXCallWithResult("/api/PM_RequestedResources/GetExtraHours", param, false);
                    m_extrahrsRequired = parseFloat(m_extrahrsRequired);
                    if (GlobalRequestType == 'P') {
                        //Added By Rutuja D. 8 Jan 2020 For resource with Extra Hrs Validation
                        if (m_extrahrsRequired > m_dblFreeHours) {
                            $("#AlertMsg").text("<%= MyBase.GetResourceString("A_ExtraHoursResource") %>");
                            $("#confirmationmodal").modal('show');
                            return false;

                        }
                        //End Added By Rutuja D. 8 Jan 2020 For resource with Extra Hrs Validation

                        if (objNewAllocation.value > m_dblFreeMinWorkpercentage) {
                            var m_strerr = "Resource available percentage ( " + m_dblFreeMinWorkpercentage + "%) is less than the requested.";
                            $("#AlertMsg").text(m_strerr);
                            $("#confirmationmodal").modal('show');
                            return false;
                        }

                    } else if (GlobalRequestType == 'HPD') {
                        if (objNewAllocation.value > m_dblFreeMinWorkperday) {
                            var m_strerr = "Resource available free work hours per day (" + m_dblFreeMinWorkperday + ") are less than the requested. "
                            $("#AlertMsg").text(m_strerr);
                            $("#confirmationmodal").modal('show');
                            return false;
                        }
                    }
                }


                //Added By Rutuja D. 8 Jan 2020 For Alert Sequence 

                //Commented by Dipali V on 18th March 2025 To remove alert 'You can not Prepone release this resource! Resource has daily activity entered greater than New Total Hours'
                <%--if (ActualHours != 0) {
                    if (Hours <= ActualHours) {
                        alertify.error("<%= MyBase.GetResourceString("A_PreHoursGreaterAcualHours") %>");
                        return false;
                    }
                }--%>
                //End of Commented by Dipali V on 18th March 2025 To remove alert 'You can not Prepone release this resource! Resource has daily activity entered greater than New Total Hours'

                if (WorkingDays == 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_PreReleaseWorkingDay") %>");
                    return false;
                }
                //Commented and Added by Dipali V on 18th March 2025 To remove alert 'You can not Prepone release this resource! Resource has daily activity entered greater than New Total Hours'
                //var RequestEndDate = $("#txtReqEndDate").val();
                var RequestEndDate = $("#txtPrEndDate").val();
                //End of Commented and added by Dipali V on 18th March 2025 To remove alert 'You can not Prepone release this resource! Resource has daily activity entered greater than New Total Hours'
                //debugger
                RequestParameters = {
                    RequestedEndDate: encodeURI(RequestEndDate),
                    ProjectID: encodeURI(ProjectID),
                    EmployeeID: encodeURI(ChngEmployeeID),

                }
                var param = JSON.stringify(RequestParameters);
               //added & Commented by dipali V On 18th Jan 2020 For Method call wronge
                //var IntEmployeeid = AJAXCallWithResult("/api/PM_RequestedResources/GetExtraHours", param, false);
                var IntEmployeeid = AJAXCallWithResult("/api/PM_RequestedResources/GetEmployeeId", param, false);
                if (IntEmployeeid != 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_PreTaskEmployeeID") %>");
                    return false;
                }
                //End of added & Commented by dipali V On 18th Jan 2020 For Method call wronge
            }
            else {
                return false;
            }

            return true;
        }

        function validWorkHoursAndPrevAllocation() {

            var checkval = true;
            var objNewAllocation = document.getElementById("txtPrPerOfDay");
            var objPrevAllocation = document.getElementById("txtPrevAllocation");
            var objReqEffectiveDate = document.getElementById("txtPrEffeDate");

            var objReqEndDate = document.getElementById("txtPrEndDate");
            var objEndDate = document.getElementById("txtEndDate");
            var objProjEndDate = document.getElementById("txtProjEndDate");
            var objStartDate = document.getElementById("txtStartDate");
            var objWorkHours = document.getElementById("txtHours");
            var objToday = document.getElementById("txtToday");
            var Today = $("#txtToday").val();
            var ReqEffectiveDate = $("#txtPrEffeDate").val();
            objprojEndDate = getDate1(objProjEndDate.value);
            objPrevAllocation.disabled = false;
            objWorkHours.disabled = false;

            if (objReqEndDate.value == '') {
                alertify.error("<%= MyBase.GetResourceString("A_ReqEndDate") %>");
                document.getElementById("txtPrEndDate").focus();
                return false;
            }
            // Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
            <%--else if (objWorkHours.value == '') {
                alertify.error("<%= MyBase.GetResourceString("A_EnterWorkHours") %>");
                document.getElementById("txtHours").focus();
                return false;
            }--%>
            //End Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 

            else if (disallowNegativeNumeric(objWorkHours, "Please enter positive integer") == false) {
            //else if (disallowNegativeNumeric(objWorkHours, alertify.error("<%= MyBase.GetResourceString("A_PositiveInt") %>")) == false) {


                if (objWorkHours.value < 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveWorkHours") %>");
                    objWorkHours.disabled = true;
                    document.getElementById("txtHours").focus();
                    return false;

                }
                // Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
                <%--else if (objWorkHours.value == 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_WorkHoursGreZero") %>");
                     document.getElementById("txtHours").focus();
                    objWorkHours.disabled = true;
                    return false;
                }--%>
                //End Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
                else if (Date.parse(objStartDate.value) > Date.parse(objReqEndDate.value)) {
                    alertify.error("<%= MyBase.GetResourceString("A_ReqEndgreThanStartDate") %>");
                    document.getElementById("txtPrEndDate").focus();
                    return false;
                }
                else if (Date.parse(objReqEffectiveDate.value) > Date.parse(objReqEndDate.value)) {
                    alertify.error("<%= MyBase.GetResourceString("A_EffeDateLessReqEndDate") %>");
                    //Added By Rutuja D. 10 Jan 2020 for Misplace Focus
                    //document.getElementById("txtPrEndDate").focus();
                    $("#txtPrEffeDate").focus();
                    //End of Added By Rutuja D. 10 Jan 2020 for Misplace Focus
                    return false;
                }
                else if (Date.parse(objReqEndDate.value) > Date.parse(objEndDate.value)) {
                    alertify.error("<%= MyBase.GetResourceString("ReqEndDateessEndDate") %>");
                    document.getElementById("txtPrEndDate").focus();
                    return false;
                }

                //Commented & Added By Rutuja D. 8 Jan 2020 For Fet Focus On TextBox
                //if (disallowDate1GreaterThanOrEqualToDate2(objToday, objStartDate) == false) {
                if ((Date.parse(objToday.value) <= Date.parse(objStartDate.value)) == false) {

                    if (Date.parse(objStartDate.value) >= Date.parse(objReqEffectiveDate.value)) {
                        alertify.error("<%= MyBase.GetResourceString("A_EffeDateGreEqualStartDate") %>");
                        $("#txtPrEffeDate").focus();
                        return false;
                    }
                }
                //Commented & Added By Rutuja D. 8 Jan 2020 For Fet Focus On TextBox

                else {
                    if (Date.parse(objPrevAllocation.value) != Date.parse(objNewAllocation.value)) {
                        if (Date.parse(objToday.value) > Date.parse(objReqEffectiveDate.value)) {
                            alertify.error("<%= MyBase.GetResourceString("A_EffDateGreToday") %>");
                            document.getElementById("txtPrEffeDate").focus();
                            return false;
                        }
                    }
                }
            }
            else if (Date.parse(objReqEndDate.value) > Date.parse(objEndDate.value)) {
                alertify.error("<%= MyBase.GetResourceString("A_EndDatelessrequestEndDate") %>");
                document.getElementById("txtPrEndDate").focus();
                return false;
            }
            else if (Date.parse(objStartDate.value) > Date.parse(objReqEndDate.value)) {
                alertify.error("<%= MyBase.GetResourceString("A_ReqEndDateNotLessStartDate") %>");
                // Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
                // document.getElementById("txtStartDate").focus();
                $("#txtPrEffeDate").focus();
                //End Commented By Rutuja D. 10 Jan 2020 For Giving Wrong alert 
                return false;
            }

            return true;
        }


        //Save Prepone Request
        function SavePreponeRequest() {

            if (txtPrPerOfDayOnchange() == true) {
                if (ValidPreponeAllocation() == true) {
                    //if (validWorkHoursAndPrevAllocation() == true) {

                    var ResourcePoolID = "";
                    var RoleID = "";
                    RequestParameters = {
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                    }

                    var param = JSON.stringify(RequestParameters);
                    Result = AJAXCallWithResult("/api/PM_RequestedResources/GetResourcePoolAndRoleId", param, false);
                    for (var i = 0; i < Result.length; i++) {
                        ResourcePoolID = Result[i]["ResourcePoolID"];
                        RoleID = Result[i]["RoleID"];

                    }

                    var RequestedStartDate = $("#txtPrEffeDate").val();
                    var RequestedEndDate = $("#txtPrEndDate").val();

                    var WorkHour = $("#txtPrNewWorkHour").val();
                    if (WorkHour.indexOf(":") > -1) {

                        var RequestParameters = {
                            WorkHrs: encodeURI(WorkHour),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                        if (NewAllocationValue.indexOf('.00') > -1) {
                            var WorkHours = NewAllocationValue.replace(".00", "");

                        }
                        else {
                            var WorkHours = NewAllocationValue;
                        }
                    }

                    var Specialrequest = $("#txtPrSpeRequest").val();
                    //Added By Dipali V On 18th March 2025 For Allocation Changes
                    var NewAllocationPre = $("#txtPrPerOfDay").val();

                    RequestParameters = {
                        RequestID: encodeURI(RequestID),
                        EmployeeID: encodeURI(ChngEmployeeID),
                        ProjectID: encodeURI(ProjectID),
                        ProjectEmployeeRoleID: encodeURI(ProjectEmployeeRoleID),
                        UserName: encodeURI(UserName),
                        UserID: encodeURI(UserID),
                        RequestedStartDate: encodeURI(RequestedStartDate),
                        RequestedEndDate: encodeURI(RequestedEndDate),
                        WorkHour: encodeURI(NewAllocationValue),
                        Specialrequest: encodeURI(Specialrequest),
                        ResourcePoolID: encodeURI(ResourcePoolID),
                        RoleID: encodeURI(RoleID),
                        RequestType: encodeURI(GlobalRequestType),
                        //Added By Dipali V On 18th March 2025 For Allocation Changes
                        NewAllocationPre: encodeURI(NewAllocationPre),
                        //End of Added By Dipali V On 18th March 2025 For Allocation Changes
                    }

                    var param = JSON.stringify(RequestParameters);
                    StrResult = AJAXCallWithResult("/api/PM_RequestedResources/UpdatePreponeRequest", param, false);

                    if (StrResult != '') {
                        alertify.success("<%= MyBase.GetResourceString("A_PreponeRequestDetails") %>");
                        EditPreponeRequest(ProjectEmployeeRoleID, RequestID);

                    }

                }
            }
            //}

        }

        //Status Converted Into Actual Status means Status ='R' that value is 'Ready For Assignment'
        function ResourceRequest_GetStatusString(RequestorID) {
            var param = JSON.stringify(encodeURI(RequestorID));
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/ResourceRequest_GetStatusString", param, false);
            return strResult
        }

        // Priority DropDown Binding
        function GetPriority() {
            var GroupID = 2
            var param = JSON.stringify(encodeURI(GroupID));
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetPriority", param, false);

            var objCbo1 = document.getElementById("cboResourcePriority");

            $("#cboResourcePriority option").remove();

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);

                objOption.text = Objresult.Priority;
                objOption.value = Objresult.ParameterID == 0 ? '' : Objresult.ParameterID;

            }

        }

        // Resource Pool DropDown Binding
        function GetResourcePool() {
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetResourcePool", '', false);

            var objCbo1 = document.getElementById("cboResourceResourcePool");

            $("#cboResourceResourcePool option").remove();

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);

                objOption.text = Objresult.ResourcePoolName;
                objOption.value = Objresult.ResourcePoolID == 0 ? '' : Objresult.ResourcePoolID;

            }

        }

        // Resource Type DropDown Binding
        function GetResourceType(RequestID)
        {
            var RequestParameters = {
                RequestID: encodeURI(RequestID)
              
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetResourceType", param, false);

            var objCbo1 = document.getElementById("cboResourceType");

            $("#cboResourceType option").remove();

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);

                objOption.text = Objresult.RequestedType;
                objOption.value = Objresult.RequestedTypeID == 0 ? '' : Objresult.RequestedTypeID;

            }

        }

        // Change Request List Plotting
        function GetChangeRequestList() {

            $("#chngresourcereqtbl").dataTable().fnDestroy();
            StartLoader("#RequestBody");

            var Status = $("#cboStatus").find(':selected').val();
           
            var SearchID = $("#txtSearch").val();
            var VendorID = $("#cboVendorFilter").find(':selected').val();

            if (Status == "") {
                Status = "0";
            }

            if (SearchID == "") {
                SearchID = "0";
            }
            if (VendorID == "") {
                VendorID = "0";
            }
            var FilterParameter = {
                ProjectID: encodeURI(ProjectID),
                Status: encodeURI(Status),
                SearchID: encodeURI(SearchID),
                VendorID: encodeURI(VendorID)
            }
            
            var param = JSON.stringify(FilterParameter);



           
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetChangeRequestList", param, false);


            $("#chngRequestedtblbody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var ChangeRequestID = strResult[i]["RequestID"]
                var EmployeeName = strResult[i]["EmployeeName"];
                var RequestDate = strResult[i]["RequestDate"];
                var FromDate = strResult[i]["FromDate"];
                var ToDate = strResult[i]["ToDate"];
                var Requestor = strResult[i]["Requestor"];
                var WorkHours = strResult[i]["WorkHours"];
                //var Status = strResult[i]["Status"];
                var AllocationType = strResult[i]["AllocationType"];
                var RequestType = strResult[i]["Requesttype"];
                var ProjectEmployeeRoleID = strResult[i]["ProjectEmployeeRoleID"];
                var EmployeeID = strResult[i]["EmployeeID"]
                if (ChangeRequestID != undefined || ChangeRequestID != null || ChangeRequestID != '') {
                    var Status = ResourceRequest_GetStatusString(ChangeRequestID);
                }

                var RequestParameters = {
                    RequestID: encodeURI(ChangeRequestID),

                }
                var param = JSON.stringify(RequestParameters);

                var Savelink = AJAXCallWithResult("/api/PM_RequestedResources/SaveLinkPlotting", param, false);

                strHTML += '<tr>'
                <% If m_blnEditAccess = True Then %>
                <%-- if (Savelink == false) {
                    strHTML += '<td class="reqid">'
                    strHTML += '<a href="javascript:;" class="RreqID" style="text-decoration:underline" onclick=RequestIDClick(' + EmployeeID + ',' + ProjectEmployeeRoleID + ',' + ChangeRequestID + ',&quot;' + escape(RequestType) + '&quot;)  ><span data-bs-toggle="tooltip" title="View Detail" data-placement="bottom" class="idlabel">' + ChangeRequestID + '</span></a>'
                    strHTML += '</td>'
                }
                else {
                    strHTML += '<td class="reqid">'
                    strHTML += '<span data-bs-toggle="tooltip" class="idlabel">' + ChangeRequestID + '</span>'
                    strHTML += '</td>'
                }
                <% Else %>--%>
                //strHTML += '<td class="reqid">'
                //strHTML += '<span data-bs-toggle="tooltip" class="idlabel">' + ChangeRequestID + '</span>'
                //strHTML += '</td>'


                if (Status == "Assigned") {
                    strHTML += '<td class="reqid">'
                    strHTML += '<span data-bs-toggle="tooltip" class="idlabel">' + ChangeRequestID + '</span>'
                    strHTML += '</td>'
                }
                //Added By Rutuja D. 15 Jan 2020 For Reject Resource Link Not Unable
                else if (Status == "Rejected") {
                    strHTML += '<td class="reqid">'
                    strHTML += '<span data-bs-toggle="tooltip" class="idlabel">' + ChangeRequestID + '</span>'
                    strHTML += '</td>'
                }
                else if (Status == "Declined") {
                    strHTML += '<td class="reqid">'
                    strHTML += '<span data-bs-toggle="tooltip" class="idlabel">' + ChangeRequestID + '</span>'
                    strHTML += '</td>'
                }
                //End Added By Rutuja D. 15 Jan 2020 For Reject Resource Link Not Unable
                else {
                    strHTML += '<td class="reqid">'
                    //Commented & Added By Rutuja D. 15 Jan 2020 For Get New Parameter Status
                    // strHTML += '<a href="javascript:;" class="RreqID" style="text-decoration:underline" onclick=RequestIDClick(' + EmployeeID + ',' + ProjectEmployeeRoleID + ',' + ChangeRequestID + ',&quot;' + escape(RequestType) + '&quot;)  ><span data-bs-toggle="tooltip" title="View Detail" data-placement="bottom" class="idlabel">' + ChangeRequestID + '</span></a>'
                    strHTML += '<a href="javascript:;" class="RreqID" style="text-decoration:underline" onclick=RequestIDClick(' + EmployeeID + ',' + ProjectEmployeeRoleID + ',' + ChangeRequestID + ',&quot;' + escape(RequestType) + '&quot;' + ',&quot;' + escape(Status) + '&quot;)  ><span data-bs-toggle="tooltip" title="View Detail" data-placement="bottom" class="idlabel">' + ChangeRequestID + '</span></a>'
                    //End Commented & Added By Rutuja D. 15 Jan 2020 For Get New Parameter Status

                    strHTML += '</td>'
                }


                //strHTML += '<td class="reqid">'
                //strHTML += '<a href="javascript:;" class="RreqID" style="text-decoration:underline" onclick=RequestIDClick(' + EmployeeID + ',' + ProjectEmployeeRoleID + ',' + ChangeRequestID + ',&quot;' + escape(RequestType) + '&quot;)  ><span data-bs-toggle="tooltip" title="View Detail" data-placement="bottom" class="idlabel">' + ChangeRequestID + '</span></a>'
                //strHTML += '</td>'
                 <% Else %>
                strHTML += '<td class="reqid">'
                strHTML += '<span data-bs-toggle="tooltip" class="idlabel">' + ChangeRequestID + '</span>'
                strHTML += '</td>'
                <% End If %>
                strHTML += '<td>' + EmployeeName
                strHTML += '</td>'
                strHTML += '<td>' + RequestDate
                strHTML += '</td>'
                strHTML += '<td>' + FromDate
                strHTML += '</td>'
                strHTML += '<td>' + ToDate
                strHTML += '</td>'
                strHTML += '<td>' + WorkHours
                strHTML += '</td>'
                strHTML += '<td>' + AllocationType
                strHTML += '</td>'
                strHTML += '<td>' + RequestType
                strHTML += '</td>'
                strHTML += '<td><label class="btn btn-yellow btn-xs" autocomplete="off">' + Status + '</label>'
                strHTML += '</td>'

                strHTML += '</tr>'

            }

            $("#chngRequestedtblbody").html("")
            $("#chngRequestedtblbody").html(strHTML);

            StopAjaxLoader("#RequestBody");
            var stdTable1 = $("#chngresourcereqtbl").DataTable({
                "order": [],
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "columnDefs": [{
                    'width': '10%',
                    'targets': [8], /* column index */
                    'orderable': false, /* true or false */
                }],
                "drawCallback": function (settings) {
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }

            });

            stdTable1.columns.adjust().draw();
            $(".dataTables_scrollHeadInner").css({ "width": "100%" });
            $(".table ").css({ "width": "100%" });

            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
            });


            if (strHTML == "") {
                $("#chngresourcereqtbl tbody tr td").prop("colspan", 9);
            }
            //Added by pradip on 17-01-2020
            setTimeout(function(){
        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
            }, 350); 



        }

        //Binding Edit Request Resources
        var JDAttachmentFileName = "";
        var Savelink = "";
        //var Savelink_New = "";

        // Added by Dipali V on 13th May 2026 - Purpose:-Clear stuck disabled state when switching request status (e.g. Ready for Assignment -> Submitted).
        function getRRDetailPanelEditableFields() {
            return $("#RRdetailpanel .formbody").find("select, input:not([type='hidden']), textarea");
        }

        function resetRRDetailPanelEditability() {
            getRRDetailPanelEditableFields().prop("disabled", false);
            $("#btnSelectFile").prop("disabled", false);
            $("#cboResourceRequestor").prop("disabled", true);
            $("#txtResourceNatureofRequest").prop("disabled", true);
        }

        function applyRRDetailPanelEditabilityByStatus(requestTypeForPanel) {
            resetRRDetailPanelEditability();
            var reqType = requestTypeForPanel || "";
            if (Savelink == true) {
                if ((GlobalSelectedStatus == "Assigned" || GlobalSelectedStatus == "Ready for Assignment") && reqType == "") {
                    $("#SaveRequest").show();
                    getRRDetailPanelEditableFields()
                        .not("#cboResourceRequestor, #txtResourceNatureofRequest")
                        .prop("disabled", true);
                    $("#txtResourceBillingStartDate").prop("disabled", false);
                    $("#txtResourceSpecialRequest").prop("disabled", true);
                } else {
                    getRRDetailPanelEditableFields()
                        .not("#cboResourceRequestor, #txtResourceNatureofRequest")
                        .prop("disabled", false);
                    $("#txtResourceSpecialRequest").prop("disabled", false);
                }
            } else {
                $("#SaveRequest").show();
                $("#SendEmail").show();
                $("#DivJDattahcment").show();
                $("#btnSelectFile").prop("disabled", false);
            }
        }

        function EditRequestResource(RequestID, RequestType) {
           // alert(RequestType);
            $("#txtHiddenRequestType").val(RequestType);
            if (RequestType == '' || RequestType == null || RequestType == undefined) {
                var Flag = 1;
                RequestType = "";
            }
            else {
                var Flag = 0;
            }
            var RequestParameters = {
                RequestID: encodeURI(RequestID),
                Flag: encodeURI(Flag)
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/EditRequestResource", param, false);

            for (var i = 0; i < strResult.length; i++) {
                //debugger;
                var RoleID = strResult[i].RoleID;
                var Type = strResult[i].Type;
                var WorkHours = strResult[i].WorkHours;
                var NoOfResources = strResult[i].NoOfResources;
                var ResourcePoolID = strResult[i].ResourcePoolID;
                var ToDate = strResult[i].ToDate;
                var FromDate = strResult[i].FromDate;
                var Priority = strResult[i].Priority;
                var SpecialRequest = strResult[i].SpecialRequest;
                var RequestID = strResult[i].RequestID;
                var Status = $.trim(strResult[i].Status);
                var CancelComment = strResult[i].CancelComment;
                var RejectComment = strResult[i].RejectComment;
                //Added By Dipali V On 15th Nov 2022 For Sonata Customzation
                var TypeofRequirement = strResult[i].TypeofRequirement;
                var ReplacementEmployeeName = strResult[i].ReplacementEmployeeName;
                var EngagementModel = strResult[i].EngagementModel;
                var BillablePosition = strResult[i].BillablePosition;
                var BillingStartDate = strResult[i].BillingStartDate;
                var SOWAvailable = strResult[i].SOWAvailable;
                var NatureofRequest = strResult[i].NatureofRequest;
                var DepartmentID = strResult[i].DepartmentID;
                var LocationID = strResult[i].LocationID;
                //Added By Dipali V On 8th May 2023 For Vendor Dropdown in Edit Resource Request
                var VendorID = strResult[i].VendorID;
                //End of Added By Dipali V On 8th May 2023 For Vendor Dropdown in Edit Resource Request
                /*var vendorParam = JSON.stringify(encodeURI(RequestID));*/
              /*  var VendorID = AJAXCallWithResult("/api/PM_RequestedResources/GetRequestVendorByRequestID", vendorParam, false);*/
                var JDOriginalFileName = strResult[i].JDOriginalFileName;
                var JDSystemFileName = strResult[i].JDSystemFileName;
                //End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation
                Savelink = AJAXCallWithResult("/api/PM_RequestedResources/SaveLinkPlotting", param, false);
                //if (Savelink != "") {
                //    debugger;
                //    Savelink = Savelink.split("||");
                //    Savelink = Savelink[0];
                //   // Savelink_New = Savelink[1];

                //}

                if (RequestID != undefined || RequestID != null || RequestID != '') {
                    var StatusString = ResourceRequest_GetStatusString(RequestID);
                }
                if (ResourcePoolID == '0') {
                    ResourcePoolID = '';
                }
                if (Type == '0') {
                    Type = '';
                }
                if (Priority == '0') {
                    Priority = '';
                }

                if (TypeofRequirement == null || TypeofRequirement == "") {
                    TypeofRequirement = "0";
                }

                if (ReplacementEmployeeName == null || ReplacementEmployeeName == "") {
                    ReplacementEmployeeName = "0";
                }

                if (EngagementModel == null || EngagementModel == "") {
                    EngagementModel = "0";
                }

                if (BillablePosition == null || BillablePosition == "") {
                    BillablePosition = "0";
                }

                if (SOWAvailable == "0") {
                    SOWAvailable = "2";
                }

                if (SOWAvailable == null || SOWAvailable == "") {
                    SOWAvailable = "0";
                }

                if (DepartmentID == null || DepartmentID == "") {
                    DepartmentID = "0";
                }
                if (VendorID == null || VendorID == "") {
                    VendorID = "0";
                }

                

                $("#cboResourceRequestor").val(RoleID);
                 //Added By Dipali V On 15th Nov 2022 For Sonata Customzation
                $("#cboResourceTypeofRequirement").val(TypeofRequirement);
                if (TypeofRequirement == 2) {
                    $("#cboResourceReplacementEmployeeName").prop("disabled", false);
                }
                $("#cboResourceLocationID").val(LocationID);
                $("#cboResourceDepartmentID").val(DepartmentID);
                //debugger;
                FillRequestVendorDropdown(VendorID, VendorID);
                $("#cboResourceReplacementEmployeeName").val(ReplacementEmployeeName);
                $("#cboResourceEngagementModel").val(EngagementModel);
                $("#txtResourceBillingStartDate").val(BillingStartDate);
                $("#cboResourceSOWAvailable").val(SOWAvailable);
                $("#txtResourceNatureofRequest").val(NatureofRequest);
                $("#cboResourceBillablePosition").val(BillablePosition);
                if (BillablePosition == 1) {
                    $("#txtResourceBillingStartDate").prop("disabled", false);
                    if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                        $("#lblbillingstartdate").addClass("required");
                    } else {
                        $("#lblbillingstartdate").removeClass("required");
                    }
                }
                else {
                    $("#txtResourceBillingStartDate").prop("disabled", true);
                    $("#lblbillingstartdate").removeClass("required");
                }
                 //End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation
                $("#cboResourceRequestor").prop("disabled", true);
                var Role = $("#cboResourceRequestor option:selected").text();
                $("#cboResourceType").val(Type);
                $("#txtResourceWorkHours").val(WorkHours);
                $("#txtResourceNoOfResources").val(NoOfResources);
                // New: also read JDAttachmentPath (direct file URL from tbl_PM_ResourceRequest)
                //var jdAttachmentPath = strResult[i].JDAttachmentPath || '';

                if (JDOriginalFileName.indexOf('/') === 0) {
                    JDAttachmentFileName = JDSystemFileName;
                    // Display only the filename — strip any folder prefix (e.g. "Uploads/JDAttachments/")
                    var jdDisplayName = JDOriginalFileName.split('/').pop();
                    $("#FILENAME0").text(jdDisplayName).attr('title', jdDisplayName);
                } else {
                    // Fall back to old attachment table logic (Tbl_Whizible_ResourceRequestAttachment)
                    JDAttachmentFileName = JDSystemFileName;
                    if (JDOriginalFileName == null || JDOriginalFileName == "") {
                        JDOriginalFileName = "NA";
                    }
                    $("#FILENAME0").text(JDOriginalFileName).attr('title', JDOriginalFileName);
                }
                $("#cboResourceResourcePool").val(ResourcePoolID);
                $("#txtResourceToDate").val(ToDate);
                $("#txtResourceFromDate").val(FromDate);
                $("#cboResourcePriority").val(Priority);
                $("#txtResourceSpecialRequest").val(SpecialRequest);
                $("#txtResourceCancelComment").val(CancelComment);
                if (Role == '') {
                    $("#SpanRole").text('Not Specified');
                }
                else {
                    $("#SpanRole").text(Role);
                }

                $("#SpanRoleId").text(RequestID);
                $("#StatusString").text(StatusString);
                //alert(Status);
                //debugger;
                if (Savelink == true) {
                    $("#SaveRequest").hide();
                    $("#SendEmail").hide();
                    $("#btnSelectFile").prop("disabled", true);
                    //Added By Dipali V On 23th Dec 2022 For enabled Fields; reset + apply per status (13 May 2026 fix stuck disabled)
                    applyRRDetailPanelEditabilityByStatus(RequestType);
                    if (TypeofRequirement != 2) {
                        $("#cboResourceReplacementEmployeeName").prop("disabled", true);
                    }
                    if (BillablePosition == 1) {
                        $("#txtResourceBillingStartDate").prop("disabled", false);
                    } else if (!((GlobalSelectedStatus == "Assigned" || GlobalSelectedStatus == "Ready for Assignment") && RequestType == "")) {
                        $("#txtResourceBillingStartDate").prop("disabled", true);
                    }
                    //End of Added By Dipali V On 23th Dec 2022 For enabled Fields
                }
                else {
                    resetRRDetailPanelEditability();
                    $("#SaveRequest").show();
                    $("#SendEmail").show();
                    $("#DivJDattahcment").show();
                    $("#btnSelectFile").prop("disabled", false);
                }

               

                //Commented & Added By Rutuja D. 15 jan 2020 For Close Request Button Conditionally Plotting
                //if (Status == 'C' || RequestType != '' || Status == 'A' ) {
                //    $("#CloseRequest").hide();
                //}
                if (Status == 'C') {
                    $("#CloseRequest").hide();
                }
                else if (Status == 'A' && RequestType == 'Extend Requests') {
                    $("#CloseRequest").show();
                }
                else {
                    $("#CloseRequest").show();
                }
                //End Commented & Added By Rutuja D. 15 jan 2020 For Close Request Button Conditionally Plotting

                if (Status == 'REJECT') {
                    $("#DeclineComment").show();
                    $("#txtDeclineComment").val(RejectComment);
                }
                else {
                    $("#DeclineComment").hide();
                }

            }

            GetAssignedResourcesList(RequestID);


            //Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert

            CheckResourcePoolMandatory();
            if (ResourcePoolIsMandatory == 1) {
                $("#lblResourcePool").addClass('required');
            }
            else {
                $("#lblResourcePool").removeClass('required');
            }
            //End Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert
        }

        // Assigned Resources List Plotting        
        function GetAssignedResourcesList(RequestID) {

            StartLoader("#RequestBody");
            $("#AssignedResourcesTbl").dataTable().fnDestroy();
            var EmployeeID = '';
            var RequestParameters = {
                RequestID: encodeURI(RequestID)
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetAssignedResourcesList", param, false);

            $("#AssignedResourcesTblBody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var RequestID = strResult[i]["RequestID"];
                var ResourceName = strResult[i]["employeename"];
                var RoleDescription = strResult[i]["roledescription"];
                var ResourceLoading = strResult[i]["Resource Loading"];
                var WorkHoursPerday = strResult[i]["WorkHours"];
                var EmployeeID = strResult[i]["EmployeeID"];
                var ProjectEmployeeRoleID = strResult[i]["ProjectEmployeeRoleID"];
                var FromDate = strResult[i]["FromDate"];
                var ToDate = strResult[i]["ToDate"];
                var TotalRequestedHrs = strResult[i]["TotalRequestedHrs"];
                var PercentageAllocation = strResult[i]["PercentageAllocation"];

                var Resume = strResult[i]["Resume"];
                var Status = $.trim(strResult[i]["Status"]);
                if (Status == "A") {
                    Status = "ALLOCATED";
                }
                else if (Status == "R") {
                    Status = "REJECTED";
                }
                else if (Status == "L") {
                    Status = "ASSIGNED TO PROJECT";
                }
                else if (Status == "REVERT") {
                    Status = "REVERTED";
                }

                strHTML += '<tr>'
                strHTML += '<td>' + ResourceName + '</td>'
                strHTML += '<td>' + RoleDescription + '</td>'
                strHTML += '<td>' + FromDate + '</td>'
                strHTML += '<td>' + ToDate + '</td>'
                strHTML += '<td><a href="javascript:; onclick=ResourceUtilizationOnclick(' + EmployeeID + ')">' + ResourceLoading + '</a></td>'
                strHTML += '<td>' + WorkHoursPerday + '</td>'
                strHTML += '<td><a href="javascript:; Onclick= Resume_OnClick(' + EmployeeID + ')">' + Resume + '</a></td>'
                strHTML += '<td>' + TotalRequestedHrs + '</td>'
                strHTML += '<td>' + PercentageAllocation + '</td>'


                <%If m_blnDeleteAccess = True Then%>

                if (Status == "ASSIGNED TO PROJECT" || Status == "REJECTED" || Status == "REVERTED") {
                    strHTML += '<td class="action-status" style="cursor:no-drop;" >'
                    strHTML += '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-original-title="Already Assigned" data-placement="bottom" class="act-stas-main disabled""><i class="far fa-thumbs-up" id="AssignedResource' + i + '"></i></a>/ '
                    strHTML += '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-original-title="Already Rejected" data-placement="bottom" id="RejectResource" class="act-stas-main disabled"><i class="far fa-thumbs-down"></i></a>'
                    strHTML += '</td>'
                }
                else {
                    strHTML += '<td class="action-status" >'
                    //Commented & Added By Rutuja D. 15 Jan 2020 For Get From Date For Assign Resource 
                    //strHTML += '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-original-title="Assign" data-placement="bottom" onclick="AssignedResource(' + RequestID + ',' + EmployeeID  +')"><i class="far fa-thumbs-up" id="AssignedResource' + i + '"></i></a>/ '
                    strHTML += '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-original-title="Assign" data-placement="bottom" onclick="AssignedResource(' + RequestID + ',' + EmployeeID + ',' + '&quot;' + escape(FromDate) + '&quot;' + ')"><i class="far fa-thumbs-up" id="AssignedResource' + i + '"></i></a>/ '
                    //Commented & Added By Rutuja D. 15 Jan 2020 For Get From Date For Assign Resource 
                    strHTML += '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-original-title="Reject" data-placement="bottom" id="RejectResource" onclick="GetRejectResource(' + RequestID + ',' + EmployeeID + ')"><i class="far fa-thumbs-down"></i></a>'
                    strHTML += '</td>'
                }
                <% End If %>


                strHTML += '<td> <label class="btn btn-success btn-xs" autocomplete="off">' + Status + '</label></td>'
                strHTML += ' </tr>'

            }
            $("#AssignedResourcesTblBody").html("")
            $("#AssignedResourcesTblBody").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();
            StopAjaxLoader("#RequestBody");
            $("#AssignedResourcesTbl").DataTable({
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "retrieve": true,
                "columnDefs": [{
                    //'width': '10%',
                    'targets': [4, 6], /* column index */
                    'orderable': false, /* true or false */
                }],

            });
            $(".dataTables_scrollHeadInner").css({ "width": "100%" });
            $(".table ").css({ "width": "100%" });
             <%If m_blnDeleteAccess = True Then%> 

            if (strHTML == "") {

                $("#AssignedResourcesTbl").css('display', 'table'); //modified by pradip on 08-01-2019
                $("#AssignedResourcesTbl tbody tr td").prop("colspan", 11);
            }
                <% Else %>
            if (strHTML == "") {
                $("#AssignedResourcesTbl").css('display', 'table');//modified by pradip on 08-01-2019
                $("#AssignedResourcesTbl tbody tr td").prop("colspan", 11);
            }
                <% End If %>



        }

        //Assigned Resources
        //Added By Rutuja D. 15 Jan 2020 For Check Assign Resource is Assign Current Date
        function AssignedResource(RequestID, EmployeeID, FromDate) {
         // debugger;
            var objCurrentDate = $("#txtToday").val();
            var FromDate = unescape(FromDate).trim();
            //Commented And Added By Chetan on 18th Jan 2020
            //if (objCurrentDate < FromDate) {
            if (Date.parse(objCurrentDate) < Date.parse(FromDate)) {
             //End Commented And Added By Chetan on 18th Jan 2020
                alertify.error('You can not assign this resource before &#39;' + FromDate + '&#39;');
            }
            else {
                //End Added By Rutuja D. 15 Jan 2020 For Check Assign Resource is Assign Current Date

                var RequestParameters = {
                    RequestID: encodeURI(RequestID),
                    EmployeeID: encodeURI(EmployeeID)
                }
                var param = JSON.stringify(RequestParameters);
                var strResult = AJAXCallWithResult("/api/PM_RequestedResources/AssignedResource", param, false);
                var Flag = strResult

                if (Flag == 1) {
                    window.open("../Email/SendEmail.aspx?MessageID=503&EmployeeID=" + EmployeeID + "&RequestID=" + RequestID + "&UserID=" + UserID + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');

                }
                alertify.success('<%= MyBase.GetResourceString("A_AssignedResources") %>');
                //if (RequestType != "Extend Requests") {
                //    EditRequestResource(RequestID);
                //    GetAssignedResourcesList(RequestID);

                //} else {

                //    GetChangeRequestList();
                //}

                   EditRequestResource(RequestID);
                GetAssignedResourcesList(RequestID);

            } //End Added By Rutuja D. 15 Jan 2020 For Close Else bracket
            //GetAssignedResourcesList(RequestID);
        }

        //Reject Resources
        function GetRejectResource(RejectRequestID, RejectEmployeeID) {

            EmployeeID = RejectEmployeeID;
            var RequestParameters = {
                RequestID: encodeURI(RejectRequestID),
                EmployeeID: encodeURI(RejectEmployeeID)

            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetAssignedResourcesList", param, false);

            var strHtml = "";
            for (var i = 0; i < strResult.length; i++) {
                var RequestID = strResult[i]["RequestID"];
                var EmployeeName = strResult[i]["employeename"];
                var AssignmentDate = strResult[i]["AssignmentDate"];
                var WorkHoursPerday = strResult[i]["WorkHours"];
                var FromDate = strResult[i]["FromDate"];
                var ToDate = strResult[i]["ToDate"];

                strHtml += '<tr><th width="30%" align="left"><strong> Employee<span> Name</strong></th>'
                strHtml += '<td>' + EmployeeName + '</td></tr>'
                strHtml += '<tr><th align="left"><strong> Assignment Date</strong></th>'
                strHtml += '<td>' + AssignmentDate + '</td></tr>'
                strHtml += '<tr><th align="left"><strong> From Date</strong> </th>'
                strHtml += '<td>' + FromDate + '</td></tr>'
                strHtml += '<tr><th align="left"><strong> To Date</strong></th>'
                strHtml += '<td>' + ToDate + '</td></tr>'
                strHtml += '<tr><th align="left"><strong> Work Hours</strong></th>'
                strHtml += '<td>' + WorkHoursPerday + '</td></tr>'
            }
            $("#RejectCommentsBody").html();
            $("#RejectCommentsBody").html(strHtml);
            $("#txtResourceRejectComment").val('');
            $("#RejectRequestinfomodal").modal("show");

        }

        function ApplyRejectResource() {

            var RejectComment = $("#txtResourceRejectComment").val();
            if (isBlank(RejectComment)) {
                alertify.error('<%= MyBase.GetResourceString("A_RejectCommentsfield") %>');
                $('#txtResourceRejectComment').focus();
                return false;
            }
            else {

                var RequestParameters = {
                    EmployeeID: encodeURI(EmployeeID),
                    RequestID: encodeURI(RequestID),
                    UniqueComment: encodeURI(RejectComment)

                }
                var param = JSON.stringify(RequestParameters);
                var strResult = AJAXCallWithResult("/api/PM_RequestedResources/ApplyRejectResource", param, false);

                var Flag = strResult

                if (Flag == 1) {
                    //added by Chetan M on 9th Jan 2020
                    $("#RejectRequestinfomodal").modal('hide');
                    //End of addded by Chetan M on 9th Jan 2020
                    window.open("../Email/SendEmail.aspx?MessageID=203&EmployeeID=" + EmployeeID + "&RequestID=" + RequestID + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');

                }
                alertify.success('<%= MyBase.GetResourceString("A_RejectResource") %>');

                //GetAssignedResourcesList(RequestID);
                //GetRequestedResourcesList(ProjectID);
                EditRequestResource(RequestID);
                GetAssignedResourcesList(RequestID);
            }

        }

        //Close Request
        function CloseRequest() {

            var CloseComment = $("#txtResourceCancelComment").val();
            if (isBlank(CloseComment)) {
                //Commented and added by Chetan M on 11th Jan 2020 for IssueID 21255
                <%--alertify.error('<%= MyBase.GetResourceString("A_CloseComments") %>');--%>
                alertify.error('Enter Close Comment.');
                //End of added by Chetan M on 11th Jan 2020
                $('#txtResourceCancelComment').focus();
                return false;
            }
            else {
                // added by Chetan M on 12th Jan 2020
                //$("#CloseRequestomodal").modal("show");
                CloseRequestFunction();
               <%-- var RequestParameters = {
                    RequestID: encodeURI(RequestID),
                    UniqueComment: encodeURI(CloseComment)
                }
                var param = JSON.stringify(RequestParameters);
                var result = AJAXCallWithResult("/api/PM_RequestedResources/CloseRequest", param, false);
                alertify.success('<%= MyBase.GetResourceString("A_RequestClosed") %>');
                GetAssignedResourcesList(RequestID);
                GetRequestedResourcesList(ProjectID);

                EditRequestResource(RequestID);--%>
                //End of commented and added by Chetan M on 12th Jan 2020
            }
        }


        //Added by Chetan M on 12th Jan 2020
        function CloseRequestFunction() {
            var CloseComment = $("#txtResourceCancelComment").val();
            var UserName = '<%= Session("strUserName") %>';
            var RequestParameters = {
                RequestID: encodeURI(RequestID),
                UniqueComment: encodeURI(CloseComment),
                UserName: UserName,
            }
            var param = JSON.stringify(RequestParameters);
            var result = AJAXCallWithResult("/api/PM_RequestedResources/CloseRequest", param, false);
                <%--alertify.success('<%= MyBase.GetResourceString("A_RequestClosed") %>');--%>
            alertify.success('Request Closed Successfully.');
            GetAssignedResourcesList(RequestID);
            GetRequestedResourcesList(ProjectID);
            EditRequestResource(RequestID,RequestType);
        }
        // }
        //End of added by Chetan M on 12th Jan 2020

        //Show Decline Comment
        function DeclineComment() {
            $("#DeclineRequestinfomodal").modal("show");
        }

        //Send Email Functionality
        function SendEmailClick() {
            var RequestParameters = {
                RequestID: encodeURI(RequestID),
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/SendEmail", param, false);

            var Flag = strResult

            if (Flag == 1) {
                window.open("../Email/SendEmail.aspx?MessageID=75&RequestID=" + RequestID + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');

            }

        }

        //Function for direct to  Resource Loading Page
        function ResourceUtilizationOnclick(EmployeeID) {

            var ProjectName = $("#cboResourceProjects option:selected").text();

            EmployeeID = EmployeeID;
            generatetokenResourceLoading(EmployeeID)

            //var url = "../PM/PM_ResourceLoading.aspx?PKToken=" + m_CurrentToken + "&ProjectID=" + ProjectID + " &EmployeeID=" + EmployeeID + "&UserID=" + UserID + "&ProjectName=" + ProjectName+" &Link=AR";
            //window.location.href = url;
            //window.open("../../HR/HR_EmployeeResume.aspx?EmployeeID=" + intEmployeeID + "&MasterTagId=3861", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");
            window.open("../PM/PM_ResourceLoading.aspx?PKToken=" + m_CurrentToken + "&ProjectID=" + ProjectID + " &EmployeeID=" + EmployeeID + " &Link=AR" + "&ProjectName=" + ProjectName + "&MasterTagId=3861", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");

            //var url = "../PM/PM_ResourceLoading.aspx?PKToken=" + m_CurrentToken + "&ProjectID=" + ProjectID + " &EmployeeID=" + EmployeeID + " &Link=AR" + "&ProjectName=" + ProjectName;
            //window.location.href = url;


        }

        var m_CurrentToken = '';
        function generatetokenResourceLoading(EmployeeID) {

            try {
                var ProjectID = $("#cboResourceProjects option:selected").val();

                var EmployeeID = EmployeeID;

                if (ProjectID != undefined) {
                    var generatedtoken = ajaxCall("PM_RequestedResources.aspx/GeneratePK_TokenUtilization", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, EmployeeID: EmployeeID }));
                    if (generatedtoken != undefined) {

                        m_CurrentToken = generatedtoken.d;
                        validatetokenResourceLoading(EmployeeID);
                    }
                }
            }
            catch (ex) {
                //alert(ex.message());
            }
        }

        var m_PKToken;
        function validatetokenResourceLoading(EmployeeID) {

            try {
                var ProjectID = $("#cboResourceProjects option:selected").val();
                var EmployeeID = EmployeeID;
                m_PKToken = m_CurrentToken;

                if (ProjectID != undefined) {
                    var validatetoken = ajaxCall("PM_RequestedResources.aspx/ValidatePK_TokenUtilization", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, EmployeeID: EmployeeID, PKToken: m_PKToken }));

                    if (validatetoken != undefined) {
                        if (validatetoken.d == false) {
                            window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                        }

                    }
                }
            }
            catch (ex) {
                alert(ex.message());
            }
        }

        function Resume_OnClick(intEmployeeID) {
            var LoginEmployeeID = '<%= Session("intUserID") %>';
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: '../Resources/RM_ResourceAllocation.aspx/Resume_OnClick',
                data: JSON.stringify({ EmployeeID: intEmployeeID, LoginEmployeeID: LoginEmployeeID }),
                success: function (Result) {
                    //window.open("../Resources/Resume.aspx?Token=" + Result.d + "&EmployeeID=" + intEmployeeID, "new", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 550) / 2 + ",width=700,height=550");
                    window.open("../Resources/RM_Resume.aspx?PKToken=" + Result.d + "&EmployeeID=" + intEmployeeID + "&TagID=1225", "new", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 550) / 2 + ",width=700,height=550");

                },
                error: function () {
                }
            });
           // window.open("../../HR/HR_EmployeeResume.aspx?EmployeeID=" + intEmployeeID + "&MasterTagId=3861", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");
        }


        var savefile = 0;
        function attachement(RequestID) {
            //debugger;
            var formData = new FormData();
            var objFileGrid = document.getElementById('tblFiles');

            //Added by dipali V on 11th Sep 2019 for multiple insertation of attachments
            fileObject = [];
            $("#FileControlUploadDiv [type=File]").each(function (j, val) {
                if ($(this)[0].files.length != 0) {
                    fileObject[(j)] = $(this)[0].files;
                }
            })

            for (var i = 0; i < fileObject.length; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {
                    formData.append(fileObject[i][0].name, fileObject[i][0]);
                    // formData.append(arrGlobalrequestID[k], arrGlobalrequestID[k]);
                    OldFileName = $("#FILENAME0 td:nth-child(1)").text();
                }
            }

            if (savefile == 0) {
                if (formData != "[]") {
                    $.ajax({
                        url: encodeURI(strUrl + '/api/PM_AddNewResource/FileUplaod'),
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        method: 'POST',
                        type: 'POST',
                        async: false,
                        beforeSend: function (xhr) {
                            // xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                        },
                        success: function (result) {
                            if (result.length > 0) {
                                //debugger;
                                var ProjectId = '<%=Session("intProjectID")%>';
                                var UserName = '<%=Session("strUserName")%>';
                               // for (var k = 0; k < arrGlobalrequestID.length; k++) {
                                var UploadFileParameter = [ProjectId, RequestID, $("#FILENAME0 td:nth-child(1)").text(), result[0], UserName];
                                    $.ajax({
                                        url: encodeURI(strUrl) + '/api/PM_AddNewResource/FileUplaodSaveDB',
                                        method: 'Post',
                                        data: JSON.stringify(UploadFileParameter),
                                        dataType: 'json',
                                        async: false,
                                        contentType: "application/json",

                                        beforeSend: function (xhr) {
                                            //xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                                        },
                                        success: function (result) {
                                            if (result == "Successfully uploaded file") {
                                                savefile = 1;
                                            }

                                        },
                                        error: function (xhr, errorThrown) {
                                            //alert("error ");
                                        }
                                    });
                                //}
                            }
                            else {
                                if (fileObject.length == 0 && (IsResourceRequestNewFieldsManatory == 0 || IsResourceRequestNewFieldsManatory == "False")) {
                                    savefile = 1;
                                }
                            }
                        },
                        error: function (xhr, errorThrown) {
                            // alert("error ");
                        }
                    });
                } else {
                    if (IsResourceRequestNewFieldsManatory == 0 || IsResourceRequestNewFieldsManatory == "False") {
                        savefile = 1;
                    }
                }
            }
            return savefile;

        }

        function UpdateRequest(Flag) {
           //debugger;
            //Commented & added By Dipali V On 15th Nov 2022 For Sonata Customzation
            //var RequestAllFields = ["Type", "WorkHours", "FromDate", "ToDate", "ResourcePool", "Priority", "NoOfResources", "SpecialRequest", "CancelComment"];
            var RequestAllFields = ["Type", "WorkHours", "FromDate", "ToDate", "ResourcePool", "Priority", "NoOfResources", "SpecialRequest", "DepartmentID", "LocationID", "TypeofRequirement", "ReplacementEmployeeName", "EngagementModel", "BillablePosition", "BillingStartDate", "SOWAvailable", "NatureofRequest"];
             //End of Commented & added By Dipali V On 15th Nov 2022 For Sonata Customzation
            ObjRequestValues = [];
            if (Flag == true) {
                $("#txtResourceCancelComment").val('');
            }
            var AddRequest = new Object();
            var m_strType = "";
            AddRequest.m_strType = ProjectID;
            ObjRequestValues.push(AddRequest.m_strType)
            for (var i = 0; i < RequestAllFields.length; i++) {
                var Id = "";
                  //Commented & added By Dipali V On 15th Nov 2022 For Sonata Customzation
                //if (RequestAllFields[i].indexOf("Type") > -1 || RequestAllFields[i].indexOf("ResourcePool") > -1 || RequestAllFields[i].indexOf("Priority") > -1 ) {
                if (RequestAllFields[i].indexOf("Type") > -1 || RequestAllFields[i].indexOf("ResourcePool") > -1 || RequestAllFields[i].indexOf("Priority") > -1 || RequestAllFields[i].indexOf("TypeofRequirement") > -1 || RequestAllFields[i].indexOf("ReplacementEmployeeName") > -1 || RequestAllFields[i].indexOf("DepartmentID") > -1 || RequestAllFields[i].indexOf("LocationID") > -1 || RequestAllFields[i].indexOf("EngagementModel") > -1 || RequestAllFields[i].indexOf("BillablePosition") > -1 || RequestAllFields[i].indexOf("SOWAvailable") > -1) {
                 //End of Commented & added By Dipali V On 15th Nov 2022 For Sonata Customzation
                    Id = "#cboResource" + RequestAllFields[i] //.substr(0, FieldName.indexOf(","));
                    m_strType = RequestAllFields[i];
                    AddRequest.m_strType = $(Id).val();
                    if (m_strType == "Type") {
                        if (AddRequest.m_strType != '') {
                            ObjRequestValues.push("'" + AddRequest.m_strType + "'");
                        }
                        else {
                            AddRequest.m_strType = "0";
                            ObjRequestValues.push(AddRequest.m_strType);
                        }
                    }
                    else {

                        if (AddRequest.m_strType != '') {
                            ObjRequestValues.push(AddRequest.m_strType);
                        }
                        else {
                            AddRequest.m_strType = "0";
                            ObjRequestValues.push(AddRequest.m_strType);
                        }
                    }
                }
                else {

                    Id = "#txtResource" + RequestAllFields[i];
                    m_strType = RequestAllFields[i];
                    AddRequest.m_strType = $(Id).val();
                    if (m_strType == "NoOfResources" || m_strType == "WorkHours" || m_strType == "BillingStartDate" || m_strType == "NatureofRequest" ) {
                        if (AddRequest.m_strType != '') {
                            ObjRequestValues.push(AddRequest.m_strType);
                        }
                        else {
                            AddRequest.m_strType = "0";
                            ObjRequestValues.push(AddRequest.m_strType);
                        }
                    }
                    else {
                        if (AddRequest.m_strType.indexOf("'") > -1) {
                            AddRequest.m_strType = AddRequest.m_strType.replace(/'/g, "''");

                        }
                        if (AddRequest.m_strType != '') {
                            ObjRequestValues.push("'" + AddRequest.m_strType + "'");
                        }
                        else {
                            AddRequest.m_strType = "0";
                            ObjRequestValues.push(AddRequest.m_strType);
                        }
                    }
                }
            }

            if (RequestID != undefined || RequestID != '') {
                AddRequest.m_strType = RequestID;
                ObjRequestValues.push(AddRequest.m_strType);
            }
            else {
                AddRequest.m_strType = "0";
                ObjRequestValues.push(AddRequest.m_strType);
            }
          
            //return;
            //debugger;
            var UserName = '<%=Session("strUserName")%>'
            ObjRequestValues.push(UserName);
           // debugger;
            //Added by Dipali V on 6th May 2026 for vendor management - persist vendor update in request edit/save flow
            ObjRequestValues.push($("#cboResourceVendorID").val());
            var param = JSON.stringify(ObjRequestValues);
            console.log(ObjRequestValues)

            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/InsertAndUpdateRequest", param, false);
            var Result = strResult.split("||");
           //Added By Dipali V On 16th Dec 2022 For Alert Issue
            //alertify.success(Result[0]);
            setTimeout(function () {
                alertify.success(Result[0]);
            }, 1300);
             //End of Added By Dipali V On 16th Dec 2022 For Alert Issue
            RequestID = Result[1];
            //debugger;
            if (Savelink == false) {
                attachement(RequestID);
            }
            GetAssignedResourcesList(RequestID);
            GetRequestedResourcesList(ProjectID);
            EditRequestResource(RequestID);

        }

        // Edit Request
        function AddRequestClick() {
           //debugger;
            var CancelRequest = $("#txtResourceCancelComment").val();
            var RequestType = $("#txtHiddenRequestType").val().trim();
            //if (RequestType != 'Extend Requests') {
            //    var Checkval = ValidateRequest();
            //}
            //else {

            //}
            var Checkval = ValidateRequest();

            if (Checkval == true) {

                if (CancelRequest == "") {
                    $("#CloseRequestinfomodal").modal("hide");
                    UpdateRequest(true);
                }
                else {
                    $("#CloseRequestinfomodal").modal("show");
                }
            }


            $('html, body').animate({
                scrollTop: $("#RRdetailpanel").offset().top -= 100
            }, 500);


        }
        //Added By Riddhesh Patil on 18-NOV-2022 
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

        //Validate Fields
        function ValidateRequest() {
           
            var Checkval = false;
            RequestParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(RequestParameters);
            var ProjectBalHrs = AJAXCallWithResult("/api/PM_RequestedResources/GetProjectBalHrs", param, false);

            var param = JSON.stringify(RequestParameters);
            var intWorkHours = AJAXCallWithResult("/api/PM_RequestedResources/GetLocationWorkingHours", param, false);

           // var param = JSON.stringify();
            var objResPer = AJAXCallWithResult("/api/PM_RequestedResources/GetresourceHrs", false);

            var Requestor = $("#cboResourceRequestor").val();
            var ResourceType = $("#cboResourceType").val();
            var WorkHours = $("#txtResourceWorkHours").val();
            var FromDate = $("#txtResourceFromDate").val();
            var ToDate = $("#txtResourceToDate").val();
            var ResourcePool = $("#cboResourceResourcePool").val();
            var NoOfResources = $("#txtResourceNoOfResources").val();
            var SpclRequest = $("#txtResourceSpecialRequest").val();
            var ObjNoOfResources = document.getElementById("txtResourceNoOfResources");
            var IsdigitResources = isNumeric(ObjNoOfResources.value);
            var ObjWorkHours = document.getElementById("txtResourceWorkHours");
            var IsdigitWorkHoursResources = isNumeric(ObjWorkHours.value);
            var maxhrs;


            // Commented & Added By Rutuja D. 14 Jan 2020 For Validation
            
            var ChkWorkHours = "";
                    maxhrs = parseFloat(intWorkHours) * parseInt(objResPer) / 100;
                    // var fltTotalWorkHrs = parseFloat(WorkHours) * parseFloat(NoOfResources);
                    var fltTotalWorkHrs = parseFloat(ChkWorkHours) * parseFloat(NoOfResources);
                    //End Commented & Added By Rutuja D. 14 Jan 2020 For Validation

                    if (ResourcePoolIsMandatory == 1) {//Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert         

                        if (isBlank(ResourcePool)) {
                            alertify.error('<%= MyBase.GetResourceString("A_ResourcePool") %>');
                            $('#cboResourceResourcePool').focus();
                            Checkval = false;
                        } else {
                            Checkval = true;
                        }
                    }
                    else {
                        Checkval = true;
                    }

                    // alert(Checkval)
                    if (Checkval == true) {//Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert
                        //Checkval = false;
                        if (isBlank(ResourceType)) {
                            alertify.error('<%= MyBase.GetResourceString("A_Type") %>');
                            $('#cboResourceType').focus();

                        }
                        else if (isBlank(NoOfResources)) {
                            alertify.error('<%= MyBase.GetResourceString("A_NoOfResources") %>');
                            $('#txtResourceNoOfResources').focus();

                        }


                        //Commented By Rutuja D. 9 Jan 2020 For Alert Issue
            <%--else if (isBlank(ResourcePool)) {
                    alertify.error('<%= MyBase.GetResourceString("A_ResourcePool") %>');
                    $('#cboResourceResourcePool').focus();
                }--%>
                        //End Commented By Rutuja D. 9 Jan 2020 For Alert Issue
                        else if (isBlank(FromDate)) {
                            alertify.error('<%= MyBase.GetResourceString("A_FromDate") %>');
                            $('#txtResourceFromDate').focus();
                            Checkval = false;

                        }
                        else if (isBlank(ToDate)) {
                            alertify.error('<%= MyBase.GetResourceString("A_ToDate") %>');
                            $('#txtResourceToDate').focus();
                            Checkval = false;

                        }

                        /*Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/

                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && ($("#cboResourceTypeofRequirement").val() == "0")) {
                            alertify.error("Type of Requirement Should not be left blank.");
                            $("#cboResourceTypeofRequirement").focus();
                            Checkval = false;
                        }

                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && ($("#cboResourceLocationID").val() == "0")) {
                            alertify.error("Location Should not be left blank.");
                            $("#cboResourceLocationID").focus();
                            Checkval = false;
                        }
                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && ($("#cboResourceDepartmentID").val() == "0")) {
                            alertify.error("Department Should not be left blank.");
                            $("#cboResourceDepartmentID").focus();
                            Checkval = false;
                        }
                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && (($("#cboResourceTypeofRequirement").val() == "2") && ($("#cboResourceReplacementEmployeeName").val() == "0"))) {
                            /* if ($("#cboRRProjectRepEmployeeName").val() == "0") {*/
                            alertify.error("Replacement Employee Name Should not be left blank.");
                            $("#cboResourceReplacementEmployeeName").focus();
                            Checkval = false;
                            // }
                        }
                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && (($("#cboResourceTypeofRequirement").val() == "2") && ($("#txtResourceNoOfResources").val() > 1 || $("#txtResourceNoOfResources").val() == 0))) {
                            // if ($("#txtResourceNoOfResources").val() > 1 || $("#txtResourceNoOfResources").val() == 0) {
                            alertify.error("In case of Replacement Request, No. Of Resources should be 1.");
                            $("#txtResourceNoOfResources").focus();
                            Checkval = false;
                            //}
                        }

                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && ($("#cboResourceEngagementModel").val() == "0")) {
                            alertify.error("Engagement Model Should not be left blank.");
                            $("#cboResourceEngagementModel").focus();
                            Checkval = false;
                        }

                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && ($("#cboResourceBillablePosition").val() == "0")) {
                            alertify.error("Billable Position Should not be left blank.");
                            $("#cboResourceBillablePosition").focus();
                            Checkval = false;
                        }

                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && (($("#cboResourceBillablePosition").val() == "1") && ($("#txtResourceBillingStartDate").val() == ""))) {
                            //if ($("#RRillingStartDate").val() == "") {
                            alertify.error("Billing Start Date Should not be left blank.");
                            $("#txtResourceBillingStartDate").focus();
                            Checkval = false;
                            //}
                        }

                        else if ((IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") && ($("#cboResourceSOWAvailable").val() == "0")) {
                            //if ($("#RRillingStartDate").val() == "") {
                            alertify.error("SOW Available Should not be left blank.");
                            $("#cboResourceSOWAvailable").focus();
                            Checkval = false;
                            //}
                        }

                        /*End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/
                        else if (isBlank(WorkHours)) {
                            alertify.error('<%= MyBase.GetResourceString("A_WorkHours") %>');
                            $('#txtResourceWorkHours').focus();
                            Checkval = false;

                        }
                        else if (WorkHours == 0) {
                            alertify.error("The value of 'Work Hours' should be in the range of (1-9999).");
                            $('#txtResourceWorkHours').focus();
                            Checkval = false;
                        }
                        else if (WorkHours <= 0) {
                            alertify.error('Work hours should not be less than or equal to zero(0).');
                            Checkval = false;
                            return;
                        }
                        //------------------Added By Dipali on  25th April 2023
                        else if (WorkHours != "") {
                            if (ResourceType != 'P') {
                                if ($("#txtResourceWorkHours").val() != '' && Checkval == true && $("#cboResourceType").val() != 'P') {
                                    //2020
                                    var result = WorkHoursValidation("txtResourceWorkHours");
                                    if (result == true) {
                                        Checkval = true;
                                    } else {
                                        $('#txtResourceWorkHours').focus();
                                        Checkval = false;
                                    }
                                }

                                if (Checkval == true) {
                                    if (WorkHours.indexOf(':') > -1) {
                                        WorkHours = WorkHours;
                                    }
                                    else {
                                        WorkHours = WorkHours + ":00"
                                    }

                                    if (WorkHours.indexOf(':') > -1) {
                                        var RequestParameters = {
                                            WorkHrs: encodeURI(WorkHours),
                                            Flag: encodeURI(2),
                                        }
                                        var param = JSON.stringify(RequestParameters);
                                        ChkWorkHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                                    } else {
                                        ChkWorkHours = ChkWorkHours;
                                    }
                                }
                            }
                            else {
                                var result = jQuery.isNumeric(WorkHours)
                                if (result == false) {
                                    //Added By Dipali V On 11th May 2023 For Alert Change Issue
                                    //alertify.error('Work hours should numeric value.');
                                    alertify.error('Work hours should be numeric value.');
                                    $("#txtResourceWorkHours").focus();
                                  //End of Added By Dipali V On 11th May 2023 For Alert Change Issue
                                    Checkval = false;
                                    return;
                                }
                            }
                        }
                          //------------------End of By Dipali on  25th April 2023
                        else if (isNumeric(ObjNoOfResources)) {
                            alertify.error("<%= MyBase.GetResourceString("A_ValueNoOfResources") %>");
                            $('#txtResourceNoOfResources').focus();
                            Checkval = false;

                        }
                        else if (IsdigitResources == false) {
                            alertify.error('<%= MyBase.GetResourceString("A_ValueNoOfResources") %>');
                            $('#txtResourceNoOfResources').focus();
                            Checkval = false;

                        }
                        else if (disallowNegativeNumeric(ObjNoOfResources)) {
                            alertify.error('<%= MyBase.GetResourceString("A_ValueNoOfResources") %>');
                            $('#txtResourceNoOfResources').focus();
                            Checkval = false;
                        }
                        else if (NoOfResources == 0) {
                            alertify.error('<%= MyBase.GetResourceString("A_ValueNoOfResources") %>');
                            $('#txtResourceNoOfResources').focus();
                            Checkval = false;
                        }
                        else if (NoOfResources.indexOf('.') > -1) {
                            alertify.error('<%= MyBase.GetResourceString("A_PositiveInteger") %>');
                            $('#txtResourceNoOfResources').focus();
                            Checkval = false;

                        }

                        else if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                            //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                            ValidateAttachmentFlag = ValidateAttachment();
                            //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation

                            if (ValidateAttachmentFlag == true) {
                                Checkval = true;
                            } else {
                                Checkval = false;
                            }
                        }




                        else if (WorkHours != "" && Checkval == true) {
                            var Data = "";
                            //var result = WorkHoursValidation("txtResourceWorkHours");
                            //if (result == true) {
                            //Added By Reshma on 10th Jan 2020 For IssueID-21364
                           // var result = WorkHoursValidation("txtResourceWorkHours");
                           // if (result == true) {
                                //End Added By Reshma on 10th Jan 2020 For IssueID-21364
                                if (ResourceType == 'TH') {
                                    if (ProjectBalHrs != null || ProjectBalHrs != undefined || ProjectBalHrs != '') {
                                        if (parseFloat(ProjectBalHrs) < parseFloat(fltTotalWorkHrs)) {
                                            alertify.error("<%= MyBase.GetResourceString("A_TotalWorkHours") %> " + ProjectBalHrs);
                                            $('#txtResourceWorkHours').focus();
                                            Data = false;
                                        }
                                        else {
                                            Data = true;
                                        }

                                    }
                                }
                                else if (ResourceType == 'HPD') {
                                    //Commented & Added By RUtuja D. 14 Jan 2020 For Validation
                                    if (maxhrs.toString().indexOf(".") != -1) {
                                        var maxhrsHPD = maxhrs;
                                    } else {
                                        var maxhrsHPD = maxhrs + '.00';
                                    }
                                    //  if (parseFloat(WorkHours) > parseFloat(maxhrs)) {
                                    if (parseFloat(ChkWorkHours) > parseFloat(maxhrsHPD)) {
                                        //End Commented & Added By RUtuja D. 14 Jan 2020 For Validation
                                        alertify.error('Work hours cannot be greater than the company work hours ' + maxhrs);
                                        $('#txtResourceWorkHours').focus();
                                        Data = false;
                                    }
                                    else {
                                        Data = true;
                                    }

                                }
                                else if (ResourceType == 'P') {
                                    //Commented & Added By RUtuja D. 14 Jan 2020 For Validation

                                    if (objResPer.toString().indexOf(".") != -1) {
                                        var objResPerP = objResPer;
                                    } else {
                                        var objResPerP = objResPer + '.00';
                                    }
                                    // if (parseFloat(WorkHours) > parseInt(objResPer)) {
                                    if (parseFloat(ChkWorkHours) > parseInt(objResPerP)) {
                                        //End Commented & Added By RUtuja D. 14 Jan 2020 For Validation

                                        alertify.error("<%= MyBase.GetResourceString("A_ResourcepercentageRange") %>" + objResPer);
                                        //setFocus(objWorkHours);
                                        $('#txtResourceWorkHours').focus();
                                        Data = false;
                                    }
                                    else {
                                        Data = true;
                                    }
                                }
                                else {
                                    Data = true;
                                }
                                //Added By Reshma on 10th Jan 2020 For IssueID-21364
                           // }
                            //End Added By Reshma on 10th Jan 2020 For IssueID-21364
                            if (Data == true) {

                                if (FromDate != "" || ToDate != "") {
                                    var Datecheckval = ValidateDates(FromDate, ToDate);
                                    if (Datecheckval == true) {
                                        Checkval = true;
                                    }
                                    if (Datecheckval == false) {
                                        Checkval = false;
                                    }
                                }
                            }
                            else {
                                Checkval = false;
                            }
                        }
                        else {
                            Checkval = false;
                        }
                    }//End Added By Rutuja D. 9 Jan 2020 For Close Bracket
                    //}
                    //else {
                    //    Checkval = true;
                    //}
                    return Checkval;

               // }

            
        }


        //Function for Validation dates
        function ValidateDates(ExpectedStartDate, ExpectedEndDate) {
            var checkval = false;

            var result = GetProjectStartDateEndDate(ProjectID);
            for (var i = 0; i < result.length; i++) {
                var ObjDate = result[i];

                if (Date.parse(ExpectedStartDate) > Date.parse(ExpectedEndDate)) {
                    alertify.error('<%= MyBase.GetResourceString("A_FromDateToDate") %> ');
                    $("#txtResourceFromDate").focus();

                }
                else if (Date.parse(ObjDate.expectedenddate) < Date.parse(ExpectedStartDate)) {
                    alertify.error('<%= MyBase.GetResourceString("A_FromDateGreater") %> ' + result[i].expectedenddate + "");
                    $("#txtResourceFromDate").focus();

                }
                else if (Date.parse(ObjDate.expectedenddate) < Date.parse(ExpectedEndDate)) {
                    alertify.error('<%= MyBase.GetResourceString("A_FromDateLessPro") %> ' + result[i].expectedenddate + "");
                    $("#txtResourceToDate").focus();

                }
                else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(ExpectedStartDate)) {
                    alertify.error('<%= MyBase.GetResourceString("A_FromDateless") %> ' + result[i].expectedStartdate + "");
                    $("#txtResourceFromDate").focus();

                }
                else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(ExpectedEndDate)) {
                    alertify.error('<%= MyBase.GetResourceString("A_ToDateLess") %> ' + result[i].expectedStartdate + "");
                    $("#txtResourceToDate").focus();

                }

                else {
                    checkval = true;
                }
            }
            return checkval;
        }

        //Project Start Date End Date From Company Information
        function GetProjectStartDateEndDate(ProjectID) {
            var param = JSON.stringify(encodeURI(ProjectID));
            var result = AJAXCallWithResult("/api/PM_RequestedResources/GetProjectStartDateEndDate", param, false);
            if (result != undefined) {
                return result;
            }
        }




        function Date_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = (e.keyCode == 8 || e.keyCode == 46)
            {
                if (e.keyCode == 8 || e.keyCode == 46) {

                }
            }
            return ret;
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
                    //xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    //StopAjaxLoader("#WBSBody");
                    ajaxResult = data;
                },
                error: function (err) {
                    //StopAjaxLoader("#WBSBody");
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }


        //Back Button Click
        $("#BackBtn").click(function () {
            window.location.href = "PM_Resources.aspx?ProjectID=" + ProjectID + "&ProjectName=" + ProjectName;
        });


        //Prepone request detail
        function RRPRdetail() {
            $("#RRpreponerequest_Detail").show('fast');
            $('html, body').animate({
                scrollTop: $("#RRpreponerequest_Detail").offset().top -= 60
            }, 500);

        }

        function ajaxCall(url, type, contentType, dataType, data) {
            var ajaxResult;

            $.ajax({
                url: url,
                type: "POST",
                data: data,
                async: false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",

                success: function (data) {

                    ajaxResult = data;
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
            return ajaxResult;
        }


        //Validation script for work hours

        function WorkHoursValidation(ControlID) {

            var objHMEffort = document.getElementById(ControlID);

            var objVal = objHMEffort.value;

            var objOldVal = objHMEffort.value;

            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");

                var isdigit = jQuery.isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;

                if (isdigit == false) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_PositiveNumericForNewAllocation") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_PositiveNumeric") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                objHMEffort.value = objHMEffort.value.replace('.', ':');

                var WorkHour = objHMEffort.value;

                WorkHour = WorkHour.trim();
                var idxColon = WorkHour.indexOf(':');

                var hrs = WorkHour.substring(0, idxColon);
                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (hrs.indexOf("-") != -1) {

                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZeroForNewAllocation") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZero") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZero") %>');
                    }

                    setFocus(objHMEffort);
                    return false;
                }

                if (mins.length > 2) {
                    alertify.error('<%= MyBase.GetResourceString("A_MinInTwoDecimal") %>');

                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {

                    alertify.error('<%= MyBase.GetResourceString("A_MinInRange") %>');


                    setFocus(objHMEffort);

                    return false;
                }

                //var strResult = AJAXCallWithResult("/api/PM_WBS/GetRestrictByMinHours_MinHoursForDAEntry", false);
                var strResult = AJAXCallWithResult("/api/PM_RequestedResources/GetRestrictByMinHours_MinHoursForDAEntry", false);

                if (strResult != undefined) {
                    RestrictByMinHours = strResult.RestrictByMinHours;
                    MinHoursForDAEntry = strResult.MinHoursForDAEntry;
                }


                var MinDAENtryDisplay = "";
                var objMinWorkHrs = MinHoursForDAEntry;

                var MinDAEntry = objMinWorkHrs;

                var objRestrictByMinHours = RestrictByMinHours;


                if (MinDAEntry == 0.25) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:15"
                }
                else if (MinDAEntry == 0.50) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:30"
                }
                else if (MinDAEntry == 0.75) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:45"
                }
                if (objRestrictByMinHours == true) {
                    if (MinDAEntry == 0.016) {
                    }
                    else {
                        var minutes = WorkHour.split(':');

                        var p = minutes[0];
                        var dec = minutes[1];

                        if (dec.length > 2) {
                            dec = dec.substring(0, 2);
                        }
                        if (dec.length == 1) {
                            dec = dec + "0";
                        }
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            if (ControlID == 'txtExtResourceNewAllocation') {
                                alertify.error("Please enter the New Allocation in multiple of (" + MinDAENtryDisplay + ") min");

                            }
                            else {
                                alertify.error("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");

                            }
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }
            }
            return true;
        }


        //Cancle stakeholder detail panel
        $(".closedetailpanel").click(function () {
            $(".listdetailcontent").hide('fast');
            $("td.reqid.sorting_1,.milestonetabheader ").css('pointer-events', 'auto');
            $("td.reqid").css('pointer-events', 'auto');
            $(".dataTables_paginate ").css("pointer-events", "auto");
            //$("#MainResourceRequest").css("pointer-events", "auto");
            $("#cboResourceProjects").removeAttr('disabled');
            $("#BackBtn").removeAttr('disabled');
            GetRequestedResourcesList(ProjectID);
            GetChangeRequestList();

            $("td.reqid.sorting_1,.milestonetabheader").css("pointer-events", "auto");
                    $("td.reqid,.milestonetabheader ").css("pointer-events", "auto");
                    $(".dataTables_paginate ").css("pointer-events", "auto");
                      // $("#MainResourceRequest").css("pointer-events", "none");
                       $("#cboResourceProjects").prop('disabled', false);
                    $("#BackBtn").prop('disabled', false);

            //Added By Dipali V On 23th Dec 2022 For enabled Fields; reset all on close (13 May 2026 fix stuck disabled)
            resetRRDetailPanelEditability();
            //End of Added By Dipali V On 23th Dec 2022 For enabled Fields

        });


        //Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory Or Not

        function CheckResourcePoolMandatory() {

            var param = JSON.stringify();
            var result = AJAXCallWithResult("/api/PM_RequestedResources/CheckResourcePoolMandatory", param, false);
            ResourcePoolIsMandatory = result;

        }
        //End Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory Or Not

        //Added By Rutuja D. 10 Jan 2020 For Show Close Modal 
        function ShowCloseModal() {

            var CloseComment = $("#txtResourceCancelComment").val();
            var SpecialRequest = $("#txtResourceSpecialRequest").val();
           //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            if (checkSpecialCharacter(SpecialRequest, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Special Request should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtResourceSpecialRequest").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else if (isBlank(CloseComment)) {
                alertify.error('<%= MyBase.GetResourceString("A_CloseComments") %>');
                $('#txtResourceCancelComment').focus();
                return false;
            }
            //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(CloseComment, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Close Comment should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtResourceCancelComment").focus();
                return false;
            }
			//End of Comment Added By Riddhesh Patil
            else {

                $("#CloseRequestomodal").modal("show");

            }
        }

        //End Added By Rutuja D. 10 Jan 2020 For Show Close Modal 

        //Added By Rutuja D. 16 Jan 2020 For Cancel Request Function
        function CancelRequest() {
            //alert(RequestID);
            var param = JSON.stringify(encodeURI(RequestID));
            var result = AJAXCallWithResult("/api/PM_RequestedResources/CancelRequest", param, false);
            GetChangeRequestList();
        }
                    //End Added By Rutuja D. 16 Jan 2020 For Cancel Request Function

        function cboStatus_OnChange() {
            GetRequestedResourcesList(ProjectID);
            GetChangeRequestList();
        }
        function myFunction() {

            GetRequestedResourcesList(ProjectID)
            GetChangeRequestList();

        }

        function restrictAlphabets(e) {
            //
           // debugger;
            //  $("#textNoOfResource").val();
            var x = e.which || e.keycode;
            if ((x >= 48 && x <= 57) || x == 8 ||
                (x >= 35 && x <= 40) || x == 46)
                return true;
            else
                return false;
        }

        //Added By Dipali V On 15th Nov 2022 For Sonata Customzation
        function ValidateReEmployeeName(selectedvalue) {
            if (selectedvalue == 2) {
                $("#spncboRRProjectRepEmployeeName").css("display", "block");
                $("#cboResourceReplacementEmployeeName").removeAttr("disabled");
            } else {
                $("#spncboRRProjectRepEmployeeName").css("display", "none");
                $("#cboResourceReplacementEmployeeName").attr("disabled", "disabled");
                $("#cboResourceReplacementEmployeeName").val("0");
            }
        }


        function ValidateBillingStartDate(selectedvalue) {
            if (selectedvalue == 1) {
                /* $("#spnRRillingStartDate").css("display", "block");*/
               
                if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                    $("#lblbillingstartdate").addClass("required");
                }
                $("#txtResourceBillingStartDate").removeAttr("disabled");
                const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                const today = new Date();
                today.setDate(today.getDate() + 30);
                const yyyy = today.getFullYear();
                let mm = month[today.getMonth()]; // Months start at 0!
                let dd = today.getDate();

                if (dd < 10) dd = '0' + dd;
                if (mm < 10) mm = '0' + mm;
                const formattedToday = dd + ' ' + mm + ' ' + yyyy;
                $("#txtResourceBillingStartDate").val(formattedToday);
                selectedAddedDate = formattedToday;

            } else {
                //$("#spnRRillingStartDate").css("display", "none");
                $("#txtResourceBillingStartDate").attr("disabled", "disabled");
                $("#lblbillingstartdate").removeClass("required");

            }
            //ValidateNatureofRequest();
        }

        function ValidateNatureofRequest() {
            //debugger;
            if ($("#cboResourceSOWAvailable").val() != "") {
                if ($("#cboResourceSOWAvailable").val() == "1") {
                    if ($("#txtResourceBillingStartDate").val() != "") {

                        //if (selectedAddedDate == undefined) {
                        //    const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                        //    const today = new Date();
                        //    today.setDate(today.getDate() + 30);
                        //    const yyyy = today.getFullYear();
                        //    let mm = month[today.getMonth()]; // Months start at 0!
                        //    let dd = today.getDate();

                        //    if (dd < 10) dd = '0' + dd;
                        //    if (mm < 10) mm = '0' + mm;
                        //    const formattedToday = dd + ' ' + mm + ' ' + yyyy;
                        //    selectedAddedDate = formattedToday
                        //}

                        var ResourceParameters = {
                            RillingStartDate: encodeURI($("#txtResourceBillingStartDate").val()),
                            AddedDate: encodeURI(selectedAddedDate),
                        }
                        var param = JSON.stringify(ResourceParameters);
                        var result = AJAXCallWithResult("/api/PM_AddNewResource/ValidateNatureofRequest", param, false);
                        if (result != "") {
                            $("#txtResourceNatureofRequest").val(result[0].Column1);
                        }
                    }
                    else {
                        $("#txtResourceNatureofRequest").val("Normal");
                    }
                } else {
                    $("#txtResourceNatureofRequest").val("Normal");
                }

            }
        }


        //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
        function Warningattachment() {
            var jdAttachment = $("#FILENAME0").text();
            if (jdAttachment == "NA") {
                jdAttachment = "";
            }
            if (jdAttachment != "") {
                $("#WarningJDAttachment").modal('show');
            } else {
                SelectFile();
            }
        }
        var strAppRoot = '<%=Request.ApplicationPath.TrimEnd("/")%>';
        function DownloadJDAttachement() {
            $(".tooltip").removeClass('show');
            if (JDAttachmentFileName == null || JDAttachmentFileName == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("There is no attachment present to download.", 'error', 25);
                return;
            }
            // If path starts with "/" — it's a direct project folder file, open via strAppRoot
            // Otherwise — it's an old system filename, open via ViewAttachment.aspx
            if (JDAttachmentFileName.indexOf('/') === 0) {
                window.open(strAppRoot + JDAttachmentFileName, '_blank');
            } else {
                var strTemp = '../../General/ViewAttachment.aspx?FromWhere=JDAttachments&FileName=' + JDAttachmentFileName + '&SystemFileName=' + JDAttachmentFileName;
                window.open(strTemp);
            }
        }

        function SelectFile() {
            var strFileCount = $("#btnSelectFile").attr("FileCount");
            var objCurrentFileControl = $("#txtFileName" + strFileCount);
            if (FileCount_toDisable == 5) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("User can attach maximum five files at a time.", 'error', 25);
                return;
            }
            objCurrentFileControl.click();
        }

        var FileCount_toDisable = 0;
        var IsFileadded = 0;
        var fileObject = [];
        var fileObject1 = [];
        var AllfileData = [];
        async function addFileinGrid() {
            var data = new FormData();
            fileObject = [];
            fileObject1 = [];
            AllfileData = [];
            var FileCount = 0;
            IsFileadded = 0;
            savefile = 0;
            $("#tblFiles").html('');
            ValidateAttachmentFlag = true;
            var objtxtFileName = document.getElementById('txtFileName' + FileCount);


            //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
            var objFile = objtxtFileName;
            var fileName = objtxtFileName.value;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


            isValidTypeExeCheck = false;
            //Commented and Added by Aditya J. on 25-11-2024
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
                //End of comment Added by Aditya J. on 25-11-2024
            isValidTypeExeCheck = ValidExtsExe.includes(extension);

            if (isValidTypeExeCheck) {
                const file = objFile.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        //alert("File is valid and ready to upload.");
                    })
                    .catch(error => {
                        //Added by Ajit L on 21/11/2024
                        var fileInput = objFile;
                        var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                        // Before clearing:
                        console.log("Selected files before clearing:", fileInput.files);
                        $(fileInput).val(""); // Clear the file input
                        fileNameInput.val(""); // Clear the file name text input
                        //End of Added by Ajit L on 21/11/2024

                        console.log(error);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;
                        $(objtxtFileName).val("");
                        /*$(objFileName).attr("placeholder", "Upload File");*/
                        //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                        return;
                    });



                if (!isValidTypeExeCheck) {
                    return;
                }
            }

            //$(objtxtFileName).val("");

             //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not

            var fileName = objtxtFileName.value;
            var files = objtxtFileName.files;

            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_AddNewResource/GetFileType',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',
                async: false,
                beforeSend: function (xhr) {
                    //xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                },
                success: function (result) {

                    if (result == true) {
                       // debugger;
                        $("#WarningJDAttachment").modal('hide');
                        AllfileData.push(FileCount);
                        IsFileadded += 1;
                        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                        var objFileGrid = document.getElementById('tblFiles');
                        objFileGrid.style.display = "none";
                        var newRow = objFileGrid.insertRow(objFileGrid.rows.length);
                        objtxtFileName.style.display = "none";
                        newRow.id = 'FILENAME' + FileCount;
                        newRow.name = 'txtFileName';
                        newRow.className = "clsTREven";
                        var newCell = newRow.insertCell(0);
                        newCell.innerHTML = "<i class='fa fa-file-pdf-o' aria-hidden='true'></i>";
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);

                        newCell.innerHTML = fileName;
                        $("#FILENAME0").text('');
                        $("#FILENAME0").text(fileName);

                        parentTD = objtxtFileName.parentNode;
                        objtxtFileName.style.display = "none";
                        FileCount++;
                        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                        objtxtFileName.style.display = "none";
                        objtxtFileName.disabled = true;
                        $("#btnSelectFile").attr("FileCount", FileCount);

                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Invalid Content Type!!");
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);
                        //alert(fileName);
                        data.delete(fileName);
                    }


                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }
        //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation


        //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
        //function validateDocFileForExe(file) {

        //    return new Promise((resolve, reject) => {
        //        //debugger;

        //        const reader = new FileReader();

        //        reader.onload = function (e) {
        //            const arrayBuffer = e.target.result;
        //            const uint8 = new Uint8Array(arrayBuffer);

        //            // Function to search for a specific byte sequence
        //            const containsSignature = (signature) => {
        //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
        //                    let found = true;
        //                    for (let j = 0; j < signature.length; j++) {
        //                        if (uint8[i + j] !== signature[j]) {
        //                            found = false;
        //                            break;
        //                        }
        //                    }
        //                    if (found) return true;
        //                }
        //                return false;
        //            };

        //            // Check for 'MZ' signature (common for Windows EXE files)
        //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
        //            if (containsSignature(mzSignature)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // If no signatures are found, the file is considered safe
        //            resolve();
        //        };

        //        reader.onerror = function () {
        //            reject("Error reading the file. Please try again.");
        //        };

        //        // Read the file as an ArrayBuffer
        //        reader.readAsArrayBuffer(file);
        //    });
        //}

        //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not

        //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
        var ValidateAttachmentFlag = true;
        function ValidateAttachment() {
            $('#tblFiles tr').each(function () {

                var id = $(this).attr("id");
                if (id != undefined) {
                    var Filecount = id.split("FILENAME")[1];
                    var objFileName = document.getElementById('txtFileName' + Filecount);
                    if (objFileName != null) {

                        if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                        if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                        var countOfDot, FileNameCharCount;
                        var intMinFileSize = '<%=ConfigurationManager.AppSettings("inFileSize")%>'
                        var intActualFileSize = (objFileName.files['0'].size);
                        var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
                        var validateExtensions;

                        validateExtensions = strFileExtension.split(",");
                        if (strFileExtension.length > 0) {
                            var allowSubmit = false;
                            var file = objFileName.value;
                            var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();

                            for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                                var strExtn;
                                strExtn = validateExtensions[cnt];
                                if (strExtn.toLowerCase() == extension) { allowSubmit = true; }

                            }
                            if (allowSubmit == false) {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!");
                                ValidateAttachmentFlag = false;
                                return false;

                            }

                        }

                        if (objFileName.files['0'].name != '')
                            var countOfDot = objFileName.files['0'].name.split(".").length - 1;

                        if (countOfDot > 1) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File with two or more extensions is not allowed!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (objFileName.files['0'].name != '')
                            FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

                        if (FileNameCharCount > 120) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File name should not exceed 120 characters!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (intActualFileSize < intMinFileSize) {

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
                            ValidateAttachmentFlag = false;
                            return false;

                        }

                    }
                }
            });
            return ValidateAttachmentFlag;
        }
        //End of Added By Dipali V On 12th Nov 2022 For Sonata Customzation

    </script>
</body>

</html>
