<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectConfigurationSettings.aspx.vb" Inherits="PbNIT.PM_ProjectConfigurationSettings" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
  <!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->
  <%CommonFunctions.General.PlotPageHeadTag("PM_ProjectConfigurationSettings")%>
<head runat="server">
        <!-- Commented by Madhuri.K for JQuery and Bootstrap version upgrade -->
<%--    <title>PM_ProjectConfigurationSettings</title>--%>
    <!-- Tell the browser to be responsive to screen width -->
<%--    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css"/>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" /--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1" />
</head>
      
    <style type="text/css">
        body {
            background: #fff;
        }

        .modalpgHead {
            background: #4263c1;
            color: #fff;
            font-family: 'Roboto', sans-serif;
            font-size: 20px;
        }

        .lblcrsr {
            cursor: not-allowed !important;
        }

        .clsShowHide {
            display: none !important;
        }

    </style>

<body id="pcpsBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectConfigSettings">
        <%-- <form id="form1" runat="server">--%>

        <!-- Main content -->
        <section class="content">

            <!--ps_configuration_Types_list_table_start-->
            <div class="modalpgHead pt-1 pb-1 col-sm-12 mb-10">Configure Settings</div>
            <div class="tab-pane pstbl_configuration" id="pstbl_configuration">
                <div class=" pt-1 pb-1 col-sm-12 text-end">
                    <h5 class="float-start mb-0">Project Name : <span id="ProjectName"></span></h5>
                    <div class="text-end">
                        <button id="configuresettingsave" onclick="SaveProjectConfiguration()" class="btn btnyellow"><%= MyBase.GetResourceString("C_PM_ConfigSetting_btnSave") %></button>
                    </div>
                </div>



                <%--<button id="btnIssueSeverity">IssueSeverity</button>
            <button id="btnpriorities">Priorities</button>
            <button id="btnversion">Version</button>
            <button id="btnRootCause">RootCause</button>
            <button id="btnEmailSettings">EmailSettings</button>
            <button id="btnTaskType">TaskType</button>
            <button id="btnDeliverableSettings">DeliverableSettings</button>--%>
                <br />
                <div class="col-sm-12">
                    <div class="main-form-inner">
                        <div class="form-sec-first">
                            <div class="sec-first-title">
                                <h4><%= MyBase.GetResourceString("C_IssueBasedRelatedSettings") %></h4>
                            </div>
                            <div class="col-sm-12 bor-bot">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_TypeofIssueLayout") %><span style="color: red">*</span> </label>
                                            <div class="custom-dropdown">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboIssueLayoutType", "usp_Whizible2_Sel_tbl_IB_IssueLayoutType",,, "class='form-control'", False,, ) %>
                                                <%--<select class="selectpicker">
                                                    <option selected="selected">Role-based Issue Layouts</option>
                                                    <option>Role-based Issue Layouts</option>
                                                    <option>Role-based Issue Layouts</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_IssueBaseLayout") %></label>
                                            <div class="custom-dropdown">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboIssueEntryLayout", "usp_Whizible2_Sel_tbl_IB_IssueEntry_Layout_Master",,, "class='form-control'", False,, ) %>
                                                <%--  <select class="selectpicker">
                                                    <option selected="selected"></option>
                                                    <option>1</option>
                                                    <option>2</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="issueChange" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkIssueChange", "pcpschkIssueChange") %>
                                                    <label for="pcpschkIssueChange"></label>
                                                </div>
                                                <label class="check-label"><%= MyBase.GetResourceString("C_Logissuechanges") %></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 bor-bot">
                                <div class="row">
                                    <%--Commented By Rutuja D. For issue id 20927 --%>
                                    <div class="col-sm-4" style="display: none!important;">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="shareChnage" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkShareChange", "pcpschkShareChange") %>
                                                    <label for="pcpschkShareChange" style="display: none!important;"></label>
                                                </div>
                                                <label class="check-label" style="display: none!important;"><%= MyBase.GetResourceString("C_ShareissuewithinProjectGroup") %></label>
                                            </div>
                                        </div>
                                    </div>
                                    <%--End Added By Rutuja D. For issue id 20927 --%>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="sendMailres" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkSendMailres", "pcpschkSendMailres") %>
                                                    <label for="pcpschkSendMailres"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_SendMailtoResponsiblePerson") %></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field" id="pcpschklAssignIssue_Div" style="display: none">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="assignIssue" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkAssignIssue", "pcpschkAssignIssue") %>
                                                    <label for="pcpschkAssignIssue" id="pcpschklAssignIssue" ></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1">Assign Issue (Create Task) to Responsible Person</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_ResponsiblePersonForIssue") %>  <span style="color: red">*</span></label>
                                            <div class="custom-dropdown">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboResponsiblePerson", "Select 0,'--select--' ",,, "class='form-control'", True,, ) %>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboResponsiblePerson", "usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'AssignTo' ," & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control selectpicker'", False,, ) %>--%>

                                                <%--  <select class="selectpicker">
                                                    <option selected="selected">Amruta</option>
                                                    <option>Omkar</option>
                                                    <option>Pradip</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="issueSLA" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkIssueSLA", "pcpschkIssueSLA") %>
                                                    <label for="pcpschkIssueSLA"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_IsIssueSLAApplicable") %></label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="main-form-inner">
                        <div class="form-sec-first">
                            <div class="sec-first-title">
                                <h4><%= MyBase.GetResourceString("C_GeneralSetting") %></h4>
                            </div>
                            <div class="col-sm-12 bor-bot">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_AuthenticationType") %><span style="color: red">*</span></label>
                                            <div class="custom-dropdown">
                                                <%--Added By Rutuja D 6 Jan 2020 For Binging Authentication Type Drop Down.--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboAuthenticationType", " usp_Whizible2_Sel_tbl_RTS_ProjectSpecificControlData  'AuthenticationType'",,, "class='form-control selectpicker'", False,, ) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboAuthenticationType", " Select ''",,, "class='form-control'", False,, ) %>

                                                <%--End of addition By Rutuja D 6 Jan 2020 For Binging Authentication Type Drop Down.--%>

                                                <%--<select class="selectpicker">
                                                    <option selected="selected">Internal</option>
                                                    <option>External</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_PurchaseOrderNumber") %></label>
                                            <%--<input type="text" class="text-field">--%>
                                            <%--Commented And Added By Usha Pandit On 11.06.2020 For allowing maxlength - 20--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtPurchaseOrderNo", "pcpstxtPurchaseOrderNo", "text-field",, 50,,,,,,,,,,,,,,, True) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtPurchaseOrderNo", "pcpstxtPurchaseOrderNo", "text-field",, 20,,,,,,,,,,,,,,, True) %>
                                            <%--end Of Added By Usha Pandit On 11.06.2020 For allowing maxlength - 20--%>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <label><%= MyBase.GetResourceString("C_PurchaseOrderDate") %></label>
                                                <div class="cal-main-wrap">
                                                    <%--<input type="text" id="RRdate" class="text-field" placeholder="mm/dd/yyyy">--%>
                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtPurchaseOrderDate", " usp_Whizible2_Sel_tbl_RTS_ProjectSpecificControlData  'AuthenticationType'",,, "class='form-control' placeholder='mm/dd/yyyy' ", False,, ) %>--%>
                                                    <%--Commented And Added By Usha Pandit On 11.06.2020 for restricting alphabates for Purchase Order Date--%>
                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtPurchaseOrderDate", "pcpstxtPurchaseOrderDate", "text-field",, 10,,,,,,,,,,,,,,, True) %>--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtPurchaseOrderDate", "pcpstxtPurchaseOrderDate", "text-field",, 10,,,,,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'",,,,,,, True) %>
                                                    <%--End Of Added By Usha Pandit On 11.06.2020 for restricting alphabates for Purchase Order Date--%>
                                                    <span class="cal-wrap"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_GLAccountCode") %></label>
                                            <%--<input type="text" class="text-field">--%>
                                            <%--Commented And Added By Usha Pandit On 11.06.2020 For allowing maxlength - 16--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtGLAccountCode", "pcpstxtGLAccountCode", "text-field",, 50,,,,,,,,,,,,,,, True) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtGLAccountCode", "pcpstxtGLAccountCode", "text-field",, 16,,,,,,,,,,,,,,, True) %>
                                            <%--End Of Added By Usha Pandit On 11.06.2020 For allowing maxlength - 16--%>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_DefaultCrossRefNo") %></label>
                                            <%--<input type="text" class="text-field">--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("pcpstxtDefaultCrossRefNo", "pcpstxtDefaultCrossRefNo", "text-field",, 10,,,,,,,,,,,,,,, True) %>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                             <%-- Commented and added by Chetan M on 26th Oct 2020 for JD Issue 27807 --%>
                                            <%--<div class="form-check">--%>
                                            <div class="form-check" id="divpcpschkSupportProject">
                                                 <%-- End of Commented and added by Chetan M on 26th Oct 2020 for JD Issue 27807 --%>
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkSupportProject", "pcpschkSupportProject") %>
                                                    <label for="pcpschkSupportProject"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_SupportProject") %></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-12 bor-bot">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_ProjectCalculation") %></label>
                                            <div class="custom-dropdown">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboProjectCalculation", "usp_Whizible2_Sel_tbl_PM_Project_PercentCalculation",,, "class='form-control'", False,, ) %>
                                                <%-- <select class="selectpicker">
                                                    <option selected="selected">Only MPP Tasks</option>
                                                    <option>Only MPP Tasks</option>
                                                    <option>Only MPP Tasks</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label>Issue Aging Duration</label>
                                            <div class="custom-dropdown">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtIssueAging", "txtIssueAging", "form-control input-sm ", , 10,,,, ,,,, " onkeypress='return Field_OnKeyPress(event)' autocomplete='off'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_ProjectTimesheetApprover") %></label>
                                            <div class="custom-dropdown">

                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboProjectTimesheetApprover", "usp_Whizible2_Sel_ProjectTimesheetApprovers " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control selectpicker'", True,, ) %>--%>

                                                <%--<select class="selectpicker">
                                                    <option selected="selected"></option>
                                                    <option>1</option>
                                                    <option>2</option>
                                                </select>--%>
                                                <%--123--%>
                                                <%--  <select class="selectpicker">
                                                <optgroup label="Picnic">
                                                    <option >Mustard</option>
                                                    <option>Ketchup</option>
                                                    <option>Relish</option>
                                                </optgroup>
                                                <optgroup label="Camping">
                                                    <option selected="selected">Tent</option>
                                                    <option>Flashlight</option>
                                                    <option>Toilet Paper</option>
                                                </optgroup>
                                            </select>--%>
                                                <select id="pcpsCboProjectTimesheetApprover"></select>


                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <%-- Commented and added by Chetan M on 26th Oct 2020 for JD Issue 27807 --%>
                                            <%--<div class="form-check">--%>
                                            <div class="form-check" id="divpcpschkProductEngProduct">
                                                 <%--End of Commented and added by Chetan M on 26th Oct 2020 for JD Issue 27807 --%>
                                                <div class="custom_chckbox">
                                                    <%--<input id="assignIssue" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkProductEngProduct", "pcpschkProductEngProduct") %>
                                                    <label for="pcpschkProductEngProduct"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_ProductEngineeringProject") %></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 bor-bot">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="showEarned" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkShowEarned", "pcpschkShowEarned") %>
                                                    <label for="pcpschkShowEarned"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_ShowEarnedValueinProjectHealthSheet") %></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="main-form-inner">
                        <div class="form-sec-first">
                            <div class="sec-first-title">
                                <h4><%= MyBase.GetResourceString("C_MSPSettings") %></h4>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="enforce" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkEnforce", "pcpschkEnforce") %>
                                                    <label for="pcpschkEnforce"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_EnforceConstraintsonTasks") %></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_MSPFileOwner") %><span style="color: red">*</span></label>
                                            <div class="custom-dropdown">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboMSPFileOwner", "Select 0,'--select--' ",,, "class='form-control'", True,, ) %>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboMSPFileOwner", "usp_Sel_tbl_PM_ProjectEmployeeRoleForMSPOwnership null, " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control selectpicker'", False,, ) %>--%>
                                                <%--  <select class="selectpicker">
                                                    <option selected="selected">Amruta</option>
                                                    <option>Pradip</option>
                                                    <option>Omkar</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_MSPIntegrationMethod") %></label>
                                            <div class="custo-dropdown">
                                                <%--Commented & Added By Rutuja D. 6 Jan 2020 For Binding Place Holder MSP Integration Method--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboMSPIntegration", "SELECT 1,'Actual Effort Based' UNION SELECT 2,'Percentage Completion Based'",,, "class='form-control selectpicker'", True,, ) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboMSPIntegration", "SELECT 0,'Select MSP Integration Method' UNION SELECT 1,'Actual Effort Based' UNION SELECT 2,'Percentage Completion Based'",,, "class='form-control'",,, ) %>
                                                <%--End Commented & Added By Rutuja D. 6 Jan 2020For Binding Place Holder MSP Integration Method--%>

                                                <%--<select class="selectpicker">
                                                    <option selected="selected"></option>
                                                    <option>1</option>
                                                    <option>2</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="main-form-inner">
                        <div class="form-sec-first">
                            <div class="sec-first-title">
                                <h4><%= MyBase.GetResourceString("C_TimesheetBlockingConfiguration") %></h4>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <label><%= MyBase.GetResourceString("C_PersonresponsibleforTimesheetblocking") %></label>
                                            <div class="custom-dropdown">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboTimesheetBlocking", "Select 0,'--select--' ",,, "class='form-control'", True,, ) %>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcpsCboTimesheetBlocking", " usp_Whizible2_Sel_tbl_PM_Employee_Project_Resources " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control selectpicker'", True,, ) %>--%>
                                                <%--  <select class="selectpicker">
                                                    <option selected="selected"></option>
                                                    <option>1</option>
                                                    <option>2</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="main-form-inner">
                        <div class="form-sec-first">
                            <div class="sec-first-title">
                                <h4><%= MyBase.GetResourceString("C_TaskSettings") %></h4>
                            </div>
                            <div class="col-sm-12 bor-bot">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkResourceDateValidation", "pcpschkResourceDateValidation") %>
                                                    <%--<input id="resouceData" class="chcktbl" type="checkbox" />--%>
                                                    <label for="pcpschkResourceDateValidation"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_ResourceDateValidation") %></label>
                                                <span><%= MyBase.GetResourceString("C_ResourceDateValidationTL") %></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkAllowResource", "pcpschkAllowResource") %>
                                                    <%--<input id="allowResource" class="chcktbl" type="checkbox">--%>
                                                    <label for="pcpschkAllowResource"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_AllowResoucetoCompletetheTask") %></label>
                                                <span><%= MyBase.GetResourceString("C_AllowResoucetoCompletetheTaskTL") %></span>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-field">
                                            <div class="form-check">
                                                <div class="custom_chckbox">
                                                    <%--<input id="applySub" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkApplySubTask", "pcpschkApplySubTask") %>
                                                    <label for="pcpschkApplySubTask" id="pcpschklApplySubTask"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_ApplySubTaskTypes") %></label>
                                            </div>
                                        </div>
                                    </div>
                                 <%--   Commented & Added By Dipali V On 8th Jan 2025 For Effort Distribution Flag--%>
                                    <div class="col-sm-4" style="display:none">
                                        <%--Commented And Added By Usha Pandit On 02.09.2020 For hiding effort distribution flag--%>
                                        <%--<div class="form-field">--%>
                                        <div class="form-field" >
                                            <%--End Of Added By Usha Pandit On 02.09.2020 For hiding effort distribution flag--%>
                                            <div class="form-check">
                                                <div class="custom_chckbox">                                                    
                                                    <%--<input id="applyEffort" class="chcktbl" type="checkbox">--%>
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcpschkApplyEffort", "pcpschkApplyEffort") %>
                                                    <label for="pcpschkApplyEffort" id="pcpschklApplyEffort"></label>
                                                </div>
                                                <label class="check-label" for="exampleCheck1"><%= MyBase.GetResourceString("C_ApplyEffortDistribution") %></label>
                                            </div>
                                        </div>
                                    </div>

                                       <%--End of Commented & Added By Dipali V On 8th Jan 2025 For Effort Distribution Flag--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="note-wrap">
                <p><strong><%= MyBase.GetResourceString("C_PMC_Note") %></strong></p>
                <ul>
                    <li><%= MyBase.GetResourceString("C_PM_Note1_ConfigSetting") %></li>
                    <li><%= MyBase.GetResourceString("C_PM_Note2_ConfigSetting") %></li>
                    <li><%= MyBase.GetResourceString("C_PM_Note3_ConfigSetting") %></li>
                </ul>
            </div>
    </div>
    <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
        <button type="button" onclick="CloseShowAlert()" class="close">×</button>
        <p id="alertMsg"></p>
    </div>
    <!--ps_configuration_table_end-->


    </section>


        <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->

<!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>      
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>

    <script>
        //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        EmployeeID = '<%= Session("intUserID") %>';
        UserName = '<%= Session("strUserName") %>';
        //let searchParams = new URLSearchParams(window.location.search);
        // var ProjectID = searchParams.get('ProjectID');
        var ProjectID = "<%= Request.QueryString("ProjectID") %>";
        <%--ProjectID = '<%= Session("intProjectID") %>';--%>
        ProjectName = '<%= Session("strProjectName") %>';

        var AddAccess = '<%= m_AddAccess %>';
        var EditAccess = '<%= m_EditAccess %>';
        var DeleteAccess = '<%= m_DeleteAccess %>';
        var ViewAccess = '<%= m_ViewAccess %>';
        //$("#btnIssueSeverity").click(function () {
        //    window.location.href = "PM_IssueSeverity.aspx"
        //});
        //$("#btnpriorities").click(function () {
        //    window.location.href = "PM_Priorities.aspx"
        //});
        //$("#btnversion").click(function () {
        //    window.location.href = "PM_Version.aspx"
        //});
        //$("#btnRootCause").click(function () {
        //    window.location.href = "PM_RootCauses.aspx"
        //});
        //$("#btnEmailSettings").click(function () {
        //    window.location.href = "PM_EmailSettings.aspx"
        //});
        //$("#btnTaskType").click(function () {
        //    window.location.href = "PM_TaskType.aspx"
        //});
        //$("#btnDeliverableSettings").click(function () {
        //    window.location.href = "PM_DeliverableSettings.aspx"
        //});
        function getURLParameter(url, name) {
            return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
        }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjectConfigurationSettings%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjectConfigurationSettings%>');
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
        }//End by Rehan


        function SaveProjectConfiguration() {
            //debugger;
            var pcpsCboIssueLayoutType = document.getElementById("pcpsCboIssueLayoutType");
            var pcpsCboIssueEntryLayout = document.getElementById("pcpsCboIssueEntryLayout");
            var pcpschkIssueChange = document.getElementById("pcpschkIssueChange");
            var pcpschkShareChange = document.getElementById("pcpschkShareChange");
            var pcpschkSendMailres = document.getElementById("pcpschkSendMailres");
            var pcpschkAssignIssue = document.getElementById("pcpschkAssignIssue");
            var pcpsCboResponsiblePerson = document.getElementById("pcpsCboResponsiblePerson");
            var pcpsCboProjectCalculation = document.getElementById("pcpsCboProjectCalculation");
            var pcpsCboProjectTimesheetApprover = document.getElementById("pcpsCboProjectTimesheetApprover");
            var pcpsCboAuthenticationType = document.getElementById("pcpsCboAuthenticationType");
            var pcpschkEnforce = document.getElementById("pcpschkEnforce");
            var pcpsCboMSPFileOwner = document.getElementById("pcpsCboMSPFileOwner");
            var pcpsCboTimesheetBlocking = document.getElementById("pcpsCboTimesheetBlocking");
            var pcpsCboMSPIntegration = document.getElementById("pcpsCboMSPIntegration");
            var pcpschkResourceDateValidation = document.getElementById("pcpschkResourceDateValidation");
            var pcpschkAllowResource = document.getElementById("pcpschkAllowResource");
            var pcpschkApplySubTask = document.getElementById("pcpschkApplySubTask");
            var pcpschkApplyEffort = document.getElementById("pcpschkApplyEffort");
            var pcpschkShowEarned = document.getElementById("pcpschkShowEarned");
            var pcpschkIssueSLA = document.getElementById("pcpschkIssueSLA");
            //Added By RehanC for Support Project and Product Engineering Project checboxes issue on 21st Mar 2023
            var pcpschkSupportProject = document.getElementById("pcpschkSupportProject");
            var pcpschkProductEngProduct = document.getElementById("pcpschkProductEngProduct");
            //End of Comment By RehanC for Support Project and Product Engineering Project issue on 21st Mar 2023
            //var pcpstxtPurchaseOrderNo = document.getElementById("pcpstxtPurchaseOrderNo");
            //var pcpstxtPurchaseOrderDate = document.getElementById("pcpstxtPurchaseOrderDate");
            //var pcpstxtGLAccountCode = document.getElementById("pcpstxtGLAccountCode");
            //var pcpstxtDefaultCrossRefNo = document.getElementById("pcpstxtDefaultCrossRefNo");

             var IssueAging = document.getElementById("txtIssueAging");

            if (document.getElementById("pcpstxtPurchaseOrderNo").value != "") {
                var pcpstxtPurchaseOrderNo = document.getElementById("pcpstxtPurchaseOrderNo").value;
            }
            else {
                //var pcpstxtPurchaseOrderNo = "NULL";
                var pcpstxtPurchaseOrderNo =0;
            }
            //debugger;
            if (document.getElementById("pcpstxtPurchaseOrderDate").value != "") {
                //var pcpstxtPurchaseOrderDate = new Date(document.getElementById("pcpstxtPurchaseOrderDate").value).toLocaleDateString("en-US");
                var pcpstxtPurchaseOrderDate = document.getElementById("pcpstxtPurchaseOrderDate").value;
            }
            else {
                //var pcpstxtPurchaseOrderDate = "NULL";
                var pcpstxtPurchaseOrderDate = 0;
            }

            if (document.getElementById("pcpstxtGLAccountCode").value != "") {
                var pcpstxtGLAccountCode = document.getElementById("pcpstxtGLAccountCode").value;
            }
            else {
                //var pcpstxtGLAccountCode = "NULL";
                var pcpstxtGLAccountCode = 0;
            }

            if (document.getElementById("pcpstxtDefaultCrossRefNo").value != "") {
                var pcpstxtDefaultCrossRefNo = document.getElementById("pcpstxtDefaultCrossRefNo").value;
            }
            else {
                var pcpstxtDefaultCrossRefNo = "0";
            }
           
            //alert(pcpsCboTimesheetBlocking.value);
          //Added by imran on 06-01-2023
            var IssueAging = IssueAging.value; 
            if (IssueAging > 0) {

            }
            else if (IssueAging =="")
            {
                IssueAging = ""; 
            }
            else
            {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Issue Aging Duration should be greater than zero');
                return;
            }
            //End of comment by imran on 06-01-2023
            var chkFlag;
            chkFlag = ValidateCreateTask();
            if (chkFlag != false && EmployeeID != "")
            {
                //Added by imran on 06-09-2022

                if (pcpschkIssueChange.checked == true)
                {
                    var IBHistoryOn = 1
                }
                else {
                    var IBHistoryOn = 0;
                }

                if (pcpschkShareChange.checked == true) {
                    var pcpschkShareChange = 1
                }
                else {
                    var pcpschkShareChange = 0;
                }

                if (pcpschkSendMailres.checked == true) {
                    var pcpschkSendMailres = 1
                }
                else {
                    var pcpschkSendMailres = 0;
                }

                if (pcpschkAssignIssue.checked == true) {
                    var pcpschkAssignIssue = 1
                }
                else {
                    var pcpschkAssignIssue = 0;
                }

                //Uncommented By RehanC for Support Project and Product Engineering Project checboxes issue on 21st Mar 2023
                if (pcpschkSupportProject.checked == true) {
                    var pcpschkSupportProject = 1
                }
                else {
                    var pcpschkSupportProject = 0;
                }

                if (pcpschkProductEngProduct.checked == true) {
                    var pcpschkProductEngProduct = 1
                }
                else {
                    var pcpschkProductEngProduct = 0;
                }

                if (pcpschkResourceDateValidation.checked == true) {
                    var pcpschkResourceDateValidation = 1
                }
                else {
                    var pcpschkResourceDateValidation = 0;
                }

                if (pcpschkAllowResource.checked == true) {
                    var pcpschkAllowResource = 1
                }
                else {
                    var pcpschkAllowResource = 0;
                }

                if (pcpschkApplySubTask.checked == true) {
                    var pcpschkApplySubTask = 1
                }
                else {
                    var pcpschkApplySubTask = 0;
                }

                if (pcpschkApplyEffort.checked == true) {
                    var pcpschkApplyEffort = 1
                }
                else {
                    var pcpschkApplyEffort = 0;
                }

                if (pcpschkShowEarned.checked == true) {
                    var pcpschkShowEarned = 1
                }
                else {
                    var pcpschkShowEarned = 0;
                }

                if (pcpschkIssueSLA.checked == true) {
                    var pcpschkIssueSLA = 1
                }
                else {
                    var pcpschkIssueSLA = 0;
                }

                if (pcpschkEnforce.checked == true) {
                    var pcpschkEnforce = 1
                }
                else {
                    var pcpschkEnforce = 0;
                }                

                if (pcpsCboTimesheetBlocking.value == "") {
                    pcpsCboTimesheetBlocking = 0;
                }
                else {
                    pcpsCboTimesheetBlocking=pcpsCboTimesheetBlocking.value
                }

                if (pcpsCboProjectTimesheetApprover.value == "Select Project Timesheet Approver") {
                    pcpsCboProjectTimesheetApprover = 0;
                }
                else {
                    pcpsCboProjectTimesheetApprover = pcpsCboProjectTimesheetApprover.value;
                }

                if (pcpstxtPurchaseOrderDate.val == "") {
                    pcpstxtPurchaseOrderDate = "";
                }
                else {
                    pcpstxtPurchaseOrderDate = pcpstxtPurchaseOrderDate.val;
                }
                
                var taskParameters = {
                    IssueLayoutType: pcpsCboIssueLayoutType.value,
                    LayoutID: pcpsCboIssueEntryLayout.value,                   
                    IBHistoryOn: IBHistoryOn,
                    ShareIBwithinProjectGroup: pcpschkShareChange,
                    SendResponsiblePersonMail: pcpschkSendMailres,
                    AssignIssueToResponsiblePerson: pcpschkAssignIssue,
                    ResponsiblePersonForIssue: pcpsCboResponsiblePerson.value,
                    PercentCalculation: pcpsCboProjectCalculation.value,
                    TimeSheetAuthenticatorID: pcpsCboProjectTimesheetApprover,

                    TimeSheetAuthenticatedBy: pcpsCboAuthenticationType.options[pcpsCboAuthenticationType.selectedIndex].text,
                    PurchaseOrderNumber: pcpstxtPurchaseOrderNo,
                    PurchaseOrderDate: pcpstxtPurchaseOrderDate,//new Date(pcpstxtPurchaseOrderDate.value).toLocaleDateString("en-US"),
                    GLAccountCode: pcpstxtGLAccountCode,
                    DefaultCrossRefNo: pcpstxtDefaultCrossRefNo,
                   
                    DeliverableLevelCustomer: pcpschkSupportProject,
                    IsProductDevelopementProject: pcpschkProductEngProduct,
                    EnforceConstraints: pcpschkEnforce,
                    MSPFileOwner: pcpsCboMSPFileOwner.value,
                    //Commented By Dipali  V On 17th For Saving TimesheetBloacking Approver
                    BackDatingEmployeeID: pcpsCboTimesheetBlocking,
                    //BackDatingEmployeeID: selectedTimesheetBlockingEmployeeid,
                    //End of Commented By Dipali  V On 17th For Saving TimesheetBloacking Approver
                    MSPIntegrationMethod: pcpsCboMSPIntegration.value,
                    ResourceValidation: pcpschkResourceDateValidation,
                    ResourceLevelTaskCompletion: pcpschkAllowResource,
                    HaveSubTaskTypes: pcpschkApplySubTask,
                    ApplyEffortDistribution: pcpschkApplyEffort,
                    EVApplicable: pcpschkShowEarned,
                    IsIssueSLAApplicable: pcpschkIssueSLA,
                    ModifiedBy: UserName,
                    ProjectID: ProjectID,
                    Command: "UPD",
                    IssueAgingDurration: IssueAging
                }

                //var taskParameters = {
                //    IssueLayoutType: encodeURI(pcpsCboIssueLayoutType.value),
                //    LayoutID: encodeURI(pcpsCboIssueEntryLayout.value),
                //    IBHistoryOn: encodeURI(pcpschkIssueChange.checked),
                //    ShareIBwithinProjectGroup: encodeURI(pcpschkShareChange.checked),
                //    SendResponsiblePersonMail: encodeURI(pcpschkSendMailres.checked),
                //    AssignIssueToResponsiblePerson: encodeURI(pcpschkAssignIssue.checked),
                //    ResponsiblePersonForIssue: encodeURI(pcpsCboResponsiblePerson.value),
                //    PercentCalculation: encodeURI(pcpsCboProjectCalculation.value),
                //    TimeSheetAuthenticatorID: encodeURI(pcpsCboProjectTimesheetApprover.value),
                    
                //    TimeSheetAuthenticatedBy: encodeURI(pcpsCboAuthenticationType.options[pcpsCboAuthenticationType.selectedIndex].text),
                //    PurchaseOrderNumber: encodeURI(Trim(pcpstxtPurchaseOrderNo)),
                //    PurchaseOrderDate: encodeURI(Trim(pcpstxtPurchaseOrderDate)),//new Date(pcpstxtPurchaseOrderDate.value).toLocaleDateString("en-US"),
                //    GLAccountCode: encodeURI(Trim(pcpstxtGLAccountCode)),
                //    DefaultCrossRefNo: encodeURI(Trim(pcpstxtDefaultCrossRefNo)),
                //    DeliverableLevelCustomer: encodeURI(pcpschkSupportProject.checked),
                //    IsProductDevelopementProject: encodeURI(pcpschkProductEngProduct.checked),
                //    EnforceConstraints: encodeURI(pcpschkEnforce.checked),
                //    MSPFileOwner: encodeURI(pcpsCboMSPFileOwner.value),
                //    //Commented By Dipali  V On 17th For Saving TimesheetBloacking Approver
                //    BackDatingEmployeeID: encodeURI(pcpsCboTimesheetBlocking.value),
                //    //BackDatingEmployeeID: encodeURI(selectedTimesheetBlockingEmployeeid),
                //      //End of Commented By Dipali  V On 17th For Saving TimesheetBloacking Approver
                //    MSPIntegrationMethod: encodeURI(pcpsCboMSPIntegration.value),
                //    ResourceValidation: encodeURI(pcpschkResourceDateValidation.checked),
                //    ResourceLevelTaskCompletion: encodeURI(pcpschkAllowResource.checked),
                //    HaveSubTaskTypes: encodeURI(pcpschkApplySubTask.checked),
                //    ApplyEffortDistribution: encodeURI(pcpschkApplyEffort.checked),
                //    EVApplicable: encodeURI(pcpschkShowEarned.checked),
                //    IsIssueSLAApplicable: encodeURI(pcpschkIssueSLA.checked),
                //    ModifiedBy: encodeURI(UserName),
                //    ProjectID: encodeURI(ProjectID),
                //    Command: encodeURI("UPD")
                //}        

                //End of comment by imran on 06-09-2022
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectConfigurationSettings/UpdateProjectConfigurationData',
                    type: "POST",
                    data: JSON.stringify(taskParameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (taskParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                        }
                    },
                    success: function (data) {
                        //debugger
                        if (data.ProjectConfigDetailsLists[0].ack == "updated") {
                            //added and commented by omkar 20/3/2020 issue id 23048

                            var msg = '<%= MyBase.GetResourceString("C_PM_ConfigSetting_msgSuccess") %>';
                                if (msg.indexOf('Configure') > -1) {
                                    ///Added & Commented By Dipali V On 14th April 2020 For alter changes
                                    //msg = msg.replace('Configure','Configuration');
                                    msg = msg.replace('Configure', 'Configurations');
                                    ///End of Added & Commented By Dipali V On 14th April 2020 For alter changes
                                }

                                //showAlert('<%= MyBase.GetResourceString("C_PM_ConfigSetting_msgSuccess") %>', 'alert-success');
                                showAlert(msg, 'alert-success');
                                //end of added and commented by omkar 20/3/2020 issue id 23048
                                refreshMyParent();
                            }
                            else {
                                showAlert('<%= MyBase.GetResourceString("C_PM_ConfigSetting_msgFailed") %>', 'alert-danger');
                        }
                        return false;
                    },
                    error: function (err) {

                        console.log(err);
                        return;
                        //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            else {
                //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=sessionover"
            }
        }

        
 //Added by Chetan M on 26th Oct 2020 for get the ISProductExecutionProject is on or not
        function GetISProductExecutionProject() {            
            $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectConfigurationSettings/GetISProductExecutionProject',
                    type: "POST",
                    data: JSON.stringify(ProjectID),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                        }
                    },
                    success: function (data) {                        
                        if (data[0].ISProductExecutionProject == false) {                            
                            $("#divpcpschkProductEngProduct").hide();
                            $("#divpcpschkSupportProject").hide();
                        }
                        else {
                             $("#divpcpschkProductEngProduct").show();
                            $("#divpcpschkSupportProject").show();
                        }
                    },
                    error: function (err) {

                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
        }
        //End of Added by Chetan M on 26th Oct 2020 for get the ISProductExecutionProject is on or not


        function GetProjectName() {
            $("#ProjectName").empty();
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_TaskType/GetProjectName'),
                type: "POST",
                data: JSON.stringify(ProjectID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {
                    if (result != null) {
                        $("#ProjectName").append(result[0].ProjectName);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }
        $("#pcpsCboIssueLayoutType").change(function () {
            if (this.value == "P") {
                    //Commented By Rutuja D On 19.12.2019
                   <%-- showAlert('<%= MyBase.GetResourceString("C_AL1_pcpsCboIssueLayoutType") %>', 'alert-success');
                    pcpsCboIssueLayoutType.focus();--%>
                //Commented By Rutuja D On 19.12.2019
            }
        });
        //Added By Dipali V On 17th March 2021 For saving Approver
        var selectedTimesheetBlockingEmployeeid = "";
        function BindProjectTimesheetApprover(id) {
            //123
            var taskParameters_pta = {
                ProjectID: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectConfigurationSettings/GetProjectTimesheetApprover',
                type: "POST",
                data: JSON.stringify(taskParameters_pta),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters_pta) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_pta) ? taskParameters_pta : JSON.stringify(taskParameters_pta)));
                    }
                },
                success: function (data) {
                    var selHTML = "";
                    selHTML += "<option >Select Project Timesheet Approver</option>"
                    var v1 = "";
                    
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        if (v1 != d.IsExternal && i == 0) {
                            selHTML += "<optgroup label='" + d.IsExternal + "'>";
                            v1 = d.IsExternal;
                        }
                        if (v1 != d.IsExternal && i != 0 && i != data.length - 1) {
                            selHTML += "</optgroup><optgroup label='" + d.IsExternal + "'>";
                            v1 = d.IsExternal;
                        }
                        if (d.EmployeeID == id) {
                            //Added BY Dipali V On 17th March 2021 For Saving Timesheet Approver
                            selectedTimesheetBlockingEmployeeid = d.EmployeeID;
                            //End of Added BY Dipali V On 17th March 2021 For Saving Timesheet Approver
                            selHTML += "<option selected='selected' title='" + d.UserName + "' value='" + d.EmployeeID + "'>" + d.UserName + "</option>";

                        } else {
                            selHTML += "<option  title='" + d.UserName + "' value='" + d.EmployeeID + "'>" + d.UserName + "</option>";
                        }
                        if (v1 != d.IsExternal && i == data.length - 1) {
                            selHTML += "</optgroup>";
                            v1 = d.IsExternal;
                        }
                    }
                    //alert(selectedEmployeeid);
                    $("#pcpsCboProjectTimesheetApprover").html(selHTML);
                    $(".selectpicker").selectpicker('refresh');
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        $(document).ready(function SetProjectConfigurationData() {           
            try {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectConfigSettings").html(bodyHTML);
                    return;
                }
                //DOM manipulation code

                //showAlert('testing by developer', 'alert-danger');
                if (EditAccess == "False") {
                    $("#configuresettingsave").addClass("clsShowHide");
                }
                else {
                    $("#configuresettingsave").removeClass("clsShowHide");
                }

                StartLoader("#pcpsBodyID")
                GetProjectName();
                GetResponsiblePersonForIssue();
                GetMSPFileOwner();
                GetResponsiblePersonForTimesheetBlocking();
                //Added By Rutuja D. 6 Jan 2020 For Binding Authentication Type
                FillAuthenticationTypeCombo();
                //End Added By Rutuja D. 6 Jan 2020 For Binding Authentication Type
                //Added by Chetan M on 26th Oct 2020 for get the ISProductExecutionProject is on or not
                GetISProductExecutionProject();
                //End of Added by Chetan M on 26th Oct 2020 for get the ISProductExecutionProject is on or not
                if (ProjectID == "")
                    $("#configuresettingsave").hide();

                if (EmployeeID != "") {
                    //$("#lblProjName").html(ProjectName);
                    //$("#lblProjName").attr("title", ProjectName);

                    var settaskParameters = {
                        ProjectID: encodeURI(ProjectID),
                        Command: encodeURI("RES")
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectConfigurationSettings/SetProjectConfigurationData',
                        type: "POST",
                        data: JSON.stringify(settaskParameters),
                        dataType: "json",
                        async: false,
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (settaskParameters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(settaskParameters) ? settaskParameters : JSON.stringify(settaskParameters)));
                            }
                        },
                        success: function (data) {
                            console.log(data);
                            //COMBO BOX
                            jQuery("select#pcpsCboIssueLayoutType option[value=" + data[0].IssueLayoutType + "  ]").attr("selected", "selected");
                            jQuery("select#pcpsCboIssueEntryLayout option[value=" + data[0].LayoutID + "  ]").attr("selected", "selected");
                            jQuery("select#pcpsCboResponsiblePerson option[value=" + data[0].ResponsiblePersonForIssue + "  ]").attr("selected", "selected");
                            if (data[0].PercentCalculation != "") {
                                jQuery("select#pcpsCboProjectCalculation option[value=" + data[0].PercentCalculation + "  ]").attr("selected", "selected");
                            }
                            //jQuery("select#pcpsCboProjectTimesheetApprover option[value=" + data[0].TimeSheetAuthenticatorID + "  ]").attr("selected", "selected");

                            jQuery("select#pcpsCboAuthenticationType option[value=" + data[0].TimeSheetAuthenticatedBy + "  ]").attr("selected", "selected");
                            jQuery("select#pcpsCboMSPFileOwner option[value=" + data[0].MSPFileOwner + "  ]").attr("selected", "selected");
                            jQuery("select#pcpsCboTimesheetBlocking option[value=" + data[0].BackDatingEmployeeID + "  ]").attr("selected", "selected");
                            jQuery("select#pcpsCboMSPIntegration option[value=" + data[0].MSPIntegrationMethod + "  ]").attr("selected", "selected");
                            //CHECK BOX
                            $('#pcpschkIssueChange').prop('checked', data[0].IBHistoryOn);
                            $('#pcpschkShareChange').prop('checked', data[0].ShareIBwithinProjectGroup);
                            $('#pcpschkSendMailres').prop('checked', data[0].SendResponsiblePersonMail);

                            if (data[0].IsAssignIssueToResponsiblePerson) {
                               // debugger;
                                //Added By Dipali V On 18th Oct 2021 For Create Review Issue Task
                                //$('#pcpschklAssignIssue').prop('hidden', false);
                                $('#pcpschklAssignIssue_Div').css('display', 'block');
                                //End of Added By Dipali V On 18th Oct 2021 For Create Review Issue Task
                            } else {
                                //Added By Dipali V On 18th Oct 2021 For Create Review Issue Task
                              // $('#pcpschklAssignIssue').prop('hidden', true);
                                $('#pcpschklAssignIssue_Div').css('display', 'none');
                                //End of Added By Dipali V On 18th Oct 2021 For Create Review Issue Task
                            }
                            $('#pcpschkAssignIssue').prop('checked', data[0].AssignIssueToResponsiblePerson);
                            $('#pcpschkSupportProject').prop('checked', data[0].DeliverableLevelCustomer);
                            $('#pcpschkProductEngProduct').prop('checked', data[0].IsProductDevelopementProject);

                            $('#pcpschkEnforce').prop('checked', data[0].EnforceConstraints);
                            $('#pcpschkResourceDateValidation').prop('checked', data[0].ResourceValidation);
                            $('#pcpschkAllowResource').prop('checked', data[0].ResourceLevelTaskCompletion);
                            //alert(data[0].IsDisableEffortDistribution);
                            //alert(data[0].IsDisableSubTaskTypes);
                            if (data[0].IsDisableEffortDistribution == true && data[0].IsDisableSubTaskTypes == false) {
                                $('#pcpschkApplyEffort').prop('checked', data[0].ApplyEffortDistribution);
                                $("#pcpschkApplyEffort").prop("disabled", true);
                                $("#pcpschklApplyEffort").addClass("lblcrsr");
                            }

                            else if (data[0].IsDisableSubTaskTypes == true && data[0].IsDisableEffortDistribution == false) {
                                $('#pcpschkApplySubTask').prop('checked', data[0].HaveSubTaskTypes);
                                $("#pcpschkApplySubTask").prop("disabled", true);
                                $("#pcpschklApplySubTask").addClass("lblcrsr");
                            }
                            else if (data[0].IsDisableSubTaskTypes == true && data[0].IsDisableEffortDistribution == true) {
                                $('#pcpschkApplyEffort').prop('checked', data[0].ApplyEffortDistribution);
                                $("#pcpschkApplyEffort").prop("disabled", true);
                                $("#pcpschklApplyEffort").addClass("lblcrsr");
                                $('#pcpschkApplySubTask').prop('checked', data[0].HaveSubTaskTypes);
                                $("#pcpschkApplySubTask").prop("disabled", true);
                                $("#pcpschklApplySubTask").addClass("lblcrsr");
                            }
                            else {
                                $('#pcpschkApplySubTask').prop('checked', data[0].HaveSubTaskTypes);
                                $('#pcpschkApplyEffort').prop('checked', data[0].ApplyEffortDistribution);
                            }

                            $('#pcpschkShowEarned').prop('checked', data[0].EVApplicable);
                            $('#pcpschkIssueSLA').prop('checked', data[0].IsIssueSLAApplicable);
                            //TEXT BOX
                            var date = new Date(data[0].PurchaseOrderDate);
                            var dt;
                            if (data[0].PurchaseOrderDate != null) {
                                dt = ((date.getMonth() > 8) ? (date.getMonth() + 1) : ('0' + (date.getMonth() + 1))) + '/' + ((date.getDate() > 9) ? date.getDate() : ('0' + date.getDate())) + '/' + date.getFullYear()
                            }

                            $('#pcpstxtPurchaseOrderNo').prop('value', data[0].PurchaseOrderNumber);
                            //Added By Dipali V On 6th April 2023 For Get Issue Againg values
                            $('#txtIssueAging').val(data[0].IssueAgingDuration);
                             //End of Added By Dipali V On 6th April 2023 For Get Issue Againg values
                            //$('#pcpstxtPurchaseOrderDate').prop('value', dt);
                            $('#pcpstxtPurchaseOrderDate').prop('value', data[0].PurchaseOrderDate);
                            $('#pcpstxtGLAccountCode').prop('value', data[0].GLAccountCode);
                            $('#pcpstxtDefaultCrossRefNo').prop('value', data[0].DefaultCrossRefNo);
                            BindProjectTimesheetApprover(data[0].TimeSheetAuthenticatorID);
                            return true;
                        },
                        error: function (err) {
                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
                else {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=sessionover"
                }
                StopAjaxLoader("#pcpsBodyID")
            }
            catch (ex) {
                //alert(ex.message);
            }
        });
        //Commented By RehanC for checkbox Issue
        $('#pcpschkSupportProject').click(function () {
            //Commented And Added By Usha Pandit On 12.06.2020 For correct check/uncheck functionality
            //$('#pcpschkProductEngProduct').prop('checked', false);
            if ($('#pcpschkSupportProject').is(':checked')) {
                $('#pcpschkProductEngProduct').prop('disabled', true);
            }
            else {
                $('#pcpschkProductEngProduct').prop('disabled', false);
            }
            //End Of Added By Usha Pandit On 12.06.2020 For correct check/uncheck functionality
        });
        $('#pcpschkProductEngProduct').click(function () {
            //Commented And Added By Usha Pandit On 12.06.2020 For correct check/uncheck functionality
            //$('#pcpschkSupportProject').prop('checked', false);
            if ($('#pcpschkProductEngProduct').is(':checked')) {
                $('#pcpschkSupportProject').prop('disabled', true);
            }
            else {
                $('#pcpschkSupportProject').prop('disabled', false);
            }
            //End Of Added By Usha Pandit On 12.06.2020 For correct check/uncheck functionality
        });

        function ValidateCreateTask() {
            try {
                var PurchaseOrderNumber = $("#pcpstxtPurchaseOrderNo").val();
                var GLAccCode = $("#pcpstxtGLAccountCode").val();
                var DefaultCrossReff = $("#pcpstxtDefaultCrossRefNo").val();
                               
                    //Commented And Added By Rutuja D. 19 Dec 2019 For Project Based Issue Layout Validation
                   <%-- if (pcpsCboIssueLayoutType != null) {
                        if (pcpsCboIssueLayoutType.value == "P") {
                            //showAlert('<%= MyBase.GetResourceString("C_AL1_pcpsCboIssueLayoutType") %>', 'alert-success');
                            //if (pcpsCboIssueEntryLayout != null) {
                            //showAlert('<%= MyBase.GetResourceString("C_AL1_pcpsCboIssueLayoutType") %>', 'alert-success');
                            //}
                            pcpsCboIssueLayoutType.focus();
                        }
                    }--%>

                    if (pcpsCboIssueLayoutType != null) {
                        if (pcpsCboIssueLayoutType.value == "P") {
                            pcpsCboIssueEntryLayout = $("#pcpsCboIssueEntryLayout").val();

                            if (pcpsCboIssueEntryLayout == null || pcpsCboIssueEntryLayout == '' || pcpsCboIssueEntryLayout == 0) {
                                showAlert('<%= MyBase.GetResourceString("C_AL1_pcpsCboIssueLayoutType") %>', 'alert-danger');
                                return false;
                                pcpsCboIssueEntryLayout.focus();
                            }

                        }
                    }
                    // End By Rutuja D. 19 Dec 2019 For Project Based Issue Layout Validation
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_AL2_pcpsCboIssueLayoutType") %>', 'alert-danger');
                        return false;
                    }
                    var RespPerson = $("#pcpsCboResponsiblePerson option:selected").val();

                    // Added By Rutuja D. 6 Jan 2020 For Project Based Issue Layout Blank Validation
                    if (pcpsCboIssueLayoutType.value == null || pcpsCboIssueLayoutType.value == '') {
                        showAlert("'Type of Issue Layout' should not be left blank", 'alert-danger');
                        return false;
                    }
                    if (pcpsCboResponsiblePerson == null || RespPerson == "0") {
                        showAlert('<%= MyBase.GetResourceString("C_AL_pcpsCboResponsiblePerson") %>', 'alert-danger');
                        return false;
                    }
                    var AuthenticationType = $("#pcpsCboAuthenticationType").val();

                    if (pcpsCboAuthenticationType == null || AuthenticationType == "") {
                        showAlert('<%= MyBase.GetResourceString("C_AL_pcpsCboAuthenticationType") %>', 'alert-danger');
                        return false;
                    }
                    var MspFileOwner = $("#pcpsCboMSPFileOwner").val()
                    if (MspFileOwner == null || MspFileOwner == '') {
                        showAlert("'MSP File Owner' should not be left blank", 'alert-danger');
                        return false;
                    }

                    // End By Rutuja D. 6 Jan 2020 For Project Based Issue Layout Blank Validation


                    if (pcpsCboAuthenticationType == null) {
                        showAlert('<%= MyBase.GetResourceString("C_AL_pcpsCboAuthenticationType") %>', 'alert-danger');
                        return false;
                    }



                //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
                if (checkSpecialCharacter(PurchaseOrderNumber, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Purchase Order Number should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#pcpstxtPurchaseOrderNo").focus();
                    return false;
                }//End of Comment by Rehan C

                //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
                if (checkSpecialCharacter(GLAccCode, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('G/L Account Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#pcpstxtGLAccountCode").focus();
                    return false;
                }//End of Comment by Rehan C

                //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
                if (checkSpecialCharacter(DefaultCrossReff, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Default Cross Ref No. should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#pcpstxtDefaultCrossRefNo").focus();
                    return false;
                }
                    if (pcpsCboMSPFileOwner == null) {
                        showAlert('<%= MyBase.GetResourceString("C_AL_pcpsCboMSPFileOwner") %>', 'alert-danger');
                    return false;
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function showAlert(Msg, className, id) {
            $('.ClosaeblealertMsg').show();
            if (id != undefined) {
                $('#' + id).prop("disabled", true);
            }
            if (className == 'alert-danger') {
                $('#CloseableAlert').removeClass("alert-success");
                $('#CloseableAlert').addClass("alert-danger");
            }
            else if (className == 'alert-success') {
                $('#CloseableAlert').removeClass("alert-danger");
                $('#CloseableAlert').addClass("alert-success");
            }
            $('#alertMsg').html(Msg);
            $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function checkSpecialCharacterProject(value) {
            var regularExpression = '[/:*?+\"><|,\\\\]';
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

        //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
        function GetResponsiblePersonForIssue() {
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_ProjectConfigurationSettings/GetResponsiblePersonForIssue'),
                type: "POST",
                data: JSON.stringify(ProjectID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {
                    var objCboOU = document.getElementById('pcpsCboResponsiblePerson');
                    if (objCboOU != null) {
                        $("#pcpsCboResponsiblePerson").empty();

                        for (var i = 0; i < result.length; i++) {
                            var ObjStatus = result[i];
                            var objOption = document.createElement("OPTION");
                            objCboOU.options.add(objOption);
                            objOption.text = ObjStatus.UserName;
                            objOption.value = ObjStatus.EmployeeID;
                        }
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function GetMSPFileOwner() {
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_ProjectConfigurationSettings/GetMSPFileOwner'),
                type: "POST",
                data: JSON.stringify(ProjectID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {
                    var objCboOU = document.getElementById('pcpsCboMSPFileOwner');
                    if (objCboOU != null) {
                        $("#pcpsCboMSPFileOwner").empty();
                        $("#pcpsCboMSPFileOwner").append('<option value="">Select MSP File Owner</option>');

                        for (var i = 0; i < result.length; i++) {
                            var ObjStatus = result[i];
                            var objOption = document.createElement("OPTION");
                            objCboOU.options.add(objOption);
                            objOption.text = ObjStatus.UserName;
                            objOption.value = ObjStatus.EmployeeID;
                        }
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function GetResponsiblePersonForTimesheetBlocking() {
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_ProjectConfigurationSettings/GetResponsiblePersonForTimesheetBlocking'),
                type: "POST",
                data: JSON.stringify(ProjectID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {

                    var objCboOU = document.getElementById('pcpsCboTimesheetBlocking');
                    if (objCboOU != null) {
                        $("#pcpsCboTimesheetBlocking").empty();
                        $("#pcpsCboTimesheetBlocking").append('<option value="">Select Person Responsible for Timesheet blocking</option>');
                        for (var i = 0; i < result.length; i++) {
                            var ObjStatus = result[i];
                            var objOption = document.createElement("OPTION");
                            objCboOU.options.add(objOption);
                            objOption.text = ObjStatus.Employeename;
                            objOption.value = ObjStatus.Employeeid;
                        }
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        //End of addition By Chetan M.
        //Added By Rutuja D. For Fill Drop Down Values In Type Of Issue Layout
        function FillAuthenticationTypeCombo() {
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_ProjectConfigurationSettings/FillAuthenticationTypeCombo'),
                type: "POST",
                data: JSON.stringify(),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {

                    var objCboOU = document.getElementById('pcpsCboAuthenticationType');
                    if (objCboOU != null) {
                        $("#pcpsCboAuthenticationType").empty();
                        $("#pcpsCboAuthenticationType").append('<option value="">Select Authentication Type</option>');
                        for (var i = 0; i < result.length; i++) {
                            var ObjStatus = result[i];
                            var objOption = document.createElement("OPTION");
                            objCboOU.options.add(objOption);
                            objOption.text = ObjStatus.ControlData;
                            objOption.value = ObjStatus.ControlData;
                        }
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        //End Added By Rutuja D. For Fill Drop Down Values In Type Of Issue Layout

        //Added By Usha Pandit On 11.06.2020 for restricting alphabates for Purchase Order Date
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
            //End Of Added By Usha Pandit On 11.06.2020 for restricting alphabates for Purchase Order Date
    </script>
    <script>
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


        $('#pcpstxtPurchaseOrderDate').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'
        });


    </script>
    <%--  </form>--%>
    
    </div>
</body>
</html>
