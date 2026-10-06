<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TaskType.aspx.vb" Inherits="PbNIT.PM_TaskType" %>

<!DOCTYPE html>

<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head runat="server">
    <%--<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
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

        .subtypebtnlist .btn {
            margin-left: 5px;
        }

        .subtasktyediv {
            position: relative;
        }

            .subtasktyediv a.accordion-toggle {
                left: 0;
            }
            .modal-header{display:block}
    </style>

<body id="pcttBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectTaskType">
        <div id="practicetasktype" class="tab-content practicesettinglist">
            <!--ps_list_table_start-->
            <div class="tab-pane active pstbl_tasktype pt-0" id="pstbl-tasktype" style="border-top: 1px solid #ddd;">
                <div class="modalpgHead pt-1 pb-1 col-sm-12">Task Type</div>

                <div class=" pt-1 pb-1 col-sm-12 text-end">
                    <h5 class="float-start mb-0">Project Name : <span id="TaskTypeProjectName"></span></h5>
                    <div class="">
                        <a id="btnpcttCPaddnewtsktype" class="btn borderbtn mr-5" href="javascript:;" data-bs-toggle="modal"><%= MyBase.GetResourceString("C_AddNew") %></a>
                        <button type="submit" id="btnpcttDeleteTask" data-bs-toggle="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Delete") %></button>
                    </div>
                </div>


                <div class="col-sm-12">
                    <table id="tblpcttTaskType" class="table table-bordered">
                    </table>
                    <div class="clearfix"></div>
                </div>
            </div>
            <!--ps_list_table_end-->
        </div>
        <!--Add new site modal end here-->

        <!--Add new task start here-->
        <div class="modal custmodal fade" id="newTaskTypePopup" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_TaskType") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4"><%= MyBase.GetResourceString("C_TaskType") %></label>
                                <div class="col-sm-8">
                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcttcboTaskType", "Select 0,'--select--' ",,, "class='form-control selectpicker'", True,, ) %>--%>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("pcttcboTaskType", "Select 0,'--select--' ",,, "class='form-control'", True,, ) %>
                                    <%--     <select  class="form-control selectpicker">
                                </select>--%>
                                </div>
                            </div>
                        </div>
                        <div class="">
                            <div class="row">
                                <!--<label class="control-label col-sm-4"></label>-->
                                <div class="col-sm-12 btns-center btn-grp-new">
                                    <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                                    <%--<button data-bs-dismiss="modal" id="btnpcttSaveTaskType" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Save") %></button>--%>
                                    <%--Added By Rutuja D. 19 Dec 2019 --%>
                                    <button id="btnpcttSaveTaskType" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Save") %></button>

                                    <%-- End Added By Rutuja D. 19 Dec 2019--%>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Add new task end here-->


        <!--Add_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPaddSubtaskModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_AddNewSubTask") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4"><%= MyBase.GetResourceString("C_SubTaskType") %></label>
                                <div class="col-sm-8">
                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("pcttcboSubTaskType", "usp_Whizible2_Sel_ListOfSubTasks_ForInheriting_New " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control selectpicker'", True,, ) %>--%>
                                    <select id="pcttcboSubTaskType" class="form-control ">
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="">
                            <div class="row">
                                <!--<label class="control-label col-sm-4"></label>-->
                                <div class="col-sm-12 btns-center btn-grp-new">
                                    <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                                    <%--<button data-bs-dismiss="modal" id="btnpcttSaveSubTaskType" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Save") %></button>--%>
                                    <%--by vishal Mahajan 21-12-2019--%>
                                    <button id="btnpcttSaveSubTaskType" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Save") %></button>
                                    <%--by vishal Mahajan 21-12-2019--%>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add_new_Sub_tasktype_modal_end_here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true" data-bs-dismiss="modal">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_DeleteSubTask") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5 class="text-center">
                                <%= MyBase.GetResourceString("C_AL_SConfirmDelete") %>
                            </h5>
                        </div>
                        <br />
                        <div class="text-center btn-grp-new">
                            <button data-bs-dismiss="modal" class="btn borderbtn">No</button>
                            <button data-bs-dismiss="modal" id="btnpcttsdelete" class="btn btnyellow ml-1">Yes</button>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdeltaskModal" aria-hidden="true" data-bs-dismiss="modal">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_DeleteTask") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5 class="text-center">
                                <%= MyBase.GetResourceString("C_AL_TConfirmDelete") %> 
                            </h5>
                        </div>
                        <%--<div class="text-center">
                            <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                            <button data-bs-dismiss="modal" id="btnpctttdelete" class="btn btnyellow ml-1"><%= MyBase.GetResourceString("C_Okay") %></button>
                        </div>--%>
                        <div class="">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button id="btnpctttdelete" class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--Delete_new_Sub_tasktype_modal_end_here-->

        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" style="top: 10px!important">
            <button type="button" onclick="CloseShowAlert()" class="close">×</button>
            <p id="alertMsg"></p>
        </div>
                
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
        <!-- jqueryUI js -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
       
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
       
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>       
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
        <script src="../../General/CommonValidations.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            EmployeeID = '<%= Session("intUserID") %>';
            UserName = '<%= Session("strUserName") %>';
       <%-- ProjectID = '<%= Session("intProjectID") %>';--%>
            var ProjectID;
            ProjectName = '<%= Session("strProjectName") %>';

            var colspn;
            var delsubtaskIDs = [];
            var TaskTypeID;
            var AddAccess = '<%= m_AddAccess %>';
            var EditAccess = '<%= m_EditAccess %>';
            var DeleteAccess = '<%= m_DeleteAccess %>';
            var ViewAccess = '<%= m_ViewAccess %>';
            $(document).ready(ProjectTaskTypeActions);
            //ProjectID1 = $.url.attr('ProjectID');

            ProjectID = "<%= Request.QueryString("ProjectID") %>";

            // alert(param);
            //`alert(ViewAccess);
            function ProjectTaskTypeActions() {
                try {
                    if (ViewAccess == "False") {
                        var bodyHTML = '';
                        bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                        $("#divProjectTaskType").html(bodyHTML);
                        return;
                    }
                    StartLoader("#pcttBodyID")

                    GetTaskTypes();
                    GetProjectName();
                    var setHTML = '';

                    if (ProjectID != "") {
                        var taskParameters_tt = {
                            ProjectID: encodeURI(ProjectID),
                            Command: encodeURI('GETT')
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectTaskTypeActions',
                            type: "POST",
                            data: JSON.stringify(taskParameters_tt),
                            dataType: "json",
                            async: false,
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_tt) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_tt) ? taskParameters_tt : JSON.stringify(taskParameters_tt)));
                                }
                            },
                            success: function (data) {
                                setHTML += '<thead>'
                                setHTML += '<tr>'
                                setHTML += '<th width="25%" class="text-start"><%= MyBase.GetResourceString("C_TaskType") %></th>'
                                if (AddAccess == "True" || EditAccess == "True") {
                                    setHTML += '<th class="text-start">'
                                }
                                else {
                                    setHTML += '<th class="text-start">'
                                }

                                setHTML += 'Description'


                                setHTML += '</th>'
                                setHTML += '<th width="20%">'
                                setHTML += 'Set as Default'
                                setHTML += '</th>'

                                if (DeleteAccess == "True") {
                                    setHTML += '<th class="">'
                                    setHTML += '<a href="javascript:;">'
                                    setHTML += '<div class="custom_chckbox">'
                                    setHTML += '<input id="tasktypeSelectAll" class="chckHead" type="checkbox">'
                                    setHTML += '<label for="tasktypeSelectAll" style="margin-right:-15px"></label>'
                                    setHTML += '</div>'
                                    setHTML += '</a>'
                                    setHTML += '</th>'
                                }
                                setHTML += '</tr>'
                                setHTML += '</thead>'
                                setHTML += '<tbody>'
                                var LTaskTypeID = 0;
                                var NTaskTypeID;
                                for (var i = 0; i < data.length; i++) {

                                    var d = data[i];
                                    NTaskTypeID = d.TaskTypeID
                                    //NO ANY BIND
                                    if (LTaskTypeID != NTaskTypeID) {
                                        //SetForAllNestedCheckBox(d.TaskTypeID);
                                        if (LTaskTypeID != 0) {
                                            setHTML += '</tbody>'
                                            setHTML += '</table>'
                                            setHTML += '</div>'
                                            setHTML += '</div>'
                                            setHTML += '</div>'
                                            setHTML += '</td>'
                                            setHTML += '</tr>'
                                        }
                                        setHTML += '<tr>'
                                        setHTML += '<td class="text-start">'
                                        setHTML += '<div class="subtasktyediv">'
                                        setHTML += '<a data-bs-toggle="collapse" data-bs-target="#CPSTTpanel' + d.TaskTypeID + '" class="accordion-toggle collapsed" aria-expanded="false">'
                                        setHTML += '<img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px"></a> ' + d.TaskType
                                        setHTML += '</div>'
                                        setHTML += '</td>'
                                        setHTML += '<td class="text-start ps_detailtext">'
                                        if (d.SubTaskList == "NRE") {
                                            setHTML += '<p class="more"></p>'
                                        }
                                        else {
                                            setHTML += '<p class="more">' + d.SubTaskList + '</p>'
                                        }
                                        setHTML += '</td>'
                                        if (AddAccess == "True" || EditAccess == "True") {
                                            setHTML += '<td onclick=setasdefaultTask(' + d.TaskTypeID + ')>'
                                            if (d.DefaultTaskType) {
                                                setHTML += '<a href="javascript::" class="btn borderbtn borderbtnfill" style="width:122px">' + d.SetasDefault + '</a>'
                                            } else {
                                                setHTML += '<a href="javascript::" class="btn borderbtn">' + d.SetasDefault + '</a>'
                                            }
                                            setHTML += '</td>'
                                        }
                                        else {
                                            setHTML += '<td>'
                                            //if (d.DefaultTaskType) {
                                            //    setHTML += '<a class="btn borderbtn borderbtnfill">' + d.SetasDefault + '</a>'
                                            //} else {
                                            //    setHTML += '<a class="btn borderbtn">' + d.SetasDefault + '</a>'
                                            //}
                                            setHTML += '</td>'
                                        }
                                        if (DeleteAccess == "True") {
                                            setHTML += '<td width="5%" class="text-end">'
                                            //setHTML += '<a class="closeaction removerow nostylebtn" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Delete"></i></a>'
                                            setHTML += '<div class="custom_chckbox">'
                                            if (d.AllowDeleteTask) {
                                                setHTML += '<input id="tasktypecheck' + d.TaskTypeID + '" class="chcktbl taskchck" value="' + d.TaskTypeID + '" name="pctttaskdel" type="checkbox" >'
                                                setHTML += '<label for="tasktypecheck' + d.TaskTypeID + '"></label>'
                                            }
                                            else {
                                                setHTML += '<input id="tasktypecheck' + d.TaskTypeID + '" class="chcktbl taskchckx" type="checkbox">'
                                                setHTML += '<label  style="cursor: not-allowed !important; " for="tasktypecheckx' + d.TaskTypeID + '"></label>'
                                            }
                                            setHTML += '</div>'
                                            setHTML += '</td>'
                                        }
                                        setHTML += '</tr>'
                                        //<!--start subtasktype hidden row-->
                                        setHTML += '<tr>'
                                        setHTML += '<td colspan="5" class="hiddenRow subtasktypeTD text-start">'
                                        setHTML += '<div class="accordian-body collapse" id="CPSTTpanel' + d.TaskTypeID + '">'
                                        setHTML += '<div class="row pt-1 pb-1 bgwhite">'
                                        setHTML += '<div class="col-sm-8">'
                                        setHTML += '<h5><strong><%= MyBase.GetResourceString("C_SubTaskType") %></strong></h5>'
                                        setHTML += '</div>'
                                        setHTML += '<div class="col-sm-4 mb-1">'
                                        setHTML += '<div class="subtypebtnlist float-end">'
                                        setHTML += '<button data-bs-toggle="collapse" data-bs-target="#CPSTTpanel' + d.TaskTypeID + '" class="btn borderbtn mr-"><%= MyBase.GetResourceString("C_Close") %></button>'
                                        if (DeleteAccess == "True") {
                                            setHTML += '<button data-bs-toggle="modal" id="btnpcttDeleteSubtask' + d.TaskTypeID + '" onclick=setValuesForMultiDelete(' + d.TaskTypeID + ') class="btn borderbtn clsBtnDeleteSubTask"><%= MyBase.GetResourceString("C_Delete") %></button>'
                                        } else {
                                            setHTML += '<button data-bs-toggle="modal" disabled=true id="btnpcttDeleteSubtask' + d.TaskTypeID + '" onclick=setValuesForMultiDelete(' + d.TaskTypeID + ') class="btn borderbtn clsBtnDeleteSubTask"><%= MyBase.GetResourceString("C_Delete") %></button>'
                                        }
                                        if (AddAccess == "True") {
                                            setHTML += '<button data-bs-toggle="modal" id="btnpcttAddSubtask" onclick=bindSubtaskCob(' + d.TaskTypeID + ')  class="btn btnyellow clsBtnAddSubtask"><%= MyBase.GetResourceString("C_Add") %></button>'
                                        }
                                        else {
                                            setHTML += '<button data-bs-toggle="modal" disabled=true id="btnpcttAddSubtask" onclick=bindSubtaskCob(' + d.TaskTypeID + ')  class="btn btnyellow clsBtnAddSubtask"><%= MyBase.GetResourceString("C_Add") %></button>'
                                        }

                                        setHTML += '</div>'
                                        setHTML += '</div>'
                                        setHTML += '<div class="clearfix"></div>'
                                        setHTML += '<div class="table-responsive col-sm-12">'
                                        setHTML += '<table class="table CPsubtypetbl table-bordered">'
                                        setHTML += '<thead>'
                                        setHTML += '<tr>'
                                        setHTML += '<th><%= MyBase.GetResourceString("C_TaskTypeName") %></th>'

                                        if (DeleteAccess == "True") {
                                            setHTML += '<th width="10%">'
                                            setHTML += '<div class="custom_chckbox">'
                                            setHTML += '<input type="checkbox" id="DeleteSTTcheckALL' + d.TaskTypeID + '" class="chckHead"><label onclick="SetForAllNestedCheckBox(' + d.TaskTypeID + ')" for="DeleteSTTcheckALL' + d.TaskTypeID + '"></label>'
                                            setHTML += '</div>'
                                            setHTML += '</th>'
                                        }

                                        setHTML += '</tr>'
                                        setHTML += '<!--end subtasktype hidden row-->'
                                        setHTML += '</thead>'
                                        setHTML += '<tbody>'
                                        LTaskTypeID = data[i].TaskTypeID
                                    }
                                    //FOR LOOP TRAVEL
                                    if (d.SubTaskList == "NRE") {
                                        setHTML += '<tr>'
                                        setHTML += '<td colspan="2" style="text-align:center!important;"><span class="text-center"><%= MyBase.GetResourceString("C_AL_SNoItem") %></span>'
                                        setHTML += '</td>'
                                        setHTML += '</tr>'
                                    }
                                    else {
                                        setHTML += '<tr>'
                                        setHTML += '<td>'
                                        setHTML += d.SubTaskType
                                        //setHTML += '< a href = "javascript:;" data - toggle="modal" data - target="#CPaddSubtaskModal" > ' + d.SubTaskType + '</a >
                                        setHTML += '</td > '
                                        if (DeleteAccess == "True") {
                                            setHTML += '<td>'
                                            setHTML += '<div class="custom_chckbox">'
                                            if (d.AllowDeleteSubTask) {
                                                setHTML += '<input type = "checkbox"  id = "DeleteSTTcheck' + d.TaskTypeID + '_' + d.SubTaskTypeID + '" value="' + d.ProjectSubTaskTypeID + '" name="pcttsubtaskdel' + d.TaskTypeID + '" class="chcktbl taskchck' + d.TaskTypeID + '" onchange="checkboxchekd(this);">'
                                                setHTML += '<label   for="DeleteSTTcheck' + d.TaskTypeID + '_' + d.SubTaskTypeID + '"></label>'
                                            }
                                            else {
                                                setHTML += '<input type = "checkbox"  id = "DeleteSTTcheck' + d.TaskTypeID + '_' + d.SubTaskTypeID + '" class="chcktbl taskchckx' + d.TaskTypeID + '" onchange="checkboxchekd(this);" >'
                                                setHTML += '<label style="cursor: not-allowed !important; " for="DeleteSTTcheckx' + d.TaskTypeID + '_' + d.SubTaskTypeID + '"></label>'
                                            }
                                            setHTML += '</div>'
                                            setHTML += '</td>'
                                        }
                                        setHTML += '</tr>'
                                    }
                                    //if (LTaskTypeID != NTaskTypeID) {
                                    //    setHTML += '</tbody>'
                                    //    setHTML += '</table>'
                                    //    setHTML += '</div>'
                                    //    setHTML += '</div>'
                                    //    setHTML += '</div>'
                                    //    setHTML += ' </td>'
                                    //    setHTML += '</tr>'
                                    //}
                                    //<!--End subtasktype hidden row-->
                                    //< !--subtask type 3 end-- >
                                }
                                //    setHTML += '</tbody>'
                                //    setHTML += '</table>'
                                //    setHTML += '</div>'
                                //    setHTML += '</div>'
                                //    setHTML += '</div>'
                                //    setHTML += ' </td>'
                                //    setHTML += '</tr>'
                                setHTML += '</tbody >'
                                $("#tblpcttTaskType").html(setHTML);
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

                    if (AddAccess == "False") {
                        $("#btnpcttCPaddnewtsktype").hide();
                        $(".clsBtnAddSubtask").hide();
                        // $("#btnpcttCPaddnewtsktype").attr("disabled", true);
                        // $("#btnpcttAddSubtask").attr("disabled", true);

                    }
                    else {
                        $('#btnpcttCPaddnewtsktype').attr('data-bs-target', '#newTaskTypePopup');
                    }
                    if (DeleteAccess == "False") {
                        $("#btnpcttDeleteTask").hide();
                        $(".clsBtnDeleteSubTask").hide();
                        // $("#btnpcttDeleteTask").attr("disabled", true);//.hide();
                        // $("#btnpcttDeleteSubtask").attr("disabled", true);//.hide();
                    }
                    $("#tasktypeSelectAll").click(function () {
                        $(".taskchck").prop('checked', $(this).prop('checked'));
                    });
                    //add by omkar 31/12/2019 for  check box checked or unchecked
                    $(".taskchck").click(function () {

                        HeadCheckBoxChecked();
                    });
                    //end of add by omkar 31/12/2019 for  check box checked or unchecked
                    StopAjaxLoader("#pcttBodyID")
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }//ProjectTaskTypeActions

            $("#btnpcttDeleteTask").click(function () {
                var del = [];
                $.each($("input[name='pctttaskdel']:checked"), function () {
                    del.push($(this).val());
                });
                if (del.join(",") == "") {
                    $('#btnpcttDeleteTask').removeAttr('data-bs-target', '#CPdeltaskModal');
                    showAlert('<%= MyBase.GetResourceString("C_AL_TSelect") %>', 'alert-danger');
                }
                else {
                    $('#btnpcttDeleteTask').attr('data-bs-target', '#CPdeltaskModal');
                }
            });
             //add by omkar 31/12/2019 for Head / main check box checked or unchecked
            function HeadCheckBoxChecked() {

                var nocheckbox = $("#tblpcttTaskType > tbody > tr> td.text-end > div>label[style='cursor: not-allowed !important; ']").length;
                var TotalCheckBox = $("#tblpcttTaskType > tbody > tr> td.text-end > div>label").length;
                var ActualCheckBox = TotalCheckBox - nocheckbox;
                var checkedcnt = $("#tblpcttTaskType > tbody > tr> td > div>input[type=checkbox]:checked").length;
                if (ActualCheckBox == checkedcnt) {
                    $("#tblpcttTaskType > thead > tr > th:nth-child(4) > a > div>input#tasktypeSelectAll").prop('checked', true);
                } else {
                    $("#tblpcttTaskType > thead > tr > th:nth-child(4) > a > div>input#tasktypeSelectAll").prop('checked', false);
                }

            }
            //end of add by omkar 31/12/2019 for Head / main check box checked or unchecked
            function GetProjectName() {
                $("#TaskTypeProjectName").empty();
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
                            $("#TaskTypeProjectName").append(result[0].ProjectName);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

            function GetTaskTypes() {

                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_TaskType/GetTaskTypeData'),
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
                        var objCboOU = document.getElementById('pcttcboTaskType');
                        if (objCboOU != null) {
                            $("#pcttcboTaskType").empty();

                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];
                                var objOption = document.createElement("OPTION");
                                objCboOU.options.add(objOption);
                                objOption.text = ObjStatus.TaskType;
                                objOption.value = ObjStatus.TaskTypeID;
                                // Added By Rutuja D. 19 Dec 2019 For PlaceHolder From Sp
                                //objOption.value = ObjStatus.TaskTypeID == 0 ? '' : ObjStatus.TaskTypeID;
                                // End Added By Rutuja D. 19 Dec 2019 For PlaceHolder From Sp
                            }
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }

            $('#btnpcttCPaddnewtsktype').click(function () {
                //$('#pcttcboTaskType').val("");
                //Added by Chetan M on 29 Dec 2020 for Issue fixing
                $('#pcttcboTaskType').val("0");
                //End of Added by Chetan M on 29 Dec 2020 for Issue fixing
            });
            $('#btnpcttSaveTaskType').click(function () {
                if (AddAccess == "True") {
                    if ($('#pcttcboTaskType').val() != "" && $('#pcttcboTaskType').val() != null && $('#pcttcboTaskType').val() != "0") {
                        var taskParameters_adt = {
                            intTaskTypeID: encodeURI($('#pcttcboTaskType').val()),
                            ProjectID: encodeURI(ProjectID),
                            Command: encodeURI('POSTT')
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectTaskTypeActions',
                            type: "POST",
                            data: JSON.stringify(taskParameters_adt),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_adt) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_adt) ? taskParameters_adt : JSON.stringify(taskParameters_adt)));
                                }
                            },
                            success: function (data) {
                                if (data[0].ack == "AD") {
                                    //window.location.reload();
                                    ProjectTaskTypeActions();
                                    showAlert('<%= MyBase.GetResourceString("C_AL_TAdded") %>', 'alert-success');
                                    //ProjectTaskTypeActions();
                                    // Added By Rutuja D For Close Modal After Saving
                                    //commented by omkar 24/3/2020 issue id 23005
                                   // $('#newTaskTypePopup').modal('toggle');
                                    //end of commented by omkar 24/3/2020 issue id 23005
                                    // End Added By Rutuja D For Close Modal After Saving

                                } else if (data[0].ack == "AE") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_TAddedAE") %>', 'alert-danger');
                                    // Added By Rutuja D For Do not Close Modal 
                                    $('#newTaskTypePopup').modal('toggle');
                                    //End Added By Rutuja D For Do not Close Modal 
                                } else {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_TAddFailed") %>', 'alert-danger');
                                }
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        $("#pcttcboTaskType").focus();
                        showAlert('<%= MyBase.GetResourceString("C_AL_SelectTaskType") %>', 'alert-danger');
                    }
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });
            function bindSubtaskCob(tsktid) {

                TaskTypeID = tsktid
                var taskParameters_cbs = {
                    intTaskTypeID: encodeURI(tsktid),
                    ProjectID: encodeURI(ProjectID),
                    Command: encodeURI('GETS')
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectTaskTypeActions',
                    type: "POST",
                    data: JSON.stringify(taskParameters_cbs),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (taskParameters_cbs) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_cbs) ? taskParameters_cbs : JSON.stringify(taskParameters_cbs)));
                        }
                    },
                    success: function (data) {

                        var setcboHTML = ''
                         //by vishal Mahajan 21-12-2019
                        setcboHTML += "<option value=''> Select Sub Task Type </option>";
                        //by vishal Mahajan 21-12-2019
                        for (var i = 0; i < data.length; i++) {
                            setcboHTML += '<option value="' + data[i].SubTaskTypeID + '">' + data[i].SubTaskType + '</option>'
                        }
                        $("#pcttcboSubTaskType").html(setcboHTML);
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

                //data-bs-target="#CPaddSubtaskModal"
                $('#CPaddSubtaskModal').modal('toggle');
            }
            $('#btnpcttSaveSubTaskType').click(function () {
                if (AddAccess == "True") {
                    if ($('#pcttcboSubTaskType').val() != "" && $('#pcttcboSubTaskType').val() != null) {
                        var taskParameters_adt = {
                            intSubTaskTypeID: encodeURI($('#pcttcboSubTaskType').val()),
                            intTaskTypeID: encodeURI(TaskTypeID),
                            ProjectID: encodeURI(ProjectID),
                            Command: encodeURI('POSTS')
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectTaskTypeActions',
                            type: "POST",
                            data: JSON.stringify(taskParameters_adt),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_adt) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_adt) ? taskParameters_adt : JSON.stringify(taskParameters_adt)));
                                }
                            },
                            success: function (data) {
                                //by vishal Mahajan 21-12-2019
                                $("#CPaddSubtaskModal").modal("hide");
                                //by vishal Mahajan 21-12-2019
                                console.log(data);
                                if (data[0].ack == "AD") {
                                    //window.location.reload();
                                    ProjectTaskTypeActions();
                                    showAlert('<%= MyBase.GetResourceString("C_AL_SAdded") %>', 'alert-success');
                                    //ProjectTaskTypeActions();

                                } else if (data[0].ack == "AE") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_SAddedAE") %>', 'alert-danger');
                                } else {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_SAddFailed") %>', 'alert-danger');
                                }
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        $("#pcttcboSubTaskType").focus();
                        showAlert('<%= MyBase.GetResourceString("C_AL_SelectSubTaskType") %>', 'alert-danger');
                    }
                }
            else {
                showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });
            function SetForAllNestedCheckBox(tid) {
                $("#DeleteSTTcheckALL" + tid).click(function () {
                    $(".taskchck" + tid).prop('checked', $(this).prop('checked'));
                });
            }
            function setValuesForMultiDelete(ttid) {
                delsubtaskIDs = [];
                var ctrlname = "pcttsubtaskdel" + ttid;
                $.each($("input[name=" + ctrlname + "]:checked"), function () {
                    delsubtaskIDs.push($(this).val());
                });
                if (delsubtaskIDs.join(",") == "") {
                    $('#btnpcttDeleteSubtask' + ttid + '').removeAttr('data-bs-target', '#CPdelSubtaskModal');
                    showAlert('<%= MyBase.GetResourceString("C_AL_SSelect") %>', 'alert-danger');
                }
                else {
                    $('#btnpcttDeleteSubtask' + ttid + '').attr('data-bs-target', '#CPdelSubtaskModal');
                }
            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_TaskTypeToken%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_TaskTypeToken%>');
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
            function setasdefaultTask(td_ttid) {
                if (EditAccess == "True") {
                    var taskParameters_dfl = {
                        intTaskTypeID: encodeURI(td_ttid),
                        ProjectID: encodeURI(ProjectID),
                        Command: encodeURI('PUT')
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectTaskTypeActions',
                        type: "POST",
                        data: JSON.stringify(taskParameters_dfl),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (taskParameters_dfl) {
                                xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dfl) ? taskParameters_dfl : JSON.stringify(taskParameters_dfl)));
                            }
                        },
                        success: function (data) {
                            if (data[0].ack == "UPD") {
                                showAlert('<%= MyBase.GetResourceString("C_AL_DefaultTaskType") %>', 'alert-success');
                                ProjectTaskTypeActions();
                                refreshMyParent();
                            } else if (data[0].ack == "AUPD") {
                                //showAlert('<%= MyBase.GetResourceString("C_AL_DefaultTaskTypeFailed") %>', 'alert-danger');
                            } else {
                                showAlert('<%= MyBase.GetResourceString("C_AL_DefaultTaskTypeFailed") %>', 'alert-danger');
                            }
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

            $("#btnpcttsdelete").click(function () {
                if (DeleteAccess = "True") {
                    if (delsubtaskIDs.join(",") != "") {
                        var taskParameters_dss = {
                            ProjectSubTaskTypeIDs: encodeURI(delsubtaskIDs.join(",")),
                            ProjectID: encodeURI(ProjectID),
                            Command: encodeURI('DELETE')
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectTaskTypeActions',
                            type: "POST",
                            data: JSON.stringify(taskParameters_dss),
                            dataType: "json",
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (taskParameters_dss) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dss) ? taskParameters_dss : JSON.stringify(taskParameters_dss)));
                                }
                            },
                            success: function (data) {
                                if (data[0].ack == "DEL") {
                                   <%-- showAlert('<%= MyBase.GetResourceString("C_AL_SDeleted") %>', 'alert-success');--%>
                                     //by vishal Mahajan 24-12-2019
                                    if (delsubtaskIDs.length > 1) {
                                        showAlert('<%= MyBase.GetResourceString("C_AL_Deleted") %>', 'alert-success');
                                    } else {
                                        showAlert('<%= MyBase.GetResourceString("C_AL_SDeleted") %>', 'alert-success');
                                    }
                                    //by vishal Mahajan 24-12-2019
                                ProjectTaskTypeActions();
                            } else {
                                showAlert('<%= MyBase.GetResourceString("C_AL_SDeleteFailed") %>', 'alert-danger');
                            }
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_SSelect") %>', 'alert-danger');
                    }
                }
            });

            $("#btnpctttdelete").click(function () {
                if (DeleteAccess == "True") {
                     //add by omkar 10/01/2020
                    var NotallowedDelete = [];
                    ProjectTaskTypAllData = {};                   

                    //end of added by omkar 10/01/2020
                    var deltaskIDs = [];
                    $.each($("input[name='pctttaskdel']:checked"), function () {
                        deltaskIDs.push($(this).val());
                    });
                    if (deltaskIDs.join(",") != "") {


                         //added by omkar 10/01/2020
                         CheckTaskTypedDataAllowForDelete();
                        for (var i = 0; i < ProjectTaskTypAllData.length; i++) {
                            var TaskTypeID = ProjectTaskTypAllData[i]["TaskTypeID"];
                            var TaskType = ProjectTaskTypAllData[i]["TaskType"];
                            TaskTypeID = TaskTypeID.toString();
                            var AllowDeleteTask = ProjectTaskTypAllData[i]["AllowDeleteTask"];
                            if (deltaskIDs.indexOf(TaskTypeID) != -1) {
                                if (AllowDeleteTask == false) {
                                    deltaskIDs = jQuery.grep(deltaskIDs, function (value) {
                                        return value != TaskTypeID;
                                    });
                                    NotallowedDelete.push(TaskType);
                                }
                            }
                        }
                        //End of added by omkar 10/01/2020
                        //added by omkar 10/01/2020
                        if (deltaskIDs.length != 0) {
                            //end of Added by omkar 10/01/2020
                            var taskParameters_dts = {
                                ProjectID: encodeURI(ProjectID),
                                UniqueIDs: encodeURI(deltaskIDs.join(","))
                            }
                            $.ajax({
                                url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectDeleteTaskType',
                                type: "POST",
                                data: JSON.stringify(taskParameters_dts),
                                dataType: "json",
                                contentType: "application/json;charset-utf=8",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    if (taskParameters_dts) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_dts) ? taskParameters_dts : JSON.stringify(taskParameters_dts)));
                                    }
                                },
                                success: function (data) {

                                    if (data[0].ack == "success") {
                                        //window.location.reload();
                                        //commented and add by omkar 10/01/2020
                                        //showAlert(data[0].strResult, 'alert-success');
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.success(data[0].strResult);
                                        //end of commented and add by omkar 10/01/2020
                                        ProjectTaskTypeActions();
                                        refreshMyParent();
                                    } else {
                                        showAlert('<%= MyBase.GetResourceString("C_AL_TDeleteFailed") %>', 'alert-danger');
                                    }
                                },
                                error: function (err) {
                                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                }

                            });
                            //added by omkar 10/01/2020
                        }
                        //end of Added by omkar 10/01/2020
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_AL_TSelect") %>', 'alert-danger');
                        //showAlert('Select at least one task type.', 'alert-danger');
                    }
                }
                else {
                <%--showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');--%>
                    showAlert('Something went wrong please try again.', 'alert-danger');
                }
                //add by omkar 10/01/2020
                if (NotallowedDelete.length != 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    //Commented and added by Omkar 13/01/2020
                    //alertify.error('This ' + NotallowedDelete + ' Task Type are Map With Task ,can not be deleted .');
                    if (NotallowedDelete.length == 1) {
                        alertify.error("This " + NotallowedDelete + " Task Type is Map With Task ,can not be deleted");
                    } else {
                        alertify.error("This  " + NotallowedDelete + " Task Types are Map With Tasks ,can not be deleted.");
                    }
                    //End Of Commented and added by Omkar 13/01/2020
                    //showAlert('This ' + NotallowedDelete + ' Task Type are Map With Task ,can not be deleted .', 'alert-danger');
                }
                //end of add by omkar 10/01/2020
            });
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
                $(".nostylebtn  ").click(function () {
                    $(this).closest('tr').remove();
                });
            });

            $(document).ready(function () {
                $('[data-bs-toggle="tooltip"]').tooltip();
            });


            ////
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
            function checkboxchekd(id) {
                var id1 = id.id;
                var clss = $("#" + id1).attr('class');
                //alert(clss);
                var tid = clss.replace("chcktbl taskchck", "");
                // alert(tid);
                var ck_box_cnt = $('#CPSTTpanel' + tid + ' > div > div > table > tbody > tr > td > div> input[type="checkbox"]').length;

                var chk_box_checked_cnt = $('#CPSTTpanel' + tid + ' > div > div > table > tbody > tr > td > div> input[type="checkbox"]:checked').length;

                if (ck_box_cnt == chk_box_checked_cnt) {
                    $("#CPSTTpanel" + tid + " > div > div > table > thead > tr > th > div>input.chckHead").prop('checked', true);

                } else {
                    $("#CPSTTpanel" + tid + " > div > div > table > thead > tr > th > div>input.chckHead").prop('checked', false);
                }

            }

            //added by omkar 10/01/2020
            var ProjectTaskTypAllData = {};
            function CheckTaskTypedDataAllowForDelete() {

                if (ProjectID != "") {
                    var taskParameters_tt = {
                        ProjectID: encodeURI(ProjectID),
                        Command: encodeURI('GETT')
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_TaskType/ProjectTaskTypeActions',
                        type: "POST",
                        data: JSON.stringify(taskParameters_tt),
                        dataType: "json",
                        async: false,
                        contentType: "application/json;charset-utf=8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (taskParameters_tt) {
                                xhr.setRequestHeader("Params", encryptString(isJson(taskParameters_tt) ? taskParameters_tt : JSON.stringify(taskParameters_tt)));
                            }
                        },
                        success: function (data) {
                            ProjectTaskTypAllData = {};
                            ProjectTaskTypAllData = data;


                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }
            //end of added by omkar 10/01/2020
        </script>
        
    </div>
</body>
</html>
