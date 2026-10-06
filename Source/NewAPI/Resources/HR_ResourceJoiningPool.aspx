<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_ResourceJoiningPool.aspx.vb" Inherits="PbNIT.HR_ResourceJoiningPool" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
<head>
     <!-- Commented by Madhuri.K on 29/08/24 for JQuery and Bootstrap version upgrade -->
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css?v=2">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css?v=2">--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css?v=2">
    <!-- animate css -->
   <%-- <link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/dataTables.bootstrap.min.css?v=0">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_project.css?v=3.1">

<%--    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/adavanced_filter.css?v=0.1">
    <%--alertify Css--%>
    <link href="../../../Whizible2.0/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

    <style type="text/css">
        h5.pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px
        }

        .dblock {
            display: block
        }

        .mb-1 {
            margin-bottom: 10px
        }

        .dataTables_scrollBody {
            margin-bottom: 10px
        }

        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px
        }

        .pgdetailinner {
            padding: 10px
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0
        }

        tr.rowhiglight {
            background: #c3dbff
        }

        .DisableContent {
            pointer-events: none;
            opacity: .5
        }

            .DisableContent:hover {
                cursor: no-drop
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac
        }

        .control-label.required {
            white-space: nowrap
        }

        .ui-datepicker {
            z-index: 9999 !important
        }

        .alertify-notifier {
            z-index: 9999
        }

        .dataTables_scrollHeadInner, .dataTables_scrollHeadInner table {
            width: 100% !important;
        }

        .table tbody td.dataTables_empty {
            text-align: center;
        }
    </style>

</head>

<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 text-right graybg">
            <h5 class="pgtitle pull-left"><%= MyBase.GetResourceString("C_ResourceJoiningPoolMaster") %></h5>
        </div>


        <div class="content pt-0">
            <div class="container-fluid pt-1 pb-1 text-right" style="cursor: auto;">
                <% If m_AddAccess = True Then %>
                <button class="btn borderbtn mr-5 addbtn" id="" onclick="addCRdetail()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                <% End If %>
                <% If m_DeleteAccess Then %>
                <button class="btn borderbtn deletebtn" id="deletebtn" data-toggle="tooltip" data-placement="bottom" title="Delete" onclick="Deleteconfirmationmodal()"><%= MyBase.GetResourceString("C_Delete") %></button>
                <% End If %>
                <% If m_AddAccess = True Then %>
                <a href="javascript:;" class="btn borderbtn mr-5" id="btnDownloadTemplate" data-toggle="modal" onclick="Download_Template()"><%= MyBase.GetResourceString("C_DownloadTemplate") %></a>
                <a href="javascript:;" class="btn borderbtn mr-5" id="btnUpload" data-toggle="modal" onclick="EmpOpenExceluploadsteps()"><%= MyBase.GetResourceString("C_ExcelUpload") %></a>
                <% End If %>
            </div>
            <table id="RJPtbl" class="table table-bordered" style="width: 100%;">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_Move") %></th>
                        <th><%= MyBase.GetResourceString("C_EmployeeName") %></th>
                        <th><%= MyBase.GetResourceString("C_Role") %></th>
                        <th><%= MyBase.GetResourceString("C_Designation") %></th>
                        <th><%= MyBase.GetResourceString("C_TentativeJoinningDate") %></th>
                        <th>
                            <div class="custom_chckbox">
                                <input id="CheckSelectAll" class="chckHead" type="checkbox">
                                <label for="CheckSelectAll"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="RJPtblBody">
                </tbody>
            </table>

        </div>

        <div class="Resourcedetailpanel">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="active" id="Panal1"><a href="#CRsrsdetails" data-toggle="tab" id="" onclick="GetResourceDetailList()"><%= MyBase.GetResourceString("C_Details") %></a><div></div>
                    </li>
                    <li class="" id="Panal2"><a href="#RJPdetailtab2" data-toggle="tab" id="" onclick="BindSkillDetails()"><%= MyBase.GetResourceString("C_Skills") %><span id="SkillCount"></span></a><div></div>
                    </li>
                    <li class="" id="Panal3"><a href="#RJPdetailtab3" data-toggle="tab" id="" onclick="BindQualificationDetails()"><%= MyBase.GetResourceString("C_Qualification") %><span id="QualCount"></span></a><div></div>
                    </li>
                    <li class="" id="Panal4"><a href="#RJPdetailtab4" data-toggle="tab" id="" onclick="BindWorkExpDetails()"><%= MyBase.GetResourceString("C_PreWorkExp") %><span id="ExpCount"></span></a><div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="CRsrsdetails" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="BtnSave" onclick="SaveJoiningPoolData()"><%= MyBase.GetResourceString("C_Save") %></button>
                            <% If m_AddAccess Then %>
                            <button class="btn btnyellow mr-5" id="BtnSaveAndAdd" onclick="SaveAndAddJoiningPoolDetails()"><%= MyBase.GetResourceString("C_SaveAndAdd") %></button>
                            <% End If %>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_EmployeeName") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='30'", ,, True,,,,) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_Address") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtAddress", "txtAddress", , "autocomplete='off' form-control",,,,,,,,,,,,,,,,,,,,,,,,,) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_Contact") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPhone", "txtPhone", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='50'", ,, True,,,,) %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_Role") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRoleDescription", "EXEC usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-control' ",, ,, ) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_Designation") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDesignationID", "EXEC usp_Whizible2_Sel_tbl_PM_DesignationMaster",,, "class='form-control' ",, ,, ) %>
                            </div>
                            <div class="col-sm-4 form-group">
                                <label class="required"><%= MyBase.GetResourceString("C_TentativeJoinningDate") %></label>
                                <div class="input-group">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtJoiningDate", "txtJoiningDate", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='50'", ,, True,,,,) %>
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="RJPdetailtab2" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn mr-5" id="" onclick="AddSkillDetail()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                            <% If m_DeleteAccess Then %>
                            <button class="btn borderbtn mr-5" id="" onclick="DeleteSkillconfirmationmodal()"><%= MyBase.GetResourceString("C_Delete") %></button>
                            <% End If %>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>

                        <table class="table table-stripped" id="RJPSkilltbl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_Skill") %></th>
                                    <th><%= MyBase.GetResourceString("C_ExperienceYears") %></th>
                                    <th><%= MyBase.GetResourceString("C_ExperienceMonths") %></th>
                                    <th><%= MyBase.GetResourceString("C_Proficiency") %></th>
                                    <th><%= MyBase.GetResourceString("C_CoreCompetency") %></th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="RJPSkillCheck0" class="chckHeadSkill" type="checkbox">
                                            <label for="RJPSkillCheck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="RJPSkilltblbody">
                            </tbody>
                        </table>
                    </div>

                    <div id="RJPdetailtab3" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn mr-5" id="" onclick="ShowQualModal()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                            <% If m_DeleteAccess Then %>
                            <button class="btn borderbtn mr-5" id="" onclick="DeleteQualificationconfirmationmodal()"><%= MyBase.GetResourceString("C_Delete") %></button>
                            <% End If %>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>

                        <table id="Qualtbl" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_Qualification") %></th>
                                    <th><%= MyBase.GetResourceString("C_UniversityName") %></th>
                                    <th><%= MyBase.GetResourceString("C_PassoutYear") %></th>
                                    <th><%= MyBase.GetResourceString("C_Class") %></th>
                                    <th><%= MyBase.GetResourceString("C_Percentage") %></th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="chckQualHead" class="chckQualHead" type="checkbox">
                                            <label for="chckQualHead"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="Qualtblbody">
                            </tbody>
                        </table>

                    </div>

                    <div id="RJPdetailtab4" class="tab-pane">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn borderbtn mr-5" id="" onclick="ShowExpModal()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></button>
                            <% If m_DeleteAccess Then %>
                            <button class="btn borderbtn mr-5" id="" onclick="DeleteExperianceDetail()"><%= MyBase.GetResourceString("C_Delete") %></button>
                            <% End If %>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>


                        <table id="RJPWrkExptbl" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_OrganizationName") %></th>
                                    <th><%= MyBase.GetResourceString("C_FromDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_TillDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_PositionHeld") %></th>
                                    <th><%= MyBase.GetResourceString("C_WorkProfile") %></th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="chckExpHead" class="chckExpHead" type="checkbox">
                                            <label for="chckExpHead"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="RJPWrkExptblBody">
                            </tbody>
                        </table>

                    </div>

                </div>
            </div>
        </div>


        <!-- Skills Modal start here-->
        <div class="modal custmodal fade" id="RJPAddskillmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Skill") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="rowhiglight pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveOrUpdateSkill()"><%= MyBase.GetResourceString("C_Save") %></button>
                            <% If m_AddAccess Then %>
                            <button class="btn btnyellow mr-5" id="" onclick="SaveAndAddUpdateDetails()"><%= MyBase.GetResourceString("C_SaveAndAdd") %></button>
                            <% End If %>
                        </div>
                        <br />



                        <div class="form-group">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_Skill") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRJPSkillID", "Select ''",,, "class='form-control'",) %>
                            </div>
                            <div class="col-sm-8">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label><%= MyBase.GetResourceString("C_ExperienceYears") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRJPExpYr", "EXEC usp_sel_GetYears 0, 50",,, "class='form-control'",) %>
                                    </div>
                                    <div class="col-sm-4">
                                        <label><%= MyBase.GetResourceString("C_ExperienceMonths") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRJPExpMon", "EXEC usp_sel_GetYears 0, 11",,, "class='form-control'",) %>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_Proficiency") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRJPProficiencyID", "EXEC usp_Sel_tbl_HR_Parameters 7",,, "class='form-control'",) %>
                            </div>
                            <div class="col-sm-8">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label><%= MyBase.GetResourceString("C_CoreCompetency") %></label>
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkRJPCompetency", "chkRJPCompetency") %>
                                    </div>
                                    <div class="col-sm-4">
                                        <label><%= MyBase.GetResourceString("C_Note") %></label>
                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtNote", "txtNote",, "form-control",,,,, , , 300,,,,,,,, "autocomplete='Off' maxlength='100'",,,,,,,,,,) %>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">


                            <div class="clearfix"></div>
                        </div>

                        <div class="clearfix"></div>
                        <hr />

                        <div class="btnrow text-center">
                            <!--<button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>-->
                            <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Skills Modal End here-->

        <!-- Qualification Modal start here-->
        <div class="modal custmodal fade" id="qualmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Qualification") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="rowhiglight pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveOrUpdateQualification()"><%= MyBase.GetResourceString("C_Save") %></button>
                            <% If m_AddAccess Then %>
                            <button class="btn btnyellow mr-5" id="" onclick="SaveAndAddQualification()"><%= MyBase.GetResourceString("C_SaveAndAdd") %></button>
                            <%End If %>
                        </div>
                        <br />



                        <div class="form-group">
                            <div class="col-sm-6">
                                <label class="required"><%= MyBase.GetResourceString("C_Qualification") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRJPQualification", "Exec usp_Sel_tbl_PM_Qualifications",,, "class='form-control'",) %>
                            </div>
                            <div class="col-sm-6">
                                <label class="required"><%= MyBase.GetResourceString("C_UniversityName") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRJPUniversityName", "txtRJPUniversityName", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='200'", ,, True,,,,) %>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label class="required"><%= MyBase.GetResourceString("C_PassoutYear") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRJPYear", "Exec usp_Sel_GetYears 1950",,, "class='form-control'",) %>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_Class") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRJPClass", "txtRJPClass", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='50'", ,, True,,,,) %>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label class=""><%= MyBase.GetResourceString("C_Percentage") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRJPPercentage", "txtRJPPercentage", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='3' ", ,, True,,,,) %>
                            </div>
                            <div class="col-sm-6">
                                &nbsp;
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">


                            <div class="clearfix"></div>
                        </div>


                        <div class="clearfix"></div>
                        <hr />

                        <div class="btnrow text-center">
                            <!--<button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>-->
                            <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Qualification Modal End here-->

        <!-- Prev. Work Exp. Modal start here-->
        <div class="modal custmodal fade" id="wrkExpModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_WorkExperience") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="rowhiglight pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="" onclick="SaveOrUpdateExpPrev()"><%= MyBase.GetResourceString("C_Save") %></button>
                            <% If m_AddAccess Then %>
                            <button class="btn btnyellow mr-5" id onclick="SaveAndAddExpPrev()"><%= MyBase.GetResourceString("C_SaveAndAdd") %></button>
                            <% End If %>
                        </div>
                        <br />



                        <div class="form-group">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_OrganizationName") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRJPOrganizationName", "txtRJPOrganizationName", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                            </div>
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label><%= MyBase.GetResourceString("C_FromDate") %></label>
                                        <div class="input-group">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRJPFromDate", "txtRJPFromDate", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label><%= MyBase.GetResourceString("C_TillDate") %></label>
                                        <div class="input-group">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRJPToDate", "txtRJPToDate", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label class="required"><%= MyBase.GetResourceString("C_PositionHeld") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRJPPositionHeld", "txtRJPPositionHeld", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("C_WorkProfile") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRDJPWorkProfile", "Exec usp_Sel_tbl_HR_Parameters 5",,, "class='form-control'",) %>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label class=""><%= MyBase.GetResourceString("C_Summary") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtRJPSummery", "txtRJPSummery",, "form-control",,,,, , , 300,,,,,,,, "autocomplete='Off' maxlength='100'",,,,,,,,,,) %>
                            </div>
                            <div class="col-sm-6">
                                &nbsp;
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">


                            <div class="clearfix"></div>
                        </div>


                        <div class="clearfix"></div>
                        <hr />

                        <div class="btnrow text-center">
                            <!--<button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>-->
                            <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Prev. Work Exp. Modal End here-->

        <!--Excel Upload Modal start here-->
        <div id="exceluploadsteps" class="modal fade custmodal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ExcelUpload") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!--step_wizard-->
                        <ul class="nav nav-wizard">
                            <li class="active">
                                <a href="#PBEUstep1" data-toggle="tab" id="btnaStep1"><%= MyBase.GetResourceString("C_Step1") %></a>
                            </li>
                            <li class="disabled">
                                <a href="#PBEUstep2" data-toggle="tab" id="btnaStep2"><%= MyBase.GetResourceString("C_Step2") %></a>
                            </li>
                            <li class="disabled">
                                <a href="#PBEUstep3" data-toggle="tab" id="btnaStep3"><%= MyBase.GetResourceString("C_Step3") %></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="PBEUstep1">
                                <div class="file_attach">
                                    <form id="frmFileUpload">
                                        <input type="file" multiple id="txtFileUpload" onchange="showName()" accept=".xlsx">
                                        <p><span id="plabelName"></span><span id="dvShowFileName"></span></p>
                                        <button type="submit"><%= MyBase.GetResourceString("C_Upload") %></button>
                                    </form>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="clearfix"></div>
                                <br />
                                <br />
                                <div class="list-inline text-center">
                                    <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="EmpUploadxlsfile()"><%= MyBase.GetResourceString("C_Next") %></button>
                                </div>

                            </div>

                            <div class="tab-pane" id="PBEUstep2">
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class=""><%= MyBase.GetResourceString("C_ExcelColumnA") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_A", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class=""><%= MyBase.GetResourceString("C_ExcelColumnB") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_B", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class=""><%= MyBase.GetResourceString("C_ExcelColumnC") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_C", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class=""><%= MyBase.GetResourceString("C_ExcelColumnD") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_D", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <label class=""><%= MyBase.GetResourceString("C_ExcelColumnE") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_E", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class=""><%= MyBase.GetResourceString("C_ExcelColumnF") %></label>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboIrmExcelColumn_F", "Select 0,'  Select Column ' ",,, " class='form-control issueselectprojects'' ",,, True) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <br />
                                <br />
                                <ul class="list-inline text-center">
                                    <li>
                                        <button id="btnPrevious" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_2()"><%= MyBase.GetResourceString("C_Back") %></button>
                                        <button type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="IrmNextStep_2()"><%= MyBase.GetResourceString("C_Next") %></button></li>
                                </ul>

                            </div>
                            <div class="tab-pane" id="PBEUstep3">

                                <p class="pull-left"><a href="#"><%= MyBase.GetResourceString("C_UploadedData") %> :-</a><span id="dvShowFileNameStep3"></span></p>
                                <div class="form-group pull-right">
                                    <div class="input-group searchsetting" id="searchsetting">
                                        <input id="txtSearchXlsxEmpName" type="text" class="form-control searchempname" placeholder="Search Employee name">
                                        <span class="input-group-addon">
                                            <button type="submit" onclick="SearchEmplistByName()">
                                                <span class="glyphicon glyphicon-search"></span>
                                            </button>
                                        </span>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                                <div class="table-responsive">
                                    <table id="exluploadTbl" class="table bgwhite table-bordered" style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th><%= MyBase.GetResourceString("C_IsValid") %></th>
                                                <th><%= MyBase.GetResourceString("C_EmployeeName") %></th>
                                                <th><%= MyBase.GetResourceString("C_Role") %></th>
                                                <th><%= MyBase.GetResourceString("C_Designation") %></th>
                                                <th><%= MyBase.GetResourceString("C_TentativeJoinningDate") %></th>
                                                <th><%= MyBase.GetResourceString("C_PrimarySkills") %></th>
                                                <th><%= MyBase.GetResourceString("C_OtherSkills") %></th>
                                                <th><%= MyBase.GetResourceString("C_Error") %></th>
                                            </tr>
                                        </thead>

                                        <tbody id="exluploadTblTbody">
                                        </tbody>

                                    </table>
                                </div>
                                <br />
                                <br />
                                <ul class="list-inline text-center" style="margin-bottom: -20px;">
                                    <li>
                                        <button id="btnPreviousS" type="button" class="btn borderbtn btnPrevious" onclick="IrmBackStep_3()"><%= MyBase.GetResourceString("C_Back") %></button>
                                        <button type="button" id="btnEmpXlsxSave" class="btn btnyellow nextwizardbtn ml-1 uploadbtn" onclick="IrmSaveXlsxData()"><%= MyBase.GetResourceString("C_Upload") %></button>
                                    </li>
                                </ul>


                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <!--End_step_wizard-->

                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- Excel Upload Modal End here-->

        <!-- RJP Employee detail Modal start here-->
        <div class="modal custmodal fade" id="RJPEmpDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Employee") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="rowhiglight pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="" onclick="MoveEmployeeFromJoinPool()"><%= MyBase.GetResourceString("C_Save") %></button>
                        </div>
                        <br />

                        <div class="col-sm-6">
                            <div class="row form-group">
                                <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_EmployeeName") %></label>
                                <div class="col-sm-7 pl-0">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtMoveEmployeeName", "txtMoveEmployeeName", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30'", ,, True,,,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_EmployeeCode") %></label>
                                <div class="col-sm-7 pl-0">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeCode", "txtEmployeeCode", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='50'", ,, True,,,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_UserName") %></label>
                                <div class="col-sm-7 pl-0">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtUserName", "txtUserName", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30'", ,, True,,,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_LDAP") %></label>
                                <div class="col-sm-7 pl-0">
                                    <div class="custom_chckbox">
                                        <% CommonFunctions.HTMLControls.DrawCheckBox("ChkIsLDAPAuthentication", "ChkIsLDAPAuthentication") %>
                                        <label for="ChkIsLDAPAuthentication"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row">
                                <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_BirthDate") %></label>
                                <div class="col-sm-7 pl-0">
                                    <div class="input-group datefielddiv">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtBirthDate", "txtBirthDate", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30'", ,, True,,,,) %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_Gender") %></label>
                                <div class="col-sm-7 pl-0">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboGender", "Exec usp_Whizible2_Sel_tbl_PM_Gender",,, "class='form-control'",) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row">
                                <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_EmailID") %></label>
                                <div class="col-sm-7 pl-0">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtEmailID", "txtEmailID", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='50'", ,, True,,,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <label for="" class="col-sm-5 control-label "><%= MyBase.GetResourceString("C_BloodGroup") %></label>
                                <div class="col-sm-7 pl-0">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboBloodGroup", "Exec usp_Whizible2_Sel_BloodGroup",,, "class='form-control'",) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6">
                        </div>

                        <div class="clearfix"></div>
                        <hr />
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label">&nbsp;</label>
                                    <div class="col-sm-7 pl-0">
                                        <label class=""><%= MyBase.GetResourceString("C_PermanantAddress") %></label>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_Address") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtMoveAddress", "txtMoveAddress",, "form-control",,,,, , , 300,,,,,,,, "autocomplete='Off' maxlength='255'",,,,,,,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_City") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCity", "txtCity", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30'", ,, True,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_State") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtState", "txtState", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30' ", ,, True,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_PinCode") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPinCode", "txtPinCode", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30' onkeypress='return /[0-9]/i.test(event.key)'", ,, True,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_Phone") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtMovePhone", "txtMovePhone", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30' onkeypress='return /[0-9]/i.test(event.key)'", ,, True,,,,) %>
                                    </div>
                                </div>
                            </div>



                            <div class="col-sm-6">
                                <div class="row form-group">
                                    <div class="custom_chckbox">
                                        <input id="MECurrentAddressCheck" class="" type="checkbox">
                                        <label for="MECurrentAddressCheck"><%= MyBase.GetResourceString("C_CurrentAddressifPer") %></label>
                                    </div>

                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_Address") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtCurrAddress", "txtCurrAddress",, "form-control",,,,, , , 300,,,,,,,, "autocomplete='Off' maxlength='30'",,,,,,,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_City") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrCity", "txtCurrCity", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30'", ,, True,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_State") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrState", "txtCurrState", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30'", ,, True,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_PinCode") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrPinCode", "txtCurrPinCode", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='6' onkeypress='return /[0-9]/i.test(event.key)'", ,, True,,,,) %>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_Phone") %></label>
                                    <div class="col-sm-7 pl-0">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrPhone", "txtCurrPhone", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='30' onkeypress='return /[0-9]/i.test(event.key)'", ,, True,,,,) %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>


                        <hr style="border-color: #ddd; border-style: dashed; margin: 20px 5px;" />

                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_Role") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Exec usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-control'",) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_Designation") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "Exec usp_Whizible2_Sel_tbl_PM_DesignationMaster",,, "class='form-control'",) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_DeptUnit") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "Exec usp_Whizible2_Sel_PM_DepartmentList",,, "class='form-control'",) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_Employeetype") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboEmployeeType", "Exec usp_whizible2_Sel_tbl_RTS_ProjectSpecificControlData 'EmployeeType'",,, "class='form-control'",) %>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_ReportingTo") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboReportingTo", "usp_Whizible2_sel_tbl_ReportingTo",,, "class='form-control'",,,, ,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_JoiningDate") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <div class="input-group datefielddiv">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtMoveJoiningDate", "txtMoveJoiningDate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_RateHour") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtRatePerHr", "txtRatePerHr", cssClass:="form-control", widthInPixel:=0, maxLength:=8, ToBeInserted:="autocomplete='off'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_CostHour") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtCostPerHr", "txtCostPerHr", cssClass:="form-control", widthInPixel:=0, maxLength:=8, ToBeInserted:="autocomplete='off'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_CostToCompany") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtCostToCompany", "txtCostToCompany", cssClass:="form-control", widthInPixel:=0, maxLength:=12, ToBeInserted:="autocomplete='off'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_CostandRateCurrency") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "autocomplete='off' class='form-control'",,,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>



                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_BusinessGroup") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "EXEC usp_Whizible2_sel_BGEmployee",,, "class=""form-control"" onChange=""FillOU(this.value,2)""",,,, ,)%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_OrganizationUnit") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboOU", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDU(this.value,2)""",,,, , ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_DeliveryUnit") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDU", "Select 0,'' ",,, "class=""form-control"" onChange=""FillDT(this.value,undefined,2)""",,,, ,)%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_DeliveryTeam") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDT", "Select 0,'' ",,, "class=""form-control""",,,, ,)%>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_Facility") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboFacility", "usp_Whizible2_Sel_tbl_PM_Facility",,, "class=""form-control clsPlanWidth"" ,""",,,, ,)%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_ExNo") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtExtensionNo", "txtExtensionNo", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:="autocomplete='off'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label required"><%= MyBase.GetResourceString("C_Deployable") %> </label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "EXEC usp_Whizible2_Sel_Employee_Deployable",,, "class='form-control'",,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_Grade") %> </label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboGrade", "usp_Whizible2_sel_tbl_PM_GradeMaster_GradeID",,, "class='form-control'",,,, ,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row form-group">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_MbNO") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtMobileNumber", "txtMobileNumber", "form-control") %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_MsgID") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <% CommonFunctions.HTMLControls.DrawTextArea("txtInstantMsgID", "txtInstantMsgID",, "form-control",,,,, , , 100,,,,,,,, " autocomplete='Off' maxlength='200'",,,,,,,,,,) %>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>


                            <hr style="border-color: #ddd; border-style: dashed; margin: 20px 5px;" />

                        </div>

                        <div class="clearfix"></div>

                        <div class="row">

                            <div class="form-group">
                                <h4 style="margin: 0 15px 15px;"><%= MyBase.GetResourceString("C_PassportDetails") %></h4>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label "><%= MyBase.GetResourceString("C_PassNo") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPassportNumber", "txtPassportNumber", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:="autocomplete='off'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label "><%= MyBase.GetResourceString("C_Placeofissue") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPlaceOfIssue", "txtPlaceOfIssue", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:="autocomplete='off'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_DateofIssue") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <div class="input-group datefielddiv">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtDateOfIssue", "txtDateOfIssue", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_ExpiaryDate") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <div class="input-group datefielddiv">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtExpirydate", "txtExpirydate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_FullName") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPPFullName", "txtPPFullName", "form-control", 0, 50,,,,,,,, "autocomplete='off' onkeypress='return /[0-9a-zA-Z]/i.test(event.key)'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_Relative") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtPPRelativeName", "txtPPRelativeName", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:="autocomplete='off' onkeypress='return /[0-9a-zA-Z]/i.test(event.key)'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label for="" class="col-sm-5 control-label"><%= MyBase.GetResourceString("C_PageLeft") %></label>
                                        <div class="col-sm-7 pl-0">
                                            <%CommonFunctions.HTMLControls.DrawTextBox("txtNoofPagesLeft", "txtNoofPagesLeft", cssClass:="form-control", widthInPixel:=0, maxLength:=3, ToBeInserted:="autocomplete='off'")%>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <hr />

                        <div class="btnrow text-center">
                            <button id="savefilterbtn" class="btn btnyellow" onclick="MoveEmployeeFromJoinPool()"><%= MyBase.GetResourceString("C_Save") %></button>
                            <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- RJP Employee detail Modal End here-->

        <!--Delete confrimation modal start here -->
        <div class="modal custmodal fade" id="Deleteconfirmationmodal" aria-hidden="true" data-dismiss="modal" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_DeleteConfirmation") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <span id="CheckModal"></span>
                            <p><%= MyBase.GetResourceString("C_DeleteNote") %></p>
                        </div>
                        <br />
                        <div class="">
                            <a href="javascript:;" data-dismiss="modal" class="btn borderbtn" onclick=""><%= MyBase.GetResourceString("C_No") %></a>
                            <a href="javascript:;" data-dismiss="modal" class="btn btnyellow  pull-right" onclick="DeleteEmployee()"><%= MyBase.GetResourceString("C_Yes") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Delete confrimation modal -->

        <!--Skill Delete confrimation modal start here -->
        <div class="modal custmodal fade" id="DeleteSkillconfirmationmodal" aria-hidden="true" data-dismiss="modal" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_DeleteConfirmation") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <span id=""></span>
                            <p><%= MyBase.GetResourceString("C_DeleteNote") %></p>
                        </div>
                        <br />
                        <div class="">
                            <a href="javascript:;" data-dismiss="modal" class="btn borderbtn" onclick=""><%= MyBase.GetResourceString("C_No") %>No</a>
                            <a href="javascript:;" data-dismiss="modal" class="btn btnyellow  pull-right" onclick="DeleteSkillDetail()"><%= MyBase.GetResourceString("C_Yes") %>Yes</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Delete confrimation modal -->

        <!--Qualification Delete confrimation modal start here -->
        <div class="modal custmodal fade" id="DeleteQualiconfirmationmodal" aria-hidden="true" data-dismiss="modal" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_DeleteConfirmation") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <span id=""></span>
                            <p><%= MyBase.GetResourceString("C_DeleteNote") %></p>
                        </div>
                        <br />
                        <div class="">
                            <a href="javascript:;" data-dismiss="modal" class="btn borderbtn" onclick=""><%= MyBase.GetResourceString("C_No") %></a>
                            <a href="javascript:;" data-dismiss="modal" class="btn btnyellow  pull-right" onclick="DeleteQualificationDetail()"><%= MyBase.GetResourceString("C_Yes") %>Yes</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Delete confrimation modal -->

        <!--eXP Delete confrimation modal start here -->
        <div class="modal custmodal fade" id="DeleteExpfirmationmodal" aria-hidden="true" data-dismiss="modal" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_DeleteConfirmation") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <span id=""></span>
                            <p><%= MyBase.GetResourceString("C_DeleteNote") %></p>
                        </div>
                        <br />
                        <div class="">
                            <a href="javascript:;" data-dismiss="modal" class="btn borderbtn" onclick=""><%= MyBase.GetResourceString("C_No") %></a>
                            <a href="javascript:;" data-dismiss="modal" class="btn btnyellow  pull-right" onclick="DeleteExperianceDetail()"><%= MyBase.GetResourceString("C_Yes") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Delete confrimation modal -->

        <input type="hidden" id="HdnEmployeeID" name="HdnEmployeeID" value="">
        <input type="hidden" id="HdnEmployeeSkillID" name="HdnEmployeeSkillID" value="">
        <input type="hidden" id="HdnEmployeeQualID" name="HdnEmployeeQualID" value="">
        <input type="hidden" id="HdnWrkExpID" name="HdnWrkExpID" value="">
        <input type="hidden" id="HdnMoveEmployeeID" name="HdnMoveEmployeeID" value="">

        <div class="clearfix"></div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
<%--    <script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/jquery.dataTables.min.js"></script>

    <!-- alertify -->
    <script src="../../../Whizible2.0/plugins/alertify/alertify.min.js"></script>--%>

    <!--Added for loader-->
    <!-- custome js -->
    <script src="../../../Whizible2.0/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>

    <script>

        $("[data-toggle='tooltip'], [data-toggle='collapse'], [data-toggle='dropdown']").tooltip();

        function refreshPage() {
            window.location.reload();
        }

        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
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
        $('#FCRD, #CRdetailDate, #RJPBirthdateinput, #txtJoiningDate, #txtRJPToDate, #txtRJPFromDate,#txtDateOfIssue,#txtExpirydate,#txtBirthDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'd M yy'
        });

        //Detailpanel Script start from here
        function addCRdetail() {
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#CRtble_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .borderbox, .filter,#Panal2,#Panal3,#Panal4,#btnUpload,#RJPtblBody").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
            $("#HdnEmployeeID").val('');


        }

        function editRJPdetails(EmployeeID) {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#CRtble_wrapper .dataTables_scrollBody, .backbtn, #CRtble_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter,#btnUpload,#RJPtblBody").addClass("DisableContent").parent().css("cursor", "no-drop");
            $("#Panal2,#Panal3,#Panal4").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
            $("#HdnEmployeeID").val(EmployeeID);
            BindPoolData(EmployeeID);

        }

        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });

        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#CRtble_wrapper .dataTables_scrollBody, .backbtn, #CRtble_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter,#Panal2,#Panal3,#Panal4,#btnUpload,#RJPtblBody").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();

        });

        function resizeSection() {
            //var tblheight = $(window).height();
            //$('#InfraTypeListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 220, "overflow-y": "auto" });


        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });

    </script>

    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        alertify.set('notifier', 'position', 'top-right');
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var ajaxResult = "";
        $(document).ready(function () {
            $('body').tooltip({
                selector: '[data-toggle="tooltip"], [title]:not([data-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-toggle="tooltip"], [title]:not([data-toggle="popover"])', function () {
                $('[data-toggle="tooltip"], [title]:not([data-toggle="popover"])').tooltip('destroy');
            });
            $('body').tooltip({
                selector: '[data-toggle="tooltip"], [title]:not([data-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-toggle="tooltip"], [title]:not([data-toggle="popover"])', function () {
                $('[data-toggle="tooltip"], [title]:not([data-toggle="popover"])').tooltip('destroy');
            });
            BindPlaceholder();
            GetResourceDetailList();
        });

        function GetResourceDetailList() {

            //StartLoader("#RDSBody");
            $("#RJPtbl").dataTable().fnDestroy();

            var param = JSON.stringify();
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetResourceDetailList", param, false);
            $("#RJPtblBody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var EmployeeID = strResult[i]["EmployeeID"];
                var EmployeeName = strResult[i]["EmployeeName"];
                var RoleDescription = strResult[i]["RoleDescription"];
                var DesignationName = strResult[i]["DesignationName"];
                var JoiningDate = strResult[i]["JoiningDate"];

                strHTML += '<tr>'
                strHTML += '<td><a href="javascript:;" data-toggle="modal" data-target="#RJPEmpDetailModal" onclick=BindResourceMoveData(' + EmployeeID + ')><i class="fas fa-file-export" data-toggle="tooltip" data-placement="top" data-title="Employee Details"></i></a></td>'
                <% If m_EditAccess Then %>
                strHTML += '<td><a href="javascript:;" onclick="editRJPdetails(' + EmployeeID + ')">' + EmployeeName + '</a></td>'
                <% Else %>
                strHTML += '<td>' + EmployeeName + '</td>'
                <% End If %>
                strHTML += '<td>' + RoleDescription + '</td>'
                strHTML += '<td>' + DesignationName + '</td>'
                strHTML += '<td>' + JoiningDate + '</td>'
                strHTML += '<td>'
                strHTML += '<div class="custom_chckbox">'
                strHTML += '<input id="RJPCheck_' + EmployeeID + '" class="chcktbl" name="checkRJP" type="checkbox" value = ' + EmployeeID + '>'
                strHTML += '<label for="RJPCheck_' + EmployeeID + '"></label>'
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '</tr>'
            }
            $("#RJPtblBody").html("")
            $("#RJPtblBody").html(strHTML);

            $('#RJPtbl').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true

            });

        }

        function ValidateDetails() {
            var Employee = $("#txtEmployeeName").val();
            var Address = $("#txtAddress").val();
            var Contact = $("#txtPhone").val();
            var Role = $("#cboRoleDescription").val();
            var Designation = $("#cboDesignationID").val();
            var JoiningDate = $("#txtJoiningDate").val();
            var currentDate = $.datepicker.formatDate('d M yy', new Date());
            if (isBlank(Employee)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankEmpName") %>")
                $("#txtEmployeeName").focus();
                return false;
            }
            else if (isBlank(Address)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankAddress") %>")
                $("#txtAddress").focus();
                return false;
            }
            else if (isBlank(Contact)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankContact") %>")
                $("#txtPhone").focus();
                return false;
            }
            else if (isBlank(Role)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankRole") %>")
                $("#cboRoleDescription").focus();
                return false;
            }
            else if (isBlank(Designation)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankDesignation") %>")
                $("#cboDesignationID").focus();
                return false;
            }
            else if (isBlank(JoiningDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankTentitiveDate") %>")
                $("#txtJoiningDate").focus();
                return false;
            }
            else if (Date.parse(currentDate) > Date.parse(JoiningDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_TenNotLessTodayDate") %>");
                $("#JoiningDate").focus();
                return false;
            }
            else {
                return true;
            }

        }

        function SaveJoiningPoolData() {
            if (ValidateDetails() == true) {
                var EmployeeName = $("#txtEmployeeName").val();
                var Address = $("#txtAddress").val();
                var Contact = $("#txtPhone").val();
                var Role = $("#cboRoleDescription").val();
                var Designation = $("#cboDesignationID").val();
                var JoiningDate = $("#txtJoiningDate").val();
                var EmployeeID = $("#HdnEmployeeID").val();
                var Parameter = {
                    EmployeeName: EmployeeName,
                    Address: Address,
                    Contact: Contact,
                    Role: Role,
                    Designation: Designation,
                    JoiningDate: JoiningDate,
                    EmployeeID: EmployeeID,
                    LoginType: LoginType,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/SaveOrUpdateResource", param, false);
                if (Result == "Resource Updated Successfully") {
                    alertify.success(Result);
                } else {
                    alertify.success("<%= MyBase.GetResourceString("A_ResourceAdded") %>");
                    $("#HdnEmployeeID").val(Result);
                }
                $("#Panal2,#Panal3,#Panal4").removeClass("DisableContent").parent().css("cursor", "auto");
                GetResourceDetailList();
            }
        }

        function SaveAndAddJoiningPoolDetails() {
            if (ValidateDetails() == true) {
                SaveJoiningPoolData();
                ClearDetailTab();
                $("#HdnEmployeeID").val('');
                $("#Panal2,#Panal3,#Panal4").addClass("DisableContent").parent().css("cursor", "no-drop");
            }
        }

        function ClearDetailTab() {
            $("#txtEmployeeName").val('');
            $("#txtAddress").val('');
            $("#txtPhone").val('');
            $("#cboRoleDescription").val('');
            $("#cboDesignationID").val('');
            $("#txtJoiningDate").val('');
        }

        function BindPoolData(EmployeeID) {
            $("#HdnEmployeeID").val(EmployeeID);
            var param = JSON.stringify(EmployeeID);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetResourceDetailList", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var EmployeeID = strResult[i]["EmployeeID"];
                var EmployeeName = strResult[i]["EmployeeName"];
                var PostID = strResult[i]["PostID"];
                var DesignationID = strResult[i]["DesignationID"];
                var JoiningDate = strResult[i]["JoiningDate"];
                var Address = strResult[i]["Address"];
                var Phone = strResult[i]["Phone"];

                $("#txtEmployeeName").val(EmployeeName);
                $("#txtAddress").val(Address);
                $("#txtPhone").val(Phone);
                $("#cboRoleDescription").val(PostID);
                $("#cboDesignationID").val(DesignationID);
                $("#txtJoiningDate").val(JoiningDate);

            }
        }

        function Deleteconfirmationmodal() {
            var RJPIDs = "";
            var table = $('#RJPtbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            RJPIDs = $('input[name=checkRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            if (RJPIDs.length != 0) {
                $("#Deleteconfirmationmodal").modal('show');
            } else {
                alertify.error("<%= MyBase.GetResourceString("A_SelectOneRecord") %>");
                return false;
            }
        }

        function DeleteEmployee() {
            var curResult = "";
            var table = $('#RJPtbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var RJPIDs = $('input[name=checkRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrRJPIDs = RJPIDs.split(',');
            for (var i = 0; i < arrRJPIDs.length; i++) {
                var EmployeeID = arrRJPIDs[i];
                var param = JSON.stringify(encodeURI(EmployeeID));
                var result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/DeleteEmployee", param, false);
            }
            alertify.success("<%= MyBase.GetResourceString("A_ResourceDeleted") %>");
            GetResourceDetailList();
            $(".chckHead").prop("checked", false);
        }


        //this use for if uncheck one of the Checkbox then remove check of Select all
        $(document).on('change', '.chcktbl', function () {

            var table = $("#RJPtbl").DataTable();
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl').length;
            var checked1 = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;
            if (checked == checked1) {
                $(".chckHead").prop("checked", true);
            }
            else {
                $(".chckHead").prop("checked", false);
            }
        });

        //Check Or Uncheck All checkBox
        $('#CheckSelectAll').click(function () {

            var table = $('#RJPtbl').DataTable();
            if ($(this).prop("checked") == true) {

                var rows1 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows1).each(function () {
                    this.checked = true;
                });

            }
            else if ($(this).prop("checked") == false) {
                var rows2 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows2).each(function () {
                    this.checked = false;
                });
            }
        });

        //////////////////////////   Skill Part Start From Here ///////////////////////////////////////
        function BindSkillDetails() {
            $("#RJPSkilltbl").dataTable().fnDestroy();
            var EmployeeID = $("#HdnEmployeeID").val();
            var parameter = {
                EmployeeSkillID: EmployeeSkillID,
                EmployeeID: EmployeeID,
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetResourceSkillDetailList", param, false);
            $("#RJPSkilltblbody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var Description = strResult[i]["Description"];
                var MonthsOfExperience = strResult[i]["MonthsOfExperience"];
                var YearsOfExperience = strResult[i]["YearsOfExperience"];
                var Proficiency = strResult[i]["Proficiency"];
                var HasCoreCompetency = strResult[i]["HasCoreCompetency"];
                var EmployeeSkillID = strResult[i]["EmployeeSkillID"];
                if (HasCoreCompetency == true) {
                    HasCoreCompetency = 'Yes';
                }
                else {
                    HasCoreCompetency = 'No';
                }

                if (Proficiency == null || Proficiency == undefined) {
                    Proficiency = '';
                }
                strHTML += '<tr>'
                strHTML += '<td><a href="javascript:;" onclick=EditSkillDetail(' + EmployeeSkillID + ')>' + Description + '</a></td>'
                strHTML += '<td>' + YearsOfExperience + '</td>'
                strHTML += '<td>' + MonthsOfExperience + '</td>'
                strHTML += '<td>' + Proficiency + '</td>'
                strHTML += '<td>' + HasCoreCompetency + '</td>'
                strHTML += '<td>'
                strHTML += '<div class="custom_chckbox">'
                strHTML += '<input id="RJPSkillCheck_' + EmployeeSkillID + '" class="chckSkilltbl" name="checkSkillRJP" type="checkbox" value = ' + EmployeeSkillID + '>'
                strHTML += '<label for="RJPSkillCheck_' + EmployeeSkillID + '"></label>'
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '</tr>'
            }
            $("#RJPSkilltblbody").html("")
            $("#RJPSkilltblbody").html(strHTML);
            $('#RJPSkilltbl').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true

            });
        }

        function EditSkillDetail(EmployeeSkillID) {
            BindSkillDropDown(EmployeeSkillID);
            $("#RJPAddskillmodal").modal('show');

            $("#HdnEmployeeSkillID").val(EmployeeSkillID);
            var EmployeeID = $("#HdnEmployeeID").val();
            var parameter = {
                EmployeeSkillID: EmployeeSkillID,
                EmployeeID: EmployeeID,

            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetResourceSkillDetailList", param, false);

            for (var i = 0; i < strResult.length; i++) {
                var Description = strResult[i]["Description"];
                var MonthsOfExperience = strResult[i]["MonthsOfExperience"];
                var YearsOfExperience = strResult[i]["YearsOfExperience"];
                var Proficiency = strResult[i]["Proficiency"];
                var HasCoreCompetency = strResult[i]["HasCoreCompetency"];
                var EmployeeSkillID = strResult[i]["EmployeeSkillID"];
                var ToolID = strResult[i]["ToolID"];

                $("#cboRJPSkillID").val(ToolID);
                $("#cboRJPExpYr").val(YearsOfExperience);
                $("#cboRJPExpMon").val(MonthsOfExperience);
                $("#cboRJPProficiencyID").val(Proficiency);
                $("#chkRJPCompetency").val(HasCoreCompetency);
            }
        }

        function AddSkillDetail() {
            $("#HdnEmployeeSkillID").val('');
            $("#RJPAddskillmodal").modal('show');
            BindSkillDropDown("NULL");
            $("#RJPAddskillmodal").modal('show');
            $("#cboRJPSkillID").val('');
            $("#cboRJPExpYr").val('');
            $("#cboRJPExpMon").val('');
            $("#cboRJPProficiencyID").val('');
            $("#chkRJPCompetency").val('')
        }

        function BindSkillDropDown(EmployeeSkillID) {
            var EmployeeID = $("#HdnEmployeeID").val();
            var parameter = {
                EmployeeSkillID: EmployeeSkillID,
                EmployeeID: EmployeeID
            }
            var param = JSON.stringify(parameter);
            var Result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetAllSkillList", param, false);
            var s = '';
            for (var i = 0; i < Result.length; i++) {
                s += '<option value="' + Result[i].ToolID + '">' + Result[i].Description + '</option>';
            }
            $("#cboRJPSkillID").html(s);
            $("#cboRJPSkillID").prepend("<option value='' selected='selected'>Select Skill</option>");
        }

        function SaveOrUpdateSkill() {
            var EmployeeSkillID = $("#HdnEmployeeSkillID").val();
            if ($("#cboRJPSkillID").val() == "") {
                alertify.error("<%= MyBase.GetResourceString("A_SelSkill") %>");
                $("#cboRJPSkillID").focus();
                return false;
            } else {
                var SkillID = $("#cboRJPSkillID").val();
                var YearOfExp = $("#cboRJPExpYr").val();
                var MonthOfExp = $("#cboRJPExpMon").val();
                var ProficiancyID = $("#cboRJPProficiencyID").val();
                var CoreCompentency = $("#chkRJPCompetency").val();
                var Note = $("#txtNote").val();
                var EmployeeID = $("#HdnEmployeeID").val();
                var Parameter = {
                    SkillID: SkillID,
                    YearOfExp: YearOfExp,
                    MonthOfExp: MonthOfExp,
                    ProficiancyID: ProficiancyID,
                    CoreCompentency: CoreCompentency,
                    Note: Note,
                    EmployeeID: EmployeeID,
                    EmployeeSkillID: EmployeeSkillID,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/SaveOrUpdateSkill", param, false);
                if (Result == "Skill Updated Successfully.") {
                    alertify.success(Result);
                } else {
                    alertify.success("<%= MyBase.GetResourceString("A_SkillAdded") %>");
                    $("#HdnEmployeeSkillID").val(Result);
                }
                BindSkillDetails();
            }
        }

        function SaveAndAddUpdateDetails() {
            if ($("#cboRJPSkillID").val() == "") {
                alertify.error("<%= MyBase.GetResourceString("A_SelSkill") %>");
                $("#cboRJPSkillID").focus();
                return false;
            } else {
                SaveOrUpdateSkill();
                BindSkillDropDown("NULL");
                $("#RJPAddskillmodal").modal('show');
                $("#cboRJPSkillID").val('');
                $("#cboRJPExpYr").val('');
                $("#cboRJPExpMon").val('');
                $("#cboRJPProficiencyID").val('');
                $("#chkRJPCompetency").val('');
                $("#HdnEmployeeSkillID").val('');
            }
        }

        function DeleteSkillconfirmationmodal() {
            var RJPSkillIDs = "";
            var table = $('#RJPSkilltbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            RJPSkillIDs = $('input[name=checkSkillRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            if (RJPSkillIDs.length != 0) {
                $("#DeleteSkillconfirmationmodal").modal('show');
            } else {
                alertify.error("<%= MyBase.GetResourceString("A_SelectOneRecord") %>");
                return false;
            }
        }

        function DeleteSkillDetail() {
            var curResult = "";
            var table = $('#RJPSkilltbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var RJPSkillIDs = $('input[name=checkSkillRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrRJPSkillIDs = RJPSkillIDs.split(',');
            for (var i = 0; i < arrRJPSkillIDs.length; i++) {
                var EmployeeSkillID = arrRJPSkillIDs[i];
                var param = JSON.stringify(encodeURI(EmployeeSkillID));
                var result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/DeleteSkillDetail", param, false);
            }
            alertify.success("<%= MyBase.GetResourceString("A_SkillDeleted") %>");
            BindSkillDetails();
            $(".chckHeadSkill").prop("checked", false);
        }


        //this use for if uncheck one of the Checkbox then remove check of Select all
        $(document).on('change', '.chckSkilltbl', function () {

            var table = $("#RJPSkilltbl").DataTable();
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chckSkilltbl').length;
            var checked1 = table.rows().nodes().to$().find('input[type="checkbox"].chckSkilltbl:checked').length;
            if (checked == checked1) {
                $(".chckHeadSkill").prop("checked", true);
            }
            else {
                $(".chckHeadSkill").prop("checked", false);
            }
        });

        //Check Or Uncheck All checkBox
        $('.chckHeadSkill').click(function () {

            var table = $('#RJPSkilltbl').DataTable();
            if ($(this).prop("checked") == true) {

                var rows1 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows1).each(function () {
                    this.checked = true;
                });

            }
            else if ($(this).prop("checked") == false) {
                var rows2 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows2).each(function () {
                    this.checked = false;
                });
            }
        });

        //////////////////////////   Skill Part End  Here ///////////////////////////////////////




        //////////////////////////   Qualification Part Start From Here ///////////////////////////////////////

        function BindQualificationDetails() {

            $("#Qualtbl").dataTable().fnDestroy();
            // $("#RJPdetailtab3").show();
            var EmployeeID = $("#HdnEmployeeID").val();
            var parameter = {
                EmployeeQualificationID: EmployeeQualificationID,
                EmployeeID: EmployeeID,
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetQualificationDetailList", param, false);
            $("#Qualtblbody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var QualificationName = strResult[i]["QualificationName"];
                var University = strResult[i]["University"];
                var PassoutYear = strResult[i]["PassoutYear"];
                var Class = strResult[i]["Class"];
                var PercentageDetails = strResult[i]["PercentageDetails"];
                var EmployeeQualificationID = strResult[i]["EmployeeQualificationID"];


                strHTML += '<tr>'

                strHTML += '<td><a href="javascript:;" onclick="EditQualificationDetails(' + EmployeeQualificationID + ')">' + QualificationName + '</a></td>'

                strHTML += '<td>' + University + '</td>'
                strHTML += '<td>' + PassoutYear + '</td>'
                strHTML += '<td>' + Class + '</td>'
                strHTML += '<td>' + PercentageDetails + '</td>'
                strHTML += '<td>'
                strHTML += '<div class="custom_chckbox">'
                strHTML += '<input id="RJPQualCheck_' + EmployeeQualificationID + '" class="chckQualtbl" name="checkQualRJP" type="checkbox" value = ' + EmployeeQualificationID + '>'
                strHTML += '<label for="RJPQualCheck_' + EmployeeQualificationID + '"></label>'
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '</tr>'
            }
            $("#Qualtblbody").html("")
            $("#Qualtblbody").html(strHTML);
            $('#Qualtbl').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true

            });
        }

        function SaveOrUpdateQualification() {

            var EmployeeQualificationID = $("#HdnEmployeeQualID").val();
            if (ValidateQualification() == true) {
                var QualificationID = $("#cboRJPQualification").val();
                var University = $("#txtRJPUniversityName").val();
                var PassoutYear = $("#cboRJPYear").val();
                var Class = $("#txtRJPClass").val();
                var Percentage = $("#txtRJPPercentage").val();
                var EmployeeID = $("#HdnEmployeeID").val();
                if (Percentage == "") {
                    Percentage = "Null";
                }
                var Parameter = {
                    QualificationID: QualificationID,
                    University: University,
                    PassoutYear: PassoutYear,
                    Class: Class,
                    Percentage: Percentage,
                    EmployeeID: EmployeeID,
                    EmployeeQualificationID: EmployeeQualificationID,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/SaveOrUpdateQualification", param, false);
                if (Result == "Qualification Updated Successfully") {
                    alertify.success(Result);
                } else {
                    alertify.success("<%= MyBase.GetResourceString("A_QualAdded") %>");
                    // $("#HdnEmployeeQualID").val(Result);
                }
                $("#qualmodal").modal('hide');
                BindQualificationDetails();
            }
        }

        function SaveAndAddQualification() {
            if (ValidateQualification() == true) {
                SaveOrUpdateQualification();
                BindSkillDropDown("NULL");
                $("#qualmodal").modal('show');
                $("#cboRJPQualification").val('');
                $("#txtRJPUniversityName").val('');
                $("#cboRJPYear").val('');
                $("#txtRJPClass").val('');
                $("#txtRJPPercentage").val('');
                $("#HdnEmployeeQualID").val('');
            }
        }

        function ValidateQualification() {
            var QualificationID = $("#cboRJPQualification").val();
            var University = $("#txtRJPUniversityName").val();
            var PassoutYear = $("#cboRJPYear").val();
            var Class = $("#txtRJPClass").val();
            var Percentage = $("#txtRJPPercentage").val();
            if (isBlank(QualificationID)) {
                alertify.error("<%= MyBase.GetResourceString("A_SelQual") %>")
                $("#cboRJPQualification").focus();
                return false;
            }
            else if (isBlank(University)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankUniversity") %> ")
                $("#txtRJPUniversityName").focus();
                return false;
            }
            else if (isBlank(PassoutYear)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankPassOut") %> ")
                $("#cboRJPYear").focus();
                return false;
            }
            else if (University.indexOf("<") > -1 || University.indexOf(">") > -1) {
                alertify.error("<%= MyBase.GetResourceString("A_SplUniversity") %> ")
                $("#txtRJPUniversityName").focus();
                return false;
            }
            else if (disallowSpecialCharacters($("#txtRJPClass")) == true) {
                alertify.error("<%= MyBase.GetResourceString("A_SplClass") %>")
                $("#txtRJPClass").focus();
                return false;
            }
            else if (Percentage != "") {
                if (!jQuery.isNumeric(Percentage)) {
                    alertify.error("<%= MyBase.GetResourceString("A_onlynumber") %> ")
                    $("#txtRJPPercentage").focus();
                    return false;
                }
                else if (ValidateQualificationName() == false) {
                    return false;
                }
            }
            else if (ValidateQualificationName() == false) {
                return false;
            }
            else {
                return true;
            }
        }

        function ValidateQualificationName() {
            var EmployeeID = $("#HdnEmployeeID").val();
            var EmployeeQualificationID = $("#HdnEmployeeQualID").val();
            var QualificationID = $("#cboRJPQualification").val();

            var parameter = {
                EmployeeQualificationID: EmployeeQualificationID,
                EmployeeID: EmployeeID,
                QualificationID: QualificationID
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/ValidateQualificationName", param, false);
            if (strResult == "<%= MyBase.GetResourceString("A_QualExist") %>") {
                alertify.error(strResult);
                $("#cboRJPQualification").focus();
                return false;
            } else {
                return true;
            }
        }


        function disallowSpecialCharacters(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }
            var msg = (arguments.length > 1) ? arguments[1] : "";
            msg = replaceSubstring(msg, "&#39;", "'");
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            var spChars = (arguments.length > 3) ? arguments[3] : "[/*?+\"><|,\\\\]";
            if (hasSpecialCharacters(getInputValue(obj), spChars)) {
                if (!isBlank(msg)) {
                }
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }

        function EditQualificationDetails(EmployeeQualificationID) {
            $("#qualmodal").modal('show');
            var EmployeeID = $("#HdnEmployeeID").val();
            $("#HdnEmployeeQualID").val(EmployeeQualificationID);
            var parameter = {
                EmployeeQualificationID: EmployeeQualificationID,
                EmployeeID: EmployeeID,
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetQualificationDetailList", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var QualificationID = strResult[i]["QualificationID"];
                var University = strResult[i]["University"];
                var PassoutYear = strResult[i]["PassoutYear"];
                var Class = strResult[i]["Class"];
                var PercentageDetails = strResult[i]["PercentageDetails"];
                var EmployeeQualificationID = strResult[i]["EmployeeQualificationID"];
                $("#cboRJPQualification").val(QualificationID);
                $("#txtRJPUniversityName").val(University);
                $("#cboRJPYear").val(PassoutYear);
                $("#txtRJPClass").val(Class);
                $("#txtRJPPercentage").val(PercentageDetails);
            }

        }

        function DeleteQualificationconfirmationmodal() {
            var RJPSkillIDs = "";
            var table = $('#Qualtbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            RJPSkillIDs = $('input[name=checkQualRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            if (RJPSkillIDs.length != 0) {
                $("#DeleteQualiconfirmationmodal").modal('show');
            } else {
                alertify.error("<%= MyBase.GetResourceString("A_SelectOneRecord") %>");
                return false;
            }
        }

        function DeleteQualificationDetail() {
            var curResult = "";
            var table = $('#Qualtbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var RJPSQualIDs = $('input[name=checkQualRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrRJPQualIDs = RJPSQualIDs.split(',');
            for (var i = 0; i < arrRJPQualIDs.length; i++) {
                var EmployeeQualificationID = arrRJPQualIDs[i];
                var param = JSON.stringify(encodeURI(EmployeeQualificationID));
                var result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/DeleteQualiDetail", param, false);
            }
            alertify.success("<%= MyBase.GetResourceString("A_QualDeleted") %>");
            BindQualificationDetails();
            $(".chckQualHead").prop("checked", false);
        }
        function ShowQualModal() {
            $("#qualmodal").modal('show');
            $("#cboRJPQualification").val('');
            $("#txtRJPUniversityName").val('');
            $("#cboRJPYear").val('');
            $("#txtRJPClass").val('');
            $("#txtRJPPercentage").val('');
            $("#HdnEmployeeQualID").val('');
        }


        //this use for if uncheck one of the Checkbox then remove check of Select all
        $(document).on('change', '.chckQualtbl', function () {

            var table = $("#Qualtbl").DataTable();
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chckQualtbl').length;
            var checked1 = table.rows().nodes().to$().find('input[type="checkbox"].chckQualtbl:checked').length;
            if (checked == checked1) {
                $(".chckQualHead").prop("checked", true);
            }
            else {
                $(".chckQualHead").prop("checked", false);
            }
        });

        //Check Or Uncheck All checkBox
        $('.chckQualHead').click(function () {

            var table = $('#Qualtbl').DataTable();
            if ($(this).prop("checked") == true) {

                var rows1 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows1).each(function () {
                    this.checked = true;
                });

            }
            else if ($(this).prop("checked") == false) {
                var rows2 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows2).each(function () {
                    this.checked = false;
                });
            }
        });

        //////////////////////////   Qualification Part End Here ///////////////////////////////////////

        //////////////////////////   Exp Part End Here ///////////////////////////////////////
        function BindWorkExpDetails() {
            $("#RJPWrkExptbl").dataTable().fnDestroy();
            // $("#RJPdetailtab4").show();
            var EmployeeID = $("#HdnEmployeeID").val();
            var parameter = {
                EmployeeHistoryID: EmployeeHistoryID,
                EmployeeID: EmployeeID,
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetWorkExpDetailList", param, false);
            $("#RJPWrkExptblBody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var OrganizationName = strResult[i]["OrganizationName"];
                var WorkedFrom = strResult[i]["WorkedFrom"];
                var WorkedTill = strResult[i]["WorkedTill"];
                var PositionHeld = strResult[i]["PositionHeld"];
                var WorkProfileNatureText = strResult[i]["WorkProfileNatureText"];
                var EmployeeHistoryID = strResult[i]["EmployeeHistoryID"];


                strHTML += '<tr>'
                strHTML += '<td><a href="javascript:;" onclick="EditExperianceDetails(' + EmployeeHistoryID + ')">' + OrganizationName + '</a></td>'
                strHTML += '<td>' + WorkedFrom + '</td>'
                strHTML += '<td>' + WorkedTill + '</td>'
                strHTML += '<td>' + PositionHeld + '</td>'
                strHTML += '<td>' + WorkProfileNatureText + '</td>'
                strHTML += '<td>'
                strHTML += '<div class="custom_chckbox">'
                strHTML += '<input id="RJPWorkCheck_' + EmployeeHistoryID + '" class="chckWorktbl" name="checkWorkRJP" type="checkbox" value = ' + EmployeeHistoryID + '>'
                strHTML += '<label for="RJPWorkCheck_' + EmployeeHistoryID + '"></label>'
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '</tr>'
            }
            $("#RJPWrkExptblBody").html("")
            $("#RJPWrkExptblBody").html(strHTML);
            $('#RJPWrkExptbl').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true

            });
        }

        function SaveOrUpdateExpPrev() {
            var EmployeeHistoryID = $("#HdnWrkExpID").val();
            if (ValidateExp() == true) {
                var OrganizationName = $("#txtRJPOrganizationName").val();
                var WorkedFrom = $("#txtRJPFromDate").val();
                var WorkedTill = $("#txtRJPToDate").val();
                var PositionHeld = $("#txtRJPPositionHeld").val();
                var Summery = $("#txtRJPSummery").val();
                var WorkProfile = $("#cboRDJPWorkProfile").val();
                var EmployeeID = $("#HdnEmployeeID").val();

                var Parameter = {
                    OrganizationName: OrganizationName,
                    WorkedFrom: WorkedFrom,
                    WorkedTill: WorkedTill,
                    PositionHeld: PositionHeld,
                    Summery: Summery,
                    WorkProfile: WorkProfile,
                    EmployeeID: EmployeeID,
                    EmployeeHistoryID: EmployeeHistoryID,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/SaveOrUpdateExp", param, false);
                if (Result == "Work Experiance Updated Successfully") {
                    alertify.success(Result);
                } else {
                    alertify.success("<%= MyBase.GetResourceString("A_WorkAdded") %>");
                    $("#HdnWrkExpID").val(Result);
                }
                BindWorkExpDetails();
            }
        }

        function ValidateExp() {
            var CurrentDate = new Date();
            var ResourceName = $("#txtRJPOrganizationName").val();
            var FromDate = $("#txtRJPFromDate").val();
            var TillDate = $("#txtRJPToDate").val();
            var PositionHeld = $("#txtRJPPositionHeld").val();

            if (isBlank(ResourceName)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankResource") %>");
                $("#txtRJPOrganizationName").focus();
                return false;
            }
            else if (isBlank(FromDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankFromDate") %>");
                $("#txtRJPFromDate").focus();
                return false;
            }
            else if (isBlank(TillDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankTillDate") %>");
                $("#txtRJPToDate").focus();
                return false;
            }
            else if (isBlank(PositionHeld)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankPosition") %>");
                $("#txtRJPPositionHeld").focus();
                return false;
            }
            else if (Date.parse(FromDate) > Date.parse(CurrentDate)) {
                $("#txtRJPFromDate").focus();
                alertify.error("<%= MyBase.GetResourceString("A_FromnotGreterTodayDate") %>");
                return false;
            }
            else if (Date.parse(TillDate) < Date.parse(FromDate)) {
                $("#txtRJPToDate").focus();
                alertify.error("<%= MyBase.GetResourceString("A_TillNotLessFromDate") %>");
                return false;
            }
            else if (Date.parse(TillDate) > Date.parse(CurrentDate)) {
                $("#txtRJPToDate").focus();
                alertify.error("<%= MyBase.GetResourceString("A_TillNotGreTodayDate") %>");
                return false;
            }
            else {
                return true;
            }
        }

        function EditExperianceDetails(EmployeeHistoryID) {
            $("#wrkExpModal").modal('show');
            var EmployeeID = $("#HdnEmployeeID").val();
            $("#HdnWrkExpID").val(EmployeeHistoryID);
            var parameter = {
                EmployeeHistoryID: EmployeeHistoryID,
                EmployeeID: EmployeeID,
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetWorkExpDetailList", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var OrganizationName = strResult[i]["OrganizationName"];
                var WorkedFrom = strResult[i]["WorkedFrom"];
                var WorkedTill = strResult[i]["WorkedTill"];
                var PositionHeld = strResult[i]["PositionHeld"];
                var WorkProfileNatureText = strResult[i]["WorkProfileNature"];
                var EmployeeHistoryID = strResult[i]["EmployeeHistoryID"];
                var Summary = strResult[i]["Summary"];

                $("#txtRJPOrganizationName").val(OrganizationName);
                $("#txtRJPFromDate").val(WorkedFrom);
                $("#txtRJPToDate").val(WorkedTill);
                $("#txtRJPPositionHeld").val(PositionHeld);
                $("#txtRJPSummery").val(Summary);
                $("#cboRDJPWorkProfile").val(WorkProfileNatureText);
            }

        }

        function SaveAndAddExpPrev() {
            if (ValidateExp() == true) {
                SaveOrUpdateExpPrev();
                $("#wrkExpModal").modal('show');
                $("#txtRJPOrganizationName").val('');
                $("#txtRJPFromDate").val('');
                $("#txtRJPToDate").val('');
                $("#txtRJPPositionHeld").val('');
                $("#txtRJPSummery").val('');
                $("#cboRDJPWorkProfile").val('');
                $("#HdnWrkExpID").val('');
            }
        }

        function DeleteExperianceDetail() {
            var RJPexpIDs = "";
            var table = $('#RJPWrkExptbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            RJPexpIDs = $('input[name=checkWorkRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            if (RJPexpIDs.length != 0) {
                $("#DeleteExpfirmationmodal").modal('show');
            } else {
                alertify.error("<%= MyBase.GetResourceString("A_SelectOneRecord") %>");
                return false;
            }
        }

        function DeleteExperianceDetail() {
            var curResult = "";
            var table = $('#RJPWrkExptbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var RJPSExpIDs = $('input[name=checkWorkRJP]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrRJPExpIDs = RJPSExpIDs.split(',');
            for (var i = 0; i < arrRJPExpIDs.length; i++) {
                var EmployeeHistoryID = arrRJPExpIDs[i];
                var param = JSON.stringify(encodeURI(EmployeeHistoryID));
                var result = AJAXCallWithResult("/api/HR_ResourceJoiningPool/DeleteExpDetail", param, false);
            }
            alertify.success("<%= MyBase.GetResourceString("A_QualificationDeleted") %>");
            BindWorkExpDetails();
            $(".chckExpHead").prop("checked", false);
        }

        function ShowExpModal() {
            $("#wrkExpModal").modal('show');
            $("#txtRJPOrganizationName").val('');
            $("#txtRJPFromDate").val('');
            $("#txtRJPToDate").val('');
            $("#txtRJPPositionHeld").val('');
            $("#txtRJPSummery").val('');
            $("#cboRDJPWorkProfile").val('');
            $("#HdnWrkExpID").val('');
        }

        //this use for if uncheck one of the Checkbox then remove check of Select all
        $(document).on('change', '.chckQualtbl', function () {

            var table = $("#Qualtbl").DataTable();
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chckQualtbl').length;
            var checked1 = table.rows().nodes().to$().find('input[type="checkbox"].chckQualtbl:checked').length;
            if (checked == checked1) {
                $(".chckQualHead").prop("checked", true);
            }
            else {
                $(".chckQualHead").prop("checked", false);
            }
        });

        //Check Or Uncheck All checkBox
        $('.chckQualHead').click(function () {

            var table = $('#Qualtbl').DataTable();
            if ($(this).prop("checked") == true) {

                var rows1 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows1).each(function () {
                    this.checked = true;
                });

            }
            else if ($(this).prop("checked") == false) {
                var rows2 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows2).each(function () {
                    this.checked = false;
                });
            }
        });

        //////////////////////////   Exp Part End Here ///////////////////////////////////////

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
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token-I"));
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
            });
            return ajaxResult;
        }

        function BindPlaceholder() {
            $("#cboRJPExpYr").prepend("<option value='' selected='selected'>Select Experience (Years)</option>");
            $("#cboRJPExpMon").prepend("<option value='' selected='selected'>Select Experience (Months)</option>");
            $("#cboRJPProficiencyID").prepend("<option value='' selected='selected'>Select Proficiency</option>");
            $("#cboRDJPWorkProfile").prepend("<option value='' selected='selected'>Select Work Profile</option>");



            $("#cboRoleDescription").prepend("<option value='' selected='selected'>Select Role</option>");
            $("#cboDesignationID").prepend("<option value='' selected='selected'>Select Designation</option>");
            $("#cboRJPQualification").prepend("<option value='' selected='selected'>Select Qualification</option>");
            $("#cboRJPYear").prepend("<option value='' selected='selected'>Select Year</option>");
            $("#cboBloodGroup").prepend("<option value='' selected='selected'>Select Blood Group</option>");
            $("#cboRole").prepend("<option value='' selected='selected'>Select Role</option>");
            $("#cboDesignation").prepend("<option value='' selected='selected'>Select Designation</option>");
            $("#cboDepartment").prepend("<option value='' selected='selected'>Select Department</option>");
            $("#cboEmployeeType").prepend("<option value='' selected='selected'>Select Employee Type</option>");
            $("#cboReportingTo").prepend("<option value='' selected='selected'>Select Reporting To</option>");
            $("#cboCurrency").prepend("<option value='' selected='selected'>Select Currency</option>");
            $("#cboBG").prepend("<option value='' selected='selected'>Select Business Group</option>");
            $("#cboOU").prepend("<option value='' selected='selected'>Select Organization Unit</option>");
            $("#cboDU").prepend("<option value='' selected='selected'>Select Delivery Unit</option>");
            $("#cboDT").prepend("<option value='' selected='selected'>Select Delivery Team</option>");
            $("#cboFacility").prepend("<option value='' selected='selected'>Select Facility</option>");
            $("#cboDeployable").prepend("<option value='' selected='selected'>Select Deployable</option>");
            $("#cboGrade").prepend("<option value='' selected='selected'>Select Grade</option>");
        }

        function ValidateEmployee() {

            var today = new Date();
            var T = convert(today);
            var BD = convert($("#txtBirthDate").val());
            var JD = convert($("#txtMoveJoiningDate").val());
            var optimizedBirthday = BD.replace(/-/g, "/");
            var emailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            //set date based on birthday at 01:00:00 hours GMT+0100 (CET)
            var myBirthday = new Date(optimizedBirthday);
            // set current day on 01:00:00 hours GMT+0100 (CET)
            var currentDate = new Date().toJSON().slice(0, 10) + ' 01:00:00';
            // calculate age comparing current date and borthday
            var myAge = ~~((Date.now(currentDate) - myBirthday) / (31557600000));
            var RgxAlaphNumeric = /[/\:*?<>|,"+-]/
            var RgxAddress = /[\\*?<>|"+=#~!&;{}@%]/
            var rateperhr = $("#txtRatePerHr").val();
            var costperhr = $("#txtCostPerHr").val();
            var costToCmpny = $("#txtCostToCompany").val()

            if (isBlank($("#txtMoveEmployeeName").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankEmpName") %>");
                $("#txtMoveEmployeeName").focus();
                return false;
            }
            else if (isBlank($("#txtEmployeeCode").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankEmpCode") %>");
                $("#txtEmployeeCode").focus();
                return false;
            }
            else if (isBlank($("#txtUserName").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankUserName") %>");
                $("#txtUserName").focus();
                return false;
            }
            else if (isBlank($("#txtBirthDate").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankBirthDate") %>");
                $("#txtBirthDate").focus();
                return false;
            }
            else if ($("#cboGender").val() == 0) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankGender") %>");
                $("#cboGender").focus();
                return false;
            }
            else if (isBlank($("#txtEmailID").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankEmailID") %>");
                $("#txtEmailID").focus();
                return false;
            }
            else if (isBlank($("#cboRole").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankRole") %>");
                $("#cboRole").focus();
                return false;
            }
            else if (isBlank($("#cboDesignation").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankDesignation") %>");
                $("#cboDesignation").focus();
                return false;
            }
            else if (isBlank($("#cboDepartment").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankDept") %>");
                $("#cboDepartment").focus();
                return false;
            }
            else if (isBlank($("#cboEmployeeType").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankEmployeeType") %>");
                $("#cboEmployeeType").focus();
                return false;
            }
            else if (isBlank($("#cboReportingTo").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankReportingTo") %>");
                $("#cboReportingTo").focus();
                return false;
            }
            else if (isBlank($("#txtMoveJoiningDate").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankJoiningDate") %>");
                $("#txtMoveJoiningDate").focus();
                return false;
            }
            else if (isBlank(rateperhr)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankRateHour") %>");
                $("#txtRatePerHr").focus();
                return false;
            }
            else if (isBlank(costperhr)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankCostHour") %>");
                $("#txtCostPerHr").focus();
                return false;
            }
            else if (isBlank(costToCmpny)) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankCostToCompany") %>");
                $("#txtCostToCompany").focus();
                return false;
            }
            else if (isBlank($("#cboCurrency").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankCurrency") %>");
                $("#cboCurrency").focus();
                return false;
            }
            else if (isBlank($("#cboBG").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankBusinessGroup") %>");
                $("#cboBG").focus();
                return false;
            }
            else if (isBlank($("#cboOU").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankOU") %>");
                $("#cboOU").focus();
                return false;
            }
            else if (isBlank($("#cboDeployable").val())) {
                alertify.error("<%= MyBase.GetResourceString("A_BlankDeployable") %>");
                $("#cboDeployable").focus();
                return false;
            }
            else if (ValidateUserNameOrUserCode() == false) {
                return false;
            }
            else if (BD > T) {
                $("#txtBirthDate").focus();
                alertify.error("<%= MyBase.GetResourceString("A_BirthnotGreterTodayDate") %>");
                return false;
            }
            else if (myAge < 18) {
                $("#txtBirthDate").focus();
                alertify.error("<%= MyBase.GetResourceString("A_EmpAgegreater18") %>");
                return false;
            }
            else if (!($("#txtEmailID").val().match(emailformat))) {
                $("#txtEmailID").focus();
                alertify.error("<%= MyBase.GetResourceString("A_BlankEmail") %>");
                return false;
            }
            else if ($("#txtMoveEmployeeName").val().trim().match(RgxAlaphNumeric)) {
                $("#txtMoveEmployeeName").focus();
                alertify.error('<%= MyBase.GetResourceString("A_EmpNameSpl") %>');
                return false;
            }
            else if ($("#txtUserName").val().trim().match(RgxAlaphNumeric)) {
                $("#txtUserName").focus();
                alertify.error('<%= MyBase.GetResourceString("A_UserNameSpl") %>');
                return false;
            }
            else if ($("#txtMoveAddress").val().trim().match(RgxAddress)) {
                $("#txtMoveAddress").focus();
                alertify.error("<%= MyBase.GetResourceString("A_AddressSpl") %>");
                return false;
            }
            else if ($("#txtCurrAddress").val().trim().match(RgxAddress)) {
                $("#txtCurrAddress").focus();
                alertify.error("<%= MyBase.GetResourceString("A_CurAddressSpl") %>");
                return false;
            }
            else if ($("#txtCity").val().trim().match(RgxAlaphNumeric)) {
                $("#txtCity").focus();
                alertify.error('<%= MyBase.GetResourceString("A_CitySpl") %>');
                return false;
            }
            else if ($("#txtCurrCity").val().trim().match(RgxAlaphNumeric)) {
                $("#txtCurrCity").focus();
                alertify.error('<%= MyBase.GetResourceString("A_CurCitySpl") %>');
                return false;
            }
            else if ($("#txtState").val().trim().match(RgxAlaphNumeric)) {
                $("#txtState").focus();
                alertify.error('<%= MyBase.GetResourceString("A_StateSpl") %>');
                return false;
            }
            else if ($("#txtCurrState").val().trim().match(RgxAlaphNumeric)) {
                $("#txtCurrState").focus();
                alertify.error('<%= MyBase.GetResourceString("A_CurStateSpl") %>');
                return false;
            }
            else if ($("#txtPinCode").val().trim().match(RgxAlaphNumeric)) {
                $("#txtPinCode").focus();
                alertify.error('<%= MyBase.GetResourceString("A_PinCodeSpl") %>');
                return false;
            }
            else if ($("#txtCurrPinCode").val().trim().match(RgxAlaphNumeric)) {
                $("#txtCurrPinCode").focus();
                alertify.error('<%= MyBase.GetResourceString("A_CurPincodeSpl") %>');
                return false;
            }
            else if ($("#txtMovePhone").val().trim().match(RgxAlaphNumeric)) {
                $("#txtMovePhone").focus();
                alertify.error('<%= MyBase.GetResourceString("A_PhoneSpl") %>');
                return false;
            }
            else if ($("#txtCurrPhone").val().trim().match(RgxAlaphNumeric)) {
                $("#txtCurrPhone").focus();
                alertify.error('<%= MyBase.GetResourceString("A_CurPhoneSpl") %>');
                return false;
            }
            else if ($("#txtMobileNumber").val().trim().match(RgxAlaphNumeric)) {
                $("#txtMobileNumber").focus();
                alertify.error('<%= MyBase.GetResourceString("A_MbNoSpl") %>');
                return false;
            }
            else if (JD > T) {
                $("#txtMoveJoiningDate").focus();
                alertify.error("<%= MyBase.GetResourceString("A_JoiningnotGrTodaysDate") %>");
                return false;
            }
            else if (BD > JD) {
                $("#txtJoiningDate").focus();
                alertify.error("<%= MyBase.GetResourceString("A_BirthnotGreJoiningDate") %>");
                return false;
            }
            else if (rateperhr != null && rateperhr > 99999.99) {
                $("#txtRatePerHr").focus();
                alertify.error("<%= MyBase.GetResourceString("A_Rate99") %>");
                return false;
            }
            else if (costperhr != null && costperhr > 99999.99) {
                $("#txtCostPerHr").focus();
                validateflag = false;
                alertify.error("<%= MyBase.GetResourceString("A_Cost99") %>");
                return false;
            }
            else if (costToCmpny != null && costToCmpny > 999999999.99) {
                $("#txtCostToCompany").focus();
                alertify.error("<%= MyBase.GetResourceString("A_CostToCompany99") %>");
                return false;
            }
            else if ($("#txtInstantMsgID").val().trim().match(RgxAlaphNumeric)) {
                $("#txtInstantMsgID").focus();
                alertify.error('<%= MyBase.GetResourceString("A_MsgSpl") %>');
                return false;
            }
            else if (Date.parse($('#txtDateOfIssue').val()) > Date.parse($('#txtExpirydate').val())) {
                alertify.error("<%= MyBase.GetResourceString("A_ExpnotLessIssueDate") %>");
                $("#txtExpirydate").focus();
                return false;
            }
            else if ($("#txtPassportNumber").val().trim().match(RgxAlaphNumeric)) {
                $("#txtPassportNumber").focus();
                alertify.error('<%= MyBase.GetResourceString("A_PassportSpl") %>');
                return false;
            }
            else if ($("#txtPlaceOfIssue").val().trim().match(RgxAlaphNumeric)) {
                $("#txtPlaceOfIssue").focus();
                alertify.error('<%= MyBase.GetResourceString("A_PlaceOfIssueSpl") %>');
                return false;
            }
            else if ($("#txtPPRelativeName").val().trim().match(RgxAlaphNumeric)) {
                $("#txtPPRelativeName").focus();
                alertify.error('<%= MyBase.GetResourceString("A_RelativeSpl") %>');
                return false;
            }
            else if ($("#txtNoofPagesLeft").val().trim().match(RgxAlaphNumeric)) {
                $("#txtNoofPagesLeft").focus();
                alertify.error('<%= MyBase.GetResourceString("A_NoOfPagesSpl") %>');
                return false;
            }

            else {
                return true;
            }
        }

        function ValidateUserNameOrUserCode() {
            var UserName = $("#txtUserName").val();
            var EmployeeCode = $("#txtEmployeeCode").val();
            var Parameter = {
                UserName: UserName,
                EmployeeCode:EmployeeCode
            }
            var param = JSON.stringify(Parameter);
            var data = AJAXCallWithResult("/api/HR_ResourceJoiningPool/ValidateUserNameOrUserCode", param, false);
            if (data == 'Employee Code already exist') {
                alertify.error(data);
                $("#txtEmployeeCode").focus();
                return false;
            } else if (data == 'UserName already exist') {
                alertify.error(data);
                $("#txtUserName").focus();
                return false;
            } else {
                return true;
            }
        }


        function FillOU(OUID, isChange) {
            if (isChange == 2) {
                var Parameter = { BusinessGroupID: OUID }
            }
            else {
                var Parameter = { BusinessGroupID: OUID, EmployeeID: $("#hdnEmployee_UniqueIDTab").val() }
            }

            var param = JSON.stringify(Parameter);
            var data = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetBusinessGroupsLocation", param, false);
            $("#cboOU").html("");
            var strHTML = "";
            for (var i = 0; i < data.length; i++) {
                var listComponent = data[i];
                strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');
            }
            $("#cboOU").html(strHTML);
            $("#cboOU").prepend("<option value='' selected='selected'>Select Organization Unit</option>");
        }

        function FillDU(LocationID, isChange) {
            if (isChange == 2) {
                var Parameter = { LocationID: LocationID }
            }
            else {
                var Parameter = { LocationID: LocationID, EmployeeID: $("#hdnEmployee_UniqueIDTab").val() }
            }
            var param = JSON.stringify(Parameter);
            var data = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetResourcePoolForLocation", param, false);
            $("#cboDU").html("");
            var strHTML = "";
            for (var i = 0; i < data.length; i++) {
                var listComponent = data[i];
                strHTML += ('<option value=' + listComponent.ResourcePoolID + ' >' + listComponent.ResourcePoolName + '</option>');
            }
            $("#cboDU").html(strHTML);
            $("#cboDU").prepend("<option value='' selected='selected'>Select Delivery Unit</option>");
        }

        function FillDT(LocationID, isChange) {
            var strHTML = "";

            if (isChange == 2) {
                var Parameter = { LocationID: LocationID }
            }
            else {
                var Parameter = { LocationID: LocationID, EmployeeID: $("#hdnEmployee_UniqueIDTab").val() }
            }
            var param = JSON.stringify(Parameter);
            var data = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetDeliveryTeam", param, false);
            $("#cboDT").html("");
            for (var i = 0; i < data.length; i++) {
                var listComponent = data[i];
                strHTML += ('<option value=' + listComponent.GroupID + ' >' + listComponent.GroupName + '</option>');
            }
            $("#cboDT").html(strHTML);
            $("#cboDT").prepend("<option value='' selected='selected'>Select Delivery Team</option>");
        }


        ///////////////////////////////////// Excel Upload Start From Here   /////////////////////////////////

        function Download_Template() {
            window.open("../../General/ViewAttachment.aspx?FromWhere=DXU&FileName=cca96b2b.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=850,height=500");
        }



        function EmpOpenExceluploadsteps() {

            $("#btnaStep1").click();
            ReloadEmpXslxData("");
            var $el = $('#frmFileUpload');
            $el.wrap('<form>').closest('form').get(0).reset();
            $el.unwrap();
            document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
            document.getElementById('dvShowFileName').innerHTML = "";
            $('#exceluploadsteps').modal('show');
        }

        function showName() {
            var name = document.getElementById('txtFileUpload');
            if (name.value.length == 0) {
                document.getElementById('dvShowFileName').innerHTML = "";
                document.getElementById('plabelName').innerHTML = "";
                document.getElementById('dvShowFileNameStep3').innerHTML = "";
                document.getElementById('plabelName').innerHTML = "Attach file or drop here :-";
            } else {
                var fileName = name.files.item(0).name;
                document.getElementById('dvShowFileName').innerHTML = fileName;
                document.getElementById('plabelName').innerHTML = "";
                var currentDate = new Date();
                document.getElementById('dvShowFileNameStep3').innerHTML = fileName + "( " + formatDateWithTime(currentDate) + " )";
            }
        };

        function formatDateWithTime(date) {
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var ampm = hours >= 12 ? 'pm' : 'am';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return (date.getMonth() + 1) + "-" + date.getDate() + "-" + date.getFullYear() + "  " + strTime;
        }

        //upload xslx
        var EmpXslxList = ''
        function EmpUploadxlsfile() {
            //StartLoader("#body-tblEmplyee");
            Fillstep_2DropDowUsingColumnName();
            var SelectedFile = txtFileUpload.files;
            var SelectedFileName = document.getElementById('dvShowFileName').innerHTML;
            if (SelectedFile != 'undefined' && SelectedFile.length > 0 && SelectedFileName != "") {
                var isFileValid = fileValidation()
                if (isFileValid === true) {
                    var data = new FormData();
                    data.append("file", SelectedFile[0]);
                    $.ajax({
                        url: strUrl + '/api/HR_ResourceJoiningPool/UploadEmpXlsxFile',
                        type: "POST",
                        data: data,
                        contentType: false,
                        processData: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token-I"));
                        },
                        success: function (data) {

                            EmpXslxList = data;

                            if (EmpXslxList.length > 0) {
                                var ChkValidationBlank = BlankExcelColumnCheck(EmpXslxList);
                                ChkValidationBlank = ChkValidationBlank.split('~');
                            }

                            if (ChkValidationBlank[0] == 0) {
                                ReloadEmpXslxData(EmpXslxList);
                                $("#btnaStep2").click();
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ChkValidationBlank[1])

                            }

                        },

                        error: function (xhr, ajaxOptions, thrownError) {
                            if (ajaxOptions == "error") {
                                if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                    window.open("../../../Default.aspx", "_top");
                                } else {
                                    window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                                }
                            }
                        }
                        //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                    });

                }
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SelOrDrop") %>");
            }
            // StopAjaxLoader("#body-tblEmplyee");
        }

        function Fillstep_2DropDowUsingColumnName() {
            var Step2DrpList = [
                { Name: 'Employee Name', Value: 1 },
                { Name: 'Role', Value: 2 },
                { Name: 'Designation', Value: 3 },
                { Name: 'Tentative Joining Date', Value: 4 },
                { Name: 'Primary Skills', Value: 5 },
                { Name: 'Other Skills', Value: 6 },

            ];
            var arrExcelFields = ["A", "B", "C", "D", "E", "F"];
            var CboIrmExcelColumnHTML = ''
            CboIrmExcelColumnHTML += "<option value='0'>Select Column </option>";
            for (var i = 0; i < Step2DrpList.length; i++) {
                var listComponent = Step2DrpList[i];
                CboIrmExcelColumnHTML += ('<option value=' + listComponent.Value + ' >' + listComponent.Name + '</option>');

            }
            var LengthOfExcelField = arrExcelFields.length;

            for (var i = 0; i < LengthOfExcelField; i++) {
                var CboID = "#CboIrmExcelColumn_" + arrExcelFields[i];
                $(CboID).html(CboIrmExcelColumnHTML)
                $(CboID).prop("disabled", true);
                $(CboID).val(i + 1);
            }
        }

        function fileValidation() {
            var fileInput = document.getElementById('txtFileUpload');
            var filePath = fileInput.value;
            var allowedExtensions = /(\.(xlsx|xls))$/i;
            if (!allowedExtensions.exec(filePath)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_OnlyXLSX") %>");
                return false;
            }
            else { return true; }
        }

        function BlankExcelColumnCheck(objXlsx) {
            var XlsxObj = objXlsx;
            var TBlankCheck = 0;
            var tColumnvalue = '';

            $.each(XlsxObj, function (index, objXlsx) {
                console.log(objXlsx.ColumnError);
                if (objXlsx.ColumnError != null) {
                    TBlankCheck += 1;
                    if (objXlsx.ColumnError.indexOf(':{0}') > -1) {
                        tColumnvalue = objXlsx.ColumnError.replaceAll(':{0}', '<br>');
                        tColumnvalue = tColumnvalue.replaceAll(':{1}', '<br>');
                        tColumnvalue = tColumnvalue.replaceAll(':', '<BR>');
                    } else if (objXlsx.ColumnError.indexOf(':{1}') > -1) {
                        tColumnvalue += objXlsx.ColumnError.replaceAll(':{1}', '<BR>');
                    }
                    else if (objXlsx.ColumnError.indexOf(':') > -1) {
                        tColumnvalue += objXlsx.ColumnError.replaceAll(':', '<BR>');
                    }
                    else { }
                }
            });
            tColumnvalue = tColumnvalue.replace('<br>', '');
            return TBlankCheck + '~' + tColumnvalue.replaceAll(':', '<br>');
        }

        function ReloadEmpXslxData(XlsxList) {
            var strHTML = "";
            if (XlsxList.length > 0) {
                $.each(XlsxList, function (index, objXlsx) {
                    if (objXlsx.ColumnError == null || objXlsx.ColumnError == "" || objXlsx.ColumnError == 'undefined') {
                        strHTML += '<tr><td><div class="custom_chckbox" '
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId2"  id ="hdn_EmpRoleId2" value =' + objXlsx.Role + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId"  id ="hdn_EmpRoleId" value =' + objXlsx.Role + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpDesignationID" id = "hdn_EmpDesignationID" value = ' + objXlsx.Designation + ' >';
                        strHTML += ' <input id="' + index + '"   class="chcktblXlsx" type="checkbox" checked="true"><label for="' + index + '"></label></div> </td>';
                        strHTML += ' <td> ' + objXlsx.EmployeeName + ' </td> <td> ' + objXlsx.Role + '</td> <td> ' + objXlsx.Designation + '</td> <td>' + objXlsx.JoiningDate + '</td><td>' + objXlsx.PrimarySkill + '</td>  <td>' + objXlsx.OtherSkill + '</td> ';
                        strHTML += '<td> </td>';
                        strHTML += ' </tr > ';

                    }
                    else {
                        strHTML += '<tr style="color:red;"><td><div class="custom_chckbox" '
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId2"  id ="hdn_EmpRoleId2" value =' + objXlsx.Role + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpRoleId"  id ="hdn_EmpRoleId" value =' + objXlsx.Role + ' >';
                        strHTML += ' <input type = "hidden" name = "hdn_EmpDesignationID" id = "hdn_EmpDesignationID" value = ' + objXlsx.Designation + ' >';
                        strHTML += ' <input id="' + index + '"   class="chcktblXlsx" type="checkbox" disabled="disabled"><label for="' + index + '"></label></div> </td>';
                        strHTML += ' <td> ' + objXlsx.EmployeeName + ' </td> <td> ' + objXlsx.Role + '</td> <td> ' + objXlsx.Designation + '</td> <td>' + objXlsx.JoiningDate + '</td><td>' + objXlsx.PrimarySkill + '</td>  <td>' + objXlsx.OtherSkill + '</td> ';
                        strHTML += '<td> ' + objXlsx.ColumnError + '</td>';
                        strHTML += ' </tr > ';

                    }


                });
            } else {
                strHTML = '<tr><td colspan="7">No data found. <td></tr>'
            }
            $("#exluploadTblTbody").html(strHTML);
        }

        function SearchEmplistByName() {
            var SearchedXslxEmpNameText = $("#txtSearchXlsxEmpName").val();
            var FilterxslxList = EmpXslxList.filter(function (x) { return x.EmployeeName.toLowerCase().indexOf(SearchedXslxEmpNameText.toLowerCase()) !== -1 });
            ReloadEmpXslxData(FilterxslxList);
        }

        function IrmNextStep_2() {
            if ($("#CboIrmExcelColumn_A").val() == "" || $("#CboIrmExcelColumn_A").val() == 0 || $("#CboIrmExcelColumn_A").val() != "1") {
                alertify.error("<%= MyBase.GetResourceString("A_SelEMpName") %>");
                $("#CboIrmExcelColumn_A").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_B").val() == "" || $("#CboIrmExcelColumn_B").val() == 0 || $("#CboIrmExcelColumn_B").val() != "2") {
                alertify.error("<%= MyBase.GetResourceString("A_SelRole") %>");
                $("#CboIrmExcelColumn_B").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_C").val() == "" || $("#CboIrmExcelColumn_C").val() == 0 || $("#CboIrmExcelColumn_C").val() != "3") {
                alertify.error("<%= MyBase.GetResourceString("A_SelDesignation") %>");
                $("#CboIrmExcelColumn_C").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_D").val() == "" || $("#CboIrmExcelColumn_D").val() == 0 || $("#CboIrmExcelColumn_D").val() != "4") {
                alertify.error("<%= MyBase.GetResourceString("A_SelTentitiveDate") %>");
                $("#CboIrmExcelColumn_D").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_E").val() == "" || $("#CboIrmExcelColumn_E").val() == 0 || $("#CboIrmExcelColumn_E").val() != "5") {
                alertify.error("<%= MyBase.GetResourceString("A_SelPrimarySkill") %>");
                $("#CboIrmExcelColumn_E").focus();
                return false;
            }
            if ($("#CboIrmExcelColumn_F").val() == "" || $("#CboIrmExcelColumn_F").val() == 0 || $("#CboIrmExcelColumn_F").val() != "6") {
                alertify.error("<%= MyBase.GetResourceString("A_SelOtherSkill") %>");
                $("#CboIrmExcelColumn_F").focus();
                return false;
            }
            else {
                $("#btnaStep3").click();
            }
        }

        function IrmSaveXlsxData() {
            var xlsxSelectedList = []
            var message = '';

            $("#exluploadTbl input[type=checkbox]:checked").each(function () {

                var objxlsxSelectedList = {}
                var row = $(this).closest("tr")[0];
                var FirstTd = $(this).parent().parent("td");
                var hdn_EmpDesignationID = FirstTd.find('#hdn_EmpDesignationID').val();
                var hdn_EmpRoleID = FirstTd.find('#hdn_EmpRoleId').val();
                // objxlsxSelectedList.EmployeeId = 0

                var InfraNameRowValue = row.cells[1].innerHTML.toString();
                objxlsxSelectedList.EmployeeName = InfraNameRowValue.toString();
                objxlsxSelectedList.RoleName = row.cells[2].innerHTML;
                objxlsxSelectedList.DesignationName = row.cells[3].innerHTML;
                objxlsxSelectedList.JoiningDate = row.cells[4].innerHTML;
                objxlsxSelectedList.PrimarySkill = row.cells[5].innerHTML;
                objxlsxSelectedList.OtherSkill = row.cells[6].innerHTML;

                ///value field

                objxlsxSelectedList.Designation = hdn_EmpDesignationID;
                objxlsxSelectedList.Role = hdn_EmpRoleID;
                objxlsxSelectedList.UploadedBy = UserName;

                xlsxSelectedList.push(objxlsxSelectedList);

            });

            EmpSaveXlsxDataSelectedData(xlsxSelectedList)

        }

        function EmpSaveXlsxDataSelectedData(xlsxSelectedList) {

            if (xlsxSelectedList != null && xlsxSelectedList.length > 0) {
                var strHTML = "";
                $.ajax({
                    url: strUrl + '/api/HR_ResourceJoiningPool/UploadXlsxRecord',
                    type: "POST",
                    data: JSON.stringify(xlsxSelectedList),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token-I"));
                    },
                    success: function (data) {
                        alertify.success("<%= MyBase.GetResourceString("A_FileUploaded") %>");
                        $('#exceluploadsteps').modal('hide');
                        GetResourceDetailList();
                    },

                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    //End of Commented and Integrated by Chetan M on 8 Jul 2021 for Session Expire
                })

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_NoValidRecord") %>");
            }

        }

        function IrmBackStep_2() {
            $("#btnaStep1").click();
        }
        function IrmBackStep_3() {
            $("#btnaStep2").click();
        }
        ///////////////////////////////////// Excel Upload End Here   /////////////////////////////////

        ///////////////////////////////////      Employee Move Functionality Start from Here        ////////////////////////////
        function BindResourceMoveData(EmployeeID) {
            ClearEmpMoveModal();
            $("#HdnMoveEmployeeID").val(EmployeeID);
            var param = JSON.stringify(EmployeeID);
            var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/GetResourceDetailList", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var EmployeeID = strResult[i]["EmployeeID"];
                var EmployeeName = strResult[i]["EmployeeName"];
                var PostID = strResult[i]["PostID"];
                var DesignationID = strResult[i]["DesignationID"];
                var JoiningDate = strResult[i]["JoiningDate"];
                var Address = strResult[i]["Address"];
                var Phone = strResult[i]["Phone"];

                $("#txtMoveEmployeeName").val(EmployeeName);
                $("#txtMoveAddress").val(Address);
                $("#txtMovePhone").val(Phone);
                $("#cboRole").val(PostID);
                $("#cboDesignation").val(DesignationID);
                $("#txtMoveJoiningDate").val(JoiningDate);

            }
        }

        $("#MECurrentAddressCheck").on("click", function () {
            if (this.checked) {
                $("#txtCurrAddress").val($("#txtMoveAddress").val());
                $("#txtCurrCity").val($("#txtCity").val());
                $("#txtCurrState").val($("#txtState").val());
                $("#txtCurrPinCode").val($("#txtPinCode").val());
                $("#txtCurrPhone").val($("#txtMovePhone").val());
            } else {
                $("#txtCurrAddress").val("");
                $("#txtCurrCity").val("");
                $("#txtCurrState").val("");
                $("#txtCurrPinCode").val("");
                $("#txtCurrPhone").val("");
            }

        });

        function MoveEmployeeFromJoinPool() {
            if (ValidateEmployee() == true) {
                var EmployeeName = $("#txtMoveEmployeeName").val();
                var EmployeeCode = $("#txtEmployeeCode").val();
                var UserName = $("#txtUserName").val();
                var IsLDAP = $("#ChkIsLDAPAuthentication").val();
                var BirthDate = $("#txtBirthDate").val();
                var Gender = $("#cboGender").val();
                var EmailID = $("#txtEmailID").val();
                var BloodGroup = $("#cboBloodGroup").val();
                var PerAddress = $("#txtMoveAddress").val();
                var CurAddress = $("#txtCurrAddress").val();
                var PerCity = $("#txtCity").val();
                var CurCity = $("#txtCurrCity").val();
                var PerState = $("#txtState").val();
                var CurrState = $("#txtCurrState").val();
                var PerPinCode = $("#txtPinCode").val();
                var CurrPinCode = $("#txtCurrPinCode").val();
                var PerPhone = $("#txtMovePhone").val();
                var CurrPhone = $("#txtCurrPhone").val();
                var Role = $("#cboRole").val();
                var Designation = $("#cboDesignation").val();
                var Department = $("#cboDepartment").val();
                var EmployeeType = $("#cboEmployeeType").val();
                var ReportingTo = $("#cboReportingTo").val();
                var JoiningDate = $("#txtMoveJoiningDate").val();
                var RatePerHR = $("#txtRatePerHr").val();
                var CostPerHR = $("#txtCostPerHr").val();
                var CostToCompany = $("#txtCostToCompany").val();
                var Currency = $("#cboCurrency").val();
                var BusinessGroup = $("#cboBG").val();
                var OrganizationUnit = $("#cboOU").val();
                var DeliveryUnit = $("#cboDU").val();
                var DeliveryTeam = $("#cboDT").val();
                var Facility = $("#cboFacility").val();
                var ExtNo = $("#txtExtensionNo").val();
                var Deployable = $("#cboDeployable").val();
                var Grade = $("#cboGrade").val();
                var MobileNo = $("#txtMobileNumber").val();
                var InstantMsgID = $("#txtInstantMsgID").val();
                var PassportNumber = $("#txtPassportNumber").val();
                var PlaceOfIssue = $("#txtPlaceOfIssue").val();
                var DateOfIssue = $("#txtDateOfIssue").val();
                var Expirydate = $("#txtExpirydate").val();
                var FullName = $("#txtPPFullName").val();
                var RelativeName = $("#txtPPRelativeName").val();
                var NoofPagesLeft = $("#txtNoofPagesLeft").val();
                var MgrID = $("#txtInstantMsgID").val();
                var ResourcePoolEmployeeID = $("#HdnMoveEmployeeID").val();

                if (isBlank(BloodGroup)) {
                    BloodGroup = "Null";
                }
                if (isBlank(PerAddress)) {
                    PerAddress = "Null";
                }
                if (isBlank(CurAddress)) {
                    CurAddress = "Null";
                }
                if (isBlank(PerCity)) {
                    PerCity = "Null";
                }
                if (isBlank(CurCity)) {
                    CurCity = "Null";
                }
                if (isBlank(PerState)) {
                    PerState = "Null";
                }
                if (isBlank(CurrState)) {
                    CurrState = "Null";
                }
                if (isBlank(PerPinCode)) {
                    PerPinCode = "Null";
                }
                if (isBlank(CurrPinCode)) {
                    CurrPinCode = "Null";
                }
                if (isBlank(PerPhone)) {
                    PerPhone = "Null";
                }
                if (isBlank(CurrPhone)) {
                    CurrPhone = "Null";
                }
                if (isBlank(ExtNo)) {
                    ExtNo = "Null";
                }
                if (isBlank(MobileNo)) {
                    MobileNo = "Null";
                }
                if (isBlank(InstantMsgID)) {
                    InstantMsgID = "Null";
                }
                if (isBlank(PassportNumber)) {
                    PassportNumber = "Null";
                }
                if (isBlank(PlaceOfIssue)) {
                    PlaceOfIssue = "Null";
                }
                if (isBlank(DateOfIssue)) {
                    DateOfIssue = "Null";
                }
                if (isBlank(Expirydate)) {
                    Expirydate = "Null";
                }
                if (isBlank(FullName)) {
                    FullName = "Null";
                }
                if (isBlank(RelativeName)) {
                    RelativeName = "Null";
                }
                if (isBlank(NoofPagesLeft)) {
                    NoofPagesLeft = "Null";
                }
                if (isBlank(MgrID)) {
                    MgrID = "Null";
                }
                if (isBlank(ResourcePoolEmployeeID)) {
                    ResourcePoolEmployeeID = "Null";
                }


                var parameter = {
                    EmployeeName: EmployeeName, EmployeeCode: EmployeeCode, UserName: UserName, IsLDAP: IsLDAP,
                    BirthDate: BirthDate, Gender: Gender, EmailID: EmailID, BloodGroup: BloodGroup, PerAddress: PerAddress,
                    CurAddress: CurAddress, PerCity: PerCity, CurCity: CurCity, PerState: PerState, CurrState: CurrState,
                    PerPinCode: PerPinCode, CurrPinCode: CurrPinCode, PerPhone: PerPhone, CurrPhone: CurrPhone, Role: Role,
                    Designation: Designation, Department: Department, EmployeeType: EmployeeType, ReportingTo: ReportingTo, JoiningDate: JoiningDate,
                    RatePerHR: RatePerHR, CostPerHR: CostPerHR, CostToCompany: CostToCompany, Currency: Currency, BusinessGroup: BusinessGroup,
                    OrganizationUnit: OrganizationUnit, DeliveryUnit: DeliveryUnit, DeliveryTeam: DeliveryTeam, Facility: Facility,
                    ExtNo: ExtNo, Deployable: Deployable, Grade: Grade, MobileNo: MobileNo, MgrID: MgrID, PassportNumber: PassportNumber,
                    InstantMsgID: InstantMsgID, PlaceOfIssue: PlaceOfIssue, DateOfIssue: DateOfIssue, Expirydate: Expirydate, FullName: FullName, RelativeName: RelativeName,
                    NoofPagesLeft: NoofPagesLeft, LoginUserName: '<%= Session("strUserName") %>', ResourcePoolEmployeeID: ResourcePoolEmployeeID,
                }

                var param = JSON.stringify(parameter);
                var strResult = AJAXCallWithResult("/api/HR_ResourceJoiningPool/MoveEmployeesFromJoinPool", param, false);
                if (strResult == 'Employee Moved Successfully') {
                    alertify.success(strResult);
                    $("#RJPEmpDetailModal").modal('hide');
                    $("#HdnMoveEmployeeID").val('');
                }
                //ClearEmpMoveModal();
                GetResourceDetailList();

            }
        }

        function ClearEmpMoveModal() {
            $("#txtMoveJoiningDate").val('');
            $("#txtEmployeeCode").val('');
            $("#txtUserName").val('');
            $("#ChkIsLDAPAuthentication").val('');
            $("#txtBirthDate").val('');
            $("#cboGender").val(0);
            $("#txtEmailID").val('');
            $("#cboBloodGroup").val('');
            $("#txtMoveAddress").val('');
            $("#txtCurrAddress").val('');
            $("#txtCity").val('');
            $("#txtCurrCity").val('');
            $("#txtState").val('');
            $("#txtCurrState").val('');
            $("#txtPinCode").val('');
            $("#txtCurrPinCode").val('');
            $("#txtMovePhone").val('');
            $("#txtCurrPhone").val('');
            $("#cboRole").val('');
            $("#cboDesignation").val('');
            $("#cboDepartment").val('');
            $("#cboEmployeeType").val('');
            $("#cboReportingTo").val('');
            $("#txtMoveJoiningDate").val('');
            $("#txtRatePerHr").val('');
            $("#txtCostPerHr").val('');
            $("#txtCostToCompany").val('');
            $("#cboCurrency").val('');
            $("#cboBG").val('');
            $("#cboOU").val('');
            $("#cboDU").val('');
            $("#cboDT").val('');
            $("#cboFacility").val('');
            $("#txtExtensionNo").val('');
            $("#cboDeployable").val('');
            $("#cboGrade").val('');
            $("#txtMobileNumber").val('');
            $("#txtInstantMsgID").val('');
            $("#txtPassportNumber").val('');
            $("#txtPlaceOfIssue").val('');
            $("#txtDateOfIssue").val('');
            $("#txtExpirydate").val('');
            $("#txtPPFullName").val('');
            $("#txtPPRelativeName").val('');
            $("#txtNoofPagesLeft").val('');
        }


        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-"); txt
        }
        ///////////////////////////////////      Employee Move Functionality End Here         ////////////////////////////


    </script>
</body>

</html>
