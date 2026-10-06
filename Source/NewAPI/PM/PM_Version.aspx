<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Version.aspx.vb" Inherits="PbNIT.PM_Version" %>

<!DOCTYPE html>

<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Version")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head runat="server">
    <%--<meta charset="utf-8 " />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>Version</title>
    <!-- Tell the browser to be responsive to screen width -->

    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1" />
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2" />
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css.css?v=0" />
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.2" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />

<%--    <script src="../../General/CommonValidations.js"></script>
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

</head>

    <style type="text/css">
         .alertify-notifier {
            z-index: 99999 !important;
        }
         .alertify-notifier {
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
        }
        body { background:#fff; }
        .modalpgHead {background: #4263c1; color: #fff; font-family: 'Roboto', sans-serif; font-size:20px;}
        #tblpcvrVersion {margin:0 auto 20px;width:97%;}
        .lblcrsr {
            cursor: not-allowed !important;
        }
         #CloseableAlert .close {
            float: right;
            border: none;
        }
         .ClosaeblealertMsg{ display:none;}
    </style>

<body id="pcvrBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
   <div id="divProjectVersion">
    <div id="" class="tab-content practicesettinglist">
        <!--ps_Version_start-->
        <div class="modalpgHead pt-1 pb-1 col-sm-12">Version</div>
         <div class=" pt-1 pb-1 col-sm-12 text-end clearfix">
        <h5 class="float-start mb-0 px-3 pt-2">Project Name : <span id="ProjectName"></span></h5>
            </div>
        <div class="tab-pane pstbl_version pt-1 practicesettinglist in active" id="pstbl_Version">
            <table id="tblpcvrVersion" class="table table-stripped table-bordered tbl-version">
            </table>
            <div class="pl-20">
                <div class="input-wid-30">
                    <!-- Added By Gauri On 20th Aug 2024 For Alignment Issue -->
                    <button type="submit" class="btn borderbtn mr-5" id="btnpcvraddNewRow" data-bs-toggle="modal" data-bs-target="#VersionPopup"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                    <!-- End of Added By Gauri On 20th Aug 2024 For Alignment Issue -->
                    <button id="btnpcvrConfirmDelete" class="btn borderbtn"><%= MyBase.GetResourceString("C_Delete") %></button>
                    <%--<button id="Save-rowNew" class="btn btnyellow"><%= MyBase.GetResourceString("C_Save") %></button>--%>
                </div>
            </div>
        </div>
        <!--ps_Version_end-->
    </div>
    <!--Add new site modal end here-->

    <!-- Add new Version modal start here-->
    <div class="modal custmodal fade" id="VersionPopup" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Version") %></h5>
                    <button type="button" onclick="clearVersionDetails()" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6 mb-10">
                                <label><%= MyBase.GetResourceString("C_Version") %><span style="color: red">*</span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("pcvrtxtVersion", "pcvrtxtVersion", "text-field",, 50,,,,,,,,,,,,,,, True) %>
                            </div>
                            <div class="col-sm-6">
                                <label>&nbsp;</label>
                                <div class="custom_chckbox">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("pcvrchkCurrentVersion", "pcvrchkCurrentVersion") %>
                                    <label for="pcvrchkCurrentVersion"><%= MyBase.GetResourceString("C_CurrentVersion") %></label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="btns-center btn-grp-new">
                        <button data-bs-dismiss="modal" class="btn borderbtn" onclick="clearVersionDetails()"><%= MyBase.GetResourceString("C_Close") %></button>
                        <button id="btnpcvrSave" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Save") %></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add new Version modal end here-->

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
                        <h5>
                            <center><%= MyBase.GetResourceString("C_AL_ConfirmDelete") %>
                        </center>
                        </h5>
                    </div>
                  
                    <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button id="btnpcvrdelete" class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal">Yes</button>
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
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
    
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min"></script>--%>


    <script type="text/javascript">
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

        var flag;
        var ProjectVersionID;
        var objpcvrtxtVersion = document.getElementById("pcvrtxtVersion");
        var objpcvrchkCurrentVersion = document.getElementById("pcvrchkCurrentVersion");
        var colspn;
        var AddAccess = '<%= m_AddAccess %>';
        var EditAccess = '<%= m_EditAccess %>';
        var DeleteAccess = '<%= m_DeleteAccess %>';        
        var ViewAccess = "<%= m_ViewAccess %>";
        $(document).ready(ProjectVersionActions);


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

        $("#btnpcvraddNewRow").click(function () {
            $('#pcvrtxtVersion').val("");
            $('#pcvrchkCurrentVersion').prop('checked', false);
            flag = "POST";
        });
        $('#VersionPopup').on('hidden.bs.modal', function () {
            clearVersionDetails();
        });
        function clearVersionDetails() {
            $('#pcvrtxtVersion').val("");
            $('#pcvrchkCurrentVersion').prop('checked', false);
            flag = "POST";           
        }

        function ValidateFields() {
            var Version = $("#pcvrtxtVersion").val();
            if (Trim(objpcvrtxtVersion.value) == "") {
                showAlert('<%= MyBase.GetResourceString("C_AL_VersionBlank") %>', 'alert-danger');
                //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                var txtID = "#" + objpcvrtxtVersion.id;
                $(txtID).focus();
                //End of addition By Chetan M.
                
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
            else if (checkSpecialCharacter(Version, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Version should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#pcvrtxtVersion").focus();
                return false;
            }

            else {
                return true;
            }
        }


        //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
        function checkSpecialCharacter(value) {            
            var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
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
        //End of addition By Chetan M.

        function getURLParameter(url, name) {
            return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
        }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_Version%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_Version%>');
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
        $("#btnpcvrSave").click(function () {
            if (AddAccess == "True" || EditAccess == "True") {

                var valres = ValidateFields();

                if (valres)
                {
                    //added by imran on 06-09-2022
                    if (pcvrchkCurrentVersion.checked == true) {
                        var objpcvrchkCurrentVersion = 1
                    }
                    else {
                        var objpcvrchkCurrentVersion = 0;
                    }
                    if (ProjectVersionID == undefined) {
                        ProjectVersionID = 0;
                    }
                    //end of comment by imran on 06-09-2022

                    var taskParameters_s = {
                        ProjectID: encodeURI(ProjectID),
                        ProjectVersionID: encodeURI(ProjectVersionID),
                        Version: encodeURI(Trim(objpcvrtxtVersion.value)),
                        CurrentVersion: objpcvrchkCurrentVersion,
                        CreatedBy: encodeURI(UserName),
                        Command: encodeURI(flag)
                    }                   
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_Version/ProjectVersionActions',
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
                            if (data[0].ack == "AD") {
                                showAlert('<%= MyBase.GetResourceString("C_AL_Added") %>', 'alert-success');
                                ProjectVersionActions();
                                //Added by Chetan M on 06 Nov 2020 for get update added Priority
                                        flag = "PUT";
                                        ProjectVersionID = data[0].PK;
                                        //End of Added by Chetan M on 06 Nov 2020 for get update added Priority
                                //add by omkar 31/12/2019
                                //$('#VersionPopup').modal('toggle');//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                                //end of Add by omkar 31/12/2019
                                //Added By Reshma on 19th Dec 2019 For IssueID-20823                       
                                refreshMyParent();
                                //End Added By Reshma on 19th Dec 2019 For IssueID-20823  
                            } else if (data[0].ack == "AE" || data[0].ack == "NUPD") {
                                showAlert('<%= MyBase.GetResourceString("C_AL_VersionExists") %>', 'alert-danger');
                            } else if (data[0].ack == "UPD") {

                                showAlert('<%= MyBase.GetResourceString("C_AL_VersionUpdated") %>', 'alert-success');
                                ProjectVersionActions();
                                               
                                refreshMyParent();
                               
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

        $("#btnpcvrConfirmDelete").click(function () {
            var del = [];
            $.each($("input[name='Version']:checked"), function () {
                del.push($(this).val());
            });
            if (del.join(",") == "") {
                //$('#btnpcvrConfirmDelete').removeAttr('data-bs-target', '#CPdelSubtaskModal');
                $('#CPdelSubtaskModal').modal('hide');
                showAlert('<%= MyBase.GetResourceString("C_AL_VersionDeleteSelect") %>', 'alert-danger');
            }
            else {
                //$('#btnpcvrConfirmDelete').attr('data-bs-target', '#CPdelSubtaskModal');
                $('#CPdelSubtaskModal').modal('show');
            }
        });

        function ProjectVersionActions() {
            if (ViewAccess == "False") {
                var bodyHTML = '';
                bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                $("#divProjectVersion").html(bodyHTML);
                return;
            }
            StartLoader("#pcvrBodyID")
            GetProjectName();
            if (AddAccess == "False") {
               
                $("#btnpcvraddNewRow").hide();
                $("#btnpcvraddNewRow").addClass("lblcrsr");
            }
            else {
                $('#btnpcvraddNewRow').attr('data-bs-target', '#VersionPopup');
            }
            if (DeleteAccess == "False") {
               
                $("#btnpcvrConfirmDelete").hide();
                colspn = 2;
            }
            else {
                colspn = 3;
            }
            if (ProjectID != "") {
                var taskParameters_is = {
                    ProjectID: encodeURI(ProjectID),
                    Command: encodeURI('GET')
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_Version/ProjectVersionActions',
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
                        var setHTML = '<thead><tr><th width="40%"><%= MyBase.GetResourceString("C_VersionHead") %></th><th width="40%"><%= MyBase.GetResourceString("C_CurrentVersionHead") %></th>'
                        if (DeleteAccess == "True") {
                            setHTML += '<th class="text-center sm-wid"><div class="custom_chckbox"><input id="VersionAll" class="chckHead" type="checkbox"><label for="VersionAll"></label></div></th>'
                        }

                        setHTML += '</tr></thead>'
                        setHTML += ' <tbody id="tbodyProjectVersion">'
                        if (data.length != 0) {
                            for (var i = 0; i < data.length; i++) {
                                console.log(data);
                                var d = data[i];
                                var defltsav;
                                if (d.CurrentVersion == "0") { defltsev = "No" } else { defltsev = "Yes" }

                                setHTML += '<tr>'
                                if (EditAccess == "False") {
                                    setHTML += '<td>' + d.Versions + '</td>'
                                } else {
                                   
                                    setHTML += '<td><a href="#" data-bs-toggle="modal" onclick="setValues(' + d.ProjectVersionID + ',&quot;' + Trim(d.Versions) + '&quot;' + ',' + d.CurrentVersion + ')" data-bs-target="#VersionPopup">' + d.Versions + '</a></td>'
                                    


                                }
                                setHTML += '<td>' + defltsev + '</td>'

                                if (DeleteAccess == "True") {
                                    setHTML += '<td class="text-center sm-wid"><div class="custom_chckbox"><input id="pcvr' + d.Versions + '" value="' + d.ProjectVersionID + '"  class="chckHead versioncheck" name="Version" type="checkbox"><label for="pcvr' + d.Versions + '"></label></div></td>'
                                }
                                setHTML += '</tr>';
                            }
                        }
                        else {

                            setHTML += '<tr><td colspan="' + colspn +'"><span class="text-center"><%= MyBase.GetResourceString("C_AL_NoItem") %></span></td></tr>';
                        }
                        setHTML += '</tbody></table>'

                        $("#tblpcvrVersion").html(setHTML);                       
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
            $("#VersionAll").click(function () {
                $(".versioncheck").prop('checked', $(this).prop('checked'));
            });

            $(".versioncheck").change(function () {
                    var rowCount = $("#tbodyProjectVersion > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectVersion");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#VersionAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#VersionAll").prop("checked", false);
                    }
                }); 

            StopAjaxLoader("#pcvrBodyID")
        }
        
        $("#btnpcvrdelete").click(function () {
            if (DeleteAccess == "True") {
                var favorite = [];
                $.each($("input[name='Version']:checked"), function () {
                    favorite.push($(this).val());
                });

                if (favorite.join(",") != "") {
                    var taskParameters_ds = {
                        UniqueIDs: encodeURI(favorite.join(",")),
                        ProjectID: encodeURI(ProjectID)
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_Version/ProjectVersionDelete',
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
                            if (data[0].ack == "success") {
                                
                                //added and commented by omkar 18/3/2020 issue id 23069
                                 //showAlert(data[0].strResult, 'alert-success');
                                if (data[0].strResult.toString().indexOf("deleted successfully") != -1) {
                                    showAlert(data[0].strResult, 'alert-success');
                                    
                                } else {
                                    showAlert(data[0].strResult, 'alert-danger');

                                }
                                //end of  added and commented by omkar 18/3/2020 issue id 23069
                                ProjectVersionActions();
                                 //Added by omkar 6/01/2020 for issue 20832
                                refreshMyParent();
                                //End of added by omkar 6/01/2020 for issue 20832

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
                    showAlert('<%= MyBase.GetResourceString("C_AL_VersionDeleteSelect") %>', 'alert-danger');
                }
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
            }
        });

        function setValues(pvid, ver, cv) {

            flag = "PUT";
            ProjectVersionID = pvid;
            $('#pcvrtxtVersion').val(ver);
            $('#pcvrchkCurrentVersion').prop('checked', cv == 0 ? false : true);
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

        $(document).ready(function () {
            $("#VersionAll").click(function () {
                $(".versioncheck").prop('checked', $(this).prop('checked'));
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

    </script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
</div>
</body>
</html>
