<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_IssueSeverity.aspx.vb" Inherits="PbNIT.PM_IssueSeverity" %>

<!DOCTYPE html>

<html>
    <%CommonFunctions.General.PlotPageHeadTag("Project Issue Severity")%>
<head runat="server">
<!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
<%--    <meta charset="utf-8 " />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Project Issue Severity</title>
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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    
    <script src="../../General/CommonValidations.js"></script>
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />
  
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />
</head>
              
    <style type="text/css">
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

        #tblpcisSeverity {
            margin: 0 auto 20px;
            width: 100%;
        }

        .add-btn-wrap {
            margin-left: 0px;
        }

        #CloseableAlert .close {
            float: right;
            border: none;
            /*display:none;*/
        }

        
        #CloseableAlert2 .close {
            float: right;
            border: none;
            /*display:none;*/
        }
        .autoclosablemsg{ display:none;}/*Added by pradip on 6-4-2023*/

        /* Modified By Madhuri.K On 26-03-2026 */
        .form-control, .btn {
            font-size: 11.5px;
            -webkit-appearance: auto;
        }
    </style>
<body id="pcisBodyID" class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divIssueSeverity">
        <%--<form id="form1" runat="server">--%>
        <div id="" class="tab-content practicesettinglist">
            <div class="modalpgHead pt-1 pb-1 col-sm-12">Issue Severity</div>
            <div class="pt-1 pb-1 col-sm-12 px-3 text-end clearfix">
                <h5 class="float-start mb-0">Project Name : <span id="ProjectName"></span></h5>
            </div>
            <!--ps_list_table_start-->
            <div class="tab-pane pstbl_severity pt-0 in active" id="pstbl_severity" style="border-top: 1px solid #ddd;">
                <table id="tblpcisSeverity" class="table table-stripped table-bordered tbl-priority">
                </table>
                <div class="add-btn-wrap">
                    <div class="input-wid-30">
                        <%--data-bs-target="#SeverityPopup"--%>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnpcisaddNewRow" data-bs-toggle="modal"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></a>
                        <button type="button" id="btnpcisConfirmDelete" class="btn borderbtn"><%= MyBase.GetResourceString("C_Delete") %></button>
                        <%--<button id="Save-rowNew" class="btn btnyellow">Save</button>--%>
                    </div>
                </div>
            </div>
            <!--ps_list_table_end-->
        </div>

        <div class="modal custmodal fade" id="SeverityPopup" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_IssueSeverity") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-6 mb-10">
                                    <label><%= MyBase.GetResourceString("C_Severity") %><span style="color: red">*</span></label>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("pcistxtSeverity", "pcistxtSeverity", "text-field",, 50,,,,,,,,,,,,,,, True) %>
                                </div>
                                <div class="col-sm-6 mb-10">
                                    <label><%= MyBase.GetResourceString("C_MapToCorporateSeverity") %><span style="color: red">*</span></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("pcisCboMapToCS", "usp_Whizible2_Sel_tbl_IB_Severity",,, "class='form-control'", False,, ) %>
                                </div>
                                <div class="col-sm-6">
                                    <label><%= MyBase.GetResourceString("C_DefaultSeverity") %></label>
                                    <div class="form-check">
                                        <div class="custom_chckbox">
                                            <% CommonFunctions.HTMLControls.DrawCheckBox("pcischkDefaultSeverity", "pcischkDefaultSeverity") %>
                                            <label for="pcischkDefaultSeverity"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="">
                            <div class="row">
                               
                                <div class="col-sm-12 btns-center btn-grp-new">
                                    <button type="button" data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                                    <button type="button" id="btnpcisSave" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Save") %></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Add new severity modal end here-->
        <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true" data-bs-dismiss="modal">
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
                                <center><%= MyBase.GetResourceString("C_AL_ReqDelete") %>
                        </center>
                            </h5>
                        </div>
                         <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button type="button" class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button type="button" id="btnpcisdelete" class="btn btnyellow ml-1 float-end">Yes</button>
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
        <%--by vishal Mahajan 21-12-2019--%>
       <%-- Commented & Added By Dipali V On 31st March 2023 For Show alert issue--%>
         <%--<div id="CloseableAlert2" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg2" style="top:80px" hidden="hidden">--%>
         <div id="CloseableAlert2" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg2" style="top:80px">
            <button type="button" onclick="CloseShowAlert2()" class="close">×</button>
             <%-- End of Commented & Added By Dipali V On 31st March 2023 For Show alert issue--%>
            <p id="alertMsg2"></p>
        </div>
        <%--by vishal Mahajan 21-12-2019--%>
        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->

<!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->

<%--        <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>

       <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
     
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>

        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>

        <script>
            //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
            var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            EmployeeID = '<%= Session("intUserID") %>';
            UserName = '<%= Session("strUserName") %>';
            //let searchParams = new URLSearchParams(window.location.search);
            // var ProjectID = searchParams.get('ProjectID');
            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
       // ProjectID = '<%= Session("intProjectID") %>';

            var ViewAccess = "<%= m_SubProjectblnViewAccess %>";

            var flag;
            var ProjectSeverityID;
            var objpcistxtSeverity = document.getElementById("pcistxtSeverity");
            var objpcischkDefaultSeverity = document.getElementById("pcischkDefaultSeverity");
            var objpcisCboMapToCS = document.getElementById("pcisCboMapToCS");
            var colspn;
            var SubProjectAddAccess = '<%= m_SubProjectblnAddAccess %>';
            var SubProjectEditAccess = '<%= m_SubProjectblnEditAccess %>';
            var SubProjectDeleteAccess = '<%= m_SubProjectblnDeleteAccess %>';
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_IssueSeverity%>'&Mode=Edit&update=done";                        
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_IssueSeverity%>');
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
            }
            
            $("#btnpcisdelete").click(function () {
                if (SubProjectDeleteAccess == "True") {
                    var favorite = [];
                    $.each($("input[name='Severity']:checked"), function () {
                        favorite.push($(this).val());
                    });

                    if (favorite.join(",") != "") {
                        var taskParameters_ds = {
                            UniqueIDs: encodeURI(favorite.join(",")),
                            ProjectID: encodeURI(ProjectID)
                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_IssueSeverity/ProjectIssueSeverityDelete',
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
                                //debugger;
                                //by vishal Mahajan 21-12-2019
                                if (data[0].SuceessResult != "") {
                                    showAlert(data[0].SuceessResult, 'alert-success');
                                }

                                if (data[0].ErrorResult != "") {
                                    showAlert2(data[0].ErrorResult, 'alert-danger');
                                }
                                //Commented By Dipali V On 29th March 2023 For Duplicate model pop up
                                //if (data[0].SuceessResult != "" && data[0].ErrorResult == "") {
                                //    $('#CPdelSubtaskModal').modal('toggle');
                                //}
                                //End of Commented By Dipali V On 29th March 2023 For Duplicate model pop up
                                ProjectIssueSeverityActions();
                                if (data[0].ErrorResult == "") {
                                    refreshMyParent();
                                }
                                //by vishal Mahajan 21-12-2019

                              
                            },
                            error: function (err) {
                                console.log(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_AL_SeverityDeleteSelect") %>', 'alert-danger');
                    }
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });

            $("#btnpcisSave").click(function ()
            {
                if (SubProjectAddAccess == "True" || SubProjectEditAccess == "True") {
                    var valres = ValidateFields();
                    if (valres != false)
                    {
                        //Added by imran on 06-09-2022
                        if (ProjectSeverityID == undefined) {
                            ProjectSeverityID = 0;
                        }

                        if (pcischkDefaultSeverity.checked == true) {
                            var objpcischkDefaultSeverity = 1
                        }
                        else {
                            var objpcischkDefaultSeverity = 0;
                        }
                        //End of comment by imran on 06-09-2022

                        var taskParameters_s = {
                            ProjectID: encodeURI(ProjectID),
                            ProjectSeverityID: encodeURI(ProjectSeverityID),
                            Severity: encodeURI(Trim(objpcistxtSeverity.value)),
                            CorporateSeverity: encodeURI($('select[name=pcisCboMapToCS] option:selected').text()),//objpcisCboMapToCS.text,
                            DefaultSeverity: objpcischkDefaultSeverity,
                            CreatedBy: encodeURI(UserName),
                            Command: encodeURI(flag)//"POST"
                        }                       
                        $.ajax({
                            //Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
                            //url: encodeURI(strUrl) + '/api/PM_IssueSeverity/ProjectIssueSeverityActions',
                            url: encodeURI(strUrl) + '/api/PM_IssueSeverity/New_ProjectIssueSeverityActions',
                            //End of Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
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
                                console.log(data);
                                if (data[0].ack == "AD") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_SeverityAdded") %>', 'alert-success');
                                    ProjectIssueSeverityActions();
                                    //Added by Chetan M on 06 Nov 2020 for get update added Priority
                                        flag = "PUT";
                                        ProjectSeverityID = data[0].PK;
                                        //End of Added by Chetan M on 06 Nov 2020 for get update added Priority
                                       //Add by omkar 31/12/2019
                                   // $('#SeverityPopup').modal('toggle');//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                                     //end of Add by omkar 31/12/2019

                                    refreshMyParent();
                                } else if (data[0].ack == "AE") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_SeverityExists") %>', 'alert-danger');
                                } else if (data[0].ack == "UPD") {

                                    showAlert('<%= MyBase.GetResourceString("C_AL_SeverityUpdated") %>', 'alert-success');
                                    ProjectIssueSeverityActions();
                                       //Add by omkar 31/12/2019
                                    //$('#SeverityPopup').modal('toggle');//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                                     //end of Add by omkar 31/12/2019

                                    refreshMyParent();
                                }
                                else if (data[0].ack == "NUPD") {
                                    showAlert('<%= MyBase.GetResourceString("C_AL_SeverityExists") %>', 'alert-danger');
                                }
                                //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                                //$('#SeverityPopup').modal('toggle');
                                //End of addition By Chetan M.
                            },
                            error: function (err) {
                                console.log(err);
                                //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
                }
                else {
                    showAlert('<%= MyBase.GetResourceString("C_AL_AccessRestrict") %>', 'alert-danger');
                }
            });

            function ValidateFields() {
                var IssueS = $("#pcistxtSeverity").val();
                if (Trim(objpcistxtSeverity.value) == "") {
                    showAlert('<%= MyBase.GetResourceString("C_AL_SeverityBlank") %>', 'alert-danger');
                    //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                    var SeverityTxtID = "#" + objpcistxtSeverity.id;
                    $(SeverityTxtID).focus();
                    //End of addition By Chetan M.
                    return false;
                }
                //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
                else if (checkSpecialCharacter(IssueS, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Severity should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#pcistxtSeverity").focus();
                    return false;
                }
<%--                else if (checkSpecialCharacter(objpcistxtSeverity.value) == true) {
                    showAlert('<%= MyBase.GetResourceString("C_AL_SeverityCharacter") %>', 'alert-danger');
                    //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                    var SeverityTxtID = "#" + objpcistxtSeverity.id;
                    $(SeverityTxtID).focus();
                    //End of addition By Chetan M.
                    return false;
                }--%>
                    //Commented And Added By rutuja D. 6 Jan 2020 For Blank Validation
                //else if (objpcisCboMapToCS.value == "") {
                else if (objpcisCboMapToCS.value == "" || objpcisCboMapToCS.value == 0) {
                    showAlert('<%= MyBase.GetResourceString("C_AL_MapToCorporateSeverity") %>', 'alert-danger');
                    //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
                    var SeverityTxtID = "#" + objpcisCboMapToCS.id;
                    $(SeverityTxtID).focus();
                    //End of addition By Chetan M.
                    return false;
                }
                else {
                    return true;
                }
            }


            //Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
            //function checkSpecialCharacter(value) {
            //    var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
            //    var isSpecialCharacter = 0;
            //    for (var i = 0; i < regularExpression.length; i++) {
            //        if (value.indexOf(regularExpression[i]) != -1) {
            //            isSpecialCharacter = 1
            //        }
            //    }
            //    if (isSpecialCharacter == 1) {
            //        return true;
            //    }
            //    else {
            //        return false;
            //    }
            //}
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
            //End of addition By Chetan M.


            function setValues(psid, sev, csev, dsev) {
                $('#pcistxtSeverity').val(sev);
                flag = "PUT";
                $('#pcisCboMapToCS').val(csev);
                ProjectSeverityID = psid;
                $('#pcischkDefaultSeverity').prop('checked', dsev == 0 ? false : true);
            }

            $("#btnpcisaddNewRow").click(function () {
                $('#pcistxtSeverity').val("");
                //Commented By Rutuja D. 6 Jan 2020 For Binding Corporate Severity DropDown
              // $('#pcisCboMapToCS').val("");
                //Commented By Rutuja D. 6 Jan 2020 For Binding Corporate Severity DropDown

                //Added By Rutuja D. on 24 March 2020 For In Add Mode Corporate Severity Dropdown Should be placeholder issueid = 23013
                $('#pcisCboMapToCS').val(0);
                //End Added By Rutuja D. on 24 March 2020 For In Add Mode Corporate Severity Dropdown Should be placeholder issueid = 23013

                $('#pcischkDefaultSeverity').prop('checked', false);
                flag = "POST";
            });

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

            $(document).ready(ProjectIssueSeverityActions);


            $("#btnpcisConfirmDelete").click(function () {
                var de = [];
                $.each($("input[name='Severity']:checked"), function () {
                    de.push($(this).val());
                });
                if (de.join(",") == "") {
                    $('#btnpcisConfirmDelete').removeAttr('data-bs-target', '#CPdelSubtaskModal');
                    showAlert('<%= MyBase.GetResourceString("C_AL_SeverityDeleteSelect") %>', 'alert-danger');
                }
                else {
                    //$('#btnpcisConfirmDelete').attr('data-bs-target', '#CPdelSubtaskModal');
                    $('#CPdelSubtaskModal').modal('show');
                }
            });

            function ProjectIssueSeverityActions() {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divIssueSeverity").html(bodyHTML);
                    return;
                }
              
                StartLoader("#pcisBodyID")
                GetProjectName();
            //showAlert('<%= MyBase.GetResourceString("C_AL_SeverityBlank") %>', 'alert-danger');
                if (SubProjectAddAccess == "False") {
                    //$("#btnpcisaddNewRow").attr("disabled", true);//.hide();
                    $("#btnpcisaddNewRow").hide();
                    $("#btnpcisaddNewRow").addClass("lblcrsr");
                    //data - target="#SeverityPopup"
                }
                else {
                    $('#btnpcisaddNewRow').attr('data-bs-target', '#SeverityPopup');
                }
                if (SubProjectDeleteAccess == "False") {
                    //$("#btnpcisConfirmDelete").attr("disabled", true);//.hide();
                    $("#btnpcisConfirmDelete").hide();
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
                        url: encodeURI(strUrl) + '/api/PM_IssueSeverity/ProjectIssueSeverityActions',
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
                            var setHTML = '<thead><tr><th><%= MyBase.GetResourceString("C_SeverityHead") %></th><th><%= MyBase.GetResourceString("C_MapToCorporateSeverityHead") %></th><th><%= MyBase.GetResourceString("C_DefaultSeverityHead") %></th>'
                        if (SubProjectDeleteAccess == "True") {
                            setHTML += '<th class="text-center sm-wid"><div class="custom_chckbox"><input id="severityAll" class="chckHead" type="checkbox"><label for="severityAll"></label></div ></th>'
                        }

                        setHTML += '</tr></thead>'
                        setHTML += '<tbody id="tbodyProjectSeverity">'
                        if (data.length != 0) {
                            for (var i = 0; i < data.length; i++) {
                                var d = data[i];
                                var defltsav;
                                if (d.DefaultSeverity == "0") { defltsev = "No" } else { defltsev = "Yes" }

                                setHTML += '<tr>'
                                if (SubProjectEditAccess == "False") {
                                    setHTML += '<td>' + d.Severity + '</td>'
                                } else {
                                    //Commented And Added by Usha Pandit On 05.09.2020 as not getting complete text if contains space or quote
                                    //setHTML += '<td><a href="#" data-bs-toggle="modal" onclick=setValues(' + d.ProjectSeverityID + ',&#39;' + replaceChar(Trim(d.Severity), ' ', '&#32;') + '&#39;,' + d.SeverityID + ',' + d.DefaultSeverity + ') data-bs-target="#SeverityPopup">' + d.Severity + '</a></td>'
                                    var curIssueSeverity = Trim(d.Severity).toString().replace(/'/g, "\\'");
                                    setHTML += '<td><a href="#" data-bs-toggle="modal" onclick="setValues(' + d.ProjectSeverityID + ',' + '&quot;' + curIssueSeverity + '&quot;' + ',' + d.SeverityID + ',' + d.DefaultSeverity + ')" data-bs-target="#SeverityPopup">' + d.Severity + '</a></td>'
                                    //End Of Added by Usha Pandit On 05.09.2020 as not getting complete text if contains space or quote
                                }
                                setHTML += '<td>' + d.CorporateSeverity + '</td><td>' + defltsev + '</td>'
                                if (SubProjectDeleteAccess == "True") {
                                    setHTML += '<td class="text-center sm-wid"><div class="custom_chckbox"><input id="sev' + d.Severity + '" value="' + d.ProjectSeverityID + '"  class="chckHead severitychck" name="Severity" type="checkbox"><label for="sev' + d.Severity + '"></label></div></td>'
                                }
                                setHTML += '</tr>';
                            }
                        }
                        else {

                            setHTML += '<tr><td style="text-align:center!important;" colspan="' + colspn + '"><span class="text-center"><%= MyBase.GetResourceString("C_AL_NoItem") %></span></td></tr>';
                            }
                            setHTML += " </tbody></table>"

                            //console.log(setHTML);
                            $("#tblpcisSeverity").html(setHTML);

                            return false;
                        },
                        error: function (err) {
                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
                else {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=SessionLost"
                }

                $("#severityAll").click(function () {
                    $(".severitychck").prop('checked', $(this).prop('checked'));
                });

                $(".severitychck").change(function () {
                    var rowCount = $("#tbodyProjectSeverity > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", "#tbodyProjectSeverity");
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#severityAll").prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#severityAll").prop("checked", false);
                    }
                });
                StopAjaxLoader("#pcisBodyID")
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
    </div>
</body>
</html>
