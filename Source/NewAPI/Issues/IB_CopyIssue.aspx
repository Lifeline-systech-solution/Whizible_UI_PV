<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IB_CopyIssue.aspx.vb" Inherits="PbNIT.IB_CopyIssue" %>

<!DOCTYPE html>

<html>
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
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_issues.css?v=2.7">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css?v=2.8" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css">--%>

</head>

     <style type="text/css">
        #copywizardtbl_wrapper > div:first-child {
            display: none;
        }

        #copywizardtbl_wrapper > .row > div.col-sm-6 {
            display: none;
        }

        #toProject {
            margin-left: 5px; /*modified by pradip on 14-10-2020*/
        }
       
        #SessionProject, #SessionProjectTAB2, #SessionProjectTAB3 {
            font-weight: 500 !important;
        }

        #CboResponsiblePerson {
            width: 200px !important;
        }

        .gofirst {
            height: 30px !important;
        }

        #copywizardtbl_paginate, #copywizardtbl_info {
            margin-top: 18px;
        }

        input#dtReportedDate, #dtReportedTime {
            width: 130px !important;
        }

        #issuelist tr td {
            word-wrap: break-word !important;
        }


        /*#copywizardtbl tr td {*/
            /*word-break: break-all;*/
            /*min-width: 100px;
        }*/ /*Commented ruby pradip p content 31-3-2023*/

        .tooltip-inner {
            word-wrap: break-word;
            white-space: pre-line;

           max-width:100%!important;
        }

        /*cOMMENTED & Addded By Dipali V On 21st May 2020 For Issue ID-23588*/
        /*//.large.tooltip-inner {*/
            /*Commented And Added By Usha Pandit On 13.04.2020 For long tooltip issue */
            /*max-width: 550px;
            width: 550px;*/
            /*/*max-width: 550px!important;
            width: auto;
            min-width:200px; 
            /*End Of AddedBy Usha Pandit On 13.04.2020 For long tooltip issue */
            /*max-height: 550px !important;
            height: auto !important;
            margin-top: 100px !important;
            word-break: break-all !important;*/            
        /*}*/
        /*End of cOMMENTED & Addded By Dipali V On 21st May 2020 For Issue ID-23588*/

         /*css added by pradip on 11-12-2019*/
#copywizardtbl tr td:not(:last-child) {text-align: left;}
.table tr th:not(:last-child) {text-align: left!important;}
.wizard {min-height:auto;}
 


.tooltip-inner {
    max-width: 100% !important;
}

       /*Added By Dipali V On 13th Feb 2021 For Aligment Issue*/
        .form-control {
            width:160px!important
        }
   /*End of Added By Dipali V On 13th Feb 2021 For Aligment Issue*/


   /*.show{display:revert!important}*/
   .wizardformbody .col-md-4{display:inline-flex}

   /*added by ashwini M. on 23-3-2023*/
  /* #copywizardtbl_wrapper .dataTables_scrollHeadInner, #copywizardtbl_wrapper table {width:100%!important}*/
   /*End Of added by ashwini M. On 23-3-2023*/


ul.nav-wizard li a.active, ul.nav-wizard li a:active, ul.nav-wizard li a.active:visited, ul.nav-wizard li a.active:focus {
    color: #ffffff;
    background: #1359a6;
}

.nav-wizard li.disabled{ cursor:not-allowed;}
.nav-wizard li.disabled a{ pointer-events:none;}
ul.nav-wizard li a.active:after {
    border-left: 16px solid #1359a6;
}
ul.nav-wizard li{ padding:0;}
ul.nav-wizard li a{ padding:0 20px 0 30px;}

ul.nav-wizard li::after, ul.nav-wizard li::before{ display:none;}

ul.nav-wizard li a::before {
    position: absolute;
    display: block;
    border-width: 24px 0px 24px 16px;
    border-top-style: solid;
    border-bottom-style: solid;
    border-top-color: transparent;
    border-bottom-color: transparent;
    border-image: initial;
    border-left-style: solid;
    border-left-color: rgb(255, 255, 255);
    border-right-style: initial;
    border-right-color: initial;
    top: -1px;
    z-index: 10;
    content: "";
    right: -16px;
}

body ul.nav-wizard li a:after {
    
        position: absolute;
    display: block;
    border: 24px solid transparent;
    border-left: 16px solid #999!important;
    border-right: 0;
    top: -1px;
    z-index: 10;
    content: '';
    right: -15px;
}
ul.nav-wizard li a.active:after {
    border-left: 16px solid #1359a6!important;
}
 ul.nav-wizard .active ~ li a:after {
            border-left: 16px solid #999
        }
 ul.nav-wizard li a.active::before {
    border-left: 16px solid #1359a6!important;
}
ul.nav-wizard .active ~ li a:after {
    border-left: 16px solid #422e2e;
}


    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="Body_CopyIssues">

    <%--<div class="wrapper">--%>

    <!-- Content Wrapper. Contains page content -->
    <%-- <div class="content-wrapper" id="maindiv">--%>
    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="content">

        <div class="Issuemodulewrap_main">
            <div class="headerspacing">&nbsp;</div>

            <div class="col-md-12">

                <div class="box box-panel box-solid mb-0">
                    <div class="box-body">
                        <!--step_wizard-->


                        <div class="wizard">
                            <!--Commented by pradip on 3-4-2023-->
                            <%--<ul class="nav nav-wizard">

                                <li class="active">
                                    <a href="#step1" data-bs-toggle="tab" id="tab1">Step1 (Select issues)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step2" data-bs-toggle="tab" id="tab2">Step2 (Responsible Person)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step3" data-bs-toggle="tab" id="tab3">Step3 (Update Attributes)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step4" data-bs-toggle="tab" id="tab4">Step4 (Perform Action)</a>
                                </li>
                            </ul>--%> 

                            <ul class="nav nav-wizard">

                                <li class="">
                                    <a href="#step1" data-bs-toggle="tab" id="tab1" class="nav-link active">Step1 (Select issues)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step2" data-bs-toggle="tab" id="tab2" class="nav-link">Step2 (Responsible Person)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step3" data-bs-toggle="tab" id="tab3" class="nav-link">Step3 (Update Attributes)</a>
                                </li>

                                <li class="disabled">
                                    <a href="#step4" data-bs-toggle="tab" id="tab4" class="nav-link">Step4 (Perform Action)</a>
                                </li>
                            </ul>


                            <form>
                                <div class="tab-content">
                                    <div class="tab-pane show active" id="step1">

                                        <div class="form-inline pt-1">
                                            <div class="form-group pull-left">
                                                <%--<label for="">Coppying Issues From</label>--%>
                                                <label><%=MyBase.GetResourceString("C_CopyingIssues")%></label>

                                            </div>
                                            <!--modified by pradip on 14-10-2020-->
                                            <div class="form-group col-sm-4 ml-1 mr-2">
                                                <%--<select class="form-control selectpicker">
                                                            <option>--Select Project--</option>
                                                            <option>Project1</option>
                                                            <option>Project2</option>
                                                            <option>Project3</option>
                                                        </select>--%>
                                               <%-- Commented & Added By Dipali V On 31st March 2021 For Customer login Project should list out--%>
                                                      
                                                <%--  <% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_CopyIssueList " & Session("intUserID") & "", 300,, "class='form-control'",,, ) %>--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_IssueList " & Session("intUserID") & "," & Convert.ToInt32(Request.QueryString("ProjectID")), 300,, "Onchange='Project_Onchange()' class='form-control'", ,,, ) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_IssueList " & Session("intUserID") & "," & Convert.ToInt32(Request.QueryString("ProjectID")) & ",0,0,NULL,0," & Session("LoginType") & ",0,NULL,0,0,NULL", 300,, "Onchange='Project_Onchange()' class='form-control'",,, ) %>
                                                 <%-- End of Commented & Added By Dipali V On 31st March 2021 For Customer login Project should list out--%>
                                                      
                                            </div>
                                            <%--<span>To Project Customization 2018-19</span>--%>

                                            <%--<label for=" "> To Project <span id="SessionProject"></span></label>--%>
                                            <label for=" " id="toProject"><%=MyBase.GetResourceString("C_ToProject")%> <span id="SessionProject"></span></label>
                                            <div class="clearfix"></div>

                                            <!--bootstrap_Alertify-->
                                            <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" style="display: none">
                                                <button type="button" onclick="CloseShowAlert()" class="close">×</button>
                                                <p id="alertMsg"></p>
                                            </div>
                                            <!--bootstrap_Alertify-->

                                        </div>

                                        <p class="text-right CInoteTop"><small><em><strong>Note:</strong> Issue can be copied where source and destination project practice and project group is same.</em></small></p>
                                        <%-- <br />--%>

                                        <div class="copywizardtbl_outer">

                                            <%--<p class="text-right" style="margin-bottom:-10px"><small><em><strong>Note:</strong> issue can be copied where source and destination project practise/project group is same.</em></small></p>--%>
                                            <table id="copywizardtbl" class="table table-hover table-bordered mt-1" style="width: 100%;">
                                                <thead>
                                                    <tr>
                                                        <th style='min-width: 100px;'><%=MyBase.GetResourceString("C_IssueId")%></th>
                                                        <th><%=MyBase.GetResourceString("C_SUMMARY")%></th>
                                                        <th><%=MyBase.GetResourceString("C_Description1")%></th>
                                                        <th style="min-width: 12%;"><%=MyBase.GetResourceString("C_Type")%></th>
                                                        <th><%=MyBase.GetResourceString("C_Sub_Type")%></th>
                                                        <th style="min-width: 105px;"><%=MyBase.GetResourceString("C_Status")%></th>
                                                        <th style="min-width: 12%;"><%=MyBase.GetResourceString("C_Priority")%></th>
                                                        <th><%=MyBase.GetResourceString("C_Severity")%></th>
                                                        <th>
                                                            <div class="custom_chckbox">
                                                                <input type="checkbox" class="chckHead" id="selectcopyissueall">
                                                                <%--<label for="selectcopyissueall" class="chckHead" data-bs-toggle="tooltip" data-placement="left" title="Select All"></label>--%>
                                                                <label for="selectcopyissueall" class="chckHead"></label>
                                                            </div>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="issuelist">
                                                </tbody>
                                            </table>
                                        </div>


                                        <ul class="list-inline pull-right mt-2 mb-0">
                                            <li>
                                                <a href="javascript:;" onclick="backlink()" type="button" class="btn borderbtn ml-1 ">Back</a>
                                                <button id="nextbtn1" type="button" class="btn btnyellow nextwizardbtn ml-1 " onclick="Nextbtn1_click()">Next</button></li>
                                        </ul>
                                    </div>

                                    <div class="tab-pane" id="step2">

                                        <div class="form-inline pt-1 mb-2">
                                            <div class="form-group pull-left">
                                                <%--<label for="">Coppying Issues Form</label>--%>
                                                <label><%=MyBase.GetResourceString("C_CopyingIssues")%></label>
                                            </div>
                                            <div class="form-group ml-1 mr-2">
                                                <%-- <select class="form-control selectpicker">
                                                               <option>--Select Project--</option>
                                                               <option>Project1</option>
                                                               <option>Project2</option>
                                                               <option>Project3</option>
                                                               </select>--%>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectTAB2", "SELECT ''", 300,, "class='form-control'",,,,,,)%>
                                            </div>
                                            <%--<span>To Project Customization 2018-19</span>--%>
                                            <div class="form-group ml-2 mr-2">
                                                <label><span><%=MyBase.GetResourceString("C_ToProject")%> </span><span id="SessionProjectTAB2"></span></label>
                                            </div>

                                            <div class="clearfix"></div>
                                        </div>
                                        <br />
                                        <div class="wizardcontent mt-2">
                                            <%--<small>*<em>Total issues selected for copy 15.</em></small><br/><br/>--%>
                                            <small>*<em><%=MyBase.GetResourceString("C_TotalSelectedIssue")%> <span id="totalselectedissue"></span></em></small>
                                            <br />
                                            <br />
                                            <div class="text-center mt-2 mb-2">
                                                <div class="form-inline mb-2">
                                                    <%--<label>Select Responsible Person</label>--%>

                                                    <label><%=MyBase.GetResourceString("C_AssignTo")%></label>
                                                    <div class="form-group ml-1" style="width: 180px;">
                                                        <%-- <select class="form-control selectpicker"><option>person1</option>
                                                                     <option>person2</option>
                                                                       <option>person3</option>
                                                                     </select>--%>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("CboResponsiblePerson", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy'," & Request.QueryString("ProjectID").ToString() & ", NULL ,NULL, NULL, NULL ," & "'" & Session("LoginType") & "','New',0 ",,, "class='form-control'", ,, ) %>
                                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboResponsiblePerson", "Select '' ",,, "class='form-control'", True,, ) %>--%>
                                                    </div>
                                                </div>
                                                <small><em>if no responsible person is selected,the responsible person set at Project level will be by default set as responsible person</em></small>
                                            </div>

                                        </div>
                                        <br />
                                        <br />

                                        <ul class="list-inline pull-right mt-2 mb-0">
                                            <li>
                                                <button id="btnPrevious2" type="button" class="btn borderbtn btnPrevious">Back</button>
                                                <button id="nextbtn2" type="button" class="btn btnyellow nextwizardbtn ml-1 ">Next</button>

                                            </li>
                                        </ul>

                                    </div>
                                    <div class="tab-pane" id="step3">

                                        <div class="form-inline pt-1 mb-2">
                                            <div class="form-group pull-left">
                                                <%--<label for="">Coppying Issues Form</label>--%>
                                                <label><%=MyBase.GetResourceString("C_CopyingIssues")%></label>
                                            </div>
                                            <div class="form-group ml-1 mr-2">
                                                <%-- <select class="form-control selectpicker">
                                                             <option>--Select Project--</option>
                                                             <option>Project1</option>
                                                             <option>Project2</option>
                                                             <option>Project3</option>
                                                        </select>--%>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectTAB3", "SELECT ''", 300,, "class='form-control'",, ,,,,,)%>
                                            </div>
                                            <%--<span>To Project Customization 2018-19</span>--%>
                                            <label><%=MyBase.GetResourceString("C_ToProject")%> <span id="SessionProjectTAB3"></span></label>
                                            <div class="clearfix"></div>
                                        </div>
                                        <br />
                                        <div class="wizardcontent mt-2">
                                            <div class="row">
                                                <%--Commented & Added By Rutuja D. on 6 jan 2020 For UI is disturbed captions and fields are overlapped--%>
                                                <%--<div class="col-md-1">&nbsp;</div>--%>
                                                <%--<div class="col-md-10">--%>
                                                <div>&nbsp;</div>
                                                <div>
                                                <%-- End Of Commented & Added By Rutuja D. on 6 jan 2020 For UI is disturbed captions and fields are overlapped--%>
                                                    <div class="wizardform">
                                                        <div class="wizardformbody">
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <div class="col-md-4" id="divType">

                                                                        <label class="control-label col-sm-4" id="lblType"><%=MyBase.GetResourceString("C_Type")%></label>
                                                                        <div class="col-sm-8">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboType", "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & Request.QueryString("ProjectID").ToString() & ",'T',Null,Null,Null,Null,Null," & Convert.ToInt32(Session("intPostID").ToString()),,, "class='form-control' onchange='Typeclick(this.value)'",,,) %>
                                                                        </div>

                                                                    </div>
                                                                    <div class="col-md-4" id="divSubType">

                                                                        <label class="control-label col-sm-4" id="lblSubType"><%=MyBase.GetResourceString("C_Sub_Type")%></label>
                                                                        <div class="col-sm-8">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboSubType", "Select ''",,, "class='form-control'", True,, ) %>
                                                                        </div>

                                                                    </div>
                                                                    <div class="col-md-4" id="divStatus">

                                                                        <label class="control-label col-sm-4" id="lblStatus"><%=MyBase.GetResourceString("C_Status")%></label>
                                                                        <div class="col-sm-8">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboStatus", "Select ''",,, "class='form-control'", True, , ) %>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <div class="col-md-4" id="divReportedBy">

                                                                        <label class="control-label col-sm-4" id="lblReportedBy"><%=MyBase.GetResourceString("C_Reported_By")%></label>
                                                                        <div class="col-sm-8">

                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboReportedBy", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy'," & Request.QueryString("ProjectID").ToString() & "," & Convert.ToInt32(Session("intUserID").ToString()) & ",1,NULL,NULL,'" & Session("LoginType") & "','New',0",,, "class='form-control ' ",,, ) %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4" id="divReportedDate">

                                                                        <label class="control-label col-sm-4" id="lblReportedDate"><%=MyBase.GetResourceString("C_Reported_Date")%></label>
                                                                        <div class="col-sm-8">
                                                                            <div class="input-group datefielddiv">
                                                                                <%--<input id="dtReportedDate" type="text" class="form-control">--%>
                                                                                <%--Commented And Added By Usha Pandit On 09.06.2020 for restricting alphabates for Reported Date--%>
                                                                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtReportedDate", "dtReportedDate", "form-control", 50, 200, ,,, ,,,, "autocomplete=off",,, True,,,, True) %>--%>
                                                                                <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedDate", "dtReportedDate", "form-control", 50, 200, ,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete=off",,, True,,,, True) %>
                                                                                <%--End Of Added By Usha Pandit On 09.06.2020 for restricting alphabates for Reported Date--%>
                                                                                <span class="input-group-btn">
                                                                                    <button class="btn btncalendar" type="button" style="height:30px"><i class="fas fa-calendar-alt"></i></button>
                                                                                </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4" id="divReportedTime">

                                                                        <label class="control-label col-sm-4" id="lblReportedTime"><%=MyBase.GetResourceString("C_ReportedTime")%></label>
                                                                        <div class="col-sm-8">
                                                                            <div class="input-group datefielddiv">
                                                                                <%--<input id="dtReportedTime" type="text" class="form-control">--%>
                                                                                <%--Commented And Added By Usha Pandit On 09.06.2020 for restricting alphabates for Reported Date--%>
                                                                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtReportedTime", "dtReportedTime", "form-control", 50, 200,,,, ,,,, "autocomplete=off",, , True,,,, True) %>--%>
                                                                                <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedTime", "dtReportedTime", "form-control", 50, 200,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete=off",, , True,,,, True) %>
                                                                                <%--End Of Added By Usha Pandit On 09.06.2020 for restricting alphabates for Reported Date--%>
                                                                                <span class="input-group-btn">
                                                                                    <button class="btn btncalendar" type="button" style="height:30px"><i class="far fa-clock"></i></button>
                                                                                </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group last" id="divRelease">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <%--<label class="control-label col-sm-4">Reported Date</label>--%>
                                                                        <label class="control-label col-sm-4" id="lblRelease"><%=MyBase.GetResourceString("C_Release")%></label>
                                                                        <div class="col-sm-8">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboRelease", "Exec usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseName " & Request.QueryString("ProjectID").ToString(),,, "class='form-control' OnChange='GetIterations(this)'", ,,, ) %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4" id="divIteration">
                                                                        <%--<label class="control-label col-sm-4">Reported Time</label>--%>
                                                                        <label class="control-label col-sm-4" id="lblIteration"><%=MyBase.GetResourceString("C_Sprint")%></label>
                                                                        <div class="col-sm-8">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboIteration", "SELECT ''",,, "class='form-control' OnChange='GetUserStories(this)'",,,) %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4" id="divUserStory">
                                                                        <%--<label class="control-label col-sm-4">Reported Time</label>--%>
                                                                        <label class="control-label col-sm-4" id="lblUserStory"><%=MyBase.GetResourceString("C_User_Story")%></label>
                                                                        <div class="col-sm-8">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboUserStory", "SELECT ''",,, "class='form-control ' ",,,,) %>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                    <br />
                                                    <%--<center> <button class="btn btnyellow" data-bs-toggle="tooltip" data-placement="top" title="Copy">Copy</button></center>--%>
                                                </div>
                                                <div class="col-md-1">&nbsp;</div>
                                            </div>

                                        </div>
                                        <br />
                                        <br />


                                        <ul class="list-inline pull-right mt-2 mb-0">
                                            <li>
                                                <button id="btnPrevious3" type="button" class="btn borderbtn btnPrevious">Back</button>
                                                <%If m_blnAddAccess = True Then%>
                                                <button type="button" class="btn btnyellow nextwizardbtn1 ml-1 ">Copy</button></li>
                                            <%End If %>
                                        </ul>
                                    </div>
                                    <div class="tab-pane" id="step4">
                                        <div class="pt-1 mb-2">
                                            &nbsp;
                                        </div>

                                        <div class="wizardcontent mt-2 mb-2">
                                            <h4 class="text-center text-info"><span id="WaitText"></span><span id="countforcopy"></span></h4>
                                            <h4 class="text-center text-info"><span id="MsgCopy"></span></h4>
                                            <div class="copyloaderimg text-center" style="display: block">
                                                <img src="../../../Whizible2.0-new/dist/img/time.gif" alt="Waiting" title="Waiting">
                                                <div class="copyloaderimg text-center">
                                                    <span id="imgtext"></span>
                                                </div>
                                            </div>

                                        </div>


                                        <ul class="list-inline pull-right">
                                            <li>
                                                <%--<a class="gofirst" href="#step1" data-bs-toggle="tab">Add More</a>--%>
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


        </div>

        <div class="clearfix"></div>
    </section>

    <%--  </div>--%>


    <!-- /.content -->
    <%-- </div>--%>
    <!-- /.content-wrapper -->

    <%--</div>--%>

    <!-- ./wrapper -->

    <!-- REQUIRED JS SCRIPTS -->
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js" type="text/javascript"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js" type="text/javascript"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>


    <script type="text/javascript">
        var viewApplied;
        var ResponsiblePerson;
        $(document).ready(function () {
            viewApplied = '<%=ViewApplied%>';
            //Wizard
            $('a[data-bs-toggle="tab"]').on('show.bs.tab', function (e) {

                var $target = $(e.target);

                if ($target.parent().hasClass('disabled')) {
                    return false;
                }
            });

            $(".nextwizardbtn").click(function (e) {
                var $active = $('.wizard .nav-wizard li a.active');
                $active.next().removeClass('disabled');
                nextTab($active);

            });



        });

        $('.tt_large').tooltip({
        template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                        });

        function nextTab(elem) {
            $(elem).next().find('a[data-bs-toggle="tab"]').click();
                      
        }
        //End bootstrap datepicker

        //End bootstrap datepicker Time



        $(function () {


            //start bootstrap datepicker
            $('#dtReportedDate').datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy'

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




            $('#dtReportedTime').datetimepicker({
                format: 'LT',
            });


            //checkall
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
    <script>

        $('#dtReportedDate').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'

        });


        $('#dtReportedDate').datepicker('setDate', new Date());

        $('#dtReportedTime').datetimepicker({
            defaultDate: new Date(),
            format: 'LT'
        });

    </script>


    <!--back btn-->
    <script type="text/javascript">
        var totalTabs = $('.nav-wizard li a').length;
        var currentTab = 1;

       
        $('.btnPrevious').on('click', function () {
            //alert();
            //e.preventDefault();
            //currentTab -= 1;
            //showHideControls();
            //var prev_tab = $('.nav-wizard .active').prev('li').find('a');
            //if (prev_tab.length > 0) {
            //    prev_tab.trigger('click');
            //}
           // $('.nav-wizard li a.active').parent('li').prev('li').find('a').trigger('click');

            const prevTabLinkEl = $('.nav-wizard .active').closest('li').prev('li').find('a')[0];
            const prevTab = new bootstrap.Tab(prevTabLinkEl);
            prevTab.show();

        });

    </script>


    <script>

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var IssueProjectID;
        var OnchangeProject;
        var ProjectId;
        var logintype;
        var Project_Flag;
        var UserName;
        var issueIDs;
        var SelectedProject;
        var RoleId;
        var LoginType;
        var UserId;
        var items;
        var UserName;
        UserName ='<%= Session("strUserName") %>';
        alertify.set('notifier', 'position', 'top-right');
        $(document).ready(function () {

            //Pagination();
            StartLoader("#Body_CopyIssues");
            RoleId = "<%= Session("IssueRole").ToString() %>";
            LoginType = "<%= Session("LoginType").ToString() %>";
            UserId = "<%= Session("intUserID").ToString() %>";

            //$("#SessionProject").text(SelectedProject);
            logintype = "<%= Session("LoginType").ToString() %>";
            UserName = "<%= Session("strUserName").ToString() %>";

            $("#CboReportedBy").val(UserName);
            params = getParams();
            //Commented & Added By Dipali V On 31st March 2023 For Project ID Issues
            //IssueProjectID = unescape(params["ProjectID"]);
            IssueProjectID = unescape(params["ProjectID"]).trim();
            //End of Commented & Added By Dipali V On 31st March 2023 For Project ID Issues
            //Added By Riddhesh Patil on 31st March 2023
            RoleId = params["RoleId"];
            //End of Added By Riddhesh Patil on 31st March 2023
            SelectedProject = unescape(params["ProjectName"]);
            $("#SessionProject").text(SelectedProject);
            GetProjectDates(IssueProjectID);
            GetMaxItemsToShow();
            Pagination();
            SetWindowHeight();
            var fields = ["Type", "SubType", "Status", "Release", "Sprint", "UserStory", "ReportedBy"];//REPORTEDBY ADDED BY  DIPALI ON 12ND NOV 2019 FOR PLACEHOLDER ISSUES
            for (var i = 0; i < fields.length; i++) {
                //
                AppendToCombo(fields[i].toString());
            }
            //REPORTEDBY ADDED BY  DIPALI ON 12ND NOV 2019 FOR DEFAULT LOGIN PERSON 
            $("#CboReportedBy").val(UserName);
            StopAjaxLoader("#Body_CopyIssues");
            Project_Onchange();
           
        });

        //Project On Change 


        //For Set Height dyanamically
       function SetWindowHeight() {
            //
            var height = $(window).height();
            $(".dataTables_scrollBody").css("height", height - 328);

            //var height = $(window).height();
            //$(".wizard").css("height", height - 52); // Comented by pradip p on 31-3-2023

        }
        $(window).on("load resize scroll", function (e) {
            SetWindowHeight(this);
        });

        //For Plot Issue List
        function PlotIssueList(data) {
            //alert();
            $("#issuelist").html('');
            var strHTML = "";
            var strDescription = "";
                    for (var i = 0; i < data.length; i++) {
                        //
                        var strDescription = "";
                        var strSummary = "";
                        var strType = "";
                        var strSubType = "";
                        var strStatus = "";
                        var strPriority = "";
                        var strSeverity = "";

                        var IssueID = data[i]["IssueID"];
                        var Summary = data[i]["Summary"].replace("'","''");
                        var Description = data[i]["Description"].replace("'","''");
                        var Type = data[i]["Type"];
                        var SubType = data[i]["SubType"];
                        var Status = data[i]["Status"];
                        var Priority = data[i]["Priority"];
                        var Severity = data[i]["Severity"];


                        //Added by dipali V on 9th Aug 2019 for if data is null then
                        if (Type == null) {
                            Type = "Not Specified";
                        }
                        else if (Type == "NULL") {
                            Type = "Not Specified";
                        }

                        if (SubType == null) {
                            SubType = "Not Specified";
                        }
                        else if (SubType == "NULL") {
                            SubType = "Not Specified";
                        }


                        if (Status == null) {
                            Status = "Not Specified";
                        }
                        else if (Status == "NULL") {
                            Status = "Not Specified";
                        }


                        if (Priority == null) {
                            Priority = "Not Specified";
                        }
                        else if (Priority == "NULL") {
                            Priority = "Not Specified";
                        }


                        if (Severity == null) {
                            Severity = "Not Specified";
                        }

                        else if (Severity == "NULL") {
                            Severity = "Not Specified";
                        }
                        //End of Added by dipali V on 9th Aug 2019 for if data is null then


                        if (Summary.length < 30) {
                            strSummary = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Summary + '" class="tt_large"> ' + Summary + '</td>'
                        }
                        else {
                            var str = Summary.substring(0, 30);
                            strSummary = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Summary + '" class="tt_large"> ' + str + '....</td>'

                        }

                        if (Description.length < 50) {
                            strDescription = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Description + '" class="tt_large"> ' + Description + '</td>'
                        }
                        else {
                            var str = Description.substring(0, 50);
                            strDescription = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Description + '" class="tt_large"> ' + str + '....</td>'

                        }


                        //if (SubType != "Not Specified" && SubType != "null" && SubType != null) {
                            if (SubType.length < 5) {
                                strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '" class="tt_large"> ' + SubType + '</td>'
                            }
                            else {
                                var str = SubType.substring(0, 5);
                                strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //}
                        //else {

                        //    strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '"> ' + SubType + '</td>'

                        //}


                        //if (Type != "Not Specified" && Type != "null" && Type != null) {
                            if (Type.length < 5) {
                                strType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '" class="tt_large"> ' + Type + '</td>'
                            }
                            else {
                                var str = Type.substring(0, 5);
                                strType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //} else {

                        //    strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '"> ' + Type + '</td>'

                        //}



                       // if (Status != "Not Specified" && Status != "null" && Status != null) {
                            if (Status.length < 5) {
                                strStatus = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '" class="tt_large"> ' + Status + '</td>'
                            }
                            else {
                                var str = Status.substring(0, 5);
                                strStatus = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //} else {

                        //    strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '"> ' + Status + '</td>'

                        //}



                        //if (Priority != "Not Specified" && Priority != "null" && Priority != null) {
                            if (Priority.length < 5) {
                                strPriority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '" class="tt_large"> ' + Priority + '</td>'
                            }
                            else {
                                var str = Priority.substring(0, 5);
                                strPriority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //}
                        //else {
                        //    strPriority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '"> ' + Priority + '</td>'
                        //}

                        //if (Severity != "Not Specified" && Severity != "null" && Severity != null) {
                            if (Severity.length < 5) {
                                strSeverity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '" class="tt_large">  ' + Severity + '</td>'
                            }
                            else {
                                var str = Severity.substring(0, 5);
                                strSeverity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //} else {
                        //    strSeverity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '"> ' + Severity + '</td>'

                        //}


                        strHTML += '<tr>'
                        strHTML += '<td>'
                        strHTML += IssueID
                        strHTML += ' </td > '
                        //strHTML += '<td>'
                        //strHTML += Summary
                        //strHTML += ' </td > '
                        //strHTML += '<td>'
                        //strHTML += Description
                        //strHTML += ' </td > '
                        strHTML += strSummary
                        strHTML += strDescription
                        //strHTML += '<td>'
                        //strHTML += Type
                        //strHTML += '</td>'
                        //strHTML += '<td>'
                        //strHTML += SubType
                        //strHTML += '</td>'
                        strHTML += strType
                        strHTML += strSubType
                        strHTML += strStatus
                        strHTML += strPriority
                        strHTML += strSeverity
                        //strHTML += '<td>'
                        //strHTML += Status
                        //strHTML += '</td>'
                        //strHTML += '<td>'
                        //strHTML += Priority
                        //strHTML += '</td>'
                        //strHTML += '<td>'
                        //strHTML += Severity
                        //strHTML += '</td>'
                        strHTML += '<td><div class="custom_chckbox">'
                        strHTML += '<input type="checkbox" name="checkIssue" id="checkIssue_' + IssueID + '" value="' + IssueID + '" class="chcktbl">'
                        strHTML += '<label for="checkIssue_' + IssueID + '" class="chcktbl" ></label>'
                        strHTML += '</div></td>'
                        strHTML += '</tr>'

                        $("#issuelist").html(strHTML);
                        $('[data-bs-toggle="tooltip"]').tooltip();
                    }
            GetProjectPractises(IssueProjectID, ProjectId);
        }

        //For Plot Project Practises
        function GetProjectPractises(IssueProjectID, ProjectId) {

            var issueParameters = {
                intProjectID: IssueProjectID,
                intCurrentProjectID: ProjectId
            }
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetPractises',
                type: 'POST',
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
                    //
                    mstrselectedPractiseID = result[0];
                    mstrcurrentPractiseID = result[1];

                    if (mstrselectedPractiseID != mstrcurrentPractiseID) {
                        $(".chcktbl").attr('style', 'cursor: not-allowed !important');
                        $(".chcktbl").attr("disabled", true);
                        $(".chckHead").attr('style', 'cursor: not-allowed !important');
                        $("#selectcopyissueall").attr("disabled", true);


                    }
                },
                error: function (err) {
                    // alert("error");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //Get project name on step2 and step3 dropdown
        var selectedProjetName = "";
        function GetProjectName(ProjectId) {
            issueParameters = {
                intProjectID: ProjectId,
            }
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetProjectName',
                type: "POST",
                data: JSON.stringify(issueParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (issueParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(issueParameters) ? issueParameters : JSON.stringify(issueParameters)));
                    }
                },
                success: function (result) {
                    //debugger
                    var res = result[0];
                    if (res != undefined) {
                        if (res.ResultFlag == true) {

                        }
                        else {
                            var ProjectLists = result;
                            PlotProject(ProjectLists);
                        }
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        var StartDate;
        var EndDate;
        function GetProjectDates(IssueProjectID) {

           var issueParameters = {
                intProjectID: IssueProjectID,

            }
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/ProjectStartEndDates',
                type: "POST",
                data: JSON.stringify(issueParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (issueParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(issueParameters) ? issueParameters : JSON.stringify(issueParameters)));
                    }
                },
                success: function (result) {
                    StartDate = result[0];
                    EndDate = result[1];

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        function PlotProject(ProjectLists) {

            var selsHTML = "";
            for (var i = 0; i < ProjectLists.length; i++) {
                var da = ProjectLists[i];

                var Projectid = da.ProjectID;
                var ProjectName = da.StrProjectName;
                selsHTML = ('<option value=' + Projectid + ' >' + ProjectName + '</option>');
            }

            $("#CboProjectTAB2").html(selsHTML);
            $("#CboProjectTAB3").html(selsHTML);
            $("#CboProjectTAB2").prop("disabled", true);
            $("#CboProjectTAB3").prop("disabled", true);
        }

        //this use for if checek box checked then all check box selected and all issue id stored in rows array                  
        $('#selectcopyissueall').click(function () {

            var table = $('#copywizardtbl').DataTable();
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


        ////this use for if uncheck one of the Checkbox then remove check of Select all        
        $(document).on('change', '.chcktbl', function () {

            var table = $("#copywizardtbl").DataTable();
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl').length;
            var checked1 = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;
            if (checked == checked1) {
                $(".chckHead").prop("checked", true);
            }
            else {
                $(".chckHead").prop("checked", false);
            }
        });



        //Function for to get the Selected Project Name from IB_IssueList.aspx page using query string      
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

        var countchecked;
        function Nextbtn1_click() {
            //var IssueProjectID= $("#cboProject").val();
            //GetResponsiblePerson(IssueProjectID)
            $('#CboResponsiblePerson option[value=' + ResponsiblePerson + ']').attr("selected", "selected");
            var table = $("#copywizardtbl").DataTable();
            countchecked = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;      // Convert to a jQuery object             
        }

       
      
        $("#nextbtn1").on('click', function () {
            
            var table = $('#copywizardtbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            issueIDs = $('input[name=checkIssue]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');

            if (!$('#cboProject').val() || $('#cboProject').val() == 0) {
                alertify.error('Please Select Project.');
                $("#tab2").prop('disabled', true);
                return false;
            }
            if (issueIDs.length != 0) {

                $("#tab1").prop('disabled', false);
                $("#tab2").prop('disabled', false);

                //$("#tab1").prop("disabled", true);
                $(".nav.nav-wizard li:nth-child(2)").removeClass("disabled");
               
                $('a[href="#step2"]').tab('show');


                $("#SessionProjectTAB2").text(SelectedProject);
                $("#SessionProjectTAB3").text(SelectedProject);
                $("#totalselectedissue").text('[' + countchecked + ']');
                //$('#CboResponsiblePerson').empty();
                GetResponsiblePerson(IssueProjectID);

            }
            else {
                alertify.error('Please select at least one record.');
                $("#tab2").prop("disabled", true);
                return false;
            }

        });

        $("#nextbtn2").click(function () {
            if (!$('#CboResponsiblePerson').val() || $('#CboResponsiblePerson').val() == 0) {
                alertify.error('Please Select Responsible Person.');
                $("#tab3").prop('disabled', true);
                return false;
            }
            else {
                $("#tab3").prop('disabled', false);
                $(".nav.nav-wizard li:nth-child(3)").removeClass("disabled");
                //$(".nav.nav-wizard li:last-child(3)").removeClass("disabled");
                $('a[href="#step3"]').tab('show');

                GetControlPloatingProject(IssueProjectID, RoleId);
                var ReleaseID = $("#CboRelease").val();
                GetIterations(ReleaseID);
                var TypeID = $("#CboType").val();
                Typeclick(TypeID);
                //COMMENTED & AADED BY DIPALI TO MAKE GENERIC DATEPICKER
                //  $('#dtReportedDate').datepicker('setDate', new Date());

                $('#dtReportedDate').datepicker({
                    autoclose: true,
                    changeMonth: true,
                    dateFormat: 'dd M yy'

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
                $('#dtReportedDate').datepicker('setDate', new Date());
                //END OF COMMENTED & AADED BY DIPALI TO MAKE GENERIC DATEPICKER

                $('#dtReportedTime').datetimepicker({
                    defaultDate: new Date(),
                    format: 'HH:mm'
                });


            }

        });

        function Project_Onchange() {
            // 
            StartLoader("#Body_CopyIssues");
            $("#copywizardtbl").dataTable().fnDestroy();
            /*$(".chckHead").prop("checked", false); */   //To remove selected checkbox after page load
            OnchangeProject = $("#cboProject").find(':selected').text();
            ProjectId = $("#cboProject").find(':selected').val();
            GetProjectName(ProjectId);

            issueParameters = {
                intProjectID: ProjectId,
            }
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetIssueList1',
                type: "POST",
                data: JSON.stringify(issueParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (issueParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(issueParameters) ? issueParameters : JSON.stringify(issueParameters)));
                    }
                },
                success: function (data) {

                    $("#issuelist").html('');
                    var strHTML = "";
                    for (var i = 0; i < data.length; i++) {
                        //
                        var strDescription = "";
                        var strSummary = "";
                        var strType = "";
                        var strSubType = "";
                        var strStatus = "";
                        var strPriority = "";
                        var strSeverity = "";

                        var IssueID = data[i]["IssueID"];
                        var Summary = data[i]["Summary"].replace("'","''");
                        var Description = data[i]["Description"].replace("'","''");
                        var Type = data[i]["Type"];
                        var SubType = data[i]["SubType"];
                        var Status = data[i]["Status"];
                        var Priority = data[i]["Priority"];
                        var Severity = data[i]["Severity"];


                        //Added by dipali V on 9th Aug 2019 for if data is null then
                        if (Type == null) {
                            Type = "Not Specified";
                        }
                        else if (Type == "NULL") {
                            Type = "Not Specified";
                        }

                        if (SubType == null) {
                            SubType = "Not Specified";
                        }
                        else if (SubType == "NULL") {
                            SubType = "Not Specified";
                        }


                        if (Status == null) {
                            Status = "Not Specified";
                        }
                        else if (Status == "NULL") {
                            Status = "Not Specified";
                        }


                        if (Priority == null) {
                            Priority = "Not Specified";
                        }
                        else if (Priority == "NULL") {
                            Priority = "Not Specified";
                        }


                        if (Severity == null) {
                            Severity = "Not Specified";
                        }

                        else if (Severity == "NULL") {
                            Severity = "Not Specified";
                        }
                        //End of Added by dipali V on 9th Aug 2019 for if data is null then


                        if (Summary.length < 30) {
                            strSummary = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Summary + '" class="tt_large"> ' + Summary + '</td>'
                        }
                        else {
                            var str = Summary.substring(0, 30);
                            strSummary = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Summary + '" class="tt_large"> ' + str + '....</td>'

                        }

                        if (Description.length < 50) {
                            strDescription = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Description + '" class="tt_large"> ' + Description + '</td>'
                        }
                        else {
                            var str = Description.substring(0, 50);
                            strDescription = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Description + '" class="tt_large"> ' + str + '....</td>'

                        }


                        //if (SubType != "Not Specified" && SubType != "null" && SubType != null) {
                            if (SubType.length < 5) {
                                strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '" class="tt_large"> ' + SubType + '</td>'
                            }
                            else {
                                var str = SubType.substring(0, 5);
                                strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //}
                        //else {

                        //    strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + SubType + '"> ' + SubType + '</td>'

                        //}


                        //if (Type != "Not Specified" && Type != "null" && Type != null) {
                            if (Type.length < 5) {
                                strType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '" class="tt_large"> ' + Type + '</td>'
                            }
                            else {
                                var str = Type.substring(0, 5);
                                strType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //} else {

                        //    strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Type + '"> ' + Type + '</td>'

                        //}



                       // if (Status != "Not Specified" && Status != "null" && Status != null) {
                            if (Status.length < 5) {
                                strStatus = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '" class="tt_large"> ' + Status + '</td>'
                            }
                            else {
                                var str = Status.substring(0, 5);
                                strStatus = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //} else {

                        //    strSubType = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Status + '"> ' + Status + '</td>'

                        //}



                        //if (Priority != "Not Specified" && Priority != "null" && Priority != null) {
                            if (Priority.length < 5) {
                                strPriority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '" class="tt_large"> ' + Priority + '</td>'
                            }
                            else {
                                var str = Priority.substring(0, 5);
                                strPriority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //}
                        //else {
                        //    strPriority = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Priority + '"> ' + Priority + '</td>'
                        //}

                        //if (Severity != "Not Specified" && Severity != "null" && Severity != null) {
                            if (Severity.length < 5) {
                                strSeverity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '" class="tt_large">  ' + Severity + '</td>'
                            }
                            else {
                                var str = Severity.substring(0, 5);
                                strSeverity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '" class="tt_large"> ' + str + '....</td>'

                            }
                        //} else {
                        //    strSeverity = '<td data-bs-toggle="tooltip"  data-container="body" title="' + Severity + '"> ' + Severity + '</td>'

                        //}


                        strHTML += '<tr>'
                        strHTML += '<td>'
                        strHTML += IssueID
                        strHTML += ' </td > '
                        //strHTML += '<td>'
                        //strHTML += Summary
                        //strHTML += ' </td > '
                        //strHTML += '<td>'
                        //strHTML += Description
                        //strHTML += ' </td > '
                        strHTML += strSummary
                        strHTML += strDescription
                        //strHTML += '<td>'
                        //strHTML += Type
                        //strHTML += '</td>'
                        //strHTML += '<td>'
                        //strHTML += SubType
                        //strHTML += '</td>'
                        strHTML += strType
                        strHTML += strSubType
                        strHTML += strStatus
                        strHTML += strPriority
                        strHTML += strSeverity
                        //strHTML += '<td>'
                        //strHTML += Status
                        //strHTML += '</td>'
                        //strHTML += '<td>'
                        //strHTML += Priority
                        //strHTML += '</td>'
                        //strHTML += '<td>'
                        //strHTML += Severity
                        //strHTML += '</td>'
                        strHTML += '<td><div class="custom_chckbox">'
                        strHTML += '<input type="checkbox" name="checkIssue" id="checkIssue_' + IssueID + '" value="' + IssueID + '" class="chcktbl">'
                        strHTML += '<label for="checkIssue_' + IssueID + '" class="chcktbl" ></label>'
                        strHTML += '</div></td>'
                        strHTML += '</tr>'

                        $("#issuelist").html(strHTML);

                        //Added By Usha Pandit On 01.04.2020 For Tooltip UI issue
                        $('.tt_large').tooltip({
                            template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                        });
                        //End Of Added By Usha Pandit On 01.04.2020 For Tooltip UI issue

                        $('[data-bs-toggle="tooltip"]').tooltip();
                    }
                    //StopAjaxLoader("#Body_CopyIssues");
                    SetWindowHeight();
                    Pagination();
                   
                    //Added by dipali V on 9th Aug 2019 for check Project pratices

                    // GetProjectPractises(IssueProjectID, ProjectId);
                    //Added by dipali V on 9th Aug 2019 for check Project pratices
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            });
            //Added By Usha Pandit to clear checked checkbox if project is changed
            $(".chckHead").prop("checked", false);
            //End Of Added By Usha Pandit to clear checked checkbox if project is changed
            StopAjaxLoader("#Body_CopyIssues");
            $('table').resize();


        }






        function GetResponsiblePerson(IssueProjectID) {
            var project = IssueProjectID;
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetResPerson',
                method: 'Post',
                data: JSON.stringify(project),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project) ? project : JSON.stringify(project)));
                    }

                },
                success: function (result) {
                    //$('#CboResponsiblePerson').empty();

                     ////start vishal mahajan 05-12-2019 
                    if ($("#CboResponsiblePerson option[value='0']").length <= 0) {
                        AppendToCombo("ResponsiblePerson");
                    }
                     ////end vishal mahajan 05-12-2019 

                    for (var i = 0; i < result.length; i++) {
                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objOption.value = Objresult.ResponsiblePersonID;
                        objOption.text = Objresult.UserName;
                        ResponsiblePerson = Objresult.ResponsiblePersonID;;
                        $('#CboResponsiblePerson option[value=' + ResponsiblePerson + ']').attr("selected", "selected");
                    }
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        ////this is function used for ploating some control by using projecct id 

        function GetControlPloatingProject(IssueProjectID, RoleId) {
            var layoutid;
            var MaxRows;
            var MaxCols;
            var IsIssueSLAApplicable;
            var Layoutdetails;
            var ListFiled;
            var issueParameters = {
                intProjectID: IssueProjectID,
                intRoleID: RoleId
            }
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetIssueLayout',
                type: 'POST',
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

                    Project_Flag = result[0];
                    IsIssueSLAApplicable = result[1];
                    layoutid = result[2];
                    MaxRows = result[3];
                    MaxCols = result[4];
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            var issueParameters = {
                intLayOutID: layoutid,
            }
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetControlLists',
                method: 'POST',
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

                    // 
                    var ListFiled = ["ReportedDate", "ReportedTime", "ReportedBy", "Type", "SubType", "Status", "Release", "Iteration", "UserStory"];
                    for (var i = 0; i < result.length; i++) {
                        var layoutcontrolobject = result[i];
                        var filed = ListFiled[i];
                        ////this is used for check from output layoutcontrolobject.FieldName value exist or not in ListFiled array
                        //// this is creatd instead of many if else condtion or switch case .this is used for increse code resubality and reduce code complixity
                        if (ListFiled.indexOf(layoutcontrolobject.FieldName) > -1) {
                            ////this is declare for store control prefix like if we would like to ploat text box control then this id will txtDescription
                            //// #txt= textbox,#dt=Datetime/calender,#Cbo=droup down list/select tag,
                            var cntrlprefix;
                            if (layoutcontrolobject.FieldName == "ReportedDate" || layoutcontrolobject.FieldName == "ReportedTime") {

                                cntrlprefix = "#dt";

                            } else if (layoutcontrolobject.FieldName == "Release" || layoutcontrolobject.FieldName == "Iteration" || layoutcontrolobject.FieldName == "UserStory") {

                                if (Project_Flag == "0") {
                                    layoutcontrolobject.Active = false;
                                } else {
                                    layoutcontrolobject.Active = true;
                                }
                                cntrlprefix = "#Cbo";

                            } else {

                                cntrlprefix = "#Cbo";
                            }

                            ////this funtion used for ploating common control pass some parameter
                            CommonFieldsPloat(cntrlprefix, layoutcontrolobject.FieldName, layoutcontrolobject.Active, layoutcontrolobject.ReadOnly, layoutcontrolobject.ControlWidth, layoutcontrolobject.Mandatory, layoutcontrolobject.RowNo, layoutcontrolobject.ColumnNo);


                        } else {

                            continue;
                        }

                    }


                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function CommonFieldsPloat(cntrlId, FieldName, Active, ReadOnly, ControlWidth, Mandatory, row, column) {

            ////this is used for custom create div id and label id common filed control 
            //// the div id strate with div and label id is start with lbl
            var divId = "#div" + FieldName;
            var lblId = "#lbl" + FieldName;

            ////this is use for custom create control id that mean if we use textbox, dorpdown,datetimepicker etc .
            /// cntrlId is prefix of control id
            var controlId = cntrlId + FieldName;
            //alert(controlId);
            if (Active == true) {
                $(divId).show();
                if (controlId != "#CboReportedBy" && controlId != "#dtReportedDate" && controlId != "#dtReportedTime") {
                    if ($(controlId).val() != "" && $(controlId).val() != "0") {
                        $(controlId).val('0');
                    }
                }

                if (ReadOnly == true) {
                    $(controlId).attr("disabled", true);

                } else {

                    $(controlId).attr("disabled", false);

                }
                if (ControlWidth > 0) {

                    $(controlId).css('width', ControlWidth);

                }
                //Comment Added by Swapnagandha K. On 22 Oct 2019 To make all fields mandatory
                //  if (Mandatory == true) {

                ////create custom madatory id 
                var RequiredId = "Mandatory" + FieldName;
                var mandatoryid = "#" + RequiredId;
                if ($(mandatoryid).length > 0) {

                } else {
                    //// if any contorl field is mandatory then apply requeried 
                    ///// this is custom required after current control label in red color                      
                    var lblval = "&nbsp;&nbsp;&nbsp;<span id=" + RequiredId + "  style='color:red;'>*</span>";
                    $(lblId).append(lblval);

                }
                // }
                //else {

                //}
                //End Comment Added by Swapnagandha K. On 22 Oct 2019 To make all fields mandatory

            } else {
                $(divId).hide();
            }


        }

        //On change of Type
        function Typeclick(Type) {

            if (Type != 0) {

                ////bind data to the subtype droup down list
                //DefaultSubType(IssueProjectID, Type);
                //
                $('#CboSubType').empty();
                $('#CboStatus').empty();

                GetDefault(IssueProjectID, Type);
                SubType(IssueProjectID, Type);
                //// bind data on status droupdown list
                // DefaultStatus(IssueProjectID, Type);
                Status(IssueProjectID, Type, RoleId);

            } else {
                $('#CboSubType').empty();
                $('#CboStatus').empty();
                var fields = ["SubType", "Status"];
                for (var i = 0; i < fields.length; i++) {
                    AppendToCombo(fields[i].toString());
                }

            }

        }

        ////Get Default SubType and Status For Dropdown ...Set in Project Setting:Issue Types
        var SelectedSubType = "";
        var SelectedStatus = "";
        function GetDefault(IssueProjectID, strDefaultType) {
            StartLoader("#Body_CopyIssues");
            SelectedSubType = "";
            SelectedStatus = "";
            var issueParameters = {
                intProjectID: IssueProjectID,
                strType: strDefaultType
            };

            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetDefaultSubTypeAndStatus',
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
                    //alert(result);
                    //
                    if (result != "") {
                        SelectedSubType = result[0].StrSubType;
                        SelectedStatus = result[1].StrStatus;

                        // alert(SelectedStatus);
                    }
                    //else {

                    //    var fields = ["SubType", "Status"];
                    //    for (var i = 0; i < fields.length; i++) {
                    //        AppendToCombo(fields[i].toString());
                    //    }
                    //}



                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#Body_CopyIssues");

        }


        //Get SubType List Dropdown
        function SubType(IssueProjectID, Type) {
            StartLoader("#Body_CopyIssues");
            var issueParameters = {
                intProjectID: IssueProjectID,
                strType: Type
            };

            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetSubType',
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
                    // 
                    if (result != "") {
                        var objCbo1 = document.getElementById("CboSubType");
                        $("#CboSubType option").remove();
                        for (var i = 0; i < result.length; i++) {
                            var Objresult = result[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.value = Objresult.strFieldID;
                            objOption.text = Objresult.strFieldName;

                        }



                        //$("#CboSubType").val(SelectedSubType);
                        //$("#CboStatus").val(SelectedStatus);
                        //("#CboStatus option:selected").text(SelectedStatus);
                        //if (SelectedStatus == "") {
                        //    var fields = ["Status"];
                        //    for (var i = 0; i < fields.length; i++) {
                        //        AppendToCombo(fields[i].toString());
                        //      //   $("#CboStatus option[value=0]").prop('selected', true);
                        //    }
                        //} else
                        //{
                        //     $("#CboStatus").val(SelectedStatus);
                        //}

                        //} else
                        //{ 
                        //if (SelectedStatus == "" && SelectedSubType == "") {
                        var fields = ["SubType"];
                        for (var i = 0; i < fields.length; i++) {
                            AppendToCombo(fields[i].toString());
                        }
                        //}
                        if (SelectedSubType != '')
                            $("#CboSubType").val(SelectedSubType).change();
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#Body_CopyIssues");

        }

        //Get Status List Dropdown

        function Status(IssueProjectID, Type, RoleId) {
            StartLoader("#Body_CopyIssues");
            var issueparameters = {
                intProjectID: IssueProjectID,
                strType: Type,
                intRoleID: RoleId
            };
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetStatus',
                method: 'Post',
                data: JSON.stringify(issueparameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (issueparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(issueparameters) ? issueparameters : JSON.stringify(issueparameters)));
                    }
                },
                success: function (result) {
                    // 
                    if (result != "") {
                        var res = result[0];
                        //if (res.ResultFlag == true) {

                        //}
                        //else {
                        //
                        var objCbo1 = document.getElementById("CboStatus");
                        $("#CboStatus option").remove();
                        for (var i = 0; i < result.length; i++) {
                            var Objresult = result[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.text = Objresult.strFieldID;
                            objOption.value = Objresult.strFieldName;
                        }

                        //$("#CboStatus").val(SelectedStatus);
                        //}
                    }
                    //if (SelectedStatus == "" && SelectedSubType == "") {
                    var fields = ["Status"];
                    for (var i = 0; i < fields.length; i++) {
                        AppendToCombo(fields[i].toString());
                    }
                    //}
                    if (SelectedStatus != '')
                        $("#CboStatus").val(SelectedStatus).change();

                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#Body_CopyIssues");
        }

        //Get Iteration Name By Release
        function GetIterations(Release) {
            var ReleaseIdVal = $("#CboRelease").find(':selected').val();
            // 
            if (ReleaseIdVal != 0) {
                ////bind data to the Iteration droup down list                
                GetIterationsByRelease(ReleaseIdVal);

            } else {
                //alertify.error("Please Select Release Name");
                $('#CboIteration').empty();
                $('#CboUserStory').empty();
                var fields = ["Sprint", "UserStory"];
                for (var i = 0; i < fields.length; i++) {

                    AppendToCombo(fields[i].toString());
                }
            }
        }

        function GetIterationsByRelease(Release) {
            StartLoader("#Body_CopyIssues");
            $('#CboIteration').empty();
            var issueParameters = {
                intReleaseID: Release,
            };

            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetIterationName',
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
                    //
                    //  var result = htmlEntities(HtmlResult);
                    // alert(HtmlResult.length);
                    if (result != "") {
                        var res = result[0];
                        if (res.ResultFlag == true) {

                        }
                        else {
                            var objCbo1 = document.getElementById("CboIteration");
                            $("#CboIteration option").remove();
                            //var objOption1 = document.createElement("OPTION");
                            //objCbo1.options.add(objOption1, 0);
                            //objCbo1.selectedIndex = 0;
                            for (var i = 0; i < result.length; i++) {
                                var Objresult = result[i];
                                var objOption = document.createElement("OPTION");
                                objCbo1.options.add(objOption);
                                objOption.value = Objresult.IntIterationId;
                                objOption.text = Objresult.StrIterationName;

                            }

                        }
                    }
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();
                    //var fields = ["Iteration","UserStory"];
                    //for (var i = 0; i < fields.length; i++)
                    //     {
                    //AppendToCombo("UserStory");
                    AppendToCombo("Sprint");
                    if ($("#CboIteration").val() == 0) {
                        $('#CboUserStory').empty();
                        AppendToCombo("UserStory");
                    }
                    //      }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#Body_CopyIssues");
        }

        function htmlEntities(str) {
            //
            //var Result = "";
            //return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
            // Result = escape(str);
            // alert(Result);
            //return Result;
        }
        //Get UserStory Name By Iteration
        function GetUserStories(Iteration) {
            var IterationIdVal = $("#CboIteration").find(':selected').val();
            if (IterationIdVal != 0) {
                //bind data to the Iteration droup down list                
                GetUserStoriesByIteration(IterationIdVal);

            } else {
                $('#CboUserStory').empty();
                var fields = ["UserStory"];
                for (var i = 0; i < fields.length; i++) {
                    AppendToCombo(fields[i].toString());
                }

            }
        }

        function GetUserStoriesByIteration(Iteration) {
            StartLoader("#Body_CopyIssues");
            $('#CboUserStory').empty();
            var issueParameters = {
                intIterationID: Iteration,
            };

            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetUserStoryName',
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
                        var res = result[0];
                        if (res.ResultFlag == true) {

                        }
                        else {
                            var objCbo1 = document.getElementById("CboUserStory");
                            $("#CboUserStory option").remove();
                            //var objOption1 = document.createElement("OPTION");
                            //objCbo1.options.add(objOption1, 0);
                            //objCbo1.selectedIndex = 0;
                            for (var i = 0; i < result.length; i++) {
                                var Objresult = result[i];
                                var objOption = document.createElement("OPTION");
                                objCbo1.options.add(objOption);
                                objOption.value = Objresult.IntUserStoryId;
                                objOption.text = Objresult.StrUserStory;

                            }
                        }
                    }
                    AppendToCombo("UserStory");
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#Body_CopyIssues");
        }

        function AppendToCombo(FieldName) {
            var id = "";
            if (FieldName == "Sprint") {
                id = "CboIteration";
            } else {
                id = "Cbo" + FieldName;
            }

            if (FieldName == "UserStory") {
                FieldName = "User Story";
            }
            if (FieldName == "ResponsiblePerson") {
                FieldName = "Responsible Person";
            }
            if (FieldName == "SubType") {
                FieldName = "Sub Type";
            }

            if (FieldName == "ReportedBy") {
                FieldName = "Reported By";
            }



            var textval = "Select " + FieldName + "";
            // $('#'+ id).empty();
            document.getElementById(id).insertBefore(new Option(textval, '0'), document.getElementById(id).firstChild);
            $("#" + id + " option[value=0]").prop('selected', true);
        }


        $(".nexttab").click(function () {
            var selected = $("#tabs").tabs("option", "selected");
            $("#tabs").tabs("option", "selected", selected + 1);
        });


        //On Click on Copy Button

        $(".nextwizardbtn1").click(function (e) {

            $('#step4 ul li').html("");
            $(".copyloaderimg").css("display", "block");

            var validateControl = ValidateControls();
            if (validateControl == true) {

                //$('.wizard .nav-wizard li a.active').removeClass('active');
                //$(".wizard .nav-wizard li:last-child a").addClass('active');
                //$("#step3").removeClass('active');
                //$("#step4").addClass('active');

                $(".nav.nav-wizard li:last-child").removeClass("disabled");
                $('a[href="#step4"]').tab('show');

                $("#tab3").prop("disabled", true);
                $("#tab2").prop("disabled", true);
                $("#tab1").prop("disabled", true);
                


                if (countchecked == 1) {
                    $("#MsgCopy").text('');
                    $("#WaitText").text('Please wait.....Copying ');
                    $("#countforcopy").html("[" + countchecked + "] Issue");
                }
                else {
                    $("#MsgCopy").text('');
                    $("#WaitText").text('Please wait.....Copying ');
                    $("#countforcopy").html("[" + countchecked + "] Issues");
                }

                CopyIssues();
            }
        });

        //Validate Controls before Copying Issues       
        function ValidateControls() {
            $('#dtReportedTime').datetimepicker({
                defaultDate: new Date(),
                format: 'LT'
            });


            var objType = $("#CboType").val();
            var objSubType = $("#CboSubType").val();
            var objStatus = $("#CboStatus").val();
            var objReportedBy = $("#CboReportedBy").val();
            var objReportedDate = $("#dtReportedDate").val();
            var objReportedTime = $("#dtReportedTime").val();


            //var currentdate = new Date();
            //var CurrentTime = + currentdate.getHours() + ":" + currentdate.getMinutes()
            objReportedTime = objReportedTime.substring(0, 5).replace(' ', '');
            var currentdate = new Date();
            //var CurrentTime = + currentdate.getHours() + ":" + currentdate.getMinutes()
            var CurrentTime = formatAMPM(currentdate)
            CurrentTime = CurrentTime.substring(0, 5);
            //Project_Flag = 0;
            if (Project_Flag == "1") {
                var objRelease = $("#CboRelease").find(':selected').val();
                var objIteration = $("#CboIteration").find(':selected').val();
                var objUserStory = $("#CboUserStory").find(':selected').val();
            }

            if ((objType == "") || (objType == 0) || (objType == null)) {
                alertify.error('Type should not be left blank.');
                document.getElementById("CboType").focus();
                return false;
            }

            if ((objSubType == "") || (objSubType == 0) || (objSubType == null)) {
                alertify.error('Sub Type should not be left blank.');
                document.getElementById("CboSubType").focus();
                return false;
            }

            if ((objStatus == "") || (objStatus == 0) || (objStatus == null)) {
                alertify.error('Status should not be left blank.');
                document.getElementById("CboStatus").focus();
                return false;
            }

            if ((objReportedBy == "") || (objReportedBy == 0) || (objReportedBy == null)) {
                alertify.error('Reported By should not be left blank.');
                document.getElementById("CboReportedBy").focus();
                return false;
            }

            if ((objReportedDate == "") || (objReportedDate == 0)) {
                alertify.error('Reported Date should not be left blank.');
                document.getElementById("dtReportedDate").focus();
                return false;
            }
            if ((objReportedTime == "") || (objReportedTime == 0)) {
                alertify.error('Reported Time should not be left blank.');
                document.getElementById("dtReportedTime").focus();
                return false;
            }

            if (Project_Flag == "1") {
                if ((objRelease == "") || (objRelease == 0) || (objRelease == null)) {
                    alertify.error('Release should not be left blank.');
                    document.getElementById("CboRelease").focus();
                    return false;
                }
                if ((objIteration == "") || (objIteration == 0) || (objIteration == null)) {
                    //Added & Commneted By dipali V On 14th Sept 2019 For Change caption iteration to Sprint
                    //alertify.error('Iteration should not be left blank.');
                    alertify.error('Sprint should not be left blank.');
                    //End of Added & Commneted By dipali V On 14th Sept 2019 For Change caption iteration to Sprint
                    document.getElementById("CboIteration").focus();
                    return false;
                }
                if ((objUserStory == "") || (objUserStory == 0) || (objUserStory == null)) {
                    alertify.error('User Story should not be left blank.');
                    document.getElementById("CboUserStory").focus();
                    return false;
                }
            }

            if (objReportedDate != null) {
                var strmessage = ValidateProjectDates(IssueProjectID, objReportedDate);
                if (strmessage == false) {
                    document.getElementById("dtReportedDate").focus();
                    return false;
                }
            }

            if (objReportedTime > CurrentTime) {
                alertify.error('Reported Time should not be greater than Current Time.');
                document.getElementById("dtReportedTime").focus();
                return false;
            }
            return true;
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

        function convertTime12to24(time12h) {
            var time = time12h;
            var hours = Number(time.match(/^(\d+)/)[1]);
            var minutes = Number(time.match(/:(\d+)/)[1]);
            var AMPM = time.match(/\s(.*)$/)[1];
            if (AMPM == "PM" && hours < 12) hours = hours + 12;
            if (AMPM == "AM" && hours == 12) hours = hours - 12;
            var sHours = hours.toString();
            //debugger
            var sMinutes = minutes.toString();
            if (hours < 10) sHours = "0" + sHours;
            if (minutes < 10) sMinutes = "0" + sMinutes;

            return sHours + ':' + sMinutes;
            // alert(sHours + ":" + sMinutes);
        }

        function ValidateProjectDates(IssueProjectID, objReportedDate) {
            try {
                issueParameters = {
                    intProjectID: IssueProjectID,
                    DtReportedDate: objReportedDate
                }
                var flag = true;
                $.ajax({
                    url: strUrl + '/api/IB_CopyIssue/validateDates',
                    type: "POST",
                    data: JSON.stringify(issueParameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (issueParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(issueParameters) ? issueParameters : JSON.stringify(issueParameters)));
                        }
                    },
                    success: function (message) {
                        //  
                        if (message != "") {
                            alertify.error(message);
                            flag = false;
                        }
                        else if (message == null) {
                            flag = true;
                        }

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                return flag;
            }
            catch (ex) {
                alert(ex.message);
            }

        }

        //FUNCTION for get Max items to show in list-set in working option
        function GetMaxItemsToShow() {

            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/GetMaxItemsToShow',
                type: "POST",
                data: {},
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    items = result;

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        //function for copying Issues
        function CopyIssues() {
            //    
            var loginId =<%=Session("intUserID")%>;

            var copyIssue = new Object();
            copyIssue.ProjectID = IssueProjectID;

            //copyIssue.IssueID = issueIDs;
            copyIssue.IssueID = issueIDs.split(',').join(' ')

            copyIssue.AssignToIDs = $("#CboResponsiblePerson").find(':selected').val();;

            copyIssue.Type = $("#CboType").find(':selected').text();

            copyIssue.SubType = $("#CboSubType").find(':selected').text();

            copyIssue.Status = $("#CboStatus").find(':selected').text();

            copyIssue.ReportedBy = $("#CboReportedBy").find(':selected').text();

            copyIssue.ReportedDate = $("#dtReportedDate").val();

            //copyIssue.ReportedTime = $("#dtReportedTime").val();
            //copyIssue.ReportedTime = copyIssue.ReportedTime.substring(0, 5).replace(' ', '');
            var reportedtime = convertTime12to24($("#dtReportedTime").val());
            copyIssue.ReportedTime = reportedtime;
            copyIssue.LoginId = loginId;
            //Added By Dipali V On 1st April 2021 For Crash Issue if Customer/Client login
            copyIssue.LoginType = "<%= Session("LoginType").ToString() %>";
             //End of Added By Dipali V On 1st April 2021 For Crash Issue if Customer/Client login
            if (Project_Flag == "1") {
                copyIssue.Release = $("#CboRelease").find(':selected').val();

                copyIssue.Iteration = $("#CboIteration").find(':selected').val();

                copyIssue.UserStory = $("#CboUserStory").find(':selected').val();
            }
            var objCopyIssue = "";
            if (Project_Flag == "1") {
                objCopyIssue = [copyIssue.ProjectID, copyIssue.IssueID, copyIssue.AssignToIDs, copyIssue.Type, copyIssue.SubType, copyIssue.Status, copyIssue.ReportedBy, copyIssue.ReportedDate, copyIssue.ReportedTime, copyIssue.LoginId,copyIssue.LoginType , copyIssue.Release, copyIssue.Iteration, copyIssue.UserStory];
            }
            else {
                objCopyIssue = [copyIssue.ProjectID, copyIssue.IssueID, copyIssue.AssignToIDs, copyIssue.Type, copyIssue.SubType, copyIssue.Status, copyIssue.ReportedBy, copyIssue.ReportedDate, copyIssue.ReportedTime, copyIssue.LoginId,copyIssue.LoginType, "", "", ""];
            }
            //Added By Riddhesh Patil on 31st March 2023
            var objcopyIssue = objCopyIssue.toString();
          //End of Added By Riddhesh Patil on 31st March 2023
            $.ajax({
                url: strUrl + '/api/IB_CopyIssue/CopyIssues',
                method: 'Post',
                dataType: 'json',
                data: JSON.stringify(objcopyIssue),
                contentType: "application/json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (objcopyIssue) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objcopyIssue) ? objcopyIssue : JSON.stringify(objcopyIssue)));
                    }
                },

                success: function (result) {
                    //                    
                    setTimeout(function () {
                        $(".copyloaderimg").css("display", "none");
                        if (result != "") {
                            alertify.success(result);
                        }
                        if (countchecked == 1) {

                            $("#WaitText").text('');
                            $("#countforcopy").text('');
                            $("#MsgCopy").html('Copied [' + countchecked + '] Issue Successfully');

                        }
                        else {

                            $("#WaitText").text('');
                            $("#countforcopy").text('');
                            $("#MsgCopy").html('Copied [' + countchecked + '] Issues Successfully');

                        }
                        //modified by pradip on 11-12-2019
                        //$('#step4 ul li').html('<a href="javascript:;" onclick="backlink()" type="button" class="btn borderbtn ml-1 ">Back</a>&nbsp&nbsp<a class="gofirst" href="#step1" data-bs-toggle="tab" onclick="Load_Page()">Add More</a> ');
                        $('#step4 ul li').html('<a href="javascript:;" onclick="backlink()" type="button" class="btn borderbtn ml-1 ">Back</a>&nbsp&nbsp<a class="gofirst btn borderbtn" href="#step1" data-bs-toggle="tab" onclick="Load_Page()">Add More</a> ');
                        //modified by pradip on 11-12-2019
                    }, 5000);



                },
                error: function (err) {
                    alert(err.responseText)
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });


        }


        function Pagination() {

            $('#copywizardtbl').dataTable({
                "pageLength": items,
                "lengthChange": false,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollY": "auto",
                "bAutowidth": "false",
                "scrollCollapse":"false",
                //"orderable":true,
                //"aaSorting": [[ 0, "desc" ]] ,
                'columnDefs': [{
                    'targets': [8], /* column index */
                    'orderable': false, /* true or false */

                }]
            });
            //Added by Chetan M on 6 Jan 2021 for UI distrub issue
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
            //End of Added by Chetan M on 6 Jan 2021 for UI distrub issue
        }


        function backlink() {
            var A = $(parent.document.getElementById('mainHeadingTop'));
            A.text("");
            A.text("Issues >  Issues");
            //Added by Swapnagandha K. for Session Project Issue On 18-Oct-2019
            window.location.href = "IssueList.aspx?FromWhere=Issue&View=" + viewApplied + "&ViewType=" + '<%= Request.QueryString("ViewType")%>' + "";
            //EndAdded by Swapnagandha K. for Session Project Issue On 18-Oct-2019
        }

        function Load_Page() {
            $(document).on("click", ".gofirst", function () {
                //   
                //StartLoader("#Body_CopyIssues");
                //$('.wizard .nav-wizard li a.active').removeClass('active');
                //$("ul.nav-wizard li:first-child a").addClass("active");
                //$("#step4").removeClass("active");
                //$("#step1").addClass("active");

                $('a[href="#step1"]').tab('show');

                $("#cboProject").val(0);
                //$('#CboResponsiblePerson').empty();
                var IssueProjectID = $("#cboProject").val();
                GetResponsiblePerson(IssueProjectID)
                var table = $('#copywizardtbl').DataTable();
                var rows = table.rows({ 'search': 'applied' }).nodes();
                if ($("#selectcopyissueall").prop("checked") == true) {
                    $('input[name=checkIssue]:checked', rows).each(function () {
                        this.checked = false;
                    });

                }
                $("#selectcopyissueall").prop("checked", false);
                $("#copywizardtbl").dataTable().fnDestroy();
                var table1 = $("#copywizardtbl").DataTable();

                table1.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').prop('checked', false);
                //
                CopyIssuecount = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;
                if (CopyIssuecount == 0) {
                    Project_Onchange();


                }

                //$(".chckHead").prop("checked", false);
                StopAjaxLoader("#Body_CopyIssues");

            });


        }
        
		//Added By Usha Pandit On 09.06.2020 for restricting alphabates for Reported Date and time
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
        //End Of Added By Usha Pandit On 09.06.2020 for restricting alphabates for Reported Date and time

    </script>
</body>

</html>
