<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IB_AddNewIssue.aspx.vb" Inherits="PbNIT.CreateNewIssue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <%CommonFunctions.General.PlotPageHeadTag("Issues")%>
<head>
    
    <!-- Commented by Gauri on 09/08/24 for JQuery and Bootstrap version  upgrade -->
  <%--  <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Issues</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>--%>

   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css"/>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css"/>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css"/>--%>
    <link href='../../../Whizible2.0-new/dist/css/table-fixed-header.css' rel='stylesheet'/>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_issues.css?v=6.5"/>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css"/>
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    

</head>

<style type="text/css">

    #tblFiles th, #tblFiles td {
     white-space: nowrap;
     word-wrap: break-word;
     word-break: break-all;text-align: left;
 }


 #tblMainFiles th, #tblMainFiles td {
     word-wrap: break-word;
     word-break: break-all;
 }

 /*.addissuewrapper div#sidebarpanel {width: 38.333%;} */
 .content-wrapper, .right-side, .main-footer {
     margin-left: 0;
 }

 .fixed .content-wrapper, .fixed .right-side {
     padding-top: 0;
 }

 #dtReportedDate, #txtCustomFieldDate1, #dtReportedTime, #txtImportID, #txtCustomerIssueID1, #dtStatusChangeDate, #dtStatusChangeTime {
     height: 30px;
     border-radius: 4px;
 }

 /*table {
     background-color: #e7edf0;
 }*/


 #Attachments {
     margin-top: 2%;
 }

 textarea{
     resize:none;
 }

 #divAttachments{overflow-x:auto}
 #divAttachments #tblFiles tr td A.Menu {
     color: #337ab7 !important;
     background-color: white !important;
     word-break:inherit!important;
 }

  #divAttachments #tblFiles tr td:nth-child(4) {
    
     word-break:inherit!important;
 }

     #divAttachments #tblFiles tr td A.Menu:hover {
         background-color: white !important;
         color: #337ab7 !important;
     }

 /*#tblFiles tr td:nth-child(2) {
         word-break: normal !important;
 }*/

 .sidebarpanel .form-control{ text-align:left!important;}
 #contentfull .box-header .boxheaderbtn:hover {
     background: rgba(0,0,0,0.2)!important;}
 #contentfull .box-header .boxheaderbtn.pull-left{ left:15px;}
 #contentfull .box-header .boxheaderbtn.pull-right{ right:15px;}



 /*Added By Dipali V On 16th May 2020 For Loader Issues*/
 .preloader {
     position: absolute;
     margin-top: -25px;
     margin-left: -400px;
     top: 50%;
     left: 50%;
     padding: 30px 15px 0px;
     /* border: 3px solid #ababab; */
     /* box-shadow: 1px 1px 10px #ababab; */
     border-radius: 15px;
     background: #ddd;
     /* background-color: white; */
     background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
     /* background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; */
     width: 100px;
     height: 100px;
     background-repeat: no-repeat;
     background-position: center;
     margin: -100px 0 0 -100px;
     z-index: 1002;
     text-align: center;
 }            
 .clsShowHide {
     display: none !important;
 }

 /*End of Added By Dipali V On 16th May 2020 For Loader Issues*/

 /*added by pradip on 14-10-2020*/
 .createissuedetail .col-md-4 select, .createissuedetail .col-md-4 input {
 width: 100%!important;}
 .createissuedetail .col-md-4 .form-group .control-label {white-space: nowrap;}
 .createissuedetail .col-md-4 .form-group .control-label span{ margin-left:-5px;}
 /*end added by pradip*/

 .input-group{flex-wrap:revert}
 #sidebarpanel hr{border-top-color:#888}
 .input-group-btn button.btn.btncalendar{height:30px}

 #tblFiles th:nth-child(2){ min-width:120px;}
 #tblFiles th:last-child{ min-width:80px;}
 #tblFiles th:nth-child(3), #tblFiles th:nth-child(4), #tblFiles th:nth-child(5){min-width: 180px;}


 .bootstrap-datetimepicker-widget button{ height:30px;}
 button.multiselect:hover, button.multiselect:focus{ color: #464a4c;}
 button.btn.dropdown-toggle.btn-default{ background-color:transparent;}

 .ajs-content {
     overflow-wrap:break-word;
     word-wrap: break-word;
 }

 .ajs-message.ajs-success {
     white-space: normal;
     word-wrap: break-word;
     max-width: auto;
 }
 .ajs-message.ajs-error {
     white-space: normal;
     word-wrap: break-word;
     max-width: auto;
 }
</style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" >
   <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
    <div class="" id="bodyAddNew"></div>
     <%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
    <%--<div id="divProjectList" >--%>
         <div id="divAddIsseDetails" class="preloader">
       <%-- <div class="clsShowHide" >--%>
         <div class="clsShowHide" id="maindiv">
              <%--  /*End of Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <section class="content">

                <div class="Issuemodulewrap_main">
                    <div class="headerspacing">&nbsp;</div>

                    <div class="addissuewrapper">
                        <div class="col-md-12">
                            <div class="row row-eq-height" id="row-main">
                                <div class="col-md-6 contentfull row-eq-height" id="contentfull">

                                    <div class="box box-panel box-solid">
                                        <div class="box-header with-border">
                                            <a style="top: 10px" href="#" onclick="BackOnClick()" data-toggle="tooltip" data-container="body" data-placement="bottom" title="Back" class="btn boxheaderbtn pull-left">Back</a>
                                            <h3 class="box-title"><%= MyBase.GetResourceString("C_Add_Issue") %></h3>

                                        </div>
                                        <!-- /.box-header -->
                                        <button id="nav-icon3" type="button" class="btn btn-default toggle-sidebar togglesidebarpanelbtn">
                                            <img class="fas fa-times" src="../../../Whizible2.0-new/dist/img/closeicon-white1.svg" width="26" alt="" data-toggle="tooltip" data-placement="bottom" data-container="body" title="Hide Issue Details"/>
                                            <i class="fas fa-bars" data-toggle="tooltip" data-placement="bottom" data-container="body" title="Click here to show issue details"></i>
                                        </button>

                                        <div class="box-body" style="" id="divleft">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label class="control-label"><%= MyBase.GetResourceString("C_Project") %></label>
                                                    <div class="form-group">
                                                       <%-- Commented & Added By Dipali V On 31st March 2021 For Customer login Project should list out--%>
                                                        <%--<% 'CommonFunctions.HTMLControls.DrawComboBox("cboIssueProjects", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " & Session("intUserID")",,, "class='form-control' disabled",,, ) %>--%>
                                                    
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboIssueProjects", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " & Session("intUserID") & ",0,0,NULL,0," & Session("LoginType") & ",1,NULL,0,1,NULL,NULL",,, "class='form-control' disabled",,, ) %>
                                                    <%-- End of Commented & Added By Dipali V On 31st March 2021 For Customer login Project should list out--%>
                                                    </div>

                                                </div>
                                                <div class="col-sm-6">
                                                    <label class="control-label"><%= MyBase.GetResourceString("C_Project_Duration") %></label>
                                                    <div class="form-group">
                                                        <span id="ExpectdstatrendDate" class="mt-onehalf"></span>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>








                                            <div class="row">
                                                <div class="col-sm-12 col-md-12">
                                                    <label class="control-label" id="lblSummary"><%= MyBase.GetResourceString("C_SUMMARY") %></label>
                                                    <span id="MandatorySummary" style="color:red;">*</span>
                                                    <div class="form-group">

                                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtSummary", "message_area", "Enter Summary (Maxlength 500 Chars)", "form-control", ,,,, , , 500,,,,,,,, "Placeholder='Enter Summary (Maxlength 500 Char)' autocomplete='Off' maxlength='500'",, True,,,,,,,,) %>
                                                        <div id="textarea_message" class="alert alert-danger alert-autocloseable-danger animated fadeInRight">
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-sm-12 col-md-12" id="divDescription">
                                                    <label class="control-label" id="lblDescription"><%= MyBase.GetResourceString("C_Description") %></label>
                                                    <span id="MandatoryDescription" style="color:red;">*</span>
                                                    <div class="form-group">
                                                        <%--<% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "message_area_des", "", "form-control",,,,, , 100, 1000,,,,,,,, "Placeholder='Enter Description (Maxlength 1000 Char)' autocomplete='Off' maxlength='1000'",, True,,,,,,,,) %>--%>
                                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "", "form-control",,,,, , 100, 1000,,,,,,,, "Placeholder='Enter Description (Maxlength 1000 Char)' autocomplete='Off' maxlength='1000'",, True,,,,,,,,) %>

                                                        <span class="hint" id="textarea_message"></span>


                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <!--modified by pradip on 14-10-2020-->
                                                <div class="col-sm-7">

                                                    <div class="attacment-file">
                                                        <div class="form-group">

                                                            <div id="FileControlUploadDiv">

                                                                <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none !important;' class='clsFileControl' multiple=''", False, True)%>
                                                            </div>
                                                            <div class="input-group col-xs-12">

                                                                <span class="input-group-btn">
                                                                    <button class="btn borderbtn" id="btnSelectFile" filecount="0" onclick="SelectFile();" type="button" title="Add Attachments"><i class="fa fa-paperclip" aria-hidden="true" title="Add Attachments"></i>Add Attachment</button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-5 text-right">
                                                    <button class="btn btnyellow" id="btnSave" onclick="SaveRequest_OnClick()"><%= MyBase.GetResourceString("C_Save") %></button>
                                                    <button class="btn borderbtnred" onclick="ClearRequest_OnClick()"><%= MyBase.GetResourceString("C_Clear") %></button>
                                                </div>
                                            </div>

                                            <div id="divAttachments" class="bottom-bar" style="">
                                                <div class="row">
                                                    <div class="col-sm-12 table-responsive">
                                                        <table id="tblFiles" style="display: none; width:100%; margin-top: 1%" class="clsGridTable table table-bordered" >

                                                            <thead class="clsTRColumnHeader" align="left">
                                                                <tr>
                                                                    <th width="5%"></th>
                                                                    <th width="15%">Files</th>
                                                                    <th width="12%" width="49%">Comments</th>
                                                                    <th>Document Type <span style="color:red;">*</span></th> <%--//Added By Dipali V On 5th April 2023 For Focus to Control--%>                                                                                
                                                                    <th width="20%">Document Sub Type</th>                                                                                
                                                                    <th width="25%">Remove</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>
                                        <!-- /.box-body -->

                                    </div>

                                </div>

                                <div class="col-md-6 sidebarpanel" id="sidebarpanel">
                                    <div class="formpanel createissuedetail">

                                        <div class="box box-panel box-solid">
                                            <div class="box-header with-border">
                                                <h3 class="box-title"><%= MyBase.GetResourceString("C_Issue_Details") %></h3>
                                            </div>
                                            <!-- /.box-header -->

                                            <div class="box-body">

                                                <div class="row copyissue">
                                                    <label class="col-sm-5 col-md-5 pt-Onehalf"><%= MyBase.GetResourceString("C_Copy_from_issue_ID") %></label>
                                                    <div class="col-sm-8 col-md-7">

                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboIssueId", "Select 0,'Select Issue ID' ",,, "class='form-control'",,, ) %>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                            <hr />

                                            <div class="box-body" id="boxbodyProductFields">
                                                <div class="boxformheading" id="divProductFields"><strong><%= MyBase.GetResourceString("C_Product_Fields") %></strong></div>
                                                <div class="row" id="rowProductFields">
                                                    <div class="col-md-4" id="divCustomerIssueID">
                                                        <div class="form-group">
                                                            <label class="control-label" id="lblCustomerIssueID"><%= MyBase.GetResourceString("C_Customer") %>&nbsp;&nbsp;&nbsp;<span id="MandatoryCustomerIssueID" style="color: red;">*</span></label>

                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerIssueID", "EXEC usp__Whizible2_Sel_tbl_PM_Customer_ProductExecution",,, "class='form-control' onchange='Customer_OnChange(this.value)' ",,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4" id="">
                                                        <div class="form-group">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Product") %>&nbsp;&nbsp;&nbsp;<span id="MandatoryProduct" style="color: red;">*</span></label>


                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Select 0,'Select Product' ",,, "class='form-control' onchange='ProductVersion_OnChange(this.value)' ",,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Module") %></label>

                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Select 0,'Select Module' ",,, "class='form-control'",,, ) %>
                                                        </div>
                                                    </div>
                                                </div>
                                        
                                                <div class="clearfix"></div>
                                            </div>

                                            <hr />

                                            <div class="box-body">
                                                <div class="boxformheading"><strong><%= MyBase.GetResourceString("C_Common_Fields") %></strong></div>
                                                <div id="divControlPloat">
                                                    <div id="controlploat" style="display: none;">


                                                        <div class="row">
                                                            <div id="divReportedBy">
                                                                <div class="form-group">

                                                                    <label class="control-label" id="lblReportedBy"><%= MyBase.GetResourceString("C_Reported_By") %></label>
                                                                    <div class="form-group">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedBy", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy'," & Convert.ToInt32(Session("IssueProject").ToString()) & "," & Convert.ToInt32(Session("intUserID").ToString()) & ",1,NULL,NULL,'" & Session("LoginType") & "','New',0",,, "class='form-control ' ",,, ) %>
                                                                    </div>


                                                                </div>
                                                            </div>
                                                            <div id="divReportedDate">
                                                               <%-- <div class="form-group">
                                                                    <label class="control-label" id="lblReportedDate"><%= MyBase.GetResourceString("C_Reported_Date") %></label>
                                                                    <div class="form-group">

                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedDate", "dtReportedDate", "form-control", 50, 200,,,, , ,,, "style='background-color: white;' autocomplete='off'",,, True,,,, True) %>
                                                                    </div>
                                                                </div>--%>
                                                                 <!--Added By Yasmin for calnder icon on 23-9-19-->
                                                                  <div class="form-group">
                                                                     <label class="control-label" id="lblReportedDate"><%= MyBase.GetResourceString("C_Reported_Date") %></label>
                                                                    <div class="input-group">
                                                                        <%--Commented And Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time--%>
                                                                      <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtReportedDate", "dtReportedDate", "form-control", 50, 200,,,, , ,,, "style='background-color: white;' autocomplete='off'",,, True,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedDate", "dtReportedDate", "form-control", 50, 200,,,, , ,,, "style='background-color: white;' onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'",,, True,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time--%>
                                                                    <span class="input-group-btn">
                                                                       <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                    </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divReportedTime">
                                                             <%--   <div class="form-group">
                                                                    <label class="control-label" id="lblReportedTime"><%= MyBase.GetResourceString("C_ReportedTime") %></label>
                                                                    <div class="form-group">

                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedTime", "dtReportedTime", "form-control", 50, 200,,,, ,,,, "autocomplete='off'",,, True,,,, True) %>
                                                                    </div>
                                                                </div>--%>

                                                                 <!--Added By Yasmin for calnder icon on 23-9-19-->
                                                                  <!--Added By Yasmin for clock icon on 23-9-19-->
                                                                <div class="form-group">
                                                                   <label class="control-label" id="lblReportedTime"><%= MyBase.GetResourceString("C_ReportedTime") %></label>
                                                                    <div class="input-group">
                                                                        <%--Commented And Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtReportedTime", "dtReportedTime", "form-control", 50, 200,,,, ,,,, "autocomplete='off'",,, True,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedTime", "dtReportedTime", "form-control", 50, 200,,,, , True, "white",, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'",,, True,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time--%>
                                                                    <span class="input-group-btn">
                                                                         <button class="btn btncalendar" type="button"><i class="far fa-clock"></i></button>
                                                                    </span>
                                                                    </div>
                                                            </div>
                                                        </div>


                                                        <div class="row">
                                                            <div id="divType">

                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblType"><%= MyBase.GetResourceString("C_Type") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboType", "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & Convert.ToInt32(Session("IssueProject").ToString()) & ",'T',Null,Null,Null,Null,Null," & Convert.ToInt32(Session("intPostID").ToString()),,, "class='form-control' onchange='Type_OnChange(this.value)'",,, ) %>
                                                                </div>
                                                            </div>

                                                            <div id="divSubType">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblSubType"><%= MyBase.GetResourceString("C_Sub_Type") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboSubType", "Select 0,'Select Sub Type' ",,, "class='form-control'",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divStatus">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblStatus"><%= MyBase.GetResourceString("C_Status") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "Select 0,'Select Status' ",,, "class='form-control'",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div id="divCodedByName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblCodedByName"><%= MyBase.GetResourceString("C_CodedBy") %> </label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCodedByName", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " & Convert.ToInt32(Session("IssueProject").ToString()) & ", NULL ,NULL, NULL, NULL ," & "'" & Session("LoginType") & "','New',0 ",,, "class='form-control'",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divRelease">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblRelease"><%= MyBase.GetResourceString("C_Release") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRelease", "usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseID " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' onchange='Release_OnChange(this.value)' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divIteration">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblIteration"><%= MyBase.GetResourceString("C_Sprint") %></label>


                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboIteration", "Select 0,'Select Sprint' ",,, "class='form-control ' onchange='Iteration_OnChange(this.value)' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div id="divUserStory">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblUserStory"><%= MyBase.GetResourceString("C_User_Story") %></label>


                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "Select 0,'Select User Story' ",,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divStatusChangeDate">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblStatusChangeDate"><%= MyBase.GetResourceString("C_StatusChangeDate") %></label>
                                                                    <div class="form-group">
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeDate", "dtStatusChangeDate", "form-control", 50, 200,,,, , True, "white",,,,, True,,,, True) %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divStatusChangeTime">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblStatusChangeTime"><%= MyBase.GetResourceString("C_StatusChangeTime") %></label>
                                                                    <div class="form-group">
                                                                        <%--Commented And Added By Usha Pandit On 10.06.2020 for restricting alphabates for Status Change Date and time--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeTime", "dtStatusChangeTime", "form-control", 50, 200,,,, ,,,,,,, True,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeTime", "dtStatusChangeTime", "form-control", 50, 200,,,, , True, "white",, "Placeholder='Status Change Time' onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'",,,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 10.06.2020 for restricting alphabates for Status Change Date and time--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div id="divDeliverableID">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblDeliverableID"><%= MyBase.GetResourceString("C_Deliverable") %></label>


                                                                    <%--  <% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableID", "Exec usp_Whizible_2_Sel_tbl_PM_ProjectSchedule " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableID", "Exec usp_Sel_tbl_PM_ProjectSchedule " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>

                                                            <div id="divPriority">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblPriority"><%= MyBase.GetResourceString("C_Priority") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "Exec usp_Whizible2_Sel_tbl_IB_Project_Priorities " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>

                                                            <div id="divSeverity">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblSeverity"><%= MyBase.GetResourceString("C_Severity") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "Exec usp_Whizible2_Sel_tbl_IB_Project_Severity " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="row">
                                                            <div id="divComplexity">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblComplexity"><%= MyBase.GetResourceString("C_Complexity") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "Exec usp_Whizible2_Sel_tbl_IB_Project_Complexity " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divRootCauseID">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblRootCauseID"><%= MyBase.GetResourceString("C_RootCauseID") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRootCauseID", "Exec usp_Whizible2_Sel_tbl_IB_Project_RootCause " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divModuleName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblModuleName"><%= MyBase.GetResourceString("C_ModuleName") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboModuleName", "Exec usp_Whizible2_Sel_tbl_PM_Module_ProjectGroup " & Convert.ToInt32(Session("IssueProject").ToString()) & ",NULL",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divChangeRequestName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblChangeRequestName"><%= MyBase.GetResourceString("C_ChangeRequestName") %>	</label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestName", "Exec usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master  " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divAssignToName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblAssignToName"><%= MyBase.GetResourceString("C_AssignToName") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboAssignToName", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & Convert.ToInt32(Session("IssueProject").ToString()) & ",NULL",,, "class='form-control'",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divReportedInVersion">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblReportedInVersion"><%= MyBase.GetResourceString("C_ReportedInVersion") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedInVersion", "Exec usp_Whizible2_Sel_tbl_IB_Project_Version  " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divCorrectedInVersion">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblCorrectedInVersion"><%= MyBase.GetResourceString("C_CorrectedInVersion") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCorrectedInVersion", "Exec usp_Sel_tbl_IB_Project_Version " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divPhase">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblPhase"><%= MyBase.GetResourceString("C_Phase") %>	</label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPhase", "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup  " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divFoundInPhase">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblFoundInPhase"><%= MyBase.GetResourceString("C_FoundInPhase") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboFoundInPhase", "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup  " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divFixedInPhase">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblFixedInPhase"><%= MyBase.GetResourceString("C_FixedInPhase") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboFixedInPhase", "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup  " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divImportID">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblImportID"><%= MyBase.GetResourceString("C_ImportID") %></label>
                                                                    <div class="form-group">
                                                                        <%--Commented And Added By Usha Pandit On 04.06.2020 for restricting alphabates for Import ID--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtImportID", "txtImportID", "form-control", 50, 25, ,,, ,,,, "autocomplete='off'",,, True,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtImportID", "txtImportID", "form-control", 50, 25, ,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 04.06.2020 for restricting alphabates for Import ID--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divCustomerIssueID1">
                                                                <div class="form-group">
                                                                   <%-- Added & Commented By Dipali V On 16th April 2020 For Caption as per layout--%>
                                                                     <%--<label class="control-label" id="lblCustomerIssueID1"><%= MyBase.GetResourceString("C_CustomerIssueID1") %></label>--%>
                                                                    <label class="control-label" id="lblCustomerIssueID1">Duplicate Issue ID</label>
                                                                    <%--Commented And Added By Usha Pandit On 07.01.2021 For passing correct available max length for CustomerIssueID field --%>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomerIssueID1", "txtCustomerIssueID1", "form-control", 50, 200,,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, True) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtCustomerIssueID1", "txtCustomerIssueID1", "form-control", 50, 30,,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, True) %>
                                                                    <%--End Of Added By Usha Pandit On 07.01.2021 For passing correct available max length for CustomerIssueID field --%>
                                                                    <%--End Of Added By Usha Pandit On 04.06.2020 For restricting alphabates for Duplicate Issue ID--%>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divShowToCustomer">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblShowToCustomer"><%= MyBase.GetResourceString("C_ShowToCustomer") %>	</label>
                                                                    <br />
                                                                    <center>
                                                
                                               <% CommonFunctions.HTMLControls.DrawCheckBox("chkShowToCustomer", "chkShowToCustomer") %>
                                            </center>
                                                                </div>
                                                            </div>
                                                            <div id="divHardware">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblHardware"><%= MyBase.GetResourceString("C_Hardware") %>	</label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboHardware", "Exec usp_Whizible2_Sel_tbl_PM_ProjectHardware " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divOS">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblOS"><%= MyBase.GetResourceString("C_OS") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboOS", "Exec usp_Whizible2_Sel_tbl_IB_Project_OS " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divKernel">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblKernel"><%= MyBase.GetResourceString("C_Kernel") %></label>

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboKernel", "Exec usp_Whizible2_Sel_tbl_IB_Project_Kernels " & Convert.ToInt32(Session("IssueProject").ToString()),,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                          <div class="clearfix"></div>
                                                  <div id="divControlPloatDuplicated" style="display:none"></div>
                                            </div>
                                            <hr />
                                            <div class="box-body">
                                                <div class="boxformheading"><strong><%= MyBase.GetResourceString("C_Custom_Field") %></strong></div>
                                                <%--Added by imran on 03-03-2022 --%>
                                                <%--<div style="color:black;margin-bottom:15px;" ><strong> Note:Default value for custom fields will be shown after saving the issue. </strong> </div>--%>
                                                <div style="color:black;margin-bottom:15px;" ><strong> Note:Dynamic default value for custom fields will be shown after saving the issue. </strong> </div>
                                                <%--Comment End by imran on 03-03-2022 --%>
                                                <div class="dynamicstfield" id="CustomFiledsControl"></div>                                              
                                            </div>

                                        </div>
                                        <!-- /.box-body -->
                                    </div>


                                </div>
                            </div>

                        </div>
                    </div>
                </div>


                <!--bootstrap_Alertify-->
                <div class="alert alert-success autoclosablemsg alert-autocloseable-success animated slideInRight" hidden="hidden">
                    <button type="button" class="close">×</button>
                    I'm an autocloseable success  message. I will hide in few seconds.
                </div>
                <!--bootstrap_Alertify-->

                <div id="abcdd">
                    <div>
                    </div>
                </div>

                <div class="clearfix"></div>
        </section>
            <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

             </div>
             </div>

    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-datetimepicker.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?v=1.8"></script>    
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script type="text/javascript">
        var viewApplied;

        var commonpropertyI;
        $(document).ready(function () {

            

            $(".toggle-sidebar").click(function () {
                $(this).toggleClass('topen');
                $("#sidebarpanel").toggleClass("collapsed");
                $("#contentfull").toggleClass("col-md-12 col-md-6");

                return false;
            });




        });
    </script>
    <script type="text/javascript">

        $(function () {
            $('#dtReportedTime, #dtStatusChangeTime').datetimepicker({
                defaultDate: new Date(),
                // var now = new Date();
                format: 'HH:mm',
                icons:
                {
                    up: 'fas fa-chevron-up',
                    down: 'fas fa-chevron-down'
                },

            });
        });

        $(function () {
            //Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
           // $('#dtReportedDate, #dtStatusChangeDate').datetimepicker(
            $('#dtReportedDate').datetimepicker(
                //End of Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
            );
        });
        var Alldiv;
        //character_limit	
           var CurrentVersion = "";
        $(document).ready(function () {
            
           <%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
               $("#divAddIsseDetails").removeClass("center");
                $("#divAddIsseDetails").removeClass("preloader");
            $("#maindiv").removeClass('clsShowHide');
            $("#divControlPloatDuplicated").html($("#controlploat").clone());
           
           <%--  /*End of Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>            
            //m_blnAddAccess


            StartLoader("#bodyAddNew");
            var accessright = "<%= m_blnAddAccess %>";
            viewApplied = '<%=ViewApplied%>';
            //alert(accessright);
            if (accessright == "True") {
                $("#btnSave").show();
            } else {

                $("#btnSave").hide();
            }




            ////hide img tag after show text area
            $('#contentfull  div  div.box-body  div  img').hide();


            //var cboId = ["ReportedBy", "Type", "Release", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "AssignToName", "CustomerIssueID"];
            //var cboId = ["ReportedBy", "Type", "Release", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "CustomerIssueID"];
            var cboId = ["ReportedBy", "Type", "Release", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel"];

            //AppendOptioncbo("Type");
            for (var i = 0; i < cboId.length; i++) {
                // AppendOptioncbo(cboId[i]);

                AppendOptioncbo(cboId[i], "");
            }
            $("#sidebarpanel  div  div  div:nth-child(8)  div:nth-child(3)  div  div  img").hide();

            jQuery("select#cboCustomerIssueID option[value=" + 0 + " ]").attr("selected", "selected");



            var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";

            var ProjectID = '<%= Session("IssueProject") %>';
            var UserName = "<%= Session("strUserName").ToString() %>";
            var RoleId = "<%=IssueRoleId%>";
            var EmployeeId = "<%= Session("intUserID").ToString() %>";
            var LoginType = "<%= Session("LoginType").ToString() %>";
            var LoginId = "<%= Session("intLoginID").ToString() %>";
            //alert(RoleId);
            ////stroed all variable in common property
            var commonProperty = { ProjectId: ProjectID, RoleId: RoleId, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginId, strMode: 'New' };
            commonpropertyI = commonProperty
            //// this is use for set project on dorp down by using porject id session 
            jQuery("select#cboIssueProjects option[value=" + ProjectID + " ]").attr("selected", "selected");
            $('#cboIssueProjects').change();
            // getbinddefualtdatacbo("IssueProjects",ProjectID);
            ////get the date and put on Projecet duration field
            ExpectdstatrendDate(ProjectID);
      
            ////this function use for ploating all control using project id
            GetControlPloatingProject(ProjectID, commonProperty);

            ////get serverdatatime put in Reported Date Field
            //Alldiv = $("#controlploat").clone();
           // $("#controlploat").remove();
            //$( "#controlploattable" ).before(Alldiv);
            //  $("#cboSeverity option[value=0]").prop('selected', true);
            $('#cboSeverity  option').filter(function () {
                return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
            }).remove();

            //RemoveRow(14,3); -- not working

            getServerDateTime();


            ////this funtion user for ploating Product field contorl 
            ProductFiledFlag(commonProperty);


            ////bind project issueid on issue id droup down list
            GetIssueIDs(commonProperty);
            //
            // PloatCustomControl1(ProjectID, null, RoleId,LoginType,EmployeeId);
          //  PloatCustomControl1(ProjectID, Type, RoleId, LoginType, EmployeeId);
            ////this is used for set UserName in reported by droup down list

            //debugger;
            $("#cboReportedBy option:contains(" + UserName + ")").prop('selected', true);
            //DefaultValue(ProjectID, null, "PageLoad");
         
            ////This is used for when we click on project droup down list and select any project then call 
            //Commented By dipali V 12th Sep for deliveriable drop bind issue
            //$("#cboIssueProjects").change(function () {


            $("#controlploattable").remove();
            // $('#cboDeliverableID').empty();
            $('#divControlPloat').html(Alldiv);
            // $("#controlploattable").before(Alldiv);

            // Alldiv = [];
            Alldiv = null;
            commonProperty = null;
             // var LoginType = "<%= Session("LoginType").ToString() %>";
            // var ProjectId = $(this).find(':selected').val();
            var ProjectId = $(this).find(':selected').val();

            commonProperty = { ProjectId: ProjectId, RoleId: RoleId, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginId, strMode: 'New' };

            //// this is use for set project on dorp down by using porject id session 
            jQuery("select#cboIssueProjects option[value=" + ProjectId + " ]").attr("selected", "selected");

            ////get the date and put on Projecet duration field
            ExpectdstatrendDate(ProjectId);

            ////get serverdatatime put in Reported Date Field
            getServerDateTime();


            ////this funtion use for get reported by data given project and bind on reported by field
            ReportedBY(commonProperty);

            ////this is used for set UserName in reported by droup down list
            //Added & Commented By Dipali V On 14th Sep 2019 For Quote Issue
            // jQuery("select#cboReportedBy option[value=" + UserName + " ]").attr("selected", "selected");
            jQuery("select#cboReportedBy option[value='" + UserName + "'  ]").attr("selected", "selected");
            //End of Added & Commented By Dipali V On 14th Sep 2019 For Quote Issue
            jQuery("select#cboIssueProjects option[value=" + ProjectId + " ]").attr("selected", "selected");

            GetType(commonProperty);

            ////bind project issueid on issue id droup down list
            GetIssueIDs(commonProperty);
            //bind realseid on realse droup down
            GetRelease(commonProperty);
            //// bind data on Severity droup down list
            GetSeverity(commonProperty);
            ////bind data on Kernel droup down list
            GetKernel(commonProperty);
            ////bind data on DeliverableID droup down list
            // 
            //
            GetDeliverableID(commonProperty);
            ////bind data on Priorities droup down list
            GetPriorities(commonProperty);

            //CodedByProjectRootCauseGetModuleGetChangeRequestMasterGetProjectVersionGetPhaseGetHardwareGetOS
            CodedBy(commonProperty);
            AssignTo(commonProperty);
            ProjectRootCause(commonProperty);
            GetModule(commonProperty);
            GetChangeRequestMaster(commonProperty);
            GetProjectVersion(commonProperty);
            GetPhase(commonProperty);
            GetHardware(commonProperty);
            GetOS(commonProperty);
            $('#cboSubType').empty();
           //$('#cboStatus').empty();
            AppendOptioncbo("SubType", "");
            //AppendOptioncbo("Status", "");


            GetControlPloatingProject(ProjectId, commonProperty);
            ProductFiledFlag(commonProperty);
            $("#CustomFiledsControl").empty();

            //Commented By imran on 15-02-2022
            //PloatCustomControl1(ProjectId, Type, RoleId, LoginType, EmployeeId);
            //End Of Comment By imran on 15-02-2022

            Alldiv = $("#controlploat").clone();
            $("#controlploat").remove();
            DefaultType = null;
            DefaultSubType = null;

            DefaultValue(ProjectId, null, "PageLoad");
            //commonProperty = null;
            ProjectId = null;
            GetDefaultVersion(ProjectID);
            ////show tooltip on dorup down list mouse over 
            tooltipshow();

             //added by Vishal Mahajan 27-11-2019 to clear status, reported by, release, sprite and user story
             clearNewIssueControls();
             //end by Vishal Mahajan 27-11-2019 to clear status, reported by, release, sprite and user story   

            // });
            //End of Commented By dipali V 12th Sep for deliveriable drop bind issue
            $("#lblStatusChangeTime").html(function (i, html) {
                return html.replace(/&nbsp;/g, '');
            });


            $("#cboIssueId").change(function ()
            {
                StartLoader("#bodyAddNew");
                var LoginType = "<%= Session("LoginType").ToString() %>";
                var ProjectID = $("#cboIssueProjects :selected").val();
                if ($("#cboIssueId").val() != "0") {
                    var commonProperty = { ProjectId: ProjectID, RoleId: RoleId, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginId, strMode: 'CopyIssue' };
                    var issueid = $(this).children("option:selected").text();
                    getServerDateTime();
                    ///alert(CommonProperty);
                    //alert(commonProperty);
                    GetValueByIssueId(issueid, commonProperty);//cboIssueId

                    //added by Vishal Mahajan 27-11-2019 to clear status, reported by, release, sprite and user story   
                    //Commented By Usha Pandit On 25.05.2021 for getting fields selected on copy issue
                    //clearNewIssueControls();
                    //Commented By Usha Pandit On 25.05.2021 for getting fields selected on copy issue
                    //end by Vishal Mahajan 27-11-2019 to clear status, reported by, release, sprite and user story   

                    ////show tooltip on dorup down list mouse over 
                    tooltipshow();
                    StopAjaxLoader("#bodyAddNew");
                }
                else
                {
                    clearallcontrols();
                    StopAjaxLoader("#bodyAddNew");
                }
            });

            var name = $("#EmployeeName").text();

            ////text area allowed only 1000 charcter validation
            var maxchars = 1000;
            var remain;
            $('textarea').keyup(function () {

                var name = $(this).attr('name');

                //if (name == 'txtSummary' || name == 'txtDescription') {

                //    if (remain != 0) {
                //        var tlength = $(this).val().length;
                //        $(this).val($(this).val().substring(0, maxchars));
                //        var tlength = $(this).val().length;
                //        remain = maxchars - parseInt(tlength);
                //    }
                //    else {


                //        alertify.set('notifier', 'position', 'top-right');
                //        alertify.notify("Maximum Charter length 1000.", 'error', 25);
                //        var tlength = $(this).val().length;
                //        $(this).val($(this).val().substring(0, maxchars));
                //        var tlength = $(this).val().length;
                //        remain = maxchars - parseInt(tlength);

                //    }
                //}
                //$('#remain').text(remain);
            });


            tooltipshow();
            StopAjaxLoader("#bodyIssueList");
        });

        // controlploat

        //Added By Usha Pandit On 04.06.2020 for restricting alphabates for Duplicate Issue ID
        function restrictAlphabets(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        //End Of Added By Usha Pandit On 04.06.2020 for restricting alphabates for Duplicate Issue ID

        //Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time
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
        //End Of Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time

        //added By dipali V On 12th Aug 2019 to clear all control values
        var selectProejctId = "";
        function clearallcontrols() {
            selectProejctId = $("#cboIssueProjects").val();

            $("#controlploattable input,select,checkbox,file").each(function () {
                // 
                // alert(this.type);
                if (this.type == 'text') {
                    $(this).val("");
                }
                else if (this.type == 'select-one') {
                    if ($(this).val() != "0") {
                        $(this).val("0");
                    }
                }
                else if (this.type == 'checkbox') {
                    $(this).attr("checked", false);
                }
                else if (this.type == 'file') {

                    $(this).val("");


                }

            });


            $('#dtReportedTime, #dtStatusChangeTime').datetimepicker({
                format: 'LT',
                icons:
                {
                    up: 'fas fa-chevron-up',
                    down: 'fas fa-chevron-down'
                },

            });
            //Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
            //$('#dtReportedDate, #dtStatusChangeDate').datepicker({
            $('#dtReportedDate').datepicker({
                //End of Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy'

            });
            //var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            //    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            //var d = new Date();
            //var dt = d.getDate() + " " + months[d.getMonth()] + " " + d.getFullYear();
            //$('#dtReportedDate').val(dt);
            $("#cboIssueProjects").val(selectProejctId);
            getServerDateTime();
            //$("#cboIssueProjects option[value=" + ProjectId + " ]").attr("selected", "selected");
            //End of added By dipali V On 12th Aug 2019 to clear all control values
        }

        //added by Vishal Mahajan 27-11-2019 to clear status, reported by, release, sprite and user story   
        function clearNewIssueControls() {
            $("#cboRelease,#cboIteration,#cboUserStory").val(0);
        }
        //end by Vishal Mahajan 27-11-2019 to clear status, reported by, release, sprite and user story   
    </script>
    <script>
        //Added By Rehan C 
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var flag;
        var customerid;
        var ProductVersionID;
        var commonProperty;
        var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";
        var activerow = new Array();
        var activeControlIds = new Array();
        var DefaultType;
        var DefaultSubType;
        var DefaultStatus;
        var DefaultPriority;
        var DefaultSeverity, DefaultComplexity;
        var Summary;
        var Type;
        var Description;
        var ProjectName;
        var ResponsiblePerson;
        var ValidationMessage = new Array();
        var ValidationValidateID = new Array();
        function tooltipshow() {
            $('select').mouseover(function () {
                var CBOID = this.id;
                var textvalue = $("#" + CBOID + " :selected").text();
                $("#" + CBOID).attr('title', textvalue);
                $('[data-toggle="tooltip"]').tooltip();
            });
        }


        function validtetoken(paramter) {
            var validatedparameter = paramter;
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/ValidatedToken',
                type: 'POST',
                // data:JSON.stringify(projectId),
                data: JSON.stringify(validatedparameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {

                    if (result != true) {
                        window.location();
                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }

        ////this is function used for plaoting some control by using projecct id 
        function GetControlPloatingProject(projectId, commonproperty) {

            //// this created for ploating itreation , userstory,release control 
            var Project_Flag;
            var MaxRows;
            var MaxCols;
            var IsIssueSLAApplicable;
            var Layoutdetails;
            var ListFiled;
            var ProjectId = parseInt(projectId);
            //var commonProperty = commonproperty;
            var commonProperty = {
                ProjectId: commonproperty.ProjectId,
                LoginType: commonproperty.LoginType,
                EmployeeId: commonproperty.EmployeeId,
                IssueID: commonproperty.IssueID,
                RoleId: commonproperty.RoleId,
                LoginId: commonproperty.LoginId,
                strMode: commonproperty.strMode
            }
            ////get project flag and stored variable Project_Flag
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetLayoutProjectFlag',
                type: 'POST',
                // data:JSON.stringify(projectId),
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
                    layoutid = result[2];
                    MaxRows = result[3];
                    MaxCols = result[4];
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


            if ($("#cboType").val() != "" || $("#cboType").val() != 0) {
                Type = $("#cboType").val();
            } else {
                Type = '';
            }

            CreateTable(MaxRows, MaxCols);

            ////this is used for ploat coomon control 
            ////get the list of Issue layout details 

            var roleid =  "<%= Session("intPostID").ToString() %>";
            var LayoutControl = { ProjectId: projectId, RoleId: parseInt(roleid), Type: Type,Mode:"Add"};
            $.ajax({
                //url: url + '/api/IB_AddNewIssue/GetStartEndDate',
                url: encodeURI(url) + '/api/IB_AddNewIssue/IssueControlLists',
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

                    //var res = result[0];

                    //if (res.ResultFlag == true) {
                    //    alert("input parameter have use special charcter");

                    //} else {
                        Layoutdetails = result;

                        ListFiled = ["Description", "Summary", "ReportedDate", "ReportedTime", "ReportedBy", "Type", "SubType", "Status", "Release", "Iteration", "UserStory", "StatusChangeDate", "StatusChangeTime", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "ImportID", "CustomerIssueID", "ShowToCustomer", "Hardware", "OS", "Kernel", "AssignToName"];

                        // $("#DivControlPlot").html("");
                        for (var i = 0; i < result.length; i++) {


                            var layoutcontrolobject = result[i];


                            var filed = ListFiled[i];

                            ////this is used for check from output layoutcontrolobject.FieldName value exist or not in ListFiled array
                            //// this is creatd instead of many if else condtion or switch case .this is used for increse code resubality and reduce code complicity
                            if (ListFiled.indexOf(layoutcontrolobject.FieldName) > -1) {

                                ////this is declare for strod control prefix like if we wolud ploat text box control then this id will txtDeDescription

                                var cntrlprefix;
                                if (layoutcontrolobject.FieldName == "Description" || layoutcontrolobject.FieldName == "Summary" || layoutcontrolobject.FieldName == "ImportID" || layoutcontrolobject.FieldName == "CustomerIssueID") {
                                    if (layoutcontrolobject.FieldName == "CustomerIssueID") {
                                        layoutcontrolobject.FieldName = "CustomerIssueID1";
                                        cntrlprefix = "#txt";
                                    } else {
                                        cntrlprefix = "#txt";
                                    }
                                } else if (layoutcontrolobject.FieldName == "ReportedDate" || layoutcontrolobject.FieldName == "ReportedTime") {

                                    cntrlprefix = "#dt";

                                } else if (layoutcontrolobject.FieldName == "StatusChangeDate" || layoutcontrolobject.FieldName == "StatusChangeTime") {

                                    if (IsIssueSLAApplicable == false || commonproperty.LoginType == "C") {
                                        layoutcontrolobject.Active = false;


                                    } else {
                                        layoutcontrolobject.Active = true;

                                    }
                                    cntrlprefix = "#dt";


                                } else if (layoutcontrolobject.FieldName == "Release" || layoutcontrolobject.FieldName == "Iteration" || layoutcontrolobject.FieldName == "UserStory") {

                                    if (Project_Flag == "0") {
                                        layoutcontrolobject.Active = false;
                                    } else {
                                        layoutcontrolobject.Active = true;
                                    }
                                    cntrlprefix = "#cbo";

                                }
                                //else if (layoutcontrolobject.FieldName == "Hardware" || layoutcontrolobject.FieldName == "OS") {

                                //    //Added by Dipali V On 15th April 2021 For if active control will plot
                                //    if (layoutcontrolobject.Active == true) {
                                //        if (layoutcontrolobject.EditMode == false) {
                                //            layoutcontrolobject.Active = false;
                                //        } else {
                                //            layoutcontrolobject.Active = true;
                                //        }
                                //    } else {
                                //        layoutcontrolobject.Active = false;

                                //    }
                                //    cntrlprefix = "#cbo";
                                //    //End of Added by Dipali V On 15th April 2021 For if active control will plot
                                //}
                                else {

                                    cntrlprefix = "#cbo";
                                }

                                //Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by
                                if (layoutcontrolobject.FieldName == "ReportedBy") {
                                    layoutcontrolobject.ReadonlyEditMode = true;

                                }
                                //End of Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by
                                ////this funtion used for  ploating common control pass some parameter

                                //Commented And Added By Usha Pandit On 05.06.2020 For getting field caption
                                //CommonPloat(cntrlprefix, layoutcontrolobject.FieldName, layoutcontrolobject.Active, layoutcontrolobject.ReadOnlyAddMode, layoutcontrolobject.ControlWidth, layoutcontrolobject.Mandatory, layoutcontrolobject.RowNo, layoutcontrolobject.ColumnNo);
                                CommonPloat(cntrlprefix, layoutcontrolobject.FieldName, layoutcontrolobject.Active, layoutcontrolobject.ReadOnlyAddMode, layoutcontrolobject.ControlWidth, layoutcontrolobject.MandatoryInAdd, layoutcontrolobject.RowNo, layoutcontrolobject.ColumnNo, layoutcontrolobject.UserFriendlyName,layoutcontrolobject.AddMode);
                                //End Of Added By Usha Pandit On 05.06.2020 For getting field caption

                            } else {

                                continue;
                            }

                        }

                   // }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


            // TableWisePloat(Layoutdetails,ListFiled);
            deleterow(activerow, MaxRows);
            activerow = [];
            Project_Flag = null;
            MaxRows = null;
            MaxCols = null;
            IsIssueSLAApplicable = null;
            Layoutdetails = null;
            ListFiled = null;
            ProjectId = null;



        }

        //Commented And Added By Usha Pandit On 05.06.2020 For getting field caption
        //function CommonPloat(cntrlId, FieldName, Active, ReadOnly, ControlWidth, Mandatory, row, column) {
        function CommonPloat(cntrlId, FieldName, Active, ReadOnly, ControlWidth, Mandatory, row, column, userfriendlyname, AddMode) {
            //End Of Added By Usha Pandit On 05.06.2020 For getting field caption

            ////this is used for custom create div id and label id common filed control 
            //// the div id strate with div and label id is start with lbl
            var divId = "#div" + FieldName;
            var lblId = "#lbl" + FieldName;

            ////this is use for custom create control id that mean if we use textbox, dorpdown,datetimepicker etc .
            /// cntrlId is prefix of control id
            var controlId = cntrlId + FieldName;


            if (Active == true && AddMode == true) {

              //debugger;
                var tablepos = "#r" + row + "c" + column;

                $(divId).show();


                if (ReadOnly == true) {
                    $(controlId).attr("disabled", true);

                    activeControlIds.push(controlId);

                } else {
                    $(controlId).attr("disabled", false);

                }
                if (ControlWidth > 0) {

                    $(controlId).css('width', ControlWidth);

                }


                //Added By Usha Pandit On 05.06.2020 For setting field caption
                if (userfriendlyname != "" && userfriendlyname != null && userfriendlyname != undefined) {
                    //Added By Chetan M on 26 May 2021 for change caption issue
                if (userfriendlyname == 'Iteration') {
                    userfriendlyname = 'Sprint';
                }
                //End of Added By Chetan M on 26 May 2021 for change caption issue
                    $(lblId).text(userfriendlyname);
                }                  
                //End Of Added By Usha Pandit On 05.06.2020 For setting field caption
                //Commented & Added By Dipali V On 6th April 2023 For Check Mandatory in edit
                //if (Mandatory == true) {
                if (Mandatory == true || Mandatory == "True") {
                  //End of Commented & Added By Dipali V On 6th April 2023 For Check Mandatory in edit
                    ////create custom madatory id 
                    var requeridId = "Mandatory" + FieldName;
                    var mandatoryid = "#" + requeridId;
                    if ($(mandatoryid).length > 0) {

                    } else {
                        //// if any contorl field is mandatory then apply requeried 
                        ///// this is custom required after current control label in red color
                        //$(lblId).after("&nbsp;&nbsp;&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>");
                        if (lblId.indexOf("lblAssignToName") != -1) {
                            var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                            $(lblId).append(lblval);
                        } else {
                            var lblval = "&nbsp;&nbsp;&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                            $(lblId).append(lblval);
                        }

                    }
                } else {
                    var requeridId = "Mandatory" + FieldName;
                    var mandatoryid = "#" + requeridId;
                    $(mandatoryid).remove();
                }

 		////Added By Usha Pandit On 05.06.2020 For setting field caption
   //             if (userfriendlyname != "" && userfriendlyname != null && userfriendlyname != undefined) {
   //                 $(lblId).text(userfriendlyname);
   //             }                  
   //             //End Of Added By Usha Pandit On 05.06.2020 For setting field caption


                if (row != 0 || column != 0) {
                    var value1 = $(divId).clone();
                    $(tablepos).append(value1);
                    if (activerow.indexOf(row) == -1) {
                        activerow.push(row);

                    }

                }
            } else {
                $(divId).hide();
            }

        }


        function CreateTable(rows, columns) {


            var strtablebind = "";
            for (var i = 1; i < rows + 1; i++) {
                strtablebind += " <div class='row ' " + "id=" + "r" + i + ">";
                for (var j = 1; j < columns + 1; j++) {
                    strtablebind += "<div class='col-md-4'" + "id=" + "r" + i + "c" + j + "> </div>";

                }
                strtablebind += "</div>";

            }




           // $("#controlploat").after("<div id='controlploattable'  >" + strtablebind + "</div>");
            $("#controlploat").after("<div id='controlploattable'></div>");
            $("#controlploattable").html(strtablebind);

        }

        function deleterow(activerow1, MaxRows1) {
            // alert(MaxRows1);
            for (var i = 1; i <= MaxRows1; i++) {
                if (activerow1.indexOf(i) == -1) {
                    // alert(activerow1[i]);
                    $("#r" + i).remove();
                }
            }
        }



        ////get server date time from server
        function getServerDateTime() {

            //alert(url);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetCurrentDateTime',
                type: 'GET',
                //  data: JSON.stringify(ProjectId),
                dataType: 'json',
                //contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    //Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
                    //$('#dtReportedDate, #dtStatusChangeDate').datepicker({
                    $('#dtReportedDate').datepicker({
                        //End of Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
                        autoclose: true,
                        changeMonth: true,
                        dateFormat: 'dd M yy'

                    });
                    //var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    //    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                    //var d = new Date();
                    //var dt = d.getDate() + " " + months[d.getMonth()] + " " + d.getFullYear();

                    var tm = convertTo12Hour(result[1])
                    //Commented and added by Chetan M on 6 Jan 2021 for Date format issue
                  // $('#dtReportedDate').val(result[0]);
                    //$('#dtStatusChangeDate').val(result[0]);
                   var NewReportedDate=  result[0].split('-').join(' ');                   
                    $('#dtReportedDate').val(NewReportedDate);
                    $('#dtStatusChangeDate').val(NewReportedDate);
                    //Added By Dipali V On 5th April 2023 For Value should not change
                    $("#dtStatusChangeTime").prop("cursor", "no-drop!important");
                    $("#dtStatusChangeDate").prop("cursor", "no-dropimportant");
                     //End of Added By Dipali V On 5th April 2023 For Value should not change
                    //End of Commented and added by Chetan M on 6 Jan 2021 for Date format issue

                     //Added By Dipali V On 11th Nov 2022 For Convert Time with 24 hours
                    //$('#dtReportedTime').val(tm);
                    //$('#dtStatusChangeTime').val(tm);
                    $('#dtReportedTime').val(convertTime12to24(tm));
                    $('#dtStatusChangeTime').val(convertTime12to24(tm));
                     //End of Added By Dipali V On 11th Nov 2022 For Convert Time with 24 hours

                    $('#dtReportedTime').css('text-align', 'center');
                    $('#dtReportedTime').css('background-color', 'white');
                    $('#dtStatusChangeTime').css('text-align', 'center');
                    $('#dtReportedDate').css('text-align', 'center');
                    $('#dtStatusChangeDate').css('text-align', 'center');
                    //Added By Dipali V On 5th April 2023 For Value should not change
                    $("#dtStatusChangeTime").prop("cursor", "no-drop!important");
                    $("#dtStatusChangeDate").prop("cursor", "no-dropimportant");
                      //End of Added By Dipali V On 5th April 2023 For Value should not change

                    //$('#dtReportedTime,#dtStatusChangeTime').datetimepicker({
                    //    format: 'LT',

                    //});

                },
                error: function (xhr, errorThrown) {

                }
            });

        }

        //Added By Dipali V On 11th Nov 2022 For Convert Time with 24 hours
        function convertTime12to24(time12h) {
            var time = time12h;
            var hours = Number(time.match(/^(\d+)/)[1]);
            var minutes = Number(time.match(/:(\d+)/)[1]);
            var AMPM = time.match(/\s(.*)$/)[1];
            if (AMPM == "PM" && hours < 12) hours = hours + 12;
            if (AMPM == "AM" && hours == 12) hours = hours - 12;
            var sHours = hours.toString();
            //
            var sMinutes = minutes.toString();
            if (hours < 10) sHours = "0" + sHours;
            if (minutes < 10) sMinutes = "0" + sMinutes;

            return sHours + ':' + sMinutes;
            // alert(sHours + ":" + sMinutes);
        }
         //End of Added By Dipali V On 11th Nov 2022 For Convert Time with 24 hours

        ////get reported by list  and bind on reported by droup down list
        function ReportedBY(commonproperty) {

            var empName;

            var commonProperty =             {
                ProjectId: commonproperty.ProjectId,
                LoginType: commonproperty.LoginType,
                EmployeeId: commonproperty.EmployeeId,
                IssueID: commonproperty.IssueID,
                RoleId: commonproperty.RoleId,
                LoginId: commonproperty.LoginId,
                strMode: commonproperty.strMode
            }
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetReportedBy',
                method: 'Post',
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
                    if (result == true) {
                        alert("please dont send parameter special charter");
                    } else {
                        $("#cboReportedBy").empty();
                        for (var i = 0; i < result.length; i++) {
                            var username = result[i];
                            //Commented & Added By Dipali V On 31st March 2020 For UserName Binding Issue
                            //var s = ('<option value=' + result[i] + ' >' + result[i] + '</option>');
                            var s = ("<option value='" + result[i] + "' >" + result[i] + "</option>");
                            //End of Commented & Added By Dipali V On 31st March 2020 For UserName Binding Issue
                            $("#cboReportedBy").append(s);

                        }

                        AppendOptioncbo("ReportedBy", "");
                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }




        ////get list of subtype and bind data on subtype droup down list
        function SubType(projectId, Type) {

            if (Type == null) {

            } else {
                var newIssue = { ProjectId: parseInt(projectId), Type: Type };
                //alert(newIssue);
                $.ajax({
                    url: encodeURI(url) + '/api/IB_AddNewIssue/GetSubType',
                    method: 'Post',
                    data: JSON.stringify(newIssue),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (newIssue) {
                            xhr.setRequestHeader("Params", encryptString(isJson(newIssue) ? newIssue : JSON.stringify(newIssue)));
                        }
                    },
                    success: function (result) {

                        //alert(result.length);
                        var res = result[0];
                        if (res.ResultFlag == true) {

                            alert("input parameter have special charcter");
                        } else {

                            //cboBindData("cboSubType", result, "FieldID", "FieldName");

                            var objCbo1 = document.getElementById("cboSubType");
                            $("#cboSubType option").remove();

                            for (var i = 0; i < result.length; i++) {

                                var Objresult = result[i];
                                var objOption = document.createElement("OPTION");
                                objCbo1.options.add(objOption);
                                objOption.text = Objresult.FieldID;
                                objOption.value = Objresult.FieldName;
                            }
                            AppendOptioncbo("SubType", "");
                        }


                    },
                    error: function (xhr, errorThrown) {
                        //alert(errorThrown);
                       // alert(xhr.responseText);
                    }
                });
            }

        }

        ////get Status list and this list bind  on status droup down list
        function Status(projectId, Type, RoleId) {

            var newIssue = { ProjectId: parseInt(projectId), Type: Type, RoleId: RoleId };
            /// alert(newIssue);
            $.ajax({
                url: url + '/api/IB_AddNewIssue/GetStatus',
                method: 'Post',
                data: JSON.stringify(newIssue),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (newIssue) {
                        xhr.setRequestHeader("Params", encryptString(isJson(newIssue) ? newIssue : JSON.stringify(newIssue)));
                    }
                },
                success: function (result) {
                    var res = result[0];

                    //if (res.ResultFlag == true) {

                    //    alert("input parameter have special charcter");
                    //} else {



                    var objCbo1 = document.getElementById("cboStatus");
                    $("#cboStatus option").remove();

                    for (var i = 0; i < result.length; i++) {

                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.FieldID;
                        objOption.value = Objresult.FieldName;
                    }
                    AppendOptioncbo("Status", "");
                    // }

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            // $("#cboStatus").addClass('form-control');

        }
        //// this function use for chekc condtion product filed flag if this is true then show div of product field other wise hide.
        function getProductDevelopmentProject(projectId) {

            var newIssue = { ProjectId: parseInt(projectId) };

            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetProductExecutionProject',
                method: 'Post',
                data: JSON.stringify(newIssue),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (newIssue) {
                        xhr.setRequestHeader("Params", encryptString(isJson(newIssue) ? newIssue : JSON.stringify(newIssue)));
                    }
                },
                success: function (result) {
                   
                    //var flag = result[i];

                    //if (result[0] == true && result[1]==true) {
                    if (result == true) {
                        $('#boxbodyProductFields').show();
                        $('#divProductFields').show();
                        $('#rowProductFields').show();
                    } else {

                        $('#boxbodyProductFields').hide();
                        $('#divProductFields').hide();
                        $('#rowProductFields').hide();

                    }


                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }


        ////get start date and end date and put on project durtion label control, this depend on project .

        function ExpectdstatrendDate(projectId) {


            var EmployeeID = "<%= Session("IssueProject") %>  ";
            var empName;
            var ProjectId = parseInt(projectId);
            //   StartLoader("#bodyAddNew");
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetStartEndDate',
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

                    $("#ExpectdstatrendDate").html('');

                    var s = result[0] + " TO " + result[1];
                    $("#ExpectdstatrendDate").append(s);


                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }

        ////this is funtion used for check customer droup down list hide or show
       /* function ProductFiledFlag(commonProp1) {*/
        function ProductFiledFlag(commonProperty) {
            var EmployeeID = "<%= Session("serID") %>  ";
            //commonProperty = null;
            var empName;
            // var commonProp = { ProjectId: parseInt(projectid)};
            //var commonProp = commonProp1;
            var commonProp = commonProperty;
            //// global define varaiable sotred parameter current funtion
            //commonProperty = commonProp1;
            /* var productField = { commonProperty: commonProp };*/
            var productField = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId
            };

            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/ProductFiledFlag',
                method: 'Post',
                data: JSON.stringify(productField),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (productField) {
                        xhr.setRequestHeader("Params", encryptString(isJson(productField) ? productField : JSON.stringify(productField)));
                    }
                },
                success: function (result) {
                    //// global define varaiable sotred flag result
                    if (result.flag == true) {
                        alert("special charter use in input paramerter");

                    } else {
                        flag = null;
                        flag = result.FildFlag;

                        if (result.FildFlag == true && commonProperty.LoginType != "C") {
                            $('#boxbodyProductFields').show();
                            $('#divCustomerIssueID').show();
                            $('#divProductFields').show();
                            $('#rowProductFields').show();
                            //alert(result.FildFlag);
                            //Commented By Dipali V On 14th Sep 2019 placeholder issue
                            //$('#cboProduct').empty();
                            //$('#cboModule').empty();
                            //End of Commented By Dipali V On 14th Sep 2019 placeholder issue
                            activeControlIds.push("cboCustomerIssueID");
                            activeControlIds.push("cboProduct");
                            activeControlIds.push("cboModule");
                            // getProductDevelopmentProject(commonProperty.ProjectId);
                        } else {
                            $('#divCustomerIssueID').hide();
                            ListOfProduct(result.FildFlag, null, commonProp);
                            // alert(commonProperty.ProjectId);
                            getProductDevelopmentProject(commonProperty.ProjectId);
                            // $('#cboModule').empty();

                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }
        
        ////this function use when we will click on customer droup down list
        function Customer_OnChange(customerid1) {
          
            var commonprop = commonpropertyI
            customerid = null;
            customerid = customerid1;
            // alert(commonProperty.ProjectId);
            if (customerid1 != 0) {
              //  ListOfProduct(flag, customerid, commonProperty);
                ListOfProduct(flag, customerid, commonprop);
            } else {
                //Commmented & Added By Dipali V On 14th Sep 2019 For Module placeholder after product clear
                // $('#cboModule').empty();
                $("#cboProduct").empty();
                var s = ('<option value=0 >Select Product</option>');
                $("#cboProduct").append(s);

                $("#cboModule").empty();
                var s = ('<option value=0 >Select Module</option>');
                $("#cboModule").append(s);
            }

            // 
            //End of Commmented & Added By Dipali V On 14th Sep 2019 For Module placeholder after product clear

        }



        ////this function used for get product list and bind on product droup down list
        /*function ListOfProduct(flag, customerid, commonProp1)*/
        function ListOfProduct(flag, customerid, commonProperty)
        {
            //debugger;
            if (customerid == null) {
                customerid = 0;
            }

            if (flag == false)
            {
                flag = 0;
            }
            else {
                flag = 1;
            }
            //var productField = { commonProperty: commonProp1, FildFlag: flag, Customerid: customerid };           
            var productField = {
                ProjectId: parseInt(commonProperty.ProjectId),
                LoginType: commonProperty.LoginType,
                EmployeeId: parseInt(commonProperty.EmployeeId),
                RoleId: parseInt(commonProperty.RoleId),
                LoginId: parseInt(commonProperty.LoginId),
                FildFlag: flag,
                Customerid: parseInt(customerid)
            };
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetProductList',
                method: 'Post',
                data: JSON.stringify(productField),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (productField) {
                        xhr.setRequestHeader("Params", encryptString(isJson(productField) ? productField : JSON.stringify(productField)));
                    }

                },
                success: function (result) {

                    var listproduct = result[0];
                    if (result == true) {
                        alert("special charter are use in input parameter");

                    } else {

                        //$("#cboModule").empty();
                        $("#cboProduct").empty();
                        var s = ('<option value=0 >Select Product</option>');
                        $("#cboProduct").append(s);
                        //$.each(result, function (index, val) {

                        //                var s = ('<option value='+val.FieldID+' >' + val.FieldName + '</option>');  
                        //               $("#cboSubType").append(s);

                        //           });
                        for (var i = 0; i < result.length; i++) {
                            var listproduct = result[i];
                            // alert(listproduct.ProductVersionID);
                            var s = ('<option value=' + listproduct.ProductVersionID + ' >' + listproduct.ProductVersion + '</option>');
                            $("#cboProduct").append(s);
                            //  $("#cboSubType").css({ "class": "form-control selectpicker" });
                        }
                    }



                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }


        ////when we will click or select product then bind the component  
        function ProductVersion_OnChange(ProductVersionId) {
            ProductVersionID = null;
            ProductVersionID = ProductVersionId;

            if (ProductVersionID != 0) {
               //Commented Added By Dipali V On 3rd April 2023 For Get commonproperty 
               // ListOfComponet1(flag, customerid, commonProperty, ProductVersionID);
                ListOfComponet1(flag, customerid, commonpropertyI, ProductVersionID);
               //End of Commented Added By Dipali V On 3rd April 2023 For  Get commonproperty 

            } else {
                //alert("please select product");
                //Commmented & Added By Dipali V On 14th Sep 2019 For Module placeholder after product clear
                //$("#cboModule").empty();
                $("#cboModule").empty();
                var s = ('<option value=0 >Select Module</option>');
                $("#cboModule").append(s);
                //End of Commmented & Added By Dipali V On 14th Sep 2019 For Module placeholder after product clear
            }

        }

        //Added By Rehan For Special Character Validation
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
		//End Of Comment By Rehan C
        //function ListOfComponet1(flag, customerid, commonProp1, ProductVersionID) {
        function ListOfComponet1(flag, customerid, commonProperty, ProductVersionID) {
            //var productField = { commonProperty: commonProp1, FildFlag: flag, Customerid: customerid, ProductVersionID: ProductVersionID };
            //Commented Added By Dipali V On 3rd April 2023 For  Get commonproperty 
            if (flag == true) {
                flag = 1;
            }
            else {
                flag = 0;
            }
           //End of Commented Added By Dipali V On 3rd April 2023 For  Get commonproperty 
            var productField = {
                //ProjectId: commonProperty.ProjectId,
                //LoginType: commonProperty.LoginType,
                //EmployeeId: commonProperty.EmployeeId,
                //IssueID: commonProperty.IssueID,
                //RoleId: commonProperty.RoleId,
                //LoginId: commonProperty.LoginId
                ProjectId: parseInt(commonProperty.ProjectId),
                LoginType: commonProperty.LoginType,
                EmployeeId: parseInt(commonProperty.EmployeeId),
                RoleId: parseInt(commonProperty.RoleId),
                LoginId: parseInt(commonProperty.LoginId), FildFlag: flag, Customerid: parseInt(customerid), ProductVersionID: parseInt(ProductVersionID)
            };
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetComponetList',

                method: 'Post',
                data: JSON.stringify(productField),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (productField) {
                        xhr.setRequestHeader("Params", encryptString(isJson(productField) ? productField : JSON.stringify(productField)));
                    }
                },
                success: function (result) {
                    var listproduct = result[0];
                    if (listproduct.flag == true) {
                        alert("special charter are use in input parameter");

                    } else {

                        $("#cboModule").empty();
                        var s = ('<option value=0 >Select Module</option>');
                        $("#cboModule").append(s);
                        //$.each(result, function (index, val) {

                        //                var s = ('<option value='+val.FieldID+' >' + val.FieldName + '</option>');  
                        //               $("#cboSubType").append(s);

                        //           });

                        for (var i = 0; i < result.length; i++) {
                            var listComponent = result[i];

                            var s = ('<option value=' + listComponent.ComponentID + ' >' + listComponent.Component + '</option>');
                            $("#cboModule").append(s);
                            //  $("#cboSubType").css({ "class": "form-control selectpicker" });
                        }
                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }
        ////get list of component and  bind on component/module droup down list
       // function ListOfComponet(flag, customerid, commonProp1, ProductVersionID) {
        function ListOfComponet(flag, customerid, commonProperty, ProductVersionID) {


            //  alert(url);cboreportedby

            // alert(projectId);
            //var newIssue = { ProjectId: parseInt(projectId), Type: Type,RoleId:RoleId };
            /// alert(newIssue);
            //var productField = { commonProperty: commonProp1, FildFlag: flag, Customerid: customerid, ProductVersionID: ProductVersionID };
            var productField = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId, FildFlag: flag, Customerid: customerid, ProductVersionID: ProductVersionID };
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetComponetList',
                method: 'Post',
                data: JSON.stringify(productField),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (productField) {
                        xhr.setRequestHeader("Params", encryptString(isJson(productField) ? productField : JSON.stringify(productField)));
                    }
                },
                success: function (result) {
                    $("#cboModule").empty();

                    for (var i = 0; i < result.length; i++) {
                        var listComponent = result[i];
                        //  alert(subtype.FieldID);cboSubType
                        //alert(listComponent.ComponentID);
                        var s = ('<option value=' + listComponent.ComponentID + ' >' + listComponent.Component + '</option>');
                        $("#cboModule").append(s);
                        //  $("#cboSubType").css({ "class": "form-control selectpicker" });
                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }
        //cboIssueId
        function GetIssueIDs(commonProperty) {

           // var commonProperty = commonProperty;
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId}
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetIssueIds',
                method: 'Post',
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
                    if (result == true) {
                      
                    } else {
                        $("#cboIssueId").empty();

                        var objCbo1 = document.getElementById("cboIssueId");
                        $("#cboIssueId option").remove();

                        for (var i = 0; i < result.length; i++) {

                            var Objresult = result[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.text = Objresult;
                            objOption.value = Objresult;
                        }
                        AppendOptioncbo("IssueId", "");
                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }


        function GetType(commonProperty) {

            //var commonProperty = commonProperty;
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId}
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetType',
                method: 'Post',
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

                    $("#cbotype").empty();

                    for (var i = 0; i < result.length; i++) {
                        var listtype = result[i];

                        var s = ('<option value=' + listtype.fielid + ' >' + listtype.fieldname + '</option>');
                        $("#cbotype").append(s);

                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }

       
     
        function Type_OnChange(Type) {

            var ProjectID = $("#cboIssueProjects :selected").val();
            //Added By Dipali V On 16th Nov 2022 For Type Base Layout changes
            var ProjectID = '<%= Session("IssueProject") %>';
            var UserName = "<%= Session("strUserName").ToString() %>";
            var RoleId = "<%=IssueRoleId%>";
            var EmployeeId = "<%= Session("intUserID").ToString() %>";
            var LoginType = "<%= Session("LoginType").ToString() %>";
            var LoginId = "<%= Session("intLoginID").ToString() %>";
            //alert(RoleId);
            ////stroed all variable in common property
            var commonProperty = { ProjectId: ProjectID, RoleId: RoleId, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginId, strMode: 'New', Type: Type };
            ////this function use for ploating all control using project id
            GetControlPloatingProject(ProjectID, commonProperty);
            //debugger;
            ExpectdstatrendDate(ProjectID);
            getServerDateTime();
            ReportedBY(commonProperty);
            GetType(commonProperty);
            GetSeverity(commonProperty);
            GetKernel(commonProperty);
            GetDeliverableID(commonProperty);
            GetPriorities(commonProperty);
            CodedBy(commonProperty);
            AssignTo(commonProperty);
            ProjectRootCause(commonProperty);
            GetModule(commonProperty);
            GetChangeRequestMaster(commonProperty);
            GetProjectVersion(commonProperty);
            GetPhase(commonProperty);
            GetHardware(commonProperty);
            GetOS(commonProperty);
           
            //Added By Dipali V On 6th july 2023 Get Sprint & US Details
            GetRelease(commonProperty);
            Release_OnChange($("#cboRelease").val());
            //End of Added By Dipali V On 6th july 2023 Get Sprint & US Details
            AppendOptioncbo("SubType", "");
            AppendOptioncbo("Complexity", "");
            //var cboId = ["ReportedBy", "Type", "Release", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "AssignToName", "CustomerIssueID"];
            //var cboId = ["ReportedBy", "Type", "Release", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel", "CustomerIssueID"];
           // var cboId = ["ReportedBy", "Type", "Release", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "Hardware", "OS", "Kernel"];
            //var cboId = ["Type",  "Severity", "Complexity"];
            //for (var i = 0; i < cboId.length; i++) {
            //    AppendOptioncbo(cboId[i], "");
            //}
            jQuery("select#cboReportedBy option[value='" + UserName + "'  ]").attr("selected", "selected");

            $("#dtReportedDate").removeClass('hasDatepicker');
            $(function () {
                $('#dtReportedDate').datepicker({
                    autoclose: true,
                    changeMonth: true,
                    dateFormat: 'd M yy',
                    changeYear: true, //2021
                    onClose: function () {
                        $(':focus').blur();
                    }
                });
            });

            //End of Added By Dipali V On 16th Nov 2022 For Type Base Layout changes

            if (DefaultType != Type) {
                DefaultValue(ProjectID, Type, null);
            }
           
            if (Type != 0) {


                ////bind data on  subtype droup down list
                SubType(ProjectID, Type);

                var RoleId = "<%= Session("intPostID").ToString() %>";
                var LoginType = "<%= Session("LoginType").ToString() %>";
                var UserId = "<%= Session("intUserID").ToString() %>";

                //// bind data on status droupdown list
                Status(ProjectID, Type, RoleId);
                $("#CustomFiledsControl").empty();
                var isCustomField = getCustomFieldsMaxRowColCount(ProjectID);
                if (isCustomField == true) {
                    PloatCustomControl1(ProjectID, Type, RoleId, LoginType, UserId);
                }


                if (DefaultType == Type) {

                    $("#cboSubType option:contains(" + DefaultSubType + ")").prop('selected', true);
                    $("#cboStatus option:contains(" + DefaultStatus + ")").prop('selected', true);
                   
                }

            } else {
                //alert('please select Type');

                $('#cboSubType').empty();
                $('#cboStatus').empty();
                $("#CustomFiledsControl").empty();
                PloatCustomControl1(ProjectID, Type, RoleId, LoginType, UserId);

                AppendOptioncbo("SubType", "");
                AppendOptioncbo("Status", "");
                //Added By Rutuja D. on 15 Jan 2020 For Bind PlaceHolder to Type IssueID = 28991
                $('#cboType').val('0');
                //End of Added By Rutuja D. on 15 Jan 2020 For Bind PlaceHolder to Type IssueID = 28991
            }
            tooltipshow();
            setDefaultOnTypeChange(ProjectID, Type);

        }
        function setDefaultOnTypeChange(ProjectID, Type) {
           
             var ProjectId = ProjectID;
            var Type = Type;
            //var Parameter = [ProjectId, Type];
            var Parameter = {
                ProjectId: ProjectId,
                Type: Type
            };
             $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/DefaultValue',
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
                 
                   // alert(result);
                    if (result != "") {
                        $("#cboSubType option:contains(" + result[1] + ")").prop('selected', true);
                         //Commented & Added By Dipali V. on 5 Jan 2021 For Status Not Binding Properly
                         //$("#cboStatus option:contains(" + result[2] + ")").prop('selected', true);

                        //Commented and added by Chetan M on 15 Jan 2021 for Status not binding properly
                        //if (result[2] != "null" && result[2] != undefined && result[2] != "") {
                         //    $("#cboStatus").val(result[2]);
                         //} else {
                         //    $("#cboStatus").val("0");
                         //}
                        if ($("#cboStatus option:contains(" + result[2] + ")").length > 0) {
                            if (result[2] != "null" && result[2] != undefined && result[2] != "") {
                                $("#cboStatus").val(result[2]);
                            } else {
                                $("#cboStatus").val("0");
                            }
                        }
                        else {
                            $("#cboStatus").val("0");
                        }
                        //End of Commented and added by Chetan M on 15 Jan 2021 for Status not binding properly


                         //End Of Commented & Added By Dipali V. on 5 Jan 2021 For Status Not Binding Properly
                     }
                    //Type_OnChange();
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }



        function GetRelease(commonProperty) {



            //var layOutcontrol = { commonProperty: commonProperty };
            var layOutcontrol = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId,
                strMode: commonProperty.strMode
            };
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetRelease',
                method: 'Post',
                data: JSON.stringify(layOutcontrol),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (layOutcontrol) {
                        xhr.setRequestHeader("Params", encryptString(isJson(layOutcontrol) ? layOutcontrol : JSON.stringify(layOutcontrol)));
                    }
                },
                success: function (result) {
                    $("#cboRelease").empty();

                    for (var i = 0; i < result.length; i++) {
                        var listRelease = result[i];

                        var s = ('<option value=' + listRelease.ReleaseID + ' >' + listRelease.ReleaseName + '</option>');
                        $("#cboRelease").append(s);

                    }

                    AppendOptioncbo("Release", "");

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }
        //cboSeverity 

        function GetSeverity(commonProperty) {

            //var commonProperty = commonProperty;
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId
            }
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetSeverity',
                method: 'Post',
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
                    $("#cboSeverity").empty();
                    for (var i = 0; i < result.length; i++) {
                        var listSeverity = result[i];
                        var s = ('<option value="' + listSeverity.FieldID + '" >' + listSeverity.FieldName + '</option>');
                        $("#cboSeverity").append(s);

                    }
                    AppendOptioncbo("Severity", "");

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }


        function GetPriorities(commonProperty) {

            //var commonProperty = commonProperty;
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId
            }
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetPriorities',
                method: 'Post',
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
                    $("#cboPriority").empty();

                    for (var i = 0; i < result.length; i++) {
                        var listSeverity = result[i];

                        var s = ('<option value="' + listSeverity.FieldID + '" >' + listSeverity.FieldName + '</option>');
                        $("#cboPriority").append(s);

                    }

                    AppendOptioncbo("Priority", "");
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }
        //cboDeliverableID 
        function GetDeliverableID(commonProperty) {

           // var commonProperty = commonProperty;
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId
            }
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetDeliverable',
                method: 'Post',
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
                    //alert();
                    $("#cboDeliverableID").empty();
                    //     $('#cboDeliverableID')
                    //.find('option')
                    //        .remove();




                    for (var i = 0; i < result.length; i++) {
                        var listDeliverable = result[i];

                        // var s = ('<option value=' + listDeliverable.ScheduleID + ' >' + listDeliverable.Title + '</option>');
                        var s = ('<option value="' + listDeliverable.ScheduleID + '" >' + listDeliverable.LabelSchedule + '</option>');
                        $("#cboDeliverableID").append(s);

                        // alert($("#cboDeliverableID").html());

                    }

                    AppendOptioncbo("DeliverableID", "");



                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }

        //cboKernel
        function GetKernel(commonProperty) {

            //var commonProperty = commonProperty;
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId
            }
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetKernel',
                method: 'Post',
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

                    var objCbo1 = document.getElementById("cboKernel");
                    $("#cboKernel option").remove();

                    for (var i = 0; i < result.length; i++) {

                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult;
                        //Added By Dipali V On 21st Feb 2022 For Get Kernel details
                        objOption.value = Objresult;
                    }

                    AppendOptioncbo("Kernel", "");
                    //if (Kernel != 0) {

                    //    $("select#cboKernel option:contains(" + Kernel + ")").attr('selected', 'selected');
                    //}

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }


        function GetFieldValueForIssue(copyIssueID, commonProp) {
            
            var copyIssueIDs = copyIssueID;
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetFieldValueForIssue',
                method: 'Post',
                data: JSON.stringify(copyIssueIDs),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (copyIssueIDs) {
                        xhr.setRequestHeader("Params", encryptString(isJson(copyIssueIDs) ? copyIssueIDs : JSON.stringify(copyIssueIDs)));
                    }
                },
                success: function (result) {
                    //var strFieldNames = ["Type","SubType","Priority","Status","Severity","ReportedBy","AssignTo","ModuleName","OS","Hardware","Kernel","Phase","FoundInPhase","FixedInPhase","CodedBy","ShowToCustomer","CustomFieldText1","CustomFieldCombo1","CustomFieldDate1","CustomFieldTextArea1","RootCauseID","DeliverableID","Complexity","ProductVersionID","ComponentID","CustomerID","ReleaseID","IterationID","UserStoryID"];

                    if (copyIssueID.strFieldName == "AssignTo") {
                        copyIssueID.strFieldName = "AssignToName";
                    }
                    if (copyIssueID.strFieldName == "CodedBy") {
                        copyIssueID.strFieldName = "CodedByName";
                    }
                    if (copyIssueID.strFieldName == "ReleaseID") {
                        copyIssueID.strFieldName = "Release";
                    }
                    if (copyIssueID.strFieldName == "IterationID") {
                        copyIssueID.strFieldName = "Iteration";

                    }
                    if (copyIssueID.strFieldName == "UserStoryID") {
                        copyIssueID.strFieldName = "UserStory";

                    }
                    
                    var fieldid = "#cbo" + copyIssueID.strFieldName;
                    if (copyIssueID.strFieldName == "CustomerID" || copyIssueID.strFieldName == "ProductVersionID" || copyIssueID.strFieldName == "ComponentID" || copyIssueID.strFieldName == "CustomFieldTextArea1" || copyIssueID.strFieldName == "CustomFieldTextArea2" || copyIssueID.strFieldName == "CustomFieldTextArea3" ||copyIssueID.strFieldName == "CustomFieldTextArea4" || copyIssueID.strFieldName == "CustomFieldTextArea5" || copyIssueID.strFieldName == "CustomFieldDate1" || copyIssueID.strFieldName == "CustomFieldDate2" || copyIssueID.strFieldName == "CustomFieldDate3" || copyIssueID.strFieldName == "CustomFieldDate4" || copyIssueID.strFieldName == "CustomFieldDate5" || copyIssueID.strFieldName == "CustomFieldText1"  || copyIssueID.strFieldName == "CustomFieldText2" || copyIssueID.strFieldName == "CustomFieldText3" ||copyIssueID.strFieldName == "CustomFieldText4" || copyIssueID.strFieldName == "CustomFieldText5") {
                        if (copyIssueID.strFieldName == "CustomerID")
                        {
                            fieldid = "#cboCustomerIssueID";
                            if (result != null) {
                                $(fieldid).val(result);
                                flag = true;
                                commonProperty = commonProp;
                                customerid = result;
                                Customer_OnChange(result);
                            }
                        }

                        if (copyIssueID.strFieldName == "ProductVersionID") {
                            fieldid = "#cboProduct";
                            if (result != null) {
                                $(fieldid).val(result);
                                commonProperty = commonProp;
                                ProductVersion_OnChange(result);
                            }
                        }

                        if (copyIssueID.strFieldName == "ComponentID") {
                            fieldid = "#cboModule";
                            if (result != null) {
                                $(fieldid).val(result);
                            }
                        }

                        //if (copyIssueID.strFieldName == "CustomFieldTextArea1"  ) {
                        if (copyIssueID.strFieldName == "CustomFieldTextArea1"  || copyIssueID.strFieldName == "CustomFieldTextArea2" || copyIssueID.strFieldName == "CustomFieldTextArea3" ||copyIssueID.strFieldName == "CustomFieldTextArea4" || copyIssueID.strFieldName == "CustomFieldTextArea5") {
                            //fieldid = "#txtCustomFieldTextArea1";
                            fieldid = "#txt" + copyIssueID.strFieldName;
                            if (result != null) {
                                $(fieldid).html(result);
                            }
                            else {
                                 $(fieldid).val('');
                            }
                        }

                        //if (copyIssueID.strFieldName == "CustomFieldDate1" ) {
                        if (copyIssueID.strFieldName == "CustomFieldDate1" || copyIssueID.strFieldName == "CustomFieldDate2" || copyIssueID.strFieldName == "CustomFieldDate3" || copyIssueID.strFieldName == "CustomFieldDate4" || copyIssueID.strFieldName == "CustomFieldDate5") {
                            //fieldid = "#txtCustomFieldDate1";
                            fieldid = "#dt"+ copyIssueID.strFieldName;                           
                            if (result != null) {
                                var val1 = result.split('T')[0];
                                $(fieldid).val(val1);
                            }
                            else {
                                 $(fieldid).val('');
                            }
                        }

                        if (copyIssueID.strFieldName == "ShowToCustomer") {
                            fieldid = "#chkShowToCustomer";
                            if (result != null) {
                                $(fieldid).attr('checked', result);
                            }
                            else {                                
                                 $(fieldid).val('');
                            }
                        }

                        //Added by imran on 28-02-2022
                        if (copyIssueID.strFieldName == "CustomFieldText1"  || copyIssueID.strFieldName == "CustomFieldText2" || copyIssueID.strFieldName == "CustomFieldText3" ||copyIssueID.strFieldName == "CustomFieldText4" || copyIssueID.strFieldName == "CustomFieldText5") {
                            fieldid = "#txt" + copyIssueID.strFieldName;
                            if (result != null) {
                                $(fieldid).html(result);
                            }
                            else {
                                 $(fieldid).val('');
                            }
                        }
                        //End by imran on 28-02-2022
                    }
                    else {
                        if (result != null) {
                            $("" + fieldid + " option:contains(" + result + ")").attr('selected', 'selected');
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                }
            });
        }


        function RemoveRow(row, column) {
            var cnt = false;

            $('tr').each(function () {
                $(this).find('td').each(function () {
                    if ($(this).text().trim() == "") {
                        cnt = true;

                    } else {
                        cnt = false;
                    }
                    if (cnt == true) {
                        $(this).closest("tr").remove();
                        cnt = false;
                    }

                });

            });


        }

        // CodedByProjectRootCauseGetModuleGetChangeRequestMasterGetProjectVersionGetPhaseGetHardwareGetOS
        function CodedBy(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetCodedBy',
                method: 'Post',
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

                    $("#cboCodedByName").empty();
                    // $("#cboAssignToName").empty();

                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value=' + list.EmployeeID + ' >' + list.UserName + '</option>');
                        $("#cboCodedByName").append(s);
                        //   $("#cboAssignToName").append(s);

                    }

                    AppendOptioncbo("CodedByName", "");


                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }

        function AssignTo(CommonProperty) {
            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/AssignTo',
                method: 'Post',
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

                  
                    //Commented by dipali V On 18th Sep 2019 for Issue responsible person should come by default
                    
                    // $("#cboAssignToName").empty();

                    //for (var i = 0; i < result.length; i++) {
                    //    var list = result[i];

                    //    var s = ('<option value=' + list.EmployeeID + ' >' + list.UserName + '</option>');
                    //    $("#cboAssignToName").append(s);
                    //    $('#cboAssignToName option[value=' + list.EmployeeID + ']').attr("selected", "selected");

                    //}
                    for (var i = 0; i < result.length; i++) {
                        //
                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objOption.value = Objresult.EmployeeID;
                        objOption.text = Objresult.UserName;

                        $('#cboAssignToName option[value=' + objOption.value + ']').attr("selected", "selected");
                        //Added & commneted by Commented by dipali V On 18th Sep 2019 for Issue responsible person should come by default
                    }
                    //Added By Dipali V on 7th July 2023 for replace holder issue
                    AppendOptioncbo("AssignToName", "ResponsiblePersonName");
                    //End of Added By Dipali V on 7th July 2023 for replace holder issue


                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }


        function ProjectRootCause(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetProjectRootCause',
                method: 'Post',
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

                    $("#cboRootCauseID").empty();

                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value="' + list.FieldID + '" >' + list.FieldName + '</option>');
                        $("#cboRootCauseID").append(s);

                    }

                    AppendOptioncbo("RootCauseID", "");


                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }

        function GetModule(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetModule',
                method: 'Post',
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

                    $("#cboModuleName").empty();

                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value="' + list + '" >' + list + '</option>');
                        $("#cboModuleName").append(s);

                    }

                    AppendOptioncbo("ModuleName", "");


                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }



        function GetChangeRequestMaster(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetChangeRequestMaster',
                method: 'Post',
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

                    $("#cboChangeRequestName").empty();

                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value="' + list.ChangeRequestID + '" >' + list.ChangeRequestSummary + '</option>');
                        $("#cboChangeRequestName").append(s);

                    }

                    AppendOptioncbo("ChangeRequestName", "");

                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }

        function GetProjectVersion(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetProjectVersion',
                method: 'Post',
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


                    $("#cboReportedInVersion").empty();
                    $("#cboCorrectedInVersion").empty();
                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value="' + list + '" >' + list + '</option>');
                        $("#cboReportedInVersion").append(s);
                        $("#cboCorrectedInVersion").append(s);

                    }

                    AppendOptioncbo("ReportedInVersion", "");

                    AppendOptioncbo("CorrectedInVersion", "");

                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }
        function GetPhase(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetPhase',
                method: 'Post',
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

                    $("#cboPhase").empty();
                    $("#cboFoundInPhase").empty();
                    $("#cboFixedInPhase").empty();
                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value="' + list + '" >' + list + '</option>');
                        $("#cboPhase").append(s);
                        $("#cboFoundInPhase").append(s);
                        $("#cboFixedInPhase").append(s);

                    }

                    AppendOptioncbo("Phase", "");

                    AppendOptioncbo("FoundInPhase", "");

                    AppendOptioncbo("FixedInPhase", "");


                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }


        function GetHardware(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetHardware',
                method: 'Post',
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

                    $("#cboHardware").empty();
                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value="' + list + '" >' + list + '</option>');
                        $("#cboHardware").append(s);


                    }

                    AppendOptioncbo("Hardware", "");

                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }

        function GetOS(CommonProperty) {

            //var commonProperty = CommonProperty;
            var commonProperty = {
                ProjectId: CommonProperty.ProjectId,
                LoginType: CommonProperty.LoginType,
                EmployeeId: CommonProperty.EmployeeId,
                IssueID: CommonProperty.IssueID,
                RoleId: CommonProperty.RoleId,
                LoginId: CommonProperty.LoginId,
                strMode: CommonProperty.strMode
            }
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetOS',
                method: 'Post',
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

                    $("#cboOS").empty();
                    for (var i = 0; i < result.length; i++) {
                        var list = result[i];

                        var s = ('<option value="' + list + '" >' + list + '</option>');
                        $("#cboOS").append(s);


                    }

                    AppendOptioncbo("OS", "");


                },
                error: function (xhr, errorThrown) {
                    //alert(errorThrown);
                    //alert(xhr.responseText);
                }
            });

        }

        function GetValueByIssueId(issueid, commonProp) {

            $("#txtImportID").val('');
            $("#txtCustomerIssueID1").val('');
            //  $("#chkShowToCustomer").prop('checked', false);

            //alert(url);
            var commonproerty = commonProp;
            //alert(commonproerty.ProjectId);
            var IssueId = parseInt(issueid);
            //var issuepara = [IssueId.toString(), commonproerty.ProjectId];
            var Issuepara = {
                IssueID: IssueId,
                ProjectID: commonproerty.ProjectId
            }
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetValueByIssuid',
                method: 'Post',
                data: JSON.stringify(Issuepara),
                //data:parseInt( IssueId),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Issuepara) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Issuepara) ? Issuepara : JSON.stringify(Issuepara)));
                    }
                },
                success: function (result) {

                    var Getvalue = result[0];
                    if (Getvalue == true) {
                        alert("please don't pass / use special charcter  ");
                    } else {

                        //  var strfield = ["CustomerID","ProductVersionID","ComponentID","Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignTo", "ModuleName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedBy", "ShowToCustomer", "CustomFieldText1", "CustomFieldCombo1", "CustomFieldDate1", "CustomFieldTextArea1", "RootCauseID", "DeliverableID", "Complexity","ReleaseID", "IterationID", "UserStoryID"];
                        //Commented And Added By Usha Pandit On 25.05.2021 for getting fields selected on copy issue
                        //var strfield = ["Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignTo", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedBy", "ShowToCustomer", "CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo4", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "ReleaseID", "IterationID", "UserStoryID", "ImportID", "CustomerIssueID", "Module"];
                        var strfield = ["Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignTo", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedBy", "ShowToCustomer", "CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo4", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "ReleaseID", "IterationID", "UserStoryID", "ImportID", "CustomerIssueID", "Module", "ModuleName", "ChangeRequestID", "ReportedInVersion", "CorrectedInVersion"];
                        //End Of Added By Usha Pandit On 25.05.2021 for getting fields selected on copy issue

                        $.each(Getvalue, function (key, value) {

                            if (strfield.indexOf(key) != -1) {
                                ValuePloatByIssueId(key, value, commonproerty);
                            }
                        });
                    }
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }
        function ValuePloatByIssueId(key1, value1, commonProp) {
            //
            var result = value1;
            var key;

            if (key1 == "Type") {

                var ProjectID = $("#cboIssueProjects :selected").val();

                var Type = result;

                SubType(ProjectID, Type);
                //alert(Type);
                var RoleId = "<%= Session("intPostID").ToString()%>";
                var LoginType = "<%= Session("LoginType").ToString() %>";
                var UserId = "<%= Session("intUserID").ToString() %>";

                //// bind data on status droupdown list
                Status(ProjectID, Type, RoleId);

                ////this funciton used for ploat the custon field control 
                //    PloatCustomControl(ProjectID, Type, RoleId, LoginType, UserId);
                $("#CustomFiledsControl").empty();
               //   $("#CustomFiledsControl").empty();
                //Added by Swapnagandha K. On 07 nov 2019 For Issue -Details are not getting display of selected issue ID
                var isCustomField = getCustomFieldsMaxRowColCount(ProjectID);
                if (isCustomField == true) {
                PloatCustomControl1(ProjectID, Type, RoleId, LoginType, UserId);
            }
               // PloatCustomControl1(ProjectID, Type, RoleId, LoginType, UserId);
              //End  Added by Swapnagandha K. On 07 nov 2019 For Issue -Details are not getting display of selected issue ID

            }
            //Added by Swapnagandha K. On 07 nov 2019 For Issue -Details are not getting display of selected issue ID
            //if (key1 == "Summary") {
            //    $("#message_area").text(value1);
            //}
            //End Added by Swapnagandha K. On 07 nov 2019 For Issue -Details are not getting display of selected issue ID
            if (key1 == "ReleaseID") {
                Release_OnChange(result);


            }

            if (key1 == "IterationID") {
                Iteration_OnChange(result);
            }


            key = key1;
            if (key1 == "AssignTo") {
                // alert(result);
                key1 = "AssignToName";

            }
            if (key1 == "CodedBy") {
                key1 = "CodedByName";
            }
            if (key1 == "ReleaseID") {
                key1 = "Release";
            }
            if (key1 == "IterationID") {
                key1 = "Iteration";

            }
            if (key1 == "UserStoryID") {
                key1 = "UserStory";

            }
            if (key1 == "CodedBy") {
                key1 = "CodedByName";

            }
            //Added By Usha Pandit On 25.05.2021 for getting fields selected on copy issue
            if (key1 == "ChangeRequestID") {
                key1 = "ChangeRequestName";
            }
            //End Of Added By Usha Pandit On 25.05.2021 for getting fields selected on copy issue
            var fieldid = "#cbo" + key1;

            if (key.indexOf("CustomerID") != -1 || key.indexOf("ProductVersionID") != -1 || key1.indexOf("ComponentID") != -1 || key.indexOf("CustomFieldTextArea") != -1 || key.indexOf("CustomFieldDate") != -1 || key.indexOf("CustomFieldText") != -1 || key.indexOf("ImportID") != -1 || key.indexOf("CustomerIssueID") != -1 || key.indexOf("ShowToCustomer") != -1) {



                if (key.indexOf("CustomerID") != -1) {

                    fieldid = "select#cboCustomerIssueID";
                    if (result != null) {

                        jQuery("" + fieldid + " option[value=" + result + " ]").attr("selected", "selected");
                        flag = true;
                        commonProperty = commonProp;
                        customerid = result;
                        Customer_OnChange(result);
                    }
                }
                if (key.indexOf("ProductVersionID") != -1) {


                    if ($('#cboCustomerIssueID').length > 0) {

                        flag = true;
                    } else {
                        flag = false; // alert("Div1 does not exists");
                    }
                    fieldid = "select#cboProduct";
                    if (result != null) {

                        jQuery("" + fieldid + " option[value=" + result + " ]").attr("selected", "selected");

                        ProductVersion_OnChange(result);
                    }
                }
                if (key.indexOf("ComponentID") != -1) {

                    fieldid = "select#cboModule";
                    if (result != null) {
                        //  $(fieldid).val(result);
                        // alert(result);
                        jQuery("" + fieldid + " option[value=" + result + " ]").attr("selected", "selected");
                    }
                }

                if (key.indexOf("CustomFieldTextArea") != -1 || key.indexOf("CustomFieldText") != -1 || key.indexOf("ImportID") != -1) {
                    // if (key.indexOf("ImportID")!=-1) {
                    //alert(result);
                    //
                    fieldid = "#txt" + key;
                    if (result != null) {
                        //  $(fieldid).html(result);
                        $(fieldid).val("");
                        $(fieldid).val(result);
                    }
                }
                if (key.indexOf("CustomerIssueID") != -1) {
                    // alert(result);
                    fieldid = "#txtCustomerIssueID1";
                    if (result != null) {
                        $(fieldid).val(result);
                    }
                }
                if (key.indexOf("CustomFieldDate") != -1) {
                    fieldid = "#dt" + key;
                    //   alert(result);

                    if (result != null) {
                        var val1 = result.split('T')[0];
                        // alert(val);
                        // $(fieldid).html(val1);
                        $(fieldid).val("");
                        $(fieldid).val(val1);
                    }
                }
                if (key1.indexOf("ShowToCustomer") != -1) {
                    fieldid = "#chkShowToCustomer";
                    // alert(result);

                    if (result == true) {
                        $("" + fieldid + " option[value=0]").prop('selected', true);
                        $(".clsCheckBox").prop('checked', true);
                    } else {
                        $(".clsCheckBox").prop('checked', false);
                    }
                }

            } else {
                if (result != null) {
                    //Commented And Added By Usha Pandit On 25.05.2021 for getting fields selected on copy issue
                    //if (key == "AssignTo" || key == "CodedBy" || key == "RootCauseID" || key == "DeliverableID" || key == "ProductVersionID" || key == "ComponentID" || key == "CustomerID" || key == "ReleaseID" || key == "IterationID" || key == "UserStoryID" || key == "Module") {
                    if (key == "Kernel" || key == "AssignTo" || key == "CodedBy" || key == "RootCauseID" || key == "DeliverableID" || key == "ProductVersionID" || key == "ComponentID" || key == "CustomerID" || key == "ReleaseID" || key == "IterationID" || key == "UserStoryID" || key == "Module" || key == "ModuleName" || key == "ChangeRequestID") {
                        //End Of Added By Usha Pandit On 25.05.2021 for getting fields selected on copy issue
                        $("" + fieldid + " option[value='" + result + "']").prop('selected', true);
                    } else {     
                       //Commented and added by Chetan M on 22 June 2021 for Wrong Selection Issue
                        //$("" + fieldid + " option:contains(" + result + ")").prop('selected', true);
                        $("" + fieldid + " option[value='" + result + "']").prop('selected', true);
                        //Commented and added by Chetan M on 22 June 2021 for Wrong Selection Issue
                    }
                } else {
                    $("" + fieldid + " option[value=0]").prop('selected', true);
                }
            }

        }


        function cboBindData(cboid, Result, Value, text) {
            var objCbo1 = document.getElementById(cboid);
            var objRemove = "#" + cboid + " option";

            $(objRemove).remove();


            for (var i = 0; i < Result.length; i++) {


                var Objres = Result[i];
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                if (Value == "null" && text == "null") {
                    objOption.value = Objres[i];
                    objOption.text = Objres[i];
                }
                else {
                    objOption.value = Objres[Value];
                    objOption.text = Objres[text];
                }


            }


        }
        function AppendOptioncbo(FieldName, caption) {
            //
            var id;
            if (FieldName.indexOf("CustomFieldCombo") > -1) {


                id = "cbo" + FieldName.substr(0, FieldName.indexOf(","));

            } else {
                id = "cbo" + FieldName;
            }
            //var s = "Type";
            if (FieldName == "DeliverableID") {
                FieldName = "Deliverable";
            } else if (FieldName == "RootCauseID") {
                FieldName = "Root Cause";

            } else if (FieldName == "ModuleName") {
                FieldName = "Module Name";

            } else if (FieldName == "ChangeRequestName") {
                FieldName = "Change Request Name";
                //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                var curval = $("#lblChangeRequestName").text();
                curval = curval.replace("*", "");
                curval = curval.trim();
                FieldName = curval;
                //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
            } else if (FieldName == "CodedByName") {
                FieldName = "Coded By Name";
                //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                var curval = $("#lblCodedByName").text();
                curval = curval.replace("*", "");
                curval = curval.trim();
                FieldName = curval;
                //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
            } else if (FieldName == "ReportedInVersion") {
                FieldName = "Reported In Version";

            } else if (FieldName == "CorrectedInVersion") {
                FieldName = "Corrected In Version";               
            } else if (FieldName == "Phase") {
                FieldName = "Source Phase";
                //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                var curval = $("#lblPhase").text();
                curval = curval.replace("*", "");
                curval = curval.trim();
                FieldName = curval;
                //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name

            } else if (FieldName == "FoundInPhase") {
                FieldName = "Found In Phase";
                //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                var curval = $("#lblFoundInPhase").text();
                curval = curval.replace("*", "");
                curval = curval.trim();
                FieldName = curval;
                //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name             
            } else if (FieldName == "FixedInPhase") {
                FieldName = "Fixed In Phase";
                //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                var curval = $("#lblFixedInPhase").text();
                curval = curval.replace("*", "");
                curval = curval.trim();
                FieldName = curval;
                //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                
            } else if (FieldName == "AssignToName") {
                //Commented By dipali V On 18th Sep 2019 Placeholder issue
                //FieldName = "Assign To Name";
                FieldName = "Responsible Person";
                //End of Commented By dipali V On 18th Sep 2019 Placeholder issue
            } else if (FieldName.indexOf("CustomFieldCombo") > -1) {
                FieldName = FieldName.substr(FieldName.indexOf(",") + 1, FieldName.length);

            } else if (FieldName == "CustomerIssueID") {
                FieldName = "Customer";
            }
            //added by dipali V On 14th Sep 2019 for Change Iteration to Sprint
            else if (FieldName == "Iteration") {

                FieldName = "Sprint";
            }
            //End of added by dipali V On 14th Sep 2019 for Change Iteration to Sprint
            else if (FieldName == "UserStory") {
                FieldName = "User Story";
            }
            else if (FieldName == "SubType") {
                FieldName = "Sub Type";
            }
            else if (FieldName == "ReportedBy") {
                FieldName = "Reported By";
            }
            else if (FieldName == "IssueId") {
                FieldName = "Issue ID";
            }
            var textval = "Select " + FieldName;
            if (document.getElementById(id) != null)
            {
            //  if (document.getElementById(id).firstChild != null) {
               //if (document.getElementById(id).firstChild.innerText != textval) { // To check placeholder already exist or not
                        document.getElementById(id).insertBefore(new Option(textval, '0'), document.getElementById(id).firstChild);
                 // }
            // }
                $("#" + id + " option[value=0]").prop('selected', true);
            }

        }


        function customfiledTable(ProjectId) {
            var rows;
            var columns;
            //var j;


            //  alert(url);
            // var EmployeeID =parseInt( EmployeeId);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/CreateCustomFiledTable',
                method: 'Post',
                data: JSON.stringify(ProjectId),
                dataType: 'json',
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                    }
                },
                success: function (result) {
                    var value = result[0];
                    rows = value.MaxRows;
                    columns = value.MaxCols;

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

            var strtablebind = "";
            for (var i = 1; i < rows + 1; i++) {
                strtablebind += " <div class='row ' " + "id=" + "i" + i + " style='' >";
                for (var j = 1; j < columns + 1; j++) {
                    strtablebind += "<div class='col-md-4'" + "id=" + "i" + i + "j" + j + "> </div>";

                }
                strtablebind += "</div>";

            }




            $("#divsample").after("<div id='customfiledtable'  >" + strtablebind + "</div>");


        }
        function PloatCustomFiled(projectId, type, roleId, loginType, userId) {
            //var divgroup = $('#divsamplegroup').clone();
            //var lbl = $('#lblsample').clone();
            var txtarea = $('#divCustomFieldTextArea').clone();
            var dt = $('#divCustomFieldDate').clone();
            var txt = $('#divCustomFieldText').clone();
            var cbo = $('#divCustomFieldCombo').clone();

          //  var commonProp = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType };
            var customFiled = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType, Type: type };
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/customfiledPloat',
                method: 'Post',
                data: JSON.stringify(customFiled),
                dataType: 'json',
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (customFiled) {
                        xhr.setRequestHeader("Params", encryptString(isJson(customFiled) ? customFiled : JSON.stringify(customFiled)));
                    }
                },
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {
                        var customfileddate = dt;
                        var Getvalue = result[i];
                        $.each(Getvalue, function (index, value) {
                            if (index == "DatabaseFieldName") {
                                if (value.indexOf("CustomFieldDate") != -1) {

                                    customfileddate.attr("id", "div" + value);
                                    customfileddate.find("#lblCustomFieldDate").attr("id", "lbl" + value);
                                    customfileddate.find("#dtCustomFieldDate").attr("id", "dt" + value);
                                    customfileddate.find("#resCustomFieldDate").attr("id", "res" + value);
                                    CustomfiledDateset(value);
                                }
                            }
                            if (index == "UserGivenCaption") {

                            }

                        });

                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }
        function CustomfiledDateset(customfileddateid) {
            var filedid = "#dt" + customfileddateid;
            $(filedid).datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy'
            });

        }


        $('textarea#message_area, input#addissuesubject').on('keyup', function () {
            var maxlen = $(this).attr('maxlength');

            var length = $(this).val().length;
            //Commented and added by Chetan M on 13th Aug 2020 for Issue ID  = 24209
           // if (length > (maxlen - 10)) {
            if (length > maxlen) {
                //End of Commented and added by Chetan M on 13th Aug 2020 for Issue ID  = 24209
               $('#textarea_message').css('display', 'block');
                    //$('#textarea_message').text('max length '+maxlen+' characters only!');
                $("#textarea_message").html('Max length ' + maxlen + ' characters only <button type="button" class="close">×</button>');
               //Added By Dipali V On 12th May 2020 For ISsue id-24209
                setTimeout(function () {
                    $('#textarea_message').fadeOut('fast');
                }, 1000);
                //End of Added By Dipali V On 12th May 2020 For ISsue id-24209
            }
            else {
                $('#textarea_message').html('');
                $('#textarea_message').css('display', 'none');

            }
        });

        function FindMaxLength(id) {
            var maxlen = $(id).attr('maxlength');

            var length = $(id).val().length;
            if (length > (maxlen - 10)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Max length ' + maxlen + ' characters only ', 'error', 5);
            }
        }

        $(document).on('click', '.close', function () {
            $(this).parent().hide();
        });
        function getCustomFieldsMaxRowColCount(projectId) {
            var ret = false;
            var ProjectID = parseInt(projectId);
            $.ajax({
                url: encodeURI(url) + '/api/IB_IssueDetails/GetCustomFieldMasterRowNumber',
                method: 'Post',
                data: JSON.stringify(ProjectID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {
                    if (result != undefined) {
                        CreateCustomFieldTable(result[0], result[1]);
                        ret = true;
                    }
                },
                error: function (err) {
                    //alert(err);                    
                }
            });
            return ret;
        }
        function CreateCustomFieldTable(rows, columns) {
            var strtablebind = "";
            for (var i = 1; i < rows + 1; i++) {
                strtablebind += " <div class='row ' " + "id=" + "custr" + i + " style='' >";
                for (var j = 1; j < columns + 1; j++) {
                    //Commented And Added By imran on 15-02-2022
                    //strtablebind += "<div class='col-md-4'" + "id=" + "custr" + i + "c" + j + "> </div>";
                    strtablebind += "<div class='col-md-6'" + "id=" + "custr" + i + "c" + j + "> </div>";
                    //End By imran on 15-02-2022
                }
                strtablebind += "</div>";
            }
            $("#CustomFiledsControl").html(strtablebind);
        }

        // added By Chetan M On 27th Mar 2020 For Issue ID 23059
        var MaxlengthValueArray = new Array();
        var MinValueArray = new Array();
        var MaxValueArray = new Array();
        //End Of added By Chetan M On 27th Mar 2020 For Issue ID 23059
        var ValidationFieldsName = new Array();
        var ValidationFieldID = new Array();
        var ValidationRules = new Array();

        //Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
        var ValidationFieldIDSpecialChar = new Array();
        var ValidationFieldNameSpecialChar = new Array();
        //End of Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields

        //Added by imran on 14-02-2022 For Set Default value Of Text Area
        var TextAreaDefaultValue = new Array();
        var Result = '';
        //End by imran on 14-02-2022 For Set Default value Of Text Area

        ////this function used for ploating custom control like  Department,Date etc
        function PloatCustomControl1(projectId, Type, roleId, loginType, userId) {
            //
            var strHTML = "";
            //Added by imran on 14-02-2022 For Set Default value Of Text Area
            TextAreaDefaultValue = [];
            //End by imran on 14-02-2022 For Set Default value Of Text Area

          //  alert(Type);
            //var commonProp = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType };
            //var customFiled = { commonProperty: commonProp, Type: Type };
            var customFiled = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType, Type: Type };

            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/PloatCustomFiled1',
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
                    Result = '';
                    Result = result;

                    for (var i = 0; i < result.length; i++) {

                        var CustomFiledObj = result[i];
                        var custCon = "#custr" + CustomFiledObj.RowNumber + "c" + CustomFiledObj.ColumnNumber;

                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldCombo") !== -1) {

                            strHTML = "";

                            if (CustomFiledObj.ValidationRules == "1," || CustomFiledObj.ValidationRules != "") {
                                strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    "<label class='control-label' id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + "&nbsp;&nbsp;&nbsp; ";
                                if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                    strHTML += "<span id ='Mandatory" + CustomFiledObj.DatabaseFieldName + "' style = 'color:red;' value ='" + CustomFiledObj.ValidationRules + "'>*</span > ";
                                }
                                //'Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23057
                                //strHTML += ": </label > ";
                                strHTML += ":</label > ";
                                //'End Of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23057
                            } else {
                                strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    "<label class='control-label' id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + ":  </label>";
                            }

                            if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                strHTML += "<select class='form-control ' id='cbo" + CustomFiledObj.DatabaseFieldName + "'  >" +
                                    //"<option value='volvo'>Volvo</option>"+
                                    "</select>";

                                strHTML += "</div>";
                                // $("#CustomFiledsControl").append(strHTML);
                                $(custCon).html(strHTML);

                                GetComboboxValues(CustomFiledObj.DatabaseFieldName, projectId);
                                // if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldCombo")>-1) {
                                AppendOptioncbo(CustomFiledObj.DatabaseFieldName + "," + CustomFiledObj.UserGivenCaption);

                                // if (CustomFiledObj.DefaultValue!=""||CustomFiledObj.DefaultValue.length!=0||CustomFiledObj.DefaultValue!=null) {
                                if (CustomFiledObj.DefaultValue.length != 0) {
                                    $("#cbo" + CustomFiledObj.DatabaseFieldName + " option:contains(" + CustomFiledObj.DefaultValue + ")").prop('selected', true);

                                    //$("" + fieldid + " option[value=0]").prop('selected', true);
                                }
                                // }
                            }
                            else {

                                strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%=  MyBase.GetResourceString("C_Not_Available")%></b> </span>";

                                strHTML += "</div>";
                                // $("#CustomFiledsControl").append(strHTML);
                                $(custCon).html(strHTML);
                            }
                            var fieldid = "#cbo" + CustomFiledObj.DatabaseFieldName;
                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                            strHTML = "";
                        }

                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldText") !== -1) {
                            strHTML = "";
                            //Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
                            var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                            ValidationFieldIDSpecialChar.push(fieldid);
                            ValidationFieldNameSpecialChar.push(CustomFiledObj.UserGivenCaption);
                            //Endof Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields

                            if (CustomFiledObj.ValidationRules == "1," || CustomFiledObj.ValidationRules != "") {

                                strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +

                                    "<label class='control-label' id=" + "lbl" + CustomFiledObj.DatabaseFieldName + ">" + CustomFiledObj.UserGivenCaption + "&nbsp;&nbsp;&nbsp;";
                                if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                    strHTML += "<span id=Mandatory" + CustomFiledObj.DatabaseFieldName + " style = 'color:red;' value = " + CustomFiledObj.ValidationRules + " >*</span > ";

                                }
                                //Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23057
                                //strHTML += ": </label > ";
                                strHTML += ":</label > ";
                                //'End Of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23057
                            } else {
                                strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    "<label class='control-label' id=" + "lbl" + CustomFiledObj.DatabaseFieldName + ">" + CustomFiledObj.UserGivenCaption + ": </label>" +
                                    "";
                            }

                            if (CustomFiledObj.DatabaseFieldName.indexOf("Area") !== -1) {
                                if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                    //Added by imran on 14-02-2022 To Set Text Area Value
                                    //strHTML += "<br/><textarea rows='3' cols='25' id='txt" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    //    "</textarea>";
                                    var Value = CustomFiledObj.DatabaseFieldName + '~' + CustomFiledObj.DefaultValue;
                                    TextAreaDefaultValue.push(Value);
                                    strHTML += "<textarea rows='3' cols='25' id='txt" + CustomFiledObj.DatabaseFieldName + "' > </textarea>";
                                    //End by imran on 14-02-2022 To Set Text Area Value
                                }
                                else {
                                    strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                                }
                            }
                            else {
                                if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                    strHTML += "<br/><input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "' autocomplete='off'  value='" + CustomFiledObj.DefaultValue + "'>";
                                }
                                else {
                                    strHTML += "&nbsp;&nbsp;<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";

                                }
                            }
                            strHTML += "</div>";
                            //$("#CustomFiledsControl").append(strHTML);
                            $(custCon).html(strHTML);
                            var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                            strHTML = "";
                        }

                        if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldDate") !== -1) {
                            strHTML = "";
                            if (CustomFiledObj.ValidationRules == "1," || CustomFiledObj.ValidationRules != "") {
                                //if (CustomFiledObj.ValidationRules != null || CustomFiledObj.ValidationRules.length!=0) {
                                strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    // "<label class='control-label' id=" + "lbl" + CustomFiledObj.DatabaseFieldName + ">" + CustomFiledObj.UserGivenCaption + "&nbsp;&nbsp;&nbsp; <span id=Mandatory" + CustomFiledObj.DatabaseFieldName + " style='color:red;' >*</span> : </label>";
                                    "<label class='control-label' id=" + "lbl" + CustomFiledObj.DatabaseFieldName + ">" + CustomFiledObj.UserGivenCaption + "&nbsp;&nbsp;&nbsp;";
                                if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                    strHTML += "<span id=Mandatory" + CustomFiledObj.DatabaseFieldName + " style = 'color:red;' value = " + CustomFiledObj.ValidationRules + " >*</span > ";
                                }
                                //Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23057
                                //strHTML += ": </label > ";
                                strHTML += ":</label > ";
                                //'End Of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23057
                            } else {
                                strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    "<label class='control-label' id=" + "lbl" + CustomFiledObj.DatabaseFieldName + ">" + CustomFiledObj.UserGivenCaption + " : </label>";
                            }

                            if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                //Added by imran on 14-02-2022 To set Default value of Custom Controls
                                //strHTML += "<div class='input-group'><input type='text' class='form-control' id='dt" + CustomFiledObj.DatabaseFieldName + "' readonly style='background-color: white;' >";
                                strHTML += "<div class='input-group'><input type='text' class='form-control' id='dt" + CustomFiledObj.DatabaseFieldName + "' value='" + CustomFiledObj.DefaultValue + "' readonly style='background-color: white;' >";
                                //End by imran on 14-02-2022 To set Default value of Custom Controls
                                strHTML +="<span class='input-group-btn'><button class='btn btncalendar' type='button'><i class='fas fa-calendar-alt'></i></button></span></div></div>";
                            }
                            else {
                                strHTML += "&nbsp;&nbsp;<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                            }
                            strHTML += "</div>";
                            //$("#CustomFiledsControl").append(strHTML);
                            $(custCon).html(strHTML);
                            var fieldid = "#dtext" + CustomFiledObj.DatabaseFieldName;
                            var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                            CustomfiledDatePicker(CustomFiledObj.DatabaseFieldName);

                            strHTML = "";
                        }
                        // AppendOptioncbo(CustomFiledObj.UserGivenCaption);
                        //added By Chetan M On 27th Mar 2020 For Issue ID 23059                        
                        if (CustomFiledObj.MaxLength != null && CustomFiledObj.MaxLength != "") {
                            MaxlengthValueArray.push(CustomFiledObj.DatabaseFieldName + "=" + CustomFiledObj.MaxLength);
                        }
                        if (CustomFiledObj.MinValue != null && CustomFiledObj.MinValue != "") {
                            MinValueArray.push(CustomFiledObj.DatabaseFieldName + "=" + CustomFiledObj.MinValue);
                        }
                        if (CustomFiledObj.MaxValue != null && CustomFiledObj.MaxValue != "") {
                            MaxValueArray.push(CustomFiledObj.DatabaseFieldName + "=" + CustomFiledObj.MaxValue);
                        }
                        //End Of added By Chetan M On 27th Mar 2020 For Issue ID 23059
                    }
                }
            });
             
            //Added by imran on 11-02-2022
            for (i1 = 0; i1 < TextAreaDefaultValue.length; i1++) {
                var value = TextAreaDefaultValue[i1].split("~");
                $("#txt" + value[0]).val(value[1]);
            }          
            //end By imran on 11-02-2022
            

            //Added by imran on 14-02-2022 For Dynamic Custom Value Set
            if ($("#cboIssueId").val() != 0) {
                for (var i = 0; i < Result.length; i++) {
                    var CustomFiledObj = Result[i];
                    var copyIssueIDs = { issueid: $("#cboIssueId").val(), strFieldName: CustomFiledObj.DatabaseFieldName };
                    GetFieldValueForIssue(copyIssueIDs, '');
                }
            }
            else
            {                
                for (var i = 0; i < Result.length; i++)
                {
                    
                    var CustomFiledObj = Result[i];                   
                    if (CustomFiledObj.DefaultType == 'F')
                    {
                        if (CustomFiledObj.DefaultValue == "Deliverable") {
                            var skillsSelect = document.getElementById("cbo"+CustomFiledObj.DefaultValue+"ID");
                        }
                        else {
                           var skillsSelect = document.getElementById("cbo" + CustomFiledObj.DefaultValue);
                        }

                        if (skillsSelect != null || skillsSelect != undefined)
                        {                           
                            var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;
                            //Added by imran on 21-02-2022
                            var selectedTextvalue = skillsSelect.options[skillsSelect.selectedIndex].value;
                            if (selectedTextvalue == "0") {
                                 $("#txt" + CustomFiledObj.DatabaseFieldName).val('');
                            }
                            else {
                                $("#txt" + CustomFiledObj.DatabaseFieldName).val(selectedText);
                            }
                            //end of comment by imran on 21-02-2022
                        }
                        else
                        {
                            if (CustomFiledObj.DefaultValue == "ReportedDate")
                            {
                                $.ajax({
                                    url: encodeURI(url) + '/api/IB_AddNewIssue/GetCurrentDateTime',
                                    type: 'GET',
                                    dataType: 'json',
                                    async: false,
                                    beforeSend: function (xhr) {
                                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    },
                                    success: function (result) {
                                        $('#txt' + CustomFiledObj.DatabaseFieldName).datepicker({
                                            autoclose: true,
                                            changeMonth: true,
                                            dateFormat: 'dd M yy'
                                        });                                     
                                        var NewReportedDate = result[0].split('-').join(' ');
                                        $("#dt" + CustomFiledObj.DatabaseFieldName).val(NewReportedDate);                                       
                                    },
                                    error: function (xhr, errorThrown) {
                                    }
                                });                               
                            }
                            else
                            {
                                //Added by imran on 26-02-2022
                                if (CustomFiledObj.DefaultValue == "CustomFieldDate1" || CustomFiledObj.DefaultValue == "CustomFieldDate2" || CustomFiledObj.DefaultValue == "CustomFieldDate3" || CustomFiledObj.DefaultValue == "CustomFieldDate4"|| CustomFiledObj.DefaultValue == "CustomFieldDate5" )
                                {
                                    $("#dt" + CustomFiledObj.DatabaseFieldName).val('');
                                    $("#dt" + CustomFiledObj.DatabaseFieldName).val($("#dt" + CustomFiledObj.DefaultValue).val());
                                }
                                else
                                {
                                    $("#txt" + CustomFiledObj.DatabaseFieldName).val('');
                                    $("#txt" + CustomFiledObj.DatabaseFieldName).val($("#dt" + CustomFiledObj.DefaultValue).val());
                                }
                                //End by imran on 26-02-2022
                            }                            
                        }                       
                    }                   
                }
            }
            //End by imran on 14-02-2022 For Dynamic Custom Value Set

            SetValidationToCustomFields();
        }

        var ValidationMessageFieldName = new Array();
        var ValidationMessageFiled = new Array();
        function SetValidationToCustomFields() {

            for (var i = 0; i < ValidationFieldsName.length; i++) {

                var customFiled = { FieldID: ValidationFieldID[i], CustomFieldName: ValidationFieldsName[i], CustomValidation: (ValidationRules[i]).toString() };

                $.ajax({
                    url: encodeURI(url) + '/api/IB_BulkUpdate/GetValidationForCustomFields',
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
                            var ValidationObj = result[i];

                            if (ValidationMessage != "") {

                            }
                            //if (ValidationMessage.indexOf(ValidationObj.ValidationMessage) == -1) {
                                ValidationMessage.push(ValidationObj.ValidationMessage);
                            //}
                            //if (ValidationValidateID.indexOf(ValidationObj.ValidationID) == -1) {
                                ValidationValidateID.push(ValidationObj.ValidationID);
                            //}
                            //if (ValidationMessageFiled.indexOf(ValidationObj.FieldID) == -1) {
                                ValidationMessageFiled.push(ValidationObj.FieldID);
                            //}
                            //if (ValidationMessageFieldName.indexOf(ValidationObj.FieldName) == -1) {
                                ValidationMessageFieldName.push(ValidationObj.FieldName);
                            //}
                        }

                    }
                });
            }
        }

        var ValidationMessageNew = new Array();
        function CustomFieldValidation() {
           // debugger;
            var checkval = 0;
            for (var i = 0; i < ValidationMessageFieldName.length; i++) {
                //
                checkval = 0;
                switch (ValidationValidateID[i]) {

                    case "1":
                        //For Blank
                        if (ValidationMessage[i].indexOf("blank") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != undefined && $(ValidationMessageFiled[i]).val() == "") {
                                checkval = 1;
                                alertify.error(ValidationMessageFieldName[i] + ValidationMessage[i]);
                                $(ValidationMessageFiled[i]).focus()
                                return checkval;
                            }
                            else if (ValidationMessageFiled[i].indexOf('cboCustomField') > -1 && $(ValidationMessageFiled[i]).val() != undefined && $(ValidationMessageFiled[i]).val() == "0") {
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
                            if ($(ValidationMessageFiled[i]).val() != undefined && $(ValidationMessageFiled[i]).val() != "") {
                                if (!isNumeric($(ValidationMessageFiled[i]).val())) {

                                    checkval = 1;
                                    
                                    //Commnted and Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    if (ValidationMessage[i].indexOf('!!!') > -1) {
                                        ValidationMessage[i] = ValidationMessage[i].replace("!!!", "in ");
                                    }
                                   
                                    //alertify.error("For " + ValidationMessageFieldName[i] + " " + ValidationMessage[i]);
                                    alertify.error(ValidationMessage[i] + "'" + ValidationMessageFieldName[i] + "' field");
                                     //End of Commnted and  Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;


                    case "9"://for Alphabets
                        if (ValidationMessage[i].indexOf("Alphabets") != -1) {
                            if (ValidationMessageFiled[i].indexOf("Area") != -1) {
                                var Condition = $(ValidationMessageFiled[i]).text();
                            }
                            else {
                                var Condition = $(ValidationMessageFiled[i]).val();
                            }
                            //Added By Usha Pandit On 18.05.2021 For correct validation alert
                            if (ValidationMessage[i].indexOf('!!!') > -1) {
                                ValidationMessage[i] = ValidationMessage[i].replace("!!!", "in ");
                            }
                            //End Of Added By Usha Pandit On 18.05.2021 For correct validation alert
                            if (Condition != "") {
                                var pattern = /^[a-zA-Z]+$/;
                                if (!pattern.test(Condition)) {
                                    checkval = 1;
                                    //Commented And Added By Usha Pandit On 18.05.2021 For correct validation alert
                                    //alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i]);
                                    alertify.error( ValidationMessage[i] + "'" + ValidationMessageFieldName[i] + "' field");
                                    //End Of Added By Usha Pandit On 18.05.2021 For correct validation alert
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;
                    case "12": //For Maxlength 
                        if (ValidationMessage[i].indexOf("Max") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "") {
                                //Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                                //if ($(ValidationMessageFiled[i]).attr("maxlength")) {
                                //    if ($(ValidationMessageFiled[i]).val().length > $(ValidationMessageFiled[i]).attr("maxlength")) {

                                //        checkval = 1;
                                //        alertify.error(ValidationMessage[i] + "" + ValidationMessageFieldName[i]);
                                //        $(ValidationMessageFiled[i]).focus()
                                //        return checkval;
                                //        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                //    }
                                //}

                                if (ValidationMessageFiled[i].indexOf('CustomFieldText') > -1) {

                                    for (var k = 0; k < MaxlengthValueArray.length; k++) {
                                        var DatabseFieldNameArray = MaxlengthValueArray[k].split("=");
                                        var DatabseFieldName = DatabseFieldNameArray[0];
                                        var MaxlengthValue = DatabseFieldNameArray[1];
                                        if (ValidationMessageFiled[i].indexOf(DatabseFieldName) > -1) {
                                            //$(ValidationMessageFiled[i]).val('<ID>', ValidationMessageFieldName[i]);
                                            //Added by Chetan M on 6 Nov 2020 for Javascript Issue
                                            if ($(ValidationMessageFiled[i]).val() != undefined) {
                                                //End of Added by Chetan M on 6 Nov 2020 for Javascript Issue
                                                if ($(ValidationMessageFiled[i]).val().length > MaxlengthValue) {
                                                    checkval = 1;
                                                    var validationMsg = ValidationMessage[i];
                                                    validationMsg = validationMsg.replace('<ID>', ValidationMessageFieldName[i]);
                                                    validationMsg = validationMsg.replace('<LENGTH>', MaxlengthValue);
                                                    validationMsg = validationMsg.replace('<L>', $(ValidationMessageFiled[i]).val().length);
                                                    validationMsg = validationMsg.replace('\r\n', "");
                                                    alertify.error(validationMsg);
                                                    $(ValidationMessageFiled[i]).focus()
                                                    return checkval;
                                                }
                                                //Added by Chetan M on 6 Nov 2020 for Javascript Issue
                                            }
                                            //End of Added by Chetan M on 6 Nov 2020 for Javascript Issue
                                        }
                                    }

                                }
                                
                                //End Of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                            }
                        };
                        break;
                    case "13":
                        //For Positive Number
                        if (ValidationMessage[i].indexOf("positive numeric") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "") {
                                if ($(ValidationMessageFiled[i]).val() < 0) {

                                    checkval = 1;
                                    alertify.error("For " + ValidationMessageFieldName[i] + " " + ValidationMessage[i]);
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;

                    case "15":     //For Special Char
                        if (ValidationMessage[i].indexOf("contain") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "") {
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
                            if ($(ValidationMessageFiled[i]).val() != "") {
                                //Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                                //if ($(ValidationMessageFiled[i]).attr("MinValue")) {
                                //    if ($(ValidationMessageFiled[i]).val() < $(ValidationMessageFiled[i]).attr("MinValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MinValue")) {

                                //        checkval = 1;
                                //        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MinValue"));
                                //        $(ValidationMessageFiled[i]).focus()
                                //        return checkval;
                                //        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                //    }
                                //}

                                if (ValidationMessageFiled[i].indexOf('CustomFieldText') > -1) {
                                    for (var l = 0; l < MinValueArray.length; l++) {
                                        var DatabseFieldNameArray = MinValueArray[l].split("=");
                                        var DatabseFieldName = DatabseFieldNameArray[0];
                                        var MinValue = DatabseFieldNameArray[1];
                                        if (ValidationMessageFiled[i].indexOf(DatabseFieldName) > -1) {

                                            if (parseInt($(ValidationMessageFiled[i]).val()) < parseInt(MinValue)) {
                                                checkval = 1;
                                                var validationMsg = ValidationMessage[i];
                                                validationMsg = validationMsg.replace('<ID>', ValidationMessageFieldName[i]);
                                                validationMsg = validationMsg.replace('<VALUE>', MinValue);

                                                alertify.error(validationMsg);
                                                $(ValidationMessageFiled[i]).focus()
                                                return checkval;
                                            }
                                        }
                                    }
                                }                                
                                //End of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                            }
                        };
                        break;
                    case "17"://For  Maximum Value Check
                        if (ValidationMessage[i].indexOf("greater") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "") {
                                //Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                                if (ValidationMessageFiled[i].indexOf('CustomFieldText') > -1) {
                                    for (var l = 0; l < MaxValueArray.length; l++) {
                                        var DatabseFieldNameArray = MaxValueArray[l].split("=");
                                        var DatabseFieldName = DatabseFieldNameArray[0];
                                        var MaxValue = DatabseFieldNameArray[1];
                                        if (ValidationMessageFiled[i].indexOf(DatabseFieldName) > -1) {
                                            //Commented And Added By Usha Pandit On 06.05.2021 For validation of max length
                                            //if (parseInt($(ValidationMessageFiled[i]).val()) >= parseInt(MaxValue)) {
                                            if (parseInt($(ValidationMessageFiled[i]).val()) > parseInt(MaxValue)) {
                                                    //End Of Added By Usha Pandit On 06.05.2021 For validation of max length
                                                checkval = 1;
                                                var validationMsg = ValidationMessage[i];
                                                validationMsg = validationMsg.replace('<ID>', ValidationMessageFieldName[i]);
                                                validationMsg = validationMsg.replace('<VALUE>', MaxValue);

                                                alertify.error(validationMsg);
                                                $(ValidationMessageFiled[i]).focus()
                                                return checkval;
                                            }
                                        }
                                    }
                                }

                                //if ($(ValidationMessageFiled[i]).attr("MaxValue")) {
                                //    if ($(ValidationMessageFiled[i]).val() >= $(ValidationMessageFiled[i]).attr("MaxValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MaxValue")) {

                                //        checkval = 1;
                                //        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MaxValue"));
                                //        $(ValidationMessageFiled[i]).focus()
                                //        return checkval;
                                //        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                //    }
                                //}
                                //End of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
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

                            if ($(ValidationMessageFiled[i]).text() != "") {
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

        function GetComboboxValues(DatabaseFieldName, ProjectID) {


            //var commonProp = { ProjectId: parseInt(ProjectID) };
            var customFiled = { ProjectId: parseInt(ProjectID), DatabaseFieldName: DatabaseFieldName };
            //var newIssue = { DatabaseFieldName: DatabaseFieldName, commonproperty: ProjectID };
            //alert(newIssue);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetComboboxValues',
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
                  
                    if (result == true) {
			            alert("please don't send special character ");
                    } else {
                        for (var i = 0; i < result.length; i++) {

                            var list = result[i];
                            if (list.hasOwnProperty('CustomerName')) {
                                //  var s = ('<option value=' + list.CustomerName + ' >' + list.CustomerName + '</option>');

                                //var cboName = "#cbo" + DatabaseFieldName;

                                //$(cboName).append(s);

                                var cboName = "cbo" + DatabaseFieldName;

                                var objCbo1 = document.getElementById(cboName);
                                $("#" + cboName + " option").remove();
                                //$("#CboWeek option").remove();
                                for (var i = 0; i < result.length; i++) {

                                    var ObjVal = result[i];
                                    var objOption = document.createElement("OPTION");
                                    objCbo1.options.add(objOption);
                                    objOption.text = ObjVal.CustomerName;
                                    objOption.value = ObjVal.CustomerName;
                                }
                            } else {
                                //alert(list.ScheduleID);
                                //var s = ('<option value=' + list.UniqueID + ' >' + list.FieldName + '</option>');

                                var cboName = "cbo" + DatabaseFieldName;

                                var objCbo1 = document.getElementById(cboName);
                                $("#" + cboName + " option").remove();
                                //$("#CboWeek option").remove();
                                for (var i = 0; i < result.length; i++) {

                                    var ObjVal = result[i];
                                    var objOption = document.createElement("OPTION");
                                    objCbo1.options.add(objOption);
                                    objOption.text = ObjVal.FieldName;
                                    if (ObjVal.UniqueID == "") {
                                        objOption.value = ObjVal.FieldName;
                                    }
                                    else {
                                        //Commented & Added By Dipali V on 7th July 2023 For Custom Filed Saving ISsue
                                        objOption.value = ObjVal.FieldID;
                                        //objOption.value = ObjVal.UniqueID;
                                        //End of Commented & Added By Dipali V on 7th July 2023 For Custom Filed Saving ISsue
                                    }
                                    
                                }

                                // $(cboName).append(s);
                            }
                        }
                    }


                },
                error: function (xhr, errorThrown) {
                    // //alert("error ");
                }
            });


        }

        function CustomfiledDatePicker(customfileddateid) {

            var filedid = "#dt" + customfileddateid;
            $(filedid).datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy'
            });

        }
        //custome_input_file
        function alertFilename() {
            var thefile = document.getElementById('thefile');
            document.getElementById('fileName').innerHTML = thefile.value;
        }

        function SelectFile() {

            var strFileCount = $("#btnSelectFile").attr("FileCount");

            var objCurrentFileControl = $("#txtFileName" + strFileCount);

            if (FileCount_toDisable == 5) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("User can attach maximum five files at a time.", 'error', 25);
                return;
            }
            objCurrentFileControl.click();
        }

        var FileCount = 0;
        var FileCount_toDisable = 0;
        var fileObject = [];
        var fileObject1 = [];
        var AllfileData = [];
        var data = new FormData();
        var isValidTypeExeCheck;
        async function addFileinGrid() {
            //debugger;
            //Added By Usha Pandit On 01.04.2020 For showing invalid content type for correct type as it was checking old invalid file
            data = new FormData();
            //End Of Added By Usha Pandit On 01.04.2020 For showing invalid content type for correct type as it was checking old invalid file
            var LoginType = "<%= Session("LoginType").ToString() %>";
            var objtxtFileName = document.getElementById('txtFileName' + FileCount);
            var fileName = objtxtFileName.value;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


            //added by Parth Godshelwar
            var objFileName = objtxtFileName;
            isValidTypeExeCheck = false;
            //Commented and Added by Aditya J. on 25-11-2024
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            //End of Commented and Added by Aditya J. on 25-11-2024
            isValidTypeExeCheck = ValidExtsExe.includes(extension);

            if (isValidTypeExeCheck) {
                const file = objFileName.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        //alert("File is valid and ready to upload.");
                    })
                    .catch(error => {
                        console.log(error);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;
                        $(objtxtFileName).val("");
                        /*$(objFileName).attr("placeholder", "Upload File");*/
                        //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                        return;
                    });



                if (!isValidTypeExeCheck) {
                    return;
                }
            }

            //$(objtxtFileName).val("");

            //Ended by Parth Godshelwar



            var files = objtxtFileName.files;
            var file;
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetFileType',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {

                    if (result == true) {

                        //Added by imran on 17-10-2022
                        AllfileData.push(FileCount);
                        //End of comment by imran on 17-10-2022

                        var LoginType = "<%= Session("LoginType").ToString() %>";
                        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                        var objFileGrid = document.getElementById('tblFiles');
                        objFileGrid.style.display = "";
                        var newRow = objFileGrid.insertRow(objFileGrid.rows.length);
                        objtxtFileName.style.display = "none";
                        newRow.id = 'FILENAME' + FileCount;
                        newRow.name = 'txtFileName';
                        newRow.className = "clsTREven";
                        var newCell = newRow.insertCell(0);
                        newCell.innerHTML = "<i class='fa fa-file-pdf-o' aria-hidden='true'></i>";

                        newCell = newRow.insertCell(1);
                        // var fileName = objtxtFileName.value;
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);

                        newCell.innerHTML = fileName;
                        //newCell.attr("id","File"+FileCount);
                        newCell = newRow.insertCell(2);
                        newCell.innerHTML = "<Textarea wrap='Hard'  name='txtComments' id='txtComments" + FileCount + "' class='form-control' style='width:250px  ; height:50px  ; text-align:Left' maxlength='2000' onkeyup='FindMaxLength(this)'  ></Textarea>";

                        //Added By Rutuja D. on 23 May 2022
                        newCell = newRow.insertCell(3);
                        var strHTML = "";
                        strHTML +='<% CommonFunctions.HTMLControls.DrawComboBox("cboDocumenttype" + "FileCount", "SELECT 'Select Document Type'",,, "name=""cboDocumenttypeFileCount"" class=""form-control"" onChange=""GetDocumentSubType(FileCount)"" ",,,, , ).Replace("'", "\'")%>';
                        newCell.innerHTML = strHTML.replace(/FileCount/g, FileCount);
                        newCell = newRow.insertCell(4);
                        var strHTML1= "";
                        strHTML1 +='<% CommonFunctions.HTMLControls.DrawComboBox("cboDocumentSubtype" + "FileCount", "Select 'Select Document Sub Type'",,, "name=""cboDocumentSubtypeFileCount"" class=""form-control"" onChange=""""",,,, , ).Replace("'", "\'")%>';
                        newCell.innerHTML = strHTML1.replace(/FileCount/g, FileCount);
                        //End of Added By Rutuja D. on 23 May 2022

                        newCell = newRow.insertCell(5);
                       
                        //}

                        newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveAttachement(" + FileCount + ")' Title='Remove Attachment' >(Remove)</A>";

                        parentTD = objtxtFileName.parentNode;
                        objtxtFileName.style.display = "none";

                        FileCount++;
                        FileCount_toDisable++;

                        GetDocumentType();
                        //GetDocumentSubType();

                        var FileControl;
                        FileControl = document.createElement("INPUT");
                        FileControl.type = "FILE";
                        FileControl.id = "txtFileName" + FileCount;
                        FileControl.name = "txtFileName" + FileCount;
                        FileControl.className = 'clsTextBox clsFileControl';
                        FileControl.size = 74;



                        FileControl.onkeydown = function () { return false; };
                        FileControl.onbeforepaste = function () { return false; };
                        FileControl.onpaste = function () { return false; };
                        FileControl.onkeydown = function () { return false; };
                        FileControl.onbeforepaste = function () { return false; };
                        FileControl.onpaste = function () { return false; };
                        FileControl.onchange = addFileinGrid;

                        if (FileCount_toDisable == 1)
                            FileControl.disabled = true;


                        parentTD.appendChild(FileControl);

                        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                        objtxtFileName.style.display = "none";
                        objtxtFileName.disabled = false;
                        $("#btnSelectFile").attr("FileCount", FileCount);

                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Invalid Content Type!!");
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);
                        //alert(fileName);
                        data.delete(fileName);
                    }


                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }

        function RemoveAttachement(FileNO) {

            var objTR = document.getElementById('FILENAME' + FileNO);

            var toRemoveFileControl = document.getElementById('txtFileName' + FileNO);
            var objFileGrid = document.getElementById('tblFiles');
            var fileName = $("#FILENAME" + FileNO + " td:nth-child(2)").text();


            //data.delete(fileName);

            objFileGrid.deleteRow(objTR.rowIndex);

            toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
            document.getElementById("txtFileName" + FileCount).disabled = false;;

            if (objFileGrid.rows.length == 1) {
                objFileGrid.style.display = 'none';
            }
            fileObject = [];

            FileCount_toDisable--;
           
            //Added by imran on 17-10-2022
            var index = AllfileData.indexOf(FileNO);
            AllfileData.splice(index, 1);
            //End of comment by imran on 17-10-2022
        }

        var validateflag;
        function SaveRequest_OnClick() {
            var AllValue = new Array();
            checkValidation();
           // debugger;
             //Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
            if (validateflag == true) {
                for (var i = 0; i < ValidationFieldIDSpecialChar.length; i++) {
                    if ($(ValidationFieldIDSpecialChar[i]).length > 0) { // Added By Dipali V On 3rd April 2023 For Check Control have access or not
                        if (ValidationFieldIDSpecialChar[i].indexOf("CustomFieldText") != -1 || ValidationFieldIDSpecialChar[i].indexOf("CustomFieldTextArea") != -1) {
                            if (checkSpecialCharacter($(ValidationFieldIDSpecialChar[i]).val(), WebConfigSpecialCharacters) == true) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ValidationFieldNameSpecialChar[i] + ' should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                                $(ValidationFieldIDSpecialChar[i]).focus()
                                validateflag = false;
                            }
                        }
                    }
                    if (validateflag == false) {
                        break;
                    }
                }
            }
            //End of Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields

            if (validateflag == true && CustomFieldValidation() == 0) {
                  //Added By Dipali V On 20th Dec 2019 For Double click Restirction 
                 StartLoader("#bodyAddNew");
                //Added By Rutuja D. on 25 Oct 2021 for Remove the pointer event 
                $("#btnSave").hide();
                $("#btnSave").css("pointer-events", "none");
                $("#btnSave").attr("disabled", "disabled");
                //End of Adde By Rutuja D. on 25 Oct 2021 for Remove the pointer event 

                //End of Added By Dipali V On 20th Dec 2019 For Double click Restirction 
                $('#divleft textarea, #divControlPloat textarea, #CustomFiledsControl textarea').each(function () {
                    //alert($(this).val());
                    //var str = $(this).val().replace("'", "''");
                    var str = $(this).val().replace(/\'/g, '\'\'');
                    // ✅ Use JS safe encoding
                    //Added by Vishal Mane on 01/06/2026 from SBI Security Issues
                    str = encodeURIComponent(str);          
                    //End of Added by Vishal Mane on 01/06/2026 from SBI Security Issues
                    var id = $(this).attr("id");
                    // id = id.replace('txt', '');
                    var name1 = $(this).attr("name");
                    if (name1 != "txtComments") {

                        if (id == "txtMessage") {
                            return false;
                        }
                        if (str.length == 0) {
                            str = null;
                        }
                        if (id == "message_area") {
                            var name = $(this).attr("name");
                            id = name;

                        }
                        id = id.slice(3);
                        //Added By Dipali V On 3rd Feb 2026 For encodeURI issue - use str only (single encoding) to avoid double encoding of Summary/Description
                        //Added an dcommented by Vishal Mane on 01/06/2026 from SBI Security Issues
                        //id = id + "=" + encodeURI(str);
                        id = id + "=" + str;
                        AllValue.push(id);
                    }


                });
                //$('input[type=Textbox]').each(function () {
                $('#divleft input[type=Textbox], #divControlPloat input[type=Textbox],#CustomFiledsControl input[type=Textbox]').each(function () {

                    var str = $(this).val();
                    var id = $(this).attr("id");
                    if (id == "txtTo" || id == "txtFrom" || id == "txtCC" || id == "txtSubject") {
                        return false;
                    }

                    if (str.length == 0) {
                        str = null;
                    }
                    //if (id == "dtReportedDate" || id == "dtStatusChangeDate") {
                    //    var dt = new Date(str);
                    //    var MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                    //    str = dt.getDate() + "-" + MONTHS[dt.getMonth()] + "-" + dt.getFullYear();

                    //}
                    if (id == "dtReportedDate" || id == "dtReportedTime" || id == "dtStatusChangeDate" || id == "dtStatusChangeTime") {

                        if (id == "dtReportedTime" || id == "dtStatusChangeTime") {
                            str = convertTo24Hour($(this).val().toLowerCase());
                        }
                        id = id.slice(2);

                    } else {
                        id = id.slice(3);
                    }

                    //id = id + "=" + encodeURI(str);
                    id = id + "=" + str;
                    // alert(id);
                    AllValue.push(id);
                    //}
                });

                //$('input[type=text]').each(function () {
                $('#divleft input[type=text],#divleft input[type=text],#CustomFiledsControl input[type=text]').each(function () {
                    //var str = $(this).val();
                    var str = $(this).val().replace("'", "''");
                    //alert(str);
                    var id = $(this).attr("id");
                    if (str.length == 0) {
                        str = null;
                    }
                    if (id.indexOf("dtCustomFieldDate") != -1) {
                        id = id.slice(2);
                    } else {
                        id = id.slice(3);
                    }
                    id = id + "=" + encodeURI(str);
                    // alert(id);
                    AllValue.push(id);
                });

                //$('select').each(function () {
                // $('select:not(#divControlPloatDuplicated)').each(function () {
                $('#divleft select, #divControlPloat select, #CustomFiledsControl select,#boxbodyProductFields select').each(function () {

                     var str = $(this).val();
                    //console.log($(this).attr("id"));
                    //debugger;
                    var id = $(this).attr("id");
                    var str;
                    if (id != "cboIssueId" && id != undefined) {


                        //if (id == "cboIssueProjects" || id == "cboCustomerIssueID" || id == "cboProduct" || id == "cboModule" || id == "AssignTo" || id == "CodedBy" || id == "RootCauseID" || id == "DeliverableID" || id == "ProductVersionID" || id == "ComponentID" || id == "CustomerID" || id == "ReleaseID" || id == "IterationID" || id == "UserStoryID" || id == "Module") {
                        if (id == "cboIssueProjects" || id == "cboRootCauseID" || id == "cboDeliverableID" || id == "cboProductVersionID" || id == "cboComponentID" || id == "cboCustomerID" || id == "cboRelease" || id == "cboIteration" || id == "cboUserStory" || id == "cboCodedByName" || id == "cboAssignToName" || id == "cboChangeRequestName") {

                            //commented and Added by Aditya J. on 11-02-2026 for issue not getting saved on QA site 
                            //str = $(this).children("option:selected").val();
                            str = $(this).val();
                            //End of commented and Added by Aditya J. on 11-02-2026 for issue not getting saved on QA site

                            id = id.slice(3);
                            if (id == "IssueProjects") {
                                id = "ProjectID";
                            }
                            if (id == "AssignToName") {
                                id = "AssignTo";
                            }
                            if (id == "CodedByName") {
                                id = "CodedBy";
                            }
                            if (id == "Release") {
                                id = "ReleaseID";
                            }
                            if (id == "Iteration") {
                                id = "IterationID";
                            }
                            if (id == "UserStory") {
                                id = "UserStoryID";
                            }
                            if (id == "ChangeRequestName") {
                                id = "ChangeRequestID";
                            }
                            
                            //if (str.indexOf("0") != -1) {
                            if (str == "0") {

                                str = null;
                                //  id = id.slice(3);
                                id = id + "=" + encodeURI(str);
                            } else {
                                // id = id.slice(3);
                                if (str == undefined) {
                                    str = null;
                                }
                                id = id + "=" + encodeURI(str);
                            }

                        } else {
                            //1st Oct 2025
                            //Added an dcommented by Vishal Mane on 01/06/2026 from SBI Security Issues
                            if (id == "cboCustomerID" || id == "cboCustomerIssueID" || id == "cboProduct" || id == "cboModule") {
                                //1st Oct 2025
                                //  var strval = $(this).children("option:selected").val();
                                if ($('#boxbodyProductFields').is(':visible') == true) {

                                    str = $(this).children("option:selected").val();
                                    id = id.slice(3);
                                    if (id == "Product") {
                                        id = "ProductVersionID";
                                    }
                                    if (id == "Module") {
                                        id = "ComponentID";
                                    }
                                    if (id == "CustomerIssueID") {
                                        id = "CustomerID";
                                    }
                                    //1st Oct 2025
                                    if (id == "CustomerID") {
                                        str = $(this).val();
                                    }
                                    //1st Oct 2025
                                    //id = id + "=" + encodeURI(str);

                                    if (str == "0") {
                                        str = null;
                                        id = id + "=" + encodeURI(str);
                                    } else {
                                        id = id + "=" + encodeURI(str);
                                    }
                                } else {
                                    return true;
                                }

                            }
                            else {
                                //Commented and Added by imran on 17-10-2022 crash come when Add new Issue
                                //if (id == "cboDocumenttype0" || id == "cboDocumentSubtype0") {
                                if (id.match("cboDocumenttype") || id.match("cboDocumentSubtype")) {
                                }
                                else {
                                    //End of comment Added by imran on 17-10-2022 crash come when Add new Issue
                                    //Added & Commented By Dipali V On 6th July 2023 for saving issue
                                   // debugger;
                                    //str = $("#" + id + " option:selected").text();
                                    str = $("#" + id + " option:selected").val();
                                     //End of Added & Commented By Dipali V On 6th July 2023 for saving issue
                                    if (str.indexOf("Select") != -1 || str.indexOf("Select") != -1) {
                                        id = id.slice(3);
                                        str = null;
                                        id = id + "=" + encodeURI(str);
                                    } else {
                                        //return true;
                                        id = id.slice(3);
                                        id = id + "=" + encodeURI(str);
                                    }
                                }
                            }
                        }
                    }
                    //Commented and Added by imran on 17-10-2022 crash come when Add new Issue
                    //AllValue.push(id); AllValue.push(id);
                    if (id.match("cboDocumenttype") || id.match("cboDocumentSubtype")) {
                    }
                    else {
                        AllValue.push(id);
                    }
                    //End of Comment by imran on 17-10-2022 crash come when Add new Issue
                });
            


                var checkbox = document.querySelector('input[type="checkbox"]');

                //alert(checkbox.checked);
                //alert(chkid);                
                //Commented And Added By Usha Pandit On 05.05.2021 For duplicate ShowToCustomer field append crash issue
                //if ($("input[type='checkbox']").is(":visible")) {
                if ($("input[type='checkbox']").is(":visible") || "<%= Session("LoginType").ToString() %>" == "C") {                    
                    //End Of Added By Usha Pandit On 05.05.2021 For duplicate ShowToCustomer field append crash issue
                    if (checkbox != null && checkbox != undefined) {
                        if (checkbox.checked == true) {
                            strval = "1";
                        } else {
                            strval = "0";
                        }
                    }
                    //Added By Dipali V On 31st March 2021 For Get Issues list if Customer login
                    if ("<%= Session("LoginType").ToString() %>" == "C") {
                        strval = "1";
                    }
                   
                    //End of Added By Dipali V On 31st March 2021 For Get Issues list if Customer login
                    // checkbox = "ShowToCustomer=" + checkbox.checked;
                    checkbox = "ShowToCustomer=" + strval;
                    AllValue.push(checkbox);
                    var LoginType = "<%= Session("LoginType").ToString() %>";
                    var id = "LoginType=" + LoginType;
                    AllValue.push(id);
                }
                //Added By Dipali V On 31st March 2021 If Login Type C then Show to customer should be 1
                //Commented By Usha Pandit On 05.05.2021 For duplicate ShowToCustomer field append crash issue
                <%--if ("<%= Session("LoginType").ToString() %>" == "C") {
                    strval = "1";
                    var checkbox = "ShowToCustomer=" + strval;
                    AllValue.push(checkbox);
                    var LoginType = "<%= Session("LoginType").ToString() %>";
                    var id = "LoginType=" + LoginType;
                    AllValue.push(id);
                }--%>
                //End Of Commented By Usha Pandit On 05.05.2021 For duplicate ShowToCustomer field append crash issue
                  //End of Added By Dipali V On 31st March 2021 If Login Type C then Show to customer should be 1

                //alert(AllValue);
                console.log(AllValue);
                //return;
                var allValue = AllValue.toString();
                if (ValidateAttachment()) {
                    //console.log(AllValue);
                    $.ajax({
                        url: encodeURI(url) + '/api/IB_AddNewIssue/SaveIssue',
                        method: 'Post',
                        //data: JSON.stringify(removeDuplicates(AllValue)),
                        data: JSON.stringify(allValue),
                        dataType: 'json',
                        //async: false,
                        contentType: "application/json",

                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (allValue) {
                                xhr.setRequestHeader("Params", encryptString(isJson(allValue) ? allValue : JSON.stringify(allValue)));
                            }
                        },
                        success: function (result) {

                            attachement(result);
                           
                            alertify.set('notifier', 'position', 'top-right');
                            //Added & Commented By Dipali V On 16th April 2020 For Alter Issue , Issue ID 23167
                            //alertify.success("successfully added issue " + result);
                            //alertify.success("Issue Added Successfully " + result);
                            //End of Added & Commented By Dipali V On 16th April 2020 For Alter Issue , Issue ID 23167
                            var ProjectID = "<%= Session("IssueProject").ToString() %>";
                            var EmployeeId = "<%= Session("intUserID").ToString() %>";
                            
                            //Added by imran on 03-03-2022 As per had nikhil sir told
                           // window.location.reload();
                            IssueID_OnClick(result);
                            SendMailCheckCondtion(result, ProjectID, EmployeeId);                                                                                   
                            //Commented and added by imran on 03-03-2022 As per had nikhil sir told

                        },
                        error: function (xhr, errorThrown) {

                        }
                    });
                }
                //Added By Dipali V On 21st Dec 2021 For Show Save Button
                else {
                    $("#btnSave").show();
                     $("#btnSave").css("pointer-events", "auto");
                     $("#btnSave").removeAttr("disabled");
                }
                //End of Added By Dipali V On 21st Dec 2021 For Show Save Button

        } 
        else {

                return false;
            }
            //Added by Chetan M on 25th Jully 2020 for IssueID = 25561
            StopAjaxLoader("#bodyAddNew");
            //End of Added by Chetan M on 25th Jully 2020 for IssueID = 25561
        }

        //function removeDuplicates(arr) {
        //    return arr.filter((item,index) => arr.indexOf(item) === index);
        //}
        //Added By Reshma Chavan on 9th March 2022 to redirect to detail page after save issue
        function IssueID_OnClick(IssueID, tab) {
          
            StartLoader("#bodyIssueList");
            var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";

            var ProjectID = $("#cboIssueProjects :selected").val();

            var ProjectName = $("#cboIssueProjects :selected").text();
            var validatedparameter = IssueID + ProjectID;
            var token;
            $.ajax({
                url: url + '/api/IB_IssueDetails/generateToken',
                type: 'POST',               
                data: JSON.stringify(validatedparameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (validatedparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(validatedparameter) ? validatedparameter : JSON.stringify(validatedparameter)));
                    }
                },
                success: function (result) {
                    
                    token = result;                   
                    var vid = 0;                   
                    var vType = "A";                   
                    var secondfilter =''; 
                    var FirstFilter = '';

                    

                    var SavedQueryName ='';
                    var EmployeeID ='';
                    var QueryID = '';
                    var QueryType =''; 
                    var issueIdList = IssueID+'|';
                    var intPageNo = 1;
                    var tab = 'undefined';
                    
                    var url1 = "IB_IssueDetail.aspx?ProjectID=" + ProjectID + "&PKToken=" + token + "&ProjectName=" + ProjectName + " &IssueID=" + IssueID + " &IssueIDList=" + issueIdList + " &ViewType=" + vType + "&View=" + vid +
                        " &intPageNo=" + intPageNo + " &tab=" + tab + "&secondfilter=" + escape(secondfilter)
                        + "&FirstFilter=" + escape(FirstFilter) + "&SavedQueryName=" + escape(SavedQueryName) +
                        "&EmployeeID=" + escape(EmployeeID) + "&QueryID=" + escape(QueryID) + "&QueryType=" + escape(QueryType) + "&FromAdd=1";

                   
                    window.location.href = url1;

                },
                error: function (xhr, errorThrown) {
                    // console.log(err);
                }
            });
        }
        //End of Added Reshma Chavan on 9th March 2022 to redirect to detail page after save issue



        function ValidateAttachment() {
            var ValidateAttachmentFlag = true;
            $('#tblFiles tr').each(function () {

                var id = $(this).attr("id");

                if (id != undefined) {
                    var Filecount = id.split("FILENAME")[1];
                    var objFileName = document.getElementById('txtFileName' + Filecount);
                    var DocumentType = document.getElementById("cboDocumenttype" + Filecount);
                    var DocumentSubType = document.getElementById("cboDocumentSubtype" + Filecount);
                     
                    if (objFileName != null) {

                        if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                        if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                        var countOfDot, FileNameCharCount;
                        var intMinFileSize = '<%=ConfigurationManager.AppSettings("inFileSize")%>'
                        var intActualFileSize = (objFileName.files['0'].size);
                        var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
                        var validateExtensions;

                        validateExtensions = strFileExtension.split(",");
                        if (strFileExtension.length > 0) {
                            var allowSubmit = false;
                            var file = objFileName.value;
                            var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();

                            for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                                var strExtn;
                                strExtn = validateExtensions[cnt];
                                if (strExtn.toLowerCase() == extension) { allowSubmit = true; }

                            }
                            if (allowSubmit == false) {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!");
                                ValidateAttachmentFlag = false;
                                return false;

                            }

                        }

                        if (objFileName.files['0'].name != '')
                            var countOfDot = objFileName.files['0'].name.split(".").length - 1;

                        if (countOfDot > 1) {

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File with two or more extensions is not allowed!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (objFileName.files['0'].name != '')
                            FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

                        if (FileNameCharCount > 120) {

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File name should not exceed 120 characters!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (intActualFileSize < intMinFileSize) {

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
                            ValidateAttachmentFlag = false;
                            return false;

                        }
                        //Added By Rutuja D. on 23 MAy 2022
                        if (isBlank(DocumentType.value)) {
                            alertify.error('Please select document Type!');
                            DocumentType.focus();//Added By Dipali V On 5th April 2023 For Focus to Control
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        //if (isBlank(DocumentSubType.value)) {
                        //    alertify.error('Please select document Sub Type!');
                        //    ValidateAttachmentFlag = false;
                        //    return false;
                        //}
                        //End of Added By Rutuja D. on 23 MAy 2022
                    }
                }
            });
            return ValidateAttachmentFlag;
        }

        //Commented And Added By Reshma Chavan on 19 Feb 2021 For Multiple insertion while saving new issue
         //function attachement(issueid) {
        //    debugger;
        //    $.ajax({
        //        url: encodeURI(url) + '/api/IB_AddNewIssue/FileUplaod',
        //        data: data,
        //        cache: false,
        //        contentType: false,
        //        processData: false,
        //        method: 'POST',
        //        type: 'POST',
        //        async: false,
        //        beforeSend: function (xhr) {
        //            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
        //        },
        //        success: function (result) {
        //            debugger;
        //            var count = 0;
        //            $('#tblFiles tr').each(function () {
        //                debugger;
        //                var id = $(this).attr("id");
        //                if (id != undefined) {
        //                    var Attachmenttextarea = $("#" + id + " td:nth-child(3) textarea").val();
        //                    var OldFileName = $("#" + id + " td:nth-child(2)").text();
        //                    var IssuId = issueid;
        //                    return;
        //                    fileSaveInDB(Attachmenttextarea, IssuId, result[count], OldFileName);
        //                    count = count + 1;
        //                }

        //            });



        //        },
        //        error: function (xhr, errorThrown) {
        //            //alert("error ");
        //        }
        //    });
        //    // }
        //}
        //var ArrFileCount = [];
        //var ArrAttachmenttextarea = [];
        //var ArrDocumentType = [];
        //var ArrDocumentSubType = [];
          function attachement(issueid) {
            
            var formData = new FormData();
            var ArrAttachmenttextarea = [];
            var ArrDocumentType = [];
            var ArrDocumentSubType = [];
            var objFileGrid = document.getElementById('tblFiles');

            //Added by dipali V on 11th Sep 2019 for multiple insertation of attachments
            fileObject = [];
            $("#FileControlUploadDiv [type=File]").each(function (j, val) {
                if ($(this)[0].files.length != 0) {
                    fileObject[(j)] = $(this)[0].files;
                }
            })
              
            for (var i = 0; i < fileObject.length; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {
                    formData.append(fileObject[i][0].name, fileObject[i][0]);
                     //Added By Dipali V On 21st Dec 2021 For javascript
                    if ($("#txtComments" + AllfileData[i]).val() != undefined) {
                         //End of Added By Dipali V On 21st Dec 2021 For javascript
                        Attachmenttextarea = $("#txtComments" + AllfileData[i]).val().replace("'", "''");
                    } else {
                        Attachmenttextarea = "";
                    }

                    //Added By Rutuja D. on 23 May 2022
                    if ($("#cboDocumenttype" + AllfileData[i]).val() != undefined) {
                        AttachmentDocumentType = $("#cboDocumenttype" + AllfileData[i]).val();
                    } else {
                        AttachmentDocumentType = "";
                    }

                    if ($("#cboDocumentSubtype" + AllfileData[i]).val() != undefined) {
                        AttachmentDocumentSubType = $("#cboDocumentSubtype" + AllfileData[i]).val();
                    } else {
                        AttachmentDocumentSubType = "";
                    }

                    if (AttachmentDocumentSubType == "") {
                        AttachmentDocumentSubType = 0;
                    }
                    //End of Added By Rutuja D. on 23 May 2022
                    OldFileName = $("#FILENAME" + AllfileData[i] + " td:nth-child(2)").text();
                    ArrAttachmenttextarea.push(Attachmenttextarea);
                    ArrDocumentType.push(AttachmentDocumentType);
                    ArrDocumentSubType.push(AttachmentDocumentSubType);
                }
            }
            //End of Added by dipali V on 11th Sep 2019 for multiple insertation of attachments

            var IssuId = issueid;
            
            if (formData != "[]") {
                $.ajax({
                    url: encodeURI(url + '/api/IB_IssueDetails/FileUplaod'),
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    method: 'POST',
                    type: 'POST',
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (result) {


                        var j = 0;
                        for (var i = 0; i < result.length; i++)
                        {
                            //debugger;
                            //var Even = i % 2;
                           // if (Even == false)
                            //{
                                // Added & commented  by dipali V on 11th Sep 2019 for multiple insertation of attachments

                                //fileSaveInDB(ArrAttachmenttextarea[j], IssuId, result[i + 1], result[i]);
                                fileSaveInDB(ArrAttachmenttextarea[i], IssuId, result[i], result[i], ArrDocumentType[i], ArrDocumentSubType[i]);
                                //i++;
                           // }

                            //End of commented & added By Dipali Vekhande V On download zip file
                        }


                    },
                    error: function (xhr, errorThrown) {
                        // alert("error ");
                    }
                });
            }
        }
        //End of Commented And Added By Reshma Chavan on 19 Feb 2021 For Multiple insertion while saving new issue


        function fileSaveInDB(comment, issueid, NewFileName, oldFileName, DocumentTypeID, DocumentSubTypeID) {
            var EmployeeId = "<%= Session("intUserID").ToString() %>";
            var LoginType = "<%= Session("LoginType").ToString() %>";
            comment = comment.replace("'", "''");
            //Added By Rutuja D. on 23 May 2022
            if (DocumentTypeID == undefined) {
                DocumentTypeID = "";
            }
            if (DocumentSubTypeID == undefined) {
                DocumentSubTypeID = "0"
            }
            //End of Added By Rutuja D. on 23 May 2022

            //var UploadFileParameter = { issueid, EmployeeId, LoginType, NewFileName, oldFileName, comment, DocumentTypeID, DocumentSubTypeID };
            var UploadFileParameter = { issueid: issueid, EmployeeId: EmployeeId, LoginType: LoginType, NewFileName: NewFileName, oldFileName: oldFileName, comment: comment, DocumentTypeID: parseInt(DocumentTypeID), DocumentSubTypeID: DocumentSubTypeID }
            //console.log(UploadFileParameter);
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/FileUplaodSaveDB',
                method: 'Post',
                data: JSON.stringify(UploadFileParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",

                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (UploadFileParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(UploadFileParameter) ? UploadFileParameter : JSON.stringify(UploadFileParameter)));
                    }
                },
                success: function (result)
                {
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }



        function GetDefaultVersion(ProjectId) {
           // alert(intProjectID);
           // alert($("#cboReportedInVersion").length);
            var Parameter_NewIssue = {
             
                ProjectId: ProjectId,
            
            }
            var param = JSON.stringify(Parameter_NewIssue);
            var strResult = AJAXCallWithResult("/api/IB_AddNewIssue/GetDefaultVersion", param, false);
           // alert(strResult);
            if (strResult != "")
            {
                CurrentVersion = strResult[0].FieldName ;
                //alert(CurrentVersion);
               // 
                if (CurrentVersion != "") {
                       //jQuery("select#cboReportedInVersion option[value=" + CurrentVersion + "  ]").attr("selected", "selected");
                  //$("select#cboReportedInVersion option:contains(" + CurrentVersion + ")").attr('selected', 'selected');
                    $('#cboReportedInVersion').val(CurrentVersion).change();
                }
            }
            //return CurrentVersion;
        }



        //var cbocontrolfield = ["Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo4", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "Module", "IssueId"];
         //var cbocontrolfield = ["Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "Module", "IssueId", "ChangeRequest"];
         var cbocontrolfield = ["Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "ModuleName","IssueId", "ChangeRequest","ReportedInVersion","CorrectedInVersion"];//Added By Dipali V On 14th July Mandatory alert was not getting
        
        function checkValidation() {
         
            $("#divControlPloat span:contains('*'), #divleft  span:contains('*'), #CustomFiledsControl span:contains('*'), #boxbodyProductFields  span:contains('*')").each(function () {
               
                var MandatoryId = this.id;
                var controlID = MandatoryId.replace("Mandatory", "");
                var curcontrolID = controlID;

                //Added By Rehan C
                var Summary = document.getElementsByName("txtSummary")[0].value;
                var Description = document.getElementsByName("txtDescription")[0].value;
					//Added By Rehan on 07/11/2022 To check validation for Special characters  on 11/11/2022
					if (checkSpecialCharacter(Summary, WebConfigSpecialCharacters) == true) {
						alertify.set('notifier', 'position', 'top-right');
						alertify.error('Summary Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
						$("#txtSummary").focus();
						return false;
					}
					//Added By Rehan on 07/11/2022 To check validation for Special characters  on 11/11/2022
					if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
						alertify.set('notifier', 'position', 'top-right');
						alertify.error('Description Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
						$("#txtDescription").focus();
						return false;
					}

                //$('#' + this.id).remove();
                //if (MandatoryId.indexOf("Description") != -1 || MandatoryId.indexOf("Summary") != -1 || MandatoryId.indexOf("ImportID") != -1 || MandatoryId.indexOf("CustomerIssueID1") != -1 || MandatoryId.indexOf("CustomFieldText") != -1 || MandatoryId.indexOf("CustomFieldTextArea") != -1) {
                if (MandatoryId.indexOf("Description") != -1 || MandatoryId.indexOf("Summary") != -1 || MandatoryId.indexOf("ImportID") != -1 || MandatoryId.indexOf("CustomerIssueID1") != -1 ) {


                    var controlId = MandatoryId.replace("Mandatory", "txt")
                    if (MandatoryId.indexOf("Summary") != -1 || MandatoryId.indexOf("Description") != -1) {
                        //var controlId = MandatoryId.replace("Mandatory", "txt")
                        if ($("[name='" + controlId + "']").val().trim().length == 0) {

                            validateflag = false;
                            var filedName = controlId.replace("txt", "");
                            //Commented & Added By Dipali V On 14th Sep for Alert formate
                            //var message = filedName + " is Mandatory . please fill this " + filedName + " filed .";
                            var message = filedName + " should not be blank.";
                            //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                            // alert(message);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(message);
                            $("[name='" + controlId + "']").focus();
                            return false;
                        }
                        else {
                            validateflag = true;
                            return true;
                        }

                    } else {

                        controlId = "#" + controlId;
                        if ($(controlId).val().length == 0) {

                            validateflag = false;
                            var filedName = controlId.replace("txt", "");
                            //Added By Usha Pandit On 19.03.2020 for correct validation alert
                            
                            if (filedName == "#ImportID") {
                                filedName = "Import ID";
                            }
                            if (filedName == "#CustomerIssueID1") {
                                // Added & Commented By Dipali V On 16th April 2020 For Caption as per layout
                                //Commented And Added By Usha Pandit On 06.01.2021 for getting correct Mandatory alert for Customer Issue Id
                                //filedName = "Duplicate Issue ID";                               
                                var curcaption = $("#lblCustomerIssueID1")
                                    .clone()    //clone the element
                                    .children() //select all the children
                                    .remove()   //remove all the children
                                    .end()  //again go back to selected element
                                    .text();
                                
                                filedName = curcaption.toString().trim();
                                //End Of Added By Usha Pandit On 06.01.2021 for getting correct Mandatory alert for Customer Issue Id
                                
                               // filedName = "Customer Issue ID";
                                //End of Added & Commented By Dipali V On 16th April 2020 For Caption as per layout
                            }
                            //End Of Added By Usha Pandit On 19.03.2020 for correct validation alert
                            //Commented & Added By Dipali V On 14th Sep for Alert formate
                            //var message = filedName + " is Mandatory . please fill this " + filedName + " filed .";
                            var message = filedName + " should not be blank.";
                            //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                            // alert(message);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(message);
                            $(controlId).focus();
                            return false;
                        } else {
                            var filedName = controlId.replace("txt", "");
                            if (filedName == "#ImportID") {
                                filedName = "Import ID";
                                //if (checkSpecialCharacter($(controlId).val()) == true) {
                                //    validateflag = false;
                                //    var message = filedName + ' cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters'; alertify.set('notifier', 'position', 'top-right');
                                //    alertify.error(message);
                                //    $(controlId).focus();
                                //    return false;
                                //}

                                if (checkSpecialCharacter($(controlId).val(), WebConfigSpecialCharacters) == true) {
                                    validateflag = false;
                                    var message = filedName + ' cannot contain any of these' + WebConfigSpecialCharacters + ' Characters'; alertify.set('notifier', 'position', 'top-right');
                                  alertify.error(message);
                                  $(controlId).focus();
                                  return false;
                                }
                            }
                            validateflag = true;
                            return true;
                        }
                    }
                }
                alertify.set('notifier', 'position', 'top-right');
                if (MandatoryId.indexOf("ReportedDate") != -1 || MandatoryId.indexOf("ReportedTime") != -1 || MandatoryId.indexOf("StatusChangeDate") != -1 || MandatoryId.indexOf("StatusChangeTime") != -1 || MandatoryId.indexOf("CustomFieldDate") != -1) {
                    //  var controlid = "#dt" + strfield[i];
                    var controlId = MandatoryId.replace("Mandatory", "#dt");
                    if ($(controlId).val().length == 0) {
                        validateflag = false;
                        var filedName = controlId.replace("#dt", "");
                        if (filedName == "ReportedDate") {
                            filedName = "Reported Date";
                        }
                        else if (filedName == "ReportedTime") {
                            filedName = "Reported Time";
                        }
                        //Added By Usha Pandit On 07.01.2021 For Status Change Date and Time validation
                        if (filedName == "StatusChangeDate") {
                            filedName = "Status Change Date";
                        }
                        else if (filedName == "StatusChangeTime") {
                            filedName = "Status Change Time";
                        }
                        //End Of Added By Usha Pandit On 07.01.2021 For Status Change Date and Time validation
                        //Commented & Added By Dipali V On 14th Sep for Alert formate
                        //var message = filedName + " is Mandatory . please fill this " + filedName + " filed .";
                        var message = filedName + " should not be blank.";
                        //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        //alert(message);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(message);                       
                        //Commented And Added By Usha Pandit On 07.01.2021 For Status Change Date and Time validation
                        //$(controlId).focus();
                        if (filedName == "Status Change Time") {
                        }
                        else {
                            $(controlId).focus();
                        }
                        //End Of Added By Usha Pandit On 07.01.2021 For Status Change Date and Time validation
                        return false;
                    } else {
                        validateflag = true;
                        return true;
                    }


                }
                if (MandatoryId.indexOf("ShowToCustomer") != -1) {
                    var controlId = MandatoryId.replace("Mandatory", "#chk");
                    if ($(".clsCheckBox").prop("checked") == false) {
                        validateflag = false;
                        var filedName = controlId.replace("#chk", "");
                        //Added by Chetan M on 4th Aug 2020 for All E Tech Issue ID 
                        if (filedName == "ShowToCustomer") {
                            filedName = "Show To Customer";
                        }
                        //Commented & Added By Dipali V On 14th Sep for Alert formate
                        //var message = filedName + " is Mandatory . please checked this " + filedName + ".";
                        
                         //Commented and added by Chetan M on 13th Aug 2020 for Issue ID = 25674
                        //var message = filedName + " should not be blank.";
                        if (filedName == "Show To Customer") {
                            var message = "Please select "+ filedName +" checkbox.";
                        }
                        else {
                                var message = filedName + " should not be blank.";
                                var message = filedName + " should not be blank.";
                                var message = filedName + " should not be blank.";
                                var message = filedName + " should not be blank.";
                        }
                        //End of Commented and added by Chetan M on 13th Aug 2020 for Issue ID = 25674
                        //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        // alert(message);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(message);
                        $(".clsCheckBox").focus();
                        return false;

                    } else {
                        validateflag = true;
                        return true;
                    }
                }
                //debugger;
                //Added By Usha Pandit On 19.03.2020 For validation for mandatory fields
                if (MandatoryId.indexOf("Module") != -1 || MandatoryId.indexOf("ReportedInVersion") != -1 || MandatoryId.indexOf("ChangeRequest") != -1 || MandatoryId.indexOf("CorrectedInVersion") != -1 || MandatoryId.indexOf("Hardware") != -1 || MandatoryId.indexOf("Kernal") != -1 ) {
                    var controlId1 = MandatoryId.replace("Mandatory", "#cbo");
                    var controlId = MandatoryId.replace("Mandatory", "#cbo");
                    controlId = controlId + " :selected";
                    
                    //var cbovalue = $("" + controlId + " :selected").val();
                    var cbovalue = $(controlId).val();
                    if (cbovalue == 0 || cbovalue == "0") {
                        validateflag = false;
                        var filedName = controlId.replace("#cbo", "");
                        //added by dipali V on 14th Sep For Change caption iteration to sprint
                        if (filedName.lastIndexOf("ModuleName") != -1) {
                            controlID = controlID.replace(controlID, "Module Name");
                        }
                        if (filedName.lastIndexOf("ChangeRequestName") != -1) {
                            controlID = controlID.replace(controlID, "Change Request");
                        }
                        ////// if (filedName.lastIndexOf("RootCauseID") != -1) {
                        //////    controlID = controlID.replace(controlID, "Root Cause");
                        //////}
                        //Added By Dipali V On 3rd April 2020 For Correct in version alert was missing
                         if (filedName.lastIndexOf("CorrectedInVersion") != -1) {
                            controlID = controlID.replace(controlID, "Corrected In Version ");
                        }
                         if (filedName.lastIndexOf("ReportedInVersion") != -1) {
                            controlID = controlID.replace(controlID, "Reported In Version ");
                        }
                         //End of Added By Dipali V On 3rd April 2020 For Correct in version alert was missing
                        //Corrected In version 
                        //End of added by dipali V on 14th Sep For Change caption iteration to sprint
                        if (filedName.lastIndexOf("AssignToName") != -1) {
                            controlID = "Responsible Person";
                            //Commented & Added By Dipali V On 14th Sep for Alert formate
                            //var message = controlID + " is Mandatory . please select this " + controlID + ".";
                             
                            var message = controlID + " should not be blank.";
                            //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        } else {
                            //Commented & Added By Dipali V On 14th Sep for Alert formate
                            //var message = controlID + " is Mandatory . please select this " + controlID + ".";
                             
                            var message = controlID + " should not be blank.";
                            //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        }
                        // alert(message);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(message);
                        $(controlId1).focus();
                        return false;

                    } else {
                        validateflag = true;
                        return true;
                    }
                    
                }
                //End Of Added By Usha Pandit On 19.03.2020 For validation for mandatory fields
                if (cbocontrolfield.indexOf(controlID) != -1) {
                    //
                    var controlId1 = MandatoryId.replace("Mandatory", "#cbo");
                    var controlId = MandatoryId.replace("Mandatory", "#cbo");
                    controlId = controlId + " :selected";
                    //var cbovalue = $("" + controlId + " :selected").val();
                    var cbovalue = $(controlId).val();
                    if (cbovalue == 0 || cbovalue == "0") {
                        validateflag = false;
                        var filedName = controlId.replace("#cbo", "");
                        //added by dipali V on 14th Sep For Change caption iteration to sprint
                        if (filedName.lastIndexOf("Iteration") != -1) {
                            controlID = controlID.replace(controlID, "Sprint");
                        }
                        if (filedName.lastIndexOf("ReportedBy") != -1) {
                            controlID = controlID.replace(controlID, "Reported By");
                        }
                        if (filedName.lastIndexOf("RootCauseID") != -1) {
                            controlID = controlID.replace(controlID, "Root Cause ");
                        }
                        if (filedName.lastIndexOf("DeliverableID") != -1) {
                            controlID = controlID.replace(controlID, "Deliverable");
                        }
                        if (filedName == "CustomerIssueID") {
                             // Added & Commented By Dipali V On 16th April 2020 For Caption as per layout
                            //controlID = controlID.replace(controlID, "Customer Issue ID");
                            controlID = controlID.replace(controlID, "Duplicate Issue");
                             // End of Added & Commented By Dipali V On 16th April 2020 For Caption as per layout
                            
                        }
                        //alert(controlID);

                        //Added By Dipali V On 16th April 2020 For Alter Issues
                        if (controlID== "Phase") {
                            controlID = controlID.replace(controlID, "Source Phase");
                            //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                            var curval = $("#lblPhase").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim();                            
                            controlID = controlID.replace(controlID, curval);
                            //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        } 

                        if (controlID.lastIndexOf("FoundInPhase") != -1) {
                            controlID = controlID.replace(controlID, "Found In Phase");
                            //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                            var curval = $("#lblFoundInPhase").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim();  
                            controlID = controlID.replace(controlID, curval);
                            //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        }

                        if (controlID.lastIndexOf("FixedInPhase") != -1) {
                            controlID = controlID.replace(controlID, "Fixed In Phase");
                            //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                            var curval = $("#lblFixedInPhase").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim(); 
                            controlID = controlID.replace(controlID, curval);
                            //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        }
                         //End of Added By Dipali V On 16th April 2020 For Alter Issues
                       
                        
                        if (filedName.lastIndexOf("CodedByName") != -1) {
                            controlID = controlID.replace(controlID, "Coded By Name");
                            //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                            var curval = $("#lblCodedByName").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim(); 
                            controlID = controlID.replace(controlID, curval);
                            //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        }
                        //Addded By Dipali V On 16th April 2020 For Alert issues
                         if (filedName.lastIndexOf("DeliverableID") != -1) {
                            controlID = controlID.replace(controlID, "Deliverable");
                        }
                         //End of Addded By Dipali V On 16th April 2020 For Alert issues
                        //End of added by dipali V on 14th Sep For Change caption iteration to sprint
                        if (filedName.lastIndexOf("AssignToName") != -1) {
                            controlID = "Responsible Person";
                            //Commented & Added By Dipali V On 14th Sep for Alert formate
                            //var message = controlID + " is Mandatory . please select this " + controlID + ".";
                             
                            var message = controlID + " should not be blank.";
                            //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        } else {
                            //Commented & Added By Dipali V On 14th Sep for Alert formate
                            //var message = controlID + " is Mandatory . please select this " + controlID + ".";
                             
                            var message = controlID + " should not be blank.";
                            //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        }
                        // alert(message);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(message);
                        $(controlId1).focus();
                        return false;

                    } else {
                        validateflag = true;
                        return true;
                    }

                }
                //Commented And Added By Usha Pandit On 19.03.2020 for not getting alert for Customer mandatory field                
                //if (MandatoryId.indexOf("Product") != -1 || MandatoryId.indexOf("CustomerID") != -1) {
                if (MandatoryId.indexOf("Product") != -1 || MandatoryId.indexOf("CustomerID") != -1 || (MandatoryId.indexOf("CustomerIssueID") != -1 && $("#divCustomerIssueID").css("display") != "none")) {
                    //End Of Added By Usha Pandit On 19.03.2020 for not getting alert for Customer mandatory field
                    if ($("#boxbodyProductFields").is(":hidden")) {
                        validateflag = true;
                        return true;
                    } else {

                        if (MandatoryId.indexOf("CustomerID") != -1 && $("#cboCustomerID").is(":hidden")) {
                            validateflag = true;
                            return true;
                        } else {

                            var controlId = MandatoryId.replace("Mandatory", "#cbo");
                            var cbovalue = $("" + controlId + " :selected").val();
                            if (cbovalue == 0 || cbovalue == "0") {
                                validateflag = false;
                                //Commented & Added By Dipali V On 14th Sep for Alert formate
                                //var filedName = controlId.replace("cbo", "");
                                var filedName = controlId.replace("#cbo", "");
                                if (filedName == "CustomerIssueID") {
                                    filedName = filedName.replace(filedName, "Customer");
                                }
                                if (filedName == "Phase") {
                                    filedName = filedName.replace(filedName, "Source Phase");
                                }

                                //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                                //Commented & Added By Dipali V On 14th Sep for Alert formate
                                //var message = filedName + " is Mandatory . please select this " + filedName + ".";
                                 
                                var message = filedName + " should not be blank.";
                                //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                                //alert(message);
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(message);
                                $(controlId).focus();
                                return false;

                            } else {
                                validateflag = true;
                                return true;
                            }
                        }
                    }
                }



            });

        }

        function ClearRequest_OnClick() {
            //window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=1234', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
            // var strfield = ["ShowToCustomer","ReportedDate","ReportedTime","Description","Summary","tblFiles","Type","SubType","Priority","Status","Severity","ReportedBy","AssignToName","OS","Hardware","Kernel","Phase","FoundInPhase","FixedInPhase","CodedByName","ShowToCustomer","CustomFieldText1","CustomFieldText2","CustomFieldText3","CustomFieldText4","CustomFieldText5","CustomFieldText6","CustomFieldText7","CustomFieldText8","CustomFieldText9","CustomFieldText10","CustomFieldCombo1","CustomFieldCombo2","CustomFieldCombo3","CustomFieldCombo4","CustomFieldCombo5","CustomFieldCombo6","CustomFieldCombo7","CustomFieldCombo8","CustomFieldCombo9","CustomFieldCombo10","CustomFieldDate1","CustomFieldDate2","CustomFieldDate3","CustomFieldDate4","CustomFieldDate5","CustomFieldTextArea1","CustomFieldTextArea2","CustomFieldTextArea3","RootCauseID","DeliverableID","Complexity","ProductVersionID","CustomerID","ComponentID","Release","Iteration","UserStory","ImportID","CustomerIssueID1","Module","IssueId","Module","Product"];
            //Commented & Added By Dipali V On 15th Jan 2020 For Clear Issues
            //var strfield = ["Description", "Summary", "tblFiles", "Type", "Priority", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", "ShowToCustomer", "CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "ImportID", "CustomerIssueID", "Module", "IssueId", "Module", "Product"];
            //var strcbofield = ["ChangeRequestName","Type", "Priority", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", , "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID","CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "Module", "IssueId", "Product"];
            var strfield = ["ChangeRequestName","Description", "Summary", "tblFiles", "Type", "Priority", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", "ShowToCustomer", "CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "ImportID", "CustomerIssueID", "Module", "IssueId", "Module", "Product"];

            var strcbofield = ["ChangeRequestName","Type", "Priority", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", , "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID","CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "Module", "IssueId", "Product"];
             //End of Commented & Added By Dipali V On 15th Jan 2020 For Clear Issues

            for (var i = 0; i < strfield.length; i++) {

                if (strfield[i].indexOf("Description") != -1 || strfield[i].indexOf("Summary") != -1 || strfield[i].indexOf("ImportID") != -1 || strfield[i].indexOf("CustomerIssueID1") != -1 || strfield[i].indexOf("CustomFieldText") != -1 || strfield[i].indexOf("CustomFieldTextArea") != -1) {

                    var controlid = "txt" + strfield[i];

                    if (strfield[i].indexOf("Description") != -1 || strfield[i].indexOf("Summary") != -1) {

                        $("[name='" + controlid + "']").val("");

                    } else {

                        $("#" + controlid).val("");
                    }

                }

                if (strfield.indexOf("tblFiles") != -1) {

                }
                if (strfield[i].indexOf("ReportedDate") != -1 || strfield[i].indexOf("ReportedTime") != -1 || strfield[i].indexOf("StatusChangeDate") != -1 || strfield[i].indexOf("StatusChangeTime") != -1 || strfield[i].indexOf("CustomFieldDate") != -1) {

                    var controlid = "#dt" + strfield[i];

                    $(controlid).val("");
                    getServerDateTime();

                }
                if (strfield[i].indexOf("ShowToCustomer") != -1) {

                    $(".clsCheckBox").prop('checked', false);

                }

                if (strcbofield.indexOf(strfield[i]) != -1) {

                    var controlid = "#cbo" + strfield[i];

                    if (strfield[i] == "Type") {

                        $("" + controlid + " option[value=0]").prop('selected', true);

                        var ProjectID = $("#cboIssueProjects :selected").val();

                        var RoleId = "<%= Session("intPostID").ToString() %>";

                        var LoginType = "<%= Session("LoginType").ToString() %>";

                        var UserId = "<%= Session("intUserID").ToString() %>";


                        $('#cboSubType').empty();

                        $('#cboStatus').empty();

                        $("#CustomFiledsControl").empty();

                        PloatCustomControl1(ProjectID, Type, RoleId, LoginType, UserId);

                        AppendOptioncbo("SubType", "");

                        AppendOptioncbo("Status", "");

                    } else {

                        $("" + controlid + " option[value=0]").prop('selected', true);

                    }
                }
                var UserName = "<%= Session("strUserName").ToString() %>";
                //added By Dipali v On 28th Sep 2019 For Bind Usename
                $("#cboReportedBy option:contains(" + UserName + ")").prop('selected', true);
                    //End of added By Dipali v On 28th Sep 2019 For Bind Usename
                $("#cboCustomerIssueID").val("0");
                //Added by Chetan M on 06 Jan 2021 for clear issue
                $("#txtCustomerIssueID1").val("");
                $("#cboReportedInVersion option[value=0]").prop('selected', true);
                $("#cboCorrectedInVersion option[value=0]").prop('selected', true);
                $("#cboModuleName option[value=0]").prop('selected', true);
                //End of Added by Chetan M on 06 Jan 2021 for clear issue
            }
        }

        function Release_OnChange(Release) {
            GetIterationsByRelease(Release);
            Iteration_OnChange(0);
        }

        function GetIterationsByRelease(Release) {
            var issueParameters = {
                intReleaseID: Release,
            };


            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetIterationName',
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

                    var objCbo1 = document.getElementById("cboIteration");
                    $("#cboIteration option").remove();
                    for (var i = 0; i < result.length; i++) {
                        var Objresult = result[i];

                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.value = Objresult.IntIterationId;
                        objOption.text = Objresult.StrIterationName;

                    }
                    AppendOptioncbo("Iteration", "");
                    tooltipshow();

                },
                error: function (err) {
                    console.log(err);
                }
            });

        }


        //Get UserStory Name By Iteration
        function Iteration_OnChange(Iteration) {
            GetUserStoriesByIteration(Iteration);
        }

        function GetUserStoriesByIteration(Iteration) {
            var issueParameters = {
                intIterationID: Iteration,
            };

            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetUserStoryName',
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


                    var objCbo1 = document.getElementById("cboUserStory");
                    $("#cboUserStory option").remove();
                    for (var i = 0; i < result.length; i++) {
                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.value = Objresult.IntUserStoryId;
                        objOption.text = Objresult.StrUserStory;

                    }
                    AppendOptioncbo("UserStory", "");
                    tooltipshow();

                },
                error: function (err) {
                    console.log(err);
                }
            });

        }
        function BackOnClick() {
            var HeaderCaption = $(parent.document.getElementById('mainHeadingTop'));
            HeaderCaption.text("");
            HeaderCaption.text("Issues > Issues");
             //Added by Swapnagandha K. for Session Project Issue On 18-Oct-2019
            window.location.href = "IssueList.aspx?FromWhere=Issue&View=" + viewApplied +"&ViewType="+ '<%= Request.QueryString("ViewType")%>' +"";
               //EndAdded by Swapnagandha K. for Session Project Issue On 18-Oct-2019
        }
        function DefaultValue(projectId, Type, event) {
    
            var ProjectId = projectId;
            var Type = Type;
            /*var Parameter = [ProjectId, Type];*/
            var Parameter = {
                ProjectId: ProjectId,
                Type: Type};
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/DefaultValue',
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
                   // alert(result);
                    //if (result[0] != "") {
                    if (result[0] != "" && result[0] != null) {
                       //Commented and added by Chetan M on 23 Feb 2021 for Selecting issue
                        //$("#cboType option:contains(" + result[0] + ")").prop('selected', true);
                        $("#cboType").val(result[0]);
                        //End of Commented and added by Chetan M on 23 Feb 2021 for Selecting issue
                        if (event == "PageLoad") {
                            Type_OnChange(result[0]);
                        }
                    }
                 
                    if (result.length >= 7) {

                        $("#cboSubType").val(result[1] == null ? 0 : result[1]);
                        //Added By Dipali V On 3rd April 2020 For Status Binding Issues
                        if ($("#cboStatus option:contains(" + result[2] + ")").length != 0) {
                            $("#cboStatus").val(result[2] == null ? 0 : result[2]);
                        }
                        //End of Added By Dipali V On 3rd April 2020 For Status Binding Issues
                       
                        //Added By Dipali V On 22nd Feb 2022 For Clearing Selected Values
                        //if ($("#cboSeverity  option:selected").val() == "0") {
                        //    $("#cboSeverity").val(result[5] == null ? 0 : result[5]);
                        //}
                        if ($("#cboSeverity  option:selected").val() == "0") {
                            if (document.getElementById("cboSeverity").innerHTML.indexOf(result[5]) != -1) {
                                $("#cboSeverity").val(result[5] == null ? 0 : result[5]);
                            }
                            else {
                                $("#cboSeverity").val("0");
                            }
                        }

                        if ($("#cboAssignToName  option:selected").val() == "0") {
                            $("#cboAssignToName").val(result[3]).change();
                        }
                        if ($("#cboPriority  option:selected").val() == "0") {
                           // $("#cboPriority").val(result[4] == null ? 0 : result[4]);
                            if (document.getElementById("cboPriority").innerHTML.indexOf(result[4]) != -1) {
                                $("#cboPriority").val(result[5] == null ? 0 : result[4]);
                            }
                            else {
                                $("#cboPriority").val("0");
                            }
                        }

                        if ($("#cboComplexity  option:selected").val() == "0") {
                           // $("#cboComplexity").val(result[6] == null ? 0 : result[6]).change();
                            if (document.getElementById("cboComplexity").innerHTML.indexOf(result[6]) != -1) {
                                $("#cboComplexity").val(result[5] == null ? 0 : result[6]);
                            }
                            else {
                                $("#cboComplexity").val("0");
                            }
                        }

                        if ($("#cboFoundInPhase  option:selected").val() == "0") {
                            $("#cboFoundInPhase").val(result[7] == null ? 0 : result[7]).change();
                        }
                          //End of Added By Dipali V On 22nd Feb 2022 For Clearing Selected Values
                    }
                    //alert(result[4]);
                    StopAjaxLoader("#bodyAddNew");
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }

        function SendMailCheckCondtion(IssueId, PorjectId, EmployeeId) {
            var issueid = IssueId;
            var projectid = PorjectId;
            var employeeid = EmployeeId;
            var messageId = 8;
            var mailData = { ProjectId: PorjectId };
            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetMailData',
                method: 'Post',
                data: JSON.stringify(mailData),
                dataType: 'json',
                async: false,
                contentType: "application/json",

                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (mailData) {
                        xhr.setRequestHeader("Params", encryptString(isJson(mailData) ? mailData : JSON.stringify(mailData)));
                    }
                },
                success: function (result) {

                    if (result.ShowPopup == true) {
                        //alert("show popup");
                        window.open("../Email/SendEmail.aspx?MessageID=8&IssueID=" + issueid + "&ProjectID=" + projectid + "&EmployeeID=" + employeeid + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    } else {
                        SendMailWithoutPopup(messageId, issueid, projectid, employeeid);
                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }
        function SendMailWithoutPopup(MessageId, IssueID, ProjectID, EmployeeID) {
            var EmailParameters = {
                msgID: MessageId,
                intIssueID: IssueID,
                intProjectID: ProjectID,
                intEmployeeID: EmployeeID,

            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/SendEmail/GetEmailMessageInfo',
                type: "POST",
                data: JSON.stringify(EmailParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (EmailParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(EmailParameters) ? EmailParameters : JSON.stringify(EmailParameters)));
                    }
                },
                success: function (data) {
                    //console.log(data);
                    //alert("Success")
                    // EmailMessageList = data;
                    var EmailObject = data[0];
                    var FromEmailID = EmailObject.FromEmailID;
                    var ToEmailID = EmailObject.ToEmailID;
                    var CCToEmailID = EmailObject.CCToEmailID;
                    var Subject = EmailObject.Subject;
                    var Message = EmailObject.Message;
                    SendMail(FromEmailID, ToEmailID, CCToEmailID, Subject, Message)
                    // PlotEmailSection(EmailMessageList);
                },
                error: function (err) {
                    console.log(err);
                    //alert(data)
                }
            });
            //});
        }
        function SendMail(FromEmailID, ToEmailID, CCToEmailID, Subject, Message) {


            var FromEmailID = FromEmailID;
            var ToEmailID = ToEmailID;
            var CCToEmailID = CCToEmailID;
            var Subject = Subject;
            var Message = Message;

            var SendEmailParameters = {
                strToEmailID: ToEmailID,
                strCCToEmailID: CCToEmailID,
                strFromEmailID: FromEmailID,
                strSubject: Subject,
                strMessage: Message,
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/SendEmail/SendEmailMessage',
                type: "POST",
                data: JSON.stringify(SendEmailParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (SendEmailParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SendEmailParameters) ? SendEmailParameters : JSON.stringify(SendEmailParameters)));
                    }
                },
                success: function (data) {
                    console.log(data);
                    //RemoveFrameLoader();
                    //window.close();

                },
                error: function (err) {
                    console.log(err);
                    //alert(data)
                }
            })
            // }


        }
        //function disallowSpecialCharacters(obj) {
        //    if (obj == null) { return false; }
        //    if (isBlank(getInputValue(obj))) { return false; }
        //    var msg = (arguments.length > 1) ? arguments[1] : "";
        //    msg = replaceSubstring(msg, "&#39;", "'");
        //    var dofocus = (arguments.length > 2) ? arguments[2] : true;
        //    var spChars = (arguments.length > 3) ? arguments[3] : "[/:*?+\"><|,\\\\]";
        //    if (hasSpecialCharacters(getInputValue(obj), spChars)) {
        //        if (!isBlank(msg)) {

        //            alertify.set('notifier', 'position', 'top-right');
        //            alertify.error(msg);
        //        }
        //        if (dofocus) {
        //            setFocus(obj);
        //        }
        //        return true;
        //    }
        //    return false;
        //}

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {

           var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            StartLoader("#bodyAddNew");
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
                    StopAjaxLoader("#bodyAddNew");
                    ajaxResult = data;
                },
                error: function (err) {
                    StopAjaxLoader("#bodyAddNew");
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
        //Commented And Added By Usha Pandit On 17.03.2020 For extracting correct time
        //function convertTo12Hour(time24) {
        //    var ts = time24;
        //    var H = +ts.substr(0, 2);
        //    var h = (H % 12) || 12;
        //    //h = (h < 10) ? ("0" + h) : h;  // leading 0 at the left for 1 digit hours
        //    var ampm = H < 12 ? " AM" : " PM";
        //    ts = h + ts.substr(2, 3) + ampm;
        //    return ts;
        //}
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

        //function checkSpecialCharacter(value) {
        //    var regularExpression = WebConfigSpecialCharacters;
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
        function convertTo24Hour(time) {
            var hours = parseInt(time.substr(0, 2));
            if (time.indexOf('am') != -1 && hours == 12) {
                time = time.replace('12', '0');
            }
            if (time.indexOf('pm') != -1 && hours < 12) {
                time = time.replace(hours, (hours + 12));
            }
            return time.replace(/(am|pm)/, '');
        }
        //function customfieldValidation(validtionNO, ControlID) {

        //    var message;
        //    switch (validtionNO) {
        //        case 2: {
        //            var result = isDate(ControlID);
        //            if (result != true) {
        //                message = "The Date you have entered is Invalid !!!";

        //            }
        //            break;
        //        }
        //        case 3: {

        //        }

        //        default:
        //    }
        //}

        function GetDocumentSubType(Filecount) {
            $('#tblFiles tr').each(function () {
                var id = $(this).attr("id");
                if (id != undefined) {

                     //Commented  By Dipali V On 12th May 2023 For Sub Type Clear issue
                    // var Filecount = id.split(FNAME)[1];
                    //Added by imran on 17-10-2022
                    //Commented  By Dipali V On 12th May 2023 For Sub Type Clear issue
                    //Added by imran on 17-10-2022
                    var Type = $("#cboDocumenttype" + Filecount).val();
                    var SubType = $("#cboDocumentSubtype" + Filecount).val();
                    //End of comment by imran on 17-10-2022
                    var DocumentType = document.getElementById("cboDocumenttype" + Filecount);
                    var DocumentSubType = document.getElementById("cboDocumentSubtype" + Filecount);
                    DocumentType = DocumentType.value;
                    if (DocumentType == "") {
                        DocumentType = "NULL";
                    }
                    
                    //Comment and Added by imran on 17-10-2022
                    //$("#cboDocumentSubtype" + Filecount).empty();
                    if (SubType == "" || SubType =="Select Document Sub Type") {
                        $("#cboDocumentSubtype" + Filecount).empty();
                    }
                    //End of comment by imran on 17-10-2022

                    var selHTML = "";
                    selHTML += "<option  value='' > Select Document Sub Type </option>";
                    var formData = {
                        DocumentTypeID: DocumentType,
                        ProjectId: $("#cboIssueProjects :selected").val()
                    }
                    var param = JSON.stringify(formData);
                    var strResult = AJAXCallWithResult("/api/IB_IssueDetails/GetDocumentSubType", param, false);
                    if (strResult != undefined) {
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var SubCategoryID = d.SubCategoryID;
                            var SubCategory = d.SubCategory;
                            selHTML += "<option  value='" + SubCategoryID + "' >" + SubCategory + "</option>";
                        }
                    }
                    $("#cboDocumentSubtype" + Filecount).html(selHTML);
                   // $("#cboDocumentSubtype" + Filecount).val(SubType);
                    if ($("#cboDocumentSubtype" + Filecount).val() == "0") {
                        $("#cboDocumentSubtype" + Filecount).val(0);
                    }
                    $('[data-toggle="tooltip"]').tooltip();

                }
            });
        }

        function GetDocumentType() {
            $('#tblFiles tr').each(function () {
                var id = $(this).attr("id");
                if (id != undefined) {
                    var Filecount = id.split('FILENAME')[1];
                    var DocumentType = document.getElementById("cboDocumenttype" + Filecount);
                    DocumentType = DocumentType.value;
                    //Commented and added by imran on 17-10-2022
                    var Type = $("#cboDocumenttype" + Filecount).val();
                    //End of comment by imran on 17-10-2022                    

                    var formData = {
                        RoleID: '<%=Session("intPostID")%>',
                        ProjectId: $("#cboIssueProjects :selected").val()
                    }
                    var param = JSON.stringify(formData);
                    var strResult = AJAXCallWithResult("/api/IB_IssueDetails/GetDocumentType", param, false);

                    if (Type == "" || Type == "Select Document Type") {
                        $("#cboDocumenttype" + Filecount).empty();
                    }

                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value='' > Select Document Type </option>";
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var CategoryID = d.CategoryID;
                            var Category = d.Category;
                            selHTML += "<option  value='" + CategoryID + "' >" + Category + "</option>";
                        }

                        //Commented and added by imran on 17-10-2022
                        //$("#cboDocumenttype" + Filecount).html(selHTML);
                        if (Type == "" || Type == "Select Document Type") {
                            $("#cboDocumenttype" + Filecount).html(selHTML);
                        }
                       //End of comment by imran on 17-10-2022
                        $('[data-toggle="tooltip"]').tooltip();
                    }
                }
            });
        }

        //Added By Reshma Chavan on 15 June 2022 For Suntec Customization
        function FunctionalArea_OnChange(FunctionalityID) {
            var issueParameters = {
                FunctionalityID: FunctionalityID,
            };

            var param = JSON.stringify(issueParameters);
            var result = AJAXCallWithResult("/api/IB_AddNewIssue/GetSubFunctionalArea", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById("cboSubFunctionalArea");
                $("#cboSubFunctionalArea option").remove();
                for (var i = 0; i < result.length; i++) {
                    var Objresult = result[i];

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.value = Objresult.SubFunctionalityID;
                    objOption.text = Objresult.SubFunctionalityName;

                }
                AppendOptioncbo("SubFunctionalArea", "");
                tooltipshow();

            }

        }
        //End of Added By Reshma Chavan on 15 June 2022 For Suntec Customization

        //Added By Rutuja d on 30 June 2022 For SunTec Customization

        function BindOrigin() {
            //var commonProperty = { ProjectId: 0, IssueID: 0 };
            //var issueComboParameters = { commonProperty: commonProperty};
            var issueComboParameters = { ProjectId: 0, IssueID: 0 };
            var param = JSON.stringify(issueComboParameters);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/BindOrigin", param, false);
            if (result != undefined && result != null) {

                var selHTML = "";
                selHTML += "<option  value='0' IsUsSubUSMandatory='false' selected='selected'> Select Origin </option>";
                for (var i = 0; i < result.length; i++) {
                    var d = result[i];
                    var OriginID = d.OriginID;
                    var OriginName = d.OriginName;
                    var IsUsSubUSMandatory = d.IsUserstorySubUserstoryMandatory;
                    if (IsUsSubUSMandatory == true) {
                        IsUsSubUSMandatory = 1;
                    } else {
                        IsUsSubUSMandatory = 0;
                    }
                    selHTML += "<option  value='" + OriginID + "' IsUsSubUSMandatory='" + IsUsSubUSMandatory + "' >" + OriginName + "</option>";
                }
                $("#cboOrigin").html(selHTML);
            }
        }

        //Added by Parth.G
        //function validateDocFileForExe(file) {

        //    return new Promise((resolve, reject) => {
        //        //debugger;

        //        const reader = new FileReader();

        //        reader.onload = function (e) {
        //            const arrayBuffer = e.target.result;
        //            const uint8 = new Uint8Array(arrayBuffer);

        //            // Function to search for a specific byte sequence
        //            const containsSignature = (signature) => {
        //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
        //                    let found = true;
        //                    for (let j = 0; j < signature.length; j++) {
        //                        if (uint8[i + j] !== signature[j]) {
        //                            found = false;
        //                            break;
        //                        }
        //                    }
        //                    if (found) return true;
        //                }
        //                return false;
        //            };

        //            // Check for 'MZ' signature (common for Windows EXE files)
        //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
        //            if (containsSignature(mzSignature)) {
        //                reject("Upload restricted: This file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: This file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // If no signatures are found, the file is considered safe
        //            resolve();
        //        };

        //        reader.onerror = function () {
        //            reject("Error reading the file. Please try again.");
        //        };

        //        // Read the file as an ArrayBuffer
        //        reader.readAsArrayBuffer(file);
        //    });
        //}
        //Ended by Parth.G

        function GetSummayPrefix() {
            var param = JSON.stringify();
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetSummayPrefix", param, false);
            if (result != undefined && result != null) {
                return result;
            }
        }
        //End of Added By Rutuja d on 30 June 2022 For SunTec Customization

    </script>
</body>
</html>