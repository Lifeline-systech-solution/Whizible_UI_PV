<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_DeliverableSettings.aspx.vb" Inherits="PbNIT.PM_DeliverableSettings" %>

<!DOCTYPE html>

<html>
     <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
      <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head runat="server">
<%--    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
  
   <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />

<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>


    
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

        #tblpcdsDeliverableSettings {
            margin: 0 auto 20px;
            width: 97%;
        }

        .lblcrsr {
            cursor: not-allowed !important;
        }

        .modal-body .note-wrap-txt {
            width: 100% !important;
        }

        #CloseableAlert .close {
            float: right;
            border: none;
        }

        .modal-title {
    margin: 0;
    font-weight: 400;
    font-size: 14px!important;
    /* Modified By Madhuri.K On 01-04-2026 */
}
        .h5, h5 {
    font-size: 14px;
    /* Modified By Madhuri.K On 01-04-2026 */
}

        .ClosaeblealertMsg{ display:none;}
.alert .close {
    color: #fff;
    opacity: 1;
    float: right;
    font-size: 16px; background:none; border:none;
}

    </style>
<body id="pcdsBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divDeliverableSettings">
        <div class="tab-pane pstbl_custom pt-0 practicesettinglist in active" id="pstbl_doc_cat">
            <div class="modalpgHead pt-1 pb-1 col-sm-12"><%= MyBase.GetResourceString("C_DeliverableSettings") %></div>

            <div class=" pt-1 pb-1 col-sm-12 px-3 text-end clearfix">
                <h5 class="float-start pt-2">Project Name : <span id="ProjectName"></span></h5>
                <div class="text-end">
                    <button class="btn borderbtn mr-5" id="btnpcdsAddPopup" data-bs-toggle="modal" data-bs-target="#addDevelopModal"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                    <%--removed data-target by ashwini on 23-3-2023--%>
                  <%--  Commeted & Added By Dipali V On 27th March 2023 For Modal pop up issue--%>
                  <%--  <button class="btn borderbtn mr-5" id="btnpcdsConfirmDelete" data-bs-toggle="modal"><%= MyBase.GetResourceString("C_Delete") %></button>--%>
                     <button class="btn borderbtn mr-5" id="btnpcdsConfirmDelete" ><%= MyBase.GetResourceString("C_Delete") %></button>
                    <%--removed data-target End Of added by ashwini On 23-3-2023--%>
                    <%-- End of  Commeted & Added By Dipali V On 27th March 2023 For Modal pop up issue--%>
                </div>
            </div>

            <table id="tblpcdsDeliverableSettings" class="table table-stripped table-bordered">
            </table>
        </div>

        <!--Page modal start here-->

        <!--Add Deliverable Settings modal start here-->
        <div class="modal custmodal fade" id="addDevelopModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_DeliverableSettingsA") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group mb-3">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_DeliverableTypeA") %><span style="color: red">*</span> </label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcdscboDeliverableTypeA", "Select 0,'--select--' ",,, "class='form-select'", False,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcdscboDeliverableTypeA", "usp_Whizible2_Sel_tbl_PM_CompanySchedule " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", True,,,,, ) %>--%>
                                <%--Commented By Omkar P On 21/12/2019--%>
                                <%--<span class="sm-font"><%= MyBase.GetResourceString("C_NoteA") %></span>--%>
                                <%--End Commented By Omkar P On 21/12/2019--%>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_IssueTypesA") %><span style="color: red">*</span> </label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcdscboIssueTypeA", "Select 0,'--select--' ",,, "class='form-select'", False,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcdscboIssueTypeA", "usp_Whizible2_Sel_tbl_IB_Type_ForDeliverableSettings " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", True,,,,, ) %>--%>
                                <!-- Added by omkar on 21/12/2019 -->
                            <span class="sm-font"><%= MyBase.GetResourceString("C_NoteA") %></span>
                            <!-- End Of Added by omkar on 21/12/2019 -->
                            </div>
                        </div>
                        <div class="row form-group mb-3">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_ExecutionTemplateA") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcdscboExecutionTemplateA", "Select 0,'--select--' ",,, "class='form-select'", False,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcdscboExecutionTemplateA", "usp_Whizible2_Sel_tbl_PRS_PhaseTask_Template_List " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", True,,,,, ) %>--%>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_StartingSerialNumberA") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("pcdstxtStartingSerialNumberA", "pcdstxtStartingSerialNumberA", "text-field",, 8,,,,,,,,,,,,,,, True) %>
                            </div>
                        </div>
                        <div class="btn-grp-new">
                            <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" id="btnpcdsAdd" class="btn btnyellow"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add Deliverable Settings modal end here-->

        <!--save Deliverable Settings modal start here-->
        <div class="modal custmodal fade" id="saveDevelopModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_DeliverableSettingsA") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_DeliverableTypeA") %><span style="color: red">*</span> </label>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcdscboDeliverableTypeS", "Select 0,'--select--' ",,, "class='form-control'", True,, ) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcdscboDeliverableTypeS", "usp_Whizible2_Sel_tbl_PM_CompanySchedule",,, "class='form-select'", True,,,,, ) %>

                                
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_IssueTypesA") %><span style="color: red">*</span> </label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcdscboIssueTypeS", "Select 0,'--select--' ",,, "class='form-select'", False,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcdscboIssueTypeS", "usp_Whizible2_Sel_tbl_IB_Type_ForDeliverableSettings " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", False,,,,, ) %>--%>
                                <span class="sm-font"><%= MyBase.GetResourceString("C_NoteA") %></span>
                            </div>
                        </div>
                        <%--added by ashwini on 23-3-2023--%>
                        <div class="row form-group mb-3">
                            <%--End Of added by ashwini On 23-3-2023--%>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_ExecutionTemplateA") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcdscboExecutionTemplateS", "Select 0,'--select--' ",,, "class='form-select'", False,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcdscboExecutionTemplateS", "usp_Whizible2_Sel_tbl_PRS_PhaseTask_Template_List " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", True,,,,, ) %>--%>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_StartingSerialNumberA") %></label>

                                <% CommonFunctions.HTMLControls.DrawTextBox("pcdstxtStartingSerialNumberS", "pcdstxtStartingSerialNumberS", "text-field",, 8,,,,,,,, "onkeypress='return restrictAlphabets(event, &quot;srno&quot;)'",,,,,,, True) %>
                            </div>
                        </div>
                        <div class="btn-grp-new">
                            <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" id="btnpcdsSave" class="btn btnyellow"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--save Deliverable Settings modal end here-->

        <!--Set Access modal start here-->
        <div class="modal custmodal fade" id="setAccModal" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ResourceAccessB") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="right-side-save">
                                <a href="#" id="btnpcdsRefresh" class="btn borderbtn"><%= MyBase.GetResourceString("C_RefreshB") %></a>
                            </div>
                            <div class="note-wrap note-wrap-txt">
                                <p><%= MyBase.GetResourceString("C_NoteB") %></p>
                            </div>
                            <table id="tblpcdsResourceAccess" class="table table-stripped table-bordered">
                            </table>
                        </div>
                        <div class="btn-grp-new">
                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" id="btnpcdsResourceSave" class="btn btnyellow"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Set Access modal end here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdeldeliverableModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ConfirmDelete") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5 class="mb-3">
                                <center><%= MyBase.GetResourceString("C_AL_ConfirmDelete") %></center>
                            </h5>
                        </div>
                        
                       <%-- <center>
                        <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        <button data-bs-dismiss="modal" id="btnpcdsdelete" class="btn btnyellow ml-1"><%= MyBase.GetResourceString("C_Okay") %></button>
                    </center>--%>
                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button id="btnpcdsdelete" class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Delete_new_Sub_tasktype_modal_end_here-->

        <!--Page modal end here-->

        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" style="top: 10px">
            <button type="button" onclick="CloseShowAlert()" class="close">×</button>
            <p id="alertMsg"></p>
        </div>

        <!-- REQUIRED JS SCRIPTS -->
        <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->

        <%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>     
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            EmployeeID = '<%= Session("intUserID") %>';
            UserName = '<%= Session("strUserName") %>';
        <%--ProjectID = '<%= Session("intProjectID") %>';--%>
            //let searchParams = new URLSearchParams(window.location.search);
            //var ProjectID = searchParams.get('ProjectID');
            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
            ProjectName = '<%= Session("strProjectName") %>';

            var AddAccess = '<%= m_AddAccess %>';
            var EditAccess = '<%= m_EditAccess %>';
            var DeleteAccess = '<%= m_DeleteAccess %>';
            var colspn;
            var UniqueID;
            var ScheduleTypeID;
            var m_PKToken = "";
            var cntProjectDeliverableSettingsRole = 0;
            var ViewAccess = "<%= m_ViewAccess %>";

            $(document).ready(function () {
                ProjectDeliverableSettingsActions();
                //Added By Omkar P On 21/12/2019
                $("#pcdstxtStartingSerialNumberA").val(1);
                //End Of Added By Omkar P On 21/12/2019
            });
            
            $("#btnpcdsConfirmDelete").click(function () {
                var delds = [];
                $.each($("input[name='delsetdelete']:checked"), function () {
                    delds.push($(this).val());
                });
                if (delds.join(",") == "") {
                    $('#btnpcdsConfirmDelete').removeAttr('data-bs-target', '#CPdeldeliverableModal');
                    showAlert('<%= MyBase.GetResourceString("C_AL_DSDeleteSelect") %>', 'alert-danger');
                }
                else {
                    //Commented & Added By Dipali V On 27th March 2023 For Model Issue should open on 1st click
                    //$('#btnpcdsConfirmDelete').attr('data-bs-target', '#CPdeldeliverableModal');
                    $('#CPdeldeliverableModal').modal('show');
                    //End of Commented & Added By Dipali V On 27th March 2023 For Model Issue should open on 1st click
                }
            });
            function restrictAlphabets(e, flag, curId) {
                //debugger;

                var x = e.which || e.keycode;

                if (flag == "resource" || flag == "zipcode" || flag == "weekdays" || flag == "fax"|| flag == "srno") {
                    if ((x >= 48 && x <= 57) || x == 8 ||
                        (x >= 35 && x <= 40))
                        return true;
                    else
                        return false;
                }
                else {
                    if ((x >= 48 && x <= 57) || x == 8 ||
                        (x >= 35 && x <= 40) || x == 46)
                        return true;
                    else
                        return false;
                }
            }
             //add by omkar 31/12/2019 for Head / main check box checked or unchecked
            function HeadCheckBoxChecked() {
                var rowCount = $("#tbodySetResourceAccess > tr > td>div>input[type=checkbox]").length;
                var CheckedcheckedBoxes = $("#tbodySetResourceAccess > tr > td>div>input[type=checkbox]:checked").length;
                if (rowCount == CheckedcheckedBoxes && rowCount > 0) {
                    $("#tblpcdsResourceAccess > thead > tr > th.inp-select > div>input#resAccSltAll").prop('checked', true);
                }
                else {
                    $("#tblpcdsResourceAccess > thead > tr > th.inp-select > div>input#resAccSltAll").prop("checked", false);
                }
            }
            //end of add by omkar 31/12/2019 for Head / main check box checked or unchecked
            function ProjectDeliverableSettingsActions() {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divDeliverableSettings").html(bodyHTML);
                    return;
                }
                StartLoader("#pcdsBodyID")

                GetProjectName();
                setHTML = '';

                GetProjectDeliverableType();
                GetProjectIssueTypes();
                //Commented And Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id
                //GetExecutionTemplateData();
                GetExecutionTemplateData(0);
                //Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id

                if (AddAccess == "False") {
                    //Commented and Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                    //$("#btnpcdsAddPopup").attr("disabled", true);
                    $("#btnpcdsAddPopup").hide();
                    //End of addition By Chetan M.
                    $("#btnpcdsAdd").hide();

                    $("#btnpcdsAddPopup").addClass("lblcrsr");
                }
                else {
                    $("#btnpcdsAdd").show();
                    $('#btnpcdsAddPopup').attr('data-bs-target', '#addDevelopModal');
                }
                if (DeleteAccess == "False") {
                    //Commented and Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                    //$("#btnpcdsConfirmDelete").attr("disabled", true);
                    $("#btnpcdsConfirmDelete").hide();
                    //End of addition By Chetan M.
                    $("#btnpcdsConfirmDelete").addClass("lblcrsr");
                    $("#btnpcdsdelete").hide();
                    colspn = 5;
                }
                else {
                    $("#btnpcdsdelete").show();
                    colspn = 6;
                }
                if (ProjectID != "") {
                    var taskParameters_dsl = {
                        intProjectID: encodeURI(ProjectID),
                        Command: encodeURI('GETDL')
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/ProjectDeliverableSettingsActions',
                        type: "POST",
                        data: JSON.stringify(taskParameters_dsl),
                        dataType: "json",
                        async: false,
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (taskParameters_dsl) {
                                xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dsl) ? taskParameters_dsl : JSON.stringify(taskParameters_dsl)));
                            }
                        },
                        success: function (data) {
                            setHTML += '<thead>'
                            setHTML += '     <tr>'
                            setHTML += '         <th><%= MyBase.GetResourceString("C_DeliverableTypeHead") %></th>'
                        setHTML += '         <th><%= MyBase.GetResourceString("C_CodeTemplateHead") %></th>'
                        setHTML += '         <th><%= MyBase.GetResourceString("C_IssueTypeHead") %></th>'
                        setHTML += '         <th><%= MyBase.GetResourceString("C_ExecutionTemplateHead") %></th>'
                        setHTML += '         <th><%= MyBase.GetResourceString("C_SetResourceAccessHead") %></th>'
                        if (DeleteAccess == "True") {
                            setHTML += '         <th class="inp-select">'
                            setHTML += '             <div class="custom_chckbox">'
                            setHTML += '                 <input type="checkbox" id="delSettSltAll" class="chckHead">'
                            setHTML += '                 <label for="delSettSltAll"></label>'
                            setHTML += '             </div>'
                            setHTML += '         </th>'
                        }
                        setHTML += '     </tr>'
                        setHTML += '</thead>'
                        setHTML += '<tbody id="tbodyProjectDeliverableSetting">'
                        if (data.length != 0) {
                            for (var i = 0; i < data.length; i++) {
                                console.log(data);
                                var d = data[i];
                                setHTML += '<tr>'
                                setHTML += '<td>'
                                if (EditAccess == "False") {
                                    setHTML += d.LabelSchedule
                                }
                                else {
                                    //setHTML += '<a href = "javascript:;" data-bs-toggle="modal" onclick = setDeliverableType(' + d.ScheduleID + ', "' + replaceChar(d.IssueType, ' ', '&#32;') + '", ' + d.TemplateID + ', ' + d.SerialNo + ', ' + d.UniqueID + ') data-bs-target="#saveDevelopModal" > ' + d.LabelSchedule + '</a >'
                                    //Commented And Added By Usha Pandit On 12.06.2020 For escaping quotes instring
                                    //setHTML += '<a href = "javascript:;" onclick = setDeliverableType(' + d.ScheduleID + ',&#39;' + replaceChar(d.IssueType, ' ', '&#32;') + '&#39;,' + d.TemplateID + ',' + d.SerialNo + ',' + d.UniqueID + ')>' + d.LabelSchedule + '</a >'
                                    var curIssueType = d.IssueType.toString().replace(/'/g, "\\'");
                                    //Commented And Added by Usha Pandit On 14.08.2020 as not getting complete text if contains space
                                    //setHTML += '<a href = "javascript:;" onclick = setDeliverableType(' + d.ScheduleID + ',' + '&quot;' + curIssueType + '&quot;' + ',' + d.TemplateID + ',' + d.SerialNo + ',' + d.UniqueID + ')>' + d.LabelSchedule + '</a >';
                                    setHTML += '<a href = "javascript:;" onclick = "setDeliverableType(' + d.ScheduleID + ',' + '&quot;' + curIssueType + '&quot;' + ',' + d.TemplateID + ',' + d.SerialNo + ',' + d.UniqueID + ')">' + d.LabelSchedule + '</a >';
                                    //End Of Added by Usha Pandit On 14.08.2020 as not getting complete text if contains space
                                    //End Of Added By Usha Pandit On 12.06.2020 For escaping quotes instring

                                }
                                setHTML += '</td > '
                                setHTML += '<td><xmp style="margin-top: 0px;margin-bottom: 0px;white-space:pre-wrap!important">' + d.CodeTemplate + '</xmp></td>'
                                setHTML += '<td>' + d.IssueType + '</td>'
                                setHTML += '<td>' + d.TemplateName + '</td>'
                                setHTML += '<td>'
                                if (EditAccess == "False") {
                                    setHTML += d.Hyperlink1
                                } else {
                                    setHTML += '<a href="javascript:;" data-bs-toggle="modal" onclick=ProjectDeliverableSettingsRole(' + d.ScheduleID + ') data-bs-target="#setAccModal">' + d.Hyperlink1 + '</a>'
                                }
                                setHTML += '</td>'
                                if (DeleteAccess == "True") {
                                    setHTML += '<td class="inp-select text-center">'
                                    setHTML += '    <div class="custom_chckbox">'
                                    setHTML += '        <input type="checkbox" id="comerSlt' + d.UniqueID + '" class="chckHead doc-chck" name="delsetdelete" value="' + d.UniqueID + '">'
                                    setHTML += '        <label for="comerSlt' + d.UniqueID + '"></label>'
                                    setHTML += '    </div>'
                                    setHTML += '</td>'
                                }
                                setHTML += '</tr>'
                            }
                        }
                        else {                            
                            setHTML += '<tr><td colspan="' + colspn + '"><span class="text-center"><%= MyBase.GetResourceString("C_AL_NoItem") %></span></td></tr>';
                            }
                            setHTML += '</tbody>'
                            $("#tblpcdsDeliverableSettings").html(setHTML);
                            return false;
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
                else {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=SessionLost"
                }

                $("#delSettSltAll").click(function () {
                    $(".doc-chck").prop('checked', $(this).prop('checked'));
                });

                $(".doc-chck").change(function () {
                    var rowCount = $("#tbodyProjectDeliverableSetting > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectDeliverableSetting");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#delSettSltAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#delSettSltAll").prop("checked", false);
                    }
                });

                StopAjaxLoader("#pcdsBodyID")

            }

            function ProjectDeliverableSettingsRole(schtid) {
                cntProjectDeliverableSettingsRole = 0;
                if (EditAccess == "True") {
                    ScheduleTypeID = schtid;
                    StartLoader("#pcdsBodyID")
                    setHTML = '';
                    if (ProjectID != "") {
                        var taskParameters_dsrfl = {
                            intProjectID: encodeURI(ProjectID),
                            intScheduleTypeID: schtid,
                            Command: encodeURI('GETRF')
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/ProjectDeliverableSettingsActions',
                            type: "POST",
                            data: JSON.stringify(taskParameters_dsrfl),
                            dataType: "json",
                            async: false,
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_dsrfl) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dsrfl) ? taskParameters_dsrfl : JSON.stringify(taskParameters_dsrfl)));
                                }
                            },
                            success: function (data) {
                                console.log(data);
                                setHTML += '<thead>'
                                setHTML += '    <tr>'
                                setHTML += '        <th><%= MyBase.GetResourceString("C_RoleHeadB") %></th>'
                                setHTML += '        <th><%= MyBase.GetResourceString("C_ResourceHeadB") %></th>'
                                setHTML += '        <th class="inp-select">'
                                setHTML += '            <div class="custom_chckbox">'
                                setHTML += '                <input type="checkbox" id="resAccSltAll" class="chckHead">'
                                setHTML += '                <label for="resAccSltAll"></label>'
                                setHTML += '            </div>'
                                setHTML += '        </th>'
                                setHTML += '    </tr>'
                                setHTML += '</thead>'
                                setHTML += '<tbody id="tbodySetResourceAccess">'
                                cntProjectDeliverableSettingsRole = data.length;
                                if (data.length != 0) {
                                    for (var i = 0; i < data.length; i++) {
                                        var d = data[i];
                                        setHTML += '<tr>'
                                        setHTML += '    <td>' + d.RoleDescription + '</td>'
                                        setHTML += '    <td>' + d.UserName + '</td>'
                                        setHTML += '<td class="inp-select text-center">'
                                        setHTML += '    <div class="custom_chckbox">'
                                        setHTML += '        <input type="checkbox" id="innrcomerSlt' + d.UniqueID + '" class="chckHead chkresourceaccess" value="' + d.UniqueID + '" name="resourceaccess" checked=true>'
                                        setHTML += '        <label for="innrcomerSlt' + d.UniqueID + '"></label>'
                                        setHTML += '    </div>'
                                        setHTML += '</td>'
                                        setHTML += '</tr>'
                                    }
                                }
                                else {
                                    setHTML += '<tr><td colspan="' + colspn + '"><span class="text-center"><%= MyBase.GetResourceString("C_NoItems") %></span></td></tr>';
                                }
                                setHTML += '</tbody>'
                                $("#tblpcdsResourceAccess").html(setHTML);
                                return false;
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=SessionLost"
                    }

                    $("#resAccSltAll").click(function () {
                        $(".chkresourceaccess").prop('checked', $(this).prop('checked'));
                    });

                    $(".chkresourceaccess").change(function () {
                        var rowCount = $("#tbodySetResourceAccess > tr").length;
                        var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodySetResourceAccess");
                        if (rowCount == CheckedcheckedBoxes.length) {
                            $("#resAccSltAll").prop('checked', true);
                        }
                        if (!$(this).prop("checked")) {
                            $("#resAccSltAll").prop("checked", false);
                        }
                    });


                    StopAjaxLoader("#pcdsBodyID")
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
                // Add by omkar 31/12/2019 for main check box checked
                HeadCheckBoxChecked();
                //end of Add by omkar 31/12/2019 for main check box checked
            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_DeliverableSettings%>'&Mode=Edit&update=done";                        
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_DeliverableSettings%>');
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
            function GetProjectName() {
                $("#ProjectName").empty();
                var Parameter = { ProjectId: ProjectID }
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_ProjectSettings/GetProjectName'),
                    type: "POST",
                    data: JSON.stringify(Parameter),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Parameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                        }
                    },
                    success: function (result) {
                        if (result != null) {
                            $("#ProjectName").text(result);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

            $('#btnpcdsRefresh').click(function () {

                if (EditAccess == "True") {
                    var taskParameters_dref = {
                        intScheduleTypeID: encodeURI(ScheduleTypeID),
                        intProjectID: encodeURI(ProjectID),
                        CreatedBy: encodeURI(UserName)
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/ProjectDeliverableSettingsResourceAccess',
                        type: "POST",
                        data: JSON.stringify(taskParameters_dref),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (taskParameters_dref) {
                                xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dref) ? taskParameters_dref : JSON.stringify(taskParameters_dref)));
                            }
                        },
                        success: function (data) {
                            showAlert('<%= MyBase.GetResourceString("C_AL_Refresh") %>', 'alert-success');
                        ProjectDeliverableSettingsRole(ScheduleTypeID);
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });

            $('#btnpcdsResourceSave').click(function () {
                
                if (EditAccess == "True") {
                    if (cntProjectDeliverableSettingsRole != 0) {
                        var saveds = [];
                        $.each($("input[name='resourceaccess']:checked"), function () {
                            saveds.push($(this).val());
                        });
                        var taskParameters_drv = {
                            intScheduleTypeID: encodeURI(ScheduleTypeID),
                            intProjectID: encodeURI(ProjectID),
                            UniqueIDs: encodeURI(saveds.join(","))
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/ProjectDeliverableSettingsResourceSave',
                            type: "POST",
                            data: JSON.stringify(taskParameters_drv),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_drv) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_drv) ? taskParameters_drv : JSON.stringify(taskParameters_drv)));
                                }
                            },
                            success: function (data) {
                                showAlert('<%= MyBase.GetResourceString("C_AL_RAResorceAccessSaved") %>', 'alert-success');
                                ProjectDeliverableSettingsRole(ScheduleTypeID);
                                $('#setAccModal').modal('toggle');
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_No_AL_RAResorceAccessSaved") %>', 'alert-danger');
                    }
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });

            $("#btnpcdsdelete").click(function () {

                if (DeleteAccess == "True") {
                    var delds = [];
                    $.each($("input[name='delsetdelete']:checked"), function () {
                        delds.push($(this).val());
                    });

                    if (delds.join(",") != "") {
                        var taskParameters_del = {
                            UniqueIDs: encodeURI(delds.join(",")),
                            intProjectID: encodeURI(ProjectID)
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/ProjectDeliverableSettingsDelete',
                            type: "POST",
                            data: JSON.stringify(taskParameters_del),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_del) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_del) ? taskParameters_del : JSON.stringify(taskParameters_del)));
                                }
                            },
                            success: function (data) {
                               // debugger;
                                if (data[0].ack == "success") {
                                    showAlert(data[0].strResult, 'alert-success');
                                    ProjectDeliverableSettingsActions();
                                    refreshMyParent();
                                } else if (data[0].ack == "error") {//Added By Dipali V On 11th May 2020 For ISSUEOD= 24094
                                    showAlert(data[0].strResult, 'alert-danger');
                                    ProjectDeliverableSettingsActions();
                                    refreshMyParent();
                                }//End of Added By Dipali V On 11th May 2020 For ISSUEOD= 24094
                                else {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_DSDeleteFailed") %>', 'alert-danger');
                                }
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_AL_DSDeleteSelect") %>', 'alert-danger');
                    }
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });

            function setDeliverableType(sid, ity, tid, sno, uid) {
                $('#pcdscboDeliverableTypeS').val(sid);
                $("#pcdscboDeliverableTypeS").prop("disabled", true);
               
                $('#pcdscboIssueTypeS').val(ity);
                if (tid == null) {
                    $('#pcdscboExecutionTemplateS').val(0);
                }
                else {
                    $('#pcdscboExecutionTemplateS').val(tid);
                }
                
                $('#pcdstxtStartingSerialNumberS').val(sno);
                UniqueID = uid;
                $('#saveDevelopModal').modal('toggle');
                //Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id
                GetExecutionTemplateData(UniqueID);
                //End Of Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id

                //Added By Usha Pandit On 14.08.2020 For selecting correct template
                if (tid == null) {
                    $('#pcdscboExecutionTemplateS').val(0);
                }
                else {
                    $('#pcdscboExecutionTemplateS').val(tid);
                }
                //End Of Added By Usha Pandit On 14.08.2020 For selecting correct template
            }
            $("#btnpcdsSave").click(function () {
                //Commented And Added By Usha Pandit On 23.10.2020 For validation issue
                //if ($("#pcdscboIssueTypeS").val() == "") {
                //    showAlert('Issue Type should not be left blank.', 'alert-danger');
                //    $("#pcdscboIssueTypeS").focus();
                //}
                if ($("#pcdscboIssueTypeS").val() == "" || $("#pcdscboIssueTypeS").val() == "0") {
                    showAlert('Issue Type should not be left blank.', 'alert-danger');
                    $("#pcdscboIssueTypeS").focus();
                }
                //Commented And Added By Usha Pandit On 23.10.2020 For validation issue
                else {
                    if (EditAccess == "True") {
                        
                        var taskParameters_dsv = {
                            intProjectID: encodeURI(ProjectID),
                            IssueType: encodeURI($('#pcdscboIssueTypeS').val()),
                            intTemplateID: encodeURI($('#pcdscboExecutionTemplateS').val()),
                            intSerialNo: encodeURI($('#pcdstxtStartingSerialNumberS').val()),
                            intUniqueID: encodeURI(UniqueID),
                            Command: encodeURI('PUT')
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/ProjectDeliverableSettingsActions',
                            type: "POST",
                            data: JSON.stringify(taskParameters_dsv),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_dsv) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dsv) ? taskParameters_dsv : JSON.stringify(taskParameters_dsv)));
                                }
                            },
                            success: function (data) {
                                if (data[0].ack == "UPD") {                                    
                                    //Commented And Added By Usha Pandit On 11.06.2020 For rephrasing alert
                                    <%--showAlert('<%= MyBase.GetResourceString("C_AL_DSUpdated") %>', 'alert-success');--%>
                                    showAlert('Deliverable Type updated successfully', 'alert-success');
                                    //End Of Added By Usha Pandit On 11.06.2020 For rephrasing alert
                                ProjectDeliverableSettingsActions();
                            } else {
                                showAlert('<%= MyBase.GetResourceString("C_AL_DSUpdatedFailed") %>', 'alert-danger');
                            }
                            $('#saveDevelopModal').modal('hide');
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                    }
                }
            });
            function ValidateFields() {
                var objpcdstxtStartingSerialNumberA = document.getElementById("pcdstxtStartingSerialNumberA");

                if ($('#pcdscboDeliverableTypeA').val() == "" || $('#pcdscboDeliverableTypeA').val() == "0") {
                    showAlert('<%= MyBase.GetResourceString("C_AL_DeliverableTypeBlank") %>', 'alert-danger');
                $("#pcdscboDeliverableTypeA").focus();
                return false;
            }
            else if ($("#pcdscboIssueTypeA").val() == "" || $("#pcdscboIssueTypeA").val() == "0") {
                showAlert('Issue type should not be left blank.', 'alert-danger');
                $("#pcdscboIssueTypeA").focus();
                return false;
            }
            else if (disallowSpecialCharacters(objpcdstxtStartingSerialNumberA)) {
                showAlert('<%= MyBase.GetResourceString("C_AL_StartingSerialNumberChar") %>', 'alert-danger');
                return false;
            } else if (disallowNegativeInteger(objpcdstxtStartingSerialNumberA)) {
                showAlert('<%= MyBase.GetResourceString("C_AL_StartingSerialNumberInt") %>', 'alert-danger');
                    return false;
                }
                else {
                    return true;
                }
            }
            //Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id
            $("#btnpcdsAddPopup").click(function () {                
                GetExecutionTemplateData(0);                
            });
            //End Of Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id

            $("#btnpcdsAdd").click(function () {

                if (AddAccess == "True") {
                    var vres = ValidateFields();
                    if (vres) {
                        var taskParameters_dad = {
                            intProjectID: encodeURI(ProjectID),
                            intScheduleID: encodeURI($('#pcdscboDeliverableTypeA').val()),
                            IssueType: encodeURI($('#pcdscboIssueTypeA').val()),
                            intTemplateID: encodeURI($('#pcdscboExecutionTemplateA').val()),
                            intSerialNo: encodeURI($('#pcdstxtStartingSerialNumberA').val()),
                            Command: encodeURI('POST')
                        }
                        $.ajax({
                            //Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
                            //url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/ProjectDeliverableSettingsActions',
                            url: encodeURI(strUrl) + '/api/PM_DeliverableSettings/New_ProjectDeliverableSettingsActions',
                            //End of Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
                            type: "POST",
                            data: JSON.stringify(taskParameters_dad),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_dad) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dad) ? taskParameters_dad : JSON.stringify(taskParameters_dad)));
                                }
                            },
                            success: function (data) {
                                if (data[0].ack == "AD") {

                                    //Commented And Added By Usha Pandit On 11.06.2020 For rephrasing alert
                                    <%--showAlert('<%= MyBase.GetResourceString("C_AL_DSAdded") %>', 'alert-success');--%>
                                    showAlert('Deliverable Type added successfully', 'alert-success');
                                    //End Of Added By Usha Pandit On 11.06.2020 For rephrasing alert

                                    ProjectDeliverableSettingsActions();
                                   // $('#addDevelopModal').modal('hide');//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                                    refreshMyParent();
                                } else if (data[0].ack == "AR") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_DSAddAlreadyExists") %>', 'alert-danger');
                                }
                                else {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_DSAddFailed") %>', 'alert-danger');
                                }
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });
            //for the toast alert message
            function CloseShowAlert() {
                $('.ClosaeblealertMsg').hide();
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


            function GetProjectDeliverableType() {
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_DeliverableSettings/GetProjectDeliverableType'),
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
                        var objCboOU = document.getElementById('pcdscboDeliverableTypeA');
                        if (objCboOU != null) {
                            $("#pcdscboDeliverableTypeA").empty();
                            $("#pcdscboDeliverableTypeA").append('<option value="0">Select Deliverable Type</option>');
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.LabelSchedule;
                                objOption.value = ObjStatus.ScheduleID;
                            }
                        }

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }


            function GetProjectIssueTypes() {
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_DeliverableSettings/GetProjectIssueTypes'),
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
                        var objCboOU = document.getElementById('pcdscboIssueTypeA');
                        if (objCboOU != null) {
                            $("#pcdscboIssueTypeA").empty();
                            $("#pcdscboIssueTypeA").append('<option value="0">Select Issue Type</option>');
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.Type;
                                objOption.value = ObjStatus.Type;
                            }
                        }

                        var objCboOU1 = document.getElementById('pcdscboIssueTypeS');
                        if (objCboOU1 != null) {
                            $("#pcdscboIssueTypeS").empty();
                            $("#pcdscboIssueTypeS").append('<option value="0">Select Issue Type</option>');
                            for (var j = 0; j < result.length; j++) {
                                var ObjStatus = result[j];
                                var objOption = document.createElement("OPTION");
                                objCboOU1.options.add(objOption);
                                objOption.text = ObjStatus.Type;
                                objOption.value = ObjStatus.Type;
                            }
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }


            function GetExecutionTemplateData(curUniqueID) { 
                var TemplateData = {
                    intProjectID: encodeURI(ProjectID),
                    intUniqueID: encodeURI(curUniqueID)
                }
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_DeliverableSettings/GetExecutionTemplateData'),
                    type: "POST",
                    //Commented And Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id
                    //data: JSON.stringify(ProjectID),
                    data: JSON.stringify(TemplateData),
                    //End Of Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (TemplateData) {
                            xhr.setRequestHeader("Params", encryptString(isJson(TemplateData) ? TemplateData : JSON.stringify(TemplateData)));
                        }
                    },
                    success: function (result) {
                        var objCboOU = document.getElementById('pcdscboExecutionTemplateA');
                        if (objCboOU != null) {
                            $("#pcdscboExecutionTemplateA").empty();
                            $("#pcdscboExecutionTemplateA").append('<option value="0">Select Execution Template</option>');
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.TemplateName;
                                objOption.value = ObjStatus.ProjectPhaseTaskTemplateID;
                            }
                        }

                        var objCboOU1 = document.getElementById('pcdscboExecutionTemplateS');
                        if (objCboOU1 != null) {
                            $("#pcdscboExecutionTemplateS").empty();
                            $("#pcdscboExecutionTemplateS").append('<option value="0">Select Execution Template</option>');
                            for (var j = 0; j < result.length; j++) {
                                var ObjStatus = result[j];
                                var objOption = document.createElement("OPTION");
                                objCboOU1.options.add(objOption);
                                objOption.text = ObjStatus.TemplateName;
                                objOption.value = ObjStatus.ProjectPhaseTaskTemplateID;
                            }
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

        </script>

        <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    </div>
</body>
</html>
