<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Priorities.aspx.vb" Inherits="PbNIT.PM_Priorities" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("Priorities")%>
<head runat="server">
<!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
 <%--   <meta charset="utf-8 " />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>Priorities</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />

<%--    <script src="../../General/CommonValidations.js"></script>
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

</head>
          
    <style type="text/css">
          #CloseableAlert .close {
            float: right;
            border: none;
        }

         .alertify-notifier {
            z-index: 99999 !important;
        }
         .alertify-notifier {
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
        }
        body {
            background: #fff;
        }

        .lblcrsr {
            cursor: not-allowed !important;
        }

        .modalpgHead {
            background: #4263c1;
            color: #fff;
            font-family: 'Roboto', sans-serif;
            font-size: 20px;
        }

        .practicesettinglist .table {
            margin-bottom: 20px;
        }

        #tblpcprPriority {
            margin: 0 auto 20px;
            width:100%;
        }

        .add-btn-wrap {
            margin-left: 0px;
        }
        /* Added By Gauri On 20th Aug 2024 For Alignment Issue */
        /* @media (min-width: 576px){
            .modal-dialog {
                margin-top: 72px;
            }
        } */
        .borderbtn {
            background: #fff;
            border-color: #1359a6;
            color: #1359a6;
            font-weight: 500;
        }
        .borderbtn:hover {
            background: #1359a6;
            color: #fff;
        }
        .btnyellow {
            background: #fbb03b;
            color: #fff;
        }
        .btnyellow:hover {
            background: #e29214;
            color: #fff;
        }
        a {
            text-decoration: none !important;
        }
        /* End of Added By Gauri On 20th Aug 2024 For Alignment Issue */
    </style>

<body id="pcprBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectPriorities">
        <div id="" class="tab-content practicesettinglist">
            <!--ps_priorities_start-->
            <div class="tab-pane pstbl_priority pt-0 in active" id="pstbl_priorities">
                <div class="modalpgHead pt-1 pb-1 col-sm-12">Priorities</div>

                <div class=" pt-1 pb-1 col-sm-12 px-3 text-end clearfix">
                    <h5 class="float-start mb-0">Project Name : <span id="ProjectName"></span></h5>

                </div>
                <div class="px-3">
                <table id="tblpcprPriority" class="table table-stripped table-bordered tbl-priority">
                </table>
                    </div> 
                <div class="add-btn-wrap pl-20">
                    <div class="input-wid-30">
                        <!-- Added By Gauri On 20th Aug 2024 For Alignment Issue -->
                        <button type="submit" class="btn borderbtn mr-5" id="btnpcpraddNewRow" data-bs-toggle="modal" data-bs-target="#PriorityPopup"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                        <!-- End of Added By Gauri On 20th Aug 2024 For Alignment Issue -->
                        <button id="btnpcprConfirmDelete" data-bs-toggle="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Delete") %></button>
                        <%--<button id="Save-rowNew" class="btn btnyellow"><%= MyBase.GetResourceString("C_Save") %></button>--%>
                    </div>
                </div>
            </div>
            <!--ps_priorities_end-->
        </div>
        <!--Add new site modal end here-->

        <!-- Add new priorities modal start here-->
        <div class="modal custmodal fade" id="PriorityPopup" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Priorities") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-6 mb-10">
                                    <label><%= MyBase.GetResourceString("C_Priority") %><span style="color: red">*</span></label>
                                    <%--<input type="text" name="" class="text-field">--%>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("pcprtxtPriority", "pcprtxtPriority", "text-field",, 50,,,,,,,,,,,,,,, True) %>
                                </div>
                                <div class="col-sm-6 mb-10">
                                    <label><%= MyBase.GetResourceString("C_CorporatePriority") %><span style="color: red">*</span></label>
                                    <%--Commented & Added By RUtuja D. 6 Jan 2020 for Drop DOwn Binding--%>
                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcprCboCorporatePriority", "usp_Whizible2_Sel_tbl_IB_Priorities",,, "class='form-control'", True,, ) %>--%>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("pcprCboCorporatePriority", "Select ''",,, "class='form-select'",,, ) %>
                                   <%--End Commented & Added By RUtuja D. 6 Jan 2020 for Drop DOwn Binding--%>
                                   
                                </div>
                                <div class="col-sm-6">
                                    <label><%= MyBase.GetResourceString("C_DefaultPriority") %></label>
                                    <div class="custom_chckbox">
                                        <%--<input id="defPrio" class="chckHead" type="checkbox">--%>
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("pcprchkDefaultPriority", "pcprchkDefaultPriority") %>
                                        <label for="pcprchkDefaultPriority"></label>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label><%= MyBase.GetResourceString("C_FixInDays") %></label>
                                    <%--<input type="number" name="" class="text-field">--%>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("pcprtxtFixInDays", "pcprtxtFixInDays", "text-field",, 4,,,,,,,,,,,,,,, True) %>
                                    <span class="sm-font"><%= MyBase.GetResourceString("C_Note") %></span>
                                </div>
                            </div>
                        </div>
                        <div class="">
                            <div class="row">
                                <!--<label class="control-label col-sm-4"></label>-->
                                <div class="col-sm-12 btns-center btn-grp-new">
                                    <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                                    <button id="btnpcprSave" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Save") %></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add new priorities modal end here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true">
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
                            <p class="text-center">
                                <%= MyBase.GetResourceString("C_AL_ConfirmDelete") %>
                            </p>
                        </div>
                       
                         <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button id="btnpcprdelete" class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--Delete_new_Sub_tasktype_modal_end_here-->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" style="top: 10px" >
            <button type="button" onclick="CloseShowAlert()" class="close">×</button>
            <p id="alertMsg"></p>
        </div>
        <%--by vishal Mahajan 21-12-2019--%>
        <div id="CloseableAlert2" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg2" style="top:80px" hidden="hidden">
            <button type="button" onclick="CloseShowAlert2()" class="close">×</button>
            <p id="alertMsg2"></p>
        </div>
        <%--by vishal Mahajan 21-12-2019--%>
        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->

        <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>     
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>   
         <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>

        <script>
            //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
            var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            EmployeeID = '<%= Session("intUserID") %>';
            UserName = '<%= Session("strUserName") %>';

            //let searchParams = new URLSearchParams(window.location.search);
            //var ProjectID = searchParams.get('ProjectID');
            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
            ProjectName = '<%= Session("strProjectName") %>';

            var flag;
            var ProjectPriorityID;
            var objpcprtxtPrioity = document.getElementById("pcprtxtPriority");
            var objpcprchkDefaultPrioity = document.getElementById("pcprchkDefaultPriority");
            var objpcprCboCorporatePriority = document.getElementById("pcprCboCorporatePriority");
            var objpcprtxtFixInDays = document.getElementById("pcprtxtFixInDays");
            var colspn;
            var AddAccess = '<%= m_AddAccess %>';
            var EditAccess = '<%= m_EditAccess %>';
            var DeleteAccess = '<%= m_DeleteAccess %>';
            var ViewAccess = '<%= m_ViewAccess %>';

            $(document).ready(ProjectPriorityActions);

            $("#btnpcpraddNewRow").click(function () {
                $('#pcprtxtPriority').val("");
                $('#pcprCboCorporatePriority').val("");
                $('#pcprtxtFixInDays').val("");
                $('#pcprchkDefaultPriority').prop('checked', false);
                flag = "POST";
            });

            $("#btnpcprConfirmDelete").click(function () {
                var del = [];
                $.each($("input[name='Priority']:checked"), function () {
                    del.push($(this).val());
                });
                if (del.join(",") == "") {
                    $('#btnpcprConfirmDelete').removeAttr('data-bs-target', '#CPdelSubtaskModal');
                    showAlert('<%= MyBase.GetResourceString("C_AL_PriorityDeleteSelect") %>', 'alert-danger');
                }
                else {
                    $('#btnpcprConfirmDelete').attr('data-bs-target', '#CPdelSubtaskModal');
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

            function ValidateFields() {
                var Priority2 = $("#pcprtxtPriority").val();
                if (Trim(objpcprtxtPrioity.value) == "") {
                    showAlert('<%= MyBase.GetResourceString("C_AL_PrioityBlank") %>', 'alert-danger');
                    var PriorityID = "#" + objpcprtxtPrioity.id;
                    $(PriorityID).focus();
                    return false;
                }
                //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
                else if (checkSpecialCharacter(Priority2, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Priority should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#pcprtxtPriority").focus();
                    return false;
                }

                else if (objpcprCboCorporatePriority.value == "") {
                    showAlert('<%= MyBase.GetResourceString("C_AL_CorporatePrioityBlank") %>', 'alert-danger');
                    var PriorityID = "#" + objpcprCboCorporatePriority.id;
                    $(PriorityID).focus();
                    return false;
                }
                else if (Trim(objpcprtxtFixInDays.value) != "") {
                    //if (disallowSpecialCharacters(objpcprtxtFixInDays)) {
                    if (checkSpecialCharacter(Trim(objpcprtxtFixInDays.value), WebConfigSpecialCharacters) == true) {
                       // showAlert('<%= MyBase.GetResourceString("C_AL_FixInDaysCharacter") %>', 'alert-danger');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Fix in Days should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    var PriorityID = "#" + objpcprtxtFixInDays.id;
                    $(PriorityID).focus();
                    return false;
                }
                else if (disallowNegativeInteger(objpcprtxtFixInDays)) {
                    showAlert('<%= MyBase.GetResourceString("C_AL_FixInDaysPositiveInt") %>', 'alert-danger');
                        var PriorityID = "#" + objpcprtxtFixInDays.id;
                        $(PriorityID).focus();
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                else {
                    return true;
                }
            }


            function GetProjectName() {
                $("#ProjectName").empty();
                var Parameter = { ProjectID: ProjectID }
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
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_Priorities%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");
                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_Priorities%>');
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
			var Actionflg = "";//Added By Dipali V On 6th June 2020 For Issue ID 25044
            $("#btnpcprSave").click(function () {
                try {
                    if (AddAccess == "True" || EditAccess == "True") {
                        var valres = ValidateFields();

                        if (ProjectPriorityID == undefined) {
                            ProjectPriorityID = 0;
                        }

                        if (pcprchkDefaultPriority.checked == true) {
                            var objpcprchkDefaultPrioity = 1
                        }
                        else {
                            var objpcprchkDefaultPrioity = 0;
                        }

                        if (valres) {
                            var taskParameters_s = {
                                ProjectID: encodeURI(ProjectID),
                                ProjectPriorityID: encodeURI(ProjectPriorityID),
                                Priority: encodeURI(Trim(objpcprtxtPrioity.value)),
                                CorporatePriority: encodeURI($('select[name=pcprCboCorporatePriority] option:selected').text()),//objpcisCboMapToCS.text,
                                DefaultPriority: objpcprchkDefaultPrioity,
                                FixInDays: encodeURI(Trim(objpcprtxtFixInDays.value)),
                                CreatedBy: encodeURI(UserName),
                                Command: encodeURI(flag)//"POST"
                            }                          
                            $.ajax({
                                url: encodeURI(strUrl) + '/api/PM_Priorities/ProjectPrioritiesActions',
                                type: "POST",
                                data: JSON.stringify(taskParameters_s),
                                dataType: "json",
                                contentType: "application/json;charset-utf=8",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    if (taskParameters_s) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_s) ? taskParameters_s : JSON.stringify(taskParameters_s)));
                                    }
                                },
                                success: function (data) {
                                    console.log();
                                   
									Actionflg = data[0].ack;//Added By Dipali V On 6th June 2020 For Issue ID 25044
                                    if (data[0].ack == "AD") {
                                        showAlert('<%= MyBase.GetResourceString("C_AL_PriorityAdded") %>', 'alert-success');
                                        ProjectPriorityActions();
                                        //Added by Chetan M on 06 Nov 2020 for get update added Priority
                                        flag = "PUT";
                                        ProjectPriorityID = data[0].PK;
                                      
                                        refreshMyParent();
                                    } else if (data[0].ack == "AE" || data[0].ack == "NUPD") {
                                        showAlert('<%= MyBase.GetResourceString("C_AL_PriorityExists") %>', 'alert-danger');
                                    } else if (data[0].ack == "UPD") {
                                        showAlert('<%= MyBase.GetResourceString("C_AL_PriorityUpdated") %>', 'alert-success');
                                        ProjectPriorityActions();
                                        refreshMyParent();
                                       
                                    }
                                    //$('#PriorityPopup').modal('toggle');
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
                }
                catch (ex) {
                    alert(ex.message);
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
            function ProjectPriorityActions() {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectPriorities").html(bodyHTML);
                    return;
                }
                StartLoader("#pcprBodyID")
                GetProjectName();
                //Added By Rutuja D. 6 Jan 2020 For Fill Drop Down Values In Corporate Priorityt
                //FillCorporatePriorityCombo();
				if (Actionflg == "") {//Added By Dipali V On 6th June 2020 For Issue ID 25044
                    FillCorporatePriorityCombo();
                }
                //End Added By Rutuja D. 6 Jan 2020 For Fill Drop Down Values In Corporate Priorityt

                if (AddAccess == "False") {
                    // $("#btnpcpraddNewRow").attr("disabled", true);//.hide();
                    $("#btnpcpraddNewRow").hide();
                    $("#btnpcpraddNewRow").addClass("lblcrsr");
                }
                else {
                    $('#btnpcpraddNewRow').attr('data-bs-target', '#PriorityPopup');
                }
                if (DeleteAccess == "False") {
                    //$("#btnpcprConfirmDelete").attr("disabled", true);//.hide();
                    $("#btnpcprConfirmDelete").hide();
                    colspn = 3;
                }
                else {
                    colspn = 4;
                }
                if (ProjectID != "") {
                    var taskParameters_is = {
                        ProjectID: encodeURI(ProjectID),
                        Command: encodeURI('GET')
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_Priorities/ProjectPrioritiesActions',
                        type: "POST",
                        data: JSON.stringify(taskParameters_is),
                        dataType: "json",
                        async: false,
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (taskParameters_is) {
                                xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_is) ? taskParameters_is : JSON.stringify(taskParameters_is)));
                            }
                        },
                        success: function (data) {
                            var setHTML = '<thead><tr><th><%= MyBase.GetResourceString("C_PriorityHead") %></th><th><%= MyBase.GetResourceString("C_CorporatePriorityHead") %></th><th><%= MyBase.GetResourceString("C_DefaultPriorityHead") %></th>'
                            if (DeleteAccess == "True") {
                                setHTML += '<th class="text-center sm-wid"><div class="custom_chckbox"><input id="prioAll" class="chckHead" type="checkbox"><label for="prioAll"></label></div></th>'
                            }

                            setHTML += '</tr></thead>'
                            setHTML += '<tbody id="tbodyProjectPriorities">'
                            if (data.length != 0) {
                                for (var i = 0; i < data.length; i++) {
                                    var d = data[i];
                                    var defltsav;
                                    if (d.DefaultPriority == "0") { defltsev = "No" } else { defltsev = "Yes" }

                                    setHTML += '<tr>'

                                    if (EditAccess == "False") {
                                        setHTML += '<td>' + d.Priority + '</td>'
                                    } else {
                                        //Commented And Added By Usha Pandit On 11.06.2020 For escaping quotes in string
                                        //setHTML += '<td><a href="#" data-bs-toggle="modal" onclick=setValues(' + d.ProjectPriorityID + ',&#39;' + replaceChar(Trim(d.Priority), ' ', '&#32;') + '&#39;,' + d.PriorityID + ',' + d.DefaultPriority + ',' + d.FixInDays + ') data-bs-target="#PriorityPopup">' + d.Priority + '</a></td>'
                                        var strPriority = Trim(d.Priority).toString().replace(/'/g, "\\'");
                                        setHTML += '<td><a href="#" data-bs-toggle="modal" onclick="setValues(' + d.ProjectPriorityID + ',' + '&quot;' + strPriority + '&quot;' + ',' + d.PriorityID + ',' + d.DefaultPriority + ',' + d.FixInDays + ')" data-bs-target="#PriorityPopup">' + d.Priority + '</a></td>'
                                        //End Of Added By Usha Pandit On 11.06.2020 For escaping quotes in string
                                    }
                                    setHTML += '<td>' + d.CorporatePriority + '</td><td>' + defltsev + '</td>'
                                    if (DeleteAccess == "True") {
                                        setHTML += '<td class="text-center sm-wid"><div class="custom_chckbox"><input id="pcpr' + d.Priority + d.CorporatePriority + '" value="' + d.ProjectPriorityID + '"  class="chckHead priochck" name="Priority" type="checkbox"><label for="pcpr' + d.Priority + d.CorporatePriority + '"></label></div></td>'
                                    }
                                    setHTML += '</tr>';
                                }
                            }
                            else {

                                setHTML += '<tr><td style="text-align: center!important;" colspan="' + colspn +'"><span class="text-center"><%= MyBase.GetResourceString("C_AL_NoItem") %></span></td></tr>';
                            }
                            setHTML += ' </tbody></table>'

                            $("#tblpcprPriority").html(setHTML);
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
                $("#prioAll").click(function () {
                    $(".priochck").prop('checked', $(this).prop('checked'));
                });
                //Added By Usha Pandit On 23.06.2020 for select all functionality
                $(".priochck").change(function () {                    
                    var rowCount = $("#tbodyProjectPriorities > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectPriorities");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#prioAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#prioAll").prop("checked", false);
                    }
                });
                //End Of Added By Usha Pandit On 23.06.2020 for select all functionality
                StopAjaxLoader("#pcprBodyID")
            }

            $("#btnpcprdelete").click(function () {
                if (DeleteAccess == "True") {
                    var favorite = [];
                    $.each($("input[name='Priority']:checked"), function () {
                        favorite.push($(this).val());
                    });
                    if (favorite.join(",") != "") {
                        var taskParameters_ds = {
                            UniqueIDs: encodeURI(favorite.join(",")),
                            ProjectID: encodeURI(ProjectID)
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_Priorities/ProjectPrioritiesDelete',
                            type: "POST",
                            data: JSON.stringify(taskParameters_ds),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_ds) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_ds) ? taskParameters_ds : JSON.stringify(taskParameters_ds)));
                                }
                            },
                            success: function (data) {
                                //by vishal Mahajan 21-12-2019
                                if (data[0].SuceessResult != "") {
                                    //Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                                    setTimeout(function () {
                                        showAlert(data[0].SuceessResult, 'alert-success');
                                    }, 350);
                                    //End of Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                                    
                                    refreshMyParent();
                                }
                                if (data[0].ErrorResult != "") {
                                    //Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                                    setTimeout(function () {
                                        showAlert2(data[0].ErrorResult, 'alert-danger');
                                    }, 350);
                                    //End of 
                                  //Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                                }
                                if (data[0].SuceessResult != "" && data[0].ErrorResult == "") {
                                    //$('#CPdelSubtaskModal').modal('toggle');
                                    refreshMyParent();
                                }
                               
                                ProjectPriorityActions();
                                //by vishal Mahajan 21-12-2019
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        //Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                        setTimeout(function () {
                            showAlert('<%= MyBase.GetResourceString("C_AL_PriorityDeleteSelect") %>', 'alert-danger');
                        }, 350);
                        //End of Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                    }
                }
                else {
                    //Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                    setTimeout(function () {
                        showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                    }, 350);
                    //End of Added By Dipali V On 28th April 2020 For alert should not be dismiss 
                }
            });

            function setValues(prid, prio, pprid, dpr, fiday) {

                flag = "PUT";
                ProjectPriorityID = prid;
                $('#pcprtxtPriority').val(prio);
                $('#pcprtxtFixInDays').val(fiday);               
                $('#pcprCboCorporatePriority').val(pprid);
                $('#pcprchkDefaultPriority').prop('checked', dpr == 0 ? false : true);
            }
            //Added By Rutuja D. 6 Jan 2020 For Fill Drop Down Values In Corporate Priorityt
            function FillCorporatePriorityCombo() {
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_Priorities/FillCorporatePriorityCombo'),
                    type: "POST",
                    data: JSON.stringify(),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (result) {
                        //Added By Usha Pandit On 11.06.2020 For getting current corporate priority value
                        var curCorporateVal = $("#pcprCboCorporatePriority").val();
                        //End Of Added By Usha Pandit On 11.06.2020 For getting current corporate priority value

                        var objCboOU = document.getElementById('pcprCboCorporatePriority');
                        if (objCboOU != null) {
                            $("#pcprCboCorporatePriority").empty();
                            $("#pcprCboCorporatePriority").append('<option value="">Select Corporate Priority</option>');
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.Priority;
                                objOption.value = ObjStatus.PriorityID;
                            }
                            //Added By Usha Pandit On 11.06.2020 For getting current corporate priority value
                            $("#pcprCboCorporatePriority").val(curCorporateVal);
                            //End Of Added By Usha Pandit On 11.06.2020 For getting current corporate priority value
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

            //End Added By Rutuja D. 6 Jan 2020 For Fill Drop Down Values In Type Of Issue Layout
        </script>

        <script>
            //$('.editor1').wysihtml5();
            //change date format
            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var uDatepicker = $.datepicker._updateDdatepicker;
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

            $(document).ready(function () {
                $("#prioAll").click(function () {
                    $(".priochck").prop('checked', $(this).prop('checked'));
                });
                $(".priochck").change(function () {                    
                    var rowCount = $("#tbodyProjectPriorities > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectPriorities");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#prioAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#prioAll").prop("checked", false);
                    }
                });
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
            //by vishal Mahajan 21-12-2019
            function CloseShowAlert2() {
                $('.ClosaeblealertMsg2').hide();
            }
            function showAlert2(Msg, className, id) {
                $('.ClosaeblealertMsg2').show();
                if (id != undefined) {
                    $('#' + id).prop("disabled", true);
                }
                if (className == 'alert-danger') {
                    $('#CloseableAlert2').removeClass("alert-success");
                    $('#CloseableAlert2').addClass("alert-danger");
                }
                else if (className == 'alert-success') {
                    $('#CloseableAlert2').removeClass("alert-danger");
                    $('#CloseableAlert2').addClass("alert-success");
                }
                $('#alertMsg2').html(Msg);
                $('.ClosaeblealertMsg2').delay(6000).fadeOut("fast", function () {
                    if (id != undefined) {
                        $('#' + id).prop("disabled", false);
                    }
                });
            }
            //by vishal Mahajan 21-12-2019
        </script>

        <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
        <script src="../../General/CommonValidations.js"></script>
    </div>
</body>
</html>
