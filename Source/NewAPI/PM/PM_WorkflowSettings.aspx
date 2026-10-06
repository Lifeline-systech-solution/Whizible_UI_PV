<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_WorkflowSettings.aspx.vb" Inherits="PbNIT.PM_WorkflowSettings" %>

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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

</head>

    <style>
        body {
            background: #fff;
        }

        .modalpgHead {
            background: #4263c1;
            color: #fff;
            font-family: 'Roboto', sans-serif;
            font-size: 20px;
        }

        #tblProjectWorkflowSettings {
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

        .proj-wrok-tbl thead tr th:first-child, .proj-wrok-tbl tbody tr td:first-child {
            text-align: left !important;
        }
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="ProjectWorkFlowSettingBody">
    <div id="divProjectWorkflowSettings">
        <div class="tab-pane pstbl_custom pt-0 practicesettinglist in active" id="pstbl_workflow_sett">
            <div class="modalpgHead pt-1 pb-1 col-sm-12"><%= MyBase.GetResourceString("P_Workflow_Settings") %></div>

            <div class=" pt-1 pb-1 col-sm-12 px-3 clearfix text-end">
                <h5 class="float-start mb-0 pt-2"><%= MyBase.GetResourceString("P_Project_Name") %> : <span id="ProjectName"></span></h5>
                <a href="#" class="btn btnyellow" id="btnSaveProjectWorkflowSettings"><%= MyBase.GetResourceString("P_Save") %></a>
            </div>

            <table id="tblProjectWorkflowSettings" class="table table-stripped table-bordered  proj-wrok-tbl">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("P_Available_Attributes") %></th>
                        <th width="80px" class="inp-select">
                            <div class="custom_chckbox">
                                <input type="checkbox" id="projectWorkFlowAvailAttriSltALl" class="chckHead">
                                <label for="projectWorkFlowAvailAttriSltALl" id="projectWorkFlowAvailAttriSltALl_lable"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tbodyProjectWorkflowSettings">
                </tbody>
            </table>
        </div>

        <div id="NoProjectDivID" hidden="hidden">
            <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
        </div>

        <!-- REQUIRED JS SCRIPTS -->
     

      <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>      
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>    
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

        <!-- Loader js -->
        <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
        <script src="../../General/CommonValidations.js?v=1"></script>--%>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        <%--var ProjectID = '<%= m_ProjectID %>';--%>

            //let searchParams = new URLSearchParams(window.location.search);
            // var ProjectID = searchParams.get('ProjectID');
            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
            var m_PM_ProjectWorkFlowSettingblnAddAccess = '<%= m_PM_ProjectWorkFlowSettingblnAddAccess %>';
            var m_PM_ProjectWorkFlowSettingblnDeleteAccess = '<%= m_PM_ProjectWorkFlowSettingblnDeleteAccess %>';
            var m_PM_ProjectWorkFlowSettingblnEditAccess = '<%= m_PM_ProjectWorkFlowSettingblnEditAccess %>';
            var m_PM_ProjectWorkFlowSettingblnViewAccess = '<%= m_PM_ProjectWorkFlowSettingblnViewAccess %>';
            var UserName = '<%= Session("strUserName") %>';

            $(document).ready(function () {
                if (m_PM_ProjectWorkFlowSettingblnViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectWorkflowSettings").html(bodyHTML);
                    return;
                }
                //alert(m_PM_ProjectWorkFlowSettingblnViewAccess);
                alertify.set('notifier', 'position', 'top-right');
                StartLoader("#ProjectWorkFlowSettingBody");
                if (m_PM_ProjectWorkFlowSettingblnViewAccess == "False" && m_PM_ProjectWorkFlowSettingblnAddAccess == "False" && m_PM_ProjectWorkFlowSettingblnEditAccess == "False") {
                    $("#pstbl_workflow_sett").hide();
                    //$("#DivNotView").show();
                }

                if (m_PM_ProjectWorkFlowSettingblnAddAccess == "False" || m_PM_ProjectWorkFlowSettingblnEditAccess == "False") {
                    $("#btnSaveProjectWorkflowSettings").hide();
                }

              
                if (ProjectID == 0) {
                    $("#ProjectWorkFlowSettingBody").hide();
                    StopAjaxLoader("#ProjectClosureBody");
                    $("#NoProjectDivID").show();
                    StopAjaxLoader("#ProjectWorkFlowSettingBody");
                }
                else {
                    StartLoader("#ProjectWorkFlowSettingBody");
                    GetProjectWorkflowSettingsData(ProjectID);
                    GetProjectName();

                    $("#projectWorkFlowAvailAttriSltALl").click(function () {
                        $(".chck-WorkFlowSettingattri").prop('checked', $(this).prop('checked'));
                    });

                    $(".chck-WorkFlowSettingattri").change(function () {
                        var rowCount = $("#tbodyProjectWorkflowSettings > tr").length;
                        var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowSettings");
                        if (rowCount == CheckedcheckedBoxes.length) {
                            $("#projectWorkFlowAvailAttriSltALl").prop('checked', true);
                        }
                        if (!$(this).prop("checked")) {
                            $("#projectWorkFlowAvailAttriSltALl").prop("checked", false);
                        }
                    });
                }
                StopAjaxLoader("#ProjectWorkFlowSettingBody");
            });

            var strHTML = '';
            function GetProjectWorkflowSettingsData(ProjectId) {
                StartLoader("#ProjectWorkFlowSettingBody");
                var ProjectID = encodeURI(ProjectId);
                $.ajax({
                    url: strUrl + '/api/PM_WorkflowSettings/GetProjectWorkflowSettingsData',
                    method: 'Post',
                    data: JSON.stringify(ProjectID),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                        }
                    },
                    success: function (result) {
                        $("#tbodyProjectWorkflowSettings").empty();
                        var Isused = 0; //Added By Dipali V On 18th Feb 2022 For IssueID 32107
                        for (var i = 0; i < result.length; i++) {
                            strHTML = '';
                            strHTML += '<tr>'
                            strHTML += '<td>' + result[i].Attribute + '</td>'
                            strHTML += '<td class="inp-select">'
                            strHTML += '<div class="custom_chckbox">'
                            if (result[i].Active == 1 && result[i].IsUsed == 1) {
                                Isused = 1; //Added By Dipali V On 18th Feb 2022 For IssueID 32107
                                strHTML += '<input type="checkbox" id="WorkflowSettings' + result[i].AttributeID + '" class="chckHead chck-WorkFlowSettingattri" checked disabled="disabled">'
                                strHTML += '<label for="WorkflowSettings' + result[i].AttributeID + '" style="cursor:NO-DROP !important;"></label>'
                            }
                            else if (result[i].Active == 0 && result[i].IsUsed == 1) {
                                Isused = 1; //Added By Dipali V On 18th Feb 2022 For IssueID 32107
                                strHTML += '<input type="checkbox" id="WorkflowSettings' + result[i].AttributeID + '" class="chckHead chck-WorkFlowSettingattri" disabled="disabled">'
                                strHTML += '<label for="WorkflowSettings' + result[i].AttributeID + '" style="cursor:NO-DROP !important;"></label>'
                            }
                            else if (result[i].Active == 1) {
                                strHTML += '<input type="checkbox" id="WorkflowSettings' + result[i].AttributeID + '" class="chckHead chck-WorkFlowSettingattri" checked>'
                                strHTML += '<label for="WorkflowSettings' + result[i].AttributeID + '"></label>'
                            }
                            else {
                                strHTML += '<input type="checkbox" id="WorkflowSettings' + result[i].AttributeID + '" class="chckHead chck-WorkFlowSettingattri">'
                                strHTML += '<label for="WorkflowSettings' + result[i].AttributeID + '"></label>'
                            }
                            strHTML += '</div>'
                            strHTML += '</td>'
                            strHTML += '</tr>'

                            $("#tbodyProjectWorkflowSettings").append(strHTML);
                        }
                        var rowCount = $("#tbodyProjectWorkflowSettings > tr").length;
                        var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowSettings");
                        if (rowCount == CheckedcheckedBoxes.length) {
                            $("#projectWorkFlowAvailAttriSltALl").prop('checked', true);
                        }
                        else {
                            $("#projectWorkFlowAvailAttriSltALl").prop('checked', false);
                        }
                        //Added By Dipali V On 18th Feb 2022 For IssueID 32107
                        if (Isused == 1) {
                            $("#projectWorkFlowAvailAttriSltALl").prop('disabled', true);
                            $("#projectWorkFlowAvailAttriSltALl_lable").css('cursor', 'NO-DROP');
                        }
                       //End of Added By Dipali V On 18th Feb 2022 For IssueID 32107
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
                StopAjaxLoader("#ProjectWorkFlowSettingBody");
            }

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

            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_WorkflowSettings%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_WorkflowSettings%>');
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

            $("#btnSaveProjectWorkflowSettings").click(function () {
                StartLoader("#ProjectWorkFlowSettingBody");
                var CheckedCheckboxArray = new Array();
                var UnCheckedCheckboxesID = '';
                var ObjCheckedcheckBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowSettings");
                var ObjUncheckedCheckBoxes = $("input[type=checkbox]:not(:checked)", "#tbodyProjectWorkflowSettings");

                for (var i = 0; i < ObjCheckedcheckBoxes.length; i++) {
                    var CheckedCheckboxVal = ObjCheckedcheckBoxes[i].id;
                    CheckedCheckboxVal = CheckedCheckboxVal.replace('WorkflowSettings', '');
                    CheckedCheckboxArray.push(CheckedCheckboxVal);
                }

                for (var j = 0; j < ObjUncheckedCheckBoxes.length; j++) {
                    var UnCheckedCheckboxVal = ObjUncheckedCheckBoxes[j].id;
                    UnCheckedCheckboxVal = UnCheckedCheckboxVal.replace('WorkflowSettings', '');
                    UnCheckedCheckboxesID += UnCheckedCheckboxVal + ',';
                }
                var CheckedCheckboxesID = CheckedCheckboxArray.toString();
                var ProjectWorkFlowSettingsParameter = {
                    ProjectID: encodeURI(ProjectID),
                    CheckedCheckboxesID: encodeURI(CheckedCheckboxesID),
                    UnCheckedCheckboxesID: encodeURI(UnCheckedCheckboxesID),
                    CreatedBy: encodeURI(UserName)
                }

                $.ajax({
                    url: strUrl + '/api/PM_WorkflowSettings/SaveProjectWorkFlowSettings',
                    method: 'Post',
                    data: JSON.stringify(ProjectWorkFlowSettingsParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectWorkFlowSettingsParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectWorkFlowSettingsParameter) ? ProjectWorkFlowSettingsParameter : JSON.stringify(ProjectWorkFlowSettingsParameter)));
                        }
                    },
                    success: function (result) {
                        if (result == null) {
                            alertify.success("Project WorkFlow Settings updated successfully.");
                            GetProjectWorkflowSettingsData(ProjectID);
                            //Added By Dipali V On 6th May 2020 For Issue iD=24112

                        $("#projectWorkFlowAvailAttriSltALl").click(function () {
                            $(".chck-WorkFlowSettingattri").prop('checked', $(this).prop('checked'));
                        });

                        $(".chck-WorkFlowSettingattri").change(function () {
                            var rowCount = $("#tbodyProjectWorkflowSettings > tr").length;
                            var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectWorkflowSettings");
                            if (rowCount == CheckedcheckedBoxes.length) {
                                $("#projectWorkFlowAvailAttriSltALl").prop('checked', true);
                            }
                            if (!$(this).prop("checked")) {
                                $("#projectWorkFlowAvailAttriSltALl").prop("checked", false);
                            }
                        });
                         //End of Added By Dipali V On 6th May 2020 For Issue iD=24112
                            refreshMyParent();
                        }

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
                StopAjaxLoader("#ProjectWorkFlowSettingBody");
            })

        </script>

    </div>
</body>

</html>
