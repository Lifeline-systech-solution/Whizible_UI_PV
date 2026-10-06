<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ExecutionTemplateSelection.aspx.vb" Inherits="PbNIT.PM_ExecutionTemplateSelection" %>

<!DOCTYPE html>
<html>
        <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
   <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">   
     <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1">
   <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />
   
    <%--alertify Css--%>
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>


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
         div#ExeTempSelTbl_wrapper {width: 97%;margin: 0 auto;}
        .alertify-notifier {
            z-index: 9999 !important;
        }

 .custmodal table tbody tr td {

           white-space:pre-line!important;
           word-break:break-word!important;

        }
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="Main_ExeTempSel">
    <% If m_blnETSViewAccess = True Then %>
	<%--Commented & Added By Rutuja D. on 10 Dec 2020 For Break Word--%>
    <%--<div class="tab-pane pstbl_custom pt-0 in active" id="ExeTempSelBody">--%>
	<div class="tab-pane custmodal pstbl_custom pt-0 practicesettinglist in active " id="ExeTempSelBody">
     <%--End Commented & Added By Rutuja D. on 10 Dec 2020 For Break Word--%>
        <div class="modalpgHead pt-1 pb-1 col-sm-12 mb-10">
            <span><%= MyBase.GetResourceString("C_ExecutionTemplateSelection") %></span>
        </div>
        <h5 class="float-start pl-20 px-3 pt-2 clearfix">Project Name : <span id="spanProjectName"></span></h5>  
        <% If m_blnETSAddAccess = True Then %>
        <div class="right-side-save mb-10">
            <a href="javascript:;" class="btn borderbtn mr-5" onclick="GetTemplateList();"><%= MyBase.GetResourceString("C_SelectTemplate") %></a>
        </div>
        <% End If %>
        <table class="table table-stripped table-bordered" id="ExeTempSelTbl">
            <thead>
                <tr>
                    <%--Commented By Reshma on 19th Dec 2019 For IssueID-20824 Functinality not there--%>
                    <%--<th><%= MyBase.GetResourceString("C_Copy") %></th>--%>
                    <%--Commented By Reshma on 19th Dec 2019 For IssueID-20824 Functinality not there--%>
                    <th class = "nosort"><%= MyBase.GetResourceString("C_TemplateTitle") %></th>
                    <th><%= MyBase.GetResourceString("C_RevisionNo") %></th>
                    <th><%= MyBase.GetResourceString("C_Publish") %></th>
                    <th><%= MyBase.GetResourceString("C_TemplateType") %></th>
                    <th><%= MyBase.GetResourceString("C_Active") %></th>
                    <th><%= MyBase.GetResourceString("C_GetLatestRevision") %></th>
                </tr>
            </thead>
            <tbody id="ExeTempSelTblBody">
            </tbody>
        </table>
    </div>

    <% Else %>
    <div id="NotAuthorized">
        <h4>You are not authorized to view this record. </h4>
    </div>
    <% End If %>

    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
    </div>
    <!--Page modal start here-->

    <!--Associated Task modal start here-->
    <div class="modal custmodal fade" id="assoTaskModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_AssociatedTask") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="text-end">
                            <strong><span class="fl-right"><%= MyBase.GetResourceString("C_Task") %> <span id="TaskId"></span></span></strong>
                            <div class="clearfix"></div>
                        </div>
                        <br />
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_OrderNo") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtATOrderNo", "txtATOrderNo", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_RevisionNo") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtATRevesionNo", "txtATRevesionNo", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_TaskType") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboATTaskType", "usp_Whizible2_Sel_tbl_PM_TaskTypes_WithTaskTypeId",,, "class='form-select  '",,, ) %>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_AccountableRole") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboATAccountableRole", "usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-select  '",,, ) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_ReviewTask") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtATReviewTask", "txtATReviewTask", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_ReviewType") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtATReviewType", "txtATReviewType", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_CheckList") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtATCheckList", "txtATCheckList", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_Description") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtATDescription", "txtATDescription", "Enter Special Request (Maxlenth 300 Char)", "form-control",,,,, , , 300,,,,,,,, "placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete='Off' maxlength='300'",,,,,,,,,,) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_Effort") %> <span style="color: red;">* </span></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtATEffort", "txtATEffort", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_Duration") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtATDuration", "txtATDuration", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <div class="inp-select d-inline-block pt-20">
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkATMandatory", "chkATMandatory") %>

                                        <label for="chkATMandatory"></label>
                                    </div>
                                </div>
                                <label><%= MyBase.GetResourceString("C_Mandatory") %> </label>
                            </div>
                        </div>
                    </div>
                    <div class="btn-grp-new">
                                <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5"><%= MyBase.GetResourceString("C_Close") %> </a>
                                <a href="javascript:;" class="btn btnyellow" onclick="UpdateAssociatedTask();" id="SaveAtModal"><%= MyBase.GetResourceString("C_Save") %> </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Associated Task modal end here-->

    <!--Copy modal start here-->
    <div class="modal custmodal fade" id="copyModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Copy Template</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row form-group">
                        <div class="col-sm-6">
                            <label>Template Title</label>
                            <input type="text" name="" class="form-control">
                        </div>
                        <div class="col-sm-6">
                            <label>Template Description</label>
                            <textarea class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="text-center">
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal">Close</a>
                                    <a href="javascript:;" class="btn btnyellow" data-bs-dismiss="modal">Save</a>
                                </div>
                </div>
            </div>
        </div>
    </div>
    <!--Copy modal end here-->

    <!--Select Template modal start here-->
    <div class="modal custmodal fade" id="selectTempModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SelectTemplateforProject") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <table class="table table-stripped table-bordered" id="TemplateTbl" width="100%">
                            <thead>
                                <tr>
                                    <%--Commented And Added bY Pradip on 21st Dec 2019 For IssueID-20974--%>
                                      <%--<th class="no-sort"><%= MyBase.GetResourceString("C_TemplateTitle") %></th>--%>                                         
                                      <th class="nosort"><%= MyBase.GetResourceString("C_TemplateTitle") %></th>
                                     <%--End Added bY Pradip on 21st Dec 2019 For IssueID-20974--%>
                                    <th><%= MyBase.GetResourceString("C_SelectTemplate") %></th>
                                </tr>
                            </thead>
                            <tbody id="TemplateTblBody">
                                <%-- <tr>
                                    <td colspan="2">There are no items to show in this view.</td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                    <%--  <center>
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %> </a>
                                    <a href="javascript:;" class="btn btnyellow" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Save") %> </a>
                                </center>--%>
                </div>
            </div>
        </div>
    </div>
    <!--Select Template modal end here-->

    <!--Publish modal start here-->
    <div class="modal custmodal fade" id="PublishModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SelectTemplateforProject") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row form-group">
                        <span id="SpanRevisionNo"></span>
                        <div class="col-sm-6">
                            <label class="required"><%= MyBase.GetResourceString("C_RevisionDate") %></label>
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPTRevisionDate", "txtPTRevisionDate", "form-control ",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)'""autocomplete='off'",,, True,,,, True) %>
                        </div>
                        <div class="col-sm-6">
                            <label class="required"><%= MyBase.GetResourceString("C_RevisedBy") %></label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPTRevisedBy", "Select ''",,, "class='form-select  '",,, ) %>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-sm-6">
                            <label class="required"><%= MyBase.GetResourceString("C_ApprovedBy") %></label>
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPTApprovedBy", "Select ''",,, "class='form-select  '",,, ) %>
                        </div>
                        <div class="col-sm-6">
                            <label class="required"><%= MyBase.GetResourceString("C_Reason") %></label>
                            <% CommonFunctions.HTMLControls.DrawTextArea("txtPTReason", "txtPTReason", "Enter Reason (Maxlenth 400 Char)", "form-control",,,,, , , 400,,,,,,,, "placeholder='Enter Reason (Maxlength 400 Char)' autocomplete='Off' maxlength='400'",,,,,,,,,,) %>
                        </div>
                    </div>
                      
                       <div class="btn-grp-new">
                           <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></a>
                           <a href="javascript:;" class="btn btnyellow" onclick="InsertPublishTemplate();"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <!--Publish modal end here-->

    <!-- GetLatestRevision Confirmation modal_Start_here-->
    <div class="modal custmodal fade" id="ETSGetLatestRevision" aria-hidden="true"  data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Confirmation Get Latest Revision</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <h5>
                            <div class="text-center">This will override existing template data by modified template data.<br /><br />Do you want to continue?</div>
                        </h5>
                    </div>
                    <div class="btn-grp-new">
                                    <button data-bs-dismiss="modal" class="btn borderbtn">No</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow ml-1" onclick="GetLatestRevision();">Yes</button>
                                </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!-- GetLatestRevision Confirmation  _modal_end_here-->




    <!--Page modal end here-->
        <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
    <!-- REQUIRED JS SCRIPTS -->
    <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- alertify -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        //datepicker
        $('#txtPTRevisionDate').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'

        });
        $('#txtPTRevisionDate').datepicker('setDate', new Date());
    </script>

    <script>
        //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
         var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        var ProjectID;
        var UserName = '<%= Session("strUserName") %>';
        var ajaxResult = "";
        var GlobalTemplateID = "";
        var GlobalProjectTemplateEffort = "";        
        var cntTemplateSelection = 0;

        $(document).ready(function () {

            params = getParams();
            ProjectID = unescape(params["ProjectID"]);

            GetProjectName(ProjectID);

            if (ProjectID != 0) {
                GetExeTempSelList();
            }
            else {
                StartLoader("#Main_ExeTempSel");
                $("#NoProjectDivID").show();
                $("#ExeTempSelBody").hide();
                StopAjaxLoader("#Main_ExeTempSel");
            }
        });        
        $(function () {
             
            $('.comment').keyup(function () {
                try {
                    var x = $(this).val();

                    var newLines = x.match(/(\r\n|\n|\r)/g);
                    var addition = 0;
                    if (newLines != null) {
                        addition = newLines.length;
                    }

                    if (newLines != null) {
                        if (newLines.length > 0 && x.length == 1000) {
                            var curtextold = $(this).val();
                            
                            curtext = curtextold.slice(0, -4);
                            
                            $(this).val(curtext);
                        }
                        //alert(curtext);
                        //$(this).val(curtext);
                        //alert(x.length);
                        //alert(addition);
                    }
                }
                catch (ex) {
                    alert(ex.message);
                }
            });
            $('.comment').keydown(function () {
                try {
                    var x = $(this).val();

                    var newLines = x.match(/(\r\n|\n|\r)/g);
                    var addition = 0;
                    if (newLines != null) {
                        addition = newLines.length;
                    }

                    if (newLines != null) {
                        if (newLines.length > 0 && x.length == 1000) {
                            var curtextold = $(this).val();
                            //curtext = curtextold.substring(0, x.length - addition)
                            curtext = curtextold.slice(0, -4);
                            $(this).val(curtext);
                        }
                        //alert(curtext);
                        //$(this).val(curtext);
                        //alert(x.length);
                        //alert(addition);
                    }
                }
                catch (ex) {
                    alert(ex.message);
                }
            });
        });
        Math.trunc = Math.trunc || function (x) {
            if (isNaN(x)) {
                return NaN;
            }
            if (x > 0) {
                return Math.floor(x);
            }
            return Math.ceil(x);
        };


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

        function GetExeTempSelList() {
            cntTemplateSelection = 0;
            StartLoader("#Main_ExeTempSel");
            $("#ExeTempSelTbl").dataTable().fnDestroy();
            var ExeTempSelPrameters = {

                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetExeTempSelList", paramater, false);

            $("#ExeTempSelTblBody").html('');
            var strHTML = "";
            cntTemplateSelection = strResult.length;
            for (var i = 0; i < strResult.length; i++) {

                var Code = strResult[i]["Code"]
                var TemplateName = strResult[i]["TemplateName"];
                var Status = $.trim(strResult[i]["Status"]);
                var ProjectRevisionNo = strResult[i]["ProjectRevisionNo"]
                var ProjectPhaseTaskTemplateID = strResult[i]["ProjectPhaseTaskTemplateID"];
                var IsActive = strResult[i]["IsActive"];


                var inputTemplateName = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtETSTemplateName" + "TemplateNameIndex", "txtETSTemplateName" + "TemplateNameIndex", "form-control", ,,,, , ,, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                inputTemplateName = inputTemplateName.replace(/TemplateNameIndex/g, ProjectPhaseTaskTemplateID);

                var inputCode = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtETSCode" + "CodeIndex", "txtETSCode" + "CodeIndex", "form-control", ,,,, , ,, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                inputCode = inputCode.replace(/CodeIndex/g, ProjectPhaseTaskTemplateID);

                var inputDescription ='<%=CommonFunctions.HTMLControls.DrawTextArea("txtETSDescription" + "DescriptionIndex", "txtETSDescription" + "DescriptionIndex", , "form-control", , "form-control", "", , , , 500,,,,,,,, "placeholder = 'Enter Special Request (Maxlength 300 Char)' autocomplete='Off' maxlength='300'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                inputDescription = inputDescription.replace(/DescriptionIndex/g, ProjectPhaseTaskTemplateID);


                //Commented & Added by Dipali V On 6th may 2020 For Javascript issues
<%--                var inputTailoringComments ='<%=CommonFunctions.HTMLControls.DrawTextArea("txtETStcDescription" + "TailoringCommentsIndex", "txtETStcDescription" + "TailoringCommentsIndex", , "form-control comment", , "form-control", "", , , , 1000,,,,,,,, "placeholder = 'Enter Tailoring Comments' onkeyup='limitText(this,10,1000)' autocomplete='Off' maxlength='1000'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                inputTailoringComments = inputTailoringComments.replace(/TailoringCommentsIndex/g, ProjectPhaseTaskTemplateID);

                var inputDeviationComments ='<%=CommonFunctions.HTMLControls.DrawTextArea("txtETSdcDescription" + "DeviationCommentsIndex", "txtETSdcDescription" + "DeviationCommentsIndex", , "form-control comment", , "form-control", "", , , , 1000,,,,,,,, "placeholder = 'Enter Deviation Comments' onkeyup='limitText(this,10,1000)' autocomplete='Off' maxlength='1000'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                inputDeviationComments = inputDeviationComments.replace(/DeviationCommentsIndex/g, ProjectPhaseTaskTemplateID);--%>


                
                var inputTailoringComments ='<%=CommonFunctions.HTMLControls.DrawTextArea("txtETStcDescription" + "TailoringCommentsIndex", "txtETStcDescription" + "TailoringCommentsIndex", , "form-control comment", , "form-control", "", , , , 1000,,,,,,,, "placeholder = 'Enter Tailoring Comments' autocomplete='Off' maxlength='1000'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                inputTailoringComments = inputTailoringComments.replace(/TailoringCommentsIndex/g, ProjectPhaseTaskTemplateID);

                var inputDeviationComments ='<%=CommonFunctions.HTMLControls.DrawTextArea("txtETSdcDescription" + "DeviationCommentsIndex", "txtETSdcDescription" + "DeviationCommentsIndex", , "form-control comment", , "form-control", "", , , , 1000,,,,,,,, "placeholder = 'Enter Deviation Comments'  autocomplete='Off' maxlength='1000'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                inputDeviationComments = inputDeviationComments.replace(/DeviationCommentsIndex/g, ProjectPhaseTaskTemplateID);

                 //End of Commented & Added by Dipali V On 6th may 2020 For Javascript issues

                var inputIsActive = '<%= CommonFunctions.HTMLControls.DrawCheckBox("chkIsActive" + "IsActiveIndex", "chkIsActive" + "IsActiveIndex", ,  , , returnHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>'
                inputIsActive = inputIsActive.replace(/IsActiveIndex/g, ProjectPhaseTaskTemplateID);

                if (ProjectPhaseTaskTemplateID != undefined || ProjectPhaseTaskTemplateID != null || ProjectPhaseTaskTemplateID != '') {

                    var IsCopyTemplate = GetIsCopyTemplate(ProjectPhaseTaskTemplateID);

                    if (IsCopyTemplate == null) {
                        IsCopyTemplate = 0;

                        var IsRevised = GetIsRevised(ProjectPhaseTaskTemplateID);

                    }
                }
                else {

                }


                if (IsCopyTemplate == 0) {
                    var TemplateType = 'Inherited'
                }
                else {
                    var TemplateType = ' Project Specific'

                }
                if (IsActive == 0) {
                    IsActive = 'No';
                }
                else {
                    IsActive = 'Yes';
                }

                strHTML += '<tr>'
                //Commented By Reshma on 19th Dec 2019 For IssueID-20824 Functinality not there
                <%--  <% If m_blnETSAddAccess = True Then %>
                strHTML += '<td>'
                strHTML += '<i class="far fa-copy copy-icon" data-bs-toggle="modal" data-bs-target="#copyModal" data-original-title="Copy Execution Template Selection"></i>'
                strHTML += '</td>'
                <% Else %>
                strHTML += '<td>'
                strHTML += '<i class="far fa-copy copy-icon"  data-original-title="Copy Execution Template Selection"></i>'
                strHTML += '</td>'
                <% End IF %>--%>
                //Commented By Reshma on 19th Dec 2019 For IssueID-20824 Functinality not there
                <% If m_blnETSEditAccess = True Then %>
                strHTML += '<td>'
                strHTML += '<a href="javascript:;" data-bs-toggle="collapse" data-bs-target="#ETSdevelopEx' + ProjectPhaseTaskTemplateID + '"  id="' + ProjectPhaseTaskTemplateID + '"onclick="EditExeTempSel(this.id)">' + TemplateName + ' </a>'
                strHTML += '</td>'
                 <% Else %>
                strHTML += '<td>' + TemplateName + '</td>'
                 <% End If %>

                strHTML += '<td>' + ProjectRevisionNo + '</td>'
                if (Status == 'P') {
                    strHTML += '<td> <FONT color="RED"> ' + "Published" + '</FONT></td>'
                }
                else if (Status == 'N') {
                    strHTML += '<td> <FONT color="BLACK"> ' + "Published" + '</FONT></td>'
                }
                else {
                    <% If m_blnETSAddAccess = True Then %>
                    strHTML += '<td>'
                    strHTML += '<a href="javascript:;" id="' + ProjectRevisionNo + '"onclick="PublishTemplate(' + ProjectRevisionNo + "," + ProjectPhaseTaskTemplateID + ');">Publish</a>'
                    strHTML += '</td>'
                   <% Else %>
                    strHTML += '<td> Publish'
                    strHTML += '</td>'
                    <% End If %>

                }
                strHTML += '<td>' + TemplateType + '</td>'
                strHTML += '<td>' + IsActive + '</td>'

                if (IsRevised == 0) {
                    strHTML += '<td><FONT color="RED"> ' + "Latest" + '</FONT></td>'
                }
                else {
                    <% If m_blnETSAddAccess = True Then %>
                    strHTML += '<td>'
                    strHTML += '<a href="javascript:;"  id="' + ProjectPhaseTaskTemplateID + '" onclick="ShowGetLatestConfirmation(this.id)">Get Latest Revision</a>'
                    strHTML += '</td>'
                   <% Else %>
                    strHTML += '<td> Get Latest Revision'
                    strHTML += '</td>'
                    <% End If %>
                }


                strHTML += '</tr>'

                //Collapse Dynamically Binding
                strHTML += '<tr>'
                strHTML += '<td colspan="6" class="hiddenRow subCustomField text-start">'
                strHTML += '<div class="accordian-body collapse" id="ETSdevelopEx' + ProjectPhaseTaskTemplateID + '" aria-expanded="true" style="">'
                strHTML += '<div class="row pt-1 pb-1 bgwhite pad-10">'
                strHTML += '<div class="right-side-save mb-10 mr-0">'
                strHTML += '<a href="javascript:;" class="btn borderbtn mr-5 closeAcco" onclick="closeaccordian(' + ProjectPhaseTaskTemplateID + ');">Close</a>'
                strHTML += '<a href="javascript:;" class="btn btnyellow" onclick="UpdateExeTempSel(this.id);" id="' + ProjectPhaseTaskTemplateID + '">Save</a>'
                strHTML += '</div>'
                strHTML += '<div class="page-main-head">'
                strHTML += '<h4>Execution Template Selection</h4>'
                strHTML += '</div>'
                strHTML += '<div class="row form-group pad-10">'
                strHTML += '<div class="col-sm-4">'
                strHTML += '<label>Template Title</label>'
                strHTML += inputTemplateName
                strHTML += '</div>'
                strHTML += '<div class="col-sm-4">'
                strHTML += '<label>Code</label>'
                strHTML += inputCode
                strHTML += '</div>'
                strHTML += '<div class="col-sm-4">'
                strHTML += '<label>Description</label>'
                strHTML += inputDescription
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '<div class="row form-group pad-10   ">'
                strHTML += '<div class="col-sm-4">'
                strHTML += '<label>Tailoring Comments</label>'
                strHTML += inputTailoringComments
                strHTML += '</div>'
                strHTML += '<div class="col-sm-4">'
                strHTML += '<label>Deviation Comments</label>'
                strHTML += inputDeviationComments
                strHTML += '</div>'
                strHTML += '<div class="col-sm-4 pt-20">'
                strHTML += '<div class="inp-select d-inline-block">'
                strHTML += '<div class="custom_chckbox">'
                strHTML += inputIsActive
                strHTML += '<label for="chkIsActive' + ProjectPhaseTaskTemplateID + '"></label>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '<label class="d-inline-block">Active</label>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '<div class="page-main-head">'
                strHTML += '<h4>Associated Task</h4>'
                strHTML += '</div>'
                strHTML += '<table class="table table-stripped table-bordered">'
                strHTML += '<thead>'
                strHTML += '<tr>'
                strHTML += '<th>Order Number</th>'
                strHTML += '<th>Task</th>'
                strHTML += '<th>Revision No</th>'
                strHTML += '<th>Effort(%) </th>'
                strHTML += '<th>Duration(Days)</th>'
                strHTML += '<th>Mandatory</th>'
                strHTML += '<th>Is Active</th>'
                strHTML += '</tr>'
                strHTML += '</thead>'
                strHTML += '<tbody id="ETSAssociatedTaskTblBody' + ProjectPhaseTaskTemplateID + '">'
                strHTML += '</tbody>'
                strHTML += '</table>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '<td class="hiddenRow subCustomField text-start" style="display:none!important;"></td>'
                strHTML += '<td class="hiddenRow subCustomField text-start" style="display:none!important;"></td>'
                strHTML += '<td class="hiddenRow subCustomField text-start" style="display:none!important;"></td>'
                strHTML += '<td class="hiddenRow subCustomField text-start" style="display:none!important;"></td>'
                strHTML += '<td class="hiddenRow subCustomField text-start" style="display:none!important;"></td>'
                
                strHTML += '</tr>'



            }

            $("#ExeTempSelTblBody").html("")
            $("#ExeTempSelTblBody").html(strHTML);

            StopAjaxLoader("#Main_ExeTempSel");

            $("#ExeTempSelTbl").DataTable({
                "pageLength": 4,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "ordering": false,
                "columnDefs": [{
                    'width': '10%',
                    'targets': {}, /* column index */
                    'orderable': false, /* true or false */
                }],
                //add by omkar 08/01/2020 issue 21171
                "infoCallback": function (settings, start, end, max, total, pre) {
                    var api = this.api();
                    var pageInfo = api.page.info();

                    if (total != 0) {


                        if ((end % 2) == 0) {
                            //Commented And added by omkar 12/1/2020
                            //return 'Show ' + start + ' to ' + (end / 2) + ' of ' + (total / 2) + ' entries';
                             start = (Math.trunc((start / 2)) + 1);
                            end = (end / 2);
                            total = (total / 2);
                            return 'Showing ' + start + ' to ' + end + ' of ' + total + ' entries';
                            //end of added by omkar 12/1/2020
                        } else {
                            //Commented And added by omkar 12/1/2020
                            //return 'Show ' + start + ' to ' + Math.trunc((end / 2)) + 1 + ' of ' + (total / 2) + ' entries';
                            start = (Math.trunc((start / 2)) + 1);
                            end = (Math.trunc((end / 2)) + 1);
                            total = (total / 2);
                            return 'Showing ' + start + ' to ' + end + ' of ' + total + ' entries';
                            //end of added by omkar 12/1/2020
                        }
                    }else {
                        return 'Showing 0 to 0 of 0 entries';
                    }


                }
                //end of add by omkar 08/01/2020 issue 21171

            });

            if (strHTML == "") {
                $("#ExeTempSelTbl tbody tr td").prop("colspan", 6);
            }
            
        }

        function ShowGetLatestConfirmation(ProjectPhaseTaskTemplateID) {
            GlobalTemplateID = ProjectPhaseTaskTemplateID;
            $("#ETSGetLatestRevision").modal('show');
        }

        function GetLatestRevision() {

            ExeTempSelPrameters = {
                ProjectPhaseTaskTemplateID: encodeURI(GlobalTemplateID),
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetLatestRevision", paramater, false);
            GetExeTempSelList();
        }

        function GetIsCopyTemplate(ProjectPhaseTaskTemplateID) {

            ExeTempSelPrameters = {
                ProjectPhaseTaskTemplateID: encodeURI(ProjectPhaseTaskTemplateID),
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetIsCopyTemplate", paramater, false);
            return strResult;
        }

        function GetIsRevised(ProjectPhaseTaskTemplateID) {

            ExeTempSelPrameters = {
                ProjectPhaseTaskTemplateID: encodeURI(ProjectPhaseTaskTemplateID),
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetIsRevised", paramater, false);


            return strResult;
        }

        function EditExeTempSel(ProjectPhaseTaskTemplateID) {

            var ExeTempSelPrameters = {
                ProjectID: encodeURI(ProjectID),
                ProjectPhaseTaskTemplateID: encodeURI(ProjectPhaseTaskTemplateID)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetExeTempSelList", paramater, false);


            for (var i = 0; i < strResult.length; i++) {
                var Code = strResult[i]["Code"]
                var TemplateName = strResult[i]["TemplateName"];
                var TemplateDescription = $.trim(strResult[i]["TemplateDescription"]);
                var IsActive = strResult[i]["IsActive"];
                var DeviationComments = strResult[i]["DeviationComments"];
                var TailoringComments = strResult[i]["TailoringComments"];


                $("#txtETSTemplateName" + ProjectPhaseTaskTemplateID).val(TemplateName);
                $("#txtETSCode" + ProjectPhaseTaskTemplateID).val(Code);
                $("#txtETStcDescription" + ProjectPhaseTaskTemplateID).val(TailoringComments);
                $("#txtETSdcDescription" + ProjectPhaseTaskTemplateID).val(DeviationComments);
                $("#txtETSDescription" + ProjectPhaseTaskTemplateID).val(TemplateDescription);

                if (IsActive == true) {
                    $("#chkIsActive" + ProjectPhaseTaskTemplateID).prop('checked', true);
                }
                else {
                    $("#chkIsActive" + ProjectPhaseTaskTemplateID).prop('checked', false);
                }

                $("#txtETSTemplateName" + ProjectPhaseTaskTemplateID).prop("disabled", true);
                $("#txtETSCode" + ProjectPhaseTaskTemplateID).prop("disabled", true);
                $("#txtETSDescription" + ProjectPhaseTaskTemplateID).prop("disabled", true);


            }

            GetAssociatedTaskList(ProjectPhaseTaskTemplateID);

            $(".accordian-body").each(function () {
                if ($(this).css("visibility") == "visible") {
                    // handle non visible state
                    $("#ExeTempSelTblBody>tr").css("pointer-events", "none");
                 
                    $("#ExeTempSelBody .btn").css("pointer-events", "none");

                    $("#ExeTempSelTblBody>tr .accordian-body tr").css("pointer-events", "auto");
                    $("#ExeTempSelTblBody>tr .accordian-body").css("pointer-events", "auto");
                    $("#ExeTempSelTblBody>tr .accordian-body .btn").css("pointer-events", "auto");
                } else {
                    // handle visible state
                    $("#ExeTempSelTblBody>tr").css("pointer-events", "auto");
                    $("#ExeTempSelTblBody>tr .accordian-body tr").css("pointer-events", "auto");
                    $("#ExeTempSelBody .btn").css("pointer-events", "auto");
                }
            });

        }

        function GetAssociatedTaskList(TemplateID) {

            var ExeTempSelPrameters = {
                TemplateID: encodeURI(TemplateID)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var TablestrResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetAssociatedTaskList", paramater, false);
            var TaskstrHTML = "";

            for (var i = 0; i < TablestrResult.length; i++) {
                var OrderNumber = TablestrResult[i]["OrderNumber"];
                var PhaseTaskName = TablestrResult[i]["PhaseTaskName"];
                var ProjectRevisionNo = TablestrResult[i]["ProjectRevisionNo"];
                var Effort = TablestrResult[i]["Effort"];
                var TaskDuration = TablestrResult[i]["TaskDuration"];
                var IsMandatory = TablestrResult[i]["IsMandatory"];
                var IsActive = TablestrResult[i]["IsActive"];
                var ProjectTemplateEffort = TablestrResult[i]["ProjectTemplateEffort"];

                if (IsMandatory == false) {
                    IsMandatory = 'No';
                }
                else {
                    IsMandatory = 'Yes';
                }

                if (IsActive == false) {
                    IsActive = 'No';
                }
                else {
                    IsActive = 'Yes';
                }
                if (TaskDuration == null) {
                    TaskDuration = '';

                }
                else {
                    TaskDuration = TaskDuration.toFixed(2);
                }
                if (Effort == null) {
                    Effort = '';
                }
                else {
                    Effort = Effort.toFixed(2);
                }
                TaskstrHTML += '<tr>'
                TaskstrHTML += '<td>' + OrderNumber + '</td>'
                TaskstrHTML += '<td>'
                TaskstrHTML += '<a href = "javascript:;" onclick="EditAssociatedTask(this.id,' + TemplateID + ')" id="' + ProjectTemplateEffort + '">' + PhaseTaskName + '</a></td > '
                TaskstrHTML += '<td>' + ProjectRevisionNo + '</td>'
                TaskstrHTML += '<td>' + Effort + '</td>'
                TaskstrHTML += '<td>' + TaskDuration + '</td>'
                TaskstrHTML += '<td>' + IsMandatory + '</td>'
                TaskstrHTML += '<td>' + IsActive + '</td>'
                TaskstrHTML += '</tr>'

            }
            $("#ETSAssociatedTaskTblBody" + TemplateID).html("");
            $("#ETSAssociatedTaskTblBody" + TemplateID).html(TaskstrHTML);

        }

        function EditAssociatedTask(ProjectTemplateEffort, TemplateID) {

            GlobalTemplateID = TemplateID;
            GlobalProjectTemplateEffort = ProjectTemplateEffort
            $("#assoTaskModal").modal('show');
            var ExeTempSelPrameters = {
                ProjectTemplateEffort: encodeURI(ProjectTemplateEffort)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var TablestrResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetAssociatedTaskList", paramater, false);

            for (var i = 0; i < TablestrResult.length; i++) {

                var OrderNumber = TablestrResult[i]["OrderNumber"];
                var ProjectRevisionNo = TablestrResult[i]["ProjectRevisionNo"];
                var ReviewTask = TablestrResult[i]["ReviewTask"];
                var Checklist = TablestrResult[i]["Checklist"];
                var Description = TablestrResult[i]["Description"];
                var Effort = TablestrResult[i]["Effort"];
                var TaskDuration = TablestrResult[i]["TaskDuration"];
                var IsMandatory = TablestrResult[i]["IsMandatory"];
                var ReviewType = TablestrResult[i]["ReviewType"];
                var RoleID = TablestrResult[i]["RoleID"];
                var TaskTypeID = TablestrResult[i]["TaskTypeID"];

                if (ReviewTask == 0) {
                    ReviewTask = 'No';
                } else {
                    ReviewTask = 'Yes';
                }
                if (IsMandatory == true) {
                    $("#chkATMandatory").prop('checked', true);
                }
                else {
                    $("#chkATMandatory").prop('checked', false);
                }

                $("#txtATOrderNo").val(OrderNumber);
                $("#txtATRevesionNo").val(ProjectRevisionNo);
                $("#txtATReviewTask").val(ReviewTask);
                $("#txtATCheckList").val(Checklist);
                $("#txtATDescription").val(Description);
                $("#txtATEffort").val(Effort);
                $("#txtATDuration").val(TaskDuration);
                $("#chkATMandatory").val(IsMandatory);
                $("#txtATReviewType").val(ReviewType);
                $("#chkATMandatory").val(IsMandatory);
                $("#txtATReviewType").val(ReviewType);
                $("#cboATTaskType").val(TaskTypeID);
                $("#cboATAccountableRole").val(RoleID);


                $("#txtATOrderNo").prop("disabled", true);
                $("#txtATRevesionNo").prop("disabled", true);
                $("#cboATTaskType").prop("disabled", true);
                $("#cboATAccountableRole").prop("disabled", true);
                $("#txtATReviewTask").prop("disabled", true);
                $("#txtATReviewType").prop("disabled", true);
                $("#txtATCheckList").prop("disabled", true);
                $("#txtATDescription").prop("disabled", true);
                var WhichTaskType = $("#cboATTaskType option:selected").text();
                $("#TaskId").text(WhichTaskType);

            }
        }

        function UpdateExeTempSel(ProjectPhaseTaskTemplateID) {
            var IsActive = "";
            var TailoringComments = $("#txtETStcDescription" + ProjectPhaseTaskTemplateID).val();
            var DeviationComments = $("#txtETSdcDescription" + ProjectPhaseTaskTemplateID).val();
            if (TailoringComments == undefined) {
                TailoringComments = '';
            }
            //Added By Rehan C for Special Char Validation on 19th Jan 2023
            if (TailoringComments !== "") {
                if (checkSpecialCharacter(TailoringComments, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Tailoring Comments should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtETStcDescription" + ProjectPhaseTaskTemplateID).focus();
                    return false;
                }

            }
            if (DeviationComments !== "") {
                if (checkSpecialCharacter(DeviationComments, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Deviation Comments should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtETSdcDescription" + ProjectPhaseTaskTemplateID).focus();
                    return false;
                }

            }
            //End Of Comment By Rehan C
            if (DeviationComments == undefined) {
                DeviationComments = '';
            }
            if ($("#chkIsActive" + ProjectPhaseTaskTemplateID).prop("checked") == true) {
                IsActive = 1;
            }
            else {
                IsActive = 0;
            }

            var ExeTempSelPrameters = {
                ProjectPhaseTaskTemplateID: encodeURI(ProjectPhaseTaskTemplateID),
                TailoringComments: encodeURI(TailoringComments),
                DeviationComments: encodeURI(DeviationComments),
                IsActive: encodeURI(IsActive)

            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/UpdateExeTempSel", paramater, false);
            alertify.success(strResult);
            GetExeTempSelList();
            $("#ExeTempSelTblBody>tr").css("pointer-events", "auto");
            $("#ExeTempSelTblBody>tr .accordian-body tr").css("pointer-events", "auto");
            $("#ExeTempSelBody .btn").css("pointer-events", "auto");
        }

        function GetSumOfEffortInPercent() {

            var Checkval = false;

            var ExeTempSelPrameters = {
                TemplateID: encodeURI(GlobalTemplateID),
                ProjectTemplateEffort: encodeURI(GlobalProjectTemplateEffort)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetSumOfEffortInPercent", paramater, false);
            var SumOfEffort = strResult;

            var Effort = $("#txtATEffort").val();
            var Duration = $("#txtATDuration").val();

            var objHMEffort = document.getElementById("txtATEffort");
            var isdigit = jQuery.isNumeric(Effort);

            var objDuration = document.getElementById("txtATDuration");
            var Durationisdigit = jQuery.isNumeric(Duration);

            var SumOfEffortPerCentage = 100 - SumOfEffort;

            if (isBlank(Effort)) {
                alertify.error("Please enter only positive numeric value for 'Effort(%)'");
                $('#txtATEffort').focus();
                Checkval = false;
            }
            else if (SumOfEffortPerCentage < Effort) {
                alertify.error('<%= MyBase.GetResourceString("A_TotalTask") %>');
                Checkval = false;
            }

            else if (isdigit == false) {
                alertify.error("Please enter only positive numeric value for 'Effort(%)'");
                $('#txtATEffort').focus();
                Checkval = false;
            }
            else if (disallowNegativeNumeric(objHMEffort)) {
                alertify.error("Please enter only positive numeric value for 'Effort(%)'");
                $('#txtATEffort').focus();
                Checkval = false;
            }
            else if (Duration != '') {
                if (Durationisdigit == false) {
                    alertify.error("Please enter only positive numeric value for 'Duration(Days)'");
                    $('#txtATDuration').focus();
                    Checkval = false;
                }
                else if (disallowNegativeNumeric(objDuration)) {
                    alertify.error("Please enter only positive numeric value for 'Duration(Days)'");
                    $('#txtATDuration').focus();
                    Checkval = false;
                }
                else if (Duration.indexOf('.') > -1) {
                    alertify.error("Please enter only positive numeric value for 'Duration(Days)'");
                    $('#txtATDuration').focus();
                    Checkval = false;
                }
                else {
                    Checkval = true;
                }
            }
            else {
                Checkval = true;
            }
            return Checkval;
        }

        function UpdateAssociatedTask() {

            var Checkval = GetSumOfEffortInPercent();

            if (Checkval == true) {
                var Duration = $("#txtATDuration").val();

                var Effort = $("#txtATEffort").val();

                if ($("#chkATMandatory").prop("checked") == true) {
                    var Mandatory = 1;
                }
                else {
                    var Mandatory = 0;
                }

                var ExeTempSelPrameters = {
                    Duration: encodeURI(Duration),
                    Effort: encodeURI(Effort),
                    Mandatory: encodeURI(Mandatory),
                    ProjectTemplateEffort: encodeURI(GlobalProjectTemplateEffort),
                    TemplateID: encodeURI(GlobalTemplateID)
                }
                var paramater = JSON.stringify(ExeTempSelPrameters);
                var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/UpdateAssociatedTask", paramater, false);
                alertify.success(strResult);

                $("#SaveAtModal").attr("data-bs-dismiss", "modal");
                GetAssociatedTaskList(GlobalTemplateID);
            }

        }

        function GetTemplateList() {

            $("#selectTempModal").modal('show');
            //alert(ProjectID);
            //StartLoader("#Main_ExeTempSel");
            $("#TemplateTbl").dataTable().fnDestroy();
            var ExeTempSelPrameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetTemplateList", paramater, false);

            $("#TemplateTblBody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {

                var TemplateName = strResult[i]["TemplateName"]
                var TemplateID = strResult[i]["TemplateID"];

                strHTML += '<tr>'
                strHTML += '<td>' + TemplateName
                strHTML += '</td>'
                strHTML += '<td>'
                strHTML += '<a href="javascript:;" id="' + TemplateID + '"onclick="UpdateSelectedTemplate(this.id)">Select Template</a>'
                strHTML += '</td>'
                strHTML += '</tr>'
            }
            $("#TemplateTblBody").html("")
            $("#TemplateTblBody").html(strHTML);

            //StopAjaxLoader("#Main_ExeTempSel");
            $("#TemplateTbl").DataTable({
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "ordering": false,
                "columnDefs": [{
                    'width': '10%',
                    'targets': {}, /* column index */
                    'orderable': false, /* true or false */
                }],

            });
            if (strHTML == "") {
                $("#TemplateTbl tbody tr td").prop("colspan", 2);
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
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ExecutionTemplateSelection%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ExecutionTemplateSelection%>');
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
        function UpdateSelectedTemplate(TemplateID) {
            var ExeTempSelPrameters = {
                ProjectID: encodeURI(ProjectID),
                UserName: encodeURI(UserName),
                TemplateID: encodeURI(TemplateID)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/UpdateSelectedTemplate", paramater, false);

            $("#selectTempModal").modal('hide');
            GetExeTempSelList();
            refreshMyParent();
        }

        function PublishTemplate(ProjectRevisionNo, ProjectPhaseTaskTemplateID) {
            GlobalTemplateID = ProjectPhaseTaskTemplateID;
            ProjectRevisionNo = parseInt(ProjectRevisionNo) + 1;

            $("#PublishModal").modal('show');
            GetApprovesdBy();
            GetRevisedBy();
            $("#SpanRevisionNo").val(ProjectRevisionNo);

            $('#txtPTRevisionDate').datepicker('setDate', new Date());
            $("#txtPTReason").val('');
            $("#txtPTRevisionDate").prop("disabled", true);

        }


        function validatePublishControl() {

            var CheckVAl = false;
            var RevisedBy = $("#cboPTRevisedBy").val();
            var ApprovedBy = $("#cboPTApprovedBy").val();
            var Reason = $("#txtPTReason").val();

            if (isBlank(RevisedBy)) {
                alertify.error("<%= MyBase.GetResourceString("A_RevisedBy") %>");
                $('#cboPTApprovedBy').focus();
                Checkval = false;
            }
            else if (isBlank(ApprovedBy)) {
                alertify.error("<%= MyBase.GetResourceString("A_ApprovedBy") %>");
                $('#cboPTApprovedBy').focus();
                Checkval = false;
            }
            else if (isBlank(Reason)) {
                alertify.error("<%= MyBase.GetResourceString("A_Reson") %>");
                $('#txtPTReason').focus();
                Checkval = false;
            }
            //Added By Rehan C To add Validator for Special characters on 18th Nov 
            else if (checkSpecialCharacter(Reason, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Reason should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtPTReason").focus();
                CheckVal = false;
            }//End of comment
            else {
                CheckVAl = true;
            }
            return CheckVAl;

        }

        function InsertPublishTemplate() {

            var RevisionDate = $("#txtPTRevisionDate").val();
            var RevisedBy = $("#cboPTRevisedBy").val();
            var ApprovedBy = $("#cboPTApprovedBy").val();
            var Reason = $("#txtPTReason").val();
            var ProjectRevisionNo = $("#SpanRevisionNo").val();
            $("#txtPTRevisionDate").prop("disabled", true);
            var CheckVAl = validatePublishControl();
            if (CheckVAl == true) {
                ExeTempSelPrameters = {
                    RevisionDate: encodeURI(RevisionDate),
                    RevisedBy: encodeURI(RevisedBy),
                    ApprovedBy: encodeURI(ApprovedBy),
                    Reason: encodeURI(Reason),
                    ProjectID: encodeURI(ProjectID),
                    TemplateID: encodeURI(GlobalTemplateID),
                    RevisionNo: encodeURI(ProjectRevisionNo),
                }
                var paramater = JSON.stringify(ExeTempSelPrameters);
                var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/PublishTemplate", paramater, false);

                alertify.success(strResult);
                $("#PublishModal").modal('hide');
                GetExeTempSelList();

            }
            else {
                $("#PublishModal").modal('show');
            }

        }

        function GetApprovesdBy() {
            var ApprovedByOrRevisedBy = 'AB'
            ExeTempSelPrameters = {
                ProjectID: encodeURI(ProjectID),
                ApprovedByOrRevisedBy: encodeURI(ApprovedByOrRevisedBy)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetApprovedByOrRevisedBy", paramater, false);

            var selHTML = "";
            if (strResult != undefined) {
                var objCbo1 = document.getElementById("cboPTApprovedBy");

                $("#cboPTApprovedBy option").remove();

                var objOption1 = document.createElement("OPTION");

                for (var i = 0; i < strResult.length; i++) {
                    var Objresult = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);

                    objOption.text = Objresult.UserName;
                    objOption.value = Objresult.EmployeeID == 0 ? '' : Objresult.EmployeeID;

                }

            }


        }

        function GetRevisedBy() {
            var ApprovedByOrRevisedBy = 'RB';
            ExeTempSelPrameters = {
                ProjectID: encodeURI(ProjectID),
                ApprovedByOrRevisedBy: encodeURI(ApprovedByOrRevisedBy)
            }
            var paramater = JSON.stringify(ExeTempSelPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ExecutionTemplateSelection/GetApprovedByOrRevisedBy", paramater, false);


            var selHTML = "";
            if (strResult != undefined) {
                var objCbo1 = document.getElementById("cboPTRevisedBy");

                $("#cboPTRevisedBy option").remove();

                var objOption1 = document.createElement("OPTION");

                for (var i = 0; i < strResult.length; i++) {
                    var Objresult = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);

                    objOption.text = Objresult.UserName;
                    objOption.value = Objresult.EmployeeID == 0 ? '' : Objresult.EmployeeID;

                }

            }


        }

        function Date_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = (e.keyCode == 8 || e.keyCode == 46)
            {
                if (e.keyCode == 8 || e.keyCode == 46) {

                }
            }
            return ret;
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

                    //StopAjaxLoader("#WBSBody");
                    ajaxResult = data;
                },
                error: function (err) {
                    //StopAjaxLoader("#WBSBody");
                    console.log(err);
                    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        function closeaccordian(id) {
            //alert();
            //$(".accordian-body").removeClass("in");
            // $("#ETSdevelopEx" + id).removeClass("in");
            $("#ETSdevelopEx" + id).removeClass("show");

            $("#ExeTempSelTblBody>tr").css("pointer-events", "auto");
            $("#ExeTempSelTblBody>tr .accordian-body tr").css("pointer-events", "auto");
            $("#ExeTempSelBody .btn").css("pointer-events", "auto");

        }

          //Added By Reshma On 29Nov 2019
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
        //End Added By Reshma On 29Nov 2019

    </script>


</body>

</html>
