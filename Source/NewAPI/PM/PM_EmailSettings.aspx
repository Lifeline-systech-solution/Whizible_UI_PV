<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EmailSettings.aspx.vb" Inherits="PbNIT.PM_EmailSettings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Project</title>
    <!--Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css?v=2" /> -->
    <!-- Bootstrap 3.3.5 -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=1" /> -->
    <!-- bootstrap select -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css?v=2" /> -->
    <!-- Font Awesome -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css?v=2" /> -->
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css?v=2" />
    <!-- animate css -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css?v=2" /> -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/dataTables.bootstrap.min.css?v=0" />
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_projctsetting.css?v=3.1" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=2" />

    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../../Whizible2.0/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />

    <!--<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet">-->
    <!-- <script src="../../General/CommonValidations.js"></script>
    <link href="../../../Whizible2.0/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0/plugins/alertify/alertify.min.js"></script> -->
   
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

    #tblpcesEmailSettings {
        margin: 0 auto 20px;
        width: 97%;
    }

    .root-add-btn {
        margin-left: 0px;
    }

    .lblcrsr {
        cursor: not-allowed !important;
    }

     /*Added by omkar on 19/12/2019 */
    div#pstbl_emailSettings {
            margin-bottom: 30px;
    }
    /*End Of Added by omkar on 19/12/2019 */
</style>

<body id="pcesBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divEmailSettings">
        <!--ps_list_table_start-->
        <div class="modalpgHead pt-1 pb-1 col-sm-12">Email Settings</div>
        <div class=" pt-1 pb-1 col-sm-12 text-right">
            <h5 class="pull-left mb-0">Project Name : <span id="ProjectName"></span></h5>

        </div>

        <div class="tab-pane pstbl_emailSettings pt-0 in active" id="pstbl_emailSettings" style="border-top: 1px solid #ddd;">

            <table id="tblpcesEmailSettings" class="table table-stripped table-bordered tbl-emails">
            </table>
            <div class="root-add-btn pl-20">
                <a href="javascript:;" class="btn borderbtn mr-5" id="btnpcesaddNewRow" data-toggle="modal"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></a>
                <button id="btnpcesConfirmDelete" class="btn borderbtn" data-toggle="modal"><%= MyBase.GetResourceString("C_Delete") %></button>
            </div>
        </div>
        <!--ps_list_table_end-->

        <!--Add new site modal end here-->

        <!--Add new email setting start here-->
        <div class="modal custmodal fade" id="addEmailSettPopup" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_EmailSetting") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group">
                            <div class="form-group col-sm-6">
                                <label class="control-label required"><%= MyBase.GetResourceString("C_EmailMessage") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcescboEmailMessageList", "Select 0,'--select--' ",,, "class='form-control'", False,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcescboEmailMessageList", "usp_Whizible2_Sel_ProjectEmailMessages " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", True,,,,, ) %>--%>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_CCToUser") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcescboEmployeeEmailList", "Select 0,'--select--' ",,, "class='form-control' multiple", True,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcescboEmployeeEmailList", "usp_Sel_ProjectEmployeeEmailMessages " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control' multiple",,, ) %>--%>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-12 btns-center">
                                    <button data-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                                    <button id="btnpcesaddsave" class="btn btnyellow pull-right ml-1"><%= MyBase.GetResourceString("C_Save") %></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add new email setting end here-->

        <!--Edit email setting start here-->
        <div class="modal custmodal fade" id="EditEmailSettPopup" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_EmailSetting") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group">
                            <div class="form-group col-sm-6">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Subject") %></label>
                                <%CommonFunctions.HTMLControls.DrawTextArea("pcestxtSubject", "pcestxtSubject", "", "form-control", , , , , , , 100, , , "line-height: 1.5!important;", , , , , "onkeyup='limitText(this,10,1000)'", , , , , , , , , , True)%>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Body") %></label>
                                <%CommonFunctions.HTMLControls.DrawTextArea("pcestxtBody", "pcestxtBody", "", "form-control", , , , , , , 4000, , , "line-height: 1.5!important;", , , , , "onkeyup='limitText(this,10,1000)'", , , , , , , , , , True)%>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label"><%= MyBase.GetResourceString("C_CCToUser") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("pcescboEditEmployeeEmailList", "Select 0,'--select--' ",,, "class='form-control' multiple", True,, ) %>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcescboEditEmployeeEmailList", "usp_Sel_ProjectEmployeeEmailMessages " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control' multiple", True,, ) %>--%>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-12 btns-center">
                                    <button data-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                                    <button id="btnpceseditsave" class="btn btnyellow pull-right ml-1"><%= MyBase.GetResourceString("C_Save") %></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Edit email setting end here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ConfirmDelete") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5>
                                <center><%= MyBase.GetResourceString("C_AL_ConfirmDelete") %></center>
                            </h5>
                        </div>
                        <br />
                        <center>
                        <button data-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        <button data-dismiss="modal" id="btnpcesdelete" class="btn btnyellow ml-1"><%= MyBase.GetResourceString("C_Okay") %></button>
                    </center>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Delete_new_Sub_tasktype_modal_end_here-->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" style="top: 10px" hidden="hidden">
            <button type="button" onclick="CloseShowAlert()" class="close">×</button>
            <p id="alertMsg"></p>
        </div>
        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->
        <!-- jQuery 2.1.4 -->
         <%--<script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>--%> 
    <script src="../../../Whizible2.0/plugins/jQuery/jquery-3.5.1.min.js"></script>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>
        <!-- Bootstrap 3.3.5 -->
        <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>
        <!-- Bootstrap 3.3.5 -->
        <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>

        <!-- Bootstrap 3.3.5 -->
        <script src="../../../Whizible2.0/dist/js/jquery.dataTables.min.js"></script>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            EmployeeID = '<%= Session("intUserID") %>';
            UserName = '<%= Session("strUserName") %>';
            //let searchParams = new URLSearchParams(window.location.search);
            // var ProjectID = searchParams.get('ProjectID');
            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
       // ProjectID = '<%= Session("intProjectID") %>';
            ProjectName = '<%= Session("strProjectName") %>';

            var flag;
            var colspn;
            var ProjectMailID;
            var emailusers;
            var objpcestxtSubject = document.getElementById("pcestxtSubject");
            var objpcestxtBody = document.getElementById("pcestxtBody");
            var objpcescboEditEmployeeEmailList = document.getElementById("pcescboEditEmployeeEmailList");
            var objpcescboEmailMessageList = document.getElementById("pcescboEmailMessageList");
            var AddAccess = '<%= m_AddAccess %>';
            var EditAccess = '<%= m_EditAccess %>';
            var DeleteAccess = '<%= m_DeleteAccess %>';

            $(document).ready(ProjectEmailSettingsActions);

            $("#btnpcesConfirmDelete").click(function () {
                var delProjectEmail = [];
                $.each($("input[name='chkEmailSetting']:checked"), function () {
                    delProjectEmail.push($(this).val());
                });
                if (delProjectEmail.join(",") == "") {
                    $('#btnpcesConfirmDelete').removeAttr('data-target', '#CPdelSubtaskModal');
                    showAlert('<%= MyBase.GetResourceString("C_AL_EmailSettingsDeleteSelect") %>', 'alert-danger');
                }
                else {
                    $('#btnpcesConfirmDelete').attr('data-target', '#CPdelSubtaskModal');
                }
            });

            $("#btnpcesdelete").click(function () {
                if (DeleteAccess == "True") {
                    var delProjectEmail = [];
                    $.each($("input[name='chkEmailSetting']:checked"), function () {
                        delProjectEmail.push($(this).val());
                    });

                    if (delProjectEmail.join(",") != "") {
                        var taskParameters_ds = {
                            ProjectMailIDs: encodeURI(delProjectEmail.join(",")),
                            ProjectID: encodeURI(ProjectID),
                            Command: encodeURI('DELETE')
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_EmailSettings/ProjectEmailSettingsActions',
                            type: "POST",
                            data: JSON.stringify(taskParameters_ds),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                            },
                            success: function (data) {
                                console.log(data);
                                if (data[0].ack == "DEL") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_EmailSettingsDeleted") %>', 'alert-success');
                                ProjectEmailSettingsActions();
                            } else {
                                showAlert('<%= MyBase.GetResourceString("C_AL_ReqDeleteFailed") %>', 'alert-danger');
                            }
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_EmailSettingsDeleteSelect") %>', 'alert-danger');
                }
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }

            });

            //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
            function GetProjectEmployees() {
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_EmailSettings/GetProjectEmployees'),
                    type: "POST",
                    data: JSON.stringify(ProjectID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (result) {
                        var objCboOU = document.getElementById('pcescboEditEmployeeEmailList');
                        if (objCboOU != null) {
                            $("#pcescboEditEmployeeEmailList").empty();

                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.UserName;
                                objOption.value = ObjStatus.EmployeeID;
                            }
                        }
                        var objCboOU1 = document.getElementById('pcescboEmployeeEmailList');
                        if (objCboOU1 != null) {
                            $("#pcescboEmployeeEmailList").empty();

                            for (var j = 0; j < result.length; j++) {
                                var ObjStatus = result[j];
                                var objOption1 = document.createElement("OPTION");
                                objCboOU1.options.add(objOption1);
                                objOption1.text = ObjStatus.UserName;
                                objOption1.value = ObjStatus.EmployeeID;
                            }
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }


            function GetProjectEmailMessages() {

                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_EmailSettings/GetProjectEmailMessages'),
                    type: "POST",
                    data: JSON.stringify(ProjectID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (result) {
                        var objCboOU = document.getElementById('pcescboEmailMessageList');
                        if (objCboOU != null) {
                            $("#pcescboEmailMessageList").empty();
                            $("#pcescboEmailMessageList option").remove();
                            var objCbo = document.getElementById("pcescboEmailMessageList");
                            var objOption = document.createElement("OPTION");
                            objCbo.options.add(objOption);
                            objOption.text = "Select Email Message";
                            objOption.value = "0";
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.subject;
                                objOption.value = ObjStatus.msgid;
                            }

                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

            //End of addition By Chetan M.

            function GetProjectName() {
                $("#ProjectName").empty();
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_ProjectSettings/GetProjectName'),
                    type: "POST",
                    data: JSON.stringify(ProjectID),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
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

            function ProjectEmailSettingsActions() {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divEmailSettings").html(bodyHTML);
                    return;
                }
                StartLoader("#pcesBodyID")
                GetProjectName();
                GetProjectEmployees();
                GetProjectEmailMessages();
                if (AddAccess == "False") {
                    //Commented and added by Chetan M. on 02/12/2019 While doing accessible page Integration testing
                    //$("#btnpcesaddNewRow").attr("disabled", true);//.hide();
                    $("#btnpcesaddNewRow").hide();
                    //End of addition By Chetan M.
                    $("#btnpcesaddNewRow").addClass("lblcrsr");
                }
                else {
                    $('#btnpcesaddNewRow').attr('data-target', '#addEmailSettPopup');
                }
                if (DeleteAccess == "False") {
                    //Commented and added by Chetan M. on 02/12/2019 While doing accessible page Integration testing
                    //$("#btnpcesConfirmDelete").attr("disabled", true);//.hide();
                    $("#btnpcesConfirmDelete").hide();
                    //End of addition By Chetan M.
                    colspn = 1;
                }
                else {
                    colspn = 2;
                }
                if (ProjectID != "") {
                    var taskParameters_is = {
                        ProjectID: encodeURI(ProjectID),
                        Command: encodeURI('GET')
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_EmailSettings/ProjectEmailSettingsActions',
                        type: "POST",
                        data: JSON.stringify(taskParameters_is),
                        dataType: "json",
                        async: false,
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                        },
                        success: function (data) {
                            var setHTML = '<thead><tr><th><%= MyBase.GetResourceString("C_SubjectHead") %></th>'
                        if (DeleteAccess == "True") {
                            setHTML += '<th class="text-center sm-wid"><div class="custom_chckbox"><input id="esAll" class="chckHead" type="checkbox"><label for="esAll"></label></div></th>'
                        }
                        setHTML += '</tr></thead>'
                        setHTML += '<tbody id="tbodyProjectEmailSetting">'
                        if (data.length != 0) {
                            for (var i = 0; i < data.length; i++) {
                                var d = data[i];
                                setHTML += '<tr>'
                                if (EditAccess == "False") {
                                    setHTML += '<td  class="text-left"><xmp style="margin-top: 1px; margin-bottom: 1px;">' + d.Subject + '</xmp></td>'
                                }
                                else {
                                    setHTML += '<td class="text-left"><a href="#" data-toggle="modal" onclick=setValues(' + d.ProjectMailID + ')  data-target="#EditEmailSettPopup" ><xmp style="margin-top: 1px; margin-bottom: 1px;"> ' + d.Subject + '</xmp></a ></td > '
                                }
                                if (DeleteAccess == "True") {
                                    setHTML += '<td class="text-center sm-wid"><div class="custom_chckbox"><input id="pces' + d.MsgID + '" value="' + d.ProjectMailID + '"  class="chckHead eschck" name="chkEmailSetting" type="checkbox"><label for="pces' + d.MsgID + '"></label></div></td>'
                                }
                                setHTML += '</tr>';
                            }
                        }
                        else {
                            setHTML += '<tr><td colspan="' + colspn + '"><span class="text-center"><%= MyBase.GetResourceString("C_AL_NoItem") %></span></td></tr>';
                            }
                            setHTML += ' </tbody></table>'
                            $("#tblpcesEmailSettings").html(setHTML);
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
                $("#esAll").click(function () {
                    $(".eschck").prop('checked', $(this).prop('checked'));
                });

                $(".eschck").change(function () {
                    var rowCount = $("#tbodyProjectEmailSetting > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectEmailSetting");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#esAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#esAll").prop("checked", false);
                    }
                });

                StopAjaxLoader("#pcesBodyID")
            }
            function ValidateFields() {
                if (Trim(objpcestxtSubject.value) == "") {
                    showAlert('Subject Should not be left blank.', 'alert-danger');
                    var SubjectTxtID = "#" + objpcestxtSubject.id;
                    $(SubjectTxtID).focus();
                    return false;
                }
                else if (objpcestxtBody.value == "") {
                    showAlert('Body should not be left blank.', 'alert-danger');
                    var BodyTxtID = "#" + objpcestxtBody.id;
                    $(BodyTxtID).focus();
                    return false;
                }
                else {
                    return true;
                }
            }

            $("#btnpceseditsave").click(function () {
                SaveEmailSettings();
            });
            $("#btnpcesaddsave").click(function () {

                msgID = objpcescboEmailMessageList.value;

                if (msgID != "" && msgID != 0) {
                    emailusers = [];
                    $('#pcescboEmployeeEmailList option:selected').each(function () {
                        var val = $(this).val();
                        if (val) {
                            emailusers.push(val);
                        }
                    });
                    SaveEmailSettings();
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_SelectEmailMessage") %>', 'alert-danger');
                    //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                    $("#pcescboEmailMessageList").focus();
                    //End of addition By Chetan M.
                }
            });

            $("#btnpcesaddNewRow").click(function () {
                flag = "POST";
                $('#pcestxtSubject').val("");
                $('#pcestxtBody').val("");
                $('#pcescboEmailMessageList').val(0);
                //$('#pcescboEmployeeEmailList').trigger('change').val(['']);
                $('#pcescboEmployeeEmailList').val("");
            });
            function setValues(pmID) {
                var taskParameters_ge = {
                    ProjectID: encodeURI(ProjectID),
                    ProjectMailID: encodeURI(pmID),
                    Command: encodeURI('GET')
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_EmailSettings/ProjectEmailSettingsActions',
                    type: "POST",
                    data: JSON.stringify(taskParameters_ge),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        flag = "PUT";
                        $('#pcestxtSubject').val(data[0].Subject);
                        $('#pcestxtBody').val(data[0].Body);
                        ProjectMailID = pmID;
                        msgID = data[0].MsgID;
                        //data[0].CCToUsersList;
                        //$('#pcescboEditEmployeeEmailList').trigger('change').val(['61', '689']);
                        console.log(data[0].CCToUsersList);
                        var nameArr = data[0].CCToUsersList.split(',');
                        $('#pcescboEditEmployeeEmailList').trigger('change').val(nameArr);
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            function SaveEmailSettings() {
                if (AddAccess == "True" || EditAccess == "True") {
                    //var selectedValues = "";
                    //$("#pcescboEditEmployeeEmailList option:selected").each(function () {
                    //    selectedValues += $(this).val() + ",";
                    //});

                    if (flag != "POST") {
                        emailusers = [];
                        $('#pcescboEditEmployeeEmailList option:selected').each(function () {
                            var val = $(this).val();
                            if (val) {
                                emailusers.push(val);
                            }
                        });
                        var valres = ValidateFields();
                    }

                    if (valres != false || flag == "POST") {
                        if (emailusers != "") {
                            var taskParameters_s = {
                                CCToUsersList: encodeURI(emailusers.join(",")),
                                ProjectID: encodeURI(ProjectID),
                                MsgID: encodeURI(msgID),
                                ProjectMailID: encodeURI(ProjectMailID),
                                Subject: encodeURI(Trim(objpcestxtSubject.value)),
                                Body: encodeURI(Trim(objpcestxtBody.value)),
                                CreatedBy: encodeURI(UserName),
                                Command: encodeURI(flag)
                            }
                            $.ajax({
                                url: encodeURI(strUrl) + '/api/PM_EmailSettings/ProjectEmailSettingsActions',
                                type: "POST",
                                data: JSON.stringify(taskParameters_s),
                                dataType: "json",
                                contentType: "application/json;charset-utf=8",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                                },
                                success: function (data) {
                                    console.log(data);
                                    if (data[0].ack == "AD") {
                                        showAlert('<%= MyBase.GetResourceString("C_AL_Added") %>', 'alert-success');
                                    ProjectEmailSettingsActions();
                                } else if (data[0].ack == "AE") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_EmailSettingsExists") %>', 'alert-danger');
                                } else if (data[0].ack == "UPD") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_EmailSettingsUpdated") %>', 'alert-success');
                                    ProjectEmailSettingsActions();
                                }
                                else if (data[0].ack == "NUPD") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_EmailSettingNotUpdated") %>', 'alert-danger');
                                }
                                //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                                $('#addEmailSettPopup,#EditEmailSettPopup').modal('hide');
                                //End of addition By Chetan M.

                            },
                            error: function (err) {
                                console.log(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_AL_EmailUserSelect") %>', 'alert-danger');
                        //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                        $("#pcescboEmployeeEmailList").focus();
                        $("#pcescboEditEmployeeEmailList").focus();
                        //End of addition By Chetan M.
                    }
                }
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            }
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


            $('#RRdate').datepicker({
                autoclose: true,
            });

            var ViewAccess = "<%= m_ViewAccess %>";
            $(document).ready(function () {
                $("#emailSettingAll").click(function () {
                    $(".email-sett-chck").prop('checked', $(this).prop('checked'));
                });

                $(".email-sett-chck").change(function () {
                    if (!$(this).prop("checked")) {
                        $("#emailSettingAll").prop("checked", false);
                    }
                });
            });

        </script>

        <!-- <script src="../../../Whizible2.0/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0/dist/js/loadingoverlay_progress.js"></script> -->
    </div>
</body>

</html>
