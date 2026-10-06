<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_RootCauses.aspx.vb" Inherits="PbNIT.PM_RootCauses" %>

<!DOCTYPE html>

<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head runat="server">
    <%--<title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    <!-- custom style -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />

   <%-- <script src="../../General/CommonValidations.js"></script>
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

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

        #tblpcrcRootCause {
            margin: 0 auto 20px;
            width: 100%;
        }

        .lblcrsr {
            cursor: not-allowed !important;
        }

        #pstbl_rootcause .root-add-btn {
            margin-left: 0px;
        }


        .table tbody tr td {
            text-align: center;
            word-break: break-word !important;
        }
         .alertify-notifier { 
            z-index: 9999999 !important;
        }
         /*Added By RehanC for delete button and pop-up Issue on 29th Mar 2023*/
              #CloseableAlert .close {
            float: right;
            border: none;
        }
        .ClosaeblealertMsg{ display:none;}
        /*End Of Comment By RehanC on 29th Mar 2023*/
    </style>

<body id="pcrcBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectRootCauses">
        <div id="" class="tab-content practicesettinglist">
            <!--ps_list_table_start-->
            <div class="modalpgHead pt-1 pb-1 col-sm-12">Root causes</div>

            <div class=" pt-1 pb-1 col-sm-12 px-3 text-end clearfix">
                <h5 class="float-start mb-0">Project Name : <span id="ProjectName"></span></h5>
            </div>

            <%--<div class="tab-pane pstbl_rootcause px-3 pt-0 in active" id="pstbl_rootcause" style="border-top: 1px solid #ddd;">--%>
             <div class="tab-pane pstbl_rootcause px-3 pt-1 in active" id="pstbl_rootcause">
                <table id="tblpcrcRootCause" class="table table-stripped table-bordered tbl-rootcause">
                </table>
                <div class="root-add-btn">
                    <button id="btnpcrcaddNewRow" type="submit" class="btn borderbtn mr-5" data-bs-toggle="modal" data-bs-target="#addRootCausePopup"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                    <button id="btnpcrcConfirmDelete" class="btn borderbtn" data-bs-toggle="modal"><%= MyBase.GetResourceString("C_Delete") %></button>
                </div>
            </div>
            <!--ps_list_table_end-->
        </div>
        <!--Add new site modal end here-->

        <!--Add_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="addRootCausePopup" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_RootCauses") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%= MyBase.GetResourceString("C_Close") %>">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="tblpcrcRootCauseList" class="table table-stripped table-bordered form-group">
                        </table>
                        <!--<label class="control-label col-sm-4"></label> -->
                        <div class="btns-center btn-grp-new">
                            <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                            <button id="btnpcrcSave" class="btn btnyellow ml-1"><%= MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add_new_Sub_tasktype_modal_end_here-->

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
                        <div class="form-group mb-3">
                            <p class="text-center"><%= MyBase.GetResourceString("C_AL_ConfirmDelete") %></p>
                        </div>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button id="btnpcrcDelete" class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Delete_new_Sub_tasktype_modal_end_here-->

        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" style="top: 10px">
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

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            EmployeeID = '<%= Session("intUserID") %>';
            UserName = '<%= Session("strUserName") %>';

            var ProjectID = "<%= Request.QueryString("ProjectID") %>";

            ProjectName = '<%= Session("strProjectName") %>';
            var ViewAccess = "<%= m_ViewAccess %>";

            var colspn;
            var AddAccess = '<%= m_AddAccess %>';
            var EditAccess = '<%= m_EditAccess %>';
            var DeleteAccess = '<%= m_DeleteAccess %>';

            $('#btnpcrcaddNewRow').click(function () {
                RootCauseList();
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
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_RootCauses%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_RootCauses%>');
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
            $('#btnpcrcDelete').click(function () {
                if (DeleteAccess == "True") {
                    var UniqueIDs = [];
                    $.each($("input[name='rootcause']:checked"), function () {
                        UniqueIDs.push($(this).val());
                    });
                    if (UniqueIDs != "") {
                        var taskParameters_rcdl = {
                            UniqueIDs: encodeURI(UniqueIDs.join(",")),
                            ProjectID: encodeURI(ProjectID)
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_RootCauses/ProjectRootCausesDelete',
                            type: "POST",
                            data: JSON.stringify(taskParameters_rcdl),
                            dataType: "json",
                            async: false,
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_rcdl) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_rcdl) ? taskParameters_rcdl : JSON.stringify(taskParameters_rcdl)));
                                }
                            },
                            success: function (data) {
                                ProjectRootCauseActions();

                                if (data[0].strResult.toString().indexOf("cannot") != -1) {
                                    showAlert(data[0].strResult, 'alert-danger');
                                }
                                else {
                                    showAlert(data[0].strResult, 'alert-success');
                                }
                                //End Of Added By Usha Pandit On 04.05.2020 For showing proper notification for Root casue deletion
                                 //Commented By Dipali V On 29th March 2023 For Duplicate model pop up
                                //Add by omkar 31/12/2019
                                //$("#CPdelSubtaskModal").modal('toggle');
                                //end of add by  omkar 31/12/2019
                                 //End of Commented By Dipali V On 29th March 2023 For Duplicate model pop up
                                refreshMyParent();
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_AL_SelectOneRCDelete") %>', 'alert-danger');
                    }
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });

            $('#btnpcrcSave').click(function () {
                if (AddAccess == "True") {
                    var intRootCauseIDs = [];
                    $.each($("input[name='rootcauseInner']:checked"), function () {
                        intRootCauseIDs.push($(this).val());
                    });
                    if (intRootCauseIDs != "") {
                        var taskParameters_rcs = {
                            intRootCauseIDs: encodeURI(intRootCauseIDs.join(",")),
                            ProjectID: encodeURI(ProjectID),
                            Command: encodeURI('POST')
                        }
                        $.ajax({
                            //Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
                            //url: encodeURI(strUrl) + '/api/PM_RootCauses/ProjectRootCausesActions',
                            url: encodeURI(strUrl) + '/api/PM_RootCauses/New_ProjectRootCausesActions',
                            //End of Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
                            type: "POST",
                            data: JSON.stringify(taskParameters_rcs),
                            dataType: "json",
                            async: false,
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_rcs) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_rcs) ? taskParameters_rcs : JSON.stringify(taskParameters_rcs)));
                                }
                            },
                            success: function (data) {
                                showAlert(data[0].strResult, 'alert-success');
                                ProjectRootCauseActions();
                                // $('#addRootCausePopup').modal('toggle');//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                                refreshMyParent();
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_AL_SelectOneRC") %>', 'alert-danger');
                    }
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });

            $("#btnpcrcConfirmDelete").click(function () {
                var del = [];
                $.each($("input[name='rootcause']:checked"), function () {
                    del.push($(this).val());
                });
                if (del.join(",") == "") {
                    //Commented and Modified By RehanC for delete button Issue on 29th Mar 2023
                    //$('#btnpcrcConfirmDelete').removeAttr('data-bs-target', '#CPdelSubtaskModal');
                    $('#CPdelSubtaskModal').modal('hide');
                    showAlert('<%= MyBase.GetResourceString("C_AL_SelectOneRCDelete") %>', 'alert-danger');
                    //End Of Comment By RehanC for delete button Issue on 29th Mar 2023
                }
                else {
                    //Commented and Modified By RehanC for delete button Issue on 29th Mar 2023
                    //$('#btnpcrcConfirmDelete').attr('data-bs-target', '#CPdelSubtaskModal');
                    $('#CPdelSubtaskModal').modal('show');
                    //End Of Comment By RehanC for delete button Issue on 29th Mar 2023
                }
            });

            $(document).ready(ProjectRootCauseActions);


            function ProjectRootCauseActions() {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectRootCauses").html(bodyHTML);
                    return;
                }
                StartLoader("#pcrcBodyID")
                GetProjectName();
                setHTML = '';
                if (AddAccess == "False") {
                    //$("#btnpcrcaddNewRow").attr("disabled", true);//.hide();
                    $("#btnpcrcaddNewRow").hide();
                    $("#btnpcrcaddNewRow").addClass("lblcrsr");
                }
                else {
                    $('#btnpcrcaddNewRow').attr('data-bs-target', '#addRootCausePopup');
                }
                if (DeleteAccess == "False") {
                    // $("#btnpcrcConfirmDelete").attr("disabled", true);//.hide();
                    $("#btnpcrcConfirmDelete").hide();
                    colspn = 2;
                }
                else {
                    colspn = 3;
                }
                if (ProjectID != "") {
                    var taskParameters_rc = {
                        ProjectID: encodeURI(ProjectID),
                        Command: encodeURI('GETPRC')
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_RootCauses/ProjectRootCausesActions',
                        type: "POST",
                        data: JSON.stringify(taskParameters_rc),
                        dataType: "json",
                        async: false,
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (taskParameters_rc) {
                                xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_rc) ? taskParameters_rc : JSON.stringify(taskParameters_rc)));
                            }
                        },
                        success: function (data) {
                            var setHTML = '<thead><tr><th><%= MyBase.GetResourceString("C_RootCauseCodeHead") %></th><th><%= MyBase.GetResourceString("C_RootCausesHead") %></th>'
                            if (DeleteAccess == "True") {
                                setHTML += '<th class="text-center sm-wid"><div class="custom_chckbox"><input id="RootCauseAll" class="chckHead" type="checkbox"><label for="RootCauseAll"></label></div></th>'
                            }
                            setHTML += '</tr></thead>'
                            setHTML += ' <tbody id="tbodyProjectRootCause">'
                            if (data.length != 0) {
                                for (var i = 0; i < data.length; i++) {
                                    console.log(data);
                                    var d = data[i];
                                    setHTML += '<tr>'
                                    if (EditAccess == "False") {
                                        setHTML += '<td>' + d.RootCauseCode + '</td>'
                                    } else {
                                        setHTML += '<td>' + d.RootCauseCode + '</td>'
                                    }
                                    setHTML += '<td>' + d.RootCause + '</td>'
                                    if (DeleteAccess == "True") {
                                        setHTML += '<td class="text-center sm-wid"><div class="custom_chckbox"><input id="pcrc' + d.ProjectRootCauseID + '" value="' + d.ProjectRootCauseID + '"  class="chckHead rootcausecheck" name="rootcause" type="checkbox"><label for="pcrc' + d.ProjectRootCauseID + '"></label></div></td>'
                                    }
                                    setHTML += '</tr>';
                                }
                            }
                            else {
                                setHTML += '<tr><td colspan="' + colspn + '"><span class="text-center"><%= MyBase.GetResourceString("C_AL_NoItem") %></span></td></tr>';
                            }
                            setHTML += '</tbody></table>'
                            $("#tblpcrcRootCause").html(setHTML);
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
                $("#RootCauseAll").click(function () {
                    $(".rootcausecheck").prop('checked', $(this).prop('checked'));
                });

                $(".rootcausecheck").change(function () {
                    var rowCount = $("#tbodyProjectRootCause > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectRootCause");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#RootCauseAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#RootCauseAll").prop("checked", false);
                    }
                });


                StopAjaxLoader("#pcrcBodyID")
            }

            function RootCauseList() {
                setHTML = '';
                var taskParameters_rcl = {
                    ProjectID: encodeURI(ProjectID),
                    Command: encodeURI('GETRCL')
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_RootCauses/ProjectRootCausesActions',
                    type: "POST",
                    data: JSON.stringify(taskParameters_rcl),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (taskParameters_rcl) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_rcl) ? taskParameters_rcl : JSON.stringify(taskParameters_rcl)));
                        }
                    },
                    success: function (data) {
                        var setHTML = '<thead><tr><th><%= MyBase.GetResourceString("C_RootCauseCodeHead") %></th>'
                        //Added By Dipali V On 15th April 2020 For Caption Change Issues
                        setHTML += '<th>Root Causes</th>'
                        //End of Added By Dipali V On 15th April 2020 For Caption Change Issues
                        setHTML += '<th class="text-center sm-wid"><div class="custom_chckbox"><input id="rootcauseInnerAll" class="chckHead" type="checkbox"><label for="rootcauseInnerAll"></label></div></th>'
                        setHTML += '</tr></thead>'
                        setHTML += ' <tbody id="tbodyAddProjectRootCause">'
                        if (data.length != 0) {
                            for (var i = 0; i < data.length; i++) {
                                console.log(data);
                                var d = data[i];
                                setHTML += '<tr>'
                                setHTML += '<td>' + d.RootCauseCode + '</td>'
                                setHTML += '<td>' + d.RootCause + '</td>'
                                setHTML += '<td class="text-center sm-wid"><div class="custom_chckbox"><input id="pcrcl' + d.RootCauseID + '" value="' + d.RootCauseID + '"  class="chckHead innerchck" name="rootcauseInner" type="checkbox">'
                                setHTML += '<label for= "pcrcl' + d.RootCauseID + '" ></label ></div ></td > '
                                setHTML += '</tr>';
                            }
                        }
                        else {
                            setHTML += '<tr><td colspan="3"><span class="text-center"><%= MyBase.GetResourceString("C_AL_NoItem") %></span></td></tr>';
                        }
                        setHTML += '</tbody></table>'
                        $("#tblpcrcRootCauseList").html(setHTML);
                        return false;
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                $("#rootcauseInnerAll").click(function () {
                    $(".innerchck").prop('checked', $(this).prop('checked'));
                });

                $(".innerchck").change(function () {
                    var rowCount = $("#tbodyAddProjectRootCause > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyAddProjectRootCause");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#rootcauseInnerAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#rootcauseInnerAll").prop("checked", false);
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
