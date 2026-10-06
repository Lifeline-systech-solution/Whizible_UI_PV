<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IB_BulkUpdate.aspx.vb" Inherits="PbNIT.BulkUpdate" %>


<!DOCTYPE html>
<html>
<%--<link href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.css" rel="stylesheet" />--%>
<%CommonFunctions.General.PlotPageHeadTag("Issues")%>
<head>
    
    <!-- Commented by Gauri on 09/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Issues</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_issues.css?v=3.3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
</head>

    <style type="text/css">
        /*need to remove below css property after implementing code in frame*/
      .content-wrapper, .right-side, .main-footer {margin-left: 0;}
     

        :focus {
            outline: none !important;
        }

        #bulkupdatetbl_length {
            display: none;
        }

        #bulkupdatetbl tr td {
            white-space: nowrap !important;
        }
         #bulkupdatetbl_wrapper table tr th:not(:last-child) {min-width: 90px;}
       
        #bulkupdatetbl_wrapper .row:nth-last-child(n) {
            margin-top: 10px !important;
        }

        #bulkupdatetbl_wrapper .row:last-child {
            margin-top: 10px !important;
        }

        #bulkupdatetbl_filter, #copywizardtbl_length {
            display: none;
        }

        #copywizardtbl_paginate, #copywizardtbl_info {
            margin-top: 18px;
        }

        #CustomFiledsControl .col-md-6 {
            margin-bottom: 10px !important;
        }

        .input-group-addon, .input-group-btn {
            width: auto !important;
        }

        #ExtendedCustomFiledsControl .col-md-6 {
            margin-bottom: 10px !important;
            /*margin-left:10%;*/
        }

        input#dtReportedDate, #dtReportedTime {
            width: 130px !important;
        }

        .dataTables_scroll {
            position: relative;
        }

        #UpdatingIssues {
            text-decoration: underline;
        }

        .BUselctfiltrlist {
            width: 300px;
            display: inline-block;
        }

        #bulkupdatetbl tr td {
            min-width: 105px;
            white-space: normal !important;
            /*word-break: break-all;*/
            word-wrap: break-word;
        }

       /* #bulkupdatetbl_wrapper table tr th{ width:auto!important;}*/
        #bulkupdatetbl_wrapper table tr th:nth-child(2), #bulkupdatetbl tr th:nth-child(3){
            width: auto!important; min-width:155px!important;
        }
            #bulkupdatetbl_wrapper table tr td:nth-child(2), #bulkupdatetbl tr td:nth-child(3) {
               /*width: 30%;*/
                text-align: left;
            }
            /*Added By Usha Pandit To highlight current page number*/
        .dataTables_paginate a.paginate_button.current {
            background: #1359a6;
            transition: 0.4s ease-in-out 0s;
            color: #fff;
            cursor: pointer;
        }
         /*End Of Added By Usha Pandit To highlight current page number*/   
/*New style added by pradip on 11-12-2019*/

#bulkupdatetbl tr td:not(:last-child) {text-align: left;}
.table tr th:not(:last-child) {text-align: left!important;}
.wizard {min-height:none;}

/*Added By Dipali V On 13th Feb 2021 For Aligment Issue*/
        .form-control {
            width:160px!important
        }
   /*End of Added By Dipali V On 13th Feb 2021 For Aligment Issue*/
.W-np-btn{ clear:both;}

/*Added by pradip on 4-4-2023 for overlapping css*/
ul.nav-wizard li a.active,ul.nav-wizard li a:active,ul.nav-wizard li a.active:visited,ul.nav-wizard li a.active:focus{color:#fff;background:#1359a6}
.nav-wizard li.disabled{cursor:not-allowed}
.nav-wizard li.disabled a{pointer-events:none}
ul.nav-wizard li a.active:after{border-left:16px solid #1359a6}
ul.nav-wizard li{padding:0}
ul.nav-wizard li a{padding:0 20px 0 30px}
ul.nav-wizard li::after,ul.nav-wizard li::before{display:none}
ul.nav-wizard li a::before{position:absolute;display:block;border-width:24px 0 24px 16px;border-top-style:solid;border-bottom-style:solid;border-top-color:transparent;border-bottom-color:transparent;border-image:initial;border-left-style:solid;border-left-color:#fff;border-right-style:initial;border-right-color:initial;top:-1px;z-index:10;content:"";right:-16px}
body ul.nav-wizard li a:after{position:absolute;display:block;border:24px solid transparent;border-left:16px solid #999!important;border-right:0;top:-1px;z-index:10;content:'';right:-15px}
ul.nav-wizard li a.active:after{border-left:16px solid #1359a6!important}
ul.nav-wizard .active ~ li a:after{border-left:16px solid #999}
ul.nav-wizard li a.active::before{border-left:16px solid #1359a6!important}
ul.nav-wizard .active ~ li a:after{border-left:16px solid #422e2e}
#CustomFiledsControl .col-md-6{ display:inline-flex;}
div#BoxCustomFileds {clear: both;margin: 0 -10px;}
.wbtn li{ display:inline-flex;}

        /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        .datefielddiv {
            display: block;
        }
        /* .bootstrap-datetimepicker-widget .dropdown-menu{
            background-color: #000;
        } */
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */ 

    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyBulkUpdate">


    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="content">

        <div class="Issuemodulewrap_main">
            <div class="headerspacing">&nbsp;</div>

            <div class="col-md-12">

                <div class="box box-panel box-solid mb-0">
                    <div class="box-body">
                        <!--step_wizard-->


                        <div class="wizard bilkupdatewizard">
                            <!--Commented by pradip on 3-4-2023-->
                            <%--<ul class="nav nav-wizard">
                                <li class="active">
                                    <a href="#step1" data-toggle="tab" id="tab1">Step 1 (Select issues)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step2" data-toggle="tab" id="tab2">Step 2 (Update Attributes)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step3" data-toggle="tab" id="tab3">Step 3 (Perform Action)</a>
                                </li>
                            </ul>--%>
                            <ul class="nav nav-wizard">
                                <li class="">
                                    <a href="#step1" data-bs-toggle="tab" id="tab1" class="nav-link active">Step 1 (Select issues)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step2" data-bs-toggle="tab" id="tab2" class="nav-link">Step 2 (Update Attributes)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step3" data-bs-toggle="tab" id="tab3" class="nav-link">Step 3 (Perform Action)</a>
                                </li>
                            </ul>


                            <form>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="step1">

                                        <div class="form-inline pt-1 mb-2">
                                            <div class="form-group">
                                                <label for="">Updating Issues of <b><span id="UpdatingIssues"></span></b></label>
                                            </div>


                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="text-center mb-2">
                                            <%--   Added & commented by dipali V On 20th Dec 2019 For Caption Change--%>
                                            <label class="mr-1"><%= MyBase.GetResourceString("C_Select_Filter") %></label>
                                           <%-- <label class="mr-1">Select Query</label>--%>
                                            <%--End of Added & commented by dipali V On 20th Dec 2019 For Caption Change--%>
                                            <%--  <% CommonFunctions.HTMLControls.DrawComboBox("cboFilter", "Select ' ' ",,, "class='form-control'") %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboFilter", "Select ' ' ",,, "class='form-control BUselctfiltrlist' data-bs-toggle='tooltip' data-placement='bottom' title='Select Query'", False,,,,,,) %>
                                                    &nbsp &nbsp<a id="myanchorid" href="#" class="pt-Onehalf" onclick="Apply_Onclick()"><%= MyBase.GetResourceString("C_Apply") %></a>
                                            <%-- <button id ="myanchorid"  >Apply</button>--%>
                                        </div>

                                        <div class="copywizardtbl_outer">
                                            <table id="bulkupdatetbl" class="table table-hover table-bordered mt-2" style="width: 100%">

                                                <thead>
                                                    <tr>
                                                        <th style='min-width: 100px;'><%= MyBase.GetResourceString("C_IssueId")%></th>
                                                        <th><%= MyBase.GetResourceString("C_SUMMARY")%></th>
                                                        <th style="min-width: 30%"><%= MyBase.GetResourceString("C_Description1")%></th>
                                                        <th style="min-width: 30%"><%= MyBase.GetResourceString("C_Type")%></th>
                                                        <th><%= MyBase.GetResourceString("C_Sub_Type")%></th>
                                                        <th><%= MyBase.GetResourceString("C_Status")%></th>
                                                        <th><%= MyBase.GetResourceString("C_Priority")%></th>
                                                        <th><%= MyBase.GetResourceString("C_Severity")%></th>
                                                        <th>
                                                            <div class="custom_chckbox">
                                                                <input type="checkbox" class="chckHead" id="selectcopyissueall">
                                                                <label for="selectcopyissueall"></label>
                                                            </div>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="BulkUpdateTblBody">
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="clearfix"></div>
                                        <ul class="list-inline pull-right mt-2 mb-0 W-np-btn clearfix">
                                            <li>
                                                <a href="javascript:;" onclick="backlink()" type="button" class="btn borderbtn ml-1 ">Back</a>

                                                <button type="button" class="btn btnyellow nextwizardbtn ml-1 " id="NextBtn1" onclick="Nextbtn1_click()">Next</button></li>
                                        </ul>
                                    </div>

                                    <div class="tab-pane" id="step2">




                                        <div class="form-group">
                                            <label for=""><%= MyBase.GetResourceString("C_Project") %> <b><span id="SelectedQuery"></span></b></label>
                                        </div>

                                        <div class="clearfix"></div>
                                        <br />
                                        <div class="wizardcontent mt-2">
                                            <p class="text-center"><%= MyBase.GetResourceString("C_Common_Fields_Select_the_value") %></p>

                                            <div class="row">
                                                <div class="col-md-1">&nbsp;</div>
                                                <div class="col-md-10 bucstfields">
                                                    <div class="wizardform">
                                                        <div class="wizardformbody">
                                                             <div class="form-group">
                                                            <div class="row" id="controlploat">
                                                               
                                                                <div class="boxformheading"><strong><%= MyBase.GetResourceString("C_Common_Fields") %></strong></div>

                                                                <div class="col-md-6 row" id="divType">
                                                                    <label class="control-label col-sm-4" id="lblType"><%= MyBase.GetResourceString("C_Type") %></label>
                                                                    <div class="col-sm-8">

                                                                        <% If Request.QueryString("ProjectID").ToString() <> "" %>
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboType", "Exec usp_Whizible2_Sel_IB_BU_Type " & Request.QueryString("ProjectID").ToString(),,, "class='form-control' onchange='Type_OnChange(this.value)'") %>
                                                                        <% End If %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divSubType">

                                                                    <label class="control-label col-sm-4" id="lblSubType"><%= MyBase.GetResourceString("C_Sub_Type") %></label>
                                                                    <div class="col-sm-8">
                                                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboSubType", " Select ' ' ",,, "class='form-control'",,,) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboSubType", "Select ''",,, "class='form-control'",,, ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divStatus">
                                                                    <label class="control-label col-sm-4" id="lblStatus"><%= MyBase.GetResourceString("C_Status") %></label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "Select ' ' ",,, "onchange='Status_OnChange()' class='form-control '",,, ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divReleaseID">
                                                                    <label class="control-label col-sm-4" id="lblReleaseID"><%= MyBase.GetResourceString("C_Release") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboReleaseID", "usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseName " & Request.QueryString("ProjectID"),,, "class='form-control' onchange='Type_OnChangeRelease(this.value)'",) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divIterationID">
                                                                    <label class="control-label col-sm-4" id="lblIterationID"><%= MyBase.GetResourceString("C_Sprint") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboIterationID", "Select ' ' ",,, "class='form-control' onchange='Type_OnChangeIteration(this.value)'",  ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divUserStoryID">
                                                                    <label class="control-label col-sm-4" id="lblUserStoryID"><%= MyBase.GetResourceString("C_User_Story") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboUserStoryID", "Select ' ' ",,, "class='form-control'", ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divStatusChangeDate">
                                                                    <label class="control-label col-sm-4" id="lblStatusChangeDate"><%= MyBase.GetResourceString("C_StatusChangeDate") %></label>
                                                                    <div class="col-sm-8">
                                                                        <div class="input-group datefielddiv">
                                                                            <% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeDate", "dtStatusChangeDate", "form-control", , 200,,,, , True, "white", , "autocomplete='off'",,, True,,,, True) %>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divStatusChangeTime">
                                                                    <label class="control-label col-sm-4" id="lblStatusChangeTime"><%= MyBase.GetResourceString("C_StatusChangeTime") %></label>
                                                                    <div class="col-sm-8">
                                                                        <div class="input-group datefielddiv">
                                                                            <%--<input id="bulkreportedtime" type="text" class="form-control">--%>
                                                                            <% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeTime", "dtStatusChangeTime", "form-control", 50, 200,,,, ,,,, "autocomplete='off'",,, True,,,, True) %>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divReportedBy">
                                                                    <label class="control-label col-sm-4" id="lblReportedBy"><%= MyBase.GetResourceString("C_Reported_By") %></label>
                                                                    <div class="col-sm-8">
                                                                        <%-- <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedBy", "Select ' ' ",,, "class='form-control selectpicker'", True,) %>
                                                                        --%>
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedBy", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy'," & Convert.ToInt32(Request.QueryString("ProjectID")) & "," & Convert.ToInt32(Session("intUserID").ToString()) & ",1,NULL,NULL,'" & Session("LoginType") & "','New',0",,, "class='form-control ' ",  ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divAssignTo">
                                                                    <label class="control-label col-sm-4" id="lblAssignTo"><%= MyBase.GetResourceString("C_AssignToName") %></label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", "Exec usp_Whizible2_Sel_IB_BU_ProjectResources " & Request.QueryString("ProjectID"),,, "class='form-control'") %>
                                                                    </div>
                                                                </div>


                                                                <div class="col-md-6 row" id="divPriority">
                                                                    <label class="control-label col-sm-4" id="lblPriority"><%= MyBase.GetResourceString("C_Priority") %></label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Whizible2_Sel_IB_BU_ProjectPriorities " & Request.QueryString("ProjectID"),,, "class='form-control '", ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divSeverity">
                                                                    <label class="control-label col-sm-4" id="lblSeverity"><%= MyBase.GetResourceString("C_Severity") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboSeverity ", "usp_Whizible2_Sel_IB_BU_ProjectSeverity " & Request.QueryString("ProjectID"),,, "class='form-control'", ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divReportedInVersion">
                                                                    <label class="control-label col-sm-4" id="lblReportedInVersion"><%= MyBase.GetResourceString("C_ReportedInVersion") %>  </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedInVersion", "usp_Whizible2_Sel_IB_BU_ProjectVersions " & Request.QueryString("ProjectID"),,, "class='form-control'", ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divCorrectedInVersion">
                                                                    <label class="control-label col-sm-4" id="lblCorrectedInVersion"><%= MyBase.GetResourceString("C_CorrectedInVersion") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboCorrectedInVersion ", "usp_Whizible2_Sel_IB_BU_ProjectVersions " & Request.QueryString("ProjectID"),,, "class='form-control'", ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divPhase">
                                                                    <label class="control-label col-sm-4" id="lblPhase"><%= MyBase.GetResourceString("C_Phase") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPhase", "usp_Whizible2_Sel_IB_BU_ProjectPhases " & Request.QueryString("ProjectID"),,, "class='form-control'", ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divFoundInPhase">
                                                                    <label class="control-label col-sm-4" id="lblFoundInPhase"><%= MyBase.GetResourceString("C_FoundInPhase") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboFoundInPhase ", "usp_Whizible2_Sel_IB_BU_ProjectPhases " & Request.QueryString("ProjectID"),,, "class='form-control'", ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divFixedInPhase">
                                                                    <label class="control-label col-sm-4" id="lblFixedInPhase"><%= MyBase.GetResourceString("C_FixedInPhase") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboFixedInPhase", "usp_Whizible2_Sel_IB_BU_ProjectPhases " & Request.QueryString("ProjectID"),,, "class='form-control'", ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divRootCauseID">
                                                                    <label class="control-label col-sm-4" id="lblRootCauseID"><%= MyBase.GetResourceString("C_RootCauseID") %></label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRootCauseID ", "usp_Whizible2_Sel_tbl_IB_Project_RootCause_ForProject " & Request.QueryString("ProjectID"),,, "class='form-control '", ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divModuleName">
                                                                    <label class="control-label col-sm-4" id="lblModuleName"><%= MyBase.GetResourceString("C_ModuleName") %></label>
                                                                    <div class="col-sm-8">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboModuleName", "Exec usp_Whizible2_Sel_tbl_PM_Module_ProjectGroup " & Convert.ToInt32(Request.QueryString("ProjectID")) & ",NULL",,, "class='form-control ' ",  ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divChangeRequestID">
                                                                    <label class="control-label col-sm-4" id="lblChangeRequestID"><%= MyBase.GetResourceString("C_ChangeRequestName") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", "Exec usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master " & Convert.ToInt32(Request.QueryString("ProjectID")),,, "class='form-control ' ",  ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divHardware">
                                                                    <label class="control-label col-sm-4" id="lblHardware"><%= MyBase.GetResourceString("C_Hardware") %></label>
                                                                    <div class="col-sm-8">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboHardware", "Exec usp_Whizible2_Sel_tbl_PM_ProjectHardware " & Convert.ToInt32(Request.QueryString("ProjectID")),,, "class='form-control ' ",  ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divOS">
                                                                    <label class="control-label col-sm-4" id="lblOS"><%= MyBase.GetResourceString("C_OS") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboOS", "Exec usp_Whizible2_Sel_tbl_IB_Project_OS " & Convert.ToInt32(Request.QueryString("ProjectID")),,, "class='form-control ' ", ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divKernel">
                                                                    <label class="control-label col-sm-4" id="lblKernel"><%= MyBase.GetResourceString("C_Kernel") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboKernel", "Exec usp_Whizible2_Sel_tbl_IB_Project_Kernels " & Convert.ToInt32(Request.QueryString("ProjectID")),,, "class='form-control ' ", ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divComplexity">
                                                                    <label class="control-label col-sm-4" id="lblComplexity"><%= MyBase.GetResourceString("C_Complexity") %>  </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboComplexity ", "usp_whizible2_Sel_IB_BU_ProjectComplexity " & Request.QueryString("ProjectID"),,, "class='form-control '", ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 row" id="divDeliverableID">
                                                                    <label class="control-label col-sm-4" id="lblDeliverableID"><%= MyBase.GetResourceString("C_Deliverable") %> </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableID ", "usp_whizible2_sel_tbl_PM_OtherSchedules_ForBatch " & Request.QueryString("ProjectID").ToString(),,, "class='form-control '", ) %>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divCodedBy">
                                                                    <label class="control-label col-sm-4" id="lblCodedBy"><%= MyBase.GetResourceString("C_CodedBy") %></label>
                                                                    <div class="col-sm-8">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboCodedBy", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " & Request.QueryString("ProjectID").ToString() & ", NULL ,NULL, NULL, NULL ," & "'" & Session("LoginType") & "','New',0 ",,, "class='form-control'",) %>
                                                                    </div>

                                                                </div>

                                                                <div class="col-md-6 row" id="divShowToCustomer">
                                                                    <label class="control-label col-sm-4" id="lblShowToCustomer"><%= MyBase.GetResourceString("C_ShowToCustomer") %>  </label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawCheckBox("chkShowToCustomer", "chkShowToCustomer") %>
                                                                    </div>
                                                                </div>


                                                                <div class="col-md-6 row" id="divImportID">
                                                                    <label class="control-label col-sm-4" id="lblImportID"><%= MyBase.GetResourceString("C_ImportID") %></label>
                                                                    <div class="col-sm-8">
                                                                    <%-- Added By Rutuja D. on 15 Jan 2020 for restricting alphabates for Import ID--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtImportID", "txtImportID", "form-contorl", , 200, ,,, ,,,, "autocomplete='off'",,, True,,,, EnableHTMLEncode:=True) %>--%>
                                                                        <%--Commented And Added By Usha Pandit On 25.01.2021 For passing correct max length--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtImportID", "txtImportID", "form-contorl", , 200, ,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, EnableHTMLEncode:=True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtImportID", "txtImportID", "form-contorl", , 25, ,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, EnableHTMLEncode:=True) %>
                                                                        <%--End Of Added By Usha Pandit On 25.01.2021 For passing correct max length--%>
                                                                    <%--End Of Added By Rutuja D. on 15 Jan 2020 for restricting alphabates for Import ID--%>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 row" id="divCustomerIssueID">
                                                                 <%--    // Added & Commented By Dipali V On 16th April 2020 For Caption as per layout--%>
                                                                   <%-- <label class="control-label col-sm-4" id="lblCustomerIssueID"><%= MyBase.GetResourceString("C_CustomerIssueID") %></label>--%>
                                                                     <label class="control-label col-sm-4" id="lblCustomerIssueID">Duplicate Issue ID</label>
                                                                    <%--    // End of Added & Commented By Dipali V On 16th April 2020 For Caption as per layout--%>
                                                                    <div class="col-sm-8">
                                                                    <%--Added By Rutuja D. on 15 Jan 2020 for restricting alphabates for Customer Issue ID--%>
                                                                        <% 'CommonFunctions.HTMLControls.DrawTextBox("txtCustomerIssueID", "txtCustomerIssueID", "form-contorl", , 200,,,, ,,,,,,, True,,,, EnableHTMLEncode:=True) %>
                                                                        <%--Commented And Added By Usha Pandit On 25.01.2021 For passing correct max length--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomerIssueID", "txtCustomerIssueID", "form-contorl", , 200,,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, EnableHTMLEncode:=True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCustomerIssueID", "txtCustomerIssueID", "form-contorl", , 30,,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, EnableHTMLEncode:=True) %>
                                                                        <%--End Of Added By Usha Pandit On 25.01.2021 For passing correct max length--%>
                                                                    <%--End Of Added By Rutuja D. on 15 Jan 2020 for restricting alphabates for Customer Issue ID--%>
                                                                    </div>
                                                                </div>
                                                                <%--     </div>
                                                                    </div>--%>
                                                            </div>
                                                                </div>

                                                            <div class="form-group" id="BoxCustomFileds">
                                                                <div class="row">
                                                                <div class="boxformheading"><strong><%= MyBase.GetResourceString("C_Custom_Field") %></strong></div>
                                                                    </div>
                                                                <div class="row" id="CustomFiledsControl">
                                                                    <%-- Here the custom fields are binded by PloatCustomControl() function --%>
                                                                </div>

                                                            </div>
                                                            <div class="clearfix"></div>
                                                            <hr />
                                                            <div class="text-center"><small><em><%= MyBase.GetResourceString("C_These_fields_are_dynamic") %></em></small></div>

                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                    <br />
                                                  
                                                </div>
                                                <div class="col-md-1">&nbsp;</div>
                                            </div>




                                        </div>
                                        <br />
                                        <br />


                                        <ul class="list-inline pull-right wbtn mt-2 mb-0">
                                            <li><a href="javascript:;" id="btnPrevious" class="btn borderbtn btnPrevious">Back</a></li>
                                            <%if m_blnEditAccess = True %>
                                            <li>
                                                <button type="button" class="btn btnyellow nextwizardbtn1" title="Update" id="btnUpdate">Update</button></li>
                                            <%End if%>
                                        </ul>
                                    </div>
                                    <div class="tab-pane" id="step3">
                                        <div class="pt-1 mb-2">
                                            &nbsp;
                                        </div>



                                        <div class="wizardcontent mt-2 mb-2">
                                            <h4 class="text-center text-info"><span id="WaitText"></span><span id="CountIssue"></span></h4>
                                            <h4 class="text-center text-info"><span id="MessageUpdate"></span></h4>
                                            <div class="Bulkloaderimg text-center" style="display: block">
                                                <img src="../../../Whizible2.0-new/dist/img/time.gif" alt="Waiting" title="Waiting">
                                                <div class="Bulkloaderimg text-center">
                                                    <span id="imgtext"></span>
                                                </div>
                                            </div>

                                        </div>
                                        <ul class="list-inline pull-right">
                                            <li>
                                                <%--<a class="gofirst" href="#step1" data-toggle="tab">Add More</a>--%>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </form>
                        </div>

                        <!--End_step_wizard-->
                    </div>

                </div>
            </div>

            <div class="clearfix"></div>
        </div>

        <div class="clearfix"></div>


    </section>
    <!-- /.content -->
     
    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?v=1"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script type="text/javascript">
        var viewApplied;
        //Added By Usha Pandit On 02.12.2020 For Bulk Update table UI issue
        var isload = 0;
        //End Of Added By Usha Pandit On 02.12.2020 For Bulk Update table UI issue
        $(document).ready(function () {
            viewApplied = '<%=ViewApplied%>';
            $('a[data-bs-toggle="tab"]').on('show.bs.tab', function (e) {

                var $target = $(e.target);

                if ($target.parent().hasClass('disabled')) {
                    return false;
                }
            });

            $(".nextwizardbtn").click(function (e) {

                var $active = $('.wizard .nav-wizard li.active');
                $active.next().removeClass('disabled');
                nextTab($active);

            });
            //Added By Usha Pandit On 02.12.2020 For Bulk Update table UI issue
            $(document).ready(function () {
                isload = 1;
                $("#myanchorid").trigger("click");
                isload = 0;
            });
            //End Of Added By Usha Pandit On 02.12.2020 For Bulk Update table UI issue
        });
        
        //For Tab
        function nextTab(elem) {
            $(elem).next().find('a[data-bs-toggle="tab"]').click();
        }

        //For Date Picker
        $(function () {
            // start bootstrap datepicker
            $('#dtReportedDate').each(function () {//#dtStatusChangeDate
                $(this).datepicker({
                    autoclose: true,
                    changeMonth: true,
                    dateFormat: 'dd M yy'
                });
            });

            //ADDED bY DIPALI V ON FOR GENERIC DATEPICKER
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

            //eND OF ADDED bY DIPALI V ON FOR GENERIC DATEPICKER
            // bootstrap datepicker Time
            //$('#dtReportedTime,#dtStatusChangeTime').each(function () {
            //    $(this).datetimepicker({
            //        format: 'LT',
            //    });
            //});


            //checkbox_in_copyissue_table
            $('#copywizardtbl_wrapper .checkAll').click(function (event) {  //on click 
                var $boxes = $(this).closest('table').find('input[type="checkbox"]');
                if (this.checked) { // check select status
                    $boxes.each(function () { //loop through each checkbox
                        this.checked = true;  //select all checkboxes                
                    });
                } else {
                    $boxes.each(function () { //loop through each checkbox
                        this.checked = false; //deselect all checkboxes under the checkAll checkbox                      
                    });
                }
            });

        });


    </script>

    <script type="text/javascript">

        //$('.btnPrevious').click(function () {
        $('.btnPrevious').on('click', function () {
            //$('.nav-wizard > .active').prev('li').find('a').trigger('click');
            const prevTabLinkEl = $('.nav-wizard .active').closest('li').prev('li').find('a')[0];
            const prevTab = new bootstrap.Tab(prevTabLinkEl);
            prevTab.show();
        });

    </script>
    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        var globalStatusChangeDate, globalStatusChangeTime, globalStatus;
        var SessionLoginType;
        var selectedProjectID;
        var selectedProjectName;
        var RoleId;
        var EmployeeId;
        var LoginType;
        var LoginId;
        var Irows = [];
        var commonProperty;
        var controlId;
        var activerow = new Array();
        var ActiveValue = new Array();
        var QueryID;
        var SelectedQueryID;
        var strUpdateSQL = "";
        var strUpdateSQ1L = "";
        var UserName;
        var issueIDs;
        var Issuecount;
        var cboFieldName;
        var txtboxFieldName;
        var txtFieldName;
        var dtFieldName;
        var pageLength;
        var globalCustomFiledAccess;
        alertify.set('notifier', 'position', 'top-right');
        var ValidationMessage = new Array();
        var ValidationValidateID = new Array();
        var ValidationMessageFieldName = new Array();
        var ValidationMessageFiled = new Array();
        var ValidationFieldsName = new Array();
        var ValidationFieldID = new Array();
        var ValidationRules = new Array();
        var cboId = "";
        $(document).ready(function () {
            // try {
            StartLoader("#bodyBulkUpdate");
            UserName = "<%= Session("strUserName").ToString() %>";
            RoleId = "<%= Session("IssueRole").ToString() %>";
            EmployeeId = "<%= Session("intUserID").ToString() %>";
            LoginType = "<%= Session("LoginType").ToString() %>";
            LoginId = "<%= Session("intLoginID").ToString() %>";
            SessionLoginType = '<%= Session("LoginType") %>';
            //Commented & Added By Dipali V On 10th Jan 2023 for Get Project Name
            //var GetselectedProjectName = getUrlVars()["ProjectName"];
            //var GetselectedProject = getUrlVars()["ProjectID"];
            params = getParams();
            var GetselectedProjectName = params["ProjectName"]
            var GetselectedProject = params["ProjectID"]
            //selectedProjectName = GetselectedProjectName.replace(/%20/g, " ").replace(/%E2%80%93/g, "-").replace(/#/g, " ");
            //selectedProjectID = GetselectedProject.replace(/%20/g, " ").replace(/%E2%80%93/g, "-");

            selectedProjectName = unescape(GetselectedProjectName);
            selectedProjectID = unescape(GetselectedProject);
            //End of Commented & Added By Dipali V On 10th Jan 2023 for Get Project Name
            $("#UpdatingIssues").text(selectedProjectName);
            $("#SelectedQuery").text(selectedProjectName);
            //Added By Riddhesh Patil on 31st March 2023
            RoleId = params["RoleId"]
            //End of Added By Riddhesh Patil on 31st March 2023

            // $("#cboReportedBy").val(UserName);
            //stroed all variable in common property

            //Added By Riddhesh Patil on 31st March 2023
            //commonProperty = { ProjectId: selectedProjectID, RoleId: RoleId, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginId, strMode: encodeURI('New') };
            commonProperty = { ProjectId: selectedProjectID.trim(), RoleId: RoleId, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginId, strMode: encodeURI('New') };
            //End of Added By Riddhesh Patil on 31st March 2023

            //  alert(commonProperty.d);
            // to get the Selected Project Quries For IssueBase BatchUpdate
            FillCombox(selectedProjectID, encodeURI(SessionLoginType));
            GetProjectlevelSetting(selectedProjectID)
            GetMaximumItemsToShow()

            //For Placeholder to Dropdown
            //Commented And Added By Usha Pandit On 19.03.2020 For considering custom combo fields during validation 
            //cboId = ["Type", "SubType", "Status", "IterationID", "UserStoryID", "ReleaseID", "ReportedBy", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestID", "CodedBy", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "AssignTo"]
            cboId = ["Type", "SubType", "Status", "IterationID", "UserStoryID", "ReleaseID", "ReportedBy", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestID", "CodedBy", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "AssignTo", "CustomFieldCombo3", "CustomFieldCombo5", "CustomFieldCombo2"]
            //End Of Added By Usha Pandit On 19.03.2020 For considering custom combo fields during validation
            for (var i = 0; i < cboId.length; i++) {
                AppendOptioncbo(cboId[i].toString(), cboId[i].toString());
            }
            //End of  Placeholder to Dropdown

            Pagination();
            //Added by Dipali For Set height Dynamically
            SetWindowHeight();
            // End of  Dipali For Set height Dynamically
            StopAjaxLoader("#bodyBulkUpdate");
            //  }
            //catch{

            //    StopAjaxLoader("#bodyBulkUpdate");

            //}
        });


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

        //For Apply Click data should come as per selected query 
        function Apply_Onclick() {
            StartLoader("#bodyBulkUpdate");            
            
            //Added by dipali V on 9th Aug 2019 for refresh/Filter is not apply

            //Commented And Added By Usha Pandit On 02.12.2020 For Bulk Update table UI issue
            //if ($("#cboFilter").val() == "0") {
            //    alertify.error("Please Select Filter First");
            //    return;
            //}   
            
            if ($("#cboFilter").val() == "0" && isload == 0) {
                alertify.error("Please Select Filter First");
                //return;
            }  
            //End Of Added By Usha Pandit On 02.12.2020 For Bulk Update table UI issue

            //End of Added by dipali V on 9th Aug 2019 for refresh/Filter is not apply
            $('#bulkupdatetbl').dataTable().fnDestroy();
            SelectedQueryID = $('#cboFilter').val();

            $(".chckHead").prop("checked", false);    //To remove selected checkbox after page load
            //alert(selectedProjectID);
            Parameters = {
                QueryID: encodeURI(SelectedQueryID),
                ProjectId: encodeURI(selectedProjectID)
            }
            // alert(Parameters);
            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/PlotIssueList',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (result) {
                    // alert(result);
                    var IssueLists = result;
                    //alert(result);
                    DisplayIssueList(IssueLists);

                    Pagination();
                    SetWindowHeight();
                    //Added by Swapnagandha K On 22 Oct 2019 
                    Selectall();
                    //End Added by Swapnagandha K On 22 Oct 2019 
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""

                }
            });

            
        }


        //For Plotting list Page
        function DisplayIssueList(IssueLists) {
            
            $("#BulkUpdateTblBody").html('');
            var strHTML = "";
            for (var i = 0; i < IssueLists.length; i++) {
                var d = IssueLists[i];
                var intIssueID = d.IssueID;
                var IssueID = d.IssueID.toString();
                var Summary = d.Summary;
                var Description = d.Description;
                var Type = d.Type;
                var SubType = d.Subtype;
                var Status = d.Status;
                var Priority = d.Priority;
                 var Severity = d.Severity;
                //Added by dipali V on 9th Aug 2019 for if data is null then
                if (Type == "0") {
                    Type = "Not Specified";
                }
                else if (Type == "NULL") {
                    Type = "Not Specified";
                }

                if (SubType == "0") {
                    SubType = "Not Specified";
                }
                else if (SubType == "NULL") {
                    SubType = "Not Specified";
                }


                if (Status == "0") {
                    Status = "Not Specified";
                }
                else if (Status == "NULL") {
                    Status = "Not Specified";
                }


                if (Priority == "0") {
                    Priority = "Not Specified";
                }
                else if (Priority == "NULL") {
                    Priority = "Not Specified";
                }


                if (Severity == "0") {
                    Severity = "Not Specified";
                }

                else if (Severity == "NULL") {
                    Severity = "Not Specified";
                }
                if (IssueID.length < 8) {
                    IssueID = '<td data-bs-toggle="tooltip"  data-container="body" title="' + IssueID + '" class="tt_large"> ' + IssueID + '</td>'
                }
                else {
                    var str = IssueID;
                    IssueID = '<td data-bs-toggle="tooltip"  data-container="body" title="' + IssueID + '" class="tt_large"> ' + str + '....</td>'

                }
                if (Summary.length < 15) {
                    Summary = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Summary + '" class="tt_large"> ' + Summary + '</td>'
                }
                else {
                    var str = Summary.substring(0, 15);
                    Summary = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Summary + '" class="tt_large"> ' + str + '....</td>'

                }
                
                if (Description.length < 15) {
                    Description = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Description + '" class="tt_large"> ' + Description + '</td>'
                }
                else {
                    var str = Description.substring(0, 15);
                    Description = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Description + '" class="tt_large"> ' + str + '....</td>'

                }
               
                if (Type.length < 8) {
                    Type = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '" class="tt_large"> ' + Type + '</td>'
                }
                else {
                    var str = Type.substring(0, 8);
                    Type = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '" class="tt_large"> ' + str + '....</td>'

                }
               
                if (SubType.length < 8) {
                    SubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '" class="tt_large"> ' + SubType + '</td>'
                }
                else {
                    var str = SubType.substring(0, 8);
                    SubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '" class="tt_large"> ' + str + '....</td>'

                }
               
                if (Status.length < 8) {
                    Status = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '" class="tt_large"> ' + Status + '</td>'
                }
                else {
                    var str = Status.substring(0, 8);
                    Status = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '" class="tt_large"> ' + str + '....</td>'

                }
              
                if (Priority.length < 8) {
                    Priority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '" class="tt_large"> ' + Priority + '</td>'
                }
                else {
                    var str = Priority.substring(0, 8);
                    Priority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '" class="tt_large"> ' + str + '....</td>'

                }
               
                if (Severity.length < 8) {
                    Severity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '" class="tt_large"> ' + Severity + '</td>'
                }
                else {
                    var str = Severity.substring(0, 8);
                    Severity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '" class="tt_large"> ' + str + '....</td>'

                }

                

                strHTML += '<tr>'
                //strHTML += '<td>'
                strHTML += IssueID
                //strHTML += ' </td > '
                //strHTML += '<td>'
                strHTML += Summary
                //strHTML += ' </td > '
                //strHTML += '<td>'
                strHTML += Description
                //strHTML += ' </td > '
                //strHTML += '<td>'
                strHTML += Type
                //strHTML += '</td>'
                //strHTML += '<td>'
                strHTML += SubType
                //strHTML += '</td>'
                //strHTML += '<td>'
                strHTML += Status
                //strHTML += '</td>'
                //strHTML += '<td>'
                strHTML += Priority
                //strHTML += '</td>'
                //strHTML += '<td>'
                strHTML += Severity
                //strHTML += '</td>'
                strHTML += '<td><div class="custom_chckbox">'
                strHTML += '<input type="checkbox" onclick="Selectall()" id="selectcopyissue_' + intIssueID + '" value="' + intIssueID + '" class="chcktbl"  name="chckIssue">'
                strHTML += '<label for="selectcopyissue_' + intIssueID + '" class="chcktbl"></label>'
                strHTML += '</div></td>'
                strHTML += '</tr>'

                
            }
            $("#BulkUpdateTblBody").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();
           //Commented by Rutuja D. on 12 Dec 2020 for loading continuesly 
            //StopLoader("#bodyBulkUpdate");
           //End Commented by Rutuja D. on 12 Dec 2020 for loading continuesly 
            StopAjaxLoader("#bodyBulkUpdate");
        }

        //for Filling Dropdown
        function FillCombox(selectedProjectID, SessionLoginType) {

            var Parameters = {
                ProjectId: selectedProjectID,
                LoginType: encodeURI(SessionLoginType)
            }

            $("#cboFilter option").empty();

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetProjectID',

                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    //debugger;
                    //Added by Swapnagandha K. On 24 Oct 2019 To remove Blank filter option
                    var objCbo1 = document.getElementById("cboFilter");
                    $("#cboFilter option").remove();
                    for (var i = 0; i < data.length; i++) {
                        var ObjBulkUpdate = data[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjBulkUpdate.QueryName;
                        objOption.value = ObjBulkUpdate.QueryID;
                    }

                    //Commented By Dipali To Change Caption Query To Filter
                    //AppendOptioncbo("Filter", "Query");
                    AppendOptioncbo("Filter", "Filter");
                       //End of Commented By Dipali To Change Caption Query To Filter
                    //End Added by Swapnagandha K. On 24 Oct 2019 To remove Blank filter option
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""
                },
            });

        }

        function GetProjectlevelSetting(selectedProjectID) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetProjectlevelSetting',

                method: 'Post',
                data: JSON.stringify(selectedProjectID),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (selectedProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(selectedProjectID) ? selectedProjectID : JSON.stringify(selectedProjectID)));
                    }
                },
                success: function (data) {

                    //alert(data);
                    globalCustomFiledAccess = data;
                }

            });


        }

        //this use for if checek box checked then all check box selected and all issue id stored in rows array
        $('#selectcopyissueall').click(function () {

            var table = $('#bulkupdatetbl').DataTable();
            if ($(this).prop("checked") == true) {

                var rows = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows).each(function () {
                    this.checked = true;
                });

            }
            else if ($(this).prop("checked") == false) {
                var row = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', row).each(function () {
                    this.checked = false;
                });
            }
        });

        //this use for if uncheck AND Check one of the Checkbox then remove check of Select all        
        $(document).on('change', '.chcktbl', function () {


            var table = $("#bulkupdatetbl").DataTable();
            var checke = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl').length;
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;
            if (checke == checked) {
                $(".chckHead").prop("checked", true);
            }
            else {
                $(".chckHead").prop("checked", false);
            }

        });

        //$("#NextBtn1").click(function () {
        $("#NextBtn1").on('click', function () {

            var table = $('#bulkupdatetbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            issueIDs = $('input[name=chckIssue]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');

            
            if (issueIDs.length != 0) {
                //  $("#controlploattable").remove();
                
                $("#CustomFiledsControl").empty();
                $("#tab1").prop('disabled', false);
                $("#tab2").prop('disabled', false);

                //Added By Usha Pandit On 01.04.2020 For redirecting to step 2 on selecting all issues
                $("#tab2").removeAttr("disabled");
                $("#tab2").attr("data-bs-toggle", "tab");
                //End Of Added By Usha Pandit On 01.04.2020 For redirecting to step 2 on selecting all issues

                $(".nav.nav-wizard li:nth-child(2)").removeClass("disabled");
                $('a[href="#step2"]').tab('show');

                //This function ploats the Controls
                GetProjectControlPloating(selectedProjectID, commonProperty);

                //This function ploats the custom fields depends upon the projectId
                PloatCustomFields(commonProperty);
                // $("#cboReportedBy").val(UserName);
                // DeleteRow();
                // PloatExtendedCustomFields(commonProperty);
                var i = 1;
                $('#controlploat > div').map(function () {
                    //alert(this.className);
                    //var id = "#controlploat  div:nth-child(" + i + ")";
                    if (!$.trim($("#controlploat > div:nth-child(" + i + ")").text())) {
                        // paragraph with id="element" is empty, your code goes here
                        //alert(this.className);
                        //$(this.className).remove();
                        $(this).hide();
                    }
                    //alert(i);
                    i++;

                });
                //This function ploats the custom fields depends upon the projectId
            } else {
                alertify.error("Please select at least one record.");
                $("#tab2").prop('disabled', true);
                return false;
            }
        });

        //Function for to get the Selected Project Name from IB_IssueList.aspx page using query string
        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];

            }
            return vars;
        }

        //this is function used for plaoting some control by using projecct id 

        function GetProjectControlPloating(projectId, commonProperty) {

            // this created for ploating itreation , userstory,release control

            var Project_Flag;
            var MaxRows;
            var MaxCols;
            var IsIssueSLAApplicable;
            var Layoutdetails;
            var ListFiled;
            var ProjectId = parseInt(projectId);
            var commonProperty = commonProperty;
            //get project flag and stored variable Project_Flag
            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetLayoutProjectFlag',
                type: 'POST',
                data: JSON.stringify(commonProperty),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (commonProperty) {
                        xhr.setRequestHeader("Params", encryptString(isJson(commonProperty) ? commonProperty : JSON.stringify(commonProperty)));
                    }
                },
                success: function (result) {

                    Project_Flag = result[0];
                    IsIssueSLAApplicable = result[1];
                    //layoutid = result[2];
                    //MaxRows = result[3];
                    //MaxCols = result[4];

                },
                error: function (xhr, errorThrown) {

                    // alert("error");
                    $("#tab2").prop('disabled', true);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""
                }
            });

            //Added By Chetan M on 5 May 2021 for layout as per layout defined
            var RoleId =  "<%= Session("intPostID").ToString() %>";
           //End of Added By Chetan M on 5 May 2021 for layout as per layout defined

             //Added By Riddhesh Patil on 31st March 2023
            //var LayoutControl = { ProjectId: projectId, RoleId: parseInt(RoleId) };
            var LayoutControl = { ProjectId: projectId.trim(), RoleId: parseInt(RoleId) };
             //End of Added By Riddhesh Patil on 31st March 2023
            $.ajax({

                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/IssueControlLists',
                method: 'Post',
                data: JSON.stringify(LayoutControl),
                dataType: 'json',
                async: false,

                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (LayoutControl) {
                        xhr.setRequestHeader("Params", encryptString(isJson(LayoutControl) ? LayoutControl : JSON.stringify(LayoutControl)));
                    }
                },
                success: function (result) {

                    var res = result[0];

                    Layoutdetails = result;

                    ListFiled = ["Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestID", "CodedBy", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "ImportID", "CustomerIssueID", "Hardware", "ReportedDate", "ReportedTime", "ReportedBy", "Type", "SubType", "Status", "Priority", "ReleaseID", "IterationID", "UserStoryID", "ShowToCustomer", "Kernel", "OS", "AssignTo", "StatusChangeDate", "StatusChangeTime", "DeliverableID"]
                    //  ListFiled = ["ReportedDate", "ReportedTime", "ReportedBy", "Type", "SubType", "Status", "ReleaseID", "IterationID", "UserStoryID", "StatusChangeDate", "StatusChangeTime", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestID", "CodedBy", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "ImportID", "CustomerIssueID", "ShowToCustomer", "Hardware", "OS", "Kernel", "AssignTo"];

                    //ListFiled = ["SubType", "Status", "CodedByName", "AssignToName", "Priority", "Severity", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "RootCauseID", "DeliverableID", "Complexity"];


                    for (var i = 0; i < result.length; i++) {

                        var layoutcontrolobject = result[i];
                        var filed = ListFiled[i];
                        if (ListFiled.indexOf(layoutcontrolobject.TableFieldName) > -1) {

                            //this is declare for strod control prefix like if we wolud ploat text box control then this id will txtDescription
                            // #txt= textbox,#dt=Datetime/calender,#cbo=dropdown list/select tag,
                            var cntrlprefix;
                            if (layoutcontrolobject.TableFieldName == "ImportID" || layoutcontrolobject.TableFieldName == "CustomerIssueID") {
                                if (layoutcontrolobject.TableFieldName == "CustomerIssueID") {
                                    layoutcontrolobject.TableFieldName = "CustomerIssueID";
                                    cntrlprefix = "#txt";
                                } else {
                                    cntrlprefix = "#txt";
                                }
                            } else if (layoutcontrolobject.TableFieldName == "ReportedDate" || layoutcontrolobject.TableFieldName == "ReportedTime") {

                                cntrlprefix = "#dt";

                            }
                            else if (layoutcontrolobject.TableFieldName == "StatusChangeDate" || layoutcontrolobject.TableFieldName == "StatusChangeTime") {

                                if (IsIssueSLAApplicable == false || commonProperty.LoginType == "C") {
                                    layoutcontrolobject.Active = false;


                                } else {
                                    layoutcontrolobject.Active = true;

                                }
                                cntrlprefix = "#dt";


                            }
                            else if (layoutcontrolobject.TableFieldName == "ReleaseID" || layoutcontrolobject.TableFieldName == "IterationID" || layoutcontrolobject.TableFieldName == "UserStoryID") {

                                if (Project_Flag == "0") {
                                    layoutcontrolobject.Active = false;

                                } else {
                                    layoutcontrolobject.Active = true;

                                }
                                cntrlprefix = "#cbo";

                            } else {

                                cntrlprefix = "#cbo";

                            }


                            //this funtion used for  ploating common control pass some parameter

                            ActiveCommonPloating(layoutcontrolobject.UserFriendlyName, layoutcontrolobject.TableFieldName, layoutcontrolobject.Active, layoutcontrolobject.ReadOnly, layoutcontrolobject.ControlWidth, layoutcontrolobject.Mandatory, cntrlprefix);

                        } else {

                            continue;
                        }

                    }

                },
                error: function (xhr, errorThrown) {
                    //  alert("error ");
                    $("#tab2").prop('disabled', true);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""
                }
            });
        }

        //This is use for Ploting Custom Fields
        function ActiveCommonPloating(UserFriendlyName, TableFieldName, Active, ReadOnly, ControlWidth, Mandatory, cntrlprefix) {

            //this is used for custom create div id and label id common filed control 
            // the div id strate with div and label id is start with lbl
            var divId = "#div" + TableFieldName;
            var lblId = "#lbl" + TableFieldName;
            var a = $(divId).parent(".form-group");
            //$("#chkShowToCustomer").attr("check","");
            console.log(a);
            //this is use for custom create control id that mean if we use textbox, dorpdown,datetimepicker etc .
            // cntrlId is prefix of control id

            if (Active == true) {
                // debugger;
                controlId = cntrlprefix + TableFieldName;                
                //Added By Usha Pandit On 24.09.2020 For display fields according to layout field name
                //Added By Chetan M on 26 May 2021 for change caption issue
                if (UserFriendlyName == 'Iteration') {
                    UserFriendlyName = 'Sprint';
                }
                //End of Added By Chetan M on 26 May 2021 for change caption issue
                $(lblId).text(UserFriendlyName);
                $("#cbo" + TableFieldName + " option[value=0]").text("Select " + UserFriendlyName);
                //End Of Added By Usha Pandit On 24.09.2020 For display fields according to layout field name
                if (controlId != "#dtReportedTime" && controlId != "#dtReportedDate" && controlId != "#dtStatusChangeDate" && controlId != "#dtStatusChangeTime") {
                    if ($(controlId).val() != "" && $(controlId).val() != "0") {
                        //if ($(controlId).indexOf("cbo") !== -1) {
                        $(controlId).val('0');
                        // }

                    }

                    $("#txtImportID").val("");
                    $("#txtCustomerIssueID").val("");
                    $("#chkShowToCustomer").removeAttr("checked");
                    //else if ($(controlId).indexOf("txt") !== -1) {

                    //     $(controlId).val("");
                    //}


                }
                // alert(controlId)


                $(divId).show();
                ////$("select option[value*='0']").prop('disabled',true);
                //if (ReadOnly == true) {
                //    $(controlId).attr("disabled", true);

                //} else {
                $(controlId).attr("disabled", false);

                //}
                if (ControlWidth > 0) {

                    $(controlId).css('width', ControlWidth);
                }

                //alert(activerow);
                if (activerow.indexOf(TableFieldName) == -1) {

                    activerow.push(TableFieldName);
                }
            } else {
                $(divId).remove();

            }

        }


        // For Selection of Type Subtype,Status Should if Default set
        function Type_OnChange(Type) {

            if (Type != 0) {
                // debugger;
                StartLoader("#bodyBulkUpdate");

                GetDefaultValue(selectedProjectID, Type)
                GetSubType(selectedProjectID, Type)
                GetStatus(selectedProjectID, Type, RoleId)
                StopAjaxLoader("#bodyBulkUpdate");
            }
            else {
                $('#cboSubType').empty();
                $('#cboStatus').empty();
                $('#dtStatusChangeDate').val('');
                $('#dtStatusChangeTime').val('');
                var fields = ["SubType", "Status"];
                for (var i = 0; i < fields.length; i++) {
                    AppendOptioncbo(fields[i].toString(), fields[i].toString());
                }

            }
        }

        //Get Default SubType and Status For Dropdown ...Set in Project Setting:Issue Types
        var DefaultSubType = "";
        var DefaultStatus = "";

        function GetDefaultValue(ProjectId, Type) {
            DefaultSubType = "";
            DefaultStatus = "";

            var issueParameters = {
                ProjectId: ProjectId.trim(),
                Type: Type
            };

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/DefaultSubTypeAndStatus',
                method: 'Post',
                data: JSON.stringify(issueParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (issueParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(issueParameters) ? issueParameters : JSON.stringify(issueParameters)));
                    }
                },
                success: function (result) {

                    if (result != "") {
                        //debugger;
                        DefaultSubType = result[0].SubType;
                        //Added by Dipali V On 2nd April 2020 For Status Mapping
                        //DefaultStatus = result[1].Status;
                        //debugger;
                        if (result[1] != undefined) {
                            if (result[1].Status != "") {
                                DefaultStatus = result[1].Status;
                            }
                        }
                        //} else {
                        //    DefaultStatus = result[0].Status;
                        //}
                        //alert(DefaultStatus);
                        if (DefaultStatus == "") {
                            DefaultStatus = result[0].Status;
                        }


                        //End of Added by Dipali V On 2nd April 2020 For Status Mapping
                        //debugger;
                        if ($("#cboStatus").val() != "" || $("#cboStatus").val() != "0") {
                            Status_OnChange();
                        } else {
                            //Added By Dipali V On 17th April 2020 For 17th April 2020 For Clear Status & Status Date should be clear
                            $('#dtStatusChangeTime').val('');
                          $('#dtStatusChangeDate').val('');
                            //objStatusDate.value('');
                            //objStatusTime.value('');
                          //End of Added By Dipali V On 17th April 2020 For 17th April 2020 For Clear Status & Status Date should be clear

                        }
                        $('select option')
                            .filter(function () {
                                return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                            })
                            .remove();

                    }
                    else {
                        var fields = ["SubType", "Status"];
                        for (var i = 0; i < fields.length; i++) {
                            AppendOptioncbo(fields[i].toString(), fields[i].toString());
                        }
                    }


                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        //For Subtype 
        function GetSubType(ProjectId, Type) {

            var Parameters = { ProjectId: parseInt(ProjectId), Type: Type };

            // $("#cboSubType option").empty();

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetSubType',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                //async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    //debugger;
                    if (data != "") {
                        var objCbo1 = document.getElementById("cboSubType");
                        $("#cboSubType option").remove();
                        for (var i = 0; i < data.length; i++) {
                            var Objresult = data[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.text = Objresult.FieldName;
                            objOption.value = Objresult.FieldID;

                        }
                        // if (SelectedStatus == "" && SelectedSubType == "") {

                        //}
                       // debugger;
                        $("#cboSubType").val(DefaultSubType);
                        // AppendOptioncbo("SubType");
                        // AppendOptioncbo("Status");

                        if (DefaultStatus == "" && DefaultSubType == "") {
                            AppendOptioncbo("SubType", "SubType");
                            AppendOptioncbo("Status", "Status");


                             //Added By Dipali V On 17th April 2020 For 17th April 2020 For Clear Status & Status Date should be clear
                            $('#dtStatusChangeTime').val('');
                          $('#dtStatusChangeDate').val('');
                            //objStatusDate.value('');
                            //objStatusTime.value('');
                          //End of Added By Dipali V On 17th April 2020 For 17th April 2020 For Clear Status & Status Date should be clear
                        }
                        // Added by Dipali V On 2nd April 2020 For Status Mapping
                        else if (DefaultSubType == null) {
                            AppendOptioncbo("SubType", "SubType");
                           

                        } else if (DefaultStatus == null) {
                            AppendOptioncbo("Status", "Status");
                        }
                        //End of Added by Dipali V On 2nd April 2020 For Status Mapping
                    }

                },
                error: function (xhr, errorThrown) {
                    //Commented And Added By Usha Pandit On 19.03.2020 for redirecting to error page
                    //alertify.error("It Has No Sub Type");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //End Of Added By Usha Pandit On 19.03.2020 for redirecting to error page
                },
            });

        }

        //For Status
        function GetStatus(ProjectId, Type, RoleId) {

            var Parameters = { ProjectId: parseInt(ProjectId), Type: Type, RoleId: parseInt(RoleId), Status: DefaultStatus };

            //$("#cboStatus option").empty();

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetStatus',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    //debugger;
                    if (data != "") {
                        var objCbo1 = document.getElementById("cboStatus");
                        $("#cboStatus option").remove();
                        for (var i = 0; i < data.length; i++) {
                            var Objresult = data[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            objOption.text = Objresult.FieldName;
                            objOption.value = Objresult.FieldID;

                        }
                        //if (SelectedStatus == "" && SelectedSubType == "") {
                        if (DefaultStatus == "" && DefaultSubType == "") {
                            // AppendOptioncbo("Status");
                        }
                        //}
                        //added by dipali v on 3rd Sep to take default status 
                        globalStatus = DefaultStatus;
                        //End of added by dipali v on 3rd Sep to take default status 
                        $("#cboStatus").val(DefaultStatus);
                    }

                },
                error: function (xhr, errorThrown) {
                    //Commented And Added By Usha Pandit On 19.03.2020 for redirecting to error page
                    //alertify.error("It Has No Status");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //End Of Added By Usha Pandit On 19.03.2020 for redirecting to error page
                },
            });

        }

        //For Release Selection sprint Should get
        function Type_OnChangeRelease(ReleaseId) {

            //Get Selected IterationID
            var ReleaseID = $("#cboReleaseID").find(':selected').val();

            if (ReleaseID != 0) {
                StartLoader("#bodyBulkUpdate");
                GetIteration(encodeURI(ReleaseID))
                StopAjaxLoader("#bodyBulkUpdate");
            }
            else {
                $("#cboIterationID").empty();
                $("#cboUserStoryID").empty();
                var fields = ["IterationID", "UserStoryID"];
                for (var i = 0; i < fields.length; i++) {

                    AppendOptioncbo(fields[i].toString(), fields[i].toString());
                }
            }
        }

        //For Get Sprint DropDown
        function GetIteration(ReleaseID) {

            $("#cboIterationID").empty();

            var Parameters = { ReleaseID: parseInt(ReleaseID) };

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetIteration',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {

                    var objCbo1 = document.getElementById("cboIterationID");
                    $("#cboIterationID option").remove();
                    //var objOption1 = document.createElement("OPTION");
                    //objCbo1.options.add(objOption1, 0);
                    //objCbo1.selectedIndex = 0;
                    for (var i = 0; i < data.length; i++) {
                        var Objresult = data[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);

                        objOption.text = Objresult.IterationName;
                        objOption.value = Objresult.IterationID;

                    }
                    AppendOptioncbo("IterationID", "IterationID");
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();
                },
                error: function (xhr, errorThrown) {
                    //Commented And Added By Usha Pandit On 19.03.2020 for redirecting to error page
                    //alertify.error("It Has No Iteration");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //End Of Added By Usha Pandit On 19.03.2020 for redirecting to error page
                },
            });

        }

        //For Get Sprint DropDown
        function Type_OnChangeIteration(IterationId) {

            //Get Selected IterationID
            var IterationID = $("#cboIterationID").find(':selected').val();
            //alert(IterationID);
            if (IterationID != 0) {
                StartLoader("#bodyBulkUpdate");
                GetUserStory(encodeURI(IterationID))
                StopAjaxLoader("#bodyBulkUpdate");

            }
            else {
                $("#cboUserStoryID ").empty();
                var fields = ["UserStoryID"];
                for (var i = 0; i < fields.length; i++) {
                    AppendOptioncbo(fields[i].toString(), fields[i].toString());
                }
            }
        }

        //For US DropDown
        function GetUserStory(IterationID) {

            var Parameters = { IterationID: parseInt(IterationID) };
            //$("#cboUserStoryID").empty();

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetUserStory',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {

                    var objCbo1 = document.getElementById("cboUserStoryID");
                    $("#cboUserStoryID option").remove();
                    //var objOption1 = document.createElement("OPTION");
                    //objCbo1.options.add(objOption1, 0);
                    //objCbo1.selectedIndex = 0;
                    for (var i = 0; i < data.length; i++) {
                        var Objresult = data[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);

                        objOption.text = Objresult.UserStoryName;
                        objOption.value = Objresult.UserStoryID;
                    }
                    AppendOptioncbo("UserStoryID", "UserStoryID");
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();
                },
                error: function (xhr, errorThrown) {
                    //Commented And Added By Usha Pandit On 19.03.2020 for redirecting to error page
                    //alertify.error("It Has No UserStory");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //End Of Added By Usha Pandit On 19.03.2020 for redirecting to error page
                },
            });

        }

        //For Plotting Custom Fileds
        ValidationFieldsName = [];
        ValidationFieldID = [];
        ValidationRules = [];
        function PloatCustomFields(commonProperty) {
            //   alert(globalCustomFiledAccess);
            var strHTML = "";
             //Added By Riddhesh Patil on 31st March 2023
            //var customFiled = { commonProperty: commonProperty };
            var customFiled = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId,
                strMode: commonProperty.strMode
            };
             //End of Added By Riddhesh Patil on 31st March 2023
            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/PloatCustomFiled',
                method: 'Post',
                data: JSON.stringify(customFiled),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (customFiled) {
                        xhr.setRequestHeader("Params", encryptString(isJson(customFiled) ? customFiled : JSON.stringify(customFiled)));
                    }
                },
                success: function (result) {
                    $("#CustomFiledsControl").html("");
                    strHTML = "";
                    if (result.length == 0) {

                        strHTML += "<label class='control-label'> No custom fields have been defined for this project.  </label>";
                        $("#CustomFiledsControl").append(strHTML);

                    }

                    for (var i = 0; i < result.length; i++) {
                        var CustomFiledObj = result[i];
                        //debugger;
                        //if (i === 0 && i % 2 === 0)
                        //{
                        strHTML += "<div class='form-group'>"
                        strHTML += " <div class='row'>"
                        //}


                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldCombo") !== -1) {
                            strHTML = "";
                            var mandatory = "";
                            //strHTML += "<div class='col-md-6'>"
                            var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;
                            if (CustomFiledObj.ValidationRules.includes("1,") == true) {
                                ////create custom madatory id 
                                var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                                var mandatoryid = "#" + requeridId;
                                if ($(mandatoryid).length > 0) {

                                } else {
                                    if (globalCustomFiledAccess == 1) {
                                        var lblval = "<span id=" + requeridId + "  style='color:red;'>*</span>";
                                        mandatory += lblval;
                                    }
                                }
                            }

                            //  if (mandatory != "") {
                            strHTML += " <div class='col-md-6' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                "<label class='control-label col-sm-4' id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " " + mandatory + " :</label>";
                            //debugger;
                            //}
                            if (CustomFiledObj.IsCustomFieldAssigned == "1") {
                                strHTML += "<div class='col-sm-8'><select class='form-control' id='cbo" + CustomFiledObj.DatabaseFieldName + "' style='width:160px'  MaxLength='" + CustomFiledObj.MaxLength + "'  MinValue='" + CustomFiledObj.MinValue + "'   MaxValue='" + CustomFiledObj.MaxValue + "'>" +

                                    "</select> </div> ";
                                //cboFieldName = 'cbo' + CustomFiledObj.DatabaseFieldName;
                                if (activerow.indexOf(CustomFiledObj.DatabaseFieldName) == -1) {

                                    activerow.push(CustomFiledObj.DatabaseFieldName);

                                }
                            }
                            else {

                                strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "' style='margin-left: 5%;'><b> Not Available </b> </span>";
                            }
                            //strHTML += "</div> </div>";
                            if (i === 0 && i % 2 === 0) {
                                strHTML += "</div> </div>";
                            }
                            $("#CustomFiledsControl").append(strHTML);

                            if (CustomFiledObj.DefaultValue != 0) {

                                $("select#cbo" + CustomFiledObj.DatabaseFieldName + "option:contains(" + CustomFiledObj.DefaultValue + ")").prop('selected', true);

                            }

                          //  GetCustomFiledComboboxValues(CustomFiledObj.DatabaseFieldName, selectedProjectID);
                            var fieldid = "#cbo" + CustomFiledObj.DatabaseFieldName;
                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                //added By Dipali V On 9th Aug 2019 For ValidateCustom fields
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }//debugge
                            //debugger;
                            AppendOptioncbo(CustomFiledObj.DatabaseFieldName, CustomFiledObj.UserGivenCaption);
                            //End of added By Dipali V On 9th Aug 2019 For ValidateCustom fields
                        }

                        if (i === 0 && i % 2 === 0) {
                            strHTML += "<div class='form-group'>"
                            strHTML += " <div class='row'>"
                        }


                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldText") !== -1) {
                            strHTML = "";

                            // strHTML += "<div class='form-group'>"
                            var mandatory = "";
                            if (CustomFiledObj.ValidationRules.includes("1,") == true) {
                                ////create custom madatory id 
                                var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                                var mandatoryid = "#" + requeridId;
                                if ($(mandatoryid).length > 0) {

                                } else {
                                    if (globalCustomFiledAccess == 1) {
                                        var lblval = "<span id=" + requeridId + "  style='color:red;'>*</span>";
                                        mandatory += lblval;
                                    }
                                }
                            }


                            strHTML += "<div class='col-md-6' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                "<label class='control-label col-sm-4' id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " " + mandatory + " : </label>";
                            var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;

                            if (CustomFiledObj.DatabaseFieldName.indexOf("Area") !== -1) {
                                if (CustomFiledObj.IsCustomFieldAssigned == "1") {
                                    strHTML += "<div class='col-sm-8'> <textarea rows='3' cols='25' autocomplete='off' id='txtext" + CustomFiledObj.DatabaseFieldName + "'    MaxLength='" + CustomFiledObj.MaxLength + "'  MinValue='" + CustomFiledObj.MinValue + "'   MaxValue='" + CustomFiledObj.MaxValue + "'  value='" + CustomFiledObj.DefaultValue + "'>" + CustomFiledObj.DefaultValue + "</textarea></div>";

                                    if (activerow.indexOf(CustomFiledObj.DatabaseFieldName) == -1) {

                                        activerow.push(CustomFiledObj.DatabaseFieldName);

                                    }
                                }
                                else {
                                    strHTML += "<span class='col-sm-8' id='res" + CustomFiledObj.DatabaseFieldName + "'><b> Not Available </b> </span>";
                                }
                            }
                            else {
                                if (CustomFiledObj.IsCustomFieldAssigned == "1") {
                                    strHTML += "<div class='col-sm-8'> <input type='text' class='form-control'  autocomplete='off' id='txt" + CustomFiledObj.DatabaseFieldName + "' style='width:160px' value='" + CustomFiledObj.DefaultValue + "' MaxLength='" + CustomFiledObj.MaxLength + "'  MinValue='" + CustomFiledObj.MinValue + "'   MaxValue='" + CustomFiledObj.MaxValue + "'>";

                                    // txtboxFieldName = 'txt' + CustomFiledObj.DatabaseFieldName;
                                    if (activerow.indexOf(CustomFiledObj.DatabaseFieldName) == -1) {

                                        activerow.push(CustomFiledObj.DatabaseFieldName);

                                    }
                                }
                                else {
                                    strHTML += "<span class='col-sm-8' id='res" + CustomFiledObj.DatabaseFieldName + "'><b> Not Available </b> </span>";

                                }
                            }

                            if (i === 0 && i % 2 === 0) {
                                strHTML += "</div> </div>";
                            }

                            $("#CustomFiledsControl").append(strHTML);

                            //alert(CustomFiledObj.DefaultType);
                            var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                            if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                                $(fieldid).html(CustomFiledObj.DefaultValue);
                            }
                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                //added By Dipali V On 9th Aug 2019 For ValidateCustom fields
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                            //End of added By Dipali V On 9th Aug 2019 For ValidateCustom fields
                            continue;
                        }
                        if (i === 0 && i % 2 === 0) {
                            strHTML += "<div class='form-group'>"
                            strHTML += " <div class='row'>"
                        }


                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldDate") !== -1) {
                            strHTML = "";
                            var mandatory = "";
                            if (CustomFiledObj.ValidationRules.includes("1,") == true) {
                                ////create custom madatory id 
                                var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                                var mandatoryid = "#" + requeridId;
                                if ($(mandatoryid).length > 0) {

                                } else {
                                    if (globalCustomFiledAccess == 1) {
                                        var lblval = "<span id=" + requeridId + "  style='color:red;'>*</span>";
                                        mandatory += lblval;
                                    }
                                }
                            }

                            //strHTML += "<div class='form-group'>"

                            strHTML += "<div class='col-md-6' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                "<label class='control-label col-sm-4' id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " " + mandatory + " : </label>";
                            var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;

                            if (CustomFiledObj.IsCustomFieldAssigned == "1") {
                                strHTML += "<div class='col-sm-8'><input type='text' class='form-control'  autocomplete='off' id='dt" + CustomFiledObj.DatabaseFieldName + "' style='width:160px' value=" + CustomFiledObj.DefaultValue + "  ></div>";
                                //cboFieldName = 'dt' + CustomFiledObj.DatabaseFieldName;
                                if (activerow.indexOf(CustomFiledObj.DatabaseFieldName) == -1) {

                                    activerow.push(CustomFiledObj.DatabaseFieldName);

                                }
                            }
                            else {
                                strHTML += "<div class='col-sm-8'><span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b>Not Available</b> </span> </div>";
                            }
                            if (i === 0 && i % 2 === 0) {
                                strHTML += "</div> </div>";
                            }
                            // $("#dt" + CustomFiledObj.DatabaseFieldName).datepicker({ dateFormat: 'dd-M-yy' });
                            $("#CustomFiledsControl").append(strHTML);
                            var fieldid = "#dt" + CustomFiledObj.DatabaseFieldName;
                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                // added By Dipali V On 9th Aug 2019 For ValidateCustom fields
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                            //End of added By Dipali V On 9th Aug 2019 For ValidateCustom fields
                            if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                                $(fieldid).html(CustomFiledObj.DefaultValue);
                            }


                            CustomfiledDatePicker(CustomFiledObj.DatabaseFieldName);
                            continue;
                        }
                    }
                }
                ,
                error: function (xhr, errorThrown) {
                    //alert(xhr.responseXML);
                }
            });
            
            if (globalCustomFiledAccess == 1) {
                SetValidationToCustomFileds()
            }


        }


        function SelectDateFormte(ID) {



        }
        //added By Dipali V On 9th Aug 2019 For ValidateCustom fields

        ValidationMessageFieldName = [];
        ValidationMessageFiled = [];
        ValidationMessage = [];
        ValidationValidateID = [];

        function SetValidationToCustomFileds() {
            // debugger;
            for (var i = 0; i < ValidationFieldsName.length; i++) {
                var customFiled = { FieldID: ValidationFieldID[i], CustomFieldName: ValidationFieldsName[i], CustomValidation: ValidationRules[i] };
                $.ajax({
                    url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetValidationForCustomFields',
                    method: 'Post',
                    data: JSON.stringify(customFiled),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (customFiled) {
                            xhr.setRequestHeader("Params", encryptString(isJson(customFiled) ? customFiled : JSON.stringify(customFiled)));
                        }
                    },
                    success: function (result) {
                        // debugger;
                        for (var i = 0; i < result.length; i++) {
                            var ValidationObj = result[i];

                            if (ValidationMessage != "") {


                            }

                            // if (ValidationValidateID.indexOf(ValidationObj.ValidationID) == -1 && ValidationMessageFiled.indexOf(ValidationObj.FieldID) == -1)
                            {
                                ValidationMessage.push(ValidationObj.ValidationMessage);
                                ValidationValidateID.push(ValidationObj.ValidationID);
                                ValidationMessageFiled.push(ValidationObj.FieldID);
                                ValidationMessageFieldName.push(ValidationObj.FieldName);
                            }


                        }

                    }
                });
            }
        }
        //End of added By Dipali V On 9th Aug 2019 For ValidateCustom fields

        // added By Dipali V On 9th Aug 2019 For ValidateCustom fields
        var ValidationMessageNew = new Array();
        function CustomFiledValidation() {
            //debugger;
            var checkval = 0;
            for (var i = 0; i < ValidationMessageFieldName.length; i++) {

                switch (ValidationValidateID[i]) {

                    case "1":
                        //For Blank
                        if (ValidationMessage[i].indexOf("blank") != -1) {
                            if ($(ValidationMessageFiled[i]).val() == "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                checkval = 1;
                                alertify.error(ValidationMessageFieldName[i] + ValidationMessage[i]);
                                $(ValidationMessageFiled[i]).focus()
                                return checkval;
                            }
                        }
                        break;

                    //For validate Date
                    case "2":
                        if (ValidationMessage[i].indexOf("Date") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if (!isDate($(ValidationMessageFiled[i]))) {
                                    checkval = 1;
                                    alertify.error(ValidationMessage[i] + " For " + ValidationMessageFieldName[i]);
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;

                    //For  Number
                    case "3":
                        if (ValidationMessage[i].indexOf("numeric") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if (!isNumeric($(ValidationMessageFiled[i]).val())) {

                                    checkval = 1;
                                    alertify.error(ValidationMessage[i] + "" + ValidationMessageFieldName[i]);
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;


                    case "9"://for Alphabets
                        // debugger;
                        if (ValidationMessage[i].indexOf("Alphabets") != -1) {
                            if (ValidationMessageFiled[i].indexOf("Area") != -1) {
                                var Condition = $(ValidationMessageFiled[i]).text();
                            }
                            else {
                                var Condition = $(ValidationMessageFiled[i]).val();
                            }
                            if (Condition != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                var pattern = /^[a-zA-Z]+$/;
                                if (!pattern.test(Condition)) {
                                    checkval = 1;
                                    alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i]);
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;
                    case "12": //For Maxlenght 
                        if (ValidationMessage[i].indexOf("Max") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if ($(ValidationMessageFiled[i]).attr("maxlength")) {
                                    if ($(ValidationMessageFiled[i]).val().length > $(ValidationMessageFiled[i]).attr("maxlength")) {

                                        checkval = 1;
                                        alertify.error(ValidationMessage[i] + "" + ValidationMessageFieldName[i]);
                                        $(ValidationMessageFiled[i]).focus()
                                        return checkval;
                                        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                    }

                                }
                            }
                        };
                        break;
                    case "13":
                        //For Positive Number
                        if (ValidationMessage[i].indexOf("positive numeric") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if ($(ValidationMessageFiled[i]).val() < 0) {

                                    checkval = 1;
                                    alertify.error(ValidationMessage[i] + "" + ValidationMessageFieldName[i]);
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;

                    case "15":     //For Special Char
                        if (ValidationMessage[i].indexOf("contain") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                var regex = /^[0-9a-zA-Z\_]+$/;
                                var value = $(ValidationMessageFiled[i]).val();
                                if (regex.test(value) == false) {

                                    checkval = 1;
                                    alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i]);
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;
                    case "16": //For  Minimum Value Check
                        if (ValidationMessage[i].indexOf("less") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if ($(ValidationMessageFiled[i]).attr("MinValue")) {
                                    if ($(ValidationMessageFiled[i]).val() < $(ValidationMessageFiled[i]).attr("MinValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MinValue")) {

                                        checkval = 1;
                                        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MinValue"));
                                        $(ValidationMessageFiled[i]).focus()
                                        return checkval;
                                        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                    }

                                }
                            }
                        };
                        break;
                    case "17"://For  Maximum Value Check
                        if (ValidationMessage[i].indexOf("greater") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if ($(ValidationMessageFiled[i]).attr("MaxValue")) {
                                    if ($(ValidationMessageFiled[i]).val() >= $(ValidationMessageFiled[i]).attr("MaxValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MaxValue")) {

                                        checkval = 1;
                                        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MaxValue"));
                                        $(ValidationMessageFiled[i]).focus()
                                        return checkval;
                                        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                    }

                                }
                            }
                        };
                        break;

                    case "18":  //For  Value Range
                        if (ValidationMessage[i].indexOf("range") != -1) {

                            if (ValidationMessageFiled[i].indexOf("cbo") != -1) {
                                var Condition = $(ValidationMessageFiled[i]).text() <= $(ValidationMessageFiled[i]).attr("MinValue") && $(ValidationMessageFiled[i]).text() >= $(ValidationMessageFiled[i]).attr("MaxValue")
                            }
                            else {
                                var Condition = $(ValidationMessageFiled[i]).val() <= $(ValidationMessageFiled[i]).attr("MinValue") && $(ValidationMessageFiled[i]).val() >= $(ValidationMessageFiled[i]).attr("MaxValue")
                            }

                            if ($(ValidationMessageFiled[i]).text() != "0" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if ($(ValidationMessageFiled[i]).attr("range")) {
                                    if (Condition == false) {
                                        checkval = 1;
                                        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MinValue") + " - " + $(ValidationMessageFiled[i]).attr("MaxValue"));
                                        $(ValidationMessageFiled[i]).focus()
                                        return checkval;

                                    }
                                }
                            }
                        };
                        break;
                }
            }

            return checkval;
        }
        //End of added By Dipali V On 9th Aug 2019 For ValidateCustom fields


        //Function for to get the date picker on click of the textbox
        function CustomfiledDatePicker(customfileddateid) {

            var filedid = "#dt" + customfileddateid;
            $(filedid).datepicker({
                autoclose: true,
                changeMonth: true,

                //Change By Dipali V On 16th Aug 2019
                dateFormat: 'dd M yy'
                //End of Change By Dipali V On 16th Aug 2019
            });


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

        }

        //For Fill DropDown of Customer
        function GetCustomFiledComboboxValues(DatabaseFieldName, ProjectID) {
            //alert(ProjectID);
            var customFiled = { ProjectId: parseInt(ProjectID), DatabaseFieldName: DatabaseFieldName };

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetComboboxCustomFiledValues',
                method: 'Post',
                data: JSON.stringify(customFiled),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (customFiled) {
                        xhr.setRequestHeader("Params", encryptString(isJson(customFiled) ? customFiled : JSON.stringify(customFiled)));
                    }
                },
                success: function (result) {
                    var s = "";
                    s = "<option value=''></option>";
                    for (var i = 0; i < result.length; i++) {

                        var list = result[i];
                        //debugger
                        s += ('<option value=' + escape(list.FieldName) + ' >' + list.FieldName + '</option>');

                        var cboName = "#cbo" + DatabaseFieldName;



                    }
                    $(cboName).append(s);
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();

                },
                error: function (xhr, errorThrown) {
                    
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""
                }
            });

            if (DatabaseFieldName == "CustomFieldCombo2") {
                GetCustomer(ProjectID);
            }
        }

        //For Get Customer 
        function GetCustomer(ProjectId) {


            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_IssueDetails/GetCustomer',
                method: 'Post',
                data: JSON.stringify(ProjectId),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                    }

                },
                success: function (result) {


                    var objCbo1 = document.getElementById("cboCustomFieldCombo2");
                    $("#cboCustomFieldCombo2 option").remove();
                    
                    for (var i = 0; i < result.length; i++) {

                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.CustomerName;
                        objOption.value = Objresult.CustomerName;
                    }

                    //Commented By Usha Pandit On 18.03.2020 For not getting extra placeholder
                    //AppendOptioncbo("CustomFieldCombo2", "");
                    //End Of Commented By Usha Pandit On 18.03.2020 For not getting extra placeholder

                },
                error: function (xhr, errorThrown) {
                    // alert("error ");
                }
            });
        }

        //For Update Issues in Bulk
       // $("#btnUpdate").click(function () {
        $("#btnUpdate").on('click', function () {
            $('#step3 ul li').html("");
            $(".Bulkloaderimg").css("display", "block");
            var m_strType = "";
            var validateControl = ValidateControls();
            //debugger;
            //var validateControl = true;
            var condition;
            //if (strUpdateSQ1L != "" && validateControl == true) {
            //if (activerow != 0) {
            //Addded & commented By Dipali V On 8th aug 2019 for Custom Filed Validation
            //if (validateControl == true  {
            //debugger;

            //alert(strUpdateSQ1L);
            //  return;
            //START Vishal Mahajan 27-11-2019 for validate custom field 
            var count = 0;
            $.each($("#divCustomFieldCombo1").find("select,textarea,textbox"), function (index, control) {
                switch (this.type) {
                    case 'text': Trim($(this).val()) != '' ? count++ : count; break;
                    //case 'checkbox': Trim($(this).val()) != ''; break;
                    case 'select-one': (Trim($(this).val()) != '0' && Trim($(this).val()) != '') ? count++ : count; break;
                    case 'textarea': Trim($(this).val()) != '' ? count++ : count; break;
                }
            });
           //debugger;
            if (count == 0 && (!validateControl)) {
                validateControl = false;
                alertify.error('Please select at least one field');
                return;
            } else {
                validateControl = true;
            }
            //end Vishal Mahajan 27-11-2019 for validate custom field 

            if (globalCustomFiledAccess == 1) {
                condition = (validateControl == true && CustomFiledValidation() == 0)
            }
            else {
                condition = (validateControl == true)
            }
            if (condition) {
                //End of Addded & commented By Dipali V On 8th aug 2019 for Custom Filed Validation

                $("#tab2").prop("disabled", true);
                $("#tab1").prop("disabled", true);

                //$('.wizard .nav-wizard li.active').removeClass('active');
                //$(".wizard .nav-wizard li:last-child").addClass('active');
                
                //$("#step2").removeClass('active');
                //$("#step3").addClass('active');
                //Commented and added by pradip on 4-4-2023
                $(".nav.nav-wizard li:last-child").removeClass("disabled");
                $('a[href="#step3"]').tab('show');

                if (Issuecount == 1) {
                    $("#MessageUpdate").text('');
                    $("#WaitText").text('Please wait.....Updating  ');
                    $("#CountIssue").html("[" + Issuecount + "] Issue of " + selectedProjectName);
                }

                else {
                    $("#MessageUpdate").text('');
                    $("#WaitText").text('Please wait.....Updating ');
                    $("#CountIssue").html("[" + Issuecount + "] Issues of " + selectedProjectName);
                }
                for (var i = 0; i < activerow.length; i++) {

                    if ((activerow[i] == "ImportID" || activerow[i] == "CustomerIssueID") == true) {

                        var Id = "#txt" + activerow[i];
                        m_strType = $(Id).val();
                        //  m_strType = encodeURI(m_strType);
                        if (m_strType != 0) {

                            if (m_strType != "undefined" || m_strType != "") {
                                m_strType = m_strType
                            }
                            else {
                                m_strType = "";
                            }


                        } else {
                            m_strType = "";
                        }

                        //if (m_strType != "undefined" && m_strType != "") {
                        //    m_strType = m_strType
                        //}
                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)
                    } else if ((activerow[i] == "StatusChangeDate" || activerow[i] == "StatusChangeTime") == true) {
                        var Id = "#dt" + activerow[i]

                        if (activerow[i] == "StatusChangeTime") {
                            m_strType = $(Id).val();
                            m_strType = m_strType.substring(0, 5);
                        } else {
                            m_strType = $(Id).val();
                        }

                        //  m_strType = encodeURI(m_strType);
                        // alert(m_strType);

                        if (m_strType != 0) {

                            if (m_strType != "undefined" || m_strType != "") {
                                m_strType = m_strType
                            }
                            else {
                                m_strType = "";
                            }


                        } else {
                            m_strType = "";
                        }

                        //if (m_strType != "undefined" && m_strType != "") {
                        //    m_strType = m_strType
                        //}

                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)
                    }

                    else if ((activerow[i] == "ShowToCustomer") == true) {

                        var Id = "#chk" + activerow[i]

                        if ($(Id).is(':checked')) {
                            m_strType = 1;
                            //  m_strType = encodeURI(m_strType);
                            if (m_strType != "undefined" || m_strType != "") {
                                m_strType = m_strType
                            }
                        }

                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)
                    }
                    else if ((activerow[i] == "AssignTo" || activerow[i] == "ReleaseID" || activerow[i] == "IterationID" || activerow[i] == "UserStoryID" || activerow[i] == "ChangeRequestID" || activerow[i] == "CodedBy") == true) {
                        var Id = "#cbo" + activerow[i]

                        m_strType = $(Id).val();
                        //  m_strType = encodeURI(m_strType);
                        if (m_strType != 0) {

                            if (m_strType != "undefined" || m_strType != "") {
                                m_strType = m_strType
                            }
                            else {
                                m_strType = "";
                            }


                        } else {
                            m_strType = "";
                        }

                        //if (m_strType != "undefined" && m_strType != "") {
                        //    m_strType = m_strType
                        //}

                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)

                    } else if ((activerow[i] == "CustomFieldDate1" || activerow[i] == "CustomFieldDate2" || activerow[i] == "CustomFieldDate3" || activerow[i] == "CustomFieldDate4" || activerow[i] == "CustomFieldDate5") == true) {
                        var Id = "#dt" + activerow[i]

                        m_strType = $(Id).val();
                        // m_strType = encodeURI(m_strType);
                        if (m_strType != 0) {

                            if (m_strType != "undefined" || m_strType != "") {
                                m_strType = m_strType
                            }
                            else {
                                m_strType = "";
                            }


                        } else {
                            m_strType = "";
                        }

                        //if (m_strType != "undefined" && m_strType != "") {
                        //    m_strType = m_strType
                        //}

                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)

                    } else if ((activerow[i] == "CustomFieldText1" || activerow[i] == "CustomFieldText2" || activerow[i] == "CustomFieldText3" || activerow[i] == "CustomFieldText4" || activerow[i] == "CustomFieldText5" || activerow[i] == "CustomFieldText6" || activerow[i] == "CustomFieldText7" ||
                        activerow[i] == "CustomFieldText8" || activerow[i] == "CustomFieldText9" || activerow[i] == "CustomFieldText10" || activerow[i] == "CustomFieldTextArea1" || activerow[i] == "CustomFieldTextArea2" ||
                        activerow[i] == "CustomFieldTextArea3") == true) {


                        //m_strType = $(Id + " option:selected").text();
                        //debugger;
                        if (activerow[i].indexOf('CustomFieldTextArea') !== -1) {
                            var Id = "#txtext" + activerow[i]
                            m_strType = $(Id).val();

                        }
                        else if (activerow[i].indexOf("Text") !== -1) {
                            var Id = "#txt" + activerow[i]
                            // if ($(activerow[i]).indexOf('Text') > -1) {
                            m_strType = $(Id).val();

                        }


                        // m_strType = encodeURI(m_strType);
                        //if (m_strType != 0) {

                        if (m_strType != "undefined" || m_strType != "") {
                            m_strType = m_strType
                        }
                        else {
                            m_strType = "";
                        }


                        //} else {
                        //    m_strType = "";
                        //}

                        //if (m_strType != "undefined" && m_strType != "") {
                        //    m_strType = m_strType
                        //}
                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)
                    } else if ((activerow[i] == "CustomFieldCombo1" || activerow[i] == "CustomFieldCombo2" || activerow[i] == "CustomFieldCombo3" || activerow[i] == "CustomFieldCombo4" || activerow[i] == "CustomFieldCombo5" || activerow[i] == "CustomFieldCombo6" || activerow[i] == "CustomFieldCombo7" || activerow[i] == "CustomFieldCombo8" || activerow[i] == "CustomFieldCombo9" || activerow[i] == "CustomFieldCombo10" == true)) {
                        var Id = "#cbo" + activerow[i]

                        //m_strType = $(Id + " option:selected").text();
                        m_strType = $(Id).val();
                        //    m_strType = encodeURI(m_strType);
                        //if (m_strType != 0) {
                        m_strType = unescape(m_strType);
                        if (m_strType != "undefined" || m_strType != "") {
                            m_strType = m_strType
                        }
                        else {
                            m_strType = "";
                        }


                        //} else {
                        //    m_strType = "";
                        //}

                        //if (m_strType != "undefined" && m_strType != "") {
                        //    m_strType = m_strType
                        //}
                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)
                    }

                    else {

                        var Id = "#cbo" + activerow[i]

                        m_strType = $(Id + " option:selected").text();
                        m_strType = $(Id).val();
                        //  m_strType = encodeURI(m_strType);
                        if (m_strType != 0) {
                            //alert(m_strType);
                            if (m_strType != "undefined" && m_strType != "" && m_strType != null) {
                                m_strType = m_strType
                            }
                            else {
                                m_strType = "";
                            }


                        } else {
                            m_strType = "";
                        }

                        //if (m_strType != "undefined" && m_strType != "" && m_strType != null) {
                        //    m_strType = m_strType
                        //}


                        BuildUpdateQuery(activerow[i], m_strType, strUpdateSQ1L)

                    }
                }
                setTimeout(function () {
                    $("#tab1").prop('disabled', true);
                    $("#tab2").prop('disabled', true);
                    BulkUpdateIssue(issueIDs, selectedProjectID, UserName, RoleId, strUpdateSQ1L)
                }, 5000);

            }

        });
        //End of For Update Issues in Bulk



        ////this function used for ploating extended custom control like  Department,Date etc (Remove Right now)
        function PloatExtendedCustomFields(commonProperty) {
            var strHTML = "";

            //var commonProp = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType };
            var customFiled = { commonProperty: commonProperty };
            //alert(newIssue);
            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/PloatExtendedCustomFileds',
                method: 'Post',
                data: JSON.stringify(customFiled),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (customFiled) {
                        xhr.setRequestHeader("Params", encryptString(isJson(customFiled) ? customFiled : JSON.stringify(customFiled)));
                    }
                },
                success: function (result) {
                    // debugger
                    $("#ExtendedCustomFiledsControl").html("");
                    if (result.length == 0) {
                        strHTML = "";
                        strHTML += "<label class='control-label'> No extended custom fields have been defined for this project.  </label>";
                        $("#ExtendedCustomFiledsControl").append(strHTML);
                    }


                    for (var i = 0; i < result.length; i++) {
                        var CustomFiledObj = result[i];
                        strHTML = "";
                        //strHTML += "<div class='form-group'>"
                        //strHTML += " <div class='row'>"


                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldCombo") !== -1) {
                            // strHTML = "";
                            //strHTML += "<div class='form-group'>"
                            strHTML += "<div class='col-md-6' id='divext" + CustomFiledObj.DatabaseFieldName + "'>" +
                                "<label class='control-label col-sm-4' id='lblext" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " : </label>";
                            if (CustomFiledObj.IsCustomFieldAssigned == "0") {
                                strHTML += "<div class='col-sm-8'><select class='form-control ' id='cboext" + CustomFiledObj.DatabaseFieldName + "' style='width:160px' >" +
                                    "</select> </div>";
                            }
                            else {

                                strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                            }
                            strHTML += "</div>";
                            $("#ExtendedCustomFiledsControl").append(strHTML);
                            // $("#ExtendedCustomFiledsControl").append("</br>");

                            var fieldid = "#cboext" + CustomFiledObj.DatabaseFieldName;
                            if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                                $("select" + fieldid + "option:contains(" + CustomFiledObj.DefaultValue + ")").attr('selected', 'selected');

                                //$('select'+ fieldid + 'option:contains'+ CustomFiledObj.DefaultValue).prop('selected',true);

                            }
                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                            }

                            var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;
                            var Mandatory = CustomFiledObj.ValidationRules;

                            if (Mandatory == "1,") {
                                ////create custom madatory id 
                                var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                                var mandatoryid = "#" + requeridId;
                                if ($(mandatoryid).length > 0) {

                                } else {
                                    var lblval = "<span id=" + requeridId + "  style='color:red;'>*</span>";
                                    $(lblId).append(lblval);
                                }
                            }
                            GetExtendedCustomFieldComboboxValues(CustomFiledObj.DatabaseFieldName, selectedProjectID);
                        }

                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldText") !== -1) {
                            strHTML = "";
                            strHTML += "<div class='col-md-6' id='divext" + CustomFiledObj.DatabaseFieldName + "'>" +
                                "<label class='control-label col-sm-4' id='lblext" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " : </label>"

                            if (CustomFiledObj.DatabaseFieldName.indexOf("Area") !== -1) {
                                if (CustomFiledObj.IsCustomFieldAssigned == "0") {

                                    strHTML += "<textarea rows='3' cols='25' id='txtext" + CustomFiledObj.DatabaseFieldName + "'>" +
                                        "</textarea>";
                                }
                                else {
                                    strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                                }
                            }
                            else {
                                if (CustomFiledObj.IsCustomFieldAssigned == "0") {
                                    strHTML += "<input type='text' class='form-control' id='txtext" + CustomFiledObj.DatabaseFieldName + "' style='width:160px' value=" + CustomFiledObj.DefaultValue + ">";
                                }
                                else {
                                    strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";

                                }
                            }

                            strHTML += "</div>";

                            $("#ExtendedCustomFiledsControl").append(strHTML);
                            // $("#ExtendedCustomFiledsControl").append("</br>");



                            var fieldid = "#txtext" + CustomFiledObj.DatabaseFieldName;
                            if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                                $(fieldid).html(CustomFiledObj.DefaultValue);
                            }

                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;

                            if (CustomFiledObj.ValidationRules != 0) {
                                SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                            }

                            var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;
                            var Mandatory = CustomFiledObj.ValidationRules;

                            if (Mandatory == "1,") {

                                ////create custom madatory id 
                                var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                                var mandatoryid = "#" + requeridId;
                                if ($(mandatoryid).length > 0) {

                                } else {
                                    var lblval = "<span id=" + requeridId + "  style='color:red;'>*</span>";
                                    $(lblId).append(lblval);
                                }
                            }
                            continue;

                        }

                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldDate") !== -1) {
                            strHTML = "";
                            strHTML += "<div class='col-md-6' id='divext" + CustomFiledObj.DatabaseFieldName + "'>" +
                                "<label class='control-label col-sm-4' id='lblext" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + ":</label>";
                            if (CustomFiledObj.IsCustomFieldAssigned == "0") {
                                strHTML += "<input type='text' class='form-control' id='dtext" + CustomFiledObj.DatabaseFieldName + "' style='width:160px;margin-left:37%;'>";
                            }
                            else {
                                strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                            }
                            strHTML += "</div>";
                            $("#ExtendedCustomFiledsControl").append(strHTML);
                            // $("#ExtendedCustomFiledsControl").append("</br>");


                            var fieldid = "#dtext" + CustomFiledObj.DatabaseFieldName;
                            if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                                $(fieldid).html(CustomFiledObj.DefaultValue);
                            }

                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                            }

                            var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;
                            var Mandatory = CustomFiledObj.ValidationRules;

                            if (Mandatory == "1,") {
                                ////create custom madatory id 
                                var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                                var mandatoryid = "#" + requeridId;
                                if ($(mandatoryid).length > 0) {

                                } else {
                                    var lblval = "<span id=" + requeridId + "  style='color:red;'>*</span>";
                                    $(lblId).append(lblval);
                                }
                            }


                            var ExtendedCustomFieldDate = "ext" + CustomFiledObj.DatabaseFieldName;
                            CustomfiledDatePicker(ExtendedCustomFieldDate);
                            continue;
                        }
                    }
                }
            });
        }


        //This function gets the values  for  the all the extended custom field dropdowns and binds to it.
        function GetExtendedCustomFieldComboboxValues(DatabaseFieldName, ProjectID) {
            var commonProp = { ProjectId: parseInt(ProjectID) };

            var customFiled = { commonProperty: commonProp, DatabaseFieldName: DatabaseFieldName };

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetExtendedCustomFieldComboboxValues',
                method: 'Post',
                data: JSON.stringify(customFiled),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (customFiled) {
                        xhr.setRequestHeader("Params", encryptString(isJson(customFiled) ? customFiled : JSON.stringify(customFiled)));
                    }

                },
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {

                        var list = result[i];

                        var s = ('<option value=' + list.UniqueID + ' >' + list.FieldName + '</option>');

                        var cboName = "#cboext" + DatabaseFieldName;

                        $(cboName).append(s);

                    }

                    var ExtenededCustomFieldName = "ext" + DatabaseFieldName;
                    AppendOptioncbo(ExtenededCustomFieldName, "");

                },
                error: function (xhr, errorThrown) {
                    // alert("error ");
                }
            });
        }


        // SELECTED CHECKBOX COUNT
        function Nextbtn1_click() {
            // debugger;
            try {
                StartLoader("#bodyBulkUpdate");
                //For Placeholder to Dropdown

            GetProjectControlPloating(selectedProjectID, commonProperty);
            //var cboId = ["ReportedBy", "Type", "SubType", "Status", "IterationID", "UserStoryID", "ReleaseID", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestID", "CodedBy", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "AssignTo"]
            //for (var i = 0; i < cboId.length; i++) {
            //    AppendOptioncbo(cboId[i].toString());
            // }

            PloatCustomFields(commonProperty);

            //End of  Placeholder to Dropdown
            $('#dtStatusChangeDate').datepicker({ dateFormat: 'd M yy' });

            // $('#dtStatusChangeDate').datepicker('setDate', new Date());

            $('#dtStatusChangeTime').datetimepicker({
                // defaultDate: new Date(),
                format: 'LT',
                //Added by Gauri On 10/10/2024 to fix up-down arrow issues on Bulk Update page for StatusChangeTime control
                icons: {
                    up: 'fa fa-chevron-up',
                    down: 'fa fa-chevron-down',
                }
                 //End of Added by Gauri On 10/10/2024 to fix up-down arrow issues on Bulk Update page for StatusChangeTime control
            });

            // $('#dtReportedDate').datepicker({ dateFormat: 'd M yy' });

            //$('#dtReportedTime').datetimepicker({
            //    defaultDate: new Date(),
            //    format: 'LT'
            //});

                Pagination();
                // debugger;
                //Apply_Onclick();
                //Added by Dipali For Set height Dynamically
                SetWindowHeight();
                var table = $('#bulkupdatetbl').DataTable();
                Issuecount = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length; // Convert to a jQuery object
                if (Issuecount == 0) {
                    Apply_Onclick();
                }
                var ReleaseID = $("#cboReleaseID").val();
                Type_OnChangeRelease(ReleaseID);
                var TypeID = $("#cboType").val();
                //$("#cboReportedBy").val(UserName);
                Type_OnChange(TypeID);
                strUpdateSQL = "";
                strUpdateSQ1L = "";
                //alert(Issuecount)
                StopAjaxLoader("#bodyBulkUpdate");
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        //This procedure Builds the Update query depending upon the value of the Field.
        function BuildUpdateQuery(strFieldName, strFieldValue, strUpdateSQL) {
            strUpdateSQ1L = "";

            //Added By Usha Pandit On 25.01.2021 For passing correct value for ShowToCustomer field
            if (strFieldName == "ShowToCustomer") {
                if ($("#chkShowToCustomer").is(':checked') == true) {
                    strFieldValue = 1;
                }
                else {
                    strFieldValue = 0;
                }
            }
            //End Of Added By Usha Pandit On 25.01.2021 For passing correct value for ShowToCustomer field
            if (strFieldValue != "") {
                var strStringToAppend = ","
            }
            else {
                var strStringToAppend = ""
            }

            if (strUpdateSQL != "") {
                strUpdateSQL += strStringToAppend
            }
            else {
                strUpdateSQL = strUpdateSQL
            }

            if (strFieldValue != "") {
                //Commented And Added By Usha Pandit On 05.05.2021 For crash due to single quote
                //strUpdateSQL += strFieldName + " = ''" + strFieldValue + "''";
                strUpdateSQL += strFieldName + " = ''" + strFieldValue.toString().replace(/\'/g, "''''") + "''";
                //Added By Usha Pandit On 26.05.2021 For update Corporate Status as well on bulk Update
                if (strFieldName == "Status") {
                    strUpdateSQL += "," + "CorporateStatus" + " = ''" + strFieldValue.toString().replace(/\'/g, "''''") + "''";
                }
                //End Of Added By Usha Pandit On 26.05.2021 For update Corporate Status as well on bulk Update
                //Added By Usha Pandit On 27.05.2021 For update Corporate Type as well on bulk Update
                if (strFieldName == "Type") {
                    strUpdateSQL += "," + "CorporateType" + " = ''" + strFieldValue.toString().replace(/\'/g, "''''") + "''";
                }
                //End Of Added By Usha Pandit On 27.05.2021 For update Corporate Type as well on bulk Update
                //Added By Usha Pandit On 27.05.2021 For update Corporate SubType as well on bulk Update
                if (strFieldName == "SubType") {
                    strUpdateSQL += "," + "CorporateSubType" + " = ''" + strFieldValue.toString().replace(/\'/g, "''''") + "''";
                }
                //End Of Added By Usha Pandit On 27.05.2021 For update Corporate SubType as well on bulk Update
                //End Of Added By Usha Pandit On 05.05.2021 For crash due to single quote                
            }
            strUpdateSQ1L = strUpdateSQL;
            // alert(strUpdateSQ1L);
            //alert(strUpdateSQL);
            //return;

        }

        //Update the Value in selected fields
        function BulkUpdateIssue(IssueIDs, ProjectID, UserName, RoleId, strUpdateSQL) {
            //alert(strUpdateSQL)
            // return;
            var UpdatedField = { IssueID: IssueIDs, ProjectId: parseInt(ProjectID), UserName: encodeURI(UserName), RoleId: parseInt(RoleId), strUpdateSQL: encodeURI(strUpdateSQL) };
            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/UpdateFields',
                method: 'Post',
                data: JSON.stringify(UpdatedField),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (UpdatedField) {
                        xhr.setRequestHeader("Params", encryptString(isJson(UpdatedField) ? UpdatedField : JSON.stringify(UpdatedField)));
                    }

                },
                success: function (result) {
                    setTimeout(function () {
                        $(".Bulkloaderimg").css("display", "none");
                        if (result != "") {
                            alertify.success(result);
                        }



                        if (Issuecount == 1) {
                            $("#CountIssue").text('');
                            $("#WaitText").text('');
                            $("#MessageUpdate").html('Updated [' + Issuecount + '] Issue Successfully');

                        }
                        else {
                            $("#CountIssue").text('');
                            $("#WaitText").text('');
                            $("#MessageUpdate").html('Updated [' + Issuecount + '] Issues Successfully');

                        }
                        //Added By Swapnagandha K. For Issue add back button On 18 Oct 2019 
                        $('#step3 ul li').html('<a href="javascript:;" onclick="backlink()" type="button" class="btn borderbtn ml-1 " style="margin-right: 10px;">Back</a><a class="gofirst btn borderbtn" href="step1" data-bs-toggle="tab" onclick="Load_Page()">Add More</a> ');
                        //Added By Swapnagandha K. For Issue add back button On 18 Oct 2019 
                    }, 3000);

                },
                error: function (xhr, errorThrown) {
                    alertify.error("Something went to wronge..Please try again");
                }
            });
        }

        //Addded By Dipali V On 9th aug 2019 for redircet from last to one then clear all data

        //End of Addded By Dipali V On 9th aug 2019 for redircet from last to one then clear all data
        function Load_Page() {
            $(document).on("click", ".gofirst", function () {


                //$('.wizard .nav-wizard li.active').removeClass('active');
                //$("ul.nav-wizard li:first-child").addClass("active");
                //$("#step3").removeClass("active");
                //$("#step1").addClass("active");
                $('a[href="#step1"]').tab('show');


                var table = $('#bulkupdatetbl').DataTable();
                var rows = table.rows({ 'search': 'applied' }).nodes();
                if ($("#selectcopyissueall").prop("checked") == true) {
                    $('input[name=checkIssue]:checked', rows).each(function () {
                        this.checked = false;
                    });

                }

                var table1 = $("#bulkupdatetbl").DataTable();
                table1.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').prop('checked', false);

                $(".chckHead").prop("checked", false);
                Issuecount = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length; // Convert to a jQuery object
                if (Issuecount == 0) {
                    Apply_Onclick();
                }
                //$('#dtReportedTime').datetimepicker({
                //    defaultDate: new Date(),
                //    format: 'LT'
                //});

            });

        }


        function formatAMPM(date) {
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var ampm = hours >= 12 ? 'pm' : 'am';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return strTime;
        }

        var inputArray = [];
        //Validate Controls before Copying Issues
        function ValidateControls() {
            //debugger;
            var IsBlank = 0;
            var FLAG = 0;
            var Isblankcount = 0;
            // var arrIsBlank = ""
            var arrIsBlank = new Array();
            cboId = ["Type", "SubType", "Status", "IterationID", "UserStoryID", "ReleaseID", "ReportedBy", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestID", "CodedBy", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "AssignTo", "CustomFieldCombo3", "CustomFieldCombo5", "CustomFieldCombo2","ImportID","CustomerIssueID"]
           
            for (var i = 0; i < cboId.length; i++) {
               // debugger;
                //Added By Dipali V On 16th April 2020 Issue ID 23285
              //Added By Dipali V On 14th May 2020 For 242308 
                if (cboId[i].indexOf("CustomerIssueID") != -1 || cboId[i].indexOf("ImportID") != -1) {
                    if ($("#txt" + cboId[i]).val()) {
                        if ($("#txt" + cboId[i]).val() == "") {
                            //alertify.error('Please select at least one field');
                            IsBlank = 1;
                            arrIsBlank.push(IsBlank);
                            Isblankcount = arrIsBlank.length;
                            //return false;

                        } else {
                            IsBlank = 0;
                            arrIsBlank.push(IsBlank);
                        }
                    } else {

                         IsBlank = 1;
                        arrIsBlank.push(IsBlank);
                        Isblankcount = arrIsBlank.length;

                    }
                    //Added By Dipali V On 14th May 2020 For 242308

                     //End of Added By Dipali V On 16th April 2020 Issue ID 23285
                }
                else {
                    if ($("#cbo" + cboId[i]).val() != undefined) {
                        //if (cboId[i].indexOf('ReportedBy') != 0)
                        //{

                        if ($("#cbo" + cboId[i]).val() == "0")//&& $("#cboReportedBy").val() != "0"
                        {
                            //alertify.error('Please select at least one field');
                            IsBlank = 1;
                            arrIsBlank.push(IsBlank);
                            Isblankcount = arrIsBlank.length;
                            //return false;

                        } else {
                            IsBlank = 0;
                            arrIsBlank.push(IsBlank);
                        }
                        // }

                    }
                }

                //}
            }
            //alert(arrIsBlank.length)
            for (var i = 0; i < arrIsBlank.length; i++) {
               // debugger;
                if (arrIsBlank[i] == 0) {
                    return true;
                }
                else {
                    FLAG = 1;
                    //alertify.error('Please select at least one field');
                    //return false;
                }
            }

            if (FLAG == 1) {
                //alertify.error('Please select at least one field');
                return false;
            } else {
                return true;
            }

            //return true;
            // $('#controlploat').find("select").each(function () {
            //var cntrlId = $(this).attr('id');
            //inputArray.push($("#" + cntrlId + "").val().trim());
            //});

            //for (i = 0; i < inputArray.length; i++) {
            //    if (inputArray[i] == "0") {
            //        alertify.error('Please select at least one field');
            //        //document.getElementById("dtReportedDate").focus();
            //        return false;

            //    }
            //     return true;
            //}


            //var today = new Date();
            // var CurrentDate = (getTodayDate(today));
            //$('#dtReportedTime').datetimepicker({
            //    defaultDate: new Date(),
            //    format: 'LT'
            //});

            //var ReportedDate = $("#dtReportedDate").val();

            //var ReportedTime = $("#dtReportedTime").val();
            //ReportedTime = ReportedTime.substring(0, 5);
            //var currentdate = new Date();
            ////var CurrentTime = + currentdate.getHours() + ":" + currentdate.getMinutes()
            //var CurrentTime = formatAMPM(currentdate)
            //CurrentTime = CurrentTime.substring(0, 5);

            //// CurrentTime = CurrentTime.toLocaleString([], { hour12: true});
            ////alert(CurrentTime);
            ////alert(ReportedTime);

            //if ((ReportedDate == "") && (ReportedDate == 0)) {
            //    alertify.error('Reported Date should not be left blank.');
            //    document.getElementById("dtReportedDate").focus();
            //    return false;
            //}
            //if ((ReportedTime == "") && (ReportedTime == 0)) {
            //    alertify.error('Reported Time should not be left blank.');
            //    //var Id = "#dtReportedTime"
            //    //var m_strType = $("#dtReportedTime").val();
            //    document.getElementById("dtReportedTime").focus();

            //    return false;
            //}

            //if (ReportedDate != null) {

            //    var ValMessage = ValidateDate(selectedProjectID, ReportedDate);
            //    if (ValMessage == false) {
            //        document.getElementById("dtReportedDate").focus();
            //        return false;
            //    }


            //}
            //// debugger;

            //if (ReportedTime > CurrentTime) {
            //    alertify.error('Reported Time should not be greater than Current Time.');
            //    document.getElementById("dtReportedTime").focus();
            //    return false;
            //}



        }

        //For Date Validate
        function ValidateDate(ProjectID, ReportedDate) {

            var Parameters = { ProjectId: parseInt(ProjectID), ReportedDate: ReportedDate };
            var flag = true;
            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/ValidateDate',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (result) {
                    //debugger;
                    if (result != "" && result != null) {
                        alertify.error(result);
                        flag = false;
                    }
                    //else if (result == null) {
                    //    flag = true;
                    //}
                    else {
                        flag = true;
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""

                }
            });
            return flag;
        }

        //For How may records should display for that 
        function GetMaximumItemsToShow() {

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_BulkUpdate/GetMaximumItemsToShowInList',
                method: 'Post',
                data: {},
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {

                    pageLength = result;

                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + ""

                }


            });
        }
        //Function for Pagination 

        //For Datatable
        function Pagination() {
            $('#bulkupdatetbl').dataTable({
                "pageLength": pageLength,
                "lengthChange": false,
                "bFilter": false,
               // "bAutoWidth":true,
                //"scrollX": true,
                "retrieve": true,
                //"fixedHeader": true,
                "scrollY": "auto",
                "ordering": true,
                "sScrollX": true,
                "sScrollInnerX": "110%",
                "sScrollCollapse": true,
                "responsive": true
            });
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        }


        //Addded By Dipali V On 7th aug 2019 for height calculation
        function SetWindowHeight() {
            //debugger;
            var height = $(window).height();
            $(".dataTables_scrollBody").css("height", height - 370);

             var height = $(window).height();
            $(".wizard").css("height", height - 72);
        }
        //End of Addded By Dipali V On 7th aug 2019 for height calculation 
        $(window).on("load resize scroll", function (e) {
            SetWindowHeight(this);
        });

        function DeleteRow() {

            if ($.trim($('.form-group').text()).length == 0) {
                if ($('.form-group').children().length == 0) {
                    //$(form-group).text('');
                    $('.form-group').remove(); // remove empty paragraphs
                }
            }
        }

        //For Placeholder
        function AppendOptioncbo(FieldName, CaptionName) {
            //var cboId = ["ReportedBy", "Type", "SubType", "Status", "Release", "Iteration", "UserStory", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "AssignToName", "CustomFieldCombo1"];
            //var s = '<option value=0>--select Type-- </option>'; 
            //$('#cboType').append(s);
            // debugger;
            var id;
            if (FieldName.indexOf("CustomFieldCombo") > -1) {


                id = "cbo" + FieldName //.substr(0, FieldName.indexOf(","));
                FieldName = CaptionName;
            }
            else {
                id = "cbo" + FieldName;
                FieldName = CaptionName;
            }
            //var s = "Type";
            if (FieldName == "DeliverableID") {
                FieldName = "Deliverables";
            } else if (FieldName == "ReleaseID") {
                FieldName = "Release";

            } else if (FieldName == "RootCauseID") {
                FieldName = "Root Cause";

            } else if (FieldName == "ModuleName") {
                FieldName = "Module Name";

            } else if (FieldName == "ChangeRequestID") {
                FieldName = "Change Request Name";

            } else if (FieldName == "CodedBy") {
                FieldName = "Coded By";

            } else if (FieldName == "ReportedInVersion") {
                FieldName = "Reported In Version";

            } else if (FieldName == "CorrectedInVersion") {
                FieldName = "Corrected In Version";

            } else if (FieldName == "FoundInPhase") {
                FieldName = "Found In Phase";

            } else if (FieldName == "FixedInPhase") {
                FieldName = "Fixed In Phase";

            } else if (FieldName == "AssignTo") {
                FieldName = "Responsible Person";

            } else if (FieldName == "IterationID") {
                FieldName = "Sprint";

            } else if (FieldName == "UserStoryID") {
                FieldName = "User Story";

            } else if (FieldName.indexOf("CustomFieldCombo") > -1) {
                FieldName = FieldName //.substr(FieldName.indexOf(",") + 1, FieldName.length);

            }
            else if (FieldName == "Phase") {
                FieldName = " Source Phase";
            }

            else if (FieldName == "Filter") {
                FieldName = "Filter";
            }

            else if (FieldName == "ReportedBy") {
                FieldName = "Reported By";
            }


            var textval = "Select " + FieldName + "";
            if (document.getElementById(id) != null) {
                document.getElementById(id).insertBefore(new Option(textval, '0'), document.getElementById(id).firstChild);

                $("#" + id + " option[value=0]").prop('selected', true);
            }
        }

        //Function For Getting The Todays Date
        function getTodayDate(today) {

            var month_names = ["Jan", "Feb", "Mar",
                "Apr", "May", "Jun",
                "Jul", "Aug", "Sep",
                "Oct", "Nov", "Dec"];

            var day = today.getDate();
            var month_index = today.getMonth();
            var year = today.getFullYear();

            return "" + day + "/" + month_names[month_index] + "/" + year;
        }

        //For Back Link 
        function backlink() {
            StartLoader("#bodyBulkUpdate");
            var A = $(parent.document.getElementById('mainHeadingTop'));
            A.text("");
            A.text("Issues >  Issues");
            //Added by Swapnagandha K. for Session Project Issue On 18-Oct-2019
            window.location.href = "IssueList.aspx?FromWhere=Issue&View=" + viewApplied + "&ViewType=" + '<%= Request.QueryString("ViewType")%>' + "";
            //EndAdded by Swapnagandha K. for Session Project Issue On 18-Oct-2019
            // StopAjaxLoader("#bodyBulkUpdate");
        }
        //Added By Usha Pandit On 17.03.2020 For extracting correct time
        function convertTo12Hour(time24) {
            var ts = new Date(time24);
            var hours = ts.getHours();
            var minutes = ts.getMinutes();
            var newformat = hours >= 12 ? 'PM' : 'AM';
            // Find current hour in AM-PM Format 
            hours = hours % 12;
            // To display "0" as "12" 
            hours = hours ? hours : 12;
            minutes = minutes < 10 ? '0' + minutes : minutes;
            return hours + ':' + minutes + ' ' + newformat;
        }
        //End Of Added By Usha Pandit On 17.03.2020 For extracting correct time
        //Added By dipali vekhande on 3rd Sep 2019 for Status onchange Status date & Time should change
        function Status_OnChange() {

            $.ajax({
                url: encodeURI(strUrl) + '/api/IB_AddNewIssue/GetCurrentDateTime',
                type: 'GET',
                //  data: JSON.stringify(ProjectId),
                dataType: 'json',
                //contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                    var d = new Date();
                    var dt = d.getDate() + " " + months[d.getMonth()] + " " + d.getFullYear();

                    var objStatusTime = document.getElementById('dtStatusChangeTime');
                    var objStatusDate = document.getElementById('dtStatusChangeDate');

                    var objCurrentDate = dt;
                    var objCurrentTime = result[1];
                    //Added By Usha Pandit On 17.03.2020 For extracting correct time
                    objCurrentTime = convertTo12Hour(result[1])
                    //End Of Added By Usha Pandit On 17.03.2020 For extracting correct time
                    if (objStatusDate != null && objStatusTime != null) {
                        if ($("#cboStatus").val() != "" || $("#cboStatus").val() != "0") {
                            objStatusDate.value = objCurrentDate;
                            objStatusTime.value = objCurrentTime;
                            $('#dtStatusChangeTime').datetimepicker({

                                defaultDate: objCurrentTime,
                                format: 'LT',
                                //Added by Gauri On 10/10/2024 to fix up-down arrow issues on Bulk Update page for StatusChangeTime control
                                icons: {
                                    up: 'fa fa-chevron-up',
                                    down: 'fa fa-chevron-down',
                                }
                                //End of Added by Gauri On 10/10/2024 to fix up-down arrow issues on Bulk Update page for StatusChangeTime control
                            });
                            $('#dtStatusChangeTime').change();
                        } else {
                            //Added By Dipali V On 17th April 2020 For 17th April 2020 For Clear Status & Status Date should be clear
                            $('#dtStatusChangeTime').val('');
                            $('#dtStatusChangeDate').val('');
                            //objStatusDate.value('');
                            //objStatusTime.value('');
                            //End of Added By Dipali V On 17th April 2020 For 17th April 2020 For Clear Status & Status Date should be clear


                        }

                    }

                },
                error: function (xhr, errorThrown) {

                }
            });



        }

        //added By dipali V On 10th oct 2019 For Select all check issue
        function Selectall() {
            // alert();
            $('#bulkupdatetbl_wrapper input[type="checkbox"]').each(function () {
                // debugger;
                if ($(this).prop("checked") == true) {
                    $("#tab2").removeAttr("disabled");
                    $("#tab2").attr("data-bs-toggle", "tab")
                    return false;
                }
                else {
                    //$("#chkIssueListAll").prop("checked", false);

                    $("#tab2").attr("disabled", "disabled")
                    $("#tab2").removeAttr("data-bs-toggle")
                    // return false;
                }
            });

        }

        //End of added By dipali V On 10th oct 2019 For Select all check issue

        //End of Added By dipali vekhande on 3rd Sep 2019 for Status onchange Status date & Time should change

        //Script added by Pradip p on 2-9-2020
        function resizeSection() {

            var tblheight = $(window).height();
            $('.content').css({ 'height': tblheight - 10, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });

        //Added By Rutuja D. On 15 Jan 2021 for restricting alphabates for Duplicate Issue ID And Import ID
        function restrictAlphabets(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        //End Of Added By Rutuja D. On 15 Jan 2021 for restricting alphabates for Duplicate Issue ID And Import ID

    </script>




    <%--End back Button--%>
</body>

</html>



