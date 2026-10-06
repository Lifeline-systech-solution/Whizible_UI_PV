<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectWorkflow.aspx.vb" Inherits="PbNIT.PM_ProjectWorkflow" %>


<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
  
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.2" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

</head>

    <style>
        @media (min-width: 992px) {
    .collapsed {
        display: block;
        margin-right: 0%;
    }
}
        body {
            background: #fff;
        }

        .modalpgHead {
            background: #4263c1;
            color: #fff;
            font-family: 'Roboto', sans-serif;
            font-size: 20px;
        }

        #tblProjectWorkflow {
            margin: 0 auto 20px;
            width: 97%;
        }

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

        .d-block {
            display: block !important;
        }
        /*added by okmar, Vishal 24-12-2019 */
        .in-tbl .in-tbl-td {
            padding: 0px !important;
        }

        .in-tbl-head tr th:first-child, .in-tbl-head + tbody tr td:first-child {
            width: 40px !important;
        }

        .in-tbl-head tr th:nth-child(2), .in-tbl-head tr th:nth-child(3), .in-tbl-head + tbody tr td:nth-child(2), .in-tbl-head + tbody tr td:nth-child(3) {
            width: 200px !important;
        }

        .in-tbl-head tr th:nth-child(5), .in-tbl-head + tbody tr td:nth-child(5) {
            width: 130px !important;
        }

        .in-tbl-head tr th:nth-child(6), .in-tbl-head + tbody tr td:nth-child(6) {
            width: 30px !important;
        }

        .in-tbl-head-hide {
            visibility: collapse;
        }
        /*by Vishal Mahajan 24-12-2019*/
        .alertify-notifier {
            z-index: 9999 !important;
        }
        /*Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
        .clsShowHide {
            display: none !important;
        }
        .collapse.show {
            display: revert!important;
        }
        /*End Of Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
td.hiddenRow.subCustomField .accordian-body{ padding:0;}
td.text-start.tbl-head-blue {background: #e7edf0;}
    </style>


<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyProjectWorkflow">
    <div id="divProjectWorkflow">
        <div class="tab-pane pstbl_custom pt-0 practicesettinglist in active" id="pstbl_proj_workflow">
            <div class="modalpgHead pt-1 pb-1 col-sm-12"><%= MyBase.GetResourceString("P_Project_Workflow") %></div>
            <div class=" pt-1 pb-1 col-sm-12 px-3 clearfix text-end">
                <h5 class="float-start mb-0 pt-2"><%= MyBase.GetResourceString("P_Project_Name") %> : <span id="ProjectName"></span></h5>
                <a href="#" class="btn borderbtn mr-5" data-bs-toggle="modal" data-bs-target="#inheritModal" onclick="GetInheritableProjectWorkflows()"><%= MyBase.GetResourceString("P_Inherit_Workflows") %></a>

            </div>
            <div class="row pad-10">
                <div class="col-sm-3 pl-20">
                    <label class="control-label d-block"><%= MyBase.GetResourceString("P_Active") %></label>
                    <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowIsActive", "usp_Whizible2_Sel_tbl_UI_ControlTagMaster_SPForActive ",,,, False,, "form-select selectpicker",,,) %>
                </div>
                <div class="col-sm-3">
                    <label class="control-label d-block"><%= MyBase.GetResourceString("P_Workflow_Entity") %></label>
                    <%--Commented & Added By Dipali V On 11th June 2020 For Issue ID 25101--%>
               <%-- <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowEntity", "usp_Whizible2_sel_tbl_IM_Attributes ",,,, True,, "form-control selectpicker",,,) %>
            --%>
                 <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowEntity", "usp_Whizible2_sel_tbl_IM_Attributes ",,,, False,, "form-select selectpicker",,,) %>
            <%--End of Commented & Added By Dipali V On 11th June 2020 For Issue ID 25101--%>
                </div>
            </div>
            <table class="table table-bordered" id="tblProjectWorkflow">
                <thead>
                    <tr>
                        <th class="text-start"><%= MyBase.GetResourceString("P_Workflow") %></th>
                        <th><%= MyBase.GetResourceString("P_Workflow_Entity") %></th>
                        <th><%= MyBase.GetResourceString("P_Revision_Number") %></th>
                        <th><%= MyBase.GetResourceString("P_Active") %></th>
                        <th><%= MyBase.GetResourceString("P_Get_New_Version") %></th>
                    </tr>
                </thead>
                <tbody id="tbodytblProjectWorkflow">
                </tbody>
            </table>

            <!--Page modal start here-->

            <!--Inherit modal start here-->
            <div class="modal custmodal fade" id="inheritModal" aria-hidden="true">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("P_Inherit_Workflows") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <table class="table table-stripped table-bordered" id="tblProjectWorkflowInheritWorkflows">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("P_Workflow") %></th>
                                            <th class="inp-select">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="InheritworkflowSLTAll" class="chckHead">
                                                    <label for="InheritworkflowSLTAll"></label>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyProjectWorkflowInheritWorkflows">
                                        <%--<tr>
                                        <td colspan="2">There are no items to show in this view.</td>
                                    </tr>--%>
                                    </tbody>
                                </table>
                            </div>
                            <div class="center-align">
                                <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("P_Close") %></a>
                                <%--<a href="javascript:;" class="btn btnyellow" data-bs-dismiss="modal" id="btnInheritProjectWorkflow" onclick="InheritProjectWorkflows()"><%= MyBase.GetResourceString("P_Inherit") %></a>--%>
                                <%--by vishal Mahajan 24-12-2019--%>
                                <a href="javascript:;" class="btn btnyellow" id="btnInheritProjectWorkflow" onclick="InheritProjectWorkflows()"><%= MyBase.GetResourceString("P_Inherit") %></a>
                                <%--by vishal Mahajan 24-12-2019--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Inherit modal end here-->


            <!--Select Stages modal start here-->
            <div class="modal custmodal fade" id="sltStagesModal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("P_Select_Stages") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="page-main-head">
                                    <h4><%= MyBase.GetResourceString("P_Workflow") %> : <span id="ProjectWorkflowSelectStagesWorkflowName"></span></h4>
                                </div>
                                <table class="table table-stripped table-bordered slt-stages-tbl">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("P_Order_Number") %></th>
                                            <th><%= MyBase.GetResourceString("P_Stage") %></th>
                                            <th><%= MyBase.GetResourceString("P_Checklist") %></th>
                                            <th id="theadProjectWorkflowStageResumeTimesheetLink"><%= MyBase.GetResourceString("P_Enable_Block_Resume_Timesheet_Link") %></th>
                                            <th id="theadProjectWorkflowStageResumeProjectLink"><%= MyBase.GetResourceString("P_Enable_OnHold_Resume_Project_Link") %></th>
                                            <th><%= MyBase.GetResourceString("P_Select") %></th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyProjectWorkflowSelectStages">
                                    </tbody>
                                </table>
                            </div>
                            <div class="btn-grp-new">
                                <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("P_Close") %></a>
                                <%--Commented By Dipali V On 11th Jun 2020 25092--%>
                            	<%--<a href="javascript:;" id="btnSaveProjectWorkflowSelectStages" class="btn btnyellow" data-bs-dismiss="modal"><%= MyBase.GetResourceString("P_Save") %></a>--%>
                        		<%--End of Commented By Dipali V On 11th Jun 2020 25092--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Select Stages modal end here-->

            <!--Approver Roles modal start here-->
            <div class="modal custmodal fade" id="approverRolesModal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("P_Approver_Roles") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="page-main-head">
                                    <h4><%= MyBase.GetResourceString("P_Stage") %> <span id="projectWorkflowApproverRolesStage"></span></h4>
                                </div>
                                <div class="row form-group mb-3">
                                    <div class="col-sm-4">
                                        <label><%= MyBase.GetResourceString("P_Role") %></label>
                                        <input type="text" id="ProjectWorkflowApproverSearch" onkeyup="Approversearch()" name="" class="form-control">
                                    </div>
                                </div>
                                <table class="table table-stripped table-bordered approver-tbl">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("P_Role") %></th>
                                            <th class="inp-select">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="roleSltAll" class="chckHead">
                                                    <label for="roleSltAll"></label>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyProjectWorkflowApproverRoles">
                                    </tbody>
                                </table>
                            </div>
                            <div class="btn-grp-new">
                                <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("P_Close") %></a>
                                 <%--Commented & Added By Dipali V On 11th une 2020 For Issue id 25092--%>

                            <%--end OF Commented & Added By Dipali V On 11th une 2020 For Issue id 25092--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Approver Roles modal end here-->

            <!--Alternate Approvers modal start here-->
            <div class="modal custmodal fade" id="alternateApproSlt" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("P_Project_Approvers") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="page-main-head">
                                    <h4><%= MyBase.GetResourceString("P_Stage_Head_Approval") %></h4>
                                </div>
                                <div class="pad-10">
                                    <div class="row form-group mb-3">
                                        <div class="col-sm-6">
                                            <label class="control-label d-block"><%= MyBase.GetResourceString("P_Business_Group") %></label>
                                           
                                         <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowProjectApproversBusinessGroup", "usp_Whizible2_Sel_tbl_CNF_BusinessGroups_WF ",,,, False,, "form-select selectpicker",,,) %>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="control-label d-block"><%= MyBase.GetResourceString("P_Organization_Unit") %></label>
                                           
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowProjectApproversOrganizationUnit", "usp_Whizible2_Sel_GetOrganizationUnit_WF",,,, False,, "form-select selectpicker",,,) %>
                                        </div>
                                    </div>
                                    <div class="row form-group mb-3">
                                        <div class="col-sm-6">
                                            <label class="control-label d-block"><%= MyBase.GetResourceString("P_Role") %></label>
                                           
                                         <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowProjectApproversRole", "usp_Whizible2_Sel_tbl_PM_Role_WF ",,,, False,, "form-select selectpicker",,,) %>                                    
                                        </div>
                                        <div class="col-sm-6">
                                            <label><%= MyBase.GetResourceString("P_Alternate_Approver") %></label>
                                            <input type="text" name="" id="ProjectWorkflowAlternateApproverSearch" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <table class="table table-bordered">
                                    <thead class="in-tbl-head">
                                        <tr>
                                            <th><%= MyBase.GetResourceString("P_Role") %></th>
                                            <th><%= MyBase.GetResourceString("P_Employee_Name") %></th>
                                            <th><%= MyBase.GetResourceString("P_User_Name") %></th>
                                            <th><%= MyBase.GetResourceString("P_Business_Group") %></th>
                                            <th><%= MyBase.GetResourceString("P_Organization_Unit") %></th>
                                            <th class="inp-select">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="workflowSLTAll" class="chckHead">
                                                    <label for="workflowSLTAll"></label>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyProjectWorkflowAlternateApprover">
                                    </tbody>
                                </table>
                            </div>
                            <div class="btn-grp-new">
                                <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("P_Close") %></a>
                                <%--Commented  By Dipali V On 11th June 2020 For Issue Id 25092--%>
                            <%--<a href="javascript:;" class="btn btnyellow" data-bs-dismiss="modal" id="btnSaveProjectWorkflowAlternateApprover"><%= MyBase.GetResourceString("P_Save") %></a>
                        --%>
                           <%-- Commented By Dipali V On 11th June 2020 For Issue Id 25092--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Alternate Approvers modal end here-->

            <!--Define Rule modal start here-->
            <div class="modal custmodal fade" id="defineRuleModal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("P_Define_Rule") %></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="page-main-head">
                                    <h4>Workflow : <span id="projectWorkflowDefineRuleWorkflow"></span><span class="fl-right"><%= MyBase.GetResourceString("P_Stage") %> : <span id="projectWorkflowDefineRuleStage"></span></span></h4>
                                </div>
                                <table class="table table-stripped table-bordered approver-tbl">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("P_Approver") %></th>
                                            <th><%= MyBase.GetResourceString("P_Rule") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyProjectWorkflowDefineRule">
                                    </tbody>
                                </table>
                            </div>
                            <div class="center-align">
                                <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("P_Close") %></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Define Rule modal end here-->

            <!--Page modal end here-->

        </div>

        <%-- <div id="DivNotView" class="tab-pane" style="height: 587px; display: none">
        <div style="text-align: center; padding: 275px" class="box box-solid">
            <p><%= MyBase.GetResourceString("P_You_are_not_authorized_to_view_this_record") %> </p>
        </div>
    </div>--%>

        <div id="NoProjectDivID" hidden="hidden">
            <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i><%= MyBase.GetResourceString("P_Project_Not_Selected") %></h4>
        </div>

        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->
        
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
        <!-- jqueryUI js -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
      
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
       
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>

        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>

        <!-- Alertify js -->
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

        <!-- Loader js -->
        <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
        <script src="../../General/CommonValidations.js?v=1"></script>--%>

        <script>
            //Added By Rehan C To check validation for Special characters  on 15th Nov 2022
            var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'


            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        <%--var ProjectID = '<%= m_ProjectID %>';--%>
            //let searchParams = new URLSearchParams(window.location.search);
            // var ProjectID = searchParams.get('ProjectID');
            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
            var m_PM_ProjectWorkFlowblnAddAccess = '<%= m_PM_ProjectWorkFlowblnAddAccess %>';
            var m_PM_ProjectWorkFlowblnEditAccess = '<%= m_PM_ProjectWorkFlowblnEditAccess %>';
            var m_PM_ProjectWorkFlowblnDeleteAccess = '<%= m_PM_ProjectWorkFlowblnDeleteAccess %>';
            var m_PM_ProjectWorkFlowblnViewAccess = '<%= m_PM_ProjectWorkFlowblnViewAccess %>';

            var ProjectName = '<%= Session("strProjectName") %>';
            var UserName = '<%= Session("strUserName") %>';
            var UserID = '<%= Session("intUserID") %>';
            var GblProjectWorkflowProjectNatureofDemandID = 0;
            var GblProjectWorkflowRequestStageID = 0;
            var GblProjectWorkflowEntityID = 0;
            var GblProjectWorkflowNatureOfDemandStageID = 0;

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
			var SelectedWFstatus = "";

            $(document).ready(function () {
				StartLoader("#bodyProjectWorkflow");
            	alertify.set('notifier', 'position', 'top-right');
                if (m_PM_ProjectWorkFlowblnViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectWorkflow").html(bodyHTML);
                    return;
                }
                StartLoader("#bodyProjectWorkflow");
                alertify.set('notifier', 'position', 'top-right');

                if (m_PM_ProjectWorkFlowblnViewAccess == "False" && m_PM_ProjectWorkFlowblnAddAccess == "False" && m_PM_ProjectWorkFlowblnEditAccess == "False") {
                    $("#pstbl_proj_workflow").hide();
                    //$("#DivNotView").show();
                }
                if (ProjectID == 0) {
                    $("#pstbl_proj_workflow").hide();
                    $("#NoProjectDivID").show();
                }
                else {
                    GetProjectWorkFlowData(ProjectID, null, null);
                    GetProjectName();
                }

                if (m_PM_ProjectWorkFlowblnEditAccess == "False" || m_PM_ProjectWorkFlowblnAddAccess == "False") {
                    $("#btnSaveProjectWorkflowSelectStages,#btnSaveProjectWorkflowAlternateApprover,#btnSaveWorkflowApproverRoles").hide();
                }

                if (m_PM_ProjectWorkFlowblnAddAccess == "False") {
                    $("#btnInheritProjectWorkflow").hide();
                }

                $("#roleSltAll").click(function () {
                    $(".role-chck").prop('checked', $(this).prop('checked'));
                });

                $(".role-chck").change(function () {
                    if (!$(this).prop("checked")) {
                        $("#roleSltAll").prop("checked", false);
                    }
                });

                $(".closeAcco").click(function () {
                    $(this).closest(".accordian-body").removeClass("in");
                });

                StopAjaxLoader("#bodyProjectWorkflow");

            });

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

            $("#cboProjectWorkflowIsActive").change(function () {
                var IsActive = this.value;

                var AttributeID = $("#cboProjectWorkflowEntity").val();
                if (IsActive == "") {
                    IsActive = "NULL";
                }
                if (AttributeID == "") {
                    AttributeID = "NULL";
                }

                GetProjectWorkFlowData(ProjectID, AttributeID, IsActive);
            })

            $("#cboProjectWorkflowEntity").change(function () {
                var IsActive = $("#cboProjectWorkflowIsActive").val();
                var AttributeID = $("#cboProjectWorkflowEntity").val();
                if (IsActive == "") {
                    IsActive = "NULL";
                }
                if (AttributeID == "") {
                    AttributeID = "NULL";
                }
                GetProjectWorkFlowData(ProjectID, AttributeID, IsActive);
            })

            //Get workflow data for project
            function GetProjectWorkFlowData(ProjectID, AttributeID, IsActive) {
                StartLoader("#bodyProjectWorkflow");
                var strHTML = '';
                if (AttributeID == undefined || AttributeID == 0) {
                    AttributeID = "NULL";
                }
                if (IsActive == undefined) {
                    IsActive = "NULL";
                }
                var ProjectWorkFlowParameter = {
                    ProjectID: encodeURI(ProjectID),
                    AttributeID: encodeURI(AttributeID),
                    IsActive: encodeURI(IsActive)
                }

                var param = JSON.stringify(ProjectWorkFlowParameter);
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/GetProjectWorkFlowData", param, false);
                $("#tbodytblProjectWorkflow").empty();
                if (strResult.length == 0) {
                    strHTML += '<tr>'
                    strHTML += '<td colspan="5">There are no items to show in this view.</td>'
                    strHTML += '</tr>'
                    $("#tbodytblProjectWorkflow").append(strHTML);
                }
                else {
                    for (var i = 0; i < strResult.length; i++) {
                        strHTML = '';

                        if (i == 0) {
                            strHTML += '<tr>'
                            strHTML += '<td colspan="5" class="text-start tbl-head-blue">' + strResult[i].EntityName + '</td>'
                            strHTML += '</tr>'
                        }
                        if (i > 0) {
                            if (strResult[i].EntityName != strResult[i - 1].EntityName) {
                                strHTML += '<tr>'
                                strHTML += '<td colspan="5" class="text-start tbl-head-blue">' + strResult[i].EntityName + '</td>'
                                strHTML += '</tr>'
                            }
                        }
                        strHTML += '<tr>'
                        strHTML += '<td></td>'
                        //Added By Usha Pandit On 08.07.2020 For not allowing to make active all revisions of workflow, which causes duplication
                        var IsEnableGetLatestVersionLink = ProjectWorkflowGetLatestVersionLinkValidation(strResult[i].ProjectNatureofDemandID);
                        //End Of Added By Usha Pandit On 08.07.2020 For not allowing to make active all revisions of workflow, which causes duplication
                                                
                        strHTML += '<td><a href="javascript:;" data-bs-toggle="collapse" onclick="GetProjectWorkflowStages(' + strResult[i].ProjectNatureofDemandID + ',' + strResult[i].AttributeID + ')" data-bs-target="#chngeReqAppro' + strResult[i].ProjectNatureofDemandID + '">' + strResult[i].NatureofDemand + '</a></td>'
                        
                        strHTML += '<td>' + strResult[i].RevisionNo + '</td>'
                        if (strResult[i].IsActive == 1) {
                            strHTML += '<td>Yes</td>'
                        }
                        else if (strResult[i].IsActive == 0) {
                            strHTML += '<td>No</td>'
                        }
                        //Commented By Usha Pandit On 08.07.2020 For not allowing to make active all revisions of workflow, which causes duplication
                        //var IsEnableGetLatestVersionLink = ProjectWorkflowGetLatestVersionLinkValidation(strResult[i].ProjectNatureofDemandID);
                        //End Of Commented By Usha Pandit On 08.07.2020 For not allowing to make active all revisions of workflow, which causes duplication

                        if (IsEnableGetLatestVersionLink == 1) {
                            strHTML += '<td><a href="javascript:;" onClick="ProjectWorkflowGetLatestVersion(' + strResult[i].ProjectNatureofDemandID + ')">Get Latest Version</a></td>'
                        }
                        else {
                            strHTML += '<td></td>'
                        }
                        //strHTML += '<td><a href="javascript:;" onClick="ProjectWorkflowGetLatestVersion(' + strResult[i].ProjectNatureofDemandID + ')">Get Latest Version</a></td>'
                        strHTML += '</tr>'



                        strHTML += '<tr>'
                        strHTML += '<td colspan="7" class="hiddenRow subCustomField text-start">'
                        strHTML += '<div  id="chngeReqAppro' + strResult[i].ProjectNatureofDemandID + '"  class="accordian-body collapse" aria-expanded="true" style="">'
                        strHTML += '<div class="pt-1 pb-1 bgwhite pad-10">'
                        strHTML += '<div class="page-main-head">'
                        strHTML += '<h4><%= MyBase.GetResourceString("P_Project_Workflow") %></h4>'
                    strHTML += '</div>'

                    strHTML += '<div class="right-side-save mr-10">'
                    strHTML += '<a href="javascript:;" onclick="CloseProjectWorkflowEditRow(chngeReqAppro' + strResult[i].ProjectNatureofDemandID + ')" class="btn borderbtn mr-5 closeAcco">Close</a>'

                    if (m_PM_ProjectWorkFlowblnAddAccess != "False" && m_PM_ProjectWorkFlowblnEditAccess != "False") {
                        strHTML += '<a href="javascript:;" id="btnSaveProjectWorkflow' + strResult[i].ProjectNatureofDemandID + '" class="btn btnyellow" onclick="SaveProjectWorkflow(' + strResult[i].ProjectNatureofDemandID + ')">Save</a>'
                    }
                    strHTML += '</div>'

                    strHTML += '<div class="mar-10 panel-border">'
                    strHTML += '<div class="page-main-head">'
                    strHTML += '<h4><%= MyBase.GetResourceString("P_Workflow_Information") %></h4>'
                    strHTML += '</div>'
                    strHTML += '<div class="row pad-10">'
                    strHTML += '<div class="col-sm-4">'
                    strHTML += '<label class="required"><%= MyBase.GetResourceString("P_Workflow_Code") %></label>'
                    strHTML += '<input type="text" name="" value="' + strResult[i].NatureofDemandCode + '"  class="form-control" disabled>'
                    strHTML += '</div>'
                    strHTML += '<div class="col-sm-4">'
                    strHTML += '<label class="required"><%= MyBase.GetResourceString("P_Workflow") %></label>'
                    strHTML += '<input type="text" id="txtProjectWorkflowName' + strResult[i].ProjectNatureofDemandID + '" name="" value="' + strResult[i].NatureofDemand + '" class="form-control">'
                    strHTML += '</div>'
                    strHTML += '<div class="col-sm-4 pt-20">'
                    strHTML += '<div class="inp-select d-inline-block">'
                    strHTML += '<div class="custom_chckbox">'

                    if (strResult[i].IsActive == 1) {
                        strHTML += '<input type="checkbox" id="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '" class="chckHead" checked>'
                        strHTML += '<label for="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '"></label>'
                    }
                    else {
                        //Commented And Added By Usha Pandit On 08.07.2020 For not allowing to make active all revisions of workflow, which causes duplication
                        //strHTML += '<input type="checkbox" id="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '" class="chckHead">'
                        //strHTML += '<label for="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '"></label>'

                        if (IsEnableGetLatestVersionLink == 1) {
                            strHTML += '<input type="checkbox" id="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '" class="chckHead">'
                        strHTML += '<label for="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '"></label>'
                        }
                        else {
                            strHTML += '<input type="checkbox" disabled id="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '" class="chckHead">'
                        strHTML += '<label for="activeStatSlt' + strResult[i].ProjectNatureofDemandID + '"></label>'
                        } 
                        //End Of Added By Usha Pandit On 08.07.2020 For not allowing to make active all revisions of workflow, which causes duplication
                    }
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '<label class="d-inline-block"><%= MyBase.GetResourceString("P_Active") %></label>'
                    strHTML += '</div>'
                    strHTML += '</div>'

                    strHTML += '<div class="row pad-10">'
                    strHTML += '<div class="col-sm-4">'
                    strHTML += '<label><%= MyBase.GetResourceString("P_Revision_Number") %> : ' + strResult[i].RevisionNo + '</label>'
                    strHTML += '</div>'
                    strHTML += '<div class="col-sm-4">'
                    strHTML += '<label><%= MyBase.GetResourceString("P_Workflow_Entity") %></label>'
                    strHTML += '<select class="form-select" tabindex="-98" disabled>'
                    strHTML += '<option>' + strResult[i].EntityName + '</option>'
                    strHTML += '</select>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '<div class="mar-10 panel-border">'
                    strHTML += '<div class="page-main-head">'
                    strHTML += '<h4><%= MyBase.GetResourceString("P_Stage_Information") %></h4>'
                    strHTML += '</div>'
                    strHTML += '<div class="pad-10">'
                    strHTML += '<div class="page-main-head">'
                    strHTML += '<h4>Project Workflow Stages</h4>'
                    strHTML += '</div> '
                    strHTML += '<div class="right-side-save mb-10 mr-0">'
                    strHTML += '<a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" onclick="ProjectWorkflowSelectStagesData(' + strResult[i].ProjectNatureofDemandID + ')" data-bs-target="#sltStagesModal"><%= MyBase.GetResourceString("P_Select_Stages") %></a>'
                    strHTML += '</div>'
                    strHTML += '<table class="table table-stripped table-bordered">'
                    strHTML += '<thead>'
                    strHTML += '<tr>'
                    strHTML += '<th><%= MyBase.GetResourceString("P_Order_Number") %></th>'
                    strHTML += '<th><%= MyBase.GetResourceString("P_Workflow_Stage") %></th>'
                    strHTML += '<th><%= MyBase.GetResourceString("P_Approver_Roles") %></th>'
                    strHTML += '<th><%= MyBase.GetResourceString("P_Define_Rule") %></th>'
                    strHTML += '<th><%= MyBase.GetResourceString("P_Alternate_Approver") %></th>'
                        strHTML += '</tr>'
                        strHTML += '</thead>'
                        strHTML += '<tbody id="tbodyProjectWorkflowStages' + strResult[i].ProjectNatureofDemandID + '">'
                        strHTML += '</tbody>'
                        strHTML += '</table>'
                        strHTML += '</div>'
                        strHTML += '</div>'
                        strHTML += '</div>'
                        strHTML += '</div>'
                        strHTML += '</td>'
                        strHTML += '</tr>'

                        $("#tbodytblProjectWorkflow").append(strHTML);
                    }
                }
                StopAjaxLoader("#bodyProjectWorkflow");
            }


            function SaveProjectWorkflow(NatureOfDemandID) {
                
                var WorkflowName = $("#txtProjectWorkflowName" + NatureOfDemandID).val();
                var IsChecked = $("#activeStatSlt" + NatureOfDemandID).is(":checked");
                if (IsChecked == true) {
                    IsChecked = 1;
                }
                if (IsChecked == false) {
                    IsChecked = 0;
                }

                if (WorkflowName == "") {
                    alertify.error("<%= MyBase.GetResourceString("P_Workflow_should_not_be_left_blank") %>");
                    $("#txtProjectWorkflowName" + NatureOfDemandID).focus();
                
                }
                
            else {
                    if (WorkflowName != null && WorkflowName != undefined) {
                        //Added By Rehan C For SpecialChar Validation
                        if (checkSpecialCharacter(WorkflowName, WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Workflow not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                            $("#txtProjectWorkflowName" + NatureOfDemandID).focus();
                            return false;
                        }
                        //End Of Comment By Rehan C
                    if (WorkflowName.toString().indexOf("'") != -1) {
                        WorkflowName = WorkflowName.replace(/'/g, "''''");
                    }
                }
                var SQLStatement = "N'UPDATE tbl_IM_ProjectNatureofDemand SET NatureofDemand =  N''" + WorkflowName + "'',IsActive = ''" + IsChecked + "'' WHERE ProjectNatureofDemandID = ''" + NatureOfDemandID + "'''";
                var SQLXML = '<WebFormData WebFormID="3934"><Fields><NonDatabase1 /><NatureofDemand>' + WorkflowName + '</NatureofDemand><IsActive>' + IsChecked + '</IsActive></Fields><WhereClause><ProjectNatureofDemandID>' + NatureOfDemandID + '</ProjectNatureofDemandID></WhereClause></WebFormData>';

                var ProjectWorkFlowParameter = {
                    SQLStatement: encodeURI(SQLStatement),
                    SQLXML: encodeURI(SQLXML)
                }
                var param = JSON.stringify(ProjectWorkFlowParameter);
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/SaveProjectWorkflow", param, false);

                if (strResult == null) {
                    alertify.success("<%= MyBase.GetResourceString("P_Updated_Workflow_Successfully") %>");
                        GetProjectWorkFlowData(ProjectID);
                    }
                }
            }

            function CloseProjectWorkflowEditRow(Id) {
                $("#" + Id.id).removeClass("show");
            }

            function ProjectWorkflowGetLatestVersionLinkValidation(NatureOfDemandID) {
                var param = JSON.stringify(encodeURI(NatureOfDemandID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowGetLatestVersionLinkValidation", param, false);
                return strResult;
            }


            // To get the latest version of the workflow
            function ProjectWorkflowGetLatestVersion(ProjectNatureofDemandID) {
                StartLoader("#bodyProjectWorkflow");
                var param = JSON.stringify(encodeURI(ProjectNatureofDemandID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowGetLatestVersion", param, false);
                var IsActive = $("#cboProjectWorkflowIsActive").val();
                var AttributeID = $("#cboProjectWorkflowEntity").val();

                if (IsActive == "") {
                    IsActive = "NULL";
                }
                if (AttributeID == "") {
                    AttributeID = "NULL";
                }
                GetProjectWorkFlowData(ProjectID, AttributeID, IsActive);
                StopAjaxLoader("#bodyProjectWorkflow");
                //Added By Usha Pandit On 19.01.2020 For Refresh on get latest version
                refreshMyParent();
                //End Of Added By Usha Pandit On 19.01.2020 For Refresh on get latest version
            } 
            
            // Added  By Dipali V On 12th June 2020 For Check Selected WF Active or not
        function CheckProjectWFStatus(ProjectNatureofDemandID) {
            //StartLoader("#bodyProjectWorkflow");
            var param = JSON.stringify(encodeURI(ProjectNatureofDemandID));
            SelectedWFstatus = AJAXCallWithResult("/api/PM_ProjectWorkflow/CheckWFActiveorNOt", param, false);
            //StopAjaxLoader("#bodyProjectWorkflow");
        }

        //End of Added  By Dipali V On 12th June 2020 For Check Selected WF Active or not
                   
            function GetProjectWorkflowStages(ProjectNatureofDemandID, EntityID) {            
                StartLoader("#bodyProjectWorkflow");
                GblProjectWorkflowProjectNatureofDemandID = ProjectNatureofDemandID;
                GblProjectWorkflowEntityID = EntityID;
                var tbodyID = "#tbodyProjectWorkflowStages" + ProjectNatureofDemandID;
                var strHTML = '';
                var param = JSON.stringify(encodeURI(ProjectNatureofDemandID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/GetProjectWorkflowStages", param, false);
                $(tbodyID).empty();
                for (var i = 0; i < strResult.length; i++) {
                    strHTML = '';
                    strHTML += '<tr>'
                    strHTML += '<td>' + strResult[i].OrderNo + '</td>'
                    strHTML += '<td>' + strResult[i].RequestStage + '</td>'
                    strHTML += '<td><a href="javascript:;" data-bs-toggle="modal" onclick="ProjectWorkflowGetApproverRoles(' + strResult[i].ProjectNatureOfDemandStageID + ',' + strResult[i].RequestStageID + ')" data-bs-target="#approverRolesModal">' + strResult[i].StakeHolderNames + '</a></td>'
                    if (EntityID == "32" && strResult[i].StakeHolderNames != '-' && strResult[i].Approvers != '-') {
                        strHTML += '<td><a href="javascript:;" data-bs-toggle="modal" onclick="ProjectWorkflowGetDefineRules(' + strResult[i].RequestStageID + ')" data-bs-target="#defineRuleModal"><%= MyBase.GetResourceString("P_Define_Rule") %></a></td>'
                    }
                    else {
                        strHTML += '<td>-</td>'
                    }
                    strHTML += '<td><a href="javascript:;" data-bs-toggle="modal" onclick="ProjectWorkflowGetAlternateApprovers(' + strResult[i].ProjectNatureOfDemandStageID + ',' + strResult[i].RequestStageID + ')" data-bs-target="#alternateApproSlt">' + strResult[i].Approvers + '</a></td>'
                    strHTML += '</tr>'
                    $(tbodyID).append(strHTML);
                }
                StopAjaxLoader("#bodyProjectWorkflow");
            }

            //Get the inheritable Workflows of project
            function GetInheritableProjectWorkflows() {
                StartLoader("#bodyProjectWorkflow");
                /*Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                $("#btnInheritProjectWorkflow").removeClass("clsShowHide");
                /*End Of Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                var strHTML = '';
                $("#tbodyProjectWorkflowInheritWorkflows").empty();
                var param = JSON.stringify(encodeURI(ProjectID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/GetInheritableProjectWorkflows", param, false);
                if (strResult.length == 0) {
                    strHTML += '<tr>'
                    strHTML += '<td colspan="2">There are no items to show in this view.</td>'
                    strHTML += '</tr>'
                    $("#tbodyProjectWorkflowInheritWorkflows").append(strHTML);
                    $("#btnInheritProjectWorkflow").hide();
                    $("#InheritworkflowSLTAll").prop("checked", false);
                }
                else {
                    if (m_PM_ProjectWorkFlowblnAddAccess != "False") {
                        $("#btnInheritProjectWorkflow").show();
                    }
                    for (var i = 0; i < strResult.length; i++) {
                        strHTML = '';
                        if (i == 0) {
                            strHTML += '<tr>'
                            strHTML += '<td colspan="5" class="text-start tbl-head-blue">' + strResult[i].Attribute + '</td>'
                            strHTML += '</tr>'
                        }
                        if (i > 0) {
                            if (strResult[i].Attribute != strResult[i - 1].Attribute) {
                                strHTML += '<tr>'
                                strHTML += '<td colspan="5" class="text-start tbl-head-blue">' + strResult[i].Attribute + '</td>'
                                strHTML += '</tr>'
                            }
                        }
                        strHTML += '<tr>'
                        strHTML += '<td>' + strResult[i].Natureofdemand + '</td>'
                        strHTML += '<td class="inp-select">'
                        strHTML += '<div class="custom_chckbox">'
                        strHTML += '<input type="checkbox" id="ProjectWorkflow' + strResult[i].NatureofdemandID + '" class="chckHead chckInheritWorkFlowattri">'
                        strHTML += '<label for="ProjectWorkflow' + strResult[i].NatureofdemandID + '"></label>'
                        strHTML += '</div>'
                        strHTML += '</td>'
                        strHTML += '</tr>'
                        $("#tbodyProjectWorkflowInheritWorkflows").append(strHTML);
                    }
                }
                $(".chckInheritWorkFlowattri").change(function () {
                    //var rowCount = $("#tbodyProjectWorkflowInheritWorkflows > tr").length;
                    var rowCount = 0;
                    $('*[id*=ProjectWorkflow]:input[type=checkbox]').each(function () {
                        rowCount = rowCount + 1;
                    });
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowInheritWorkflows");

                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#InheritworkflowSLTAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#InheritworkflowSLTAll").prop("checked", false);
                    }
                });
                StopAjaxLoader("#bodyProjectWorkflow");
            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjectWorkflow%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjectWorkflow%>');
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

            //Inherit the workflows
            function InheritProjectWorkflows() {
                StartLoader("#bodyProjectWorkflow");               
                var WorkflowIds = '';
                var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowInheritWorkflows");
               
                for (var i = 0; i < CheckedcheckedBoxes.length; i++) {
                    var CheckboxId = CheckedcheckedBoxes[i].id;
                    WorkflowIds += CheckboxId.replace('ProjectWorkflow', '') + ',';
                }
				if (CheckedcheckedBoxes.length > 0) {//Added By Dipali V On 11th june 2020 For issue Id 25097
                WorkflowIds = WorkflowIds.slice(0, -1);
                //by vishal Mahajan 24-12-2019
                if (WorkflowIds == "") {
                    StopAjaxLoader("#bodyProjectWorkflow");
                    alertify.error("<%= MyBase.GetResourceString("P_Please_select_at_least_one_Workflow") %>");
                    /*Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                    $("#btnInheritProjectWorkflow").removeClass("clsShowHide");
                    /*End Of Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                } else {
                    /*Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                    if ($("#btnInheritProjectWorkflow").hasClass("clsShowHide") == false) {
                        /*End Of Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                        //by vishal Mahajan 24-12-2019
                        var ProjectWorkFlowParameter = {
                            ProjectID: encodeURI(ProjectID),
                            CreatedBy: encodeURI(UserName),
                            WorkflowIds: encodeURI(WorkflowIds)
                        }

                        $.ajax({
                            url: strUrl + '/api/PM_ProjectWorkflow/InheritProjectWorkflows',
                            method: 'Post',
                            data: JSON.stringify(ProjectWorkFlowParameter),
                            dataType: 'json',
                            async: false,
                            contentType: "application/json",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (ProjectWorkFlowParameter) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(ProjectWorkFlowParameter) ? ProjectWorkFlowParameter : JSON.stringify(ProjectWorkFlowParameter)));
                                }
                            },
                            success: function (result) {
                                //by vishal Mahajan 24-12-2019
                                $("#inheritModal").modal("hide");
                                //by vishal Mahajan 24-12-2019
                                if (result == null) {
                                    alertify.success("<%= MyBase.GetResourceString("P_Inherited_workflows_successfully") %>");
                                    GetProjectWorkFlowData(ProjectID);
                                    refreshMyParent();
                                }
                                /*Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                                $("#btnInheritProjectWorkflow").removeClass("clsShowHide");
                                /*End Of Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        })
                        StopAjaxLoader("#bodyProjectWorkflow");
                        /*Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                    }
                    $("#btnInheritProjectWorkflow").addClass("clsShowHide");
                    /*End Of Added By Usha Pandit on 19.01.2020 for inherit workflow duplicate issue*/
                }                            
				} else {//Added By Dipali V On 11th june 2020 For issue Id 25097

                alertify.set('notifier', 'position', 'top-right');      
                alertify.notify("Please select at least one reocrd", 'error', 10);
                //End of Added By Dipali V On 11th june 2020 For issue Id 25097

            }   
            }


            function ProjectWorkflowGetApproverRoles(ProjectNatureOfDemandStageID, RequestStageID) {
                GblProjectWorkflowRequestStageID = RequestStageID;
                $("#ProjectWorkflowApproverSearch").val('');
                ProjectWorkflowGetApproverRolesStage(RequestStageID);
                $("#tbodyProjectWorkflowApproverRoles").empty();
                var strHTML = '';
                var param = JSON.stringify(encodeURI(ProjectNatureOfDemandStageID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowGetApproverRoles", param, false);
                if (strResult.length == 0) {
                    strHTML += '<tr>'
                    strHTML += '<td colspan="2">There are no items to show in this view.</td>'
                    strHTML += '</tr>'
                    $("#tbodyProjectWorkflowApproverRoles").append(strHTML);
                    //$("#btnInheritProjectWorkflow").hide();
                    //$("#InheritworkflowSLTAll").prop("checked", false);
                }
                else {
                    for (var i = 0; i < strResult.length; i++) {
                        strHTML = '';
                        strHTML += '<tr>'
                        strHTML += '<td>' + strResult[i].Role + '</td>'
                        strHTML += '<td class="inp-select">'
                        strHTML += '<div class="custom_chckbox">'

                        if (strResult[i].Selected == 1) {
                            strHTML += '<input type="checkbox" id="ProjectWorkflowApproverRole' + strResult[i].RoleID + '" class="chckHead role-chck" checked>'
                            strHTML += '<label for="ProjectWorkflowApproverRole' + strResult[i].RoleID + '"></label>'
                        }
                        else {
                            strHTML += '<input type="checkbox" id="ProjectWorkflowApproverRole' + strResult[i].RoleID + '" class="chckHead role-chck">'
                            strHTML += '<label for="ProjectWorkflowApproverRole' + strResult[i].RoleID + '"></label>'
                        }
                        strHTML += '</div>'
                        strHTML += '</td>'
                        strHTML += '</tr>'
                        $("#tbodyProjectWorkflowApproverRoles").append(strHTML);
                    }
                }
            }


            //Function for set the Stage name for Approver Roles
            function ProjectWorkflowGetApproverRolesStage(RequestStageID) {
                $("#projectWorkflowApproverRolesStage,#projectWorkflowDefineRuleStage").empty();
                var param = JSON.stringify(encodeURI(RequestStageID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowGetApproverRolesStage", param, false);
                $("#projectWorkflowApproverRolesStage,#projectWorkflowDefineRuleStage").append(strResult);
            }


            $("#btnSaveWorkflowApproverRoles").click(function () {
                StartLoader("#bodyProjectWorkflow");
                var strApproverID = ",";
                var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowApproverRoles");
                for (var i = 0; i < CheckedcheckedBoxes.length; i++) {
                    var CheckboxId = CheckedcheckedBoxes[i].id;
                    strApproverID += CheckboxId.replace('ProjectWorkflowApproverRole', '') + ',';
                }
                var ProjectWorkFlowParameter = {
                    strApproverID: encodeURI(strApproverID),
                    CreatedBy: encodeURI(UserName),
                    intUserID: encodeURI(UserID),
                    RequestStageID: encodeURI(GblProjectWorkflowRequestStageID),
                    NatureOfDemandID: encodeURI(GblProjectWorkflowProjectNatureofDemandID)
                }
                $.ajax({
                    url: strUrl + '/api/PM_ProjectWorkflow/ProjectWorkflowSaveApproverRoles',
                    method: 'Post',
                    data: JSON.stringify(ProjectWorkFlowParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectWorkFlowParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectWorkFlowParameter) ? ProjectWorkFlowParameter : JSON.stringify(ProjectWorkFlowParameter)));
                        }
                    },
                    success: function (result) {
                        alertify.success("<%= MyBase.GetResourceString("P_Saved_Approver_Roles_successfully") %>");
                        GetProjectWorkflowStages(GblProjectWorkflowProjectNatureofDemandID, GblProjectWorkflowEntityID);
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
                StopAjaxLoader("#bodyProjectWorkflow");
            })


            //Searchbox for Approver role 
            function Approversearch() {
                var input, filter, tbody, tr, a, i, txtValue;
                input = document.getElementById("ProjectWorkflowApproverSearch");
                filter = input.value.toUpperCase();
                tbody = document.getElementById("tbodyProjectWorkflowApproverRoles");
                tr = tbody.getElementsByTagName("tr");
                for (i = 0; i < tr.length; i++) {
                    a = tr[i].innerText;
                    // txtValue = a.textContent || a.innerText;
                    if (a.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }


            function ProjectWorkflowGetDefineRules(RequestStageID) {
                var strHTML = '';
                ProjectWorkflowGetApproverRolesStage(RequestStageID);
                var WorkflowName = ProjectWorkflowDefineRuleGetWorkflowName(GblProjectWorkflowProjectNatureofDemandID);
                $("#projectWorkflowDefineRuleWorkflow").empty();
                $("#projectWorkflowDefineRuleWorkflow").append(WorkflowName);

                var ProjectWorkFlowParameter = {
                    RequestStageID: encodeURI(RequestStageID),
                    NatureOfDemandID: encodeURI(GblProjectWorkflowProjectNatureofDemandID)
                }
                var param = JSON.stringify(ProjectWorkFlowParameter);
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowGetDefineRules", param, false);

                $("#tbodyProjectWorkflowDefineRule").empty();
                if (strResult.length == 0) {
                    strHTML += '<tr>'
                    strHTML += '<td colspan="2">There are no items to show in this view.</td>'
                    strHTML += '</tr>'
                    $("#tbodyProjectWorkflowDefineRule").append(strHTML);
                }
                else {
                    for (var i = 0; i < strResult.length; i++) {
                        strHTML = ''
                        strHTML += '<tr>'
                        strHTML += '<td>' + strResult[i].RoleDescription + '</td>'

                        if (strResult[i].RuleDetails == null) {
                            strHTML += '<td></td>'
                        }
                        else {
                            //Commented & Added bY Dipali v On 17th July 2020 For Issues ID 25587

                            //strHTML += '<td>' + strResult[i].RuleDetails + '</td>'
                            strHTML += '<td>' + strResult[i].UserFriendlyRuleDetails + '</td>'
                            //End of Commented & Added bY Dipali v On 17th July 2020 For Issues ID 25587

                        }
                        $("#tbodyProjectWorkflowDefineRule").append(strHTML);
                    }
                }
            }


            function ProjectWorkflowDefineRuleGetWorkflowName(NatureOfDemandID) {
                var param = JSON.stringify(encodeURI(NatureOfDemandID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowDefineRuleGetWorkflowName", param, false);
                return strResult;
            }



            function ProjectWorkflowGetAlternateApprovers(ProjectNatureOfDemandStageID, RequestStageID) {
                $("#cboProjectWorkflowProjectApproversBusinessGroup,#cboProjectWorkflowProjectApproversOrganizationUnit,#cboProjectWorkflowProjectApproversRole").val(0);
                $("#ProjectWorkflowAlternateApproverSearch").val('');
                GblProjectWorkflowRequestStageID = RequestStageID;
                GblProjectWorkflowNatureOfDemandStageID = ProjectNatureOfDemandStageID;
                ProjectWorkflowGetProjectApprovers(ProjectNatureOfDemandStageID);
            }

            var ProjectWorkflowAlternateApprovertbodyIdArray = new Array();
            //Function to plot Project Approver List
            function ProjectWorkflowGetProjectApprovers(ProjectNatureOfDemandStageID, RoleID, BusinessGroupID, OrganizationUnitID, AlternateApproverName) {
                //StartLoader("#bodyProjectWorkflow");
                if (RoleID == undefined) {
                    RoleID = 'NULL';
                }
                if (BusinessGroupID == undefined) {
                    BusinessGroupID = 'NULL';
                }

                if (OrganizationUnitID == undefined) {
                    OrganizationUnitID = 'NULL';
                }
                if (AlternateApproverName == undefined) {
                    AlternateApproverName = 'NULL';
                }
                var strHTML = '';
                //by okmar, Vishal 24-12-2019
                var HeaderProjectApproval = '<thead class="in-tbl-head in-tbl-head-hide"><tr><th><%= MyBase.GetResourceString("P_Role") %></th><th><%= MyBase.GetResourceString("P_Employee_Name") %></th>' +
                                        '<th><%= MyBase.GetResourceString("P_User_Name") %></th><th><%= MyBase.GetResourceString("P_Business_Group") %></th>' +
                                        '<th><%= MyBase.GetResourceString("P_Organization_Unit") %></th><th class="inp-select"></th></tr></thead>';
                var ProjectWorkFlowParameter = {
                    ProjectID: encodeURI(ProjectID),
                    NatureOfDemandID: encodeURI(ProjectNatureOfDemandStageID),
                    RoleID: encodeURI(RoleID),
                    BusinessGroupID: encodeURI(BusinessGroupID),
                    OrganizationUnitID: encodeURI(OrganizationUnitID),
                    AlternateApproverName: encodeURI(AlternateApproverName)
                }
                var param = JSON.stringify(ProjectWorkFlowParameter);
                var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowGetAlternateApprovers", param, false);
                $("#tbodyProjectWorkflowAlternateApprover").empty();
                ProjectWorkflowAlternateApprovertbodyIdArray.length = 0;

                if (strResult.length == 0) {
                    strHTML += '<tr>'
                    strHTML += '<td colspan="6">There are no items to show in this view.</td>'
                    strHTML += '</tr>'
                    $("#tbodyProjectWorkflowAlternateApprover").append(strHTML);
                }
                else {
                    for (var i = 0; i < strResult.length; i++) {
                        strHTML = '';

                        if (i == 0) {
                            ProjectWorkflowAlternateApprovertbodyIdArray.push('#tbodyAlternateApprover' + strResult[i].PostID);
                            strHTML += '<tr>'
                            strHTML += '<td colspan="6" class="text-start tbl-head-blue">'
                            strHTML += '<a href="javascript:;" class="collapsed change-req-acco " data-bs-toggle="collapse" data-bs-target="#appliAdmin' + strResult[i].EmployeeID + '" aria-expanded="false">' + strResult[i].RoleDescription + ''
                            //Commented & Added By Dipali V On 9th May 2023 For Arrow not display
                            //strHTML += '<span class="glyphicon glyphicon-chevron-down float-end down-arrow" aria-hidden="true"></span>'
                            //strHTML += '<span class="glyphicon glyphicon-chevron-up float-end up-arrow" aria-hidden="true"></span>'

                            strHTML += '<span><i class="fas fa-chevron-down float-end down-arrow"></i></span>'
                            strHTML += '<span><i class="fas fa-chevron-up float-end up-arrow"></i></span>'
                            //End of Commented & Added By Dipali V On 9th May 2023 For Arrow not display
                            strHTML += '</a>'
                            strHTML += '</td>'
                            strHTML += '</tr>'
                        }
                        if (i > 0) {
                            if (strResult[i].RoleDescription != strResult[i - 1].RoleDescription) {
                                ProjectWorkflowAlternateApprovertbodyIdArray.push('#tbodyAlternateApprover' + strResult[i].PostID);
                                strHTML += '<tr>'
                                strHTML += '<td colspan="6" class="text-start tbl-head-blue">'
                                strHTML += '<a href="javascript:;" class="collapsed change-req-acco " data-bs-toggle="collapse" data-bs-target="#appliAdmin' + strResult[i].EmployeeID + '" aria-expanded="false">' + strResult[i].RoleDescription + ''
                                //Commented & Added By Dipali V On 9th May 2023 For Arrow not display
                                //strHTML += '<span class="glyphicon glyphicon-chevron-down float-end down-arrow" aria-hidden="true"></span>'
                                //strHTML += '<span class="glyphicon glyphicon-chevron-up float-end up-arrow" aria-hidden="true"></span>'
                                strHTML += '<span><i class="fas fa-chevron-down float-end down-arrow"></i></span>'
                                strHTML += '<span><i class="fas fa-chevron-up float-end up-arrow"></i></span>'
                                //End of Commented & Added By Dipali V On 9th May 2023 For Arrow not display
                                strHTML += '</a>'
                                strHTML += '</td>'
                                strHTML += '</tr>'
                            }
                        }
                        strHTML += '<tr class="hiddenRow subCustomField collapse show-tbl" id="appliAdmin' + strResult[i].EmployeeID + '">'
                        strHTML += '<td colspan="6" class="accordian-body change-req-tbl collapse show in-tbl-td" aria-expanded="false">'
                        strHTML += '<table class="table table-bordered">'
                        strHTML += HeaderProjectApproval;
                        strHTML += '<tbody id=tbodyAlternateApprover' + strResult[i].PostID + '>'


                        for (var j = 0; j < strResult.length; j++) {
                            if (strResult[i].RoleDescription == strResult[j].RoleDescription) {
                                strHTML += '<tr><td></td>' //vishal <td></td>
                                strHTML += '<td>' + strResult[j].EmployeeName + '</td>'
                                strHTML += '<td>' + strResult[j].UserName + '</td>'
                                strHTML += '<td>' + strResult[j].BusinessGroup + '</td>'
                                strHTML += '<td>' + strResult[j].Location + '</td>'
                                strHTML += '<td class="inp-select">'
                                strHTML += '<div class="custom_chckbox">'
                                if (strResult[j].Selected == 1) {
                                    strHTML += '<input type="checkbox" id="AlternateApprover' + strResult[j].EmployeeID + '" class="projAppro-chck" checked>'
                                    strHTML += '<label for="AlternateApprover' + strResult[j].EmployeeID + '"></label>'
                                }
                                else {
                                    strHTML += '<input type="checkbox" id="AlternateApprover' + strResult[j].EmployeeID + '" class="projAppro-chck">'
                                    strHTML += '<label for="AlternateApprover' + strResult[j].EmployeeID + '"></label>'
                                }
                                strHTML += '</div>'
                                strHTML += '</td>'
                                strHTML += '</tr>'
                            }
                        }
                        strHTML += '</tbody>'
                        strHTML += '</table>'
                        strHTML += '</td>'
                        strHTML += '</tr>'
                        $("#tbodyProjectWorkflowAlternateApprover").append(strHTML);
                    }
                }
                //StopAjaxLoader("#bodyProjectWorkflow");
            }

            //Save the Alternate Approver Data
            $("#btnSaveProjectWorkflowAlternateApprover").click(function () {
                var strApproverID = ',';
                for (var i = 0; i < ProjectWorkflowAlternateApprovertbodyIdArray.length; i++) {
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", ProjectWorkflowAlternateApprovertbodyIdArray[i]);
                    for (var j = 0; j < CheckedcheckedBoxes.length; j++) {
                        var CheckboxId = CheckedcheckedBoxes[j].id;
                        strApproverID += CheckboxId.replace('AlternateApprover', '') + ',';
                    }
                }

                if (strApproverID == ',') {
                    alertify.error("<%= MyBase.GetResourceString("P_Please_select_at_least_one_Approver") %>");
                }
                else {
                    var ProjectWorkFlowParameter = {
                        strApproverID: encodeURI(strApproverID),
                        CreatedBy: encodeURI(UserName),
                        RequestStageID: encodeURI(GblProjectWorkflowRequestStageID),
                        NatureOfDemandID: encodeURI(GblProjectWorkflowProjectNatureofDemandID)
                    }
                    var param = JSON.stringify(ProjectWorkFlowParameter);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectWorkflow/SaveProjectWorkflowAlternateApprover", param, false);
                    if (strResult == null) {
                        alertify.success("Saved Project Approver successfully.");
                        GetProjectWorkflowStages(GblProjectWorkflowProjectNatureofDemandID, GblProjectWorkflowEntityID);
                    }
                }
            })


            //On change of Business group data should be filtered.
            $("#cboProjectWorkflowProjectApproversBusinessGroup").change(function () {
                var BusinessGroupID = this.value;
                var OrganizationUnitID = $("#cboProjectWorkflowProjectApproversOrganizationUnit").val();
                var RoleID = $("#cboProjectWorkflowProjectApproversRole").val();
                var AlternateApproverName = $("#ProjectWorkflowAlternateApproverSearch").val();
                if (BusinessGroupID == '' || BusinessGroupID == '0') {
                    BusinessGroupID = "NULL";
                }
                if (OrganizationUnitID == '' || OrganizationUnitID == '0') {
                    OrganizationUnitID = "NULL";
                }
                if (RoleID == '' || RoleID == '0') {
                    RoleID = "NULL";
                }
                if (AlternateApproverName == '') {
                    AlternateApproverName = "NULL";
                }
                ProjectWorkflowGetOrganizationUnitDropdownData(BusinessGroupID);
                ProjectWorkflowGetProjectApprovers(GblProjectWorkflowNatureOfDemandStageID, RoleID, BusinessGroupID, OrganizationUnitID, AlternateApproverName)
            })

            //on change of Organization Unit
            $("#cboProjectWorkflowProjectApproversOrganizationUnit").change(function () {
                var OrganizationUnitID = this.value;
                var BusinessGroupID = $("#cboProjectWorkflowProjectApproversBusinessGroup").val();
                var RoleID = $("#cboProjectWorkflowProjectApproversRole").val();
                var AlternateApproverName = $("#ProjectWorkflowAlternateApproverSearch").val();
                if (BusinessGroupID == '' || BusinessGroupID == '0') {
                    BusinessGroupID = "NULL";
                }
                if (OrganizationUnitID == '' || OrganizationUnitID == '0') {
                    OrganizationUnitID = "NULL";
                }
                if (RoleID == '' || RoleID == '0') {
                    RoleID = "NULL";
                }
                if (AlternateApproverName == '') {
                    AlternateApproverName = "NULL";
                }
                ProjectWorkflowGetProjectApprovers(GblProjectWorkflowNatureOfDemandStageID, RoleID, BusinessGroupID, OrganizationUnitID, AlternateApproverName)
            })


            //On change of Approver Role
            $("#cboProjectWorkflowProjectApproversRole").change(function () {
                var RoleID = this.value;
                var BusinessGroupID = $("#cboProjectWorkflowProjectApproversBusinessGroup").val();
                var OrganizationUnitID = $("#cboProjectWorkflowProjectApproversOrganizationUnit").val();
                var AlternateApproverName = $("#ProjectWorkflowAlternateApproverSearch").val();
                if (BusinessGroupID == '' || BusinessGroupID == '0') {
                    BusinessGroupID = "NULL";
                }
                if (OrganizationUnitID == '' || OrganizationUnitID == '0') {
                    OrganizationUnitID = "NULL";
                }
                if (RoleID == '' || RoleID == '0') {
                    RoleID = "NULL";
                }
                if (AlternateApproverName == '') {
                    AlternateApproverName = "NULL";
                }

                ProjectWorkflowGetProjectApprovers(GblProjectWorkflowNatureOfDemandStageID, RoleID, BusinessGroupID, OrganizationUnitID, AlternateApproverName)
            })

            $("#ProjectWorkflowAlternateApproverSearch").keyup(function () {
                var AlternateApproverName = this.value;
                var BusinessGroupID = $("#cboProjectWorkflowProjectApproversBusinessGroup").val();
                var OrganizationUnitID = $("#cboProjectWorkflowProjectApproversOrganizationUnit").val();
                var RoleID = $("#cboProjectWorkflowProjectApproversRole").val();
                if (BusinessGroupID == '' || BusinessGroupID == '0') {
                    BusinessGroupID = "NULL";
                }
                if (OrganizationUnitID == '' || OrganizationUnitID == '0') {
                    OrganizationUnitID = "NULL";
                }
                if (RoleID == '' || RoleID == '0') {
                    RoleID = "NULL";
                }
                if (AlternateApproverName == '') {
                    AlternateApproverName = "NULL";
                }
                ProjectWorkflowGetProjectApprovers(GblProjectWorkflowNatureOfDemandStageID, RoleID, BusinessGroupID, OrganizationUnitID, AlternateApproverName)
            })

            //To bind the data to the Organization unit dropdown
            function ProjectWorkflowGetOrganizationUnitDropdownData(BusinessGroupID) {
                var param = JSON.stringify(encodeURI(BusinessGroupID));
                var result = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowGetOrganizationUnitDropdownData", param, false);

                if (result != undefined) {
                    var objCbo1 = document.getElementById("cboProjectWorkflowProjectApproversOrganizationUnit");
                    $("#cboProjectWorkflowProjectApproversOrganizationUnit option").remove();
                    $("#cboProjectWorkflowProjectApproversOrganizationUnit").append('<option value="0">Select Organization Unit</option>');
                    for (var i = 0; i < result.length; i++) {
                        var ObjStatus = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.Location;
                        objOption.value = ObjStatus.LocationID;
                    }
                }
            }



            var ProjectWorkflowSelectStagesDataArray = new Array();
            function ProjectWorkflowSelectStagesData(NatureOfDemandID) {

                var WorkFlowName = ProjectWorkflowDefineRuleGetWorkflowName(NatureOfDemandID);
                $("#ProjectWorkflowSelectStagesWorkflowName").empty();
                $("#ProjectWorkflowSelectStagesWorkflowName").append(WorkFlowName);
                ProjectWorkflowSelectStagesDataArray.length = 0;

                var strHTML = '';
                var ResumeTimesheetEnableLink = false;
                var ResumeProjectEnableLink = false;
                var param = JSON.stringify(encodeURI(NatureOfDemandID));
                var result = AJAXCallWithResult("/api/PM_ProjectWorkflow/ProjectWorkflowSelectStagesData", param, false);

                for (var j = 0; j < result.length; j++) {
                    if (result[j].EnableTimesheetLink == 1) {
                        ResumeTimesheetEnableLink = true;
                    }
                    if (result[j].EnableOnHoldLink == 1) {
                        ResumeProjectEnableLink = true;
                    }
                }

                $("#tbodyProjectWorkflowSelectStages").empty();
                for (var i = 0; i < result.length; i++) {
                    strHTML = '';
                    strHTML += '<tr>'
                    strHTML += '<td>'
                    if (i == result.length - 1) {
                        if (result[i].Selected == 1) {
                            var ChecklistID = "#cboProjectWorkflowSelectStagesChecklist" + result[i].RequestStageID;
                            var StageData = result[i].RequestStageID + ":" + result[i].OrderNo + ":" + ChecklistID + ":" + result[i].CompletionDays;
                            ProjectWorkflowSelectStagesDataArray.push(StageData);
                        }
                        else {
                            var ChecklistID = 0;
                            var StageData = result[i].RequestStageID + ":" + result[i].OrderNo + ":" + ChecklistID + ":" + result[i].CompletionDays;
                            ProjectWorkflowSelectStagesDataArray.push(StageData);
                        }
                        // var StageData = result[i].RequestStageID + ":" + result[i].OrderNo + ":" + result[i].CompletionDays;
                        //ProjectWorkflowSelectStagesDataArray.push(StageData);
                        strHTML += '<input type="text" class="form-control" name="" value="" disabled>'
                    }
                    else if (result[i].OrderNo != null && i != result.length - 1) {
                        if (result[i].Selected == 1) {
                            var ChecklistID = "#cboProjectWorkflowSelectStagesChecklist" + result[i].RequestStageID;
                            var StageData = result[i].RequestStageID + ":" + result[i].OrderNo + ":" + ChecklistID + ":" + result[i].CompletionDays;
                            ProjectWorkflowSelectStagesDataArray.push(StageData);
                        }
                        else {
                            var ChecklistID = 0;
                            var StageData = result[i].RequestStageID + ":" + result[i].OrderNo + ":" + ChecklistID + ":" + result[i].CompletionDays;
                            ProjectWorkflowSelectStagesDataArray.push(StageData);
                        }
                        //var StageData = result[i].RequestStageID + ":" + result[i].OrderNo + ":" + result[i].CompletionDays;
                        //ProjectWorkflowSelectStagesDataArray.push(StageData);
                        strHTML += '<input type="text" class="form-control" name="" value="' + result[i].OrderNo + '" disabled>'
                    }
                    else {
                        strHTML += '<input type="text" class="form-control" name="" value="">'
                    }
                    strHTML += '</td>'
                    strHTML += '<td>' + result[i].RequestStage + '</td>'
                    strHTML += '<td>'
                    if (result[i].Selected == 1) {
                        var inputTemplateName = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowSelectStagesChecklist", "usp_sel_tbl_Q_Questionnaire",,,, True, True, "form-select",,,, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputTemplateName = inputTemplateName.replace(/cboProjectWorkflowSelectStagesChecklist/g, "cboProjectWorkflowSelectStagesChecklist" + result[i].RequestStageID);
                    if (result[i].CheckListID != 0 && result[i].CheckListID != null) {
                        $("#cboProjectWorkflowSelectStagesChecklist" + result[i].RequestStageID).val(result[i].CheckListID);
                    }
                    strHTML += inputTemplateName;
                    <%--strHTML += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowSelectStagesChecklist", "usp_sel_tbl_Q_Questionnaire",,,, True, True, "form-control",,,, TabIndex:=1).ToString.Replace("'", "\'")%>'--%>
                }
                else {
                    var inputTemplateName = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowSelectStagesChecklist", "usp_sel_tbl_Q_Questionnaire",,,, True, True, "form-select disabled",,,, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputTemplateName = inputTemplateName.replace(/cboProjectWorkflowSelectStagesChecklist/g, "cboProjectWorkflowSelectStagesChecklist" + result[i].RequestStageID);
                    strHTML += inputTemplateName;
                    <%--strHTML += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboProjectWorkflowSelectStagesChecklist", "usp_sel_tbl_Q_Questionnaire",,,, True, True, "form-control disabled",,,, TabIndex:=1).ToString.Replace("'", "\'")%>'--%>
                    }

                    strHTML += '</td>'
                    if (ResumeTimesheetEnableLink == false) {
                        $("#theadProjectWorkflowStageResumeTimesheetLink").hide();
                    }
                    if (ResumeTimesheetEnableLink == true) {
                        $("#theadProjectWorkflowStageResumeTimesheetLink").show();
                        strHTML += '<td class="inp-select">'
                        strHTML += '<div class="custom_chckbox">'
                        if (result[i].EnableTimesheetLink == 1) {
                            strHTML += '<input type="checkbox" id="StageResumeTimesheet' + result[i].RequestStageID + '" class="chckHead" checked disabled="disabled">'
                            strHTML += '<label for="StageResumeTimesheet' + result[i].RequestStageID + '" style="cursor:NO-DROP !important;"></label>'
                        }
                        else {
                            strHTML += '<input type="checkbox" id="StageResumeTimesheet' + result[i].RequestStageID + '" class="chckHead" disabled="disabled">'
                            strHTML += '<label for="StageResumeTimesheet' + result[i].RequestStageID + '" style="cursor:NO-DROP !important;"></label>'
                        }
                        strHTML += '</div>'
                        strHTML += '</td>'
                    }
                    if (ResumeProjectEnableLink == false) {
                        $("#theadProjectWorkflowStageResumeProjectLink").hide();
                    }
                    if (ResumeProjectEnableLink == true) {
                        $("#theadProjectWorkflowStageResumeProjectLink").show();
                        strHTML += '<td class="inp-select">'
                        strHTML += '<div class="custom_chckbox">'
                        if (result[i].EnableOnHoldLink == 1) {
                            strHTML += '<input type="checkbox" id="StageResumeProject' + result[i].RequestStageID + '" class="chckHead" checked disabled="disabled">'
                            strHTML += '<label for="StageResumeProject' + result[i].RequestStageID + '" style="cursor:NO-DROP !important;"></label>'
                        }
                        else {
                            strHTML += '<input type="checkbox" id="StageResumeProject' + result[i].RequestStageID + '" class="chckHead" disabled="disabled">'
                            strHTML += '<label for="StageResumeProject' + result[i].RequestStageID + '" style="cursor:NO-DROP !important;"></label>'
                        }
                        strHTML += '</div>'
                        strHTML += '</td>'
                    }

                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    if (result[i].OrderNo != null) {
                        strHTML += '<input type="checkbox" id="sltStageschck' + result[i].RequestStageID + '" class="chckHead" checked disabled="disabled">'
                        strHTML += '<label for="sltStageschck' + result[i].RequestStageID + '" style="cursor:NO-DROP !important;"></label>'
                    }
                    else {
                        strHTML += '<input type="checkbox" id="sltStageschck' + result[i].RequestStageID + '" class="chckHead" disabled>'
                        strHTML += '<label for="sltStageschck' + result[i].RequestStageID + '" style="cursor:NO-DROP !important;"></label>'
                    }

                    strHTML += '</div>'
                    strHTML += '</td>'

                    strHTML += '</tr>'
                    $("#tbodyProjectWorkflowSelectStages").append(strHTML);

                    if (result[i].CheckListID != 0 && result[i].CheckListID != null) {
                        $("#cboProjectWorkflowSelectStagesChecklist" + result[i].RequestStageID).val(result[i].CheckListID);
                    }
                }
            }


            $("#btnSaveProjectWorkflowSelectStages").click(function () {
                var strStageID = '';
                var strOrderNo = '';
                var strChecklist = '';
                var strCompletionDays = '';
                for (var i = 0; i < ProjectWorkflowSelectStagesDataArray.length; i++) {
                    var TempVar = ProjectWorkflowSelectStagesDataArray[i];
                    var StageData = TempVar.split(':');
                    strStageID += StageData[0] + ',';
                    strOrderNo += StageData[1] + ',';
                    if (StageData[2] != 0) {
                        strChecklist += $(StageData[2]).val() + ',';
                    }
                    else {
                        strChecklist += StageData[2] + ',';
                    }
                    strCompletionDays += StageData[3] + ',';
                }

                strStageID = strStageID.slice(0, -1);
                strOrderNo = strOrderNo.slice(0, -1);
                strChecklist = strChecklist.slice(0, -1);
                strCompletionDays = strCompletionDays.slice(0, -1);
                var ProjectWorkFlowParameter = {
                    NatureOfDemandID: encodeURI(GblProjectWorkflowProjectNatureofDemandID),
                    strStageID: encodeURI(strStageID),
                    strOrderNo: encodeURI(strOrderNo),
                    strChecklist: encodeURI(strChecklist),
                    strCompletionDays: encodeURI(strCompletionDays),
                    CreatedBy: encodeURI(UserName)
                }
                var param = JSON.stringify(ProjectWorkFlowParameter);
                var result = AJAXCallWithResult("/api/PM_ProjectWorkflow/SaveProjectWorkflowSelectStageData", param, false);
                if (result == null) {
                    alertify.success("Saved stages successfully.");
                }
            })


            var ajaxResult;
            function AJAXCallWithResult(url, param, async) {
                $.ajax({
                    url: encodeURI(strUrl + url),
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
                        ajaxResult = undefined;
                    }
                });
                return ajaxResult;
            }



            $("#InheritworkflowSLTAll").click(function () {
                $(".chckInheritWorkFlowattri").prop('checked', $(this).prop('checked'));
            });

            $(".chckInheritWorkFlowattri").change(function () {
                var rowCount = $("#tbodyProjectWorkflowInheritWorkflows > tr").length;
                var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowInheritWorkflows");

                if (rowCount == CheckedcheckedBoxes.length) {
                    $("#InheritworkflowSLTAll").prop('checked', true);
                }
                if (!$(this).prop("checked")) {
                    $("#InheritworkflowSLTAll").prop("checked", false);
                }
            });


            $("#workflowSLTAll").click(function () {
                $(".projAppro-chck").prop('checked', $(this).prop('checked'));
            });

            $(".projAppro-chck").change(function () {
                if (!$(this).prop("checked")) {
                    $("#workflowSLTAll").prop("checked", false);
                }
            });
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
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
          //End by imran on 10-01-2022
        </script>
    </div>
</body>

</html>
