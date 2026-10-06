<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectLevelSLA.aspx.vb" Inherits="PbNIT.PM_ProjectLevelSLA" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head> 
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_Project") %></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2" />

    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />

    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

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

        #editProjectSla .dataTables_wrapper table tr th {
            min-width: 80px;
        }

            #editProjectSla .dataTables_wrapper table tr th:last-child {
                min-width: 25px;
                text-align: center !important;
            }

        #editProjectSla .dataTables_wrapper table tr td:last-child {
            text-align: center !important;
        }

        #editProjectSla .dataTables_wrapper table .custom_chckbox label:before {
            margin-right: 0;
        }

        .custom_chckbox input[type=checkbox][disabled] + label:before {
            margin-right: 15px;
            CURSOR: NOT-ALLOWED;
        }

        .alertify-notifier {
            z-index: 9999;
        }

        .note-wrap-txt {
            width: 97% !important;
            margin: 15px auto;
            display: flex;
        }

        #ProjLevelSLAtbl {
            margin: 0 auto 20px;
            width: 97%;
        }

        .modal-body .note-wrap-txt {
            width: 100% !important;
            margin-top: 0px;
        }

        .mr-0 {
            margin-right: 0px;
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }
        /*Added By pradip 19 Dec 2019*/
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }
        /* End Added By pradip 19 Dec 2019*/

        /*BS5 changes start*/
        #corporateSla table th:first-child, #corporateSla table th:nth-child(2), #corporateSla table th:nth-child(3) {
            min-width: 160px;
        }

        #SLANormtbl tr th:not(:last-child) {
            min-width: 120px;
        }

        .normmodalform label {
            text-align: left;
            display: block;
        }

        /*BS5 Changes end*/
        .practicesettinglist #deleteProjectSLA h4, #deleteProjectSLANorm h4{background:#4263c1!important;padding:0}
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="main_ProjLevelSLA">
    <% If m_blnprojSLAViewAccess = True Then %>
    <div class="tab-pane pstbl_projLevelSLA practicesettinglist in active" id="pstbl_ProjLevelSLA" style="border-top: 1px solid #ddd;">
        <div class="modalpgHead  pt-1 pb-1 col-sm-12 mb-10">
            <span><%= MyBase.GetResourceString("C_ProjectlevelSLADefinition") %></span>
        </div>
        <h5 class="float-start pl-20 pt-2 clearfix">Project Name : <span id="spanProjectName"></span></h5>
        <div class="note-wrap note-wrap-txt pt-10">
            <p><strong><%= MyBase.GetResourceString("C_Note") %></strong> <%= MyBase.GetResourceString("C_DefinesProjectLevelSLA") %></p>
        </div>
        <div class="right-side-save">
            <div class="mb-10">
                <% If m_blnprojSLAAddAccess = True Then %>
                <a href="javascript:;" class="btn borderbtn mr-5" id="" onclick="ProjectSLAAddEditClick(0,0)"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %> </a>
                <%End If %>

                <a href="javascript:;" class="btn borderbtn mr-5" id="" onclick="GetCorporateSLAList()"><%= MyBase.GetResourceString("C_CorporateSLA") %> </a>
                <a href="javascript:;" class="btn borderbtn mr-5" id="" onclick="GetProjectWorkingHoursList()"><%= MyBase.GetResourceString("C_ProjectWorkingHours") %></a>
                <% If m_blnprojSLADeleteAccess = True Then %>
                <button id="delete-row" class="btn borderbtn" onclick="DeleteProjectSLAData()">Delete</button>
                <%End If %>
            </div>
        </div>
        <table class="table table-bordered" id="ProjLevelSLAtbl">
            <thead>
                <tr>
                    <th><%= MyBase.GetResourceString("C_IssueType") %></th>
                    <th><%= MyBase.GetResourceString("C_SeverityTracking") %></th>
                    <th><%= MyBase.GetResourceString("C_IsSLAApplicable") %></th>
                    <th><%= MyBase.GetResourceString("C_PriorityTracking") %></th>
                    <th><%= MyBase.GetResourceString("C_ComplexityTracking") %></th>
                    <th class="text-center multi-selectbox">
                        <div class="form-check">
                            <div class="custom_chckbox">
                                <input id="projslaAll" class="chcktbl" type="checkbox">
                                <label for="projslaAll"></label>
                            </div>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody id="ProjLevelSLAtblbody">
            </tbody>
        </table>

        <!--Add new project sla start here-->
        <div class="modal custmodal fade" id="addProjectSla" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ProjectlevelSLADefinition") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row mb-3">
                                <div class="form-group col-sm-6">
                                    <label class="control-label"><%= MyBase.GetResourceString("C_IssueType") %> <span style="color: red">*</span></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtProjSLAIssueType", "Select ''",,, "class='form-control form-select'",,,) %>
                                </div>
                            </div>
                            <div class="row center-cont mb-3">
                                <div class="col-sm-6">
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsSLAApplicable", "chkIsSLAApplicable") %>
                                        <label for="chkIsSLAApplicable"><%= MyBase.GetResourceString("C_IsSLAApplicable") %></label>
                                    </div>
                                </div>
                            </div>
                            <div class="row center-cont mb-3">
                                <div class="col-sm-6">
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkSeverityTracking", "chkSeverityTracking") %>
                                        <label for="chkSeverityTracking"><%= MyBase.GetResourceString("C_SeverityTracking") %></label>
                                    </div>

                                </div>
                                <div class="col-sm-6">
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkPriorityTracking", "chkPriorityTracking") %>
                                        <label for="chkPriorityTracking"><%= MyBase.GetResourceString("C_PriorityTracking") %></label>
                                    </div>

                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-6">
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkComplexityTracking", "chkComplexityTracking") %>
                                        <label for="chkComplexityTracking"><%= MyBase.GetResourceString("C_ComplexityTracking") %></label>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="">
                            <div class="row">
                                <div class="col-sm-12 btns-center btn-grp-new">
                                    <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                                    <button class="btn btnyellow float-end ml-1" onclick="AddNewProjectLevelSLA()" id="btnprojectSLASave"><%= MyBase.GetResourceString("C_Save") %></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add new project sla end here-->

        <!--Add new project sla in edit start here-->
        <div class="modal custmodal fade" id="editProjectSla" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ProjectlevelSLADefinition") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="">
                            <div class="form-group text-end">
                                <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                                <a href="javascript:;" class="btn btnyellow mr-5" onclick="CheckIsSLAApplicable()" id="btnprojectSLASaveInEdit"><%= MyBase.GetResourceString("C_Save") %></a>
                                <a href="javascript:;" class="btn borderbtn mr-5" onclick="GetProjectSLAHistoryList()" id="projectslaHistoryTab" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Show_History") %></a>
                            </div>
                            <div class="row mb-3">
                                <div class="form-group col-sm-6 text-start">
                                    <label class="control-label"><%= MyBase.GetResourceString("C_IssueType") %> <span style="color: red">*</span></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("txteditProjSLAIssueType", "Select ''",,, "class='form-control form-select'",,,) %>
                                </div>
                            </div>
                            <div class="row center-cont mb-3">
                                <div class="col-sm-6">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="custom_chckbox modal-inn-check">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkeditIsSLAApplicable", "chkeditIsSLAApplicable") %>
                                        <label for="chkeditIsSLAApplicable"><%= MyBase.GetResourceString("C_IsSLAApplicable") %></label>
                                    </div>
                                </div>

                            </div>
                            <div class="row center-cont mb-3">
                                <div class="col-sm-4">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="custom_chckbox modal-inn-check">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkeditSeverityTracking", "chkeditSeverityTracking") %>
                                        <label for="chkeditSeverityTracking"><%= MyBase.GetResourceString("C_SeverityTracking") %></label>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="custom_chckbox modal-inn-check">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkeditPriorityTracking", "chkeditPriorityTracking") %>
                                        <label for="chkeditPriorityTracking"><%= MyBase.GetResourceString("C_PriorityTracking") %></label>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="custom_chckbox modal-inn-check">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkeditComplexityTracking", "chkeditComplexityTracking") %>
                                        <label for="chkeditComplexityTracking"><%= MyBase.GetResourceString("C_ComplexityTracking") %></label>
                                    </div>
                                </div>
                            </div>
                            <br />

                            <div class="page-main-head text-start">
                                <h4><%= MyBase.GetResourceString("C_Norm") %></h4>
                            </div>
                            <div class="sub-head pad-10">
                                <div id="DivNoNormData" hidden="hidden" class="text-center">
                                    <%= MyBase.GetResourceString("C_NoData") %>
                                </div>
                                <div id="divSLANorm">
                                    <div class="right-side-save mb-10 mr-0">
                                        <a href="javascript:;" class="btn borderbtn mr-5" id="" data-bs-dismiss="modal" onclick="ADDEditSLANormClick(0,0)"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %> </a>
                                        <a href="javascript:;" class="btn borderbtn" id="" onclick="DeleteSLANormData()">Delete</a>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-stripped table-bordered" id="SLANormtbl">
                                            <thead>
                                                <tr>
                                                    <th><%= MyBase.GetResourceString("C_SLAName") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Severity") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Priority") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Complexity") %></th>
                                                    <th><%= MyBase.GetResourceString("C_FromStatus") %></th>
                                                    <th><%= MyBase.GetResourceString("C_ToStatus") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Norm") %></th>
                                                    <th><%= MyBase.GetResourceString("C_DaysHours") %></th>
                                                    <th><%= MyBase.GetResourceString("C_ConsiderWorkingHours") %></th>
                                                    <th><%= MyBase.GetResourceString("C_ExcludeHoldPeriod") %></th>
                                                    <th><%= MyBase.GetResourceString("C_AlertDetails") %></th>
                                                    <th class="inp-select text-start">
                                                        <div class="form-check">
                                                            <div class="custom_chckbox">
                                                                <input id="normTblSltAll" class="chcktbl" type="checkbox">
                                                                <label for="normTblSltAll"></label>
                                                            </div>
                                                        </div>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody id="normtblbody">
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>
                        </div>



                    </div>
                </div>
            </div>
        </div>
        <!--project sla in edit end here-->

        <!--Project Level SLA History modal start here-->
        <div class="modal custmodal fade" id="projectslaHistory" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ProjectSLAHistory") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="note-wrap note-wrap-txt pt-10">
                            <%-- Commented and added by Chetan M on 21th Dec 2019--%>
                            <%--<h5><span class="text-start"><%= MyBase.GetResourceString("C_AuditTrail") %></span><span class="fl-right"><%= MyBase.GetResourceString("C_ProjectlevelSLADefinition") %></span></h5>--%>
                            <h5><span class="text-start"><%= MyBase.GetResourceString("C_AuditTrail") %></span></h5>
                            <%-- End of addition by Chetan M on 21th Dec 2019 --%>
                        </div>
                        <table class="table table-stripped table-bordered" id="projectslaHistorytbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_Modified_Date") %></th>
                                    <th><%= MyBase.GetResourceString("C_Modified_Field") %></th>
                                    <th><%= MyBase.GetResourceString("C_Old_Value") %></th>
                                    <th><%= MyBase.GetResourceString("C_New_Value") %></th>
                                    <th><%= MyBase.GetResourceString("C_Modified_By") %></th>
                                </tr>
                            </thead>
                            <tbody id="projectslaHistorytblbody">
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <div class="text-center">
                            <a data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#editProjectSla" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Project Level SLA History modal end here-->

        <!--Corporate sla modal start here-->
        <%--Commented & added By Rutuja D. 18 March 2020 for Close Modal Popup  issue id = 23089--%>
        <%--<div class="modal custmodal fade" id="corporateSla" aria-hidden="true" data-keyboard="false" data-backdrop="static">--%>
        <div class="modal custmodal fade" id="corporateSla" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <%--End Commented & added By Rutuja D. 18 March 2020 for Close Modal Popup issue id = 23089--%>
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SelectCorpoarateIssueSLA") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="note-wrap note-wrap-txt pt-10">
                            <p><strong><%= MyBase.GetResourceString("C_Note") %></strong> <%= MyBase.GetResourceString("C_DisableCheckboxNote") %></p>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-stripped table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_Type") %></th>
                                        <th><%= MyBase.GetResourceString("C_CorporateType") %></th>
                                        <th><%= MyBase.GetResourceString("C_SLAName") %></th>
                                        <th><%= MyBase.GetResourceString("C_Severity") %></th>
                                        <th><%= MyBase.GetResourceString("C_Priority") %></th>
                                        <th><%= MyBase.GetResourceString("C_Complexity") %></th>
                                        <th><%= MyBase.GetResourceString("C_FromStatus") %></th>
                                        <th><%= MyBase.GetResourceString("C_ToStatus") %></th>
                                        <th><%= MyBase.GetResourceString("C_Norm") %></th>
                                        <th><%= MyBase.GetResourceString("C_Unit") %></th>
                                        <th><%= MyBase.GetResourceString("C_Select") %></th>

                                    </tr>
                                </thead>
                                <tbody id="corporateSlatblbody">
                                    <%-- <tr>
                                                <td colspan="11">No data availabel</td>
                                            </tr>--%>
                                </tbody>
                            </table>
                        </div>
                        <br />
                        <div class="btn-grp-new">
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" class="btn btnyellow" onclick="SelectCorporateSLA()"><%= MyBase.GetResourceString("C_SelectCorporateSLA") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Corporate sla modal end here-->

        <!--Project working hours modal start here-->
        <div class="modal custmodal fade" id="projHours" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ProjectWorkingHours") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <table class="table table-stripped table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_Weekday") %></th>
                                        <th><%= MyBase.GetResourceString("C_IsWorking") %></th>
                                        <th><%= MyBase.GetResourceString("C_FromTime") %></th>
                                        <th><%= MyBase.GetResourceString("C_ToTime") %></th>

                                    </tr>
                                </thead>
                                <tbody id="projHourstblbody">
                                </tbody>
                            </table>
                        </div>
                        <center>
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></a>
                        </center>
                    </div>
                </div>
            </div>
        </div>
        <!--Project working hours modal end here-->

        <!--wORKING HOURS_modal_Start_here-->
        <div class="modal custmodal fade" id="prosetWrkingHrsDetail" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ProjectWorkingHours") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="control"><%= MyBase.GetResourceString("C_Weekday") %> <span style="color: red">*</span></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtWeekday", "usp_Whizible2_Sel_WeekDays",,, "class='form-control form-select'",,,) %>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="control">&nbsp;</label>
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsWorking", "chkIsWorking") %>
                                        <label for="chkIsWorking"><%= MyBase.GetResourceString("C_IsWorking") %></label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="control"><%= MyBase.GetResourceString("C_FromTime") %> <span style="color: red">*</span></label>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtFromTime", "txtFromTime", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, True) %>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="control"><%= MyBase.GetResourceString("C_ToTime") %> <span style="color: red">*</span></label>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtToTime", "txtToTime", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, True) %>
                                </div>
                            </div>
                        </div>

                        <br />
                        <div class="btn-grp-new">
                            <button data-bs-dismiss="modal" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#projHours"><%= MyBase.GetResourceString("C_Cancel") %></button>
                            <button class="btn btnyellow ml-1" onclick="SaveProjectWorkingHours()" id="btnSaveWorkHours"><%= MyBase.GetResourceString("C_Save") %></button>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--wORKING HOURS_end_here-->




        <!--Add Norm modal start here-->
        <div class="modal custmodal fade" id="addNorm" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Norm") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body normmodalform">
                        <div class="row">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_SLAName") %> <span style="color: red">*</span></label>

                                <% CommonFunctions.HTMLControls.DrawTextBox("txtNmSLAName", "txtNmSLAName", "form-control",,,,,,,,,, "PlaceHolder = 'Enter SLA Name (Maxlength 50 Char)' autocomplete='Off' maxlength='50'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-6" id="divtxtNmSeverity">
                                <label><%= MyBase.GetResourceString("C_Severity") %> <span style="color: red">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("txtNmSeverity", "Select ''",,, "class='form-control form-select'",,,) %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6" id="divtxtNmPriority">
                                <label><%= MyBase.GetResourceString("C_Priority") %> <span style="color: red">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("txtNmPriority", "Select ''",,, "class='form-control form-select'",,,) %>
                            </div>

                            <div class="col-sm-6" id="divtxtNmComplexity">
                                <label><%= MyBase.GetResourceString("C_Complexity") %> <span style="color: red">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("txtNmComplexity", "Select ''",,, "class='form-control form-select'",,,) %>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_FromStatus") %> <span style="color: red">*</span></label>

                                <% CommonFunctions.HTMLControls.DrawComboBox("txtNmFromStatus", "Select''",,, "class='form-control form-select'",,,) %>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_ToStatus") %> <span style="color: red">*</span></label>

                                <% CommonFunctions.HTMLControls.DrawComboBox("txtNmToStatus", "Select ''",,, "class='form-control form-select'",,,) %>
                            </div>
                        </div>
                        <div class="row">  
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_Norm") %> <span style="color: red">*</span></label>
                                <%--Commented & Added By Rutuja D. For Set Maxlength--%>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtNmNorm", "txtNmNorm", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='Off'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtNmNorm", "txtNmNorm", "form-control",, 5,,,,,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='Off' maxlength='6'",,, True,,,, True) %>
                                <%--End Commented & Added By Rutuja D. For Set Maxlength--%>
                            </div>  
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_DaysHours") %> <span style="color: red">*</span></label>

                                <% CommonFunctions.HTMLControls.DrawComboBox("txtNmDaysHours", "usp_Whizible2_Sel_DaysHours",,, "class='form-control form-select'",,,) %>
                            </div>

                        </div>
                        <div class="row">
                            
                            <div class="col-sm-6 p-0">
                                <div class="col-sm-12 mb-3">
                                <div class="custom_chckbox">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkConsiderWorkHrs", "chkConsiderWorkHrs") %>
                                    <label for="chkConsiderWorkHrs"><%= MyBase.GetResourceString("C_ConsiderWorkingHours") %></label>
                                </div>
                            </div>
                            </div>
                            <div class="col-sm-6 p-0">                                
                            <div class="col-sm-12">
                                <div class="custom_chckbox">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkExcludeHoldPeriod", "chkExcludeHoldPeriod") %>
                                    <label for="chkExcludeHoldPeriod"><%= MyBase.GetResourceString("C_ExcludeHoldPeriod") %></label>
                                </div>
                            </div>
                            </div>


                            </div>
                        <div class="row">                            
                        </div>

                        <div class="btn-grp-new">
                            <a href="javascript:;" data-bs-toggle="modal" data-bs-dismiss="modal" data-bs-target="#editProjectSla" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" class="btn btnyellow mr-5" onclick="AddProjectSLANorm()" id="btnSaveNorm"><%= MyBase.GetResourceString("C_Save") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" onclick="GetNormHistoryData()" id="normHistoryTab"><%= MyBase.GetResourceString("C_Show_History") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add Norm modal end here-->


        <!--Alerts Details modal start here-->
        <div class="modal custmodal fade" id="alertDetailsModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SLAAlertMailConfiguration") %> </h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group mb-3">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_AlertBefore") %> <span style="color: red">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtAlertBefore", "txtAlertBefore", "form-control",, 5,,,,,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='Off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_AlertBeforeUnit") %> <span style="color: red">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("txtAlertBeforeUnit", "usp_Whizible2_Sel_DaysHours",,, "class='form-control form-select'",,,) %>
                            </div>
                        </div>
                        <div class="btn-grp-new">
                            <a data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#editProjectSla" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a class="btn btnyellow" onclick="SaveAlertDetails()" id="btnsaveAlertDetails"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Alerts Details modal end here-->

        <!--Norm History modal start here-->
        <div class="modal custmodal fade" id="normHistory" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_NormHistory") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="note-wrap note-wrap-txt pt-10">
                            <%-- Commented and added by Chetan M on 21th Dec 2019--%>
                            <%--<h5><span class="text-start"><%= MyBase.GetResourceString("C_AuditTrail") %></span><span class="fl-right"><%= MyBase.GetResourceString("C_ProjectlevelSLADefinition") %></span></h5>--%>
                            <h5><span class="text-start"><%= MyBase.GetResourceString("C_AuditTrail") %></span></h5>
                            <%-- End of addition by Chetan M on 21th Dec 2019 --%>
                        </div>
                        <table class="table table-stripped table-bordered" id="normHistorytbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_Modified_Date") %></th>
                                    <th><%= MyBase.GetResourceString("C_Modified_Field") %></th>
                                    <th><%= MyBase.GetResourceString("C_Old_Value") %></th>
                                    <th><%= MyBase.GetResourceString("C_New_Value") %></th>
                                    <th><%= MyBase.GetResourceString("C_Modified_By") %></th>
                                </tr>
                            </thead>
                            <tbody id="normHistorytblbody">
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <div class="text-center">
                            <a data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#addNorm" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Norm History modal end here-->


        <!-- DELETE Confirm Modal for Project SLA Start here-->
        <div id="deleteProjectSLA" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_ConfirmDelete") %></h5>
                    </div>

                    <div class="modal-body">
                        <p align="center"><%= MyBase.GetResourceString("C_ConfirmDeleteNote") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectLevelSLA()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE Confirm Modal for Project SLA End here-->

        <!-- DELETE Confirm Modal for Project SLA Norm Start here-->
        <div id="deleteProjectSLANorm" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_ConfirmDelete") %></h5>
                    </div>

                    <div class="modal-body">
                        <p align="center"><%= MyBase.GetResourceString("C_ConfirmDeleteNote") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#editProjectSla">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectSLANorm()" id="btndeleteSlaNorm">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE Confirm Modal for Project SLA End here-->

        <!--      <!--Corporate SLA Confirm Modal for Project SLA Start here-->
        <div id="confirmcorpSLA" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_Confirm") %></h5>
                    </div>

                    <div class="modal-body">
                        <p align="center"><%= MyBase.GetResourceString("C_CorporateSLANote") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="AddCorporateSLA()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- Corporate SLA Confirm Modal for Project SLA End here-->

        <!-- Edit SLA Confirm Modal for Project SLA Start here-->
        <div id="confirmeditSLA" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_Confirm") %></h5>
                    </div>

                    <div class="modal-body">
                        <p align="center"><%= MyBase.GetResourceString("C_EditSLAConfirmNote") %></p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal" data-bs-target="#editProjectSla" data-bs-toggle="modal"><%= MyBase.GetResourceString("C_Cancel") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="AddNewProjectLevelSLAInEdit()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Ok") %></button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- Edit SLA Confirm Modal for Project SLA End here-->

        <!-- Edit SLA Confirm Modal Is SLA Applicable Start here-->
        <div id="confirmIsSLAApplicable" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_Confirm") %></h5>
                    </div>

                    <div class="modal-body">
                        <p align="center"><%= MyBase.GetResourceString("C_NonSLANote") %></p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal" data-bs-target="#editProjectSla" data-bs-toggle="modal"><%= MyBase.GetResourceString("C_Cancel") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="AddNewProjectLevelSLA()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Ok") %></button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- Edit SLA Confirm Modal for Is SLA Applicable End here-->
    </div>
    <% Else %>
    <div id="NotAuthorized">
        <h4><%= MyBase.GetResourceString("C_NotAuthorized") %></h4>
    </div>
    <% End If %>
    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i><%= MyBase.GetResourceString("C_NoProject") %></h4>
    </div>

    <%CommonFunctions.HTMLControls.DrawTextBox("hiddentxtNmNorm", "hiddentxtNmNorm",, IsHidden:=True, EnableHTMLEncode:=True) %>





    <!-- REQUIRED JS SCRIPTS -->

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>


    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>

    <!-- alertify -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>


    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        //var ProjectID = '<%= ProjectID %>';      
        var ajaxResult = "";
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var blnprojSLAAddAccess = "<%=m_blnprojSLAAddAccess%>";
        var blnprojSLAEditAccess = "<%=m_blnprojSLAEditAccess%>";
        var blnprojSLADeleteAccess = "<%= m_blnprojSLADeleteAccess%>";
        var blnprojSLAViewAccess = "<%= m_blnprojSLAViewAccess%>";
        var ProjectSLAIDs;
        var ProjectSLADetailIDs;
        var CorporateSLAIDs;
        var NewProjectSLAID = 0;
        var NewProjectSLADetailID = 0;
        var NewIssueType;
        var NormMode;
        var Mode;
        var EditIsSLAApplicable = "";
        var EditSeverityTracking = "";
        var EditPriorityTracking = "";
        var EditComplexityTracking = "";
        var NewUniqueID = 0;
        var ProjectID;

        $(document).ready(function () {

            $(".closeAcco").click(function () {
                $(this).closest(".accordian-body").removeClass("in");
            });

            params = getParams();
            ProjectID = unescape(params["ProjectID"]);

            GetProjectName(ProjectID);

            if (ProjectID != 0) {
                GetProjectLevelSLAList();
            }
            else {
                StartLoader("#main_ProjLevelSLA");
                $("#NoProjectDivID").show();
                $("#pstbl_ProjLevelSLA").hide();
                StopAjaxLoader("#main_ProjLevelSLA");
            }

        });

        //Get Project Level SLA List
        function GetProjectLevelSLAList() {
            StartLoader("#main_ProjLevelSLA");

            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID)

            }

            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectLevelSLAList", paramater, false);

            $("#ProjLevelSLAtblbody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                for (var i = 0; i < strResult.length; i++) {

                    var ProjectSLAID = strResult[i]["ProjectSLAID"];
                    var IssueType = strResult[i]["TYPE"];
                    var SeverityTracking = strResult[i]["SeverityTracking"];
                    var IsSLAApplicable = strResult[i]["IsSLAApplicable"];
                    var PriorityTracking = strResult[i]["PriorityTracking"];
                    var ComplexityTracking = strResult[i]["ComplexityTracking"];

                    if (IsSLAApplicable == true) {
                        IsSLAApplicable = "Yes";
                    }
                    else {
                        IsSLAApplicable = "No";
                    }
                    if (SeverityTracking == true) {
                        SeverityTracking = "Yes";
                    }
                    else {
                        SeverityTracking = "No";
                    }
                    if (PriorityTracking == true) {
                        PriorityTracking = "Yes";
                    }
                    else {
                        PriorityTracking = "No";
                    }
                    if (ComplexityTracking == true) {
                        ComplexityTracking = "Yes";
                    }
                    else {
                        ComplexityTracking = "No";
                    }

                    strHTML += '<tr>'
                    <% If m_blnprojSLAEditAccess = True Then %>
                    strHTML += '<td><a href="javascript:;" onclick="ProjectSLAAddEditClick(' + ProjectSLAID + ',1)">' + IssueType + '</a></td>'
                    <%Else%>
                    strHTML += '<td>' + IssueType + '</td>'
                    <%End If%>                
                    strHTML += '<td>' + SeverityTracking + '</td>'
                    strHTML += '<td>' + IsSLAApplicable + '</td>'
                    strHTML += '<td>' + PriorityTracking + '</td>'
                    strHTML += '<td>' + ComplexityTracking + '</td>'
                    strHTML += ' <td class="text-center multi-selectbox">'
                    strHTML += ' <div class="form-check">'
                    strHTML += ' <div class="custom_chckbox">'
                    strHTML += ' <input type="checkbox" id="' + ProjectSLAID + '" class="chcktbl acco-chck" name="chkProjectSLA">'
                    strHTML += ' <label for="' + ProjectSLAID + '"></label>'
                    strHTML += ' </div>'
                    strHTML += ' </div>'
                    strHTML += '</td>'
                    strHTML += '</tr>'
                }
            }
            else {
                strHTML += '<tr>'
                strHTML += '<td colspan="7" class="text-center"><%= MyBase.GetResourceString("C_NoData") %></td>'
                strHTML += '</tr>'
            }

            $("#ProjLevelSLAtblbody").html("");
            $("#ProjLevelSLAtblbody").html(strHTML);

            StopAjaxLoader("#main_ProjLevelSLA");

        }

        //Project SLA ADD,EDIT and Delete Section Start Here

        //open modal popup and bind data
        function ProjectSLAAddEditClick(ProjectSLAID, Flag) {

            if (ProjectID != 0) {
                if (Flag == 0) {
                    if (ProjectSLAID == 0) {
                        $("#addProjectSla").modal('show');
                        NewProjectSLAID = 0;
                        $("#txtProjSLAIssueType :selected").val('');
                        $("#chkIsSLAApplicable").prop('checked', false);
                        $("#chkSeverityTracking").prop('checked', false);
                        $("#chkPriorityTracking").prop('checked', false);
                        $("#chkComplexityTracking").prop('checked', false);
                        GetProjSLAIssueType(1);
                        Mode = "Add";
                    }
                }
                else if (Flag == 1) {

                    $("#editProjectSla").modal('show');
                    $(".modal").css('overflow', 'auto');
                    NewProjectSLAID = ProjectSLAID;
                    GetProjectSLADetailsInEdit(NewProjectSLAID);
                    var IsHistory = IsSLAHistoryData(NewProjectSLAID);
                    if (IsHistory == true) {
                        $("#projectslaHistoryTab").css('display', 'inline-block');
                    }
                    else {
                        $("#projectslaHistoryTab").css('display', 'none');
                    }
                    var IsSLAApplicable = EditIsSLAApplicable;
                    var SeverityTracking = EditSeverityTracking;
                    var PriorityTracking = EditPriorityTracking;
                    var ComplexityTracking = EditComplexityTracking;
                    if (IsSLAApplicable == false && SeverityTracking == false && PriorityTracking == false && ComplexityTracking == false) {
                        $("#divSLANorm").hide();
                        $("#DivNoNormData").show();
                    }
                    else if (IsSLAApplicable == false && (SeverityTracking == true || PriorityTracking == true || ComplexityTracking == true)) {
                        $("#divSLANorm").hide();
                        $("#DivNoNormData").show();
                    }
                    else {
                        $("#divSLANorm").show();
                        $("#DivNoNormData").hide();
                        GetSLANormDetailsList(NewProjectSLAID);

                    }
                    Mode = "Edit";
                }

            }
        }

        function IsSLANormContainsData(NewProjectSLAID) {
            var Flag = false;
            var ConfigParameters = {
                ProjectSLAID: encodeURI(NewProjectSLAID),
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetSLANormDetailsList", paramater, false);
            if (strResult.length > 0) {
                Flag = true;
            }
            else {
                Flag = false;
            }
            return Flag;
        }

        function CheckIsSLAApplicable() {
            //Commented by Chetan M on 4th Jan 2020
            //$("#btnprojectSLASave").removeAttr("data-bs-dismiss", "modal");
            //End of comment by Chetan M on 4th Jan 2020
            var chckresult = ValidateProjectSLA();
            if (chckresult == true) {
                if ((($('#chkeditSeverityTracking').is(":checked") == true) || ($('#chkeditPriorityTracking').is(":checked") == true) || ($('#chkeditComplexityTracking').is(":checked") == true))) {
                    var IsSLAApplicable = $('#chkeditIsSLAApplicable').is(":checked");
                    if (IsSLAApplicable == false) {
                        var IsData = IsSLANormContainsData(NewProjectSLAID);
                        if (IsData == true) {
                            $("#btnprojectSLASaveInEdit").attr("data-bs-dismiss", "modal");
                            $("#confirmIsSLAApplicable").modal('show');
                        }
                        else {
                            AddNewProjectLevelSLAInEdit();
                        }
                    }
                    else {
                        var IsData = IsSLANormContainsData(NewProjectSLAID);
                        if (IsData == true) {
                            $("#btnprojectSLASaveInEdit").attr("data-bs-dismiss", "modal");
                            $("#confirmeditSLA").modal('show');
                        }
                        else {
                            AddNewProjectLevelSLAInEdit();
                        }
                    }
                }
                else {
                    AddNewProjectLevelSLAInEdit();
                }
            }
        }
        //validate Project SLA
        function ValidateProjectSLA() {
            var obJIssueType = $("#txtProjSLAIssueType :selected").val();
            if (isBlank(obJIssueType)) {
                alertify.error("'Issue Type' should not be left blank.");
                $('#txtProjSLAIssueType').focus();
                return false;
            }
            else if ($('#chkIsSLAApplicable').is(":checked")) {

                var SeverityTracking = $('#chkSeverityTracking').is(":checked");
                var PriorityTracking = $('#chkPriorityTracking').is(":checked");
                var ComplexityTracking = $('#chkComplexityTracking').is(":checked");
                if (SeverityTracking == false && PriorityTracking == false && ComplexityTracking == false) {
                    alertify.error('Please select atleast one tracking parameter if SLA is applicable for issue type');
                    return false;
                }
            }
            else if ($('#chkeditIsSLAApplicable').is(":checked")) {

                var SeverityTracking = $('#chkeditSeverityTracking').is(":checked");
                var PriorityTracking = $('#chkeditPriorityTracking').is(":checked");
                var ComplexityTracking = $('#chkeditComplexityTracking').is(":checked");
                if (SeverityTracking == false && PriorityTracking == false && ComplexityTracking == false) {
                    alertify.error('Please select atleast one tracking parameter if SLA is applicable for issue type');
                    return false;
                }
            }
            return true;
        }

        //function for adding new Project Level SLA
        function AddNewProjectLevelSLA() {
            $("#btnprojectSLASave").removeAttr("data-bs-dismiss", "modal");
            var chckresult = ValidateProjectSLA();
            if (chckresult == true) {
                var InsProjectSLA = new Object();
                InsProjectSLA.ProjectID = ProjectID;

                var IssueType = $("#txtProjSLAIssueType :selected").val();
                InsProjectSLA.IssueType = IssueType;

                if ($('#chkIsSLAApplicable').is(":checked")) {
                    var IsSLAApplicable = 1;
                }
                else {
                    var IsSLAApplicable = 0;
                }
                InsProjectSLA.IsSLAApplicable = IsSLAApplicable;

                if ($('#chkSeverityTracking').is(":checked")) {
                    var SeverityTracking = 1;
                }
                else {
                    var SeverityTracking = 0;
                }
                InsProjectSLA.SeverityTracking = SeverityTracking;

                if ($('#chkPriorityTracking').is(":checked")) {
                    var PriorityTracking = 1;
                }
                else {
                    var PriorityTracking = 0;
                }
                InsProjectSLA.PriorityTracking = PriorityTracking;

                if ($('#chkComplexityTracking').is(":checked")) {
                    var ComplexityTracking = 1;
                }
                else {
                    var ComplexityTracking = 0;
                }
                InsProjectSLA.ComplexityTracking = ComplexityTracking;

                InsProjectSLA.ProjectSLAID = NewProjectSLAID;
                if (InsProjectSLA.ProjectSLAID == undefined || InsProjectSLA.ProjectSLAID == 0) { InsProjectSLA.ProjectSLAID = "Null"; }
                else { InsProjectSLA.ProjectSLAID = InsProjectSLA.ProjectSLAID; }

                InsProjectSLA.UserName = UserName;

                objInsProjectSLA = [InsProjectSLA.ProjectID, InsProjectSLA.IssueType, InsProjectSLA.IsSLAApplicable, InsProjectSLA.SeverityTracking, InsProjectSLA.PriorityTracking, InsProjectSLA.ComplexityTracking, InsProjectSLA.UserName, InsProjectSLA.ProjectSLAID];
                //Added By Dipali V On 11st April 2023 For Validate Header Issue
                var objInsProjectSLA_New = objInsProjectSLA.toString();
               //End of Added By Dipali V On 11st April 2023 For Validate Header Issue
                InsertProjectSLAControllerCall(objInsProjectSLA_New);
            }
        }

        //function for adding new Project Level SLA
        function AddNewProjectLevelSLAInEdit() {

            var InsProjectSLA = new Object();
            InsProjectSLA.ProjectID = ProjectID;

            InsProjectSLA.IssueType = NewIssueType;

            if ($('#chkeditIsSLAApplicable').is(":checked")) {
                var IsSLAApplicable = true;
            }
            else {
                var IsSLAApplicable = false;
            }
            InsProjectSLA.IsSLAApplicable = IsSLAApplicable;

            if ($('#chkeditSeverityTracking').is(":checked")) {
                var SeverityTracking = true;
            }
            else {
                var SeverityTracking = false;
            }
            InsProjectSLA.SeverityTracking = SeverityTracking;

            if ($('#chkeditPriorityTracking').is(":checked")) {
                var PriorityTracking = true;
            }
            else {
                var PriorityTracking = false;
            }
            InsProjectSLA.PriorityTracking = PriorityTracking;

            if ($('#chkeditComplexityTracking').is(":checked")) {
                var ComplexityTracking = true;
            }
            else {
                var ComplexityTracking = false;
            }
            InsProjectSLA.ComplexityTracking = ComplexityTracking;

            InsProjectSLA.ProjectSLAID = NewProjectSLAID;

            InsProjectSLA.UserName = UserName;


            if (InsProjectSLA.ProjectSLAID == undefined || InsProjectSLA.ProjectSLAID == 0) { InsProjectSLA.ProjectSLAID = "Null"; }
            else { InsProjectSLA.ProjectSLAID = InsProjectSLA.ProjectSLAID; }


            objInsProjectSLA = [InsProjectSLA.ProjectID, InsProjectSLA.IssueType, InsProjectSLA.IsSLAApplicable, InsProjectSLA.SeverityTracking, InsProjectSLA.PriorityTracking, InsProjectSLA.ComplexityTracking, InsProjectSLA.UserName, InsProjectSLA.ProjectSLAID];
            //Added By Dipali V On 11st April 2023 For Validate Header Issue
            var objInsProjectSLA_New = objInsProjectSLA.toString();
               //End of Added By Dipali V On 11st April 2023 For Validate Header Issue
            InsertProjectSLAControllerCall(objInsProjectSLA_New);


        }
        function getURLParameter(url, name) {
            return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
        }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjectLevelSLA%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjectLevelSLA%>');
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
        //Function for Calling InsertProjectSLAControllerCall 
        function InsertProjectSLAControllerCall(objInsProjectSLA) {
            StartLoader("#main_ProjLevelSLA");
            var param = JSON.stringify(objInsProjectSLA);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/InsertNewProjectLevelSLA", param, false);
            strResult = strResult.split("||");
            var ProjectSLAID = strResult[1];
            if (strResult[0] != "") {
                alertify.success(strResult[0]);
            }

            if (Mode == "Add") {
                //Commented and added by Chetan M on 23rd Dec 2019
                //$("#btnprojectSLASave").attr("data-bs-dismiss", "modal");
                $("#addProjectSla").modal('hide');
                $("#editProjectSla").modal('hide');
                //End of addition by Chetan M on 23rd Dec 2019
                GetProjectLevelSLAList();
                //Added by Chetan M on 4th Jan 2020
                ProjectSLAAddEditClick(ProjectSLAID, 1);
                //End of added by Chetan M on 4th Jan 2020
            }
            if (Mode == "Edit") {
                //Commented and added by Chetan M on 4th Jan 2020
                //$("#btnprojectSLASave").attr('data-bs-toggle', 'modal');
                $("#btnprojectSLASave").attr('data-bs-target', 'modal');
                // End of added by Chetan M on 4th Jan 2020
                //Commented by Chetan M on 23rd Dec 2019
                //$("#btnprojectSLASave").attr('data-bs-target', '#editProjectSla');
                //End of comment by Chetan M 
                ProjectSLAAddEditClick(ProjectSLAID, 1);

            }
            //Added By Rutuja D. 19 Dec 2019 For Reload Parent Page
            //window.opener.location.reload();
            refreshMyParent();
            //End Added By Rutuja D. 19 Dec 2019 For Reload Parent Page
            StopAjaxLoader("#main_ProjLevelSLA");
        }


        //Function for edit Project level SLA
        function GetProjectSLADetailsInEdit(NewProjectSLAID) {
            clearProjectSLADetails();
            GetProjSLAIssueType(2);
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
                ProjectSLAID: encodeURI(NewProjectSLAID)
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectLevelSLAList", paramater, false);
            for (var i = 0; i < strResult.length; i++) {
                var IssueType = strResult[i]["TYPE"];
                EditSeverityTracking = strResult[i]["SeverityTracking"];
                EditIsSLAApplicable = strResult[i]["IsSLAApplicable"];
                EditPriorityTracking = strResult[i]["PriorityTracking"];
                EditComplexityTracking = strResult[i]["ComplexityTracking"];
                NewIssueType = IssueType;
                $('#txteditProjSLAIssueType').val(IssueType).attr("selected", "selected");
                $('#txteditProjSLAIssueType').prop('disabled', true);

                if (EditSeverityTracking == true) {
                    $("#chkeditSeverityTracking").prop('checked', true);
                }
                else {
                    $("#chkeditSeverityTracking").prop('checked', false);
                }
                if (EditIsSLAApplicable == true) {
                    $("#chkeditIsSLAApplicable").prop('checked', true);
                }
                else {
                    $("#chkeditIsSLAApplicable").prop('checked', false);
                }
                if (EditPriorityTracking == true) {
                    $("#chkeditPriorityTracking").prop('checked', true);
                }
                else {
                    $("#chkeditPriorityTracking").prop('checked', false);
                }
                if (EditComplexityTracking == true) {
                    $("#chkeditComplexityTracking").prop('checked', true);
                }
                else {
                    $("#chkeditComplexityTracking").prop('checked', false);
                }
            }

        }

        //clear SLA Data in Edit Mode
        function clearProjectSLADetails() {
            $("#txteditProjSLAIssueType :selected").val('');
            $("#chkIsSLAApplicable").prop('checked', false);
            $("#chkeditSeverityTracking").prop('checked', false);
            $("#chkeditPriorityTracking").prop('checked', false);
            $("#chkeditComplexityTracking").prop('checked', false);
            EditSeverityTracking = "";
            EditIsSLAApplicable = "";
            EditPriorityTracking = "";
            EditComplexityTracking = "";
        }

        //function for bind IssueType on Add Click
        function GetProjSLAIssueType(Flag) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
                Flag: encodeURI(Flag)
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjSLAIssueType", paramater, false);
            if (strResult != "") {
                var objCbo1 = document.getElementById("txtProjSLAIssueType");
                var objCbo2 = document.getElementById("txteditProjSLAIssueType");
                $("#txtProjSLAIssueType option").remove();
                $("#txteditProjSLAIssueType option").remove();
                for (var i = 0; i < strResult.length; i++) {
                    var Objresult = strResult[i];
                    var Objresult1 = strResult[i];
                    var objOption = document.createElement("OPTION");
                    var objOption1 = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objCbo2.options.add(objOption1);
                    objOption.value = Objresult.IssueTypeID;
                    objOption.text = Objresult.IssueType;
                    objOption1.value = Objresult1.IssueTypeID;
                    objOption1.text = Objresult1.IssueType;

                }
            }
        }


        //function for Delete Project Level SLA
        function DeleteProjectSLAData() {
            ProjectSLAIDs = $('input[name=chkProjectSLA]:checked').map(function () {
                return this.id;
            }).get().join(',');
            if (ProjectSLAIDs.length != 0) {
                $("#deleteProjectSLA").modal('show');
            }
            else {
                alertify.error('Please Select Atleast One Record To Delete.');
                $("#deleteProjectSLA").modal('hide');
                return false;
            }
        }

        function DeleteProjectLevelSLA() {
            var arrProjectSLAIDList = [];
            var strProjectSLAID;
            ProjectSLAIDs = $('input[name=chkProjectSLA]:checked').map(function () {
                return this.id;
            }).get().join(',');

            if (ProjectSLAIDs != "") {
                if (ProjectSLAIDs.indexOf(",") > -1) {
                    arrProjectSLAIDList = ProjectSLAIDs.split(",");
                    for (i = 0; i < arrProjectSLAIDList.length; i++) {
                        strProjectSLAID = arrProjectSLAIDList[i];
                        var ConfigParameters = {
                            ProjectSLAID: encodeURI(strProjectSLAID),

                        }
                        var paramater = JSON.stringify(ConfigParameters);
                        var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/DeleteProjectSLAs", paramater, false);

                    }
                    if (strResult != undefined) {
                        alertify.success(strResult);
                    }
                    GetProjectLevelSLAList();
                    $("#projslaAll").prop('checked', false);
                }
                else {
                    var ConfigParameters = {
                        ProjectSLAID: encodeURI(ProjectSLAIDs),
                    }
                    var paramater = JSON.stringify(ConfigParameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/DeleteProjectSLAs", paramater, false);
                    if (strResult != undefined) {
                        alertify.success(strResult);
                    }
                    GetProjectLevelSLAList();
                    $("#projslaAll").prop('checked', false);
                }
                // Added By Rutuja D. 19 Dec 2019 for reload parent page
                //window.opener.location.reload();

                refreshMyParent();
                // Added By Rutuja D. 19 Dec 2019 for reload parent page
            }

        }

        //History for Project level SLA

        function IsSLAHistoryData() {
            var TagID = 3574;
            var Flag = false;
            var ConfigParameters = {
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                ProjectSLAID: encodeURI(NewProjectSLAID),
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetprojectSLAHistoryDetails", paramater, false);
            if (strResult.length > 0) {
                Flag = true;
            }
            else {
                Flag = false;
            }
            return Flag;
        }


        function GetProjectSLAHistoryList() {
            $("#projectslaHistory").modal('show');
            var TagID = 3574;
            var ConfigParameters = {
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                ProjectSLAID: encodeURI(NewProjectSLAID),
            }
            //$("#normHistorytbl").dataTable().fnDestroy();
            //by vishal Mahajan 23-12-2019
            $("#projectslaHistorytbl").dataTable().fnDestroy();
            //by vishal Mahajan 23-12-2019
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetprojectSLAHistoryDetails", paramater, false);
            $("#projectslaHistorytblbody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                StartLoader("#main_ProjLevelSLA");
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
                $("#projectslaHistorytblbody").html('');
                $("#projectslaHistorytblbody").append(strHTML);
                StopAjaxLoader("#main_ProjLevelSLA")
                PaginationHistory("#projectslaHistorytbl");
            }
        }


        //Corporate SLA Section Start Here

        //Get Corporate SLA List
        function GetCorporateSLAList() {

            $("#corporateSla").modal('show');
            StartLoader("#main_ProjLevelSLA");
            var SLAID = [];
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectCorporateSLAList", paramater, false);
            $("#corporateSlatblbody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                for (var i = 0; i < strResult.length; i++) {

                    var SLA_DetailS_ID = strResult[i]["SLA_DetailS_ID"]
                    var Type = strResult[i]["Type"]
                    var CorporateType = strResult[i]["CorporateType"]
                    var SLAName = strResult[i]["SLADetail"];
                    var Severity = strResult[i]["Severity"];
                    var Priority = strResult[i]["Priority"];
                    var Complexity = strResult[i]["Complexity"];
                    var FromStatus = strResult[i]["StatusFrom"];
                    var ToStatus = strResult[i]["StatusTo"];
                    var Norm = strResult[i]["Norm"];
                    var Unit = strResult[i]["Unit"];
                    SLAID = SLA_DetailS_ID.split("~");
                    SLAID = SLAID[2];
                    if (Severity == null) {
                        Severity = "";
                    }
                    if (Priority == null) {
                        Priority = "";
                    }
                    if (Complexity == null) {
                        Complexity = "";
                    }
                    strHTML += '<tr>'
                    strHTML += '<td>' + Type + '</td>'
                    strHTML += '<td>' + CorporateType + '</td>'
                    strHTML += '<td>' + SLAName + '</td>'
                    strHTML += '<td>' + Severity + '</td>'
                    strHTML += '<td>' + Priority + '</td>'
                    strHTML += '<td>' + Complexity + '</td>'
                    strHTML += '<td>' + FromStatus + '</td>'
                    strHTML += '<td>' + ToStatus + '</td>'
                    strHTML += '<td>' + Norm + '</td>'
                    strHTML += '<td>' + Unit + '</td>'
                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="form-check">'
                    strHTML += '<div class="custom_chckbox">'
                    strHTML += '<input id="corp' + SLAID + '" class="chcktbl" type="checkbox" name="chkcorpProjectSLA" CorporateSLAID="' + SLA_DetailS_ID + '">'
                    strHTML += '<label for="corp' + SLAID + '"></label>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '</td>'
                    strHTML += ' </tr>'

                }
            }
            else {
                strHTML += '<tr>'
                strHTML += '<td colspan="11" class="text-center"><%= MyBase.GetResourceString("C_NoData") %></td>'
                strHTML += '</tr>'
            }
            $("#corporateSlatblbody").html("");
            $("#corporateSlatblbody").html(strHTML);
            StopAjaxLoader("#main_ProjLevelSLA");
            ValidateCorporateSLA();
        }

        //function for add Corporate SLA on Project SLA List

        //click on select cporporate SLA
        function SelectCorporateSLA() {

            CorporateSLAIDs = $('input[name=chkcorpProjectSLA]:checked').map(function () {
                return this.id;
            }).get().join(',');
            if (CorporateSLAIDs.length != 0) {
                $("#corporateSla").modal('hide');
                $("#confirmcorpSLA").modal('show');
            }
            else {
                alertify.error("Please Select SLA.");
                $("#confirmcorpSLA").modal('hide');
            }
        }
        var arrCorporateSLAIDList = [];
        var arrCorporateSLAIDList1 = [];
        var arrCorporateSLAIDs = [];
        var strCustomerID;
        var strCorporateSLAID;
        var strCorporateType;
        var strCorporateSLADetailID;

        function AddCorporateSLA() {
            CorporateSLAIDs = $('input[name=chkcorpProjectSLA]:checked').map(function () {
                return this.id;
            }).get().join(',');
            if (CorporateSLAIDs != "") {
                if (CorporateSLAIDs.indexOf(",") > -1) {
                    arrCorporateSLAIDs = CorporateSLAIDs.split(",");
                    for (i = 0; i < arrCorporateSLAIDs.length; i++) {
                        arrCorporateSLAIDList = $("#" + arrCorporateSLAIDs[i]).attr('CorporateSLAID');
                        arrCorporateSLAIDList1 = arrCorporateSLAIDList.split("~");

                        strCustomerID = arrCorporateSLAIDList1[1];
                        strCorporateSLAID = arrCorporateSLAIDList1[2];
                        strCorporateType = arrCorporateSLAIDList1[3];
                        strCorporateSLADetailID = arrCorporateSLAIDList1[4];

                        var ConfigParameters = {
                            ProjectID: encodeURI(ProjectID),
                            CorporateCustomerID: encodeURI(strCustomerID),
                            CorporateSLAID: encodeURI(strCorporateSLAID),
                            CorporateType: encodeURI(strCorporateType),
                            CorporateSLADetailID: encodeURI(strCorporateSLADetailID)

                        }
                        var paramater = JSON.stringify(ConfigParameters);
                        var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/AddCorporateSLA", paramater, false);

                    }
                    if (strResult != undefined) {
                        alertify.success(strResult);
                    }
                    GetProjectLevelSLAList();
                }
                else {
                    CorporateSLAIDs = $("#" + CorporateSLAIDs).attr('CorporateSLAID');
                    arrCorporateSLAIDList = CorporateSLAIDs.split("~");
                    strCustomerID = arrCorporateSLAIDList[1];
                    strCorporateSLAID = arrCorporateSLAIDList[2];
                    strCorporateType = arrCorporateSLAIDList[3];
                    strCorporateSLADetailID = arrCorporateSLAIDList[4];
                    var ConfigParameters = {
                        ProjectID: encodeURI(ProjectID),
                        CorporateCustomerID: encodeURI(strCustomerID),
                        CorporateSLAID: encodeURI(strCorporateSLAID),
                        CorporateType: encodeURI(strCorporateType),
                        CorporateSLADetailID: encodeURI(strCorporateSLADetailID)
                    }
                    var paramater = JSON.stringify(ConfigParameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/AddCorporateSLA", paramater, false);
                    if (strResult != undefined) {
                        alertify.success(strResult);
                    }
                    GetProjectLevelSLAList();
                }
            }
            //Added By Usha Pandit On 26.03.2020 For refreshing on add SLA
            refreshMyParent();
            //End Of Added By Usha Pandit On 26.03.2020 For refreshing on add SLA
        }

        //function for validate Corporate SLA
        function ValidateCorporateSLA() {
            CorporateSLAIDs = $('input[name=chkcorpProjectSLA]').map(function () {
                return this.id;
            }).get().join(',');
            if (CorporateSLAIDs != "") {
                if (CorporateSLAIDs.indexOf(",") > -1) {
                    arrCorporateSLAIDs = CorporateSLAIDs.split(",");
                    for (i = 0; i < arrCorporateSLAIDs.length; i++) {
                        arrCorporateSLAIDList = $("#" + arrCorporateSLAIDs[i]).attr('CorporateSLAID');
                        arrCorporateSLAIDList1 = arrCorporateSLAIDList.split("~");
                        strCorporateType = arrCorporateSLAIDList1[3];
                        GetProjectSLAName(strCorporateType, arrCorporateSLAIDs[i]);
                    }

                }
                else {
                    var CorporateSLAIDs1 = $("#" + CorporateSLAIDs).attr('CorporateSLAID');
                    arrCorporateSLAIDList = CorporateSLAIDs1.split("~");
                    strCorporateType = arrCorporateSLAIDList[3];
                    GetProjectSLAName(strCorporateType, CorporateSLAIDs);
                }
            }

        }


        //validate Project SLA Name Duplicate
        function GetProjectSLAName(CorporateType, CorporateSLAID) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetExistingNames", paramater, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    if (CorporateType == strResult[i].TYPE) {

                        //Commented And Added By Usha Pandit On 11.06.2020 for adding blocker to all checkboxes with specific id if CorporateType is matched
                        //$("#" + CorporateSLAID).prop('disabled', true);
                        //$("#" + CorporateSLAID).css('cursor', 'not-allowed');

                        $("input[type=checkbox]").each(function () {

                            if ($(this).attr("id") == CorporateSLAID) {
                                //alert($(this).attr("corporateslaid"));
                                $(this).attr('disabled', true);
                                $(this).css('cursor', 'not-allowed');
                            }
                        });
                        //End Of Added By Usha Pandit On 11.06.2020 for adding blocker to all checkboxes with specific id if CorporateType is matched
                    }
                }
            }
        }

        //Corporate SLA Section End Here
        //Project SLA ADD,EDIT and Delete Section End Here


        //Norm Detail Panel Section Start Here

        //function for Norm Details List
        function GetSLANormDetailsList(NewProjectSLAID) {
            StartLoader("#main_ProjLevelSLA");
            $("#SLANormtbl").dataTable().fnDestroy();//Added By Dipali V On 11st April 2023 For Datatable Clear issue
            var ConfigParameters = {
                ProjectSLAID: encodeURI(NewProjectSLAID),
            }
            //$("#SLANormtbl").dataTable().fnDestroy();
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetSLANormDetailsList", paramater, false);
            $("#normtblbody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var ProjectSLADetailID = strResult[i]["ProjectSLADetailID"];
                var SLADetail = strResult[i]["SLADetail"];
                var Severity = strResult[i]["Severity"];
                var Priority = strResult[i]["Priority"];
                var Complexity = strResult[i]["Complexity"];
                var FromStatus = strResult[i]["StatusFrom"];
                var ToStatus = strResult[i]["StatusTo"];
                var Norm = strResult[i]["Norm"];
                var Unit = strResult[i]["Unit"];
                var AlertDetails = strResult[i]["Alert Details"];
                var ConsiderWorkHrs = strResult[i]["ConsiderWorkHrs"];
                var ExcludeHoldPeriod = strResult[i]["ExcludeHoldPeriod"];
                if (Severity == null) {
                    Severity = "";
                }
                if (Priority == null) {
                    Priority = "";
                }
                if (Complexity == null) {
                    Complexity = "";
                }
                if (ConsiderWorkHrs == true) {
                    ConsiderWorkHrs = "Yes";
                }
                else {
                    ConsiderWorkHrs = "No";
                }
                if (ExcludeHoldPeriod == true) {
                    ExcludeHoldPeriod = "Yes";
                }
                else {
                    ExcludeHoldPeriod = "No";
                }


                strHTML += '<tr>'
                strHTML += '<td><a href="javascript:;" data-bs-dismiss="modal" onclick="ADDEditSLANormClick(' + ProjectSLADetailID + ',1)">' + SLADetail + '</a></td>'
                strHTML += '<td>' + Severity + '</td>'
                strHTML += '<td>' + Priority + '</td>'
                strHTML += '<td>' + Complexity + '</td>'
                strHTML += '<td>' + FromStatus + '</td>'
                strHTML += '<td>' + ToStatus + '</td>'
                strHTML += '<td>' + Norm + '</td>'
                strHTML += '<td>' + Unit + '</td>'
                strHTML += '<td>' + ConsiderWorkHrs + '</td>'
                strHTML += '<td>' + ExcludeHoldPeriod + '</td>'
                strHTML += '<td><a href="javascript:;" data-bs-dismiss="modal" onclick="GetAlertDetailsInEdit(' + ProjectSLADetailID + ')">' + AlertDetails + '</a></td>'
                strHTML += '<td class="inp-select text-start">'
                strHTML += '<div class="form-check">'
                strHTML += '<div class="custom_chckbox">'
                strHTML += '<input id="' + ProjectSLADetailID + '" class="chcktbl norm-chck" name=chckSLANorm type="checkbox">'
                strHTML += '<label for="' + ProjectSLADetailID + '"></label>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '</tr>'
            }
            //debugger;
            $("#normtblbody").html("");
            $("#normtblbody").html(strHTML);
            //Added By Dipali V On 11st April 2023 For Datatable Clear issue
           // Pagination("#SLANormtbl");
            $("#SLANormtbl").DataTable({
                "pageLength": 3,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "scrollX": true,
                "retrieve": true,
                "columnDefs": [{
                    'width': '10%',
                    "orderable": false,
                    "targets": [11]
                },]
            });
            //End of Added By Dipali V On 11st April 2023 For Datatable Clear issue
            StopAjaxLoader("#main_ProjLevelSLA");
          
            // Added By Vishal On 21th Aug 2024 For Alignment Issue
            // var HTML = "";
            // if ($("#SLANormtbl tbody tr td").hasClass("dataTables_empty")) {
                //    // $("#SLANormtbl tbody tr td").prop("colspan", 12);
                //     HTML += "<tbody><tr><td colspan='12' style='text-align:center!important;'>No data available in table</td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td><td style='display:none'></td></tr></tbody>"
                //     //$("#SLANormtbl tbody tr td").css("cssText", "text-align: center !important;");
                //     $("#SLANormtbl").html(HTML);
                // }
            // End of Added By Vishal On 21th Aug 2024 For Alignment Issue
            
        }

        //ADD Edit SLA Norm
        function ADDEditSLANormClick(ProjectSLADetailID, Flag) {
            if (ProjectID != 0) {
                if (Flag == 0) {
                    if (ProjectSLADetailID == 0) {
                        $("#addNorm").modal('show');
                        $("#normHistoryTab").css('display', 'none');
                        DynamicControlPlot();
                        clearProjectSLANormDetails();
                        NewProjectSLADetailID = 0;
                        GetProjectPriorities(ProjectID);
                        GetProjectSeverity(ProjectID);
                        GetProjectComplexity(ProjectID);
                        GetProjectFromToStatus(ProjectID, NewProjectSLAID);
                        NormMode = "Add";

                    }
                }
                else if (Flag == 1) {
                    $("#addNorm").modal('show');
                    DynamicControlPlot();
                    NewProjectSLADetailID = ProjectSLADetailID;
                    GetSLANormDataInEditMode(NewProjectSLADetailID);
                    var IsHistory = IsHistoryContainsData(NewProjectSLADetailID);
                    if (IsHistory == true) {
                        $("#normHistoryTab").css('display', 'inline-block');
                    }
                    else {
                        $("#normHistoryTab").css('display', 'none');
                    }
                    NormMode = "Edit";

                }
            }
        }

        //plot severity,complexity,Priority Control In Norm
        function DynamicControlPlot() {

            var IsSLAApplicable = EditIsSLAApplicable;
            var SeverityTracking = EditSeverityTracking;
            var PriorityTracking = EditPriorityTracking;
            var ComplexityTracking = EditComplexityTracking;
            if (IsSLAApplicable == true && SeverityTracking == true && PriorityTracking == true && ComplexityTracking == true) {
                $("#divtxtNmSeverity").show();
                $("#divtxtNmPriority").show();
                $("#divtxtNmComplexity").show();
            }
            else if (IsSLAApplicable == true && SeverityTracking == true && PriorityTracking == true && ComplexityTracking == false) {
                $("#divtxtNmSeverity").show();
                $("#divtxtNmPriority").show();
                $("#divtxtNmComplexity").hide();
            }
            else if (IsSLAApplicable == true && SeverityTracking == true && PriorityTracking == false && ComplexityTracking == false) {
                $("#divtxtNmSeverity").show();
                $("#divtxtNmPriority").hide();
                $("#divtxtNmComplexity").hide();
            }
            else if (IsSLAApplicable == true && SeverityTracking == false && PriorityTracking == true && ComplexityTracking == false) {
                $("#divtxtNmSeverity").hide();
                $("#divtxtNmPriority").show();
                $("#divtxtNmComplexity").hide();
            }
            else if (IsSLAApplicable == true && SeverityTracking == false && PriorityTracking == true && ComplexityTracking == true) {
                $("#divtxtNmSeverity").hide();
                $("#divtxtNmPriority").show();
                $("#divtxtNmComplexity").show();
            }
            else if (IsSLAApplicable == true && SeverityTracking == false && PriorityTracking == false && ComplexityTracking == true) {
                $("#divtxtNmSeverity").hide();
                $("#divtxtNmPriority").hide();
                $("#divtxtNmComplexity").show();
            }
            else if (IsSLAApplicable == true && SeverityTracking == true && PriorityTracking == false && ComplexityTracking == true) {
                $("#divtxtNmSeverity").show();
                $("#divtxtNmPriority").hide();
                $("#divtxtNmComplexity").show();
            }
        }
        //Function for get SLA Norm Details In Edit Mode
        function GetSLANormDataInEditMode(NewProjectSLADetailID) {
            clearProjectSLANormDetails();
            GetProjectPriorities(ProjectID);
            GetProjectSeverity(ProjectID);
            GetProjectComplexity(ProjectID);
            GetProjectFromToStatus(ProjectID, NewProjectSLAID);

            var ConfigParameters = {
                ProjectSLADetailID: encodeURI(NewProjectSLADetailID)
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetSLANormDetailsInEdit", paramater, false);
            for (var i = 0; i < strResult.length; i++) {
                var SLADetail = strResult[i]["SLADetail"];
                var Severity = strResult[i]["SeverityID"];
                var Priority = strResult[i]["PriorityID"];
                var Complexity = strResult[i]["ComplexityID"];
                var StatusFrom = strResult[i]["StatusFromID"];
                var StatusTo = strResult[i]["StatusToID"];
                var Norm = strResult[i]["Norm"];
                var Unit = strResult[i]["Unit"];
                var ConsiderWorkHrs = strResult[i]["ConsiderWorkHrs"];
                var ExcludeHoldPeriod = strResult[i]["ExcludeHoldPeriod"];
                $("#txtNmSLAName").val(SLADetail);
                $("#txtNmSeverity").val(Severity);
                $("#txtNmPriority").val(Priority);
                $("#txtNmComplexity").val(Complexity);
                $("#txtNmFromStatus").val(StatusFrom);
                $("#txtNmToStatus").val(StatusTo);
                $("#txtNmNorm").val(Norm);
                $("#txtNmDaysHours").val(Unit);

                if (ConsiderWorkHrs == true) {
                    $("#chkConsiderWorkHrs").prop('checked', true);
                }
                else {
                    $("#chkConsiderWorkHrs").prop('checked', false);
                }
                if (ExcludeHoldPeriod == true) {
                    $("#chkExcludeHoldPeriod").prop('checked', true);
                }
                else {
                    $("#chkExcludeHoldPeriod").prop('checked', false);
                }

            }
        }
        //clear data in edit Norm
        function clearProjectSLANormDetails() {
            $("#txtNmSLAName").val('');
            $("#txtNmSeverity").val('');
            $("#txtNmPriority").val('');
            $("#txtNmComplexity").val('');
            $("#txtNmFromStatus").val('');
            $("#txtNmToStatus").val('');
            $("#txtNmNorm").val('');
            $("#txtNmDaysHours").val('');
            $("#chkConsiderWorkHrs").prop('checked', false);
            $("#chkExcludeHoldPeriod").prop('checked', false);
        }

        //Function for Project Priorities on Click on Add Norm
        function GetProjectPriorities(ProjectID) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectPriorities", paramater, false);
            if (strResult != "") {
                var objCbo1 = document.getElementById("txtNmPriority");
                $("#txtNmPriority option").remove();
                for (var i = 0; i < strResult.length; i++) {
                    var Objresult = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.value = Objresult.PriorityID;
                    objOption.text = Objresult.Priority;

                }
            }
        }

        //Function for Project Priorities on Click on Add Norm
        function GetProjectSeverity(ProjectID) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectSeverity", paramater, false);
            if (strResult != "") {
                var objCbo1 = document.getElementById("txtNmSeverity");
                $("#txtNmSeverity option").remove();
                for (var i = 0; i < strResult.length; i++) {
                    var Objresult = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.value = Objresult.ProjectSeverityID;
                    objOption.text = Objresult.Severity;

                }
            }
        }

        //Function for Project Priorities on Click on Add Norm
        function GetProjectComplexity(ProjectID) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectComplexity", paramater, false);
            if (strResult != "") {
                var objCbo1 = document.getElementById("txtNmComplexity");
                $("#txtNmComplexity option").remove();
                for (var i = 0; i < strResult.length; i++) {
                    var Objresult = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.value = Objresult.ComplexityID;
                    objOption.text = Objresult.Complexity;

                }
            }
        }


        //function for get From/To Status
        function GetProjectFromToStatus(ProjectID, NewProjectSLAID) {
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
                ProjectSLAID: encodeURI(NewProjectSLAID)
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetFromToStatus", paramater, false);
            if (strResult != "") {
                var objCbo1 = document.getElementById("txtNmFromStatus");
                var objCbo2 = document.getElementById("txtNmToStatus");
                $("#txtNmFromStatus option").remove();
                $("#txtNmToStatus option").remove();
                for (var i = 0; i < strResult.length; i++) {

                    var Objresult = strResult[i];
                    var Objresult1 = strResult[i];
                    var objOption = document.createElement("OPTION");
                    var objOption1 = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objCbo2.options.add(objOption1);
                    objOption.value = Objresult.ProjecttypeStatusID;
                    objOption.text = Objresult.Status;
                    objOption1.value = Objresult1.ProjecttypeStatusID;
                    objOption1.text = Objresult1.Status;

                }
            }
        }

        //Function for ADD New SLA Norm 
        function AddProjectSLANorm() {
            $("#btnSaveNorm").removeAttr('data-bs-dismiss', 'modal');
            $("#btnSaveNorm").removeAttr('data-bs-toggle', 'modal');
            $("#btnSaveNorm").removeAttr('data-bs-target', '#editProjectSla');
            var value = ValidateNormControls();
            if (value == true) {
                AddNewProjectSLANorm();
            }
            if ($('#normTblSltAll').is(':checked')) {
                $('#normTblSltAll').prop('checked', false);
            }
        }

        //Validate Add Norm Popup Controls
        function ValidateNormControls() {

            var checkval = false;

            var objSLAName = $("#txtNmSLAName").val();
            var objSeverity = $("#txtNmSeverity :selected").val();
            if (objSeverity == 0) { objSeverity = ""; }
            else { objSeverity = objSeverity; }

            // check if element is Visible           
            var objPriority = $("#txtNmPriority :selected").val();
            if (objPriority == 0) { objPriority = ""; }
            else { objPriority = objPriority; }

            var objComplexity = $("#txtNmComplexity :selected").val();
            if (objComplexity == 0) { objComplexity = ""; }
            else { objComplexity = objComplexity; }

            var objFromStatus = $("#txtNmFromStatus :selected").val();
            if (objFromStatus == 0) { objFromStatus = ""; }
            else { objFromStatus = objFromStatus; }
            var objToStatus = $("#txtNmToStatus :selected").val();
            if (objToStatus == 0) { objToStatus = ""; }
            else { objToStatus = objToStatus; }

            var objNorm = $("#txtNmNorm").val();
            var objDaysHours = $("#txtNmDaysHours :selected").val();
            if (objDaysHours == 0) { objDaysHours = ""; }
            else { objDaysHours = objDaysHours; }

            if (isBlank(objSLAName)) {
                alertify.error("<%= MyBase.GetResourceString("A_SLAName") %>");
                $('#txtNmSLAName').focus();
                return false;
            }
            else if (checkSpecialCharacter(objSLAName, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('SLA Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtNmSLAName").focus();
                return false;
            }
            if ($("#divtxtNmSeverity").is(":visible") == true) {
                if (isBlank(objSeverity)) {
                    alertify.error("<%= MyBase.GetResourceString("A_Severity") %>");
                    $('#txtNmSeverity').focus();
                    return false;

                }
            }
            if ($("#divtxtNmPriority").is(":visible") == true) {
                if (isBlank(objPriority)) {
                    alertify.error("<%= MyBase.GetResourceString("A_Priority") %>");
                    $('#txtNmPriority').focus();
                    return false;

                }
            }
            if ($("#divtxtNmComplexity").is(":visible") == true) {
                if (isBlank(objComplexity)) {
                    alertify.error("<%= MyBase.GetResourceString("A_Complexity") %>");
                    $('#txtNmComplexity').focus();
                    return false;

                }
            }
            if (isBlank(objFromStatus)) {
                alertify.error("<%= MyBase.GetResourceString("A_FromStatus") %>");
                $('#txtNmFromStatus').focus();
                return false;

            }
            if (isBlank(objToStatus)) {
                alertify.error("<%= MyBase.GetResourceString("A_ToStatus") %>");
                $('#txtNmToStatus').focus();
                return false;

            }
            if (isBlank(objNorm)) {
                alertify.error("<%= MyBase.GetResourceString("A_Norm") %>");
                $('#txtNmNorm').focus();
                return false;

            }
            if (checkSpecialCharacter(objNorm, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Norm should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtNmNorm").focus();
                return false;
            }
            if (isBlank(objDaysHours)) {
                alertify.error("<%= MyBase.GetResourceString("A_DaysHours") %>");
                $('#txtNmDaysHours').focus();
                return false;

            }
            if (NormMode == "Add") {
                if (objSLAName != "") {
                    var IsExists = GetNormExistingName(objSLAName);
                    if (IsExists == true) {
                        if (objFromStatus != "" && objToStatus != "") {
                            var chkresult = ValidateFromToStatus(objFromStatus, objToStatus);
                            if (chkresult == true) {
                                if (objNorm != "") {
                                    var result = ValidateNorm("txtNmNorm", "txtNmDaysHours");
                                    if (result == true) {
                                        checkval = true;
                                    }
                                    else {
                                        checkval = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (NormMode == "Edit") {
                if (objFromStatus != "" && objToStatus != "") {
                    var chkresult = ValidateFromToStatus(objFromStatus, objToStatus);
                    if (chkresult == true) {
                        if (objNorm != "") {
                            var result = ValidateNorm("txtNmNorm", "txtNmDaysHours");
                            if (result == true) {
                                checkval = true;
                            }
                            else {
                                checkval = false;
                            }
                        }
                    }
                }
            }

            return checkval;
        }


        //validate SLA Norm Name Duplication
        function GetNormExistingName(SLANormName) {
            var ConfigParameters = {
                ProjectSLAID: encodeURI(NewProjectSLAID),
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetNormExistingNames", paramater, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    if (SLANormName == strResult[i].SLADetail) {
                        alertify.error("<%= MyBase.GetResourceString("A_SLAAlreadyExists") %>");
                        $('#txtNmSLAName').focus();
                        return false;
                    }
                }
                return true;
            }

        }
        //Validate FromSatus and ToStatus
        function ValidateFromToStatus(objFromStatus, objToStatus) {

            if (objFromStatus == objToStatus) {
                alertify.error("<%= MyBase.GetResourceString("A_FromToStatus") %>");
                $('#txtNmFromStatus').focus();
                return false;
            }
            return true;
        }

        //Validate Norm
        function ValidateNorm(ControlID, ControlID1) {
            var objNorm = document.getElementById(ControlID);
            var objdaysHours = document.getElementById(ControlID1);
            var isdigit = isNumeric(objNorm.value);
            if (objdaysHours.value == 'Hours') {
                //Commented By Rutuja D. For IssueID = 23093

                <%--if (isdigit == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericNorm") %>");
                    $('#txtNmNorm').focus();
                    return false;
                }--%>
                //Commented By Rutuja D. For IssueID = 23093

                <%--if (disallowNegativeNumeric(objNorm)) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericNorm") %>");
                    $('#txtNmNorm').focus();
                    return false;
                }--%>
                //Restirct upto Two Demail Places

                //Commented & Added By Rutuja D. For IssueID = 23093
                //var Norm = objNorm.value;
                //Norm = Norm.trim();
                //var idxColon = Norm.indexOf('.');
                //var hrs = Norm.substring(0, idxColon);
                //var mins = Norm.substring(idxColon + 1, Norm.length);
                //if (mins.length > 2) {
                //    alertify.error("Enter 'Hours' Upto two Decimal Places.");
                //     $('#txtNmNorm').focus();
                //     return false;
                //}


                var GetHours = WorkHoursValidation(ControlID);
                if (GetHours == false) {
                    return false;
                }
                //End Commented & Added By Rutuja D.For IssueID = 23093

            }
            else {
                if (isdigit == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericNorm") %>");
                    $('#txtNmNorm').focus();
                    return false;
                }
                if (disallowNegativeNumeric(objNorm)) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericNorm") %>");
                    $('#txtNmNorm').focus();
                    return false;
                }
                if (objNorm.value.indexOf('.') > -1) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericNorm") %>");
                    $('#txtNmNorm').focus();
                    return false;
                }
            }
            return true;
        }


        //function for add new Project level SLA Norm 
        function AddNewProjectSLANorm() {
            var InsSLANorm = new Object();

            InsSLANorm.ProjectSLAID = NewProjectSLAID;

            InsSLANorm.SLADetail = $("#txtNmSLAName").val();

            InsSLANorm.ProjectID = ProjectID;

            InsSLANorm.Severity = $("#txtNmSeverity :selected").val();
           // if (InsSLANorm.Severity == undefined || InsSLANorm.Severity == 0) { InsSLANorm.Severity = ""; }
            if (InsSLANorm.Severity == undefined || InsSLANorm.Severity == 0) { InsSLANorm.Severity = "0"; }
            else { InsSLANorm.Severity = InsSLANorm.Severity; }

            InsSLANorm.Priority = $("#txtNmPriority :selected").val();
            //if (InsSLANorm.Priority == undefined || InsSLANorm.Priority == 0) { InsSLANorm.Priority = ""; }
            if (InsSLANorm.Priority == undefined || InsSLANorm.Priority == 0) { InsSLANorm.Priority = "0"; }
            else { InsSLANorm.Priority = InsSLANorm.Priority; }

            InsSLANorm.Complexity = $("#txtNmComplexity :selected").val();
            //if (InsSLANorm.Complexity == undefined || InsSLANorm.Complexity == 0) { InsSLANorm.Complexity = ""; }
            if (InsSLANorm.Complexity == undefined || InsSLANorm.Complexity == 0) { InsSLANorm.Complexity = "0"; }
            else { InsSLANorm.Complexity = InsSLANorm.Complexity; }

            InsSLANorm.StatusFrom = $("#txtNmFromStatus :selected").val();

            InsSLANorm.StatusTo = $("#txtNmToStatus :selected").val();

            InsSLANorm.Norm = $("#txtNmNorm").val();


            InsSLANorm.Unit = $("#txtNmDaysHours :selected").val();


            if ($('#chkConsiderWorkHrs').is(":checked")) {
                var ConsiderWorkHrs = 1;
            }
            else {
                var ConsiderWorkHrs = 0;
            }
            InsSLANorm.ConsiderWorkHrs = ConsiderWorkHrs;

            if ($('#chkExcludeHoldPeriod').is(":checked")) {
                var ExcludeHoldPeriod = 1;
            }
            else {
                var ExcludeHoldPeriod = 0;
            }
            InsSLANorm.ExcludeHoldPeriod = ExcludeHoldPeriod;

            InsSLANorm.UserName = UserName;

            InsSLANorm.UserID = UserID;

            InsSLANorm.ProjectSLADetailID = NewProjectSLADetailID;

            if (InsSLANorm.ProjectSLADetailID == undefined || InsSLANorm.ProjectSLADetailID == 0)
            {
                InsSLANorm.ProjectSLADetailID = "NULL";
            }
            else {
                InsSLANorm.ProjectSLADetailID = InsSLANorm.ProjectSLADetailID;
            }

            //objInsSLANorm = [InsSLANorm.ProjectSLAID, InsSLANorm.SLADetail, InsSLANorm.ProjectID, InsSLANorm.Severity, InsSLANorm.Priority, InsSLANorm.Complexity, InsSLANorm.StatusFrom, InsSLANorm.StatusTo, InsSLANorm.Norm,
            //InsSLANorm.Unit, InsSLANorm.ConsiderWorkHrs, InsSLANorm.ExcludeHoldPeriod, InsSLANorm.UserName, InsSLANorm.ProjectSLADetailID, InsSLANorm.UserID];

            objInsSLANorm = [InsSLANorm.ProjectSLAID, InsSLANorm.SLADetail, InsSLANorm.ProjectID, InsSLANorm.Severity, InsSLANorm.Priority, InsSLANorm.Complexity, InsSLANorm.StatusFrom, InsSLANorm.StatusTo, InsSLANorm.Norm,
            InsSLANorm.Unit, InsSLANorm.ConsiderWorkHrs, InsSLANorm.ExcludeHoldPeriod, InsSLANorm.UserName, InsSLANorm.ProjectSLADetailID, InsSLANorm.UserID];

            //Added By Dipali V On 11th April 2023 For Validate Header
            var objInsSLANorm_New = objInsSLANorm.toString();
          //End of  Dipali V On 11th April 2023 For Validate Header
            InsertSLANormControllerCall(objInsSLANorm_New);
        }

        //Add new Norm Controller Call
        function InsertSLANormControllerCall(objInsSLANorm) {

            StartLoader("#main_ProjLevelSLA");
            var param = JSON.stringify(objInsSLANorm);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/InsertNewSLANorm", param, false);

//alert(strResult);
            strResult = strResult.split("||");
            if (strResult[0] != "") {
                alertify.success(strResult[0]);
            }
            $("#btnSaveNorm").attr('data-bs-dismiss', 'modal');
            $("#btnSaveNorm").attr('data-bs-toggle', 'modal');
            $("#btnSaveNorm").attr('data-bs-target', '#editProjectSla');
            GetSLANormDetailsList(NewProjectSLAID);
            StopAjaxLoader("#main_ProjLevelSLA");
        }


        //function for Delete Project Level SLA Norm
        function DeleteSLANormData() {
            ProjectSLADetailIDs = $('input[name=chckSLANorm]:checked').map(function () {
                return this.id;
            }).get().join(',');

            if (ProjectSLADetailIDs.length != 0) {
                $("#editProjectSla").modal('hide');
                $("#deleteProjectSLANorm").modal('show');
            }
            else {
                alertify.error('Please Select Atleast One Record To Delete.');
                $("#deleteProjectSLANorm").modal('hide');
                return false;
            }
        }
        function DeleteProjectSLANorm() {
            var arrProjectSLADetailIDList = [];
            var strProjectSLADetailID;
            ProjectSLADetailIDs = $('input[name=chckSLANorm]:checked').map(function () {
                return this.id;
            }).get().join(',');

            if (ProjectSLADetailIDs != "") {
                if (ProjectSLADetailIDs.indexOf(",") > -1) {
                    arrProjectSLADetailIDList = ProjectSLADetailIDs.split(",");
                    for (i = 0; i < arrProjectSLADetailIDList.length; i++) {
                        strProjectSLADetailID = arrProjectSLADetailIDList[i];
                        var ConfigParameters = {
                            ProjectSLADetailID: encodeURI(strProjectSLADetailID),

                        }
                        var paramater = JSON.stringify(ConfigParameters);
                        var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/DeleteProjectSLANorms", paramater, false);

                    }
                    if (strResult != undefined) {
                        alertify.success(strResult);
                    }
                    GetSLANormDetailsList(NewProjectSLAID);
                    $("#normTblSltAll").prop('checked', false);
                }
                else {
                    var ConfigParameters = {
                        ProjectSLADetailID: encodeURI(ProjectSLADetailIDs),
                    }
                    var paramater = JSON.stringify(ConfigParameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/DeleteProjectSLANorms", paramater, false);
                    if (strResult != undefined) {
                        alertify.success(strResult);
                    }
                    GetSLANormDetailsList(NewProjectSLAID);
                    $("#normTblSltAll").prop('checked', false);
                }
            }
            
            $("#btndeleteSlaNorm").attr('data-bs-toggle', 'modal');
            // Added By Gauri On 21th Aug 2024 for delete modal pop up Issue 
            // $("#btndeleteSlaNorm").attr('data-bs-dismiss', 'modal');
            $("#deleteProjectSLANorm").modal('hide');
            // End of Added By Gauri On 21th Aug 2024 for delete modal pop up Issue
            $("#btndeleteSlaNorm").attr('data-bs-target', '#editProjectSla');

        }

        //Show History Data on Norm History Panel
        function IsHistoryContainsData(NewProjectSLADetailID) {
            var Flag = false;
            var TagID = 10013;
            var ConfigParameters = {
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                ProjectSLADetailID: encodeURI(NewProjectSLADetailID),
            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetNormHistoryDetails", paramater, false);
            if (strResult.length > 0) {
                Flag = true;
            }
            else {
                Flag = false;
            }
            return Flag;
        }

        //Norm History Detail List
        function GetNormHistoryData() {
            $("#normHistory").modal('show');
            var TagID = 10013;
            var ConfigParameters = {
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                ProjectSLADetailID: encodeURI(NewProjectSLADetailID),
            }
            $("#normHistorytbl").dataTable().fnDestroy();
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetNormHistoryDetails", paramater, false);
            $("#normHistorytblbody").html('');
            var strHTML = "";
            if (strResult.length > 0) {
                StartLoader("#main_ProjLevelSLA");
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
                $("#normHistorytblbody").html('');
                $("#normHistorytblbody").append(strHTML);
                StopAjaxLoader("#main_ProjLevelSLA")
                PaginationHistory("#normHistorytbl");
            }
        }

        //SLA Norm Section End Here

        //Norm Detail Panel Section End Here

        //Project Working Hours Section Start here
        function GetProjectWorkingHoursList() {
            $("#projHours").modal('show');
            StartLoader("#main_ProjLevelSLA");
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectWorkingHoursList", paramater, false);
            $("#projHourstblbody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var UniqueID = strResult[i]["UniqueID"];
                var WeekDay = strResult[i]["WeekDay"];
                var IsWorking = strResult[i]["IsWorking"];
                var FromTime = strResult[i]["FromTime"];
                var ToTime = strResult[i]["ToTime"];
                if (IsWorking == true) {
                    IsWorking = "Yes";
                }
                else {
                    IsWorking = "No";
                }

                if (FromTime == null) {
                    FromTime = "";
                }
                if (ToTime == null) {
                    ToTime = "";
                }
                strHTML += '<tr>'
                strHTML += '<td><a href="#" data-bs-dismiss="modal" onclick="ProjectWorkingHoursInEdit(' + UniqueID + ')" >' + WeekDay + '</a></td>'
                strHTML += '<td>' + IsWorking + '</td>'
                strHTML += '<td>' + FromTime + '</td>'
                strHTML += '<td>' + ToTime + '</td>'
                strHTML += '</tr>'

            }
            $("#projHourstblbody").html("");
            $("#projHourstblbody").html(strHTML);
            StopAjaxLoader("#main_ProjLevelSLA");
        }

        //Project Working Hours In Edit Mode
        function ProjectWorkingHoursInEdit(UniqueID) {

            $("#prosetWrkingHrsDetail").modal('show');
            $("#txtWeekday").val('');
            $("#txtFromTime").val('');
            $("#txtToTime").val('');
            $("#chkIsWorking").prop('checked', false);
            var ConfigParameters = {
                ProjectID: encodeURI(ProjectID),
                UniqueID: encodeURI(UniqueID)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProjectWorkingHoursList", paramater, false);
            for (var i = 0; i < strResult.length; i++) {
                NewUniqueID = strResult[i]["UniqueID"];
                var WeekDay = strResult[i]["WeekDay"];
                var IsWorking = strResult[i]["IsWorking"];
                var FromTime = strResult[i]["FromTime"];
                var ToTime = strResult[i]["ToTime"];

                $("#txtWeekday").val(WeekDay);
                $("#txtWeekday").prop('disabled', true);
                $("#txtFromTime").val(FromTime);
                $("#txtToTime").val(ToTime);

                if (IsWorking == true) {
                    $("#chkIsWorking").prop('checked', true);
                }
                else {
                    $("#chkIsWorking").prop('checked', false);
                }


            }
        }

        //function for Save Project Working Hours
        function SaveProjectWorkingHours() {
            //Added By Usha Pandit On 21.04.2020 For closing modal popup only after save success
            //$("#btnSaveWorkHours").removeAttr("data-bs-dismiss");

            //Added by Ashwini M on 29 - 3 - 2023
            $("#prosetWrkingHrsDetail").modal("hide");
            //End of Added by Ashwini M on 29 - 3 - 2023

            //End Of Added By Usha Pandit On 21.04.2020 For closing modal popup only after save success
            var value = ValidateProjectWorkingHours();
            if (value == true) {
                var WeekDay = $("#txtWeekday").val();
                if ($('#chkIsWorking').is(":checked")) {
                    var IsWorking = true;
                }
                else {
                    var IsWorking = false;
                }

                var FromTime = $("#txtFromTime").val();
                var ToTime = $("#txtToTime").val();

                var ConfigParameters = {
                    ProjectID: encodeURI(ProjectID),
                    WeekDay: encodeURI(WeekDay),
                    IsWorking: encodeURI(IsWorking),
                    FromTime: encodeURI(FromTime),
                    ToTime: encodeURI(ToTime),
                    UniqueID: encodeURI(NewUniqueID)

                }
                var paramater = JSON.stringify(ConfigParameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/SaveProjectWorkingHours", paramater, false);
                if (strResult != undefined) {
                    alertify.success(strResult);
                    //Added By Usha Pandit On 21.04.2020 For closing modal popup only after save success
                    $("#btnSaveWorkHours").attr('data-bs-dismiss', 'modal');
                    //End Of Added By Usha Pandit On 21.04.2020 For closing modal popup only after save success
                }
                GetProjectWorkingHoursList();
                $("#btnSaveWorkHours").attr('data-toogle', 'modal');
                $("#btnSaveWorkHours").attr('data-bs-dismiss', 'modal');
                $("#btnSaveWorkHours").attr('data-bs-target', '#projHours');
            }

        }

        function ValidateProjectWorkingHours() {
            var checkval = false;
            var objFromTime = $("#txtFromTime").val();
            var objToTime = $("#txtToTime").val();
            if (isBlank(objFromTime)) {
                alertify.error("<%= MyBase.GetResourceString("A_FromTime") %>");
                $('#txtFromTime').focus();
                checkval = false;
            }
            else if (isBlank(objToTime)) {
                alertify.error("<%= MyBase.GetResourceString("A_ToTime") %>");
                $('#txtToTime').focus();
                checkval = false;
            }
            if (objFromTime != "") {
                var result = ValidateFromTime("txtFromTime");
                if (result == true) {
                    if (objToTime != "") {
                        var result1 = ValidateToTime("txtToTime");
                        if (result1 == true) {
                            var chckresult = ValidateTime();
                            if (chckresult == true) {
                                checkval = true;
                            }
                            else {
                                checkval = false;
                            }
                        }
                    }
                }
            }

            return checkval;
        }

        //Validate Time
        function ValidateTime() {
            var timefrom = new Date();
            temp = $('#txtFromTime').val().split(":");
            timefrom.setHours((parseInt(temp[0]) - 1 + 24) % 24);
            timefrom.setMinutes(parseInt(temp[1]));

            var timeto = new Date();
            temp = $('#txtToTime').val().split(":");
            timeto.setHours((parseInt(temp[0]) - 1 + 24) % 24);
            timeto.setMinutes(parseInt(temp[1]));

            if (timeto < timefrom) {
                alertify.error("<%= MyBase.GetResourceString("A_ToTimeGreater") %>");
                $('#txtToTime').setFocus();
                return false;
            }
            return true;
        }


        //Restrict alphabets onkeypress
        function restrictAlphabets(e) {

            var x = e.which || e.keycode;

            if ((x >= 48 && x <= 57) || x == 8 || (x >= 35 && x <= 40) || x == 46 || x == 58) {
                return true;
            }
            else {
                return false;
            }
        }
        //validate From Time
        function ValidateFromTime(ControlFromTime) {

            var objFromTime = document.getElementById(ControlFromTime);
            var objValFromTime = objFromTime.value;
            var objoldValFromTime = objFromTime.value;

            if (objFromTime.value != "") {

                objFromTime.value = objFromTime.value.replace(":", ".");
                var isdigit = isNumeric(objFromTime.value);
                objFromTime.value = objoldValFromTime;
                if (isdigit == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_InvalidFromTime") %>");
                    setFocus(objFromTime);
                    return false;
                }

                var mm = objValFromTime.split(":")[1];
                if (mm == "") {
                    alertify.error("<%= MyBase.GetResourceString("A_FromTimeHM") %>");
                    setFocus(objFromTime);
                    return false;
                }

                if (objValFromTime.indexOf(":") == -1) {
                    objFromTime.value = objValFromTime + ":00";
                    objValFromTime = objFromTime.value;
                }
                if (objFromTime.value.indexOf(":") == -1) {
                    alertify.error("<%= MyBase.GetResourceString("A_FromTimeHM") %>");
                    setFocus(objFromTime);
                    return false;
                }

                if (objFromTime.value.indexOf(":") != -1) {
                    objFromTime.value = objFromTime.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objFromTime);
                if (blnResult == true) {
                    objFromTime.value = objoldValFromTime;
                    alertify.error("<%= MyBase.GetResourceString("A_FromTimeHM") %>");
                    setFocus(objFromTime);
                    return false;
                }

                blnResult = disallowNonNumeric(objFromTime);
                if (blnResult == true) {
                    objFromTime.value = objoldValFromTime;
                    alertify.error("<%= MyBase.GetResourceString("A_FromTimeHM") %>");
                    setFocus(objFromTime);
                    return false;
                }

                objFromTime.value = objFromTime.value.replace('.', ':');

                var FromTime = objFromTime.value;

                FromTime = FromTime.trim();
                var idxColon = FromTime.indexOf(':');

                var hrs = FromTime.substring(0, idxColon);
                var mins = FromTime.substring(idxColon + 1, FromTime.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (hrs.indexOf("-") != -1) {
                    alertify.error("<%= MyBase.GetResourceString("A_HoursNotequalToZero") %>");
                    setFocus(objFromTime);
                    return false;
                }
                if (hrs < 0 || hrs > 24) {//Added & commented By Dipali V On 10th June 2020 For issue id 25050
                    <%--alertify.error("<%= MyBase.GetResourceString("A_HoursBetweenRange") %>");--%>
                    alertify.error("Please enter 'Hours' between (1-24) range.");
                    setFocus(objFromTime);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_HoursNotequalToZero") %>");
                    setFocus(objFromTime);
                    return false;
                }
                if (mins.length > 2) {
                    alertify.error("<%= MyBase.GetResourceString("A_MinutesInTwoDecimal") %>");
                    setFocus(objFromTime);
                    return false;
                }
                if (mins > 59 || mins < 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_MinutesBetweenRange") %>");
                    setFocus(objFromTime);
                    return false;
                }
                return true;
            }
        }

        //validate From Time
        function ValidateToTime(ControlToTime) {
            var objToTime = document.getElementById(ControlToTime);
            var objValToTime = objToTime.value;
            var objoldValToTime = objToTime.value;

            if (objToTime.value != "") {

                objToTime.value = objToTime.value.replace(":", ".");
                var isdigit = isNumeric(objToTime.value);
                objToTime.value = objoldValToTime;
                if (isdigit == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_InvalidToTime") %>");
                    setFocus(objToTime);
                    return false;
                }

                var mm = objValToTime.split(":")[1];
                if (mm == "") {
                    alertify.error("<%= MyBase.GetResourceString("A_ToTimeHM") %>");
                    setFocus(objToTime);
                    return false;
                }

                if (objValToTime.indexOf(":") == -1) {
                    objToTime.value = objValToTime + ":00";
                    objValToTime = objToTime.value;
                }
                if (objToTime.value.indexOf(":") == -1) {
                    alertify.error("<%= MyBase.GetResourceString("A_ToTimeHM") %>");
                    setFocus(objToTime);
                    return false;
                }

                if (objToTime.value.indexOf(":") != -1) {
                    objToTime.value = objToTime.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objToTime);
                if (blnResult == true) {
                    objToTime.value = objoldValToTime;
                    alertify.error("<%= MyBase.GetResourceString("A_ToTimeHM") %>");
                    setFocus(objToTime);
                    return false;
                }

                blnResult = disallowNonNumeric(objToTime);
                if (blnResult == true) {
                    objToTime.value = objoldValToTime;
                    alertify.error("<%= MyBase.GetResourceString("A_ToTimeHM") %>");
                    setFocus(objToTime);
                    return false;
                }

                objToTime.value = objToTime.value.replace('.', ':');

                var ToTime = objToTime.value;

                ToTime = ToTime.trim();
                var idxColon = ToTime.indexOf(':');

                var hrs = ToTime.substring(0, idxColon);
                var mins = ToTime.substring(idxColon + 1, ToTime.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (hrs.indexOf("-") != -1) {
                    alertify.error("<%= MyBase.GetResourceString("A_HoursNotequalToZero") %>");
                    setFocus(objToTime);
                    return false;
                }
                //if (hrs < 0 || hrs > 23) {
                if (hrs < 0 || hrs > 24) {//Added & commented By Dipali V On 10th June 2020 For issue id 25050
                    alertify.error("Please enter 'Hours' between (1-23) range.");
                    <%--alertify.error("<%= MyBase.GetResourceString("A_HoursBetweenRange") %>");--%>
                    setFocus(objToTime);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_HoursNotequalToZero") %>");
                    setFocus(objToTime);
                    return false;
                }
                if (mins.length > 2) {
                    alertify.error("<%= MyBase.GetResourceString("A_MinutesInTwoDecimal") %>");
                    setFocus(objToTime);
                    return false;
                }
                if (mins > 59 || mins < 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_MinutesBetweenRange") %>");
                    setFocus(objToTime);
                    return false;
                }
                return true;
            }
        }



        //Project Working Hours Section End here

        //Alert Details Modal start here

        function GetAlertDetailsInEdit(ProjectSLADetailID) {
            $("#alertDetailsModal").modal('show');
            $("#txtAlertBefore").val('');
            $("#txtAlertBeforeUnit").val('');
            NewProjectSLADetailID = ProjectSLADetailID;
            StartLoader("#main_ProjLevelSLA");
            var ConfigParameters = {
                ProjectSLADetailID: encodeURI(ProjectSLADetailID)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetSLADetailsNorms", paramater, false);
            for (var i = 0; i < strResult.length; i++) {
                var Norm = strResult[i]["NORM"];
                var Unit = strResult[i]["UNIT"];

                $("#txtAlertBefore").val(Norm);
                $("#txtAlertBeforeUnit").val(Unit);

                //Added By Rutuja D. on 17 March 2020 For Disbled Alert Before Unit DropDown issueid = 23092
                $("#txtAlertBeforeUnit").prop('disabled', true);
                //End Added By Rutuja D. on 17 March 2020 For Disbled Alert Before Unit DropDown issueid = 23092

                //by vishal Mahajan 23-12-2019
                //$("#txtAlertBeforeUnit").prop('disabled', true);
                //by vishal Mahajan 23-12-2019
            }
            StopAjaxLoader("#main_ProjLevelSLA");
        }

        //function for Save Alert Details 
        function SaveAlertDetails() {
            //Added By Usha Pandit On 23.04.2020 For closing modal popup only after save success
            $("#btnsaveAlertDetails").removeAttr("data-bs-dismiss");
            $("#btnsaveAlertDetails").removeAttr("data-bs-toggle");
            $("#btnsaveAlertDetails").removeAttr("data-bs-target");
            //End Of Added By Usha Pandit On 23.04.2020 For closing modal popup only after save success
            var value = ValidateAlertDetails();
            if (value == true) {
                var Norm = $("#txtAlertBefore").val();
                var Unit = $("#txtAlertBeforeUnit :selected").val();
                var ConfigParameters = {
                    ProjectSLADetailID: encodeURI(NewProjectSLADetailID),
                    Norm: encodeURI(Norm),
                    Unit: encodeURI(Unit)
                }
                var paramater = JSON.stringify(ConfigParameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/SaveNormAlertDetails", paramater, false);
                if (strResult != undefined) {
                    alertify.success(strResult);
                }
                $("#btnsaveAlertDetails").attr('data-bs-dismiss', 'modal');
                $("#btnsaveAlertDetails").attr('data-bs-toggle', 'modal');
                $("#btnsaveAlertDetails").attr('data-bs-target', '#editProjectSla');
            }

        }

        function ValidateAlertDetails() {
            var checkval = false;
            var objAlertBefore = $("#txtAlertBefore").val();
            var objAlertBeforeUnit = $("#txtAlertBeforeUnit :selected").val();
            if (objAlertBeforeUnit == 0) { objAlertBeforeUnit = ""; }
            else { objAlertBeforeUnit = objAlertBeforeUnit; }

            if (isBlank(objAlertBefore)) {
                alertify.error("<%= MyBase.GetResourceString("A_AlertBefore") %>");
                $('#txtAlertBefore').focus();
                return false;
            }
            if (isBlank(objAlertBeforeUnit)) {
                alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeUnit") %>");
                $('#txtAlertBeforeUnit').focus();
                return false;
            }
            if (objAlertBefore != "") {
                var validate = ValidateAlertBefore("txtAlertBefore", "txtAlertBeforeUnit");
                if (validate == true) {
                    checkval = true;
                }
                else {
                    checkval = false;
                }
            }
            //Added By Dipali V On 10th June 2020 For Alert Before value should be HH:MM format
            if (validate == true) {
                if (objAlertBefore != "") {
                    if (objAlertBeforeUnit == "Hours") {
                        var validate1 = AlertBeforeValidation("txtAlertBefore", "txtAlertBeforeUnit");
                        if (validate1 == true) {
                            checkval = true;
                        } else {
                            checkval = false;
                        }
                    }
                }
            }
            //End of Added By Dipali V On 10th June 2020 For Alert Before value should be HH:MM format
            return checkval;
        }

        //Validate Alert Before
        function ValidateAlertBefore(ControlID, ControlID1) {
            var Normvalue = GetNormDetailsforAlert();
            var objAlertBefore = document.getElementById(ControlID);
            var objAlertBeforeUnit = document.getElementById(ControlID1);
            var isdigit = isNumeric(objAlertBefore.value);
            if (objAlertBeforeUnit.value == "Hours") {
                <%--if (isdigit == false) {//Commented By Dipali V On 10th Jun 2020
                    alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeHour") %>");
                    $('#txtAlertBefore').focus();
                    return false;
                }
                if (disallowNegativeNumeric(objAlertBefore)) {
                    alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeHour") %>");
                    $('#txtAlertBefore').focus();
                    return false;
                }
                if (objAlertBefore.value == 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeHour") %>");
                    $('#txtAlertBefore').focus();
                    return false;
                }--%>
                //End of Commented By Dipali V On 10th Jun 2020
                //Restirct upto Two Demail Places
                var AlertBefore = objAlertBefore.value;
                AlertBefore = AlertBefore.trim();
                var idxColon = AlertBefore.indexOf('.');
                var hrs = AlertBefore.substring(0, idxColon);
                var mins = AlertBefore.substring(idxColon + 1, AlertBefore.length);
                //if (mins.length > 2) {
                //alertify.error("Enter 'Alert Before' Upto two Decimal Places.");
                //$('#txtAlertBefore').focus();
                //return false;
                //}               
            }
            else {
                if (isdigit == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeDays") %>");
                    $('#txtAlertBefore').focus();
                    return false;
                }
                if (disallowNegativeNumeric(objAlertBefore)) {
                    alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeDays") %>");
                    $('#txtAlertBefore').focus();
                    return false;
                }
                if (objAlertBefore.value == 0) {
                    alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeDays") %>");
                    $('#txtAlertBefore').focus();
                    return false;
                }
                if (objAlertBefore.value.indexOf('.') > -1) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumericAlertBeforeDays") %>");
                    $('#txtAlertBefore').focus();
                    return false;
                }
            }
            if (objAlertBefore.value > Normvalue) {
                alertify.error("<%= MyBase.GetResourceString("A_AlertBeforeNormValue") %>");
                $('#txtAlertBefore').focus();
                return false;
            }
            return true;
        }

        function GetNormDetailsforAlert() {
            var ConfigParameters = {
                ProjectSLADetailID: encodeURI(NewProjectSLADetailID)

            }
            var paramater = JSON.stringify(ConfigParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetAlertDetailsNorms", paramater, false);
            if (strResult != undefined) {
                return strResult;
            }
        }
        //Alert Details Modal End here

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

                    console.log(err);
                   // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        //To set the pagination for the table
        function Pagination(PageID) {
            $(PageID).dataTable().fnDestroy();
            var stdTable1 = $(PageID).DataTable({
                "pageLength": 3,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "scrollX": true,
                "retrieve": true,
                "columnDefs": [{
                    'width': '10%',
                    "orderable": false,
                    "targets": [11]
                },]
            });
            stdTable1.columns.adjust().draw();

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
            $('#normHistory,#projectslaHistory').on('shown.bs.modal', function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            });

        }
        //dynamically set height
        function resizeSection(tag) {
            var divhieght2 = $(window).height();
            $('.Tabdetailpage-content').css({ 'height': divhieght2 - 140, "overflow-y": "auto" });
        }

        $(window).on("load resize scroll click", function (e) {
            resizeSection(this);
        });


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


        //this use for if checek box checked then all check box selected and all issue id stored in rows array                  
        $("#projslaAll").click(function () {
            $('#ProjLevelSLAtblbody input[type="checkbox"].acco-chck').prop('checked', $(this).prop('checked'));
        });


        $("#normTblSltAll").click(function () {
            $('#normtblbody input[type="checkbox"].norm-chck').prop('checked', $(this).prop('checked'));
        });

        ////this use for if uncheck one of the Checkbox then remove check of Select all        
        $(document).on('change', '#ProjLevelSLAtblbody input[type="checkbox"].acco-chck', function () {

            var checked = $('#ProjLevelSLAtblbody input[type="checkbox"].acco-chck').length;
            var checked1 = $('#ProjLevelSLAtblbody input[type="checkbox"].acco-chck:checked').length;
            if (checked == checked1) {
                $('#projslaAll').prop('checked', true);
            } else {
                $('#projslaAll').prop('checked', false);
            }

        });

        $(document).on('change', '#normtblbody input[type="checkbox"].norm-chck', function () {

            var checked = $('#normtblbody input[type="checkbox"].norm-chck').length;
            var checked1 = $('#normtblbody input[type="checkbox"].norm-chck:checked').length;
            if (checked == checked1) {
                $('#normTblSltAll').prop('checked', true);
            } else {
                $('#normTblSltAll').prop('checked', false);
            }

        });


        //Added By Rutuja D. For IssueID = 23093
        //Validation script for work hours
        function WorkHoursValidation(ControlID) {

            var objHMEffort = document.getElementById(ControlID);

            var objVal = objHMEffort.value;

            var objOldVal = objHMEffort.value;

            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                //alert(objHMEffort.value);
                var isdigit = jQuery.isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;

                if (isdigit == false) {
                    alertify.error("Please Enter only positive numeric value For Norm (hrs) in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                    alertify.error("Please enter Norm (hrs) in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    alertify.error("Please enter Norm (hrs) in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }
                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error("Please enter Norm (hrs) in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");
                //Please enter Work (hrs) in H:M format.
                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error("Please enter Norm (hrs) in H:M format.");
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
                    alertify.error("Norm should not be less than or equal to zero (0).");
                    setFocus(objHMEffort);
                    return false;
                }


                if (mins.length > 2) {
                    //alert("Please enter Work (hrs) in H:M format.");
                    alertify.error("Please enter minutes in two decimal and less than 60.");

                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {

                    alertify.error("Please enter minutes between (0-59) range");


                    setFocus(objHMEffort);

                    return false;
                }
                var param = JSON.stringify();
                var strResult = AJAXCallWithResult("/api/PM_WBS/GetRestrictByMinHours_MinHoursForDAEntry", param, false);

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
                            alertify.error("Please enter the Norm in multiple of (" + MinDAENtryDisplay + ") min");
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }

            }
            return true;
        }

        //Added By Rutuja D. For IssueID = 23093
        //Added By Dipali V On 10th Jun 2020 For AlertBefore value should be HH:MM formate
        function AlertBeforeValidation(ControlID) {

            var objHMEffort = document.getElementById(ControlID);

            var objVal = objHMEffort.value;

            var objOldVal = objHMEffort.value;

            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                //alert(objHMEffort.value);
                var isdigit = jQuery.isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;

                if (isdigit == false) {
                    alertify.error("Please Enter only positive numeric value For Alert before in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                    alertify.error("Please enter Alert before in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    alertify.error("Please enter Alert before in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }
                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error("Please enter Alert before in H:M format.");
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");
                //Please enter Work (hrs) in H:M format.
                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error("Please enter Alert before in H:M format.");
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
                    alertify.error("Alert before should not be less than or equal to zero (0).");
                    setFocus(objHMEffort);
                    return false;
                }


                if (mins.length > 2) {
                    //alert("Please enter Work (hrs) in H:M format.");
                    alertify.error("Please enter minutes in two decimal and less than 60.");

                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {

                    alertify.error("Please enter minutes between (0-59) range");


                    setFocus(objHMEffort);

                    return false;
                }
                var param = JSON.stringify();
                var strResult = AJAXCallWithResult("/api/PM_WBS/GetRestrictByMinHours_MinHoursForDAEntry", param, false);

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
                            alertify.error("Please enter the Alert before in multiple of (" + MinDAENtryDisplay + ") min");
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }

            }
            return true;
        }


        $('.modal').on('hidden.bs.modal', function () {
            StopAjaxLoader("#main_ProjLevelSLA");
        });


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

    </script>
</body>

</html>
