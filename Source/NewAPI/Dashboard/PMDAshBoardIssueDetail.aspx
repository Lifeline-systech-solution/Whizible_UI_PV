<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PMDAshBoardIssueDetail.aspx.vb" Inherits="PbNIT.PMDAshBoardIssueDetail" %>

<!DOCTYPE html>
<html>
            <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Issues")%>
<head> 
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Issues</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_issues.css?v=2.15">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="../Issues/IssueDetails.css" rel="stylesheet" />


</head>
        <style>
        .issuedetailsidebar .col-md-6 .form-group label {
            white-space: normal;
        }

        #sidebarpanel hr {
            border-top-color: #888;
        }

        .uploadBtnWrap span.badge {
            border-radius: 50px
        }

        .input-group {
            flex-wrap: revert
        }

        .input-group-btn button.btn.btncalendar {
            height: 30px
        }

        .ow {
            max-width: 352px;
        }

        .media-body {
            width: 10000px;
            display: table-cell;
        }

        .nav-tabs > li > a.active {
            color: #fff !important;
            background: #1359ac
        }
    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyIssueDetails">
  
    <%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
    <%--<div id="divProjectList" >--%>

 	<%--commented and added by imran 27-10-2021--%>
    <%-- <div id="divIsseDetails" class="preloader">--%>
        <%-- <div class="clsShowHide" >--%>
		 <%--commented by imran 27-10-2021 for performance related--%>
    	<%-- <div class="clsShowHide" id="maindiv">--%>   
    
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
                                        <button id="nav-icon3" type="button" class="btn btn-default toggle-sidebar togglesidebarpanelbtn">
                                            <img class="fas fa-times" src="../../../Whizible2.0-new/dist/img/closeicon-white1.svg" width="20" alt="" data-bs-toggle="tooltip" data-placement="bottom" data-container="body" title="Hide Issue Details">
                                            <i class="fas fa-bars" data-bs-toggle="tooltip" data-placement="bottom" data-container="body" title="Click here to show issue details"></i>
                                        </button>
                                        
                                        <%--commented and added by imran 27-10-2021--%>
                                      <%--  <div class="box-header with-border">--%>
                                        <div class="box-header with-border" id="maindiv">
                                            <div class="row">
                                                <div class="col-md-3 col-sm-3 col-xs-2">
                                                <%--<a href="IssueList.aspx" data-bs-toggle="tooltip" data-container="body" data-placement="top" title="Back" class="btn boxheaderbtn pull-left">
                                                    <img src="../../../Whizible2.0-new/dist/img/backarrow_white.svg" alt="" width="20"></a>--%>
                                                <button data-bs-toggle="tooltip" onclick="goBack()" data-placement="bottom" style="margin-top: 10px;" title="Back" data-container="body" class="btn boxheaderbtn nextbtn pull-left">
                                                    <%--<img src="../../../Whizible2.0-new/dist/img/backarrow_white.svg" style="margin-top: -15px;" alt="" width="20">--%>
                                                    Back
                                                </button>
                                                </div>
                                                <div class="col-md-6 col-sm-6 col-xs-8" style="position:relative">
                                                <button id="btnPrev" data-bs-toggle="tooltip" onclick="showPrev()" data-placement="bottom" title="Prev" data-container="body" class="btn boxheaderbtn nextbtn pull-left border-0">
                                                    <img src="../../../Whizible2.0-new/dist/img/backarrow_white.svg" alt="" width="20"></button>
                                                <h3 class="box-title" id="HeaderIssue"></h3>
                                                <button id="btnNext" data-bs-toggle="tooltip" onclick="showNext()" data-placement="bottom" title="Next" data-container="body" class="btn boxheaderbtn nextbtn pull-right">
                                                    <img src="../../../Whizible2.0-new/dist/img/right-arrow.svg"  alt="" width="20"></button>
                                                    </div>
                                                <div class="col-md-3 col-sm-3 col-xs-2"></div>
                                            </div>
                                        </div>
                                        <!-- /.box-header -->
                                        <!-- /.box-header -->
                                        <div class="box-body summurysection" style="">
                                              <div class="boxformheading" id="divProjectName"><strong><span id="selectedProjectName" data-bs-toggle="tooltip" data-container="body" data-placement="Top" title="Project Name" title="Project Name" ></span></strong></div>
                                            <a class="editsummury"><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom"  class="fas fa-pencil-alt" title="Edit Summary" onclick="EditDetails()"></i></a>

                                         <%--   <h4 class="mt-0 ows" id="summary"></h4>
                                              <input type="text" class="form-control edit-input" />
                                                <div class="">
                                                    <a class="edit"><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom"  class="fas fa-pencil-alt" title="Edit Summary"  onclick="EditDetails('Summary',this)"></i></a>
                                                </div>--%>

                                            <h4 class="mt-0 ows"><span id="summary"></span><a class="editsummury"></a></h4>
                                            <%--<input type="text" id="texteditsummury" class="form-control edit-input">--%>
                                            <%-- //Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength FindMaxLength()--%>
                                            <label id="lblsummary" style="display:none">Summary <span id="MandatorySummary" style="color:red;">*</span></label>
                                            <textarea wrap="Soft" name="txtSummary" id="textsummary" class="form-control edit-input" style="text-align:Left" placeholder="" autocomplete="off" maxlength="500" onblur="blurFunction()" onkeyup="FindMaxLength(this)"></textarea>
                                        <%--  //End Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength FindMaxLength()--%>
                                             <div class="issuedetailinfo ows">
                                                 <label id="lblDescription" style="display:none">Description</label>
                                               <%--  //Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength FindMaxLength()--%>
                                               <textarea wrap="Soft" name="txtSummary" id="textIssueDescription" class="form-control edit-input" style="text-align:Left" placeholder="" autocomplete="off" maxlength="1000"  onblur="blurFunction()" onkeyup="FindMaxLength(this)"></textarea>
                                              <%--  //Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength FindMaxLength()--%>
                                                <p id="IssueDescription"></p>
                                                  
                                            </div>
                                            <hr />
                                            <div class="spacer" style="height: 40px;">&nbsp;</div>
                                            <div class="tabwrapper">
                                                <ul id="tabdetails" class="nav nav-tabs">
                                                    <li><a data-placement="top" id="divDiscussion" data-bs-original-title="View &amp; Post" href="#tab_1" data-bs-toggle="tab" data-toggle="tooltip" aria-expanded="true" class="active">Discussion</a></li>
                                                    <li class=""><a data-placement="top" id="AttachmentsID" data-bs-original-title="Upload Files" href="#tab_3" data-bs-toggle="tab" aria-expanded="false">Attachments</a></li>
                                                     <li id="liAssignIssue" class=""><a data-placement="top" id="AssignIssueID" data-bs-original-title="Assign Issue" data-toggle="tooltip" href="#tab_6" data-bs-toggle="tab" aria-expanded="false">Assign Issue</a></li>
                                                      <%--<li class="SLA" id="lisla"><a data-placement="top" id="SLA"  data-bs-original-title="SLA" class="bg-yellow" href="#tab_5" data-bs-toggle="tab" aria-expanded="false">SLA</a></li>
                                               --%>
                                                  <%--End of Commented & Added by Dipali V On 18th May 2020 For IssueID 24448 %>--%>
                                                      </ul>

                                                <div class="tab-content">
                                                    <div class="tab-pane active" id="tab_1">
                                                        <%If m_blnEditAccess = True Then%>
                                                        <p><a class="pull-right mb-2" href="javascript:;" data-bs-toggle="modal" id="addNewDiscussionID" data-bs-target="#addnewdiscussion" data-backdrop="static" data-keyboard="false">+ Add New Discussion</a></p>
                                                        <%End If %>
                                                        <div class="clearfix"></div>
                                                        <div id="DiscussionboxID">
                                                            
                                                        </div>
                                                        <!-- Discussionbox -->
                                                        
                                                        <!-- Discussionbox -->

                                                    </div>
                                                    <!-- /.tab-pane -->
                                                    <div class="tab-pane" id="tab_2">
                                                        <div class="box box-panel subboxpanel box-solid">
                                                            <div class="box-header with-border">
                                                                <h3 class="box-title">History</h3>
                                                            </div>
                                                            <div class="pt-1 pb-1">
                                                                <div class="col-md-8">
                                                                    <div class="form-inline" style="display:flex">
                                                                        <div class="form-group">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboSelectFields", "Select 0,'Select' ", 180,, "class='form-control'",,, ) %>
                                                                        </div>
                                                                        <div class="form-group ml-1">
                                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboModified", "Select 0,'Select' ", 180,, "class='form-control'",,, ) %>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="input-group stylish-input-group">
                                                                        <input id="projecttasksearch"  type="text" class="form-control" placeholder="Search" autocomplete="off">
                                                                        <span class="input-group-addon" style="height:28px;border:1px solid #ddd">
                                                                            <button type="submit">
                                                                                <span class="glyphicon glyphicon-search"></span>
                                                                            </button>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                                <div class="clearfix"></div>
                                                            </div>

                                                            <hr />

                                                            <div class="table-outer">
                                                                <div class="table-responsive">
                                                                    <table class="table table-hover table-bordered" id="tblHistoryDetails">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Date and Time</th>
                                                                                <th>Modified By</th>
                                                                                <th>Field</th>
                                                                                <th>Old Value</th>
                                                                                <th>New Value</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody id="tbdHistoryDetails">
                                                                    </table>
                                                                </div>
                                                            </div>
                                                            <div class="clearfix"></div>
                                                        </div>

                                                    </div>
                                                    <!-- /.tab-pane -->
                                                    <div class="tab-pane" id="tab_3">

                                                        <div class="row">
                                                            <div class="col-sm-7">
                                                                <div class="attacment-file">
                                                                    <div class="form-group">
                                                                        <%--  <input type="file" id="file"  name="img[]" class="file">--%>
                                                                        <div id="MainFileControlUploadDiv">

                                                                            <%=CommonFunctions.HTMLControls.DrawFileControl("txtMainFileName0", "txtMainFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addMainFileinGrid()' style='display:none !important;' class='clsFileControl'", False, True)%>
                                                                        </div>
                                                                        <div class="input-group">
                                                                     <%If m_blnEditAccess = True Then%>
                                                                            <span class="input-group-btn">
                                                                                <button class="btn borderbtn" id="btnMainSelectFile" mainfilecount="0" onclick="SelectMainFile();" type="button" style="width: 130px!important; height: 33px!important" data-bs-toggle="tooltip" data-placement="top" data-container="body" title="Select Attachment"><i class="fa fa-paperclip" aria-hidden="true"></i>Attachment</button>
                                                                            </span>
                                                                      <%End If %>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-5 text-right">
                                                                <button class="btn btnyellow" id="btnAddAttachment" style="visibility:hidden"; data-bs-toggle="tooltip" data-placement="top" data-container="body" title="Add Attachment(s)" onclick="AddAttachment_OnClick()">Add Attachment(s)</button>
                                                                <%--<button class="btn borderbtnred" onclick="ClearRequest_OnClick()"><%= MyBase.GetResourceString("C_Clear") %></button>--%>
                                                            </div>
                                                        </div>

                                                       <div id="divMainAttachments" class="bottom-bar" style="">
                                                            <div class="row">
                                                                <div class="col-sm-12 ">
                                                                    <table id="tblMainFiles" style="display: none; margin-top: 1%" class="clsGridTable table table-bordered">

                                                                        <thead class="clsTRColumnHeader" align="left">
                                                                            <tr>
                                                                                <th width="5%"></th>
                                                                                <th width="15%">Files</th>
                                                                                <th>Comments</th>                                                                                
                                                                                <th width="20%">Document Type <span style="color:red;">*</span></th>  <%--//Added By Dipali V On 5th April 2023 For Focus to Control--%>                                            
                                                                                <th width="20%">Document Sub Type</th>                                                                                
                                                                                <th width="18%">Remove</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody id="bodyMainFiles">
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="box box-panel subboxpanel box-solid">
                                                            <div class="box-header with-border">
                                                                <h3 class="box-title">Attachments</h3>
                                                            </div>
                                                            <div class="pt-1">
                                                                <div class="col-md-12">
                                                                     <%If m_blnEditAccess = True Then%>
                                                                    <button data-bs-toggle="modal" id="btnTrashButtonID" class="nostylebtn pull-right delattach"><i class="far fa-trash-alt" id="TrashButtonID"></i></button>
                                                                       <%End If%>
                                                                    <button data-bs-toggle="tooltip" data-placement="top" id="btnDownloadZipRequestAttachment" title="Click Here To Download All The Attachments" class="btn borderbtn pull-right ml-1" onclick="DownloadZipRequestAttachment();"><i class="fas fa-download" ></i>Download All (Zip)</button>
                                                                </div>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <hr />
                                                            <div class="table-outer">
                                                                <div class="table-responsive" style="max-height:50vh;">
                                                                    <table class="table table-hover table-bordered " id="tblAttachment">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>
                                                                                    <div class="custom_chckbox">
                                                                                        <input type="checkbox" id="Attachments1" class="chckHead">
                                                                                        <label for="Attachments1"></label>
                                                                                    </div>
                                                                                </th>
                                                                                <th><i class="far fa-comments"></i></th>
                                                                                <th><i class="fas fa-headset"></i></th>
                                                                                <th>ID</th>
                                                                                <th>Date and Time</th>
                                                                                <th>File name</th>
                                                                                <th>File Type</th>
                                                                                <th>Attached By</th>
                                                                                <th>Description</th>
                                                                                <th>Document Type</th>
                                                                                <th>Document Sub Type</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody id="tbodyAttachment">
                                                                            
                                                                        </tbody>
                                                                    </table>

                                                                </div>
                                                            </div>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>

                                                    <div id="tab_7" class="modal custmodal fade" role="dialog"  data-backdrop="static" data-keyboard="false">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">                                                                
                                                                <div class="modal-header" id="headerattachments" style="display:block;">
                                    <h5 class="modal-title">Attachments</h5>
                                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                                                <div class="modal-body">
                                                               
                                                                    <div class="col-md-12">
                                                                        <button data-bs-toggle="tooltip" id="btnattachmentdiscussion" data-placement="top" title="Click Here To Download All The Attachments" class="btn borderbtn pull-right ml-1" onclick="DownloadZipRequest();"><i class="fas fa-download" ></i>Download All (Zip)</button>
                                                                    </div>
                                                                    <div class="clearfix"></div>
                                                                
                                                                <hr />
                                                                <div class="table-outer">
                                                                    <div class="table-responsive">



                                                                        <table class="table table-hover table-bordered " id="tblDiscussionAttachment">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>
                                                                                        <div class="custom_chckbox">
                                                                                            <input type="checkbox" id="Attachments2" class="chckHeadd">
                                                                                            <label for="Attachments2"></label>
                                                                                        </div>
                                                                                    </th>
                                                                                    <%--<th><i class="far fa-comments"></i></th>--%>
                                                                                    <th>ID</th>
                                                                                    <th>Date and Time</th>
                                                                                    <th>File name</th>
                                                                                    <th>File Type</th>
                                                                                    <th>Attached By</th>
                                                                                    <th>Description</th>
                                                                                    <%--Added by Dipali V On 4th April 2023 For header Missing Issue--%>
                                                                                     <th>Document Type <span style="color:red;">*</span></th><%--//Added By Dipali V On 5th April 2023 For Focus to Control--%> 
                                                                                    <th>Document Sub Type</th>
                                                                                    <%--End of Added by Dipali V On 4th April 2023 For header Missing Issue--%>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody id="tbodyDiscussionAttachment">
                                                                                
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                                </div>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>

                                                    <div id="deleteinfomodal" class="modal fade custmodal" role="dialog">
                                                        <div class="modal-dialog modalsmall">
                                                            <!-- Modal content-->
                                                            <div class="modal-content">
                                                                <div class="modal-header" style="display:block;">
                                                                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                                                    <h4 class="modal-title">Delete</h4>
                                                                </div>

                                                                <div class="modal-body">
                                                                    <p align="center">You are about to delete Attachments. Do you want to Continue?</p>

                                                                    <div class="form-group mt-4">
                                                                        <div class="row">
                                                                            <div class="col-xs-6 col-sm-6 text-left">
                                                                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                                                            </div>
                                                                            <div class="col-xs-6 col-sm-6">
                                                                                <button class="btn btnyellow ml-1 pull-right" onclick="DeleteAttachments()" data-bs-dismiss="modal">Yes</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>

                                                    <div id="deletediscmodal" class="modal fade custmodal" role="dialog">
                                                        <div class="modal-dialog modalsmall">
                                                            <!-- Modal content-->
                                                            <div class="modal-content">
                                                                <div class="modal-header" style="display:block;">
                                                                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                                                    <h4 class="modal-title">Delete</h4>
                                                                </div>

                                                                <div class="modal-body">
                                                                    <p align="center">You are about to delete Discussion. Do you want to Continue?</p>

                                                                    <div class="form-group mt-4">
                                                                        <div class="row">
                                                                            <div class="col-xs-6 col-sm-6 text-left">
                                                                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                                                            </div>
                                                                            <div class="col-xs-6 col-sm-6">
                                                                                <input type="hidden" id="hdnDiscussionID" />
                                                                                <button class="btn btnyellow ml-1 pull-right" onclick="ConfirmDeleteDiscussion()" data-bs-dismiss="modal">Yes</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                    <!-- /.tab-pane -->
                                                    <div class="tab-pane" id="tab_4">
                                                        <div class="box box-panel subboxpanel box-solid">
                                                            <div class="box-header with-border">
                                                                <h3 class="box-title">Convert to Deliverable</h3>
                                                            </div>

                                                            <div class="col-md-12 pt-1">
                                                                <div class="form-group row">
                                                                    <label class="col-sm-4 text-right">Project</label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableProjects", "Select 0,'Select Project' ",,, "class='form-control'",,, ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-sm-4 text-right">Deliverable Type <span id="Mandatorydeliverabletype" style="color:red"> * </span></label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableTypes", "Select 0,'Select Deliverable Types' ",,, "class='form-control'",,, ) %>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-sm-4 text-right">Title</label>
                                                                    <div class="col-sm-8">
                                                                        <%--Commented And Added By Usha Pandit On 18.03.2020 For setting maxlength for Title field--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtDeliverableTitle", "dtDeliverableTitle", "form-control", , ,,,,,,,, "autocomplete='off'",,,,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtDeliverableTitle", "dtDeliverableTitle", "form-control", , 200,,,,,,,, "autocomplete='off'",,,,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 18.03.2020 For setting maxlength for Title field--%>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-sm-4 text-right">Description</label>
                                                                    <div class="col-sm-8">
                                                                        <% CommonFunctions.HTMLControls.DrawTextArea("dtaDescription", "dtaDescription", "form-control",,,,,, ,,,,,,,,,,,,,,,,,,,, True) %>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row" id="divCDdate">
                                                                    <label class="col-sm-4 text-right">Start Date <span id="MandatoryDeliStartDate" style="color: red;"> * </span></label>
                                                                    <div class="col-sm-8">
                                                                        <div class="row">
                                                                            <div class="col-md-6">
                                                                                <div class="input-group datefielddiv">
                                                                                    <%--<input id="CDdate" type="text" class="form-control">--%>
                                                                                   <%-- Commented & Added By Dipali V On 2nd june 2020--%>
                                                                                     <%-- <% CommonFunctions.HTMLControls.DrawTextBox("CDdate", "CDdate", "form-control", 150, 200,,,, , , ,, "Autocomplete='off'",,, True,,,, True) %>--%>
                                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("CDdate", "CDdate", "form-control", 150, 200,,,, , True, "white",, "Autocomplete='off'",,, True,,,, True) %>
                                                                                    <%-- End of Commented & Added By Dipali V On 2nd june 2020--%>
                                                                                    <span class="input-group-btn">
                                                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="text-center">
                                                                      <%If m_blnEditAccess = True Then%>
                                                              <button class="btn btnyellow" id="btnDSubmit">Save</button>
                                                                    <%End If %>
                                                                </div>

                                                            </div>

                                                            <div class="clearfix"></div>
                                                        </div>

                                                    </div>
                                                    <!-- /.tab-pane -->
                                                    <div class="tab-pane" id="tab_5">
                                                        <div class="box box-panel subboxpanel box-solid">
                                                            <div class="box-header with-border">
                                                                <h3 class="box-title">SLA</h3>
                                                            </div>
                                                            <div class="col-md-12 pt-1">
                                                            <div class="table-responsive" style="min-height:300px;">    <!--Added div class by pradip on 19-05-2021-->                                    <table class="table table-hover table-bordered">
                                                                <table class="table table-hover table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>SLA</th>
                                                                            <th colspan="1">Norm</th>
                                                                            <th>Actual</th>
                                                                            <%--<th>Remaining</th>--%>
                                                                            <th>Met/Not Met</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="tbodySLADetails">
                                                                      

                                                                    </tbody>
                                                                </table>
    </div>                        
                                                            </div>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>
                                                    <!-- /.tab-pane -->
                                                    <div class="tab-pane" id="tab_6">
                                                        <div class="box box-panel subboxpanel box-solid">
                                                            <div class="box-header with-border">
                                                                <h3 class="box-title">Assign Issue</h3>
                                                            </div>

                                                            <div class="col-md-12 pt-1">
                                                                <label class="control-label" id="lblWorkHours">Total Work Hours : </label>
                                                                <label class="control-label" id="lblTotalWorkHours"></label>
                                                                <div class="table-responsive">
                                                                    <table class="table table-hover table-bordered assignissue_tbl assignissue_order_list">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Resource</th>
                                                                                <th>Task Type</th>
                                                                                <%--<th>Subtask Type</th>--%>
                                                                                <th>Due <span>Date</span></th>
                                                                                <th>Start <span>Date</span></th>
                                                                                <th>End <span>Date</span></th>
                                                                                <th>Work <span>Hours</span></th>
                                                                                <th style="display:none;">ReOpen<span>Task</span></th>
                                                                                <th>Is<span>Billable</span></th>
                                                                                <th>&nbsp;</th>

                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <button data-bs-toggle="tooltip" data-placement="top" data-container="body" title="Click here to Add More" id="addassignissuerow" class="btn borderbtn"><i class="fas fa-plus"></i> &nbsp; Add more</button>


                                                            </div>


                                                            <div class="clearfix"></div>
                                                        </div>




                                                    </div>
                                                    <!-- /.tab-pane -->
                                                </div>


                                            </div>


                                        </div>
                                        <!-- /.box-body -->

                                    </div>
                                </div>

                                <div class="col-md-6 sidebarpanel" id="sidebarpanel">
                                    <div class="formpanel issuedetailsidebar">
                                        <div class="box box-panel box-solid">
                                            <%--commented and added by imran 27-10-2021--%>
                                            <%--<div class="box-header">--%>
                                            <div class="box-header" id="maindiv">
                                                <h3 class="box-title">Issue Details</h3>
                                                <button id="UpdateIssueDataID" data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Update" onclick="UpdateRequest_OnClick()" class="btn boxheaderbtn pull-right" id="autoclosable-btn-danger">Update</button>
                                            </div>
                                            <!-- /.box-header -->
                                            <!-- Danger messages -->
                                            <div class="alert alert-danger alert-autocloseable-danger animated fadeInRight" style="display: none;">
                                                <button type="button" class="close">×</button>
                                                Please select all fields.
                                            </div>

                                            <div class="box-body" id="boxbodyProductFields">
                                                <div class="boxformheading" id="divProductFields"><strong><%= MyBase.GetResourceString("C_Product_Fields") %></strong></div>
                                                <div class="row" id="rowProductFields">
                                                    <div class="col-md-4" id="divCustomerIssueID">
                                                        <div class="form-group">
                                                            <label class="control-label" id="lblCustomerIssueID"><%= MyBase.GetResourceString("C_Customer") %><span id="MandatoryCustomerIssueID" style="color: red;">*</span></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerID", "EXEC usp__Whizible2_Sel_tbl_PM_Customer_ProductExecution",,, "class='form-control' onchange='Customerclick(this.value)' ",,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4" id="">
                                                        <div class="form-group">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Product") %><span id="MandatoryProduct" style="color: red;">*</span></label>
                                                            
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Select 0,'Select Product' ",,, "class='form-control' onchange='ProductClick(this.value)' ",,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Module") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Select 0,'Select Module' ",,, "class='form-control'",,, ) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="box-body">
                                                <div class="boxformheading"><strong><%= MyBase.GetResourceString("C_Common_Fields") %></strong></div>
                                                <div>
                                                    <div id="controlploat" style="display: none;">
                                                        <div class="row">
                                                            <div id="divReportedBy">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblReportedBy"><%= MyBase.GetResourceString("C_Reported_By") %></label>
                                                                    <div class="form-group">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedBy", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy'," & Convert.ToInt32(Session("IssueProject").ToString()) & "," & Convert.ToInt32(Session("intUserID").ToString()) & ",1,NULL,NULL,'" & Session("LoginType") & "','New',0",,, "class='form-control'; style='background-color:white'", ,, ) %>
                                                                       <%-- <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedBy", " Select 0, 'Select Reported By'",,, "class='form-control' ",,, ) %>--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divReportedDate">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblReportedDate"><%= MyBase.GetResourceString("C_Reported_Date") %></label>
                                                                    <div class="input-group">
                                                                      <%--  Added & Commented By Dipali V On 4th June 2020 For Crash Issue--%>
                                                                       <%-- <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedDate", "dtReportedDate", "form-control", 50, 200,,,, ,,,,,,, True,,,,) %>--%>
                                                                         <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedDate", "dtReportedDate", "form-control", 50, 200,,,, True, True, "White",,,,, True,,,,) %>
                                                                        <%-- End of  Added & Commented By Dipali V On 4th June 2020 For Crash Issue--%>
                                                                        <span class="input-group-btn">
                                                                       <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                                    </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divReportedTime">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblReportedTime"><%= MyBase.GetResourceString("C_ReportedTime") %></label>
                                                                    <div class="input-group">
                                                                        <%--Commented And Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtReportedTime", "dtReportedTime", "form-control", 50, 200,,,, ,,,,,,, True,,,,) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtReportedTime", "dtReportedTime", "form-control", 50, 200,,,, True, ,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'", ,, True,,,,) %>
                                                                        <%--End Of Added By Usha Pandit On 04.06.2020 for restricting alphabates for Reported Date and time--%>
                                                                    <span class="input-group-btn">
                                                                         <button class="btn btncalendar" type="button"><i class="far fa-clock"></i></button>
                                                                    </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div id="divType">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblType"><%= MyBase.GetResourceString("C_Type") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboType", "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & Convert.ToInt32(Session("intProjectID").ToString()) & ",'T',Null,Null,Null,Null,Null," & Convert.ToInt32(Session("intPostID").ToString()),,, "class='form-control' onchange='Typeclick(this.value)'",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboType", "Select 0,'Select Type'  ",,, "class='form-control' onchange='Typeclick(this.value)'",,, ) %>
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
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "Select 0,'Select Status' ",,, "onchange='Status_OnChange()' class='form-control '",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div id="divCodedByName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblCodedByName"><%= MyBase.GetResourceString("C_CodedBy") %> </label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboCodedByName", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " & Convert.ToInt32(Session("intProjectID").ToString()) & ", NULL ,NULL, NULL, NULL ," & "'" & Session("LoginType") & "','New',0 ",,, "class='form-control'",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCodedByName", "Select 0, 'Select Coded By'",,, "class='form-control'",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divRelease">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblRelease"><%= MyBase.GetResourceString("C_Release") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRelease", "usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseID " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRelease", "Select 0, 'Select Release'",,, "class='form-control ' onchange='Release_OnChange(this.value)' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divIteration">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblIteration"><%= MyBase.GetResourceString("C_Sprint") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboIteration", "Exec usp_Whizible2_sel_tbl_PM_ScrumIteration " & 0,,, "class='form-control ' onchange='Iteration_OnChange(this.value)'",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div id="divUserStory">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblUserStory"><%= MyBase.GetResourceString("C_User_Story") %></label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "Exec usp_Whizible2_tbl_PM_ScrumUserStory " & 0,,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <%--<div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="control-label">&nbsp;</label>
                                                                    <div class="form-group">&nbsp;</div>
                                                                </div>
                                                            </div>--%>
                                                            <div id="divStatusChangeDate">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblStatusChangeDate"><%= MyBase.GetResourceString("C_StatusChangeDate") %></label>
                                                                    <div class="form-group">
                                                                        <%--Commented And Added By Usha Pandit On 10.06.2020 for restricting alphabates for Status Change Date and time--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeDate", "dtStatusChangeDate", "form-control", 50, 200,,,, ,,,,,,, True,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeDate", "dtStatusChangeDate", "form-control", 50, 200,,,, , True, "white",, "Placeholder='Status Change Date' onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'",,, True,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 10.06.2020 for restricting alphabates for Status Change Date and time--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divStatusChangeTime">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblStatusChangeTime"><%= MyBase.GetResourceString("C_StatusChangeTime") %></label>
                                                                    <div class="form-group">
                                                                        <%--Commented And Added By Usha Pandit On 10.06.2020 for restricting alphabates for Status Change Date and time--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeTime", "dtStatusChangeTime", "form-control", 50, 200,,,, ,,,,,,, True,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("dtStatusChangeTime", "dtStatusChangeTime", "form-control", 50, 200,,,, , True, "white",, "Placeholder='Status Change Time' onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'",, , True,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 10.06.2020 for restricting alphabates for Status Change Date and time--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div id="divDeliverableID">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblDeliverableID"><%= MyBase.GetResourceString("C_Deliverable") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableID", "Exec usp_Whizible2_sel_tbl_PM_OtherSchedules " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableID", "Select 0, 'Select Deliverable'",,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divPriority">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblPriority"><%= MyBase.GetResourceString("C_Priority") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "Exec usp_Whizible2_Sel_tbl_IB_Project_Priorities " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "Select 0,'Select Priority' ",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divSeverity">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblSeverity"><%= MyBase.GetResourceString("C_Severity") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "Exec usp_Whizible2_Sel_tbl_IB_Project_Severity " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "Select 0, 'Select Severity'",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divComplexity">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblComplexity"><%= MyBase.GetResourceString("C_Complexity") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "Exec usp_Whizible2_Sel_tbl_IB_Project_Complexity " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "Select 0,'Select Complexity'",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divRootCauseID">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblRootCauseID"><%= MyBase.GetResourceString("C_RootCauseID") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRootCauseID", "Exec usp_Whizible2_Sel_tbl_IB_Project_RootCause " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRootCauseID", "Select 0,'Select Rootcause'",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divModuleName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblModuleName"><%= MyBase.GetResourceString("C_ModuleName") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboModuleName", "Exec usp_Whizible2_Sel_tbl_PM_Module_ProjectGroup " & Convert.ToInt32(Session("intProjectID").ToString()) & ",NULL",,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboModuleName", "Select 0,'Select Module Name'",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divChangeRequestName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblChangeRequestName"><%= MyBase.GetResourceString("C_ChangeRequestName") %>	</label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestName", "Exec usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master  " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestName", "Select 0, 'Select Change Request '",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divAssignToName">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblAssignToName"><%= MyBase.GetResourceString("C_AssignToName") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboAssignToName", "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " & Convert.ToInt32(Session("intProjectID").ToString()) & ", NULL ,NULL, NULL, NULL ," & "'" & Session("LoginType") & "','New',0 ",,, "class='form-control'",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboAssignToName", "Select 0, 'Select Responsible Person' ",,, "class='form-control'",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divReportedInVersion">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblReportedInVersion"><%= MyBase.GetResourceString("C_ReportedInVersion") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboReportedInVersion", "Exec usp_Sel_tbl_IB_Project_Version  " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboReportedInVersion", "Select 0, 'Select Reported Version' ",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divCorrectedInVersion">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblCorrectedInVersion"><%= MyBase.GetResourceString("C_CorrectedInVersion") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboCorrectedInVersion", "Exec usp_Sel_tbl_IB_Project_Version " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                   <%-- <% CommonFunctions.HTMLControls.DrawComboBox("cboCorrectedInVersion", "Select 0, 'Select Corrected Version' ",,, "class='form-control ' ",,, ) %>--%>
                                                                     <% CommonFunctions.HTMLControls.DrawComboBox("cboCorrectedInVersion", "Select 0, 'Select Corrected Version' ",,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divPhase">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblPhase"><%= MyBase.GetResourceString("C_Phase") %>	</label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboPhase", "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup  " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboPhase", "Select 0, 'Select Phase'",,, "class='form-control' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPhase", "Select 0, 'Select Phase'",,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divFoundInPhase">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblFoundInPhase"><%= MyBase.GetResourceString("C_FoundInPhase") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboFoundInPhase", "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup  " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                  <%--  <% CommonFunctions.HTMLControls.DrawComboBox("cboFoundInPhase", "Select 0, 'Select Found In Phase'",,, "class='form-control ' ",,, ) %>--%>
                                                                      <% CommonFunctions.HTMLControls.DrawComboBox("cboFoundInPhase", "Select 0, 'Select Found In Phase'",,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divFixedInPhase">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblFixedInPhase"><%= MyBase.GetResourceString("C_FixedInPhase") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboFixedInPhase", "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup  " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                      <%--  <% CommonFunctions.HTMLControls.DrawComboBox("cboFixedInPhase", "Select 0, 'Select Fixed In Phase'",,, "class='form-control' ",,, ) %>--%>
                                                                      <% CommonFunctions.HTMLControls.DrawComboBox("cboFixedInPhase", "Select 0, 'Select Fixed In Phase'",,, "class='form-control' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divImportID">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblImportID"><%= MyBase.GetResourceString("C_ImportID") %></label>
                                                                    <div class="form-group">
                                                                        <%--Commented And Added By Usha Pandit On 04.06.2020 for restricting alphabates for Import ID--%>
                                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtImportID", "txtImportID", "form-control", 50, 25,,,, ,,,,,,, True,,,, True) %>--%>
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtImportID", "txtImportID", "form-control", 50, 25,,,, ,,,, "onkeypress='return restrictAlphabets(event)' autocomplete='off'",,, True,,,, True) %>
                                                                        <%--End Of Added By Usha Pandit On 04.06.2020 for restricting alphabates for Import ID--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="divCustomerIssueID1">
                                                                <div class="form-group">
                                                                   <%-- // Added & Commented By Dipali V On 16th April 2020 For Caption as per layout--%>
                                                                   <%-- <label class="control-label" id="lblCustomerIssueID1"><%= MyBase.GetResourceString("C_CustomerIssueID1") %></label>--%>
                                                                    <label class="control-label" id="lblCustomerIssueID1">Duplicate Issue ID</label>
                                                                    <%--// End of Added & Commented By Dipali V On 16th April 2020 For Caption as per layout--%>
                                                                    <%--Commented And Added By Usha Pandit On 04.06.2020 For restricting alphabates for Duplicate Issue ID--%>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomerIssueID1", "txtCustomerIssueID1", "form-control", 50, 200,,,, ,,,,,,, True,,,, True) %>--%>
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
                                               <% CommonFunctions.HTMLControls.DrawCheckBox("chkShowToCustomer", "chkShowToCustomer",, True) %>
                                            </center>
                                                                </div>
                                                            </div>
                                                            <div id="divHardware">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblHardware"><%= MyBase.GetResourceString("C_Hardware") %>	</label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboHardware", "Exec usp_Whizible2_Sel_tbl_PM_ProjectHardware " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboHardware", "Select 0, 'Select Hardware'",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                            <div id="divOS">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblOS"><%= MyBase.GetResourceString("C_OS") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboOS", "Exec usp_Whizible2_Sel_tbl_IB_Project_OS " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control ' ",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboOS", "Select 0, 'Select OS'",,, "class='form-control ' ",,, ) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div id="divKernel">
                                                                <div class="form-group">
                                                                    <label class="control-label" id="lblKernel"><%= MyBase.GetResourceString("C_Kernel") %></label>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboKernel", "Exec usp_Whizible2_Sel_tbl_IB_Project_Kernels " & Convert.ToInt32(Session("intProjectID").ToString()),,, "class='form-control'",,, ) %>--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboKernel", "Select 0, 'Select Kernel'",,, "class='form-control'",,, ) %>
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
                                            <hr />

                                            <div class="box-body">
                                                <div class="boxformheading"><strong><%= MyBase.GetResourceString("C_Custom_Field") %></strong></div>
                                                 <%--Added by imran on 03-03-2022 --%>
                                                <%--<div style="color:black;margin-bottom:15px;" ><strong> Note:Default value for custom fields will be shown after saving the issue. </strong> </div>--%>
                                                <div style="color:black;margin-bottom:15px;" ><strong> Note:Dynamic default value for custom fields will be shown after saving the issue. </strong> </div>
                                                <%--Comment End by imran on 03-03-2022 --%>
                                                <div class="" id="CustomFieldsControl">
                                                    <%-- Here the custom fields are binded by PloatCustomFields() function --%>
                                                </div>


                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">&nbsp;</div>
                                                    </div>
                                                </div>
                                            </div>

                                            <hr/>
			
                                            <hr />

                                            <div class="box-body">
                                                <div class="boxformheading"><strong><%= MyBase.GetResourceString("C_Extended_Custom_Fileds") %></strong></div>
                                                <div class="" id="ExtendedCustomFieldsControl">
                                                    
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="box-body" id="divCRMQueryID">
                                                <%--<%= MyBase.GetResourceString("C_Convewrted_from_Help_Desk_Request") %> <span><a href="#">HD4156</a></span></p>--%>
                                            </div>

                                        </div>
                                        <!-- /.box-body -->
                                    </div>
                                </div>
                                <div id="divControlPloatDuplicated" style="display:none"></div>
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
                
                <!-- Modal -->
                <div class="modal custmodal viewdetail largcustmodal fade" id="addnewdiscussion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" id="divModalcontent">
                            <div class="modal-header" id="Idheader" style="display:block">
                                <h5 class="modal-title" id="h5addnewdiscussion">Add New Discussion</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">

                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="form-group">
                                            <%--Added & commented By dipali v On 23rd Sep 2019 For Mandatory --%>
                                            <label class="control-label">Comment <span id="MandatorytxtareaID" style="color:red;">*</span></label>
                                    <%--      End of   Added & commented By dipali v On 23rd Sep 2019 For Mandatory --%>
                                            <%--<label class="control-label">Comment </label>--%>
                                            <%-- //Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength--%>
                                            <textarea class="form-control" style="min-height: 100px;" id="txtareaID" maxlength="4000" placeholder="Enter Comment (Maxlength 4000 Char)" onkeyup="FindMaxLength(this)"></textarea>
                                         <%--//Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength--%>
                                        </div>

                                        <div class="form-group">
                                            <div class="checkbox chekboxright" id="chkDiscussionShowToCustomer">
                                                <label>
                                                    Is Show To Customer 
                                                </label>
                                                <%--<input type="checkbox">--%>
                                                <% CommonFunctions.HTMLControls.DrawCheckBox("chkDiscShowToCustomer", "chkDiscShowToCustomer", "clsLeft10Margin", False) %>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label" id="lblDiscusiionStatus"><%= MyBase.GetResourceString("C_Status") %> <span id="MandatoryDiscussionStatus" style="color:red;"> * </span></label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboDiscussionStatus", "Select 0,'Select Status' ",,, "class='form-control'",,, ) %>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            &nbsp;             
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">&nbsp;</div>
                                <div class="row">
                                    <div class="col-sm-6 col-md-6">
                                        <div class="attacment-file">
                                            <div class="form-group">
                                                <div id="FileControlUploadDiv">
                                                    <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none !important;' class='clsDiscFileControl'", False, True)%>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-btn">
                                                        <button class="btn borderbtn" id="btnSelectFile" filecount="0" onclick="SelectFile();" type="button" style="width: 130px!important; height: 33px!important" title="Add Attachments" data-bs-toggle="tooltip"><i class="fa fa-paperclip" aria-hidden="true"></i>Attachment</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-6 col-md-6 text-right">
                                        <button class="btn btnyellow" id="btnSubmit">Submit</button>
                                        <button class="btn borderbtnred ml-1" id="btnClear">Clear</button>
                                    </div>
                                </div>

                                <div id="divAttachments" class="bottom-bar" style="">
                                    <div class="row">
                                        <div class="col-sm-12 ">
                                            <table id="tblFiles" style="display: none;" class="clsGridTable table table-bordered">

                                                <thead class="clsTRColumnHeader" align="left">
                                                    <tr>
                                                        <th width="5%" style="text-align:center"></th>
                                                        <th width="49%" style="text-align:center">Files</th>
                                                        <th style="text-align:center">Comments</th>
                                                        <%--added by imran on 18-10-2022--%>
                                                        <th style="text-align:center">Document Type<span style="color:red;">*</span></th><%--//Added By Dipali V On 5th April 2023 For Focus to Control--%>         
                                                        <th style="text-align:center">Document Sub Type</th>
                                                        <%--End of comment by imran on 18-10-2022--%>
                                                        <th style="text-align:center">Remove</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <!--modalendhere-->
                
                <!-- Modal -->
                <div class="modal custmodal fade" id="assignissuetime" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Title</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Comming soon
                                <div class="row">
                                    <div class="col-sm-12 col-md-12 text-right">
                                        <button class="btn btnyellow">Submit</button>
                                        <button class="btn borderbtnred ml-1">Clear</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--modalendhere-->

                <div class="modal custmodal fade" id="isstrackingflag" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header" id="tblheader">
                                    <h5 class="modal-title" id="trackingflagLabel">Tracking Details</h5>
                                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
								 <div class="graybg pt-1 pb-1 headertopp">
                                    <ul class="headernavlist pull-right">
                                        <%If m_blnEditAccess = True Then%>
                                        <li id="clearflag"><a href="#" onclick="ClearTrackingFlag()">Clear Flag</a></li>
                                        <li><a href="#" onclick="SaveTrackingDetails()">Save</a></li>
                                        <%End If %>
                                        <%-- <li><a href="#">Close</a></li>--%>
                                        <%--<li><a href="#">?</a></li>--%>											
										</ul>
											
                                    <div class="clearfix"></div>
                                </div>
                                <div class="modal-body">
                                    <p><strong>Note : </strong>Flagging marks an item to remind you that it needs to be followed up. After it has been followed up, you can mark it complete.</p>
										<h4><strong>Issue ID :</strong><label id="lblIssueID"></label></h4>
										<p id="txtSummary"><strong>Issue :</strong> </p>
										<p>&nbsp;</p>
                                        <div class="form-panel">										
										    <div class="form-group">
										        <div class="row">                                                    
                                                    <label class="control-label col-sm-4 text-right">Flag To <span id="MandatoryFlagto" style="color:red;">*</span> :</label>
                                                    <div class="col-sm-6">
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboFlagTo", "usp_whizible2_FlagTo_ComboFill ",,, "class='form-control'", False,,) %>
											        <%-- <select class="form-control selectpicker">
                                                        <option>Review</option>
                                                        <option>Follow Up</option>                                                             
                                                    </select>--%>
											        </div>
                                                </div>
										    </div>
										    <div class="form-group">
                                                <div class="row">                                                    
                                                    <label class="control-label col-sm-4 text-right">Due Date <span id="MandatoryDuedate" style="color:red;"> * </span> :</label>
                                                    <div class="col-sm-6">													   
												        <div class="input-group">
                                                           <%-- Added & Coommented On 4th June 2020 For Issue Crash--%>
													        <%--<input id="trackingdate" type="text" autocomplete="off" class="form-control"/>--%>
                                                            <input id="trackingdate" type="text" autocomplete="off" class="form-control" readonly style="background-color:white"/>
                                                            <%-- End of Added & Coommented On 4th June 2020 For Issue Crash--%>
                                                            <input id="hdnUniqueID" type="hidden" />
													        <span class="input-group-btn">
													            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
													        </span>
													    </div>
													</div>
                                                </div>
										    </div>
										    <div class="form-group">
										        <div class="row">                                                    
                                                    <label class="control-label col-sm-4 text-right">Complete :</label>
                                                        <div class="col-sm-6">
													       <div class="custom_chckbox">
                                                                <input type="checkbox" id="flagcomplete1" />
                                                                <label for="flagcomplete1"></label>
                                                            </div>
                                                        </div>
                                                </div>
										    </div>			
										</div>
                                        <div class="clearfix"></div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                </div>

                <div class="clearfix"></div>
            </section>
        </div>
        <%--  </section>--%>
        <!-- /.content -->
		<%-- Commented by imran 27-10-2021--%>
        <%--</div>--%>
	   <%-- End Comment--%>
    <!-- /.content-wrapper -->

    <%--</div>--%>

    <!-- ./wrapper -->

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <%--//Added By Chetan Muley On 15 Aug 2020 For setting focus in IE browser--%>
    <script src="../../General/CommonFunctions.js"></script>
    <%--//End Of Added By Chetan Muley On 15 Aug 2020 For setting focus in IE browser--%>
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jQuery-2.1.4.min.js"></script>--%> 

         <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->

<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../General/CommonValidations.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/FileSaver.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jszip.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jszip-utils.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?v=1"></script>--%>
    
    <script type="text/javascript"> 

        //Added by pradip on 6-4-2023 for tooltip issue
        $("[data-bs-toggle='popover'],[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip();
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='popover'],[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']"));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                trigger: 'hover'
            });
        });

        $('body').on('click', function () {
            $("[data-bs-toggle='popover'],[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip();
        });
            //End Added by pradip on 6-4-2023


        var FileCount_toDisable = 0;
        var SelectedCurrentdate = "";
        var IsFromWherePreNext = 0;
        //var FileCount_toDisableNew = 0;
        //Commented by imran on 29-10-2021 because of 3 times call $(document).ready(function ()
        //$(document).ready(function () {
        //     //resizeSection(this);
        //    //alert('<%= Request.QueryString("intPageNo")%>');
        //     <%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
		//
        //    //commented by imran 27-10-2021
        //    //$("#divIsseDetails").removeClass("center");
        //    //$("#divIsseDetails").removeClass("preloader");
        //    //$("#maindiv").removeClass('clsShowHide');
        //    //End Comment by imran 27-10-2021
        //     <%--  /*End of Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
        //    //Added by Chetan M on 16 Feb 2021 for Attachment icon click Attachment details get displayed.
        //    var tab = <%= Request.QueryString("tab")%>;
        //    if (tab != undefined && tab != null) { //Addded By Usha Pandit On 06.05.2021 For javascript error
        //        if (tab.id == 'tab_3') {
        //            $("#AttachmentsID").trigger("click");
        //        }
        //        //Added by Chetan M on 26 May 2021 for open History tab on click of History Icon
        //        if (tab.id == 'tab_2') {
        //            $("#ViewHistoryID").trigger("click");
        //        }
        //        //End of Added by Chetan M on 26 May 2021 for open History tab on click of History Icon
        //    }
        //    //End of Added by Chetan M on 16 Feb 2021 for Attachment icon click Attachment details get displayed.
        //
        //      Date.prototype.toShortFormat = function () {
        //
        //        var month_names = ["Jan", "Feb", "Mar",
        //            "Apr", "May", "Jun",
        //            "Jul", "Aug", "Sep",
        //            "Oct", "Nov", "Dec"];
        //
        //        var day = this.getDate();
        //        var month_index = this.getMonth();
        //        var year = this.getFullYear();
        //
        //        return "" + day + " " + month_names[month_index] + " " + year;
        //    }
        //    SelectedCurrentdate = new Date();
        //    //StartLoader("#bodyIssueDetails");
        //    //$(".toggle-sidebar").click(function () {
        //
        //    $(".toggle-sidebar").on("click", function () {
        //        //alert();   
        //        $(this).toggleClass('topen');
        //        $("#sidebarpanel").toggleClass("collapsed");
        //        $("#contentfull").toggleClass("col-md-12 col-md-6");
        //
        //        //return false;
        //        if ($(this).hasClass('topen')) {
        //            $('.msgboxmsg').css('maxWidth', 930);
        //        }
        //        else {
        //            $('.msgboxmsg').css('maxWidth', 375);
        //        }
        //    });
        //    if (window.location.hash != "") {
        //        $('a[href="' + window.location.hash + '"]').click()
        //    }
        //});
        //End Comment by imran 29-10-2021

        var FlagDateStatus, ProjectID, LoginType, UserId, ProductVersionIDs, CustomerID, LoginID, Cust_Combo, ComponentID, SubTypeDetails, Typeproject, Status, Priority, Severity, Complexity, ReportedBy, RootCauseID, ReleaseID, IterationID, UserStoryID, DeliverableID, ModuleName, ResponsiblePersonName, ReportedInVersion, ChangeRequestName, Kernel, Phase, FixedInPhase, FoundInPhase, Hardware, OperatingSystem, CodedByName, ShowToCustomer, CorrectedInVersion, CRMQueryID;
        var globalStatus, globalStatusChangeDate, globalStatusChangeTime;
        //Added By Rehan C To check validation for Special characters  on 15th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var IssueID;
        var arrayColumn = [];
        var arrRow = [];
        var activerow = new Array();
        var commonProperty;
        var EmployeeId;
        var roleid;
        var UserName;
        var ExistingStatus = '';
        var CurrentDate;
        var CurrentTime;
        var counter = 0;
        var Summary;
        var Description;
        var ProjectReportedDate;
        var Duedate;

        var ExpectedStartDate;
        var ExpectedEndDate;
        var issueIdList;
        var arrIssueIdList = [];
        var viewApplied;
        var ValidationMessage = new Array();
        var ValidationValidateID = new Array();
        var ValidationValidateExtID = new Array();
        var ValidationMessageFieldName = new Array();
        var ValidationMessageFiled = new Array();
        var defaultTaskType;

        //Comment by imran 29-10-2021
        //$(document).ready(function () {
		//
        //    var HeaderCaption = $(parent.document.getElementById('mainHeadingTop'));
        //    HeaderCaption.text("");
        //    HeaderCaption.text("Issues > Issue Details");
        //    var accessright ="<%= m_blnEditAccess %>";
        //    if (accessright == "True") {
        //        $("#UpdateIssueDataID").show();
        //    } else {
		//
        //        $("#UpdateIssueDataID").hide();
        //    }
        //    IssueID = '<%=IssueID%>';
        //    viewApplied = '<%=ViewApplied%>';
        //    issueIdList = '<%=IssueIDList%>';
        //    issueIdList = issueIdList.slice(0, -1);
        //    arrIssueIdList = issueIdList.split('|');
        //    var index = arrIssueIdList.indexOf(IssueID);
        //    togglePrevNext(index);
        //    //$("#HeaderIssue").html("Issue ID : " + IssueID);
        //    ProjectID = '<%=ProjectID%>';
        //    alertify.set('notifier', 'position', 'top-right');
        //    //commented by imran 27-10-2021
        //    //StopAjaxLoader("#bodyIssueDetails");
        //    
        //    //Added By Dipali V On 18th Feb 2021 For Cross button nothing happened
        //     $(".toggle-sidebar").on("click", function () {
        //        //alert();   
        //        $(this).toggleClass('topen');
        //        $("#sidebarpanel").toggleClass("collapsed");
        //        $("#contentfull").toggleClass("col-md-12 col-md-6");
        //
        //        //return false;
        //        if ($(this).hasClass('topen')) {
        //            $('.msgboxmsg').css('maxWidth', 930);
        //        }
        //        else {
        //            $('.msgboxmsg').css('maxWidth', 375);
        //        }
        //    });
        //     //End of Added By Dipali V On 18th Feb 2021 For Cross button nothing happened
        //   
        //});
        //End Comment by imran 29-10-2021

        $(document).ready(function () {
           // debugger;
            //Added By Reshma Chavan on 9th march 2022
            <%--if (<%= Request.QueryString("FromAdd")%> == 1) {
                var result = '<%= Request.QueryString("IssueID")%>';
                alertify.success("Issue Added Successfully " + result);
            }--%>

            var FromwhereAssignIssue = '<%= Request.QueryString("FromWhere")%>'
            var FromAdd = '<%= Request.QueryString("FromAdd")%>';
            if (FromAdd == 1) {
                var result = '<%= Request.QueryString("IssueID")%>';
                alertify.success("Issue Added Successfully " + result);
            }

            $("#divControlPloatDuplicated").html($("#controlploat").clone());
             //End of Added By Reshma Chavan on 9th march 2022
            //Added by imran 28-10-2021
            StartLoader("#bodyIssueDetails");

            var tab = <%= Request.QueryString("tab")%>;
            if (tab != undefined && tab != null) {
                if (tab.id == 'tab_3') {
                    $("#AttachmentsID").trigger("click");
                }
                if (tab.id == 'tab_2') {
                    $("#ViewHistoryID").trigger("click");
                }
            }

            Date.prototype.toShortFormat = function () {
                var month_names = ["Jan", "Feb", "Mar",
                    "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep",
                    "Oct", "Nov", "Dec"];

                var day = this.getDate();
                var month_index = this.getMonth();
                var year = this.getFullYear();

                return "" + day + " " + month_names[month_index] + " " + year;
            }
            SelectedCurrentdate = new Date();

            //$(".toggle-sidebar").on("click", function () {
            //    $(this).toggleClass('topen');
            //    $("#sidebarpanel").toggleClass("collapsed");
            //    $("#contentfull").toggleClass("col-md-12 col-md-6");
            //    if ($(this).hasClass('topen')) {
            //        $('.msgboxmsg').css('maxWidth', 930);
            //    }
            //    else {
            //        $('.msgboxmsg').css('maxWidth', 375);
            //    }
            //});

            if (window.location.hash != "") {
                $('a[href="' + window.location.hash + '"]').click()
            }

            var HeaderCaption = $(parent.document.getElementById('mainHeadingTop'));
            HeaderCaption.text("");
            HeaderCaption.text("Issues > Issue Details");
            var accessright ="<%= m_blnEditAccess %>";
            if (accessright == "True") {
                $("#UpdateIssueDataID").show();
            } else {

                $("#UpdateIssueDataID").hide();
            }
            IssueID = '<%=IssueID%>';
            viewApplied = '<%=ViewApplied%>';
            issueIdList = '<%=IssueIDList%>';
            issueIdList = issueIdList.slice(0, -1);
            arrIssueIdList = issueIdList.split('|');
            var index = arrIssueIdList.indexOf(IssueID);
            togglePrevNext(index);
            //$("#HeaderIssue").html("Issue ID : " + IssueID);
            ProjectID = '<%=ProjectID%>';
            alertify.set('notifier', 'position', 'top-right');
            //End commment by imran 28-10-2021

            //Added By Dipali V On 18th Feb 2021 For Cross button nothing happened
            $(".toggle-sidebar").on("click", function () {
                $(this).toggleClass('topen');
                $("#sidebarpanel").toggleClass("collapsed");
                $("#contentfull").toggleClass("col-md-12 col-md-6");

                if ($(this).hasClass('topen')) {
                    $('.msgboxmsg').css('maxWidth', 930);
                }
                else {
                    $('.msgboxmsg').css('maxWidth', 375);
                }
            });
            //End of Added By Dipali V On 18th Feb 2021 For Cross button nothing happened 

            //Commented by imran 28-10-2021
            //StartLoader("#bodyIssueDetails");

            LoginType = '<%=Session("LoginType").ToString%>';
            LoginID = '<%=Session("intLoginID").ToString%>';
            UserId = "<%= Session("intUserID").ToString() %>";
            roleid = "<%= Session("intPostID").ToString() %>";
            EmployeeId = "<%= Session("intUserID").ToString() %>";
            UserName = "<%= Session("strUserName").ToString() %>";
            //alert('<%=ProjectName%>');
            //Commented & Added By Rutuja D. on 20 Dec 2021 For Project Name not displaying correctly
            //$("#selectedProjectName").text('<%=ProjectName%>');            
            //End of Commented & Added By Rutuja D. on 20 Dec 2021 For Project Name not displaying correctly

            commonProperty = { ProjectId: ProjectID, RoleId: roleid, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginID, IssueID: IssueID, strMode: 'New' };
            //debugger;
            CheckConvertToDeliverable();
            ShowIssueAssignmentLink();
            //Added By Dipali V On 5th Jan 2023 For If flag Assign Issue then Discussion link will enabled
            if (FromwhereAssignIssue == "AssignIssue") {
                $("#divDiscussion").css("display", "block");
                $("#addNewDiscussionID").css("display", "block");
                $("#DiscussionboxID").css("display", "block");
                $('#liAssignIssue').css("display", "none");
            } else {
                //$("#divDiscussion").css("display", "none");
                //$("#addNewDiscussionID").css("display", "none");
                //$("#DiscussionboxID").css("display", "none");
                 $('#liAssignIssue').css("display", "block");
            }
           //End of Added By Dipali V On 5th Jan 2023 For If flag Assign Issue then Discussion link will enabled

            GetComboValues();
            GetIssueDetails(IssueID);

            DefaultValue(ProjectID, null, "PageLoad");

            GetIssueSLADetails(IssueID);
            CheckDAFillOrnot(IssueID);//Added By Dipali V On 12th May 2020 For ISSUe ID 24234
            //Added By  Dipali V On 1st April 2021 if customer/client then Deliveriable & assign tab should not display
            if (LoginType == 'C') {
                $("#liConvertToDel").hide();
                $("#liAssignIssue").hide();
            }
            //End of Added By  Dipali V On 1st April 2021 if customer/client then Deliveriable & assign tab should not display
            StopAjaxLoader("#bodyIssueDetails");

            ////text area allowed only 1000 charcter validation
            var maxchars = 1000;
            var remain;
            $('textarea').keyup(function () {

                var name = $(this).attr('name');

                if (name == 'dtaDescription') {

                    if (remain != 0) {
                        var tlength = $(this).val().length;
                        $(this).val($(this).val().substring(0, maxchars));
                        var tlength = $(this).val().length;
                        remain = maxchars - parseInt(tlength);
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Maximum Charter length 1000.", 'error', 25);
                        var tlength = $(this).val().length;
                        $(this).val($(this).val().substring(0, maxchars));
                        var tlength = $(this).val().length;
                        remain = maxchars - parseInt(tlength);
                    }
                }
            });



            //Added By Dipali V On 5th April 2023 For Value should not change
            $("#dtStatusChangeTime").prop("cursor", "no-drop!important");
            $("#dtStatusChangeDate").prop("cursor", "no-dropimportant");
            //End of Added By Dipali V On 5th April 2023 For Value should not change

          
        });

        $("#AttachmentsID").click(function () {
            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-toggle="tooltip"], [title]:not([data-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-toggle="tooltip"], [title]:not([data-toggle="popover"])', function () {
                $('[data-toggle="tooltip"], [title]:not([data-toggle="popover"])').tooltip('destroy');
            });
            //End of Added By Dipali V On 16th April 2020 For hide tooltip



            $("#tab_4").hide();
            if (IssueID == undefined || IssueID == "") {
                IssueID = '<%=IssueID%>';
            }
            GetAttachmentDetails(IssueID);
        });

        $("#btnTrashButtonID").click(function () {
            //
            var arrayId = [];
            $("input:checkbox[class=chcktbl]:checked").each(function () {
                var ID = $(this).attr("id");
                arrayId.push(ID);
            });
            //$('#tbodyAttachment input[type="checkbox"]').each(function () {
            //    if ($(this).prop("checked") == true) {
            //        var ID = $(this).attr("id");
            //        arrayId.push(ID);
            //    }
            //});

            if (arrayId.length == 0) {
                alertify.error('Please select at least one Record to delete.', 'alert-danger');
                return false;
            }
            else {
                //Commented & Added By Dipali V on 4th April 2023 For Delete Confirmation Issue 
                //$("#btnTrashButtonID").attr('data-toggle', 'modal');
                //$("#btnTrashButtonID").attr('data-bs-target', '#deleteinfomodal');
                $("#deleteinfomodal").modal('show');
                 //End of Commented & Added By Dipali V on 4th April 2023 For Delete Confirmation Issue
            }
        });
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

        //Function for delete the attachments.
        function DeleteAttachments() {
            var arrayId = [];
            $("input:checkbox[class=chcktbl]:checked").each(function () {
                var ID = $(this).attr("id");
                arrayId.push(ID);
            });

            var AttachID = arrayId.toString();
            StartLoader("#bodyIssueDetails");
            //DeleteAttachment(arrayId);
            DeleteAttachment(AttachID);
            GetAttachmentDetails(IssueID);
            //addd by dipali V on 9th sep for unselect checkbox
            $("#Attachments1").prop("checked", false);
            //End of addd by dipali V on 9th sep for unselect checkbox
            StopAjaxLoader("#bodyIssueDetails");
        }


        function GetComboValues() {
            //Added & commented by dipali On 23rd Sep 2019 for Module Name Saving & binding issue
            //var comboNameList = "CodedByName,ReportedBy,Release,Severity,Complexity,Kernel,DeliverableID,Iteration,UserStory,Priority,RootCauseID,ChangeRequestName,ReportedInVersion,CorrectedInVersion,Phase,FoundInPhase,FixedInPhase,Hardware,OS";//Type,SubType,Status,AssignToName,ModuleName,
            var comboNameList = "CodedByName,ReportedBy,Release,Severity,Complexity,Kernel,DeliverableID,Iteration,UserStory,Priority,RootCauseID,ChangeRequestName,ReportedInVersion,CorrectedInVersion,Phase,FoundInPhase,FixedInPhase,Hardware,OS,ModuleName";//Type,SubType,Status,AssignToName,ModuleName,
            //End of Added & commented by dipali On 23rd Sep 2019 for Module Name Saving & binding issue

            //var issueComboParameters = { commonProperty: commonProperty, ComboNameList: comboNameList };
            var issueComboParameters =
            {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueId,
                RoleId: commonProperty.RoleId,
                ComboNameList: comboNameList
            };
            var param = JSON.stringify(issueComboParameters);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetAllComboValues", param, false);
            if (result != undefined && result != null) {
                for (var m = 0; m < result.length; m++) {
                    var cbo = result[m].ComboName;
                    var cbovalues = result[m].lstComboValues;
                    var ctrl = 'cbo' + cbo;
                    var objCbo1 = document.getElementById(ctrl);
                    $("#" + ctrl + " option").remove();
                    for (var i = 0; i < cbovalues.length; i++) {
                        var Objresult = cbovalues[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.FieldName;
                        objOption.value = Objresult.FieldID;
                    }
                    AppendOptioncbo(cbo, "");
                }
            }
        }

        function BindComboValues() {
            //debugger;
            //AssignComboValue("Type", Typeproject);
            //AssignComboValue("SubType", SubTypeDetails);
            //AssignComboValue("Status", Status);
            //debugger;
            //If condition added by imran 28-10-2021
            //debugger;
            if (CodedByName !== null && CodedByName !== '' && CodedByName !== ' ' && CodedByName !== 0) {
                AssignComboValue("CodedByName", CodedByName);
            } else {
                $("#cboCodedByName").val("")
                $("#cboCodedByName").val("0")
            }


            //AssignComboValue("Product", Product);
            if (ReportedBy !== null && ReportedBy !== "" && ReportedBy !== " " && ReportedBy !== 0) {
                AssignComboValue("ReportedBy", ReportedBy);
            }
            else {
                $("#cboReportedBy").val("")
                $("#cboReportedBy").val("0")
            }


            //AssignComboValue("AssignToName", ResponsiblePersonName);
            if (ReleaseID !== null && ReleaseID !== "" && ReleaseID !== " " && ReleaseID !== 0 && ReleaseID != undefined) {
                AssignComboValue("Release", ReleaseID);
            }
            else {
                $("#cboRelease").val("")
                $("#cboRelease").val("0")
            }

            if (Severity !== null && Severity !== "" && Severity !== " " && Severity !== 0) {
                AssignComboValue("Severity", Severity);
              
            } else {
                $("#cboSeverity").val("")
                $("#cboSeverity").val("0")
            }

            if (Complexity !== null && Complexity !== "" && Complexity !== " " && Complexity !== 0) {
                AssignComboValue("Complexity", Complexity);
               
            } else {
                $("#cboComplexity").val("")
                $("#cboComplexity").val("0")
            }



            if (Kernel !== null && Kernel !== "" && Kernel !== " " && Kernel !== 0) {
                AssignComboValue("Kernel", Kernel);
            } else {
                $("#cboKernel").val("")
                $("#cboKernel").val("0")
            }


            if (DeliverableID !== null && DeliverableID !== "" && DeliverableID !== " " && DeliverableID !== 0) {
                AssignComboValue("DeliverableID", DeliverableID);
            } else {
                $("#cboDeliverableID").val("")
                $("#cboDeliverableID").val("0")
            }


            if (IterationID !== null && IterationID !== "" && IterationID !== " " && IterationID !== 0) {
                AssignComboValue("Iteration", IterationID);
            } else {
                $("#cboIteration").val("")
                $("#cboIteration").val("0")
            }
            if (UserStoryID !== null && UserStoryID !== "" && UserStoryID !== " " && UserStoryID !== 0) {
                AssignComboValue("UserStory", UserStoryID);
            } else {
                $("#cboUserStory").val("")
                $("#cboUserStory").val("0")
            }
            if (Priority !== null && Priority !== "" && Priority !== " " && Priority !== 0) {
                AssignComboValue("Priority", Priority);
            } else {
                $("#cboPriority").val("")
                $("#cboPriority").val("0")
            }
            //debugger;
            if (RootCauseID !== null && RootCauseID !== "" && RootCauseID !== " " && RootCauseID !== 0) {
                AssignComboValue("RootCauseID", RootCauseID);
            } else {
                $("#cboRootCauseID").val("")
                $("#cboRootCauseID").val("0")
            }

            if (ModuleName !== null && ModuleName !== "" && ModuleName !== " " && ModuleName !== 0) {
                AssignComboValue("ModuleName", ModuleName);
            } else {
                $("#cboModuleName").val("")
                $("#cboModuleName").val("0")
            }
            if (ChangeRequestName !== null && ChangeRequestName !== "" && ChangeRequestName !== " " && ChangeRequestName !== 0) {
                AssignComboValue("ChangeRequestName", ChangeRequestName);
            } else {
                $("#cboChangeRequestName").val("")
                $("#cboChangeRequestName").val("0")
            }

            if (ReportedInVersion !== null && ReportedInVersion !== "" && ReportedInVersion !== " " && ReportedInVersion !== 0) {
                AssignComboValue("ReportedInVersion", ReportedInVersion);
            } else {
                $("#cboReportedInVersion").val("")
                $("#cboReportedInVersion").val("0")
            }

            if (CorrectedInVersion !== null && CorrectedInVersion !== "" && CorrectedInVersion !== " " && CorrectedInVersion !== 0) {
                AssignComboValue("CorrectedInVersion", CorrectedInVersion);
            } else {
                $("#cboCorrectedInVersion").val("")
                $("#cboCorrectedInVersion").val("0")
            }


            if (Phase !== null && Phase !== "" && Phase !== " " && Phase !== 0) {
                AssignComboValue("Phase", Phase);
            } else {
                $("#cboPhase").val("")
                $("#cboPhase").val("0")
            }


            if (FoundInPhase !== null && FoundInPhase !== "" && FoundInPhase !== 0) {
                AssignComboValue("FoundInPhase", FoundInPhase);
            } else {
                $("#cboFoundInPhase").val("")
                $("#cboFoundInPhase").val("0")
            }


            if (FixedInPhase !== null && FixedInPhase !== "" && FixedInPhase !== " " && FixedInPhase !== 0) {
                AssignComboValue("FixedInPhase", FixedInPhase);
            } else {
                $("#cboFixedInPhase").val("")
                $("#cboFixedInPhase").val("0")
            }


            if (Hardware !== null && Hardware !== "" && Hardware !== " " && Hardware !== 0) {
                AssignComboValue("Hardware", Hardware);
            } else {
                $("#cboHardware").val("")
                $("#cboHardware").val("0")
            }


            if (OperatingSystem !== null && OperatingSystem !== "" && OperatingSystem !== " " && OperatingSystem !== 0) {
                AssignComboValue("OS", OperatingSystem);
            } else {
                $("#cboOS").val("")
                $("#cboOS option:selected").val("0")
            }
            //End Comment by imran 29-10-2021
        }

        var SelectedReportedTime = "";
         var selectedIssuesDetails = "";
        function GetIssueDetails(issueid) {

            $("#HeaderIssue").html("Issue ID : " + issueid);
            var IssueDetailsPass = {
                intIssueidID: issueid,
                EmployeeID: EmployeeId
            }

            $.ajax({

                url: encodeURI(strUrl + '/api/IB_IssueDetails/GetIssueDetails'),
                type: "POST",
                data: JSON.stringify(IssueDetailsPass),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (IssueDetailsPass) {
                        xhr.setRequestHeader("Params", encryptString(isJson(IssueDetailsPass) ? param : JSON.stringify(IssueDetailsPass)));
                    }
                },
                success: function (response) {

                    var strHTML = "";
                    var ProjectName = "";
                    if (response.GetIssueDetailsData != '') {
                        selectedIssuesDetails = response.GetIssueDetailsData;
                        for (var i = 0; i < response.GetIssueDetailsData.length; i++) {
                            var ObjIssueDetails = response.GetIssueDetailsData[i];
                            ProjectID = ObjIssueDetails.ProjectID;
                            Summary = ObjIssueDetails.Summary;
                            Description = ObjIssueDetails.Description;
                            ReportedBy = ObjIssueDetails.ReportedBy;
                            var ReportedDate = ObjIssueDetails.ReportedDate;
                            Duedate = ObjIssueDetails.Duedate;
                            var ReportedTime = ObjIssueDetails.ReportedTime;
                            var StatusChangeDate = ObjIssueDetails.StatusChangeDate;
                            var StatusChangeTime = ObjIssueDetails.StatusChangeTime;
                            var ImportID = ObjIssueDetails.ImportID;
                            //  var CustomerIssueID = ObjIssueDetails.CustomerIssueID;
                            var CustomerIssueID = ObjIssueDetails.CustomerIssueID
                            DeliverableID = ObjIssueDetails.DeliverableID;
                            Priority = ObjIssueDetails.Priority;
                            Severity = ObjIssueDetails.Severity;
                            Complexity = ObjIssueDetails.Complexity;
                            Typeproject = ObjIssueDetails.Type;
                            SubTypeDetails = ObjIssueDetails.SubType;
                            Status = ObjIssueDetails.Status;
                            ExistingStatus = ObjIssueDetails.Status;
                            RootCauseID = ObjIssueDetails.RootCauseID;
                            ReleaseID = ObjIssueDetails.ReleaseID;
                            IterationID = ObjIssueDetails.IterationID;
                            UserStoryID = ObjIssueDetails.UserStoryID;
                            //DeliverableID = ObjIssueDetails.DeliverableID;
                            ModuleName = ObjIssueDetails.ModuleName;
                            ResponsiblePersonName = ObjIssueDetails.AssignTo;
                            CodedByName = ObjIssueDetails.CodedBy;
                            ReportedInVersion = ObjIssueDetails.ReportedInVersion;
                            Kernel = ObjIssueDetails.Kernel;
                            Phase = ObjIssueDetails.Phase;
                            FixedInPhase = ObjIssueDetails.FixedInPhase;
                            CorrectedInVersion = ObjIssueDetails.CorrectedInVersion;
                            FoundInPhase = ObjIssueDetails.FoundInPhase;
                            Hardware = ObjIssueDetails.Hardware;
                            OperatingSystem = ObjIssueDetails.OS;
                            ShowToCustomer = ObjIssueDetails.ShowToCustomer;
                            ChangeRequestName = ObjIssueDetails.ChangeRequestID
                            ProductVersionIDs = ObjIssueDetails.ProductVersionID;
                            CustomerID = ObjIssueDetails.CustomerID;
                            ComponentID = ObjIssueDetails.ComponentID;
                            CRMQueryID = ObjIssueDetails.CRMQueryID;
                            FlagDateStatus = ObjIssueDetails.Flag;
                            //Added By Rutuja D. on 10 Feb 2022
                            ProjectName = ObjIssueDetails.ProjectName;
                            //End of Added By Rutuja D. on 10 Feb 2022
                        }
                        //Added By Rutuja D. on 10 Feb 2022
                        $("#selectedProjectName").text(ProjectName);
                        //End of Added By Rutuja D. on 10 Feb 2022
                        //Commented And Added By Reshma Chavan on 23rd Dec 2021 for not showing sprint in edit mode
                         //Added By Dipali V On 8th April 2023 For Data Bind Issue
                        var ReleaseID = ReleaseID.replace(" ", 0);
                        GetIterationsByRelease(ReleaseID);
                        GetUserStoriesByIteration(IterationID.trim());
                         //End of Added By Dipali V On 8th April 2023 For Data Bind Issue
                        //Added By Dipali V On 27th March 2023 For Issue Discussion Issue
                        ShowDiscussionDetails(commonProperty);
                        //End of Added By Dipali V On 27th March 2023 For Issue Discussion Issue
                        //End of Commented And Added By Reshma Chavan on 23rd Dec 2021 for not showing sprint in edit mode
                        //Added by imran on 23-11-2021 to set value to combobox of Product Fields 
                        //debugger;
                        $("#cboCustomerID").val(CustomerID);
                        //ListOfProduct("ProductVersions", CustomerID, commonProperty);
                        //$('#cboModule').empty();
                        //$("#cboProduct").val(ProductVersionIDs);
                        // ListOfComponet1(flag, CustomerID, commonProperty, ProductVersionIDs);
                        Customerclick(CustomerID);
                        $("#cboProduct").val(ProductVersionIDs);
                        ProductClick(ProductVersionIDs);
                        $("#cboModule").val(ComponentID);
                        //Added by imran on 23-11-2021 to set value to combobox of Product Fields

                        //StopAjaxLoader("#bodyIssueDetails");//need to place at appropriate place
                        //alert(OperatingSystem);
                        //alert(Status);
                        //
                        ProjectReportedDate = ReportedDate;
                        SelectedReportedTime = ReportedTime;
                        var ReportedTm = TimeConvTo12(ReportedTime);


                        strHTML += "<span id='txtIssueDescription'>"
                        strHTML += Description
                        strHTML += "</span > <br />"
                        strHTML += " <span class='badge bg-aqua'><%= MyBase.GetResourceString("C_Reported_By") %>:"
                        strHTML += ReportedBy
                        strHTML += "</span > Reported On "
                        strHTML += ProjectReportedDate + ' '
                        //Added By Dipali V On 22nd Nov 2021 For Reported time 12 to 24 hours
                        strHTML += convertTime12to24(ReportedTm);
                        //End of Added By Dipali V On 22nd Nov 2021 For Reported time 12 to 24 hours
                        strHTML += "<span class='badge btnyellow  ml-1 btnsmall'>"
                        strHTML += Priority
                        strHTML += "</span>"
                        if (LoginType == 'C') {
                            $("#IssueDescription").html(strHTML);
                        }

                        if (LoginType == 'E') {
                            if (FlagDateStatus == 'G') {
                                //strHTML += "<span class='ml-1'><a href='#' data-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='fas fa-flag flagfillGreen'></i></a></span>"
                                strHTML += "<span class='ml-1'><a id='flagto' href='#' data-bs-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='fas fa-flag flag-success'></i></a></span>"
                            }
                            else if (FlagDateStatus == 'L') {
                                //strHTML += "<span class='ml-1'><a href='#' data-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='fas fa-flag flagfillRed'></i></a></span>"
                                strHTML += "<span class='ml-1'><a id='flagto' href='#' data-bs-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='far fa-flag flagred'></i></a></span>"
                            }
                            else if (FlagDateStatus == 'S') {
                                //strHTML += "<span class='ml-1'><a href='#' data-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='fas fa-flag flagfillyellow'></i></a></span>"
                                strHTML += "<span class='ml-1'><a id='flagto' href='#' data-bs-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='far fa-flag flagorange'></i></a></span>"
                            }
                            else if (FlagDateStatus == 'B') {
                                //strHTML += "<span class='ml-1'><a href='#' data-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='fas fa-flag flagfillBlack'></i></a></span>"
                                strHTML += "<span class='ml-1'><a id='flagto' href='#' data-bs-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='fa fa-flag'></i></a></span>"
                            }
                            else {
                                //strHTML += "<span class='ml-1'><a href='#' data-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='fas fa-flag flagfillDefault{color:#cccccc;}'></i></a></span>"
                                strHTML += "<span class='ml-1'><a id='flagto' href='#' data-bs-toggle='tooltip' onclick=ShowTrackingDetails(" + issueid + ") data-placement='top' title='Flag to'><i class='far fa-flag'></i></a></span>"
                            }
                        }
                    }

                    $('#dtReportedDate').css('text-align', 'center');

                    $('#dtReportedTime').css('text-align', 'center');
                    //Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by
                    $('#dtReportedTime').css('background-color', 'white');
                    //end of Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by

                    $("#IssueDescription").html(strHTML);
                    $("#summary").html(Summary);
                    $("#textIssueDescription").val(Description);
                    $("#textsummary").val(Summary);
                    if ($("#textIssueDescription").is(":visible"))
                        $("#txtIssueDescription").hide();
                    $("#dtReportedDate").val(ProjectReportedDate);

                    // debugger;
                    //if (ReportedTm.indexOf("AM") != -1) {
                    //   // var ReportedTm1 = ReportedTm.replace("AM", "");
                    //}
                    //if (ReportedTm.indexOf("PM") != -1) {
                    //   // var ReportedTm1 = ReportedTm.replace("PM", "");
                    //}
                    //  $("#dtReportedTime").val(ReportedTm1);
                    $('#dtReportedTime').css('text-align', 'center');
                    //Added By Dipali V On 22nd Nov 2021 For Reported time 12 to 24 hours
                    ReportedTm = convertTime12to24(ReportedTm);
                    $("#dtReportedTime").val(ReportedTm);
                    //End of Added By Dipali V On 22nd Nov 2021 For Reported time 12 to 24 hours

                    if (StatusChangeTime != "") {
                        //Commennted & Added By Dipali V On 5th Oct 2021 For Get Current Date & Time
                        // StatusChangeTime = TimeConvTo12(StatusChangeTime);
                        StatusChangeTime = TimeConvTo12(StatusChangeTime);
                        StatusChangeTime = convertTime12to24(StatusChangeTime);
                        //End of Commennted & Added By Dipali V On 5th Oct 2021 For Get Current Date & Time
                    }
                    $('#dtStatusChangeDate').css('text-align', 'center');
                    $('#dtStatusChangeTime').css('text-align', 'center');
                    //Added By dipali V on 3rd Sep 2019 To take old Status Date & time
                    globalStatusChangeDate = StatusChangeDate;
                    globalStatusChangeTime = StatusChangeTime;
                    //End of Added By dipali V on 3rd Sep 2019 To take old Status Date & time
                    $("#dtStatusChangeDate").val(StatusChangeDate);
                    $("#dtStatusChangeTime").val(StatusChangeTime);
                    //Added By Dipali V On 5th April 2023 For Value should not change
                    $("#dtStatusChangeTime").prop("cursor", "no-drop!important");
                    $("#dtStatusChangeDate").prop("cursor", "no-dropimportant");
                    //End of Added By Dipali V On 5th April 2023 For Value should not change
                    if (CRMQueryID != "") {
                        //Added by Swapnagandha k. on 24 Oct 2019 For Issue-Remove Onclick
                        // $("#divCRMQueryID").html("Converted from Help Desk Request : " + '<a href="#" onclick="Query_OnClick(' + CRMQueryID + ',true);">' + CRMQueryID + '</a>');
                        $("#divCRMQueryID").html("Converted from Help Desk Request : " + ' ' + CRMQueryID + '');
                        //End Added by Swapnagandha k. on 24 Oct 2019 For Issue-Remove Onclick
                    }
                    else {
                        $("#divCRMQueryID").hide();
                    }

                    getServerDateTime();

                    //To set the checkbox of show to customer false
                    if (ShowToCustomer == "False") {
                        $('.clsCheckBox').prop('checked', false);
                    }
                    else {
                        $('.clsCheckBox').prop('checked', true);
                    }
                    $("#txtImportID").val(ImportID);
                    //Added by dipali V On 25th Sep 2019 For Null Condition 
                    if (CustomerIssueID == "null") {
                        CustomerIssueID = "";

                    }
                    else {
                        CustomerIssueID = CustomerIssueID;
                    }
                    //Added by dipali V On 25th Sep 2019 For Null Condition 
                    $("#txtCustomerIssueID1").val(CustomerIssueID);
                    //This function gets the Types on the Type Dropdown 
                    GetTypes(commonProperty);

                    //This function gets the SubTypes on the SubType Dropdown 
                    GetSubType(ProjectID, Typeproject);

                    //This function gets the Status on the Status Dropdown 
                    GetStatus(ProjectID, Typeproject, roleid);

                    ////this funtion user for ploating Product field control 
                    ProductFiledFlag(commonProperty);

                    //This function returns the responsible person
                    ResponsiblePerson(ProjectID, Typeproject);
                    //BindComboValues();
                    //This function plots the controls which is enabled in configuration
                    //commonProperty = { ProjectId: ProjectID, RoleId: roleid, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginID, IssueID: IssueID, strMode: 'New', Type: Typeproject};
                    //GetControlPloatingProject(ProjectID, commonProperty);

                    //This function ploats the custom fields depends upon the projectId and type
                    $("#CustomFieldsControl").empty();
                    var isCustomField = getCustomFieldsMaxRowColCount(ProjectID);
                    if (isCustomField == true) {
                        PloatCustomFields(ProjectID, Typeproject, roleid, LoginType, UserId);
                    }
                     //Added By Dipali V On 17th Nov 2022 For Type Layout
                    commonProperty = { ProjectId: ProjectID, RoleId: roleid, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginID, IssueID: IssueID, strMode: 'New', Type: Typeproject };
                    if (IsFromWherePreNext == 0) {
                        GetControlPloatingProject(ProjectID, commonProperty);
                    }
                    if (Typeproject != "") {
                        //$("select#cboType option:contains(" + Typeproject + ")").attr('selected', 'selected');
                       // $("select#cboType option:selected").val(Typeproject);
                        $("select#cboType option[value='" + Typeproject +"']").remove();
                        $("select#cboType option:selected").text(Typeproject);
                        $("select#cboType option:selected").val(Typeproject);
                    }

                    if (SubTypeDetails != "") {
                        //$("select#cboType option:contains(" + Typeproject + ")").attr('selected', 'selected');
                        // $("select#cboType option:selected").val(Typeproject);
                        $("select#cboSubType option[value='" + SubTypeDetails + "']").remove();
                        $("select#cboSubType option:selected").text(SubTypeDetails);
                        $("select#cboSubType option:selected").val(SubTypeDetails);
                    }


                    BindComboValues();
                    //debugger;
                    //Added By Dipali V On 8th April 2023 For Data Bind Issue
                    if ($("#cboRelease option[value=" + parseInt(ReleaseID) + "  ]").length != 0) {
                        //$("#cboRelease").val(parseInt(ReleaseID) == null ? 0 : parseInt(ReleaseID));
                        $("select#cboRelease option[value=" + parseInt(ReleaseID)  + "  ]").attr("selected", "selected");
                    }
                     //End of Added By Dipali V On 8th April 2023 For Data Bind Issue
                    //debugger;
                    $("#cboCustomerID").val(CustomerID);
                    ListOfProduct(flag, CustomerID, commonProperty);
                    $('#cboModule').empty();
                    $("#cboProduct").val(ProductVersionIDs);
                    ListOfComponet1(flag, customerid, commonProperty, ProductVersionIDs);
                    $("#cboModule").val(ComponentID);
                    //return;
                    //debugger;
                    //End of Added By Dipali V On 17th Nov  2022 For Type Layout
                    //This function ploats the Extended Custom fields depends upon the ProjectID and type
                    $("#ExtendedCustomFieldsControl").empty();
                    var isExtCustomField = getExtendedCustomFieldsMaxRowColCount(ProjectID);
                    if (isExtCustomField == true) {
                        PloatExtendedCustomFields(ProjectID, Typeproject, roleid, LoginType, UserId);
                    }

                   /* ShowDiscussionDetails(commonProperty);*/

                    //Commented and added by imran 29-10-2021 if (isCustomField == true) { to check condition
                    //var strFieldNames = ["CustomerID", "ProductVersionID", "ComponentID", "CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo4", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5"];
                    //for (var i = 0; i < strFieldNames.length; i++) 
                    //{
                    //   var copyIssueIDs = { issueid: issueid, strFieldName: strFieldNames[i] };
                    //    GetFieldValueForIssue(copyIssueIDs, commonProperty);
                    //}
                    if (isCustomField == true) {
                        for (var i = 0; i < CustomFieldNames.length; i++) {
                            var copyIssueIDs = { issueid: issueid, strFieldName: CustomFieldNames[i] };
                            GetFieldValueForIssue(copyIssueIDs, commonProperty);
                        }
                    }
                    //var strextFieldNames = ["CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldText11", "CustomFieldText12", "CustomFieldText13", "CustomFieldText14", "CustomFieldText15", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo4", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "CustomFieldCombo11", "CustomFieldCombo12", "CustomFieldCombo13", "CustomFieldCombo14", "CustomFieldCombo15", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "CustomFieldTextArea4", "CustomFieldTextArea5", "CustomFieldTextArea6", "CustomFieldTextArea7", "CustomFieldTextArea8", "CustomFieldTextArea9", "CustomFieldTextArea10", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5", "CustomFieldDate6", "CustomFieldDate7", "CustomFieldDate8", "CustomFieldDate9", "CustomFieldDate10"];
                    //for (var i = 0; i < strextFieldNames.length; i++) 
                    //{
                    //    var CopyIssueIDs = { issueid: issueid, strFieldName: strextFieldNames[i] };
                    //    GetExtFieldValueForIssue(CopyIssueIDs);
                    //}
                    //debugger;
                    if (isExtCustomField == true) {
                        for (var i = 0; i < CustomFieldNamesExt.length; i++) {
                            var copyIssueIDs = { issueid: issueid, strFieldName: CustomFieldNamesExt[i] };
                            GetExtFieldValueForIssue(copyIssueIDs, commonProperty);
                        }
                    }
                    //End Comment by imran 29-10-2021

                    Alldiv = $("#controlploat").clone();
                    $("#controlploat").remove();

                    //For give the tooltip on the mouseover on the dropdown
                    $('select').mouseover(function () {
                        var CBOID = this.id;
                        var textvalue = $("#" + CBOID + " :selected").text();
                        $("#" + CBOID).attr('title', textvalue);
                        //$("#" + CBOID).attr("data-toggle", "tooltip");
                        //$("#" + CBOID).attr("data-placement", "bottom");
                        //$("#" + CBOID).attr("data-container", "body");
                        //$('[data-bs-toggle="tooltip"]').tooltip();
                    });
                },
                error: function (err) {
                    // alert("error");
                    console.log(err);
                    StopAjaxLoader("#bodyIssueDetails");
                }
            })
        }

        function showPrev() {
           // StartLoader("#bodyIssueDetails");
            var index = arrIssueIdList.indexOf(IssueID);
            togglePrevNext(index - 1);
            IssueID = arrIssueIdList[index - 1];
            commonProperty.IssueID = IssueID;
            //debugger;
            IsFromWherePreNext = 1;
            GetIssueDetails(IssueID);
            GetIssueSLADetails(IssueID);
            CheckDAFillOrnot(IssueID);//Added By Dipali V On 12th May 2020 For ISSUe ID 24234
            removeAssignIssueTable();
            //To Get Status Time & Date 
            Status_OnChange();
            if ($("#dtStatusChangeDate").val() == "") {
                $("#dtStatusChangeDate").val($("#dtReportedDate").val());
            }
            //End of To Get Status Time & Date
            refreshActiveTab();
            clearTooltip();
           // StopAjaxLoader("#bodyIssueDetails");
        }
      
        function showNext() {
            //debugger;
            IsFromWherePreNext = 1;
           // StartLoader("#bodyIssueDetails");
            $("#divControlPloatDuplicated").html($("#controlploat").clone());
            var index = arrIssueIdList.indexOf(IssueID);
            togglePrevNext(index + 1);
            IssueID = arrIssueIdList[index + 1];
            commonProperty.IssueID = IssueID;
            GetIssueDetails(IssueID);
            //Added By Dipali V On 3rd April 2023 For Get Next Issue data
            BindComboValues();
            //End of Added By Dipali V On 3rd April 2023 For Get Next Issue data
            GetIssueSLADetails(IssueID);
            CheckDAFillOrnot(IssueID);//Added By Dipali V On 12th May 2020 For ISSUe ID 24234
            removeAssignIssueTable();
            //To Get Status Time & Date 
            Status_OnChange();
            if ($("#dtStatusChangeDate").val() == "") {
                $("#dtStatusChangeDate").val($("#dtReportedDate").val());
            }
            //End of To Get Status Time & Date 
            refreshActiveTab();
            clearTooltip();
           // StopAjaxLoader("#bodyIssueDetails");
        }

        function removeAssignIssueTable() {
            $("table.assignissue_order_list >tbody >tr").each(function () {
                var id = this.id;
                $("#" + id).remove();
            });
            counter = 0;
            generateAssignIssueRow(counter);
        }

        function CheckConvertToDeliverable() {
            var param = JSON.stringify(commonProperty);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/CheckDeliverableNodeAccess", param, false);
            if (result != undefined) {
                if (result != true) {
                    $('#liConvertToDel').hide();
                }
                else {
                    $('#liConvertToDel').show();
                }
            }
        }

        function ShowIssueAssignmentLink() {
            var param = JSON.stringify(commonProperty);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/ShowIssueAssignmentLink", param, false);
            if (strResult != true) {
                $('#liAssignIssue').hide();
            }
            else {
                $('#liAssignIssue').show();
            }
        }

        function togglePrevNext(index) {
            $('#btnPrev').attr('disabled', false);
            $('#btnNext').attr('disabled', false);
            if (index == 0 || index == -1) {
                $('#btnPrev').attr('disabled', 'disabled');
            }

            if (arrIssueIdList == "") {
                arrIssueIdList.length = 0;
            }

            if (index == arrIssueIdList.length - 1) {
                $('#btnNext').attr('disabled', 'disabled');
            }
        }




        function refreshActiveTab() {
            var acttabid = $("#tabdetails li.active").find('a')[0].id;
            if (acttabid != "") {
                $("#" + acttabid).click();
            }
        }
        //Commented And Added By Usha Pandit On 20.03.2020 For extracting correct time
        function TimeConvTo12(time24) {
            //
            //debugger;
            var ts = time24;
            var H = ts.substr(0, ts.indexOf(':'));
            var h = (H % 12) || 12;
            //h = (h < 10) ? ("0" + h) : h;  // leading 0 at the left for 1 digit hours
            var ampm = H < 12 ? " AM" : " PM";
            ts = h + ts.substr(ts.indexOf(':'), 3) + ampm;
            return ts;
        }
        //function TimeConvTo12new(time24) {
        //    var ts = new Date(time24);
        //    var hours = ts.getHours();
        //    var minutes = ts.getMinutes();
        //    var newformat = hours >= 12 ? 'PM' : 'AM';
        //    // Find current hour in AM-PM Format 
        //    hours = hours % 12;
        //    // To display "0" as "12" 
        //    hours = hours ? hours : 12;
        //    minutes = minutes < 10 ? '0' + minutes : minutes;
        //    return hours + ':' + minutes + ' ' + newformat;
        //}
        //End Of Added By Usha Pandit On 20.03.2020 For extracting correct time

        //Added by Usha Pandit on 09.06.2020 for more than 24 hours per day validation check
        function DateDiff(start, end, interval, rounding) {

            var iOut = 0;

            // Create 2 error messages, 1 for each argument.</KBD> 

            var bufferA = Date.parse(start);
            var bufferB = Date.parse(end);

            //// check that the start parameter is a valid Date. </KBD>           

            var number = bufferB - bufferA;
            // what kind of add to do?</KBD> 
            switch (interval.charAt(0)) {
                case 'd': case 'D':
                    iOut = parseInt(number / 86400000);
                    if (rounding) iOut += parseInt((number % 86400000) / 43200001);
                    break;
                case 'h': case 'H':
                    iOut = parseInt(number / 3600000);
                    if (rounding) iOut += parseInt((number % 3600000) / 1800001);
                    break;
                case 'm': case 'M':
                    iOut = parseInt(number / 60000);
                    if (rounding) iOut += parseInt((number % 60000) / 30001);
                    break;
                case 's': case 'S':
                    iOut = parseInt(number / 1000);
                    if (rounding) iOut += parseInt((number % 1000) / 501);
                    break;
                default:
                    return null;
            }
            return iOut;
        }
        //End of Added by Usha Pandit on 09.06.2019 for more than 24 hours per day validation check

        //Commented And Added By Usha Pandit On 16.03.2020 for work hours validation
        function ValidateWorkHourFormat(PlanID) {
            var checkFlag = true;
            try {
                var blnHMFormat = true;

                var objHMEffort = document.getElementById("AssignIssueWorkHours" + PlanID);
                //Added By Usha Pandit For 24 hours validation as per duration
                var objHMStartDate = document.getElementById("dtAssignIssueStartDate" + PlanID);
                var objHMEndDate = document.getElementById("dtAssignIssueEndDate" + PlanID);
                //End Of Added By Usha Pandit For 24 hours validation as per duration

                var objVal = objHMEffort.value;
                var objnewVal = objHMEffort.value;

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                var isdigit = isNumeric(objHMEffort.value);
                objHMEffort.value = objVal;

                if (isdigit == false) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please Enter only positive numeric value For Work(Hrs) in H:M format.', 'error', 5);
                    checkFlag = false;
                    return checkFlag;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    objHMEffort.value = objnewVal + ':00';
                    objnewVal = objHMEffort.value;
                }

                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                //Added By Dipali V On 17th April 2020 For Validation if Eneter HRS more than 24 
                //if (objHMEffort.value > '24.00')
                //{
                if (parseFloat(objHMEffort.value) > 24) {
                    //Commented And Added By Usha Pandit For 24 hours validation as per duration
                    //alertify.set('notifier', 'position', 'top-right');
                    //alertify.notify('Work(Hrs) should not be greater than 24 hours', 'error', 5);
                    //objHMEffort.value = objVal;
                    //checkFlag = false;
                    //return checkFlag;

                    var dblTotalDuration = DateDiff(objHMStartDate.value, objHMEndDate.value, "d") + 1;
                    var dblAvgHoursPerDay = (objHMEffort.value) / dblTotalDuration;

                    if (dblAvgHoursPerDay > 24) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Work (Hrs) should not be greater than 24 hours', 'error', 5);
                        objHMEffort.value = objVal;
                        checkFlag = false;
                        return checkFlag;
                    }
                    //End Of Added By Usha Pandit For 24 hours validation as per duration
                }
                //End of Added By Dipali V On 17th April 2020 For Validation if Eneter HRS more than 24 
                var tempEffort = objHMEffort.value.replace('-', '');
                if (checkSpecialCharacter(tempEffort) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters', 'error', 5);

                    objHMEffort.value = objVal;
                    checkFlag = false;
                    return checkFlag;
                }

                if (blnHMFormat == true) {
                    if (RestrictNonNumeric(objHMEffort) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please enter Work(Hrs) in H:M format.', 'error', 5);

                        objHMEffort.value = objVal;
                        blnHMFormat = false;
                        checkFlag = false;
                        return checkFlag;
                    }
                }

                objHMEffort.value = objHMEffort.value.replace('.', ':');

                var WorkHour = objHMEffort.value;

                WorkHour = WorkHour.trim();
                var idxColon = WorkHour.indexOf(':');

                var hrs = WorkHour.substring(0, idxColon);

                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (blnHMFormat == true) {
                    if (mins == "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please enter Work(Hrs) in H:M format.', 'error', 5);

                        blnHMFormat = false;
                        checkFlag = false;
                        return checkFlag;
                    }

                    if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Hours should not be less than or equal to zero (0).', 'error', 5);

                        blnHMFormat = false;
                        checkFlag = false;
                        return checkFlag;
                    }

                    if (blnHMFormat == true) {
                        if (mins.length > 2) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Please enter minutes in two decimal and less than 60.', 'error', 5);

                            blnHMFormat = false;
                            checkFlag = false;
                            return checkFlag;
                        }
                    }

                    if (blnHMFormat == true) {
                        if (mins > 59 || mins < 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Please enter minutes between (0-59) range', 'error', 5);

                            blnHMFormat = false;
                            checkFlag = false;
                            return checkFlag;
                        }
                    }
                }

                if (objnewVal.indexOf(':') > 0) {
                    //Commented And Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                    //var minHrsForDAEntryDec = GetMinHoursForDAEntry();
                    var MinHoursData = GetMinHoursForDAEntry();
                    var arrMinHoursData = MinHoursData.toString().split("$$");
                    var RestrictByMinHours = arrMinHoursData[0]
                    var minHrsForDAEntryDec = arrMinHoursData[1]
                    //End Of Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                    var minHrsForDAEntry = 60 * minHrsForDAEntryDec;
                    var workhrminPart = objnewVal.substring(objnewVal.indexOf(':') + 1);
                    //Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                    if (minHrsForDAEntryDec == 0.25) {
                        minHrsForDAEntry = "00:15"
                    }
                    else if (minHrsForDAEntryDec == 0.50) {
                        minHrsForDAEntry = "00:30"
                    }
                    else if (minHrsForDAEntryDec == 0.75) {
                        minHrsForDAEntry = "00:45"
                    }


                    //End Of Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag

                    //Commented And Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                    //if (workhrminPart % minHrsForDAEntry != 0 || workhrminPart > 59) {
                    //    //Commented And Added By Usha Pandit On 18.03.2020 for correct alertt
                    //    //alertify.error("Please Enter valid Work Hours minutes part in multiple of " + minHrsForDAEntry);
                    //    alertify.notify('Please enter the work Hours in multiple of (' + minHrsForDAEntry + ') min', 'error', 5);
                    //    //End Of Added By Usha Pandit On 18.03.2020 for correct alertt
                    //    checkFlag = false;
                    //    return checkFlag;
                    //}

                    if (RestrictByMinHours == "True") {
                        if (minHrsForDAEntryDec == 0.016) {
                        }
                        else {
                            var minutes = objnewVal.split(':');

                            var p = minutes[0];
                            var dec = minutes[1];

                            if (dec != undefined) {
                                if (dec.length > 2) {
                                    dec = dec.substring(0, 2);
                                }
                                if (dec.length == 1) {
                                    dec = dec + "0";
                                }

                                if (dec == undefined) { dec = 0; }
                                d = (dec - 0) / 60 + (p - 0);

                                if ((d / minHrsForDAEntryDec) != parseInt(d / minHrsForDAEntryDec)) {
                                    if (blnHMFormat == true) {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Please enter the work Hours in multiple of (' + minHrsForDAEntry + ') min', 'error', 5);
                                        checkFlag = false;
                                        return checkFlag;
                                    }
                                }
                            }
                        }
                    }

                    //End Of Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                }

                if (checkLCETotal_AssignIssue(objnewVal, PlanID) == false) {
                    checkFlag = false;
                    return checkFlag;
                }

                return checkFlag;
            }
            catch (ex) {
                return false;
                //alert(ex.message);
            }
        }
        //End Of Added By Usha Pandit On 16.03.2020 for work hours validation

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
        function RestrictNonNumeric(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }

            var dofocus = (arguments.length > 1) ? arguments[1] : true;
            if (!isNumeric(getInputValue(obj))) {
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }
        function validateWorkHours(workhr) {
            var ret = true;
            if (workhr.length == 0 || workhr == 0) {
                alertify.error("Please Enter the Work Hours..");
                return false;
            }
            if (isNumeric(workhr.replace(':', '')) == false || workhr.indexOf('.') > -1) {
                alertify.error("Please Enter the Work Hours in H:m format");
                return false;
            }
            if (workhr.indexOf(':') > 0) {
                var minHrsForDAEntryDec = GetMinHoursForDAEntry();
                var minHrsForDAEntry = 60 * minHrsForDAEntryDec;
                var workhrminPart = workhr.substring(workhr.indexOf(':') + 1);
                if (workhrminPart % minHrsForDAEntry != 0 || workhrminPart > 59) {
                    alertify.error("Please Enter valid Work Hours minutes part in multiple of " + minHrsForDAEntry);
                    return false;
                }
            }
            if (checkLCETotal(workhr) == false) {
                return false;
            }
            return ret;
        }

        function isProjectOnHold() {
            var param = JSON.stringify(issueId = IssueID);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/IsProjectOnHold", param, false);
            if (strResult == "1") {
                alertify.error("This project is 'On Hold', so you can't assign task against it.");
                return false;
            }
            return true;
        }

        function GetMinHoursForDAEntry() {
            var param = JSON.stringify(projectId = ProjectID);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/GetMinHoursForDAEntry", param, false);
            return strResult;
        }

        function checkLCETotal(workhr) {


            var param = JSON.stringify(projectId = ProjectID);
            var ProjectBalanceEfforts = 0;
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/GetProjectWorkHours", param, false);
            if (strResult != undefined) {
                var ProjectEfforts = strResult.LCETotal;
                var ProjectAllocatedEfforts = strResult.AllocatedLCETotal;
                if (ProjectEfforts != "" && ProjectAllocatedEfforts != "") {
                    ProjectBalanceEfforts = ProjectEfforts - ProjectAllocatedEfforts;
                }

                var issueNewEffort = convertWHToDecimal(workhr);
                if (parseFloat(issueNewEffort - ProjectEfforts) > parseFloat(ProjectBalanceEfforts)) {
                    alertify.error("The total work (hours) of the tasks should not exceed the project work hours.Balance work hours are (" + ProjectBalanceEfforts + ") ");
                    return false;
                }
                return true;
            }

        }
          function checkLCETotal_AssignIssue(workhr, ctr) {
           // debugger;
            var ResourceID = 'cboAssignResource' + ctr;
            var TaskID = 'cboAssignIssueTask' + ctr;
            var Resource = $('select#' + ResourceID + ' option:selected').val();
            var TaskTypeId = $('select#' + TaskID + ' option:selected').val();
            var ModuleName = $('select#' + TaskID + ' option:selected').text();

            //var param = JSON.stringify(projectId = ProjectID, Resource = Resource, TaskTypeId = TaskTypeId, ModuleName = ModuleName, IssueID = IssueID);
              var AssignIssue = {
                  projectId: ProjectID, EmployeeId: Resource, TaskTypeId: TaskTypeId,
                  ModuleName: ModuleName, IssueId: IssueID,Duration:workhr
              }
           //   alert(AssignIssue);
            var param = JSON.stringify(AssignIssue);
            var ProjectBalanceEfforts = 0;
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/GetCheckAssignIssueProjectWorkHours", param, false);
              if (strResult != undefined) {
                  if (strResult != "") {
                      alertify.error(strResult);
               
                      return false;

                  } else {
                      return true;
                  }

                  //var ProjectEfforts = strResult.LCETotal;
                  //var ProjectAllocatedEfforts = strResult.AllocatedLCETotal;
                  //if (ProjectEfforts != "" && ProjectAllocatedEfforts != "") {
                  //    ProjectBalanceEfforts = ProjectEfforts - ProjectAllocatedEfforts;
                  //}
                  //debugger;
                  //var issueNewEffort = convertWHToDecimal(workhr);
                  ////Commented & Added By Dipali V On 30th Nov 2021 For Project Efforts with Task Efforts
                  ////if (parseFloat(issueNewEffort - ProjectEfforts) > parseFloat(ProjectBalanceEfforts)) {
                  //if (parseFloat(issueNewEffort) > parseFloat(ProjectBalanceEfforts)) {
                  //    //End of Commented & Added By Dipali V On 30th Nov 2021 For Project Efforts with Task Efforts
                  //    alertify.error("The total work (hours) of the tasks should not exceed the project work hours.Balance work hours are (" + ProjectBalanceEfforts + ") ");
                  //    return false;
                  //}
                  //return true;
              }

        }
        $("#addNewDiscussionID").click(function () {
            $("#Idheader").show();
            if (ShowToCustomer == 'False') {
                $("#chkDiscussionShowToCustomer").hide();
            }
            else
            {
                //Added by imran on 22-12-2021
                document.getElementById("chkDiscShowToCustomer").checked = true;
                //End comment by imran onn 22-12-2021
                $("#chkDiscussionShowToCustomer").show();
            }

            //Added By Dipali V on 1st April 2021 For If Customer Login Show to customer should not display
            if (LoginType == "C") {
                $("#chkDiscussionShowToCustomer").hide();
            }
            //End of Added By Dipali V on 1st April 2021 For If Customer Login Show to customer should not display

            GetTypesForDiscussion();
            $("#txtareaID").val('');
            filedata = new FormData();
            var objFileGrid = document.getElementById('tblFiles');
            $('#tblFiles').find("tr:gt(0)").remove();
            objFileGrid.style.display = "none";
            FileCount_toDisable = 0;
            MainFileCount_toDisable = 0;
        })

        $("#btnClear").click(function () {
            $("#txtareaID").val('').empty();
            $("#cboDiscussionStatus option[value=0]").prop('selected', true);
            $('#chkDiscShowToCustomer').prop('checked', false);
        })

        $("#btnSubmit").click(function () {
            var ShowToCustomerVal;
            var CommentTextAreaValue = $("#txtareaID").val();
            var Statusvalue = $('select#cboDiscussionStatus option:selected').val();

            if (CommentTextAreaValue.trim() == "") {
                alertify.error("Comment should not be left blank");
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022          
            if (checkSpecialCharacter(CommentTextAreaValue, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Comment should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtareaID").focus();
                return false;
            }

            if (Statusvalue == 0) {
                alertify.error("Select Discussion Status");
                return false;
            }
            //Commented And Added By Usha Pandit On 05.05.2021 For hiding discussion from customer if ShowToCustomer check is not checked
            //if (ShowToCustomer == 'False') {
            //    ShowToCustomerVal = 0;
            //}
            //else {
            //    ShowToCustomerVal = 1;
            //}

            var checkbox = document.querySelector('input[id="chkDiscShowToCustomer"]');
            if (checkbox.checked == true) {
                ShowToCustomerVal = 1;
            }
            else {
                ShowToCustomerVal = 0;
            }
            if ($("#chkDiscShowToCustomer").is(":visible") == false) {
                ShowToCustomerVal = 1;
            }
            //End Of Added By Usha Pandit On 05.05.2021 For hiding discussion from customer if ShowToCustomer check is not checked

            if (ValidateAttachment('tblFiles', 'FILENAME', 'txtFileName') == false) {
                return false;
            }
            //StartLoader("#bodyIssueDetails");
            SaveDiscussionDetails(IssueID, UserName, CommentTextAreaValue, ShowToCustomerVal, Statusvalue);

            ShowDiscussionDetails(commonProperty);
            StopAjaxLoader("#bodyIssueDetails");

            //  window.open("../Email/SendEmail.aspx?MessageID=33&IssueID=" + IssueID + "&ProjectID=" + ProjectID + "&EmployeeID=" + EmployeeId + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
        })

        $("#ConvertTodeliverableID").click(function () {
            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            //End of Added By Dipali V On 16th April 2020 For hide tooltip


            if (DeliverableID != 0) {
                alertify.error("Deliverable is already mapped to this issue!")
                $("#tab_4").hide();
                $("#tab_4").removeClass('show');//Added By Dipali V On 5th April 2023 For Already Deliverable created then tab should not enabled
            }
            else {
                $("#tab_4").show();
                $("#tab_4").addClass('show');
                $("#divCDdate").hide();
                //GetProjectsForDeliverable();
                GetProjectsForDeliverable(ProjectID);
                GetDeliverableTypes(ProjectID);
                GetExpectedStartAndEndDate(ProjectID);
                $("#dtDeliverableTitle").val(Summary);
                $("#dtaDescription").html(Description);
                $("#cboDeliverableTypes").change(function () {
                    var value = $(this).children("option:selected").val();
                    if (value == 0) {
                        $("#divCDdate").hide();
                    }
                    else {
                        $("#divCDdate").show();
                    }
                })
            }
        })

        $("#SLA").click(function () {
            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            //End of Added By Dipali V On 16th April 2020 For hide tooltip


            $("#tab_4").hide();
            $("#tab_4").removeClass('show');
        });

        $("#btnDSubmit").click(function () {
            var cboDeliverableTypesValue = $("#cboDeliverableTypes").val();
            var dtDeliverableTitleValue = $("#dtDeliverableTitle").val();
            var dtaDescriptionValue = $("#dtaDescription").val();
            var CDdateValue = $("#CDdate").val();
            //Added By Rutuja D. on 29 Jan 2020 For Convert to deliverable not saved when single qoutes in description
            dtaDescriptionValue = dtaDescriptionValue.replace(/'/g, "''");
            //End of Added By Rutuja D. on 29 Jan 2020 For Convert to deliverable not saved when single qoutes in description
            if (cboDeliverableTypesValue == 0) {
                alertify.error(" Deliverable Type should not be left Blank");
                $("#cboDeliverableTypes").focus()
                return false;
            }
            else if (dtDeliverableTitleValue == 0) {
                alertify.error("Title should not be left Blank");
                $("#dtDeliverableTitle").focus()
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022          
            else if (checkSpecialCharacter(dtDeliverableTitleValue, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Deliverable Title should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#dtDeliverableTitle").focus();
                return false;
            }
            else if (checkSpecialCharacter(dtaDescriptionValue, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Deliverable Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#dtaDescription").focus();
                return false;
            }
            else if (CDdateValue == 0) {
                alertify.error("Start Date should not be left Blank");

                return false;
            }
            var ValMessage = ValidateDate(ProjectID, CDdateValue);
            if (ValMessage == false) {
                document.getElementById("CDdate").focus();
                $("#CDdate").focus()
                return false;
            }
            else {
                StartLoader("#bodyIssueDetails");
                var newIssue = { ScheduleTypeID: cboDeliverableTypesValue, ProjectId: ProjectID, Title: encodeURI(dtDeliverableTitleValue), StartDate: CDdateValue, Description: encodeURI(dtaDescriptionValue), IssueID: IssueID, UserName: UserName }
                var param = JSON.stringify(newIssue);
                var result = AJAXCallWithResult("/api/IB_IssueDetails/SaveDeliverable", param, false);
                //
                var Result = result;
                if (Result != undefined) {
                    // debugger;
                    //commented by dipali V on 12th sep for mail pop up conditionally
                    Result = result.split("&&")
                    // DeliverableID = result;
                    DeliverableID = Result[0];
                    $("#cboDeliverableID").removeClass('selectpicker');
                    //End of commented by dipali V on 12th sep for mail pop up conditionally
                    //GetDeliverableID(ProjectID);
                    GetCommonCboValues("GetDeliverable", "DeliverableID");
                    //Added By Dipali V On 12th May 2020 Foor Issue ID 24237
                    AssignComboValue("DeliverableID", DeliverableID);
                    //End of Added By Dipali V On 12th May 2020 Foor Issue ID 24237
                    //GetIssueDetails(IssueID);
                    StopAjaxLoader("#bodyIssueDetails");

                    alertify.success("Converted to Deliverable Successfully.");
                    $("#btnDSubmit").attr("disabled", "disabled");
                    //commented by dipali V on 12th sep for mail pop up conditionally
                    if (Result[1] == 1) {
                        window.open("../Email/SendEmail.aspx?MessageID=473&IssueID=" + IssueID + "&ProjectID=" + ProjectID + "&EmployeeID=" + EmployeeId + "", '_blank', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                    //End of commented by dipali V on 12th sep for mail pop up conditionally

                }
            }
        })

        $("#ViewHistoryID").click(function () {
            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            //End of Added By Dipali V On 16th April 2020 For hide tooltip


            if (IssueID == undefined || IssueID == "") {
                IssueID = '<%=IssueID%>';
            }
            GetHistoryDetailsInfo(IssueID, 0, 0);
            GetFiledsForHistory(IssueID);
            GetModifiedBy(IssueID);
            $("#tab_4").hide();
        })

        $("#divDiscussion").click(function () {

            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            //End of Added By Dipali V On 16th April 2020 For hide tooltip



            $("#tab_4").hide();
        })




        $("#cboSelectFields,#cboModified").change(function () {
            var FieldName = $('select#cboSelectFields option:selected').val();
            var ChangedBy = $('select#cboModified option:selected').val();

            GetHistoryDetailsInfo(IssueID, FieldName, ChangedBy);
        })

        $('#projecttasksearch').on('keyup change', function () {
            var cnt = 0;
            var value = $(this).val().toLowerCase();
            $('.nohistorydata').remove();

            $("#tbdHistoryDetails tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                if ($(this).text().toLowerCase().indexOf(value) > -1) cnt += 1;
            });
            if (cnt == 0)
                $('#tbdHistoryDetails').append('<tr class="nohistorydata"><td colspan="45">' + 'No matching records found.' + '</td></tr>');
        })

        $("#btnDownloadInZip").click(function () {
            var param = JSON.stringify(IssueID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/AttachmentsOriginalFileName", param, false);
            if (result != undefined) {
                //alert(result[0].OriginalFileName);
                //alert(result[0].FilePath);
            }

            var Data = [IssueID,]

            var nombre = "Zip_img";
            //The function is called
            compressed_img(arrayId, nombre);

            function compressed_img(arrayId, nombre) {
                var zip = new JSZip();
                var count = 0;
                var name = nombre + ".zip";
                arrayId.forEach(function (url) {
                    JSZipUtils.getBinaryContent(url, function (err, data) {
                        if (err) {
                            throw err;
                        }
                        zip.file(url, data, { binary: true });
                        count++;
                        if (count == arrayId.length) {
                            zip.generateAsync({ type: 'blob' }).then(function (content) {
                                saveAs(content, name);
                            });
                        }
                    });
                });
            }
        })

        $("#AssignIssueID").click(function () {
            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            //End of Added By Dipali V On 16th April 2020 For hide tooltip


            $("#tab_4").hide();
            //GetResources('1');
            //$("#assignissueDuedate").val(ProjectReportedDate);
            //$('#assignissueDuedate,#assignissueSdate,#assignissueEdate,#AssignIssueWorkHours').css('text-align', 'center');
            //$('#assignissueDuedate,#assignissueSdate1,#assignissueEdate1,#AssignIssueWorkHours1').css("autocomplete", "off");

            //GetTaskTypes();
            //
            //$("#cboTaskType").change(function () {
            //    var TaskTypeID = $(this).children("option:selected").val();
            //    GetSubTaskTypes(TaskTypeID);
            //})
            var totalhrsdec = 0.0;
            var totalhrs = 0;
            var param = JSON.stringify(IssueID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetAssignedIssueDetails", param, false);
            if (result.length > 0) {
                var ResourceId, TaskTypeID, SubTaskTypeID, StartDate, EndDate, WorkHours, IsBillable, TaskId;
                for (var i = 0; i < result.length; i++) {
                    ResourceId = result[i].EmployeeID;
                    TaskTypeID = result[i].TaskTypeID;
                    //SubTaskTypeID = result[i].SubTaskTypes;
                    StartDate = result[i].StartDate;
                    EndDate = result[i].EndDate;
                    WorkHours = result[i].Work;
                    IsBillable = result[i].BillableYN;
                    TaskId = result[i].TaskID;
                    IsTaskComplete = result[i].IsTaskComplete;
                    ReleaseDate = result[i].ReleaseDate;
                    totalhrsdec += parseFloat(WorkHours);
                    if (i > 0) {
                        counter = i;
                        generateAssignIssueRow(counter);
                    }

                    $("select#cboAssignResource" + i + " option[value=" + ResourceId + "  ]").attr("selected", "selected");
                    $("select#cboAssignIssueTask" + i + " option[value=" + TaskTypeID + "  ]").attr("selected", "selected");
                    //var SubTaskID = "cboAssignIssueSubtask" + i;
                    //GetSubTaskTypesAddNew(TaskTypeID, SubTaskID);
                    //$("select#cboAssignIssueSubtask" + i + " option[value=" + SubTaskTypeID + "  ]").attr("selected", "selected");
                    if ($("#cboAssignResource" + i).val() != "0") {
                        $("#cboAssignResource" + i).prop("disabled", "disabled");
                    }
                    $('#dtAssignIssueStartDate' + i).val(StartDate);
                    $('#dtAssignIssueEndDate' + i).val(EndDate);

                    WorkHours = convertWHToTime(WorkHours);
                    $('#AssignIssueWorkHours' + i).val(WorkHours);

                    if (IsTaskComplete == true) {
                        $('#dtAssignIssueStartDate' + i).prop("disabled", "disabled");
                        $('#dtAssignIssueEndDate' + i).prop("disabled", "disabled");
                        $('#AssignIssueWorkHours' + i).prop("disabled", "disabled");
                    }

                    if (IsTaskComplete == true && ReleaseDate != null) {
                        $('#ReopenTask' + i).html('');
                        $('#ReopenTask' + i).html('<a href="#">Reopen</a>');
                    }
                    else {
                        $('#ReopenTask' + i).html('');
                        $('#ReopenTask' + i).html('N/A');
                    }

                    if (IsBillable == true) {
                        $('#AssignIssueIsBillable' + i).prop('checked', true);
                    }
                    $('#htid' + i).html(TaskId);
                }
            }
            if (totalhrsdec != undefined && totalhrsdec != null && totalhrsdec != "") {
                totalhrsdec = totalhrsdec.toFixed(2);
            }
            totalhrs = convertWHToTime(totalhrsdec);
            $('#lblTotalWorkHours').text(totalhrs);
        })


       

       
        function convertWHToDecimal(wh) {
            if (wh.indexOf(':') > 0) {
                //Commented And Added By Usha Pandit On 03.04.2020 For getting HM hours
                //var workhrminPart = wh.substring(wh.indexOf(':') + 1);
                //var workhrDec = parseFloat(workhrminPart / 60);
                //var workhrhrPart = wh.substring(0, wh.indexOf(':'));
                //wh = parseFloat(workhrhrPart) + parseFloat(workhrDec);

                wh = GetDecimalHours(wh);
                //End Of Added By Usha Pandit On 03.04.2020 For getting HM hours
            }
            return wh;
        }

        function convertWHToTime(WorkHours) {
            if (WorkHours.toString().indexOf('.') > 0) {
                //Commented And Added By Usha Pandit On 03.04.2020 For getting HM hours
                //    var workhrminPart = WorkHours.toString().substring(WorkHours.toString().indexOf('.'));
                //    var workhrDec = parseFloat(workhrminPart * 60);
                //    var workhrhrPart = WorkHours.toString().substring(0, WorkHours.toString().indexOf('.') + 1);
                //    var WorkHours = (workhrhrPart + workhrDec).replace('.', ':');

                WorkHours = GetHMHours(WorkHours);
                //End Of Added By Usha Pandit On 03.04.2020 For getting HM hours
            }
            return WorkHours;
        }
        function GetHMHours(WorkHours) {
            var param = JSON.stringify(DecHours = WorkHours);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/getHMHours", param, false);
            return strResult;
        }
        function GetDecimalHours(WorkHours) {
            var param = JSON.stringify(HMHours = WorkHours);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/getDecimalHours", param, false);
            return strResult;
        }
        function ValidateAttachment(tbl, FNAME, txtfname) {
            var ValidateAttachmentFlag = true;
            $("#" + tbl + " tr").each(function () {
                var id = $(this).attr("id");

                if (id != undefined) {
                    var Filecount = id.split(FNAME)[1];
                    var objFileName = document.getElementById(txtfname + Filecount);
                    var DocumentType = document.getElementById("cboDocumenttype" + Filecount);
                    var DocumentSubType = document.getElementById("cboDocumentSubtype" + Filecount);
                     
                    if (objFileName != null) {
                        //if (disallowBlank(objFileName,"Please select the file")	) {return;}
                        if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                        if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                        var countOfDot, FileNameCharCount;
                        var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
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
                                if (strExtn.toLowerCase() == extension)
                                //Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
                                //{ allowSubmit = false; }
                                { allowSubmit = true; }
                                //End of Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
                            }
                            if (allowSubmit == false) {
                                alertify.error("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!");
                                ValidateAttachmentFlag = false;
                                return false;
                            }
                        }

                        if (objFileName.files['0'].name != '')
                            var countOfDot = objFileName.files['0'].name.split(".").length - 1;

                        if (countOfDot > 1) {
                            alertify.error('File with two or more extensions is not allowed!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (objFileName.files['0'].name != '')
                            FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

                        if (FileNameCharCount > 120) {

                            alertify.error('File name should not exceed 120 characters!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (intActualFileSize < intMinFileSize) {
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

        function UpdateIssueTable(WorkHours, DueDate) {
            var AssignIssue = { IssueId: IssueID, Duration: WorkHours, DueDate: DueDate, CreatedBy: UserName };
            var param = JSON.stringify(AssignIssue);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/UpdateIssueTable", param, false);
        }

        function GetTypesForDiscussion() {
          
            //Added By Dipali V On 8th Oct 2021 For Refresh issue
            var Type = $('#cboType option:selected').text();
            if (Type != Typeproject) {
                Typeproject = Type;

            }
            //End of Added By Dipali V On 8th Oct 2021 For Refresh issue
            //alert(Status);
            var newIssue = { ProjectId: parseInt(ProjectID), Type: Typeproject, RoleId: roleid, Status: (Status != "" ? Status : "") };
            //var newIssue = { ProjectId: parseInt(ProjectID), Type: Typeproject, RoleId: roleid, Status: (Status != "" ? Status : "") };
            var param = JSON.stringify(newIssue);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetStatus", param, false);
            if (result != undefined) {
                var res = result[0];

                //if (res.ResultFlag == true) {
                //    alert("input parameter have special charcter");
                //}
                //else {


                var objCbo1 = document.getElementById("cboDiscussionStatus");
                $("#cboDiscussionStatus option").remove();

                for (var i = 0; i < result.length; i++) {
                    // debugger;
                    var ObjStatus = result[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjStatus.FieldName;
                    objOption.value = ObjStatus.FieldID;
                }
                //Added & commented by Dipali V On 23rd Sep 2019 For Placeholder issues
                //AppendOptioncbo("DiscussionStatus", "");
                AppendOptioncbo("DiscussionStatus", "Status");
                //End of Added & commented by Dipali V On 23rd Sep 2019 For Placeholder issues

                //alert(Status);
                if (Status != "") {
                    $("select#cboDiscussionStatus option:contains(" + Status + ")").attr('selected', 'selected');
                }
            }
        }
        //}

        function SaveDiscussionDetails(IssueID, UserName, CommentTextAreaValue, ShowToCustomerVal, Statusvalue) {
           
            var DataValues = { IssueID : IssueID, UserName : UserName, CommentTextAreaValue : encodeURI(CommentTextAreaValue), StatusValue : encodeURI(Statusvalue), ShowToCustomerVal : ShowToCustomerVal };
            var param = JSON.stringify(DataValues);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/SaveDiscussionDetails", param, false);
            if (result != undefined) {
                //var result
                var Result = result.split("&&")
                //Added By Dipali V On 12th Sep 2019 For Email Comes blank

                var DiscussionID = Result[0];
                //End of Added By Dipali V On 12th Sep 2019 For Email Comes blank

                $("select#cboStatus option:contains(" + Statusvalue + ")").attr('selected', 'selected');
                if (Status != Statusvalue) {
                    getServerDateTime();
                    $("#dtStatusChangeDate").val(CurrentDate);
                    ////Commennted & Added By Dipali V On 5th Oct 2021 For Get Current Date & Time   
                    //$("#dtStatusChangeTime").val(CurrentTime);
                    // debugger;
                    var H = CurrentTime.split(' ')[1].split(":")[0];
                    var PMAM = CurrentTime.split(' ')[2];
                    var M = CurrentTime.split(' ')[1].split(":")[1];
                    var Time = H + ":" + M + " " + PMAM;
                    var CurrentTime_new = convertTime12to24(Time);
                    $("#dtStatusChangeTime").val(CurrentTime_new);
                    //Added By Dipali V On 5th April 2023 For Value should not change
                    $("#dtStatusChangeTime").prop("cursor", "no-drop!important");
                    $("#dtStatusChangeDate").prop("cursor", "no-dropimportant");
                    //End of Added By Dipali V On 5th April 2023 For Value should not change
                    //End of Commennted & Added By Dipali V On 5th Oct 2021 For Get Current Date & Time

                }
                //Added By Dipali V On 12th Sep 2019 For Email Comes blank

                if (Result[1] == "1") {
                    // Added By Chetan Muley On 15 Aug 2020 For setting focus in IE browser
                    var browser = isIE();
                    if (browser == 'IE') {
                        setTimeout('self.focus()', 2);
                    }
                    //End Of Added By Chetan Muley On 15 Aug 2020 For setting focus in IE browser
                    window.open("../Email/SendEmail.aspx?MessageID=33&IssueID=" + IssueID + "&ProjectID=" + ProjectID + "&EmployeeID=" + EmployeeId + "", '_blank', 'resizable=yes,scrollbars=yes,position=fixed,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    //Added By Usha Pandit On 09.08.2020 For setting focus in IE browser
                    $("#addnewdiscussion").modal('hide');

                }
                else {

                }
                //End of Added By Dipali V On 12th Sep 2019 For Email Comes blank

                Status = Statusvalue;
                attachement(IssueID, DiscussionID);
                clear_discussionattachement()
            }
        }

        function DeleteAssignedIssue(EmployeeID, ctr) {

            var AssignedIssue = { IssueId: IssueID, ProjectId: ProjectID, EmployeeID: EmployeeID };
            var param = JSON.stringify(AssignedIssue);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/DeleteAssignedIssue", param, false);
            if (strResult != undefined) {
                alertify.success("Assigned Issue is deleted sucessfully.")
                $("#addr" + ctr).remove();
                calculateTotalWkHrs();
            }
        }

        // var data = new FormData();
        function attachement(issueid, DiscussionId) {
            //
            //var Attachmenttextarea = $("#txtComments0").val();
            //var OldFileName = $("#FILENAME0 td:nth-child(2)").text();
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
                    //Commented and added by Chetan M on 26 May 2021 for Issue fixing
                    //Attachmenttextarea = $("#txtComments" + [i]).val().replace("'", "''");
                    if ($("#txtComments" + AllfileDataDiscussion[i]).val() != undefined) {
                        Attachmenttextarea = $("#txtComments" + AllfileDataDiscussion[i]).val().replace("'", "''");
                    }
                    else {
                        Attachmenttextarea = "";
                    }
                    //End of Commented and added by Chetan M on 26 May 2021 for Issue fixing

                    //Added By Rutuja D. on 23 May 2022
                    if ($("#cboDocumenttype" + AllfileDataDiscussion[i]).val() != undefined) {
                        AttachmentDocumentType = $("#cboDocumenttype" + AllfileDataDiscussion[i]).val();
                    } else {
                        AttachmentDocumentType = "";
                    }

                    if ($("#cboDocumentSubtype" + AllfileDataDiscussion[i]).val() != undefined) {
                        AttachmentDocumentSubType = $("#cboDocumentSubtype" + AllfileDataDiscussion[i]).val();
                    } else {
                        AttachmentDocumentSubType = "";
                    }
                    //End of Added By Rutuja D. on 23 May 2022

                    if (AttachmentDocumentSubType == "") {
                        AttachmentDocumentSubType = 0;
                    }

                    OldFileName = $("#FILENAME" + [i] + " td:nth-child(2)").text();
                    ArrAttachmenttextarea.push(Attachmenttextarea);
                    ArrDocumentType.push(AttachmentDocumentType);
                    ArrDocumentSubType.push(AttachmentDocumentSubType);
                }
            }
            //End of Added by dipali V on 11th Sep 2019 for multiple insertation of attachments

            var IssuId = issueid;
            var DiscussionID = DiscussionId;
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

                        //for (var i = 0; i < result.length / 2; i++) {
                        //    if (i == 0) {
                        //        fileSaveInDB(ArrAttachmenttextarea[i], IssuId, result[i + 1], result[i], DiscussionID);
                        //    }
                        //    else {
                        //        fileSaveInDB(ArrAttachmenttextarea[i], IssuId, result[i + 2], result[i + 1], DiscussionID);
                        //    }
                        //}

                        // Comment and added by imran on 18-10-2022
                        //var j = 0;
                        //for (var i = 0; i < result.length; i++)
                        //{
                        //    var Even = i % 2;
                        //    if (Even == false) {
                        //        // Added & commented  by dipali V on 11th Sep 2019 for multiple insertation of attachments
                        //        //SaveMainFileInDB(ArrAttachmenttextarea, issueid, result[i + 1], result[i]);

                        //        // SaveMainFileInDB(ArrAttachmenttextarea[j], issueid, result[i + 1], result[i]);
                        //        //fileSaveInDB(ArrAttachmenttextarea[j], IssuId, result[i + 1], result[i], DiscussionID);
                        //        fileSaveInDB(ArrAttachmenttextarea[j], IssuId, result[i + 1], result[i], DiscussionID,ArrDocumentType[j],ArrDocumentSubType[j]);
                        //        j++;
                        //    }
                        //    //End of commented & added By Dipali Vekhande V On download zip file
                        //}

                        for (var i = 0; i < ArrDocumentType.length; i++) {
                            fileSaveInDB(ArrAttachmenttextarea[i], IssuId, result[i], result[i], DiscussionID, ArrDocumentType[i], ArrDocumentSubType[i]);
                        }

                        //ArrFileCount = [];
                        //ArrAttachmenttextarea = [];
                        //ArrDocumentType = [];
                        //ArrDocumentSubType = [];
                        //End of Comment by imran on 18-10-2022
                    },
                    error: function (xhr, errorThrown) {
                        // alert("error ");
                    }
                });
            }
        }

        function fileSaveInDB(comment, issueid, NewFileName, oldFileName, DiscussionID, DocumentTypeID, DocumentSubTypeID) {
           
            comment = comment.replace(/'/g, "''");
            //debugger;
            //Added By Rutuja D. on 23 May 2022
            if (DocumentTypeID == undefined) {
                DocumentTypeID = "";
            }

            if (DocumentSubTypeID == undefined) {
                //Commented & Added By Dipali V On 6th April 2023 For file Upload Issue
                //DocumentSubTypeID = "";
                DocumentSubTypeID = "0";
               //End of Commented & Added By Dipali V On 6th April 2023 For file Upload Issue
            }

            //End of Added By Rutuja D. on 23 May 2022

            var EmployeeId = "<%= Session("intUserID").ToString() %>";
            var LoginType = "<%= Session("LoginType").ToString() %>";
            // comment = comment.replace("'", "''"); 

            //Commented & Added By Rutuja D. on 23 May 2022
            //var UploadFileParameter = [issueid, EmployeeId, LoginType, NewFileName, oldFileName, comment, DiscussionID];
           // var UploadFileParameter = [issueid, EmployeeId, LoginType, NewFileName, oldFileName, comment, DiscussionID, DocumentTypeID, DocumentSubTypeID];
            var UploadFileParameter = { issueid: issueid, EmployeeId: EmployeeId, LoginType: LoginType, NewFileName: NewFileName, oldFileName: oldFileName, comment: comment, DiscussionID: DiscussionID, DocumentTypeID: parseInt(DocumentTypeID), DocumentSubTypeID: parseInt(DocumentSubTypeID) }
            //End of Commented & Added By Rutuja D. on 23 May 2022
            console.log(UploadFileParameter)
            var param = JSON.stringify(UploadFileParameter);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/FileUplaodSaveDB", param, false);
        }
        var ArrFileCount = [];
        var ArrAttachmenttextarea = [];
        var ArrDocumentType = [];
        var ArrDocumentSubType = [];
        function MainAttachement(issueid) {
            
            var Attachmenttextarea, OldFileName

            var formData = new FormData();
            //var ArrAttachmenttextarea = [];
            //var ArrDocumentType = [];
            //var ArrDocumentSubType = [];
           
            var objFileGrid = document.getElementById('tblMainFiles');
            //ArrFileCount = [];
            //Added by dipali V on 11th Sep 2019 for multiple insertation of attachments
            fileObject = [];
            $("#MainFileControlUploadDiv [type=File]").each(function (j, val) {
                if ($(this)[0].files.length != 0) {
                    fileObject[(j)] = $(this)[0].files;
                }
            })


            for (var i = 0; i <= fileObject.length - 1; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {
                    formData.append(fileObject[i][0].name, fileObject[i][0]);
                    //Attachmenttextarea = $("#txtMainComments" + AllfileData[i]).val();
                    //AttachmentDocumentType = $("#cboDocumenttype" + AllfileData[i]).val();
                    //AttachmentDocumentSubType = $("#cboDocumentSubtype" + AllfileData[i]).val();

                    Attachmenttextarea = $("#txtMainComments" + i).val();
                    AttachmentDocumentType = $("#cboDocumenttype" + i).val();
                    AttachmentDocumentSubType = $("#cboDocumentSubtype" + i).val();

                    if (AttachmentDocumentSubType == "") {
                        AttachmentDocumentSubType = 0;
                    }
                    //alert(Attachmenttextarea);
                    OldFileName = $("#MAINFILENAME" + ArrFileCount[i] + " td:nth-child(2)").text();
                    ArrAttachmenttextarea.push(Attachmenttextarea);
                    ArrDocumentType.push(AttachmentDocumentType);
                    ArrDocumentSubType.push(AttachmentDocumentSubType);
                }
            }
            //End of Added by dipali V on 11th Sep 2019 for multiple insertation of attachments

            if (formData != "[]") {
                $.ajax({
                    //url: encodeURI(url + '/api/IB_AddNewIssue/FileUplaod'),
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

                        //SaveMainFileInDB(Attachmenttextarea, issueid, result, OldFileName);
                        //for (var i = 0; i < result.length / 2; i++) {
                        //    if (i == 0) {
                        //        // Added & commented  by dipali V on 11th Sep 2019 for multiple insertation of attachments
                        //        //SaveMainFileInDB(ArrAttachmenttextarea, issueid, result[i + 1], result[i]);

                        //        SaveMainFileInDB(ArrAttachmenttextarea[i], issueid, result[i + 1], result[i]);
                        //    }
                        //    else {
                        //        //SaveMainFileInDB(ArrAttachmenttextarea, issueid, result[i + 2], result[i + 1]);
                        //        SaveMainFileInDB(ArrAttachmenttextarea[i], issueid, result[i + 2], result[i + 1]);
                        //    }
                        //    //End of Added & commented by dipali V on 11th Sep 2019 for multiple insertation of attachments

                        //}
                        //Commented And added by imran on 18-10-2022 for saving wrong doc.Type saving
                        //var j = 0;
                        //for (var i = 0; i < result.length; i++) {
                        //    var Even = i % 2;
                        //    if (Even == false) {
                        //        // Added & commented  by dipali V on 11th Sep 2019 for multiple insertation of attachments
                        //        //SaveMainFileInDB(ArrAttachmenttextarea, issueid, result[i + 1], result[i]);

                        //        //SaveMainFileInDB(ArrAttachmenttextarea[j], issueid, result[i + 1], result[i]);
                        //        SaveMainFileInDB(ArrAttachmenttextarea[j], issueid, result[i + 1], result[i],AttachmentDocumentType[j],ArrDocumentSubType[j]);
                        //        j++;
                        //    }

                        //    //End of commented & added By Dipali Vekhande V On download zip file
                        //}

                        for (var i = 0; i < ArrDocumentType.length; i++) {
                            SaveMainFileInDB(ArrAttachmenttextarea[i], issueid, result[i], result[i], ArrDocumentType[i], ArrDocumentSubType[i]);
                            //alert(ArrAttachmenttextarea[i] + " " + issueid + " " + result[i] + " " + result[i] + " " + ArrDocumentType[i] + " " + ArrDocumentSubType[i]);
                        }
                        ArrFileCount = [];
                        ArrAttachmenttextarea = [];
                        ArrDocumentType = [];
                        ArrDocumentSubType = [];
                        //End of Comment by imran on 18-10-2022 for saving wrong doc.Type saving
                    },
                    error: function (xhr, errorThrown) {
                        //alert("error ");
                    }
                });
            }
            // }
        }
        //added By dipali V On 9th oct 2019 For Select all check issue
        function Selectall(obj) {
            $('#tbodyAttachment input[type="checkbox"]').each(function () {
                //
                if ($(this).prop("checked") == true) {
                    $("#Attachments1").prop("checked", true);
                }
                else {
                    $("#Attachments1").prop("checked", false);
                    return false;
                }
            });

        }

        //End of added By dipali V On 9th oct 2019 For Select all check issue

        function SaveMainFileInDB(comment, issueid, NewFileName, oldFileName, DocumentTypeID, DocumentSubTypeID) {
            //debugger;
            if (comment == undefined) { comment = ""; } else {
                comment = comment.replace(/'/g, "''");
            }
            if (DocumentTypeID == undefined) {
                DocumentTypeID = "";
            }
            if (DocumentSubTypeID == undefined || DocumentSubTypeID == 0)
            {
                  //Commented & Added By Dipali V On 6th April 2023 For file Upload Issue
                //DocumentSubTypeID = "";
                DocumentSubTypeID = "0";
                  //Commented & Added By Dipali V On 6th April 2023 For file Upload Issue
            }
            var EmployeeId = "<%= Session("intUserID").ToString() %>";
            var LoginType = "<%= Session("LoginType").ToString() %>";

            //Commented & Added By Rutuja D. on 23 May 2022
            //var UploadFileParameter = [issueid, EmployeeId, LoginType, NewFileName, oldFileName, comment];
           // var UploadFileParameter = [issueid, EmployeeId, LoginType, NewFileName, oldFileName, comment, DocumentTypeID, DocumentSubTypeID];
            var UploadFileParameter = { issueid: issueid, EmployeeId: EmployeeId, LoginType: LoginType, NewFileName: NewFileName, oldFileName: oldFileName, comment: comment, DocumentTypeID: DocumentTypeID, DocumentSubTypeID: DocumentSubTypeID }
            //END OF Added By Rutuja D. on 23 May 2022

            var param = JSON.stringify(UploadFileParameter);
            var strResult = AJAXCallWithResult("/api/IB_AddNewIssue/FileUplaodSaveDB", param, false);
          
        }


        ////get server date time from server
        function getServerDateTime() {
            $.ajax({
                url: encodeURI(url + '/api/IB_IssueDetails/GetCurrentDateTime'),
                type: 'GET',
                //  data: JSON.stringify(ProjectId),
                dataType: 'json',
                //contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    CurrentDate = result[0];
                    CurrentTime = result[1];
                },
                error: function (xhr, errorThrown) {
                    // alert("error ");
                }
            });

        }

        var DiscussionObj;
        var intDiscussionID;
        function ShowDiscussionDetails(commonProperty) {
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId,
                strMode: commonProperty.strMode
            }
            var param = JSON.stringify(commonProperty);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/ShowDiscussionDetails", param, false);
            if (result != undefined) {
                $("#DiscussionboxID").empty();
                strHTML = "";

                for (var i = 0; i < result.length; i++) {
                    DiscussionObj = result[i];
                    var count = ShowAttachemntsCount(DiscussionObj.DiscussionID);

                    strHTML += "<div class='discussionbox'>" +
                        "<div class='media'>" +
                        "<div class='media-left media-top'>" +
                        "<img src='../../../Images/Photo/" + DiscussionObj.ImageName +
                        "' data-bs-toggle='tooltip' data-placement='top' data-container='body' title = '" + DiscussionObj.UserName +
                        "' onerror=this.src='../../../Images/Photo/no-photo.png' class='img-circle img-bordered-sm media-object' style='width: 60px'>" +
                        "</div>" +
                        " <div class='media-body'>" +
                        " <div class='pt-1 pb-1'>" +
                        "<small><i>" + DiscussionObj.DiscussionDate + "</i></small> <a class='notifyicon pull-right' href='#' class='pull-right'>" +
                        "<label class='uploadBtnWrap' for='thefile>" +
                        "<input type='file' id=" + DiscussionObj.DiscussionID + " onclick='ShowAttachemnts(this.id)'><span class='badge'>" + count + "</span>" +
                        "<span class='nostylebtn' data-bs-toggle='tooltip' data-placement='left' data-container='body' title='Click here to see attached document'><i class='fas fa-paperclip'></i></span>" +
                        "</label>";
                    if (DiscussionObj.IsDeleteable == 1 && DiscussionObj.UserName == UserName) {
                         <%If m_blnEditAccess = True Then%>
                        strHTML += '<span><button data-bs-toggle="tooltip" data-placement="bottom" onclick="DeleteDiscussion(' + DiscussionObj.DiscussionID + ')" id="btnTrashDiscussion"  class="nostylebtn" title="Delete" ><i class="far fa-trash-alt" id="TrashDiscussion" ></i></button></span>';
                        <%End If%>
                    }
                    strHTML += "</a>" +
                        "<div class='clearfix'></div>" +
                        "</div>" +
                        "<div class='msgboxmsg ow'>";

                    var Comments = DiscussionObj.Comments;
                    //Commented & Added By Dipali V On 9th March 2023 For Extra space consider single comma 
                    //var DicussionComments = Comments.replace(/\n/g, ',<br>');
                    var DicussionComments = Comments.replace(/\n/g, '<br>');
                     //end of Commented & Added By Dipali V On 9th March 2023 For Extra space consider single comma 

                    if (DicussionComments.length > 100) {
                        var c = DicussionComments.substr(0, 100);
                        //Added & Commented by Dipali V On 23rd Dec 2019 For More & Less link issue
                        //var h = DicussionComments.substr(100-1, DicussionComments.length - 100);
                        var h = DicussionComments.substr(100, DicussionComments.length - 100);
                        //End of Added & Commented by Dipali V On 23rd Dec 2019 For More & Less link issue
                        strHTML += (
                            /*Added by Swapnagandha K. On 24 Oct 2019 For Issue Add Moew-Less Link In Discussion*/
                            //DicussionComments.slice(0, 100) + '<span>... </span><button class="btn btndefault morelink" id=' + DiscussionObj.DiscussionID + ' onclick="">Show more</button>' +

                            //Commented and added by Chetan M on 18 May 2021 for page getting scroll on click of more link
                            //c + '<span class="moreellipses">... </span><span class="morecontent"><span>' + h + '</span>&nbsp;<a href="#" onclick="showMore(this)">' + moretext + '</a>' +
                            c + '<span class="moreellipses">... </span><span class="morecontent"><span>' + h + '</span>&nbsp;<a href="javascript:;" onclick="showMore(this)">' + moretext + '</a>' +
                            //End of Commented and added by Chetan M on 18 May 2021 for page getting scroll on click of more link
                            '<span style="display:none;">' + DicussionComments.slice(100, DicussionComments.length) + '</span>'
                            /*End Added by Swapnagandha K. On 24 Oct 2019 For Issue Add Moew-Less Link In Discussion*/
                        );
                    }
                    else {
                        strHTML += "<p>" + DicussionComments + "</p>";
                    }
                    strHTML += "</div></div>" +
                        "</div >" +
                        "</div > ";
                }
                $("#DiscussionboxID").append(strHTML);
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }
        /*Added by Swapnagandha K. On 24 Oct 2019 For Issue Add Moew-Less Link In Discussion*/
        var showChar = 100;
        var ellipsestext = "...";
        var moretext = "more";
        var lesstext = "less";
        function showMore(id) {

            if ($(id).hasClass("less")) {
                $(id).removeClass("less");
                $(id).html(moretext);
            } else {
                $(id).addClass("less");
                $(id).html(lesstext);
            }
            $(id).parent().prev().toggle();
            $(id).prev().toggle();
            return false;
        }
        /*End Added by Swapnagandha K. On 24 Oct 2019 For Issue Add Moew-Less Link In Discussion*/
        function DeleteDiscussion(DiscussionID) {
            $('#hdnDiscussionID').val(DiscussionID);
            $('#deletediscmodal').modal('show');
        }

        function ConfirmDeleteDiscussion() {
            var DiscussionID = $('#hdnDiscussionID').val();
            $('#deletediscmodal').modal('hide');
            var param = JSON.stringify(DiscussionID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/DeleteDiscussion", param, false);
            if (result == "1") {
                alertify.success("Discussion is deleted successfully.")
            }
            ShowDiscussionDetails(commonProperty);
        }
        var attachmentCount;
        function ShowAttachemnts(DiscussionId) {
            intDiscussionID = DiscussionId;
            $("#tab_7").modal("show");
            $("#headerattachments").css("display", "block");
            var count = GetAttachmentForDiscussion(DiscussionId);
            return count;
        }

        function ShowAttachemntsCount(DiscussionId) {
            var count = GetAttachmentForDiscussion(DiscussionId);
            return count;
        }

        function GetProjectsForDeliverable(ProjectId) {
            var param = JSON.stringify(ProjectId);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetProjectsForDeliverable", param, false);
            if (result != undefined) {
                //var res = result[0];
                //if (res.ResultFlag == true) {
                //    alert("input parameter have special charcter");
                //}
                //else {
                var objCbo1 = document.getElementById("cboDeliverableProjects");
                if (objCbo1 != null) {
                    $("#cboDeliverableProjects option").remove();

                    for (var i = 0; i < result.length; i++) {
                        var ObjStatus = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.ProjectName;
                        objOption.value = ObjStatus.ProjectId;
                    }
                    AppendOptioncbo("DeliverableProjects", "");

                    if (ProjectID != "") {
                        jQuery("select#cboDeliverableProjects option[value=" + ProjectID + "  ]").attr("selected", "selected");
                    }
                    $("#cboDeliverableProjects").prop("disabled", true);
                }
                //}
            }
        }

        function GetDeliverableTypes(ProjectId) {
            var param = JSON.stringify(ProjectId);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetDeliverableTypes", param, false);
            if (result != undefined) {
                //var res = result[0];

                //if (res.ResultFlag == true) {
                //    alert("input parameter have special charcter");
                //}
                //else {
                //    var objCbo1 = document.getElementById("cboDeliverableTypes");
                //    if (objCbo1 != null) {
                //        $("#cboDeliverableTypes option").remove();

                //        for (var i = 0; i < result.length; i++) {
                //            var ObjStatus = result[i];
                //            var objOption = document.createElement("OPTION");
                //            objCbo1.options.add(objOption);
                //            objOption.text = ObjStatus.LabelSchedule;
                //            objOption.value = ObjStatus.ScheduleID;
                //        }
                //        AppendOptioncbo("DeliverableTypes", "");
                //    }
                //    }
                var objCbo1 = document.getElementById("cboDeliverableTypes");
                if (objCbo1 != null) {
                    $("#cboDeliverableTypes option").remove();

                    for (var i = 0; i < result.length; i++) {
                        var ObjStatus = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.LabelSchedule;
                        objOption.value = ObjStatus.ScheduleID;
                    }
                    AppendOptioncbo("DeliverableTypes", "");


                }
            }
        }

        function ValidateDate(ProjectID, StartDate) {
            var Parameters = { ProjectId: parseInt(ProjectID), StartDate: StartDate };
            var flag = true;
            var param = JSON.stringify(Parameters);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/ValidateDate", param, false);
            if (result != undefined) {
                if (result != "") {
                    alertify.error(result);
                    flag = false;
                }
                else if (result == null) {
                    flag = true;
                }
            }
            return flag;
        }

        function ValidateAssignDate(ProjectID, StartDate, EndDate, DueDate, ReportedDate, dtStartDate, dtEndDate, EmployeeId) {
            var Parameters = { ProjectId: parseInt(ProjectID), StartDate: StartDate, EndDate: EndDate, DueDate: DueDate, ReportedDate: ReportedDate, EmployeeID: EmployeeId };
            var flag = true;
            var param = JSON.stringify(Parameters);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/ValidateAssignDate", param, false);
            if (result != undefined) {
                if (result != "") {
                    var arrmsg = result.split('|');
                    var ctrl = arrmsg[1];
                    alertify.error(arrmsg[0]);
                    if (ctrl == 1) $(dtStartDate).focus();
                    if (ctrl == 2) $(dtEndDate).focus();
                    if (ctrl == 3) $(DueDate).focus();
                    flag = false;
                }
                else if (result == null) {
                    flag = true;
                }
            }
            return flag;
        }

        function GetExpectedStartAndEndDate(ProjectId) {
            var param = JSON.stringify(ProjectId);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetExpectedStartAndEndDate", param, false);
            if (result != undefined) {
                var res = result[0];
                //if (res.ResultFlag != undefined)
                //{
                //    if (res.ResultFlag == true) {
                //        alert("input parameter have special charcter");
                //    }
                //    else {
                for (var i = 0; i < result.length; i++) {
                    var ObjDate = result[i];
                    ExpectedStartDate = ObjDate.ExpectedStartDate;

                    var index = ExpectedStartDate.indexOf(' ');
                    ExpectedStartDate = ExpectedStartDate.substring(0, index);

                    ExpectedEndDate = ObjDate.ExpectedEndDate;
                    var index = ExpectedEndDate.indexOf(' ');
                    ExpectedEndDate = ExpectedEndDate.substring(0, index);
                }
            }
            //}
            // }
        }

        function GetHistoryDetailsInfo(IssueID, FieldName, ChangedBy) {
            //var HistoryParameter = [IssueID, FieldName, ChangedBy];
            var HistoryParameter = { IssueID:IssueID, FieldName:FieldName, ChangedBy : ChangedBy }
            var param = JSON.stringify(HistoryParameter);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetHistoryInfo", param, false);
            if (result != undefined) {
                $('#tbdHistoryDetails').empty();
                if (result.length == 0) {
                    $('#tbdHistoryDetails').append('<tr><td colspan="45">' + 'There is no history for this Issue ID.' + '</td></tr>');
                }
                var value; var Description
                $.each(result, function (index, val) {
                    // debugger;
                    var HistoryList = val;
                    var rowdata = "";
                    //var value = "";
                    // for (var i = 0; i < HistoryList.length; i++) {
                    //Added By Dipali V On 12th May 2020 Issue ID 24227
                    if (HistoryList.Value.indexOf(":") != -1) {
                        value = TimeConvTo12(HistoryList.Value);
                    } else {
                        value = HistoryList.Value;
                    }
                    // debugger;
                    //Added By Dipali V On 14th May 2020 For ISSUE ID 24441
                    if (HistoryList.FieldName == "Duration") {
                        if (HistoryList.Value != "") {
                            if (HistoryList.Value.indexOf(".") != -1) {
                                //value = TimeConvTo12(HistoryList.Value);
                                var RequestParameters = {
                                    WorkHrs: encodeURI(HistoryList.Value),
                                    Flag: encodeURI(1),
                                }
                                var param = JSON.stringify(RequestParameters);
                                var value = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                            } else {
                                value = HistoryList.Value;
                            }
                        } else {
                            value = HistoryList.Value;
                        }

                        if (HistoryList.Description != "") {
                            if (HistoryList.Description.indexOf(".") != -1) {
                                var RequestParameters = {
                                    WorkHrs: encodeURI(HistoryList.Description),
                                    Flag: encodeURI(1),
                                }
                                var param = JSON.stringify(RequestParameters);
                                var Description = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);

                            } else {
                                Description = HistoryList.Description;
                            }
                        } else {
                            Description = HistoryList.Description;
                        }

                    } else {
                        value = HistoryList.Value;
                        Description = HistoryList.Description;

                    }
                    //End of Added By Dipali V On 14th May 2020 For ISSUE ID 24441

                    //Commented & Added By Dipali V On 24th Nov 2021 For Time Should be in 24 hours
                    //rowdata += "<td>" + HistoryList.ChangedOn + "</td>";
                    if (HistoryList.ChangedTime.indexOf("AM") > -1) {
                       var ChangedTime = HistoryList.ChangedTime.replace('AM', ' AM');
                    }

                     if (HistoryList.ChangedTime.indexOf("PM") > -1) {
                        var ChangedTime = HistoryList.ChangedTime.replace('PM', ' PM');
                    }
                    rowdata += "<td>" + HistoryList.ChangeDate + " " + convertTime12to24(ChangedTime) + "</td>";
                     //End of Commented & Added By Dipali V On 24th Nov 2021 For Time Should be in 24 hours
                    rowdata += "<td>" + HistoryList.ChangedBy + "</td>";
                    rowdata += "<td>" + HistoryList.FieldName + "</td>";

                    if (value == '01 Jan 1900') {
                        value = "";
                    }
                    if (Description == '01 Jan 1900') {
                        Description = "";
                    }
                    rowdata += "<td>" + value + "</td>";
                    rowdata += "<td>" + Description + "</td>";

                    //  }
                    //var RowData;
                    //$.map(HistoryList, function (value, key) {
                    //    //Added by Dipali V On 16th April 2020 For Dateconversion Issue
                    //    if (value != "") {
                    //        if (value.indexOf(":") != -1) {
                    //            value = TimeConvTo12(value)
                    //        }
                    //    }
                    //    //End of Added by Dipali V On 16th April 2020 For Dateconversion Issue
                    //    RowData += '<td>' + value + '</td>';
                    //});

                    //HistoryList
                    $('#tbdHistoryDetails').append("<tr>" + rowdata + "</tr>");
                    //End of Added By Dipali V On 12th May 2020 Issue ID  24227
                });
            }
        }

        function GetModifiedBy(IssueID) {
            var param = JSON.stringify(IssueID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetModifiedBy", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById("cboModified");
                if (objCbo1 != null) {
                    $("#cboModified option").remove();

                    for (var i = 0; i < result.length; i++) {
                        var ObjStatus = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.ModifiedBy;
                        objOption.value = ObjStatus.ModifiedBy;
                    }
                    AppendOptioncbo("Modified", "Modified By");
                }
            }
        }

        //Added By Dipali V On 12th May 2020 For ISSUe ID 24234

        function CheckDAFillOrnot(IssueID) {
            var param = JSON.stringify(IssueID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/CheckDAFillOrnot", param, false);
            if (result != undefined) {
                if (result != "") {
                    //alert(result);
                    // $("#cboType").attr("disabled", "disabled");
                    //$("#cboType").pro("disabled", "disabled");
                    jQuery("#cboType").prop("disabled", true);

                }

            }
        }
        //End of Added By Dipali V On 12th May 2020 For ISSUe ID 24234



        function GetResources(flag1) {
            //var ResourcesParameter = [ProjectID, Typeproject, LoginType, IssueID];
           //Added by Rehan C for Version Upgrade Issues on 13th Feb 2023
            var ResourcesParameter = {
                ProjectId: ProjectID,
                Typeproject: Typeproject,
                LoginType: LoginType,
                IssueID: IssueID

            };
           //End of Comment by Rehan C for Version Upgrade Issues on 13th Feb 2023
            var param = JSON.stringify(ResourcesParameter);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetResources", param, false);
            if (result != undefined) {
                if (flag1 == '1') {
                    var objCbo1 = document.getElementById("cboResource");
                    if (objCbo1 != null) {
                        $("#cboResource option").remove();

                        for (var i = 0; i < result.length; i++) {
                            var ObjStatus = result[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.text = ObjStatus.UserName;
                            objOption.value = ObjStatus.EmployeeID;
                        }
                        AppendOptioncbo("Resource", "");
                    }

                } else {
                    //Added by dipali Vekhande on 11th jan 2019 for Resource dropdown
                    $('.assignissue_tbl tbody tr').each(function () {
                        //
                        var id = $(this).attr("id");
                        var SelectedEmployee = $("#" + id + " td:nth-child(1)").find("select").attr("id");
                        //if (SelectedEmployee != "cboResource") {
                        var objCbo1 = document.getElementById(SelectedEmployee);
                        if (objCbo1 != null && objCbo1.value == 0) {
                            $("#" + SelectedEmployee).empty();
                            var objOption = document.createElement("OPTION");
                            //objOption.text ="";
                            //objOption.value = "";
                            for (var i = 0; i < result.length; i++) {
                                var ObjStatus = result[i];

                                objCbo1.options.add(objOption);
                                objOption.text = ObjStatus.UserName;
                                objOption.value = ObjStatus.EmployeeID;
                            }
                            ///if ($("#" + SelectedEmployee).val() == "") {
                            var id = SelectedEmployee
                            var textval = "Select Resource";
                            var cbofield = document.getElementById(id);
                            if (cbofield != null && cbofield != undefined) {
                                cbofield.insertBefore(new Option(textval, '0'), cbofield.firstChild);
                                $("#" + id + " option[value=0]").prop('selected', true);
                                //}

                            }

                            //  }
                            $('select option')
                                .filter(function () {
                                    return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                                })
                                .remove();

                        }

                    });

                }
                //End of Added by dipali Vekhande on 11th jan 2019 for Resource dropdown
            }
        }



        function cbResourceOnchange(obj) {
            //GetResourcesAddNew(obj.id)
            getSelectedEmployees();
        }

        function getSelectedEmployees() {
            //
            var arrSelectedEmployees = new Array();

            $('.assignissue_tbl tbody tr').each(function () {
                var id = $(this).attr("id");
                //
                var SelectedEmployee = $("#" + id + " td:nth-child(1)").find("select").attr("id");
                var SelectedEmployeeID = $("#" + SelectedEmployee + " :selected").val();
                if (SelectedEmployeeID != 0) {
                    arrSelectedEmployees.push(SelectedEmployeeID);
                }
                else {
                    //Added by dipali Vekhande on 11th jan 2019 for Resource dropdown
                    //  GetResources('2');
                    //End of Added by dipali Vekhande on 11th jan 2019 for Resource dropdown
                }
            });

            for (let i = 0; i < arrSelectedEmployees.length; i++) {
                $('.assignissue_tbl tbody tr').each(function () {
                    //
                    var id = $(this).attr("id");
                    var SelectedEmployee = $("#" + id + " td:nth-child(1)").find("select").attr("id");
                    var SelectedEmployeeID = $("#" + SelectedEmployee + " :selected").val();
                    if (SelectedEmployeeID != arrSelectedEmployees[i]) {
                        $("#" + SelectedEmployee + " option[value='" + arrSelectedEmployees[i] + "']").remove();
                    }
                });
            }
            if (arrSelectedEmployees.length == 0) {

            }


        }

        function GetResourcesAddNew(ResourceID) {
            // alert(ResourceID);
            //var ResourcesParameter = [ProjectID, Typeproject, LoginType, IssueID];
            //Added by Rehan C for Version Upgrade Issues on 13th Feb 2023
            var ResourcesParameter = {
                ProjectId: ProjectID,
                Typeproject: Typeproject,
                LoginType: LoginType,
                IssueID: IssueID

            };
            //End of Comment by Rehan C for Version Upgrade Issues on 13th Feb 2023
            var param = JSON.stringify(ResourcesParameter);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetResources", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById(ResourceID);
                if (objCbo1 != null) {
                    $(ResourceID).empty();

                    for (var i = 1; i < result.length; i++) {
                        // alert(result.length)
                        var ObjStatus = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.UserName;
                        objOption.value = ObjStatus.EmployeeID;
                    }
                }
            }
        }

        //function GetTaskTypes() {
        //    var ProjectId = ProjectID;
        //    var param = JSON.stringify(ProjectId);
        //    var result = AJAXCallWithResult("/api/IB_IssueDetails/GetTaskTypes", param, false);
        //    if (result != undefined) {
        //        var objCbo1 = document.getElementById("cboTaskType");
        //        if (objCbo1 != null) {
        //            $("#cboTaskType option").remove();

        //            for (var i = 0; i < result.length; i++) {
        //                var ObjStatus = result[i];
        //                var objOption = document.createElement("OPTION");
        //                objCbo1.options.add(objOption);
        //                objOption.text = ObjStatus.TaskType;
        //                objOption.value = ObjStatus.TaskTypeID;
        //            }
        //            AppendOptioncbo("TaskType", "");
        //        }
        //    }
        //}

        function GetTaskTypesAddNew(TaskID) {
            var data = [ProjectID, 0];
            //Added by Dipali V On 4th April 2023 For Validateheaders
            var data = {
                ProjectId: ProjectID,
                Data: 0
            };
            //End of Comment by Rehan C for Version Upgrade Issues on 13th Feb 2023
            var param = JSON.stringify(data);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetTaskTypes", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById(TaskID);
                if (objCbo1 != null) {
                    $(TaskID).empty();

                    for (var i = 0; i < result.length; i++) {
                        var ObjStatus = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.TaskType;
                        objOption.value = ObjStatus.TaskTypeID;
                    }
                    if (defaultTaskType != '') {
                        //$("#"+TaskID).val(defaultTaskType).change();
                        //$("select#" + TaskID + " option[value='" + GetDefaultTaskType + "']").attr('selected', 'selected');
                        $("#" + TaskID + " option:contains(" + defaultTaskType + ")").prop('selected', true);
                    }
                }
            }
        }

        function GetDefaultTaskType() {
            //debugger;
            //var data = [ProjectID, IssueID];
            //Added by Rehan C for Version Upgrade Issues on 13th Feb 2023
            var data = {
                ProjectId: ProjectID,
                IssueID: IssueID
            };
            //End of Comment by Rehan C for Version Upgrade Issues on 13th Feb 2023
            var param = JSON.stringify(data);

            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetDefaultTaskTypes", param, false);
            if (result != undefined) {

                if (result[0] != undefined) {

                    defaultTaskType = result[0].TaskType;

                }
            }
        }

        //function GetSubTaskTypes(TaskTypeID) {
        //    var Data = [ProjectID, TaskTypeID];
        //    var param = JSON.stringify(Data);
        //    var result = AJAXCallWithResult("/api/IB_IssueDetails/GetSubTaskTypes", param, false);
        //    if (result != undefined) {
        //        var objCbo1 = document.getElementById("cboTaskSubType");
        //        if (objCbo1 != null) {
        //            $("#cboTaskSubType option").remove();

        //            for (var i = 0; i < result.length; i++) {
        //                var ObjStatus = result[i];
        //                var objOption = document.createElement("OPTION");
        //                objCbo1.options.add(objOption);
        //                objOption.text = ObjStatus.SubTaskType;
        //                objOption.value = ObjStatus.SubTaskTypeID;
        //            }
        //            AppendOptioncbo("SubTaskType", "");
        //        }
        //    }
        //}

        //function GetSubTaskTypesAddNew(TaskTypeID, SubTaskID) {
        //    var Data = [ProjectID, TaskTypeID];
        //    var param = JSON.stringify(Data);
        //    var result = AJAXCallWithResult("/api/IB_IssueDetails/GetSubTaskTypes", param, false);
        //    if (result != undefined) {
        //        var objCbo1 = document.getElementById(SubTaskID);
        //        $("#" + SubTaskID).find('option').not(':first').remove();;

        //        for (var i = 0; i < result.length; i++) {
        //            var ObjStatus = result[i];
        //            var objOption = document.createElement("OPTION");
        //            objCbo1.options.add(objOption);
        //            objOption.text = ObjStatus.SubTaskType;
        //            objOption.value = ObjStatus.SubTaskTypeID;
        //        }
        //    }
        //}

        function GetFiledsForHistory(IssueID) {
            var param = JSON.stringify(IssueID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetFiledsForHistory", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById("cboSelectFields");
                $("#cboSelectFields option").remove();

                for (var i = 0; i < result.length; i++) {
                    var ObjStatus = result[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjStatus.FieldName;
                    objOption.value = ObjStatus.FieldName;
                }
                //Added & commented By dipali v On 10th Sep 2019 For Placeholder
                //AppendOptioncbo("SelectFields","");
                AppendOptioncbo("SelectFields", "Field");
                //End of Added & commented By dipali v On 10th Sep 2019 For Placeholder
            }
        }
    </script>

    <script>
        var flag;
        var flag1 = "";
        var customerid;
        var SelectedCustomerID;
        var ProductVersionID;
        var commonProperty;
        var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";
        var activerow = new Array();

        function Query_OnClick(queryid, HasAccess) {
            if (HasAccess == "True") {
                HasAccess = 1;
            }
            else {
                HasAccess = 0;
            }
            window.location.href = "../../HelpdeskEnhancement/Request/CRM_RequestDetails_UnCategorised.aspx?Mode=EDIT&FromWhere=DB&PageNumber=null&PageFlag=DefaultSR&LoadFilterID= null&StatusFilterID=null&DateFilterID=null&QueryID=" + queryid + "&QueryEditAccess=" + HasAccess;
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
            var commonProperty = commonproperty;
            ////get project flag and stored variable Project_Flag
            var param = JSON.stringify(commonProperty);
            var result = AJAXCallWithResult("/api/IB_AddNewIssue/GetLayoutProjectFlag", param, false);
            if (result != undefined) {
                Project_Flag = result[0];
                IsIssueSLAApplicable = result[1];
                // alert(IsIssueSLAApplicable);
                layoutid = result[2];
                MaxRows = result[3];
                MaxCols = result[4];
                //Added By Dipali V On 18th May 2020 For Issue ID 24448
                if (IsIssueSLAApplicable == false) {
                    $("#lisla").css('display', 'none');
                } else {
                    $("#lisla").css('display', 'block');
                }
                //End of Added By Dipali V On 18th May 2020 For Issue ID 24448
            }

            CreateTable(MaxRows, MaxCols);
            ////this is used for ploat coomon control 
            ////get the list of Issue layout details 

            var roleid = "<%= Session("intPostID").ToString() %>";
            var LayoutControl = { ProjectId: projectId, RoleId: parseInt(roleid), Type: Typeproject, Mode: "Edit" };
            var param = JSON.stringify(LayoutControl);
            var result = AJAXCallWithResult("/api/IB_AddNewIssue/IssueControlLists", param, false);
            if (result != undefined) {
                var res = result[0];
                //if (res.ResultFlag != undefined) {
                //    if (res.ResultFlag == true) {
                //        alert("input parameter have use special charcter");
                //    }
                //    else {
                Layoutdetails = result;
                ////create array for sored value .this value will use for condtion check or this value are related to control filed 

                        ListFiled = ["Description", "Summary", "ReportedDate", "ReportedTime", "ReportedBy", "Type", "SubType", "Status", "Release", "Iteration", "UserStory", "StatusChangeDate", "StatusChangeTime", "DeliverableID", "Priority", "Severity", "Complexity", "RootCauseID", "ModuleName", "ChangeRequestName", "CodedByName", "ReportedInVersion", "CorrectedInVersion", "Phase", "FoundInPhase", "FixedInPhase", "ImportID", "CustomerIssueID", "ShowToCustomer", "Hardware", "OS", "Kernel", "AssignToName"];
               
                        for (var i = 0; i < result.length; i++) {
                            var layoutcontrolobject = result[i];

                            ////this is used for check from output layoutcontrolobject.FieldName value exist or not in ListFiled array
                            //// this is creatd instead of many if else condtion or switch case .this is used for increse code resubality and reduce code complicity
                            if (ListFiled.indexOf(layoutcontrolobject.FieldName) > -1) {

                                ////this is declare for strod control prefix like if we wolud ploat text box control then this id will txtDeDescription
                                //// #txt= textbox,#dt=Datetime/calender,#cbo=droup down list/select tag,
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
                                     //Added By Dipali V On 22nd Nov 2021 For Disabled Control
                            layoutcontrolobject.ReadonlyEditMode = true;
                             //End of Added By Dipali V On 22nd Nov 2021 For Disabled Control


                                } 
                                
                                
                                
                                else if (layoutcontrolobject.FieldName == "StatusChangeDate" || layoutcontrolobject.FieldName == "StatusChangeTime") {
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
                                //    //debugger;
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
                             // debugger;
                            //Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by
                                    if (layoutcontrolobject.FieldName == "ReportedBy") {
                                        layoutcontrolobject.ReadonlyEditMode = true;

                                    }
                           //End of Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by
                            
                                }
                                
                                ////this funtion used for  ploating common control pass some parameter
                                //Commented And Added By Usha Pandit On 05.06.2020 For getting field caption
                                //CommonPloat(cntrlprefix, layoutcontrolobject.FieldName, layoutcontrolobject.Active, layoutcontrolobject.ReadonlyEditMode, layoutcontrolobject.ControlWidth, layoutcontrolobject.Mandatory, layoutcontrolobject.RowNo, layoutcontrolobject.ColumnNo);
                                CommonPloat(cntrlprefix, layoutcontrolobject.FieldName, layoutcontrolobject.Active, layoutcontrolobject.ReadonlyEditMode, layoutcontrolobject.ControlWidth, layoutcontrolobject.MandatoryInEdit, layoutcontrolobject.RowNo, layoutcontrolobject.ColumnNo, layoutcontrolobject.UserFriendlyName, layoutcontrolobject.EditMode);//,layoutcontrolobject.EditMode
                                //End Of Added By Usha Pandit On 05.06.2020 For getting field caption
                            } else {
                                continue;
                            }
                        }
                    //}
                //}
            }

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
        function CommonPloat(cntrlId, FieldName, Active, ReadOnly, ControlWidth, Mandatory, row, column, userfriendlyname, EditMode) {
            //End Of Added By Usha Pandit On 05.06.2020 For getting field caption

            ////this is used for custom create div id and label id common filed control 
            //// the div id strate with div and label id is start with lbl
            console.log(userfriendlyname, Mandatory);
            var divId = "#div" + FieldName;
            var lblId = "#lbl" + FieldName;

            ////this is use for custom create control id that mean if we use textbox, dorpdown,datetimepicker etc .
            /// cntrlId is prefix of control id
            var controlId = cntrlId + FieldName;
            //debugger;
           if (Active == true && EditMode == true) {
          //  if (Active == true) {
                var tablepos = "#r" + row + "c" + column;
                $(divId).show();

                if (ReadOnly == true) {
                    $(controlId).attr("disabled", true);
                } else {
                    $(controlId).attr("disabled", false);
                }
                if (ControlWidth > 0) {
                    $(controlId).css('width', ControlWidth);
                }
                //debugger;


                //Added By Usha Pandit On 05.06.2020 For setting field caption
                if (userfriendlyname != "" && userfriendlyname != null && userfriendlyname != undefined) {
                    //Added By Chetan M on 26 May 2021 for change caption issue
                    if (userfriendlyname == 'Iteration') {
                        userfriendlyname = 'Sprint';
                    }
                    //End of Added By Chetan M on 26 May 2021 for change caption issue
                    $(lblId).text(userfriendlyname);
                    //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                    if (lblId == "#lblCodedByName") {
                        $('#cboCodedByName > option:first-child')
                            .text("Select " + userfriendlyname);
                    }
                    if (lblId == "#lblFoundInPhase") {
                        $('#cboFoundInPhase > option:first-child')
                            .text("Select " + userfriendlyname);
                    }
                    if (lblId == "#lblPhase") {
                        $('#cboPhase > option:first-child')
                            .text("Select " + userfriendlyname);
                    }
                    if (lblId == "#lblFixedInPhase") {
                        $('#cboFixedInPhase > option:first-child')
                            .text("Select " + userfriendlyname);
                    }
                    //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                    //    alert(divid);
                }
                //End Of Added By Usha Pandit On 05.06.2020 For setting field caption
                 //Commented & Added By Dipali V On 6th April 2023 For Check Mandatory in edit
               if (Mandatory == true || Mandatory == "True") {
                     //End of Commented & Added By Dipali V On 6th April 2023 For Check Mandatory in edit
                    ////create custom madatory id 
                    var requeridId = "Mandatory" + FieldName;
                    var mandatoryid = "#" + requeridId;
                    if ($(mandatoryid).length > 0) {

                    } else {
                        var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                        $(lblId).append(lblval);
                    }
                }

                ////Added By Usha Pandit On 05.06.2020 For setting field caption
                //if (userfriendlyname != "" && userfriendlyname != null && userfriendlyname != undefined) {
                //    //$(lblId).text(userfriendlyname);
                //}                  
                ////End Of Added By Usha Pandit On 05.06.2020 For setting field caption
                
                if (row != 0 || column != 0) {
                    value1 = $(divId).clone();
                    $(tablepos).append(value1);
                    $(tablepos).append(value1);
                    if (activerow.indexOf(row) == -1) {
                        activerow.push(row);
                        //console.log(row);
                    }
                }
            }
            else {
                $(divId).hide();
            }
            if (FieldName == "DeliverableID") {
                if (Active == true) {
                    $('#liConvertToDel').show();
                }
                else {
                    $('#liConvertToDel').hide();
                }
            }
           // debugger;
            //AppendOptioncbo(FieldName, userfriendlyname);
        }

        function CreateTable(rows, columns) {
            var strtablebind = "";
            for (var i = 1; i < rows + 1; i++) {
                strtablebind += " <div class='row ' " + "id=" + "r" + i + "  >";
                for (var j = 1; j < columns + 1; j++) {
                    //Commented And Added by imran on 11-02-2022 Overlap the Textarea on textbox
                    strtablebind += "<div class='col-md-4'" + "id=" + "r" + i + "c" + j + "> </div>";
                    //strtablebind += "<div class='col-md-6'" + "id=" + "r" + i + "c" + j + "> </div>";
                    //End Of Comment by imran on 11-02-2022
                }
                strtablebind += "</div>";
            }
            //$("#controlploat").after("<div id='controlploattable'  >" + strtablebind + "</div>");
            $("#controlploat").after("<div id='controlploattable'></div>");
            $("#controlploattable").html(strtablebind);
        }

        function getCustomFieldsMaxRowColCount(projectId) {
            var ret = false;
            var ProjectID = parseInt(projectId);
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetCustomFieldMasterRowNumber", param, false);
            if (result != undefined) {
                CreateCustomFieldTable(result[0], result[1]);
                ret = true;
            }
            return ret;
        }

        function CreateCustomFieldTable(rows, columns) {
            var strtablebind = "";
            for (var i = 1; i < rows + 1; i++) {
                strtablebind += " <div class='row ' " + "id=" + "custr" + i + "  >";
                for (var j = 1; j < columns + 1; j++) {
                    //Commented And Added by imran on 11-02-2022 Overlap the Textarea on textbox
                    //strtablebind += "<div class='col-md-4'" + "id=" + "custr" + i + "c" + j + "> </div>";
                    strtablebind += "<div class='col-md-6'" + "id=" + "custr" + i + "c" + j + "> </div>";
                    //End by imran on 11-02-2022 Overlap the Textarea on textbox
                }
                strtablebind += "</div>";
            }
            $("#CustomFieldsControl").html(strtablebind);
        }

        function getExtendedCustomFieldsMaxRowColCount(projectId) {
            var ret = false;
            var ProjectID = parseInt(projectId);
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetExtendedCustomFieldRowNumber", param, false);
            if (result != undefined) {
                //Commented and added by imran 28-10-2021
                //CreateExtendedCustomFieldTable(result[0], result[1]);
                //ret = true;
                if (result[0] !== 0 && result[1] !== 0) {
                    CreateExtendedCustomFieldTable(result[0], result[1]);
                    ret = true;
                }
                //End Comment by imran 28-10-2021
            }
            return ret;
        }

        function CreateExtendedCustomFieldTable(rows, columns) {
            var strtablebind = "";
            for (var i = 1; i < rows + 1; i++) {
                strtablebind += " <div class='row ' " + "id=" + "excustr" + i + "  >";
                for (var j = 1; j < columns + 1; j++) {
                    strtablebind += "<div class='col-md-4'" + "id=" + "excustr" + i + "c" + j + "> </div>";
                }
                strtablebind += "</div>";
            }
            $("#ExtendedCustomFieldsControl").html(strtablebind);
        }

        function deleterow(activerow1, MaxRows1) {
            for (var i = 1; i < MaxRows1; i++) {
                if (activerow1.indexOf(i) == -1) {
                    $("#r" + i).remove();
                }
            }
        }

        function GetSubType(projectId, Type) {
            var newIssue = { ProjectId: parseInt(projectId), Type: Type };
            var param = JSON.stringify(newIssue);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetSubType", param, false);
            if (result != undefined) {
                var res = result[0];
                //if (res.ResultFlag != undefined)
                //{
                //if (res.ResultFlag == true) {
                //    alert("input parameter have special charcter");
                //}

                var objCbo1 = document.getElementById("cboSubType");
                //Added By Dipali V On 5th April 2024 for clear Dropdown 
                 $("#cboSubType option").remove();
                //End of Added By Dipali V On 5th April 2024 for clear Dropdown
                for (var i = 0; i < result.length; i++) {
                    var Objresult = result[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = Objresult.FieldName;
                    objOption.value = Objresult.FieldID;
                }
               // debugger;
                AppendOptioncbo("SubType", "Sub Type");
                //if (SubTypeDetails != "") {
                //    //$("select#cboSubType option:contains(" + SubTypeDetails + ")").attr('selected', 'selected');
                //    $("select#cboSubType option[value='" + SubTypeDetails + "']").remove();
                //    $("select#cboSubType option:selected").text(SubTypeDetails);
                //    $("select#cboSubType option:selected").val(SubTypeDetails);
                //}
                if (SubTypeDetails != "") {
                    //Commented and added Dipali V On 9th Nov 2021 For Get Proper Data
                    //$("select#cboType option:contains(" + Typeproject + ")").attr('selected', 'selected');
                    $("#cboSubType").val(SubTypeDetails);
                    //End of Commented and added Dipali V On 9th Nov 2021 For Get Proper Data
                }
                //}
            }
        }

        ////get Status list and this list bind  on status droup down list
        function GetStatus(projectId, Type, RoleId) {

            var newIssue = { ProjectId: parseInt(projectId), Type: Type, RoleId: RoleId, Status: (Status != "" ? Status : "") };
            var param = JSON.stringify(newIssue);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetStatus", param, false);
            if (result != undefined) {

                var res = result[0];
                //if (res.ResultFlag == true) {
                //    alert("input parameter have special charcter");
                //}
                //else {
                var objCbo1 = document.getElementById("cboStatus");
                //Added By Dipali V On 5th April 2024 for clear Dropdown 
                $("#cboStatus option").remove();
                //End of Added By Dipali V On 5th April 2024 for clear Dropdown
                for (var i = 0; i < result.length; i++) {
                    var ObjStatus = result[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjStatus.FieldName;
                    objOption.value = ObjStatus.FieldID;
                }

                AppendOptioncbo("Status", "");
                if (Status != "") {
                    globalStatus = Status;
                    //Commented & Added By Dipali V On 9th Nov 2021 To Get Bind Proper Data
                    //Commented And Added By Usha Pandit On 07.01.2020 For selecting correct Status value
                    $("select#cboStatus option:contains(" + Status + ")").attr('selected', 'selected');
                    //$("select option[value='" + Status + "']").attr("selected", "selected");
                    //End Of Added By Usha Pandit On 07.01.2020 For selecting correct Status value
                    // }
                }
            }
        }

        //// this function use for check condtion product filed flag if this is true then show div of product field otherwise hide.
        function getProductDevelopmentProject(projectId) {
            var newIssue = { ProjectId: parseInt(projectId) };
            var param = JSON.stringify(newIssue);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetProductExecutionProject", param, false);
            if (result != undefined) {
                if (result == true) {
                    $('#boxbodyProductFields').show();
                    $('#divProductFields').show();
                    $('#rowProductFields').show();
                } else {
                    $('#boxbodyProductFields').hide();
                    $('#divProductFields').hide();
                    $('#rowProductFields').hide();
                }
            }
        }

        var ValidationFieldsName = new Array();
        var ValidationFieldID = new Array();
        var ValidationRules = new Array();
        // added By Chetan M On 27th Mar 2020 For Issue ID 23059
        var MaxlengthValueArray = new Array();
        var MinValueArray = new Array();
        var MaxValueArray = new Array();
        //End Of added By Chetan M On 27th Mar 2020 For Issue ID 23059
        //Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
        var ExtMaxlengthValueArray = new Array();
        var ExtMinValueArray = new Array();
        var ExtMaxValueArray = new Array();
        //End Of Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
        ////this function used for ploating custom fields like  Department,Date etc
        //Added by imran 28-10-2021
        var CustomFieldNames = new Array();
        //Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
        var ValidationFieldIDSpecialChar = new Array();
        var ValidationFieldNameSpecialChar = new Array();
        //End of Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
        //End by imran 28-10-2021
        function PloatCustomFields(projectId, type, roleId, loginType, userId) {
            var strHTML = "";
            //var commonProp = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType };
           // var customFiled = { commonProperty: commonProp, Type: type };
            var customFiled = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType, Type: type };
            var param = JSON.stringify(customFiled);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/PloatCustomFiled", param, false);
            if (result != undefined) {
                if (result.length == 0) {
                    strHTML = "";
                    strHTML += "<label class='control-label'> No custom fields have been defined for this project.  </label>";
                    $("#CustomFieldsControl").append(strHTML);
                }

                for (var i = 0; i < result.length; i++) {
                    var CustomFiledObj = result[i];
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

                    var custCon = "#custr" + CustomFiledObj.RowNumber + "c" + CustomFiledObj.ColumnNumber;
                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldCombo") !== -1) {
                        strHTML = "";
                        strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label' id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " : </label>";
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {
                            //Added by imran 28-10-2021
                            CustomFieldNames.push(CustomFiledObj.DatabaseFieldName);
                            //End Comment by imran 28-10-2021
                            strHTML += "<select class='form-control' id='cbo" + CustomFiledObj.DatabaseFieldName + "'</select>";
                        }
                        else {
                            //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                            strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                            //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available

                        }
                        strHTML += "</div>";
                        //$("#CustomFieldsControl").append(strHTML);
                        $(custCon).html(strHTML);

                        //Added by imran on 21-02-2022 to set combo default value
                        GetCustomFiledComboboxValues(CustomFiledObj.DatabaseFieldName, ProjectID, CustomFiledObj.UserGivenCaption);
                        //end of comment by imran on 21-02-2022
                                               
                        var fieldid = "#cbo" + CustomFiledObj.DatabaseFieldName;
                        if (CustomFiledObj.DefaultValue != 0) {
                            //$("select#cbo" + CustomFiledObj.DatabaseFieldName + "option:contains(" + CustomFiledObj.DefaultValue + ")").prop('selected', true);
                           $("#cbo" + CustomFiledObj.DatabaseFieldName).val(CustomFiledObj.DefaultValue); 
                        }                       

                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {//Added By Dipali V On 2nd Sep 2020
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                        }
                        //AppendOptioncbo(cbo); 
                        //added by dipali v On 9th Sep for placeholder to custom fileds
                        //AppendOptioncbo(CustomFiledObj.DatabaseFieldName, CustomFiledObj.UserGivenCaption)
                        //End of added by dipali v On 9th Sep for placeholder to custom fileds
                        var lblId = "#lbl" + CustomFiledObj.DatabaseFieldName;
                        var Mandatory = CustomFiledObj.ValidationRules;

                        if (Mandatory.indexOf("1,") > -1) {
                            ////create custom madatory id 
                            var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                            var mandatoryid = "#" + requeridId;
                            if ($(mandatoryid).length > 0) {

                            } else {
                                var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                                $(lblId).append(lblval);
                            }
                        }

                        //Commented by imran on 21-02-2022
                       // GetCustomFiledComboboxValues(CustomFiledObj.DatabaseFieldName, ProjectID, CustomFiledObj.UserGivenCaption);
                    }

                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldText") !== -1) {
                        //Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
                        var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                        ValidationFieldIDSpecialChar.push(fieldid);
                        ValidationFieldNameSpecialChar.push(CustomFiledObj.UserGivenCaption);
                            //Endof Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
                        strHTML = "";
                        //Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
                        var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                        ValidationFieldIDSpecialChar.push(fieldid);

                        ValidationFieldNameSpecialChar.push(CustomFiledObj.UserGivenCaption);
                            //Endof Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
                        strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label' id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " :</label>" +
                            "</br>";
                        if (CustomFiledObj.DatabaseFieldName.indexOf("Area") !== -1) {
                            if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                //Added by imran 28-10-2021
                                CustomFieldNames.push(CustomFiledObj.DatabaseFieldName);
                                //End Comment by imran 28-10-2021
                                strHTML += "<textarea rows='3' cols='25' id='txt" + CustomFiledObj.DatabaseFieldName + "'value=" + CustomFiledObj.DefaultValue + ">" +
                                    "</textarea>";
                            }
                            else {
                                //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                                strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                                //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available

                            }
                        }
                        else {
                            if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                //Added by imran 28-10-2021
                                CustomFieldNames.push(CustomFiledObj.DatabaseFieldName);
                                //End Comment by imran 28-10-2021
                               
                                strHTML += "<input type='text' class='form-control' autocomplete='off' id='txt" + CustomFiledObj.DatabaseFieldName + "'" //" style='width:200px' "
                                   + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else {
                                //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                                strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                                //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                            }
                        }
                        strHTML += "</div>";
                        //$("#CustomFieldsControl").append(strHTML);
                        $(custCon).html(strHTML);

                        var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                        //To set the default value to the TextArea and TextBox
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            //$(fieldid).html(CustomFiledObj.DefaultValue);
                            $(fieldid).val(CustomFiledObj.DefaultValue);
                        }

                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {//Added By Dipali V On 2nd Sep 2020
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                        }

                        var lblId = "#lbl" + CustomFiledObj.DatabaseFieldName;
                        var Mandatory = CustomFiledObj.ValidationRules;

                        if (Mandatory.indexOf("1,") > -1) {
                            ////create custom madatory id 
                            var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                            var mandatoryid = "#" + requeridId;
                            if ($(mandatoryid).length > 0) {

                            } else {
                                var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                                $(lblId).append(lblval);
                            }
                        }
                        continue;
                    }

                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldDate") !== -1) {
                        strHTML = "";
                        strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label'id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " : </label>";
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {

                            //Added by imran 28-10-2021
                            CustomFieldNames.push(CustomFiledObj.DatabaseFieldName);
                            //End Comment by imran 28-10-2021
                            strHTML += "<div class='input-group'><input type='text' class='form-control' autocomplete='off' id='dt" + CustomFiledObj.DatabaseFieldName + "'" //" style='width:200px' "
                                + " value=" + CustomFiledObj.DefaultValue + ">";
                            strHTML += "<span class='input-group-btn'><button class='btn btncalendar' type='button'><i class='fas fa-calendar-alt'></i></button></span></div>";
                        }
                        else {
                            //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                            strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                            //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available

                        }
                        strHTML += "</div>";
                        //$("#CustomFieldsControl").append(strHTML);
                        $(custCon).html(strHTML);

                        var fieldid = "#dtext" + CustomFiledObj.DatabaseFieldName;
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            $(fieldid).val(CustomFiledObj.DefaultValue);
                        }

                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {//Added By Dipali V On 2nd Sep 2020
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationFieldsName.push(UserGivenCaption);
                                ValidationFieldID.push(fieldid);
                                ValidationRules.push(ValidationRulesnew);
                            }
                        }

                        var lblId = "#lbl" + CustomFiledObj.DatabaseFieldName;
                        var Mandatory = CustomFiledObj.ValidationRules;

                        if (Mandatory.indexOf("1,") > -1) {
                            ////create custom madatory id 
                            var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                            var mandatoryid = "#" + requeridId;
                            if ($(mandatoryid).length > 0) {

                            } else {
                                var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                                $(lblId).append(lblval);
                            }
                        }

                        CustomfiledDatePicker(CustomFiledObj.DatabaseFieldName);
                        continue;
                    }
                }
            }

            SetValidationToCustomFields();
        }

        //Added by Dipali V On 6th July 2020 For Get default value
        function DefaultValue(projectId, Type, event) {
       

            var Parameter = {
                ProjectId: projectId,
                Type: Type
            }
            //var Parameter = JSON.stringify({ 'Parameter': DefVal})
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
                    if (result[0] != "") {
                        if ($("#cboType  option:selected").val() == "0") {
                            $("#cboType option:contains(" + result[0] + ")").prop('selected', true);
                            if (event == "PageLoad") {
                                // Type_OnChange(result[0]);
                            }
                        }
                    }
                  
                    if (result.length >= 7) {
                        if ($("#cboSubType  option:selected").val() == "0") {
                            $("#cboSubType").val(result[1] == null ? 0 : result[1]);
                        }
                        //Added By Dipali V On 3rd April 2020 For Status Binding Issues
                        if ($("#cboStatus  option:selected").val() == "0") {
                            if ($("#cboStatus option:contains(" + result[2] + ")").length != 0) {
                                $("#cboStatus").val(result[2] == null ? 0 : result[2]);
                            }
                        }
                        //Added by Chetan M on 8 Jan 2021 for Issue Fixing
                        if (event == "OnChange") {
                            $("#cboSubType").val(result[1] == null ? 0 : result[1]);
                            $("#cboStatus").val(result[2] == null ? 0 : result[2]);
                        }
                        //End of Added by Chetan M on 8 Jan 2021 for Issue Fixing
                        //End of Added By Dipali V On 3rd April 2020 For Status Binding Issues
                        //} else {

                        //    AppendOptioncbo("Status", "");
                        //}
                       
                        if ($("#cboSeverity  option:selected").val() == "0") {
                            if (document.getElementById("cboSeverity").innerHTML.indexOf(result[5]) != -1) {
                                $("#cboSeverity").val(result[5] == null ? 0 : result[5]);
                            }
                            else {
                                if (Severity == "") {
                                    $("#cboSeverity").val("0")
                                } else {
                                    $("#cboSeverity").val(Severity)
                                }
                               
                            }
                        }
                       
                        //if ($("#cboAssignToName  option:selected").val() == "0") {
                        //    if (ResponsiblePersonName != 0) {
                        //        $("#cboAssignToName").val(ResponsiblePersonName).change()
                        //    }
                        //    else {
                        //        $("#cboAssignToName").val(result[3]).change();
                        //    }
                        //}
                        if (ResponsiblePersonName != 0) {

                            $("#cboAssignToName").val(ResponsiblePersonName).change()
                        }
                        else {
                            $("#cboAssignToName").val(result[3]).change();
                        }
                        //alert(result[4]);
                        if ($("#cboPriority  option:selected").val() == "0") {
                            $("#cboPriority").val(result[4] == null ? 0 : result[4]);
                        }
                        if ($("#cboComplexity  option:selected").val() == "0") {
                            $("#cboComplexity").val(result[6] == null ? 0 : result[6]).change();
                        }
                        if ($("#cboFoundInPhase  option:selected").val() == "0") {
                            $("#cboFoundInPhase").val(result[7] == null ? 0 : result[7]).change();
                        }
                    }
                    //alert(result[4]);
                    StopAjaxLoader("#bodyIssueDetails");
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }



        function SetValidationToCustomFields() {
            //alert(ValidationFieldsName);
            for (var i = 0; i < ValidationFieldsName.length; i++) {
                // alert(ValidationFieldsName[i]);
                var customField = {
                    FieldID: ValidationFieldID[i],
                    CustomFieldName: ValidationFieldsName[i],
                    CustomValidation: (ValidationRules[i]).toString()
                };
                var param = JSON.stringify(customField);
                var result = AJAXCallWithResult("/api/IB_BulkUpdate/GetValidationForCustomFields", param, false);
                if (result != undefined) {
                    for (var j = 0; j < result.length; j++) {
                        var ValidationObj = result[j];
                        if (ValidationMessage != "") {
                        }
                        ValidationMessage.push(ValidationObj.ValidationMessage);
                        ValidationValidateID.push(ValidationObj.ValidationID);
                        ValidationMessageFiled.push(ValidationObj.FieldID);
                        //ValidationMessageFieldName.push(ValidationObj.FieldName);
                        ValidationMessageFieldName.push(ValidationFieldsName[i]);

                    }
                }
            }
        }

        var ValidationMessageNew = new Array();
        function CustomFieldValidation() {
            var checkval = 0;
            //
            // alert(ValidationMessageFieldName);
            for (var i = 0; i < ValidationMessageFieldName.length; i++) {
                switch (ValidationValidateID[i]) {

                    case "1":
                        //For Blank
                        if (ValidationMessage[i].indexOf("blank") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != undefined && $(ValidationMessageFiled[i]).val().trim() == "") {
                                checkval = 1;
                                alertify.error(ValidationMessageFieldName[i] + ValidationMessage[i]);
                                $(ValidationMessageFiled[i]).focus()
                                return checkval;
                            }
                            else if (ValidationMessageFiled[i].indexOf('cboCustomField') > -1 && $(ValidationMessageFiled[i]).val() != undefined && $(ValidationMessageFiled[i]).val().trim() == "0") {
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
                            if ($(ValidationMessageFiled[i]).val() != undefined && $(ValidationMessageFiled[i]).val() != "") {
                                if (!isDate($(ValidationMessageFiled[i]).val())) {
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
                            if ($($(ValidationMessageFiled[i]).val() != undefined && ValidationMessageFiled[i]).val() != "") {
                                if (!isNumeric($(ValidationMessageFiled[i]).val())) {
                                    //Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    if (ValidationMessage[i].indexOf('!!!') > -1) {
                                        ValidationMessage[i] = ValidationMessage[i].replace("!!!", "in ");
                                    }
                                    //End of Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    checkval = 1;
                                    //Commented and Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    //alertify.error(ValidationMessage[i] + "" + ValidationMessageFieldName[i]);
                                    alertify.error(ValidationMessage[i] + "'" + ValidationMessageFieldName[i] + "' field");
                                    //End of Commented and Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
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
                                    alertify.error(ValidationMessage[i] + "'" + ValidationMessageFieldName[i] + "' field");
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
                                if (ValidationMessageFiled[i].indexOf('CustomFieldText') > -1) {

                                    for (var k = 0; k < MaxlengthValueArray.length; k++) {
                                        var DatabseFieldNameArray = MaxlengthValueArray[k].split("=");
                                        var DatabseFieldName = DatabseFieldNameArray[0];
                                        var MaxlengthValue = DatabseFieldNameArray[1];
                                        if (ValidationMessageFiled[i].indexOf(DatabseFieldName) > -1) {
                                            //$(ValidationMessageFiled[i]).val('<ID>', ValidationMessageFieldName[i]);

                                            if ($(ValidationMessageFiled[i]).val().length > MaxlengthValue) {
                                                checkval = 1;
                                                var validationMsg = ValidationMessage[i];
                                                validationMsg = validationMsg.replace('<ID>', ValidationMessageFieldName[i]);
                                                validationMsg = validationMsg.replace('<LENGTH>', MaxlengthValue);
                                                validationMsg = validationMsg.replace('<L>', $(ValidationMessageFiled[i]).val().length);
                                                validationMsg = validationMsg.replace('\r\n', "  ");
                                                alertify.error(validationMsg);
                                                $(ValidationMessageFiled[i]).focus()
                                                return checkval;
                                            }
                                        }
                                    }
                                }


                                //    if ($(ValidationMessageFiled[i]).attr("maxlength")) {
                                //        if ($(ValidationMessageFiled[i]).val().length > $(ValidationMessageFiled[i]).attr("maxlength")) {

                                //            checkval = 1;
                                //            alertify.error(ValidationMessage[i] + "" + ValidationMessageFieldName[i]);
                                //            $(ValidationMessageFiled[i]).focus()
                                //            return checkval;
                                //            //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                //        }

                                //    }
                                //End of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                            }
                        };
                        break;
                    case "13":
                        //For Positive Number
                        if (ValidationMessage[i].indexOf("positive numeric") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "") {
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
                                //Commented by Nilesh Pingale on 25 Jul 2020 Issue ID : 23059
                                // if ($(ValidationMessageFiled[i]).attr("MinValue")) {
                                // if ($(ValidationMessageFiled[i]).val() < $(ValidationMessageFiled[i]).attr("MinValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MinValue")) {
                                //End of Commented by Nilesh Pingale on 25 Jul 2020 Issue ID : 23059

                                //Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
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

                                //if ($(ValidationMessageFiled[i]).attr("MinValue")) {
                                //    if ($(ValidationMessageFiled[i]).val() < $(ValidationMessageFiled[i]).attr("MinValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MinValue")) {

                                //        checkval = 1;
                                //        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MinValue"));
                                //        $(ValidationMessageFiled[i]).focus()
                                //        return checkval;
                                //        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                //    }

                                //}
                                //End of Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                            }
                            //Commented by Nilesh Pingale on 25 Jul 2020 Issue ID : 23059
                            //}
                            //}
                            //End of Commented by Nilesh Pingale on 25 Jul 2020 Issue ID : 23059
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

                                            if (parseInt($(ValidationMessageFiled[i]).val()) > parseInt(MaxValue)) {
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

        function GetCustomFiledComboboxValues(DatabaseFieldName, ProjectID, UserGivenCaption) {
            var commonProp = { ProjectId: parseInt(ProjectID) };
            //var customField = { commonProperty: commonProp, DatabaseFieldName: DatabaseFieldName };
            var customField = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId,
                DatabaseFieldName: DatabaseFieldName
            };
            var param = JSON.stringify(customField);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetCustomFiledComboboxValues", param, false);
            if (result != undefined) {
                //debugger;
                var cboName = "#cbo" + DatabaseFieldName;
                $(cboName).html('');
                //debugger;
                for (var i = 0; i < result.length; i++) {
                    var list = result[i];
                    //debugger;
                    //var s = ('<option value=' + list.UniqueID + ' >' + list.FieldName + '</option>');
                    //Added By Rutuja D. on 4 Jun 2021 For Added Extra Space
                    var s = ("<option value='" + list.FieldID.trim() + "'>" + list.FieldName + "</option>");
                    //End of Added By Rutuja D. on 4 Jun 2021 For Added Extra Space

                    //var cboName = "#cbo" + DatabaseFieldName;
                    $(cboName).append(s);
                }
                AppendOptioncbo(DatabaseFieldName, UserGivenCaption);
            }
            //alert(UserGivenCaption);
            if (DatabaseFieldName == "CustomFieldCombo2") {
                GetCustomer(ProjectID, UserGivenCaption);
            }
        }

        var ValidationExtFieldsName = new Array();
        var ValidationExtFieldID = new Array();
        var ValidationExtRules = new Array();
        ////this function used for ploating extended custom control like  Department,Date etc
        //Added by imran on 28-10-2021
        var CustomFieldNamesExt = new Array();
        //End Comment by imran 28-10-2021

        function PloatExtendedCustomFields(projectId, type, roleId, loginType, userId) {
            var strHTML = "";
            //var commonProp = { ProjectId: parseInt(projectId), RoleId: roleId, EmployeeId: userId, LoginType: loginType };
            var customField = {
                ProjectId: parseInt(projectId),
                RoleId: roleId,
                EmployeeId: userId,
                LoginType: loginType,
                Type: type
            };
            var param = JSON.stringify(customField);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/PloatExtendedCustomFileds", param, false);
            if (result != undefined) {
                if (result.length == 0) {
                    strHTML = "";
                    strHTML += "<label class='control-label'> No extended custom fields have been defined for this project.  </label>";
                    $("#ExtendedCustomFieldsControl").append(strHTML);
                }
                //
                for (var i = 0; i < result.length; i++) {
                   
                    var CustomFiledObj = result[i];
                    //Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                    if (CustomFiledObj.MaxLength != null && CustomFiledObj.MaxLength != "") {
                        ExtMaxlengthValueArray.push(CustomFiledObj.DatabaseFieldName + "=" + CustomFiledObj.MaxLength);
                    }
                    if (CustomFiledObj.MinValue != null && CustomFiledObj.MinValue != "") {
                        ExtMinValueArray.push(CustomFiledObj.DatabaseFieldName + "=" + CustomFiledObj.MinValue);
                    }
                    if (CustomFiledObj.MaxValue != null && CustomFiledObj.MaxValue != "") {
                        ExtMaxValueArray.push(CustomFiledObj.DatabaseFieldName + "=" + CustomFiledObj.MaxValue);
                    }
                    //End Of Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation

                    var excustCon = "#excustr" + CustomFiledObj.RowNumber + "c" + CustomFiledObj.ColumnNumber;
                    // debugger;
                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldCombo") !== -1) {
                        strHTML = "";
                        //debugger;
                        strHTML += "<div class='form-group' id='divext" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label' id='lblext" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " : </label>";
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {
                            //Added by imran 28-10-2021
                            CustomFieldNamesExt.push(CustomFiledObj.DatabaseFieldName);
                            //End by imran 28-10-2021
                            strHTML += "<select class='form-control ' id='cboext" + CustomFiledObj.DatabaseFieldName + "'" + //" style='width:200px'>" +
                                "</select>";
                        }
                        else {
                            //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                            strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                            //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                        }
                        strHTML += "</div>";
                        //$("#ExtendedCustomFieldsControl").append(strHTML);
                        //$("#ExtendedCustomFieldsControl").append("</br>");
                        $(excustCon).html(strHTML);

                        var fieldid = "#cboext" + CustomFiledObj.DatabaseFieldName;
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            $("select" + fieldid + "option:contains(" + CustomFiledObj.DefaultValue + ")").attr('selected', 'selected');
                        }
                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {//Added By Dipali V On 2nd Sep 2020
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationExtFieldsName.push(UserGivenCaption);
                                ValidationExtFieldID.push(fieldid);
                                ValidationExtRules.push(ValidationRulesnew);
                            }
                        }

                        var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;
                        var Mandatory = CustomFiledObj.ValidationRules;

                        if (Mandatory.indexOf("1,") > -1) {
                            ////create custom madatory id 
                            var requeridId = "Mandatoryext" + CustomFiledObj.DatabaseFieldName;
                            var mandatoryid = "#" + requeridId;
                            if ($(mandatoryid).length > 0) {

                            } else {
                                //Commented & Added By Rutuja D. 18 March 2020 For Disturbing allignment issueid = 23104
                                //var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                                //Added By Rutuja D. 21 April 2020 For Disturbing allignment
                                // var lblval = "<span id=" + requeridId + "  style='color:red; position:absolute; top:0; right:0;'>*</span>";
                                //Added By Dipali V 0n 12 may 2020 for issueid 24233
                                //var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red; position:absolute; top:0; right:1;'>*</span>";
                                var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red; top:0; right:1;'>*</span>";
                                //Added By Rutuja D. 21 April 2020 For Disturbing allignment
                                //End of Added By Dipali V 0n 12 may 2020 for issueid 24233
                                //End Commented & Added By Rutuja D. 18 March 2020 For Disturbing allignment issueid = 23104
                                $(lblId).append(lblval);
                            }
                        }
                        // debugger;
                        GetExtendedCustomFieldComboboxValues(CustomFiledObj.DatabaseFieldName, ProjectID, UserGivenCaption);
                    }

                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldText") !== -1) {
                        strHTML = "";
                        //Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
                        var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                        ValidationFieldIDSpecialChar.push(fieldid);

                        ValidationFieldNameSpecialChar.push(CustomFiledObj.UserGivenCaption);
                            //Endof Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields
                        strHTML += "<div class='form-group' id='divext" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label'id='lblext" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " :</label>" +
                            "</br>";
                        if (CustomFiledObj.DatabaseFieldName.indexOf("Area") !== -1) {
                            if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                //Added By Dipali V On 6th April 2023 For Textarea Saving Issue
                                CustomFieldNamesExt.push(CustomFiledObj.DatabaseFieldName);
                                  //End of Added By Dipali V On 6th April 2023 For Textarea Saving Issue
                                strHTML += "<textarea rows='3' cols='25' id='txtext" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    "</textarea>";
                            }
                            else {
                                //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                                strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                                //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                            }
                        }
                        else {
                            if (CustomFiledObj.IsCustomFieldAssigned == true) {
                                //Added by imran 28-10-2021
                                CustomFieldNamesExt.push(CustomFiledObj.DatabaseFieldName);
                                //End by imran 28-10-2021
                                strHTML += "<input type='text' class='form-control' autocomplete='off' id='txtext" + CustomFiledObj.DatabaseFieldName + "'" + //" style='width:200px' 
                                    " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else {
                                //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                                strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                                //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                            }
                        }
                        strHTML += "</div>";
                        //$("#ExtendedCustomFieldsControl").append(strHTML);
                        //$("#ExtendedCustomFieldsControl").append("</br>");
                        $(excustCon).html(strHTML);

                        var fieldid = "#txtext" + CustomFiledObj.DatabaseFieldName;
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            $(fieldid).html(CustomFiledObj.DefaultValue);
                        }

                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {//Added By Dipali V On 2nd Sep 2020
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationExtFieldsName.push(UserGivenCaption);
                                ValidationExtFieldID.push(fieldid);
                                ValidationExtRules.push(ValidationRulesnew);
                            }
                        }

                        var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;
                        var Mandatory = CustomFiledObj.ValidationRules;

                        if (Mandatory.indexOf("1,") > -1) {
                            ////create custom madatory id 
                            var requeridId = "Mandatoryext" + CustomFiledObj.DatabaseFieldName;
                            var mandatoryid = "#" + requeridId;
                            if ($(mandatoryid).length > 0) {

                            } else {
                                var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                                $(lblId).append(lblval);
                            }
                        }
                        continue;
                    }

                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldDate") !== -1) {
                        strHTML = "";
                        strHTML += "<div class='form-group' id=divext" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label'id='lblext" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " : </label>";
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {
                            //Added by imran 28-10-2021
                            CustomFieldNamesExt.push(CustomFiledObj.DatabaseFieldName);
                            //End by imran 28-10-2021
                            strHTML += "<div class='input-group'><input type='text' class='form-control' autocomplete='off' id='dtext" + CustomFiledObj.DatabaseFieldName + "'>"; //" style='width:200px'>";
                            strHTML += "<span class='input-group-btn'><button class='btn btncalendar' type='button'><i class='fas fa-calendar-alt'></i></button></span></div>"
                        }
                        else {
                            //Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                            strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><b><%= MyBase.GetResourceString("C_Not_Available") %></b> </span>";
                            //End Added By swapnagandha K. On 22 Oct 2019 To change Caption C_Not_Applicale to  C_Not_Available
                        }
                        strHTML += "</div>";
                        //$("#ExtendedCustomFieldsControl").append(strHTML);
                        //$("#ExtendedCustomFieldsControl").append("</br>");
                        $(excustCon).html(strHTML);

                        var fieldid = "#dtext" + CustomFiledObj.DatabaseFieldName;
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            $(fieldid).val(CustomFiledObj.DefaultValue);
                        }

                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.IsCustomFieldAssigned == true) {//Added By Dipali V On 2nd Sep 2020
                            if (CustomFiledObj.ValidationRules != 0) {
                                //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                                var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                                ValidationExtFieldsName.push(UserGivenCaption);
                                ValidationExtFieldID.push(fieldid);
                                ValidationExtRules.push(ValidationRulesnew);
                            }
                        }

                        var lblId = "#lblext" + CustomFiledObj.DatabaseFieldName;
                        var Mandatory = CustomFiledObj.ValidationRules;

                        if (Mandatory.indexOf("1,") > -1) {
                            ////create custom madatory id 
                            var requeridId = "Mandatoryext" + CustomFiledObj.DatabaseFieldName;
                            var mandatoryid = "#" + requeridId;
                            if ($(mandatoryid).length > 0) {

                            } else {
                                var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                                $(lblId).append(lblval);
                            }
                        }

                        var ExtendedCustomFieldDate = "ext" + CustomFiledObj.DatabaseFieldName;
                        CustomfiledDatePicker(ExtendedCustomFieldDate);
                        continue;
                    }
                }
            }
            SetValidationToExtCustomFields();
        }

        var ValidationMessageExtFieldName = new Array();
        var ValidationMessageExtField = new Array();
        var ValidationMessageExt = new Array();
        function SetValidationToExtCustomFields() {
            // 
            for (var i = 0; i < ValidationExtFieldsName.length; i++) {
                //Commented & Added By Dipali V On 6th April 2023 For Extended Cust Fileds 
                //var customField = { FieldID: ValidationExtFieldID[i], CustomFieldName: ValidationExtFieldsName[i], CustomValidation: ValidationExtRules[i] };

                var customField = {
                    FieldID: ValidationExtFieldID[i],
                    CustomFieldName: ValidationExtFieldsName[i],
                    CustomValidation: (ValidationExtRules[i]).toString()
                };
                 //End of Commented & Added By Dipali V On 6th April 2023 For Extended Cust Fileds 
                var param = JSON.stringify(customField);
                var result = AJAXCallWithResult("/api/IB_BulkUpdate/GetValidationForCustomFields", param, false);
                if (result != undefined) {
                    for (var j = 0; j < result.length; j++) {
                        var ValidationObj = result[j];

                        if (ValidationMessageExt != "") {

                        }
                        ValidationMessageExt.push(ValidationObj.ValidationMessage);
                        ValidationValidateExtID.push(ValidationObj.ValidationID);
                        ValidationMessageExtField.push(ValidationObj.FieldID);
                        ValidationMessageExtFieldName.push(ValidationObj.FieldName);
                    }
                }
            }
        }

        var ValidationMessageExtNew = new Array();
        function ExtCustomFieldValidation() {
            var checkval = 0;
            for (var i = 0; i < ValidationMessageExtFieldName.length; i++) {
                switch (ValidationValidateExtID[i]) {

                    case "1":
                        //For Blank
                        if (ValidationMessageExt[i].indexOf("blank") != -1) {
                            if ($(ValidationMessageExtField[i]).val() != undefined && $(ValidationMessageExtField[i]).val() == "") {
                                checkval = 1;
                                alertify.error(ValidationMessageExtFieldName[i] + ValidationMessageExt[i]);
                                $(ValidationMessageExtField[i]).focus()
                                return checkval;
                            }
                            else if (ValidationMessageExtField[i].indexOf('cboextCustomField') > -1 && $(ValidationMessageExtField[i]).val() != undefined && $(ValidationMessageExtField[i]).val() == "0") {
                                checkval = 1;
                                alertify.error(ValidationMessageExtFieldName[i] + ValidationMessageExt[i]);
                                $(ValidationMessageExtField[i]).focus()
                                return checkval;
                            }
                        }
                        break;

                    //For validate Date
                    case "2":
                        if (ValidationMessageExt[i].indexOf("Date") != -1) {
                            if ($(ValidationMessageExtField[i]).val() != undefined && $(ValidationMessageExtField[i]).val() != "") {
                                if (!isDate($(ValidationMessageExtField[i]))) {
                                    checkval = 1;
                                    alertify.error(ValidationMessageExt[i] + " For " + ValidationMessageExtFieldName[i]);
                                    $(ValidationMessageExtField[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;

                    //For  Number
                    case "3":
                        if (ValidationMessageExt[i].indexOf("numeric") != -1) {
                            if ($(ValidationMessageExtField[i]).val() != undefined && $(ValidationMessageExtField[i]).val() != "") {
                                if (!isNumeric($(ValidationMessageExtField[i]).val())) {
                                    //Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    if (ValidationMessageExt[i].indexOf('!!!') > -1) {
                                        ValidationMessageExt[i] = ValidationMessageExt[i].replace("!!!", "in ");
                                    }
                                    //End of Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    checkval = 1;
                                    //Commented and Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    //alertify.error(ValidationMessageExt[i] + "" + ValidationMessageExtFieldName[i]);
                                    alertify.error(ValidationMessageExt[i] + "'" + ValidationMessageExtFieldName[i] + "' field");
                                    //End of Commented and Added by Chetan M on 5 May 2021 for Sonata client login issue fixing
                                    $(ValidationMessageExtField[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;


                    case "9"://for Alphabets
                        if (ValidationMessageExt[i].indexOf("Alphabets") != -1) {
                            if (ValidationMessageExtField[i].indexOf("Area") != -1) {
                                var Condition = $(ValidationMessageExtField[i]).text();
                            }
                            else {
                                var Condition = $(ValidationMessageExtField[i]).val();
                            }
                            //Added By Usha Pandit On 18.05.2021 For correct validation alert
                            if (ValidationMessageExt[i].indexOf('!!!') > -1) {
                                ValidationMessageExt[i] = ValidationMessageExt[i].replace("!!!", "in ");
                            }
                            //End Of Added By Usha Pandit On 18.05.2021 For correct validation alert
                            if (Condition != "") {
                                var pattern = /^[a-zA-Z]+$/;
                                if (!pattern.test(Condition)) {
                                    checkval = 1;
                                    //Commented And Added By Usha Pandit On 18.05.2021 For correct validation alert
                                    //alertify.error(ValidationMessageExtFieldName[i] + " " + ValidationMessageExt[i]);
                                    alertify.error(ValidationMessageExt[i] + "'" + ValidationMessageExtFieldName[i] + "' field");
                                    //End Of Added By Usha Pandit On 18.05.2021 For correct validation alert
                                    $(ValidationMessageExtField[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;
                    case "12": //For Maxlength 
                        //Commented And Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                        //if (ValidationMessageExt[i].indexOf("Max") != -1) {
                        //    if ($(ValidationMessageExtField[i]).val() != "") {
                        //        if ($(ValidationMessageExtField[i]).attr("maxlength")) {
                        //            if ($(ValidationMessageExtField[i]).val().length > $(ValidationMessageExtField[i]).attr("maxlength")) {

                        //                checkval = 1;
                        //                alertify.error(ValidationMessageExt[i] + "" + ValidationMessageExtFieldName[i]);
                        //                $(ValidationMessageExtField[i]).focus()
                        //                return checkval;
                        //                //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                        //            }

                        //        }
                        //    }
                        //};
                        if (ValidationMessageExt[i].indexOf("Max") != -1) {
                            if ($(ValidationMessageExtField[i]).val() != "") {
                                //Commented and added By Chetan M On 27th Mar 2020 For Issue ID 23059
                                if (ValidationMessageExtField[i].indexOf('CustomFieldText') > -1) {

                                    for (var k = 0; k < ExtMaxlengthValueArray.length; k++) {
                                        var DatabseFieldNameArray = ExtMaxlengthValueArray[k].split("=");
                                        var DatabseFieldName = DatabseFieldNameArray[0];
                                        var MaxlengthValue = DatabseFieldNameArray[1];
                                        if (ValidationMessageExtField[i].indexOf(DatabseFieldName) > -1) {

                                            if ($(ValidationMessageExtField[i]).val().length > MaxlengthValue) {
                                                checkval = 1;
                                                var validationMsg = ValidationMessageExt[i];
                                                validationMsg = validationMsg.replace('<ID>', ValidationMessageExtFieldName[i]);
                                                validationMsg = validationMsg.replace('<LENGTH>', MaxlengthValue);
                                                validationMsg = validationMsg.replace('<L>', $(ValidationMessageExtField[i]).val().length);
                                                validationMsg = validationMsg.replace('\r\n', "  ");
                                                alertify.error(validationMsg);
                                                $(ValidationMessageExtField[i]).focus()
                                                return checkval;
                                            }
                                        }
                                    }

                                }
                            }
                        };
                        //End Of Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                        break;
                    case "13":
                        //For Positive Number
                        if (ValidationMessageExt[i].indexOf("positive numeric") != -1) {
                            if ($(ValidationMessageExtField[i]).val() != "") {
                                if ($(ValidationMessageExtField[i]).val() < 0) {

                                    checkval = 1;
                                    alertify.error(ValidationMessageExt[i] + "" + ValidationMessageExtFieldName[i]);
                                    $(ValidationMessageExtField[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;

                    case "15":     //For Special Char
                        if (ValidationMessageExt[i].indexOf("contain") != -1) {
                            if ($(ValidationMessageExtField[i]).val() != "") {
                                var regex = /^[0-9a-zA-Z\_]+$/;
                                var value = $(ValidationMessageExtField[i]).val();
                                if (regex.test(value) == false) {

                                    checkval = 1;
                                    alertify.error(ValidationMessageExtFieldName[i] + " " + ValidationMessageExt[i]);
                                    $(ValidationMessageExtField[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;
                    case "16": //For  Minimum Value Check
                        //Commented And Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                        //if (ValidationMessageExt[i].indexOf("less") != -1) {
                        //    if ($(ValidationMessageExtField[i]).val() != "") {
                        //        if ($(ValidationMessageExtField[i]).attr("MinValue")) {
                        //            if ($(ValidationMessageExtField[i]).val() < $(ValidationMessageExtField[i]).attr("MinValue") && $(ValidationMessageExtField[i]).val() != $(ValidationMessageExtField[i]).attr("MinValue")) {

                        //                checkval = 1;
                        //                alertify.error(ValidationMessageExtFieldName[i] + " " + ValidationMessageExt[i] + " " + $(ValidationMessageExtField[i]).attr("MinValue"));
                        //                $(ValidationMessageExtField[i]).focus()
                        //                return checkval;
                        //                //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                        //            }

                        //        }
                        //    }
                        //};
                        if (ValidationMessageExt[i].indexOf("less") != -1) {
                            if ($(ValidationMessageExtField[i]).val() != "") {

                                if (ValidationMessageExtField[i].indexOf('CustomFieldText') > -1) {
                                    for (var l = 0; l < ExtMinValueArray.length; l++) {
                                        var DatabseFieldNameArray = ExtMinValueArray[l].split("=");
                                        var DatabseFieldName = DatabseFieldNameArray[0];
                                        var MinValue = DatabseFieldNameArray[1];
                                        if (ValidationMessageExtField[i].indexOf(DatabseFieldName) > -1) {

                                            if (parseInt($(ValidationMessageExtField[i]).val()) < parseInt(MinValue)) {
                                                checkval = 1;
                                                var validationMsg = ValidationMessageExt[i];
                                                validationMsg = validationMsg.replace('<ID>', ValidationMessageExtFieldName[i]);
                                                validationMsg = validationMsg.replace('<VALUE>', MinValue);

                                                alertify.error(validationMsg);
                                                $(ValidationMessageExtField[i]).focus()
                                                return checkval;
                                            }
                                        }
                                    }

                                }
                            }
                        };
                        //End Of Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                        break;
                    case "17"://For  Maximum Value Check
                        //Commented And Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                        //if (ValidationMessageExt[i].indexOf("greater") != -1) {
                        //    if ($(ValidationMessageExtField[i]).val() != "") {
                        //        if ($(ValidationMessageExtField[i]).attr("MaxValue")) {
                        //            if ($(ValidationMessageExtField[i]).val() >= $(ValidationMessageExtField[i]).attr("MaxValue") && $(ValidationMessageExtField[i]).val() != $(ValidationMessageExtField[i]).attr("MaxValue")) {

                        //                checkval = 1;
                        //                alertify.error(ValidationMessageExtFieldName[i] + " " + ValidationMessageExt[i] + " " + $(ValidationMessageExtField[i]).attr("MaxValue"));
                        //                $(ValidationMessageExtField[i]).focus()
                        //                return checkval;
                        //                //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                        //            }

                        //        }
                        //    }
                        //};
                        if (ValidationMessageExtField[i].indexOf('CustomFieldText') > -1) {
                            for (var l = 0; l < ExtMaxValueArray.length; l++) {
                                var DatabseFieldNameArray = ExtMaxValueArray[l].split("=");
                                var DatabseFieldName = DatabseFieldNameArray[0];
                                var MaxValue = DatabseFieldNameArray[1];
                                if (ValidationMessageExtField[i].indexOf(DatabseFieldName) > -1) {

                                    if (parseInt($(ValidationMessageExtField[i]).val()) > parseInt(MaxValue)) {
                                        checkval = 1;
                                        var validationMsg = ValidationMessageExt[i];
                                        validationMsg = validationMsg.replace('<ID>', ValidationMessageExtFieldName[i]);
                                        validationMsg = validationMsg.replace('<VALUE>', MaxValue);

                                        alertify.error(validationMsg);
                                        $(ValidationMessageExtField[i]).focus()
                                        return checkval;
                                    }

                                }
                            }
                        };
                        //End Of Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                        break;

                    case "18":  //For  Value Range
                        if (ValidationMessageExt[i].indexOf("range") != -1) {

                            if (ValidationMessageExtField[i].indexOf("cbo") != -1) {
                                var Condition = $(ValidationMessageExtField[i]).text() <= $(ValidationMessageExtField[i]).attr("MinValue") && $(ValidationMessageExtField[i]).text() >= $(ValidationMessageExtField[i]).attr("MaxValue")
                            }
                            else {
                                var Condition = $(ValidationMessageExtField[i]).val() <= $(ValidationMessageExtField[i]).attr("MinValue") && $(ValidationMessageExtField[i]).val() >= $(ValidationMessageExtField[i]).attr("MaxValue")
                            }

                            if ($(ValidationMessageExtField[i]).text() != "") {
                                if ($(ValidationMessageExtField[i]).attr("range")) {
                                    if (Condition == false) {
                                        checkval = 1;
                                        alertify.error(ValidationMessageExtFieldName[i] + " " + ValidationMessageExt[i] + " " + $(ValidationMessageExtField[i]).attr("MinValue") + " - " + $(ValidationMessageExtField[i]).attr("MaxValue"));
                                        $(ValidationMessageExtField[i]).focus()
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

        //This function gets the values  for  the all the extended custom field dropdowns and binds to it.
        function GetExtendedCustomFieldComboboxValues(DatabaseFieldName, ProjectID, UserGivenCaption) {
            //Commented & Added By Dipali V On 6th April 2023 For Get Combo values
            //var commonProp = { ProjectId: parseInt(ProjectID) };
            //var customField = { commonProperty: commonProp, DatabaseFieldName: DatabaseFieldName };
            var customField = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId,
                DatabaseFieldName: DatabaseFieldName
            };
             //End of Commented & Added By Dipali V On 6th April 2023 For Get Combo values
            var param = JSON.stringify(customField);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetExtendedCustomFieldComboboxValues", param, false);
            //debugger;
            if (result != undefined) {
                //Added By Usha Pandit On 10.06.2020 For setting default value if exists
                var curCboName = "";
                var curDefaultValue = "";
                //End Of Added By Usha Pandit On 10.06.2020 For setting default value if exists
                for (var i = 0; i < result.length; i++) {
                    // debugger
                    var list = result[i];
                    //var s = ('<option value=' + list.UniqueID + ' >' + list.FieldName + '</option>');
                    var s = ('<option value=' + list.FieldID + ' >' + list.FieldName + '</option>');
                    var cboName = "#cboext" + DatabaseFieldName;
                    curCboName = cboName;
                    $(cboName).append(s);
                    //Added By Usha Pandit On 10.06.2020 For setting default value if exists
                    if (list.DefaultValue != null && list.DefaultValue != undefined && list.DefaultValue != "") {
                        curDefaultValue = list.DefaultValue;
                    }
                    //End Of Added By Usha Pandit On 10.06.2020 For setting default value if exists
                }

                var ExtenededCustomFieldName = "ext" + DatabaseFieldName;
                AppendOptioncbo(ExtenededCustomFieldName, UserGivenCaption);
                //Added By Usha Pandit On 10.06.2020 For setting default value if exists
                if (curDefaultValue != "") {
                    $(curCboName).val(curDefaultValue);
                }
                //End Of Added By Usha Pandit On 10.06.2020 For setting default value if exists
            }
        }
        /*Added by Swapnagandha K. For SLA Details*/
        function GetIssueSLADetails(IssueID) {

            $.ajax({
                url: url + '/api/IB_IssueDetails/GetProjectIssueSLA',
                method: 'Post',
                data: JSON.stringify(IssueID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (IssueID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(IssueID) ? IssueID : JSON.stringify(IssueID)));
                    }
                },
                success: function (result) {

                    $("#tbodySLADetails").empty();

                    if (result.length == 0) {
                        $('#tbodySLADetails').append('<tr><td colspan="45">' + 'There is no SLA for this Issue.' + '</td></tr>');
                        return;
                    }
                    var strHTML = "";
                    for (var i = 0; i < result.length; i++) {

                        var SLADetails = result[i];
                        strHTML += ' <tr>';
                        strHTML += '<td>' + SLADetails.SLAName + '</td>';
                        //Commented by dipali v on 24th Sep 2019 For remove NormDate
                        //strHTML += '<td>' + SLADetails.NormDate + '</td>';
                        //End of Commented by dipali v on 24th Sep 2019 For remove NormDate
                        strHTML += '<td>' + SLADetails.NormHours + ' ' + SLADetails.UnitOfNorm + '</td>';

                        strHTML += '<td>' + SLADetails.ActualHours + '</td>';

                        if (SLADetails.IsMet == "NOT MET") {
                            strHTML += '<td><span class="redcolorentry">' + SLADetails.IsMet + '</span></td>';
                        }
                        else {
                            strHTML += '<td>' + SLADetails.IsMet + '</td>';
                        }
                        strHTML += '</tr>';

                    }
                    $('#tbodySLADetails').html(strHTML);
                },
                error: function (xhr, errorThrown) {

                }
            });
        }
        /*End Added by Swapnagandha K. For SLA Details*/

        var intIssueID;
        function GetAttachmentDetails(IssueID) {
            intIssueID = IssueID;
            var param = JSON.stringify(IssueID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetAttachmentDetails", param, false);
            if (result != undefined) {
                $('#tbodyAttachment').empty();
                if (result.length == 0) {
                    $('#tbodyAttachment').append('<tr><td colspan="45">' + 'There are no attachments for this Issue Id.' + '</td></tr>');
                    $('#btnDownloadZipRequestAttachment').attr('disabled', 'disabled');
                    $('#btnTrashButtonID').attr('disabled', 'disabled');
                    $('#TrashButtonID').attr('disabled', 'disabled');
                }
                else {
                    for (var i = 0; i < result.length; i++) {
                        var filepath = result[i].FilePath;
                        var filename = filepath.split(/[\\\/]/).pop();
                        var file = filename.substring(0, filename.indexOf('.') - 1);
                        var file_extion = filename.split('.').pop();
                        //var RowData = "<td><input type='checkbox'class='chcktbl'id=" + result[i].AttachmentId + "></td>";

                        var RowData = "";
                        if (result[i].DiscussionAttachment == true) {
                            RowData += "<td></td>";
                            RowData += "<td><i class='far fa-comments' data-bs-toggle='tooltip' title='Issue Discussion Attachment'></i></td>";
                            RowData += "<td></td>";
                        }
                        else if (result[i].IsCopiedFrmHelpdesk == true) {
                            RowData += "<td></td>";
                            RowData += "<td></td>";
                            RowData += "<td><i class='fas fa-headset'  data-bs-toggle='tooltip' title='Helpdesk Attachment'></i></td>";
                        } else {
                            RowData += "<td><input type='checkbox'class='chcktbl'id=" + result[i].AttachmentId + " Onclick='Selectall(this)'></td>";
                            RowData += "<td></td>";
                            RowData += "<td></td>";
                        }
                        RowData += "<td id=" + escape(filename) + ">" + result[i].AttachmentId + "</td>";
                        RowData += "<td>" + result[i].DateOfAttaching + "</td>";
                        RowData += "<td>" + result[i].OriginalFileName + "</td>";
                        RowData += "<td> " + result[i].FileType + "<a href = '#' onclick ='DownloadAttachedFile(" + result[i].AttachmentId + "," + result[i].IsCopiedFrmHelpdesk +")' value = " + escape(filename) + " > <i class='fa fa-download' aria-hidden='true' data-bs-toggle='tooltip' title='Download Attachment' ></i></a></td>";
                        RowData += "<td>" + result[i].AttachedBy + "</td> <td class='atchmntdescr'>" + result[i].Description + "</td>";
                        //Added By Rutuja D. on 23 May 2022
                        RowData += "<td>" + result[i].Category + "</td> <td>" + result[i].SubCategory + "</td>";
                        //End of Added By Rutuja D. on 23 May 2022
                        $('#tbodyAttachment').append("<tr>" + RowData + "</tr>");
                    }
                    $('#btnDownloadZipRequestAttachment').attr('disabled', false);
                    $('#btnTrashButtonID').attr('disabled', false);
                    $('#TrashButtonID').attr('disabled', false);
                }
                Count = result.length;
                attachmentCount = Count;
            }
            //Script Added by pradip on 05-12-2019 for attachment description show more and show less

            $('.atchmntdescr').each(function () {
                var content = $(this).html();

                if (content.length > showChar) {

                    var c = content.substr(0, showChar);
                    var h = content.substr(showChar, content.length - showChar);

                    var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

                    $(this).html(html);
                }

            });

            $(".morelink").click(function () {
                if ($(this).hasClass("less")) {
                    $(this).removeClass("less");
                    $(this).html(moretext);
                } else {
                    $(this).addClass("less");
                    $(this).html(lesstext);
                }
                $(this).parent().prev().toggle();
                $(this).prev().toggle();
                return false;
            });

        }

        function DownloadAttachedFile(value, IsCopiedFrmHelpdesk) {
            $('#tbodyAttachment td').filter(function () {
                if ($(this).text() == value) {
                    var fileName = unescape($(this).attr('id'));
                    var strTemp = '../../General/ViewAttachment.aspx?FromWhere=BTS&FileName=' + fileName + '&SystemFileName=' + fileName + '&IsCopiedFrmHelpdesk=' + IsCopiedFrmHelpdesk;
                    window.open(strTemp);
                }
            });
        }

        function DeleteAttachment(arrayId) {
            var param = JSON.stringify(arrayId);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/DeleteAttachment", param, false);
            if (result == null) {
                alertify.success("Attachment is deleted successfully.")
            }
        }

        var Count;
        function GetAttachmentForDiscussion(DiscussionID) {
            Count = 0;
            var param = JSON.stringify(DiscussionID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetAttachmentForDiscussion", param, false);
            if (result != undefined) {
                $('#tbodyDiscussionAttachment').empty();
                if (result.length == 0) {
                    $('#tbodyDiscussionAttachment').append('<tr><td colspan="45">' + 'There are no attachments for this Discussion.' + '</td></tr>');
                    //Added By Dipali V On 24th Sep 2019 For If no Attchment but should be disbaled
                    $('#btnattachmentdiscussion').attr('disabled', 'disabled');
                    //End of Added By Dipali V On 24th Sep 2019 For If no Attchment but should be disbaled
                }
                else {
                    for (var i = 0; i < result.length; i++) {
                        var filepath = result[i].FilePath;
                        var filename = filepath.split(/[\\\/]/).pop();
                        var file = filename.substring(0, filename.indexOf('.') - 1);
                        var file_extion = filename.split('.').pop();
                        var RowData = "<td><input type='checkbox'class='chcktbld' id=" + result[i].AttachmentId + "></td>";
                        //RowData += "<td><a href='#'><i class='far fa-comments'></i></a></td>"; 
                        RowData += "<td id = " + filename + ">" + result[i].AttachmentId + "</td>";
                        RowData += "<td>" + result[i].DateAttach + "</td>";
                        RowData += "<td>" + result[i].OriginalFileName + "</td>";
                        RowData += "<td>" + result[i].FileType + "<a href='#' onclick='DownloadFile(" + result[i].AttachmentId + ")' value=" + filename + "><i class='fa fa-download' aria-hidden='true' data-bs-toggle='tooltip' title='Download Attachment' ></i></a></td>";
                        RowData += "<td>" + result[i].AttachedBy + "</td>";
                        RowData += "<td>" + result[i].Description + "</td>";
                        //Added By Rutuja D. on 23 May 2022
                        RowData += "<td>" + result[i].Category + "</td>";
                        RowData += "<td>" + result[i].SubCategory + "</td>";
                        //End of Added By Rutuja D. on 23 May 2022
                        $('#tbodyDiscussionAttachment').append("<tr>" + RowData + "</tr>");
                        $('#btnattachmentdiscussion').removeAttr('disabled');
                    }
                }
                Count = result.length;
                attachmentCount = Count;
            }
            return Count;
        }

        function getFieldName(FieldName) {
            if (FieldName == "DeliverableID") {
                FieldName = "Deliverable";
            } else if (FieldName == "RootCauseID") {
                FieldName = "Root Cause";
            } else if (FieldName == "ModuleName") {
                FieldName = "Module Name";
            } else if (FieldName == "ChangeRequestName") {
                FieldName = "Change Request Name";
            } else if (FieldName == "CodedByName") {
                FieldName = "Coded By Name";
            } else if (FieldName == "ReportedInVersion") {
                FieldName = "Reported In Version";
            } else if (FieldName == "CorrectedInVersion") {
                FieldName = "Corrected In Version";
            } else if (FieldName == "FoundInPhase") {
                FieldName = "Found In Phase";
            } else if (FieldName == "FixedInPhase") {
                FieldName = "Fixed In Phase";
            } else if (FieldName == "AssignToName") {
                FieldName = "Responsible Person";
            } else if (FieldName == "UserStory") {
                FieldName = "User Story";
            } else if (FieldName == "Iteration") {
                FieldName = "Sprint";
            } else if (FieldName == "SubType") {
                FieldName = "Sub Type";
            } else if (FieldName == "ReportedBy") {
                FieldName = "Reported By";
            }
            // Added & Commented By Dipali V On 16th April 2020 For Caption as per layout
            else if (FieldName == "CustomerIssueID1") {
                //Commented And Added By Usha Pandit On 06.01.2021 for getting correct Mandatory alert for Customer Issue Id
                //FieldName = "Duplicate Issue ID";
                var curcaption = $("#lblCustomerIssueID1")
                    .clone()    //clone the element
                    .children() //select all the children
                    .remove()   //remove all the children
                    .end()  //again go back to selected element
                    .text();

                FieldName = curcaption.toString().trim();
                //End Of Added By Usha Pandit On 06.01.2021 for getting correct Mandatory alert for Customer Issue Id           
            }
            // End ofAdded & Commented By Dipali V On 16th April 2020 For Caption as per layout

            // Added By Rutuja D.On 7 Jan 2021 For Caption as per layout
            else if (FieldName == "CustomerIssueID") {
                FieldName = "Customer";
            }
            // End of AddedBy Rutuja D.On 7 Jan 2021 For Caption as per layout
            return FieldName;
        }

        //var cbocontrolfield = ["Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo4", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "ModuleName", "IssueId", "txtextCustomFieldText1"];
        var cbocontrolfield = ["Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignToName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedByName", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "CustomerIssueID", "CustomerID", "ComponentID", "Release", "Iteration", "UserStory", "ModuleName", "ReportedInVersion", "CorrectedInVersion", "ChangeRequestName"];//Added By Dipali V On 14th July Mandatory alert was not getting
        function checkValidation() {
            $("#sidebarpanel span:contains('*')").each(function () {
                //
                //debugger;
                //Added By Rutuja D. on 7 Jan 2020 For Check only Visible Div 
                var MandatoryId = this.id;
                var DivID = MandatoryId.replace("Mandatory", "div");
                if ($('#' + DivID).css('display') == 'none') {

                } 
				else 
				{
                    //End Of Added By Rutuja D. on 7 Jan 2020 For Check only Visible Div
                var MandatoryId = this.id;
                var controlID = MandatoryId.replace("Mandatory", "");
                // 
                //debugger;
                //if (MandatoryId.indexOf("Description") != -1 || MandatoryId.indexOf("Summary") != -1 || MandatoryId.indexOf("ImportID") != -1 || MandatoryId.indexOf("CustomerIssueID1") != -1 || MandatoryId.indexOf("CustomFieldTextArea") != -1) {
                //Added By Usha Pandit On 20.03.2020 For Import ID validation
                if (MandatoryId.indexOf("ImportID") != -1) {                    
                    var controlId = MandatoryId.replace("Mandatory", "txt")
                    var filedName = controlID.replace("txt", "");
                    if (filedName == "ImportID") {
                        filedName = "Import ID";
                    }                    
                    if ($("[name='" + controlId + "']").val().length == 0) {
                        validateflag = false;
                        var message = filedName + " should not be blank.";
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(message);
                        $("[name='" + controlId + "']").focus();
                        return false;
                    }
                    if (checkSpecialCharacter($("[name='" + controlId + "']").val()) == true) {
                        validateflag = false;
                        var message = filedName + ' cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(message);
                        $("[name='" + controlId + "']").focus();
                        return false;                        
                    }
                    //Added By Dipali V On 2nd Jan 2020 For Id should  be positive number & and not allowed Zero
                    if ($("[name='" + controlId + "']").val() == 0) {
                        validateflag = false;
                        var message = filedName + ' is mandatory non-zero field';
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(message);
                        $("[name='" + controlId + "']").focus();
                        return false;                        
                    }
                    //End of Added By Dipali V On 2nd Jan 2020 For Id should  be positive number & and not allowed Zero
                }
                //End Of Added By Usha Pandit On 20.03.2020 For Import ID validation
                //Commented & Added By Rutuja D. on 7 Jan 2021 For CustomerIssueID And CustomerIssueID1 conflict
                    //if (MandatoryId.indexOf("Description") != -1 || MandatoryId.indexOf("Summary") != -1|| MandatoryId.indexOf("CustomerIssueID") != -1) {
                    if (MandatoryId.indexOf("Description") != -1 || MandatoryId.indexOf("Summary") != -1 || MandatoryId.indexOf("CustomerIssueID1") != -1) {
                //End of Commented & Added By Rutuja D. on 7 Jan 2021 For CustomerIssueID And CustomerIssueID1 conflict                                           
                    var controlId = MandatoryId.replace("Mandatory", "txt")
                    if (MandatoryId.indexOf("Summary") != -1 || MandatoryId.indexOf("Description") != -1) {
                        if ($("[name='" + controlId + "']").val().length == 0) {
                            validateflag = false;
                            var filedName = controlId.replace("txt", "");
                            //var message = filedName + " is Mandatory. Please fill the " + filedName + " field.";
                            //Commented & Added By Dipali V On 14th Sep for Alert formate
                            //var message = filedName + " is Mandatory . please select this " + controlID + ".";
                            var message = filedName + " should not be blank.";
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(message);
                            $("[name='" + controlId + "']").focus();
                            return false;
                        } else {
                            validateflag = true;
                            return true;
                        }
                    }
                    else {
                        // Added & Commented By Dipali V On 16th April 2020 For Caption as per layout
                        if (controlId == "txtCustomerIssueID") {
                            controlId = "txtCustomerIssueID1";
                        }
                        // End of Added & Commented By Dipali V On 16th April 2020 For Caption as per layout
                        controlId = "#" + controlId;
                        //alert(controlId);
                       // debugger
                        //Commented And Added By Usha Pandit On 14.08.2020 for checking if the field is mandatory or not
                        //if ($(controlId).val() != undefined) {
                       
                        if ($(controlId).val() != undefined && $("#MandatoryCustomerIssueID1").length != 0) {
                            //End Of Added By Usha Pandit On 14.08.2020 for checking if the field is mandatory or not
                            if ($(controlId).val().length == 0 || $(controlId).val().trim().length == "") {
                                validateflag = false;
                                var filedName = controlId.replace("#txt", "");
                                filedName = getFieldName(filedName);
                                //var message = filedName + " is Mandatory. Please fill the " + filedName + " field.";     //Commented & Added By Dipali V On 14th Sep for Alert formate
                                //var message = filedName + " is Mandatory . please select this " + controlID + ".";
                                var message = filedName + " should not be blank.";
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(message);
                                $(controlId).focus();
                                return false;
                            }
                            //} else {
                            //    validateflag = true;
                            //    return true;
                            //}

                            //Added By Dipali V On 2nd Jan 2020 For Id should  be positive number & and not allowed Zero

                            //else  if ($(controlId).val().trim() == "0") {
                             //   validateflag = false;
                             //   var filedName = controlId.replace("#txt", "");
                               // filedName = getFieldName(filedName);
                                //var message = filedName + " is Mandatory. Please fill the " + filedName + " field.";     //Commented & Added By Dipali V On 14th Sep for Alert formate
                                //var message = filedName + " is Mandatory . please select this " + controlID + ".";
                              //  var message = filedName + " is mandatory non-zero field.";
                              //  alertify.set('notifier', 'position', 'top-right');
                              //  alertify.error(message);
                              //  $(controlId).focus();
                             //   return false;
                           // }
                           

                            else if ($(controlId).val() < 0) {
                                validateflag = false;
                                var filedName = controlId.replace("#txt", "");
                                filedName = getFieldName(filedName);
                                //var message = filedName + " is Mandatory. Please fill the " + filedName + " field.";     //Commented & Added By Dipali V On 14th Sep for Alert formate
                                //var message = filedName + " is Mandatory . please select this " + controlID + ".";
                                var message = filedName + " should be positive number";
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(message);
                                $(controlId).focus();
                                return false;
                            }
                            else {
                                validateflag = true;
                                return true;
                            }
                            //End of Added By Dipali V On 2nd Jan 2020 For Id should  be positive number & and not allowed Zero



                        }

                     

                           
                        
                

                    }
                }
                alertify.set('notifier', 'position', 'top-right');
                //Commented And Added By Usha Pandit On 07.01.2021 For Status Change Date and Time validation
                //if (MandatoryId.indexOf("ReportedDate") != -1 || MandatoryId.indexOf("ReportedTime") != -1 || MandatoryId.indexOf("CustomFieldDate") != -1) {
                    if (MandatoryId.indexOf("ReportedDate") != -1 || MandatoryId.indexOf("ReportedTime") != -1 || MandatoryId.indexOf("CustomFieldDate") != -1 || MandatoryId.indexOf("StatusChangeDate") != -1 || MandatoryId.indexOf("StatusChangeTime") != -1) {
                 //End Of Added By Usha Pandit On 07.01.2021 For Status Change Date and Time validation
                        var controlId = MandatoryId.replace("Mandatory", "#dt");
                        if ($(controlId).val() != undefined) { //Added By usha pandit On 21.05.2021 For javascript on issue update
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
                                //var message = filedName + " is Mandatory. Please fill the " + filedName + " field.";
                                //Commented & Added By Dipali V On 14th Sep for Alert formate
                                //var message = filedName + " is Mandatory . please select this " + controlID + ".";
                                var message = filedName + " should not be blank.";
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
                    }
                if (MandatoryId.indexOf("ShowToCustomer") != -1) {
                    var controlId = MandatoryId.replace("Mandatory", "#chk");
                    if ($(".clsCheckBox").prop("checked") == false) {
                        validateflag = false;
                        var filedName = controlId.replace("#chk", "");
                        //Commented & Added By Dipali V On 23rd Sep for Alert formate
                        if (filedName.includes("chkDisc") == true) {
                            filedName = filedName.replace("chkDisc", "");
                        }

                        if (filedName == "ShowToCustomer") {
                            filedName = filedName.replace("ShowToCustomer", "Show To Customer");
                        }
                        //End of Commented & Added By Dipali V On 23rd  Sep for Alert formate

                        //var message = filedName + " is Mandatory . please checked " + filedName + ".";
                        //Commented & Added By Dipali V On 14th Sep for Alert formate
                        //var message = filedName + " is Mandatory . please select this " + controlID + ".";

                        //Commented and added by Chetan M on 13th Aug 2020 for Issue ID = 25674
                        //var message = filedName + " should not be blank.";
                        if (filedName == "Show To Customer") {
                            var message = "Please select "+ filedName +" checkbox.";
                        }
                        else {
                                var message = filedName + " should not be blank.";
                        }
                        //End of Commented and added by Chetan M on 13th Aug 2020 for Issue ID = 25674
                        
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
                if (cbocontrolfield.indexOf(controlID) != -1) {
                   // debugger;
                    var controlId1 = MandatoryId.replace("Mandatory", "#cbo");
                    var controlId = MandatoryId.replace("Mandatory", "#cbo");
                    controlId = controlId + " :selected";
					//Added By Rutuja D. on 7 Jan 2021 For Customer Mandatory Field alert Not Showing
                        if (controlId.indexOf("CustomerIssueID") != -1) {
                            controlId = controlId.replace("CustomerIssueID", "CustomerID");
                            controlId1 = controlId1.replace("CustomerIssueID", "CustomerID");
                        }
                        //End Added By Rutuja D. on 7 Jan 2021 For Customer Mandatory Field alert Not Showing
                    var cbovalue = $(controlId).val();
                    if (cbovalue == 0 || cbovalue == "0") {
                        //
                        validateflag = false;
                        //alert(controlId1);
                        //debugger;
                        var filedName = controlId.replace("#cbo", "");
                        ////added by dipali V on 14th Sep For Change caption iteration to sprint
                        //if (filedName.lastIndexOf("Iteration") != -1) {
                        //    controlID = controlID.replace(controlID, "Sprint");
                        //}
                        //if (filedName.lastIndexOf("ReportedBy") != -1) {
                        //    controlID = controlID.replace(controlID, "Reported By");
                        //}
                        ////End of added by dipali V on 14th Sep For Change caption iteration to sprint
                        //if (filedName.lastIndexOf("AssignToName") != -1) {
                        //    controlID = "Responsible Person";
                        //    //Commented & Added By Dipali V On 14th Sep for Alert formate
                        //    //var message = controlID + " is Mandatory . please select this " + controlID + ".";
                        //    var message = controlID + " should not be blank.";
                        //    //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        //} else {
                        //    //Commented & Added By Dipali V On 14th Sep for Alert formate
                        //    //var message = controlID + " is Mandatory . please select this " + controlID + ".";
                        //    var message = controlID + " should not be blank.";
                        //    //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                        //}
                        //Added By Dipali V On 16th April 2020 For alert issue
                        if (controlID=="FoundInPhase") {
                            controlID = controlID.replace(controlID, "Found In Phase");
                            //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                            var curval = $("#lblFoundInPhase").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim();  
                            controlID = controlID.replace(controlID, curval);
                            //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        }
                        else if (controlID=="FixedInPhase") {
                            controlID = controlID.replace(controlID, "Fixed In Phase");
                            //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                            var curval = $("#lblFixedInPhase").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim(); 
                            controlID = controlID.replace(controlID, curval);
                            //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        }
                        
                        else if (filedName.lastIndexOf("Phase") != -1) {
                            controlID = controlID.replace(controlID, "Source Phase");
                            //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                            var curval = $("#lblPhase").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim();                            
                            controlID = controlID.replace(controlID, curval);
                            //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        }
                        //Added By Usha Pandit On 18.02.2021 For correct placeholder name
                        if (controlID=="ChangeRequestName") {                                                       
                            var curval = $("#lblChangeRequestName").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim();  
                            controlID = controlID.replace(controlID, curval);                            
                        }
                        if (controlID=="CodedByName") {
                            var curval = $("#lblCodedByName").text();
                            curval = curval.replace("*", "");
                            curval = curval.trim();  
                            controlID = controlID.replace(controlID, curval);
                        }
                        //End Of Added By Usha Pandit On 18.02.2021 For correct placeholder name
                         //End of Added By Dipali V On 16th April 2020 For alert issue
                        var message = getFieldName(controlID) + " should not be blank.";
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
                            //Added By Usha Pandit On 19.03.2020 for not getting alert for Customer mandatory field
                            if (MandatoryId.indexOf("CustomerIssueID") != -1) {
                                MandatoryId = MandatoryId.replace("CustomerIssueID", "CustomerID");
                            }
                            //End Of Added By Usha Pandit On 19.03.2020 for not getting alert for Customer mandatory field
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
                                //Added By Usha Pandit On 19.03.2020 for not getting alert for Customer mandatory field
                                if (filedName == "CustomerID") {
                                    filedName = filedName.replace(filedName, "Customer ID");
                                }
                                //alert(filedName);
                                 if (filedName == "Phase") {
                                    filedName = filedName.replace(filedName, "Source Phase");
                                }                                
                                //End Of Added By Usha Pandit On 19.03.2020 for not getting alert for Customer mandatory field
                                //End of Commented & Added By Dipali V On 14th Sep for Alert formate
                                //Commented & Added By Dipali V On 14th Sep for Alert formate
                                //var message = filedName + " is Mandatory . please select this " + filedName + ".";
                                var message = filedName + " should not be blank.";
                                //End of Commented & Added By Dipali V On 14th Sep for Alert formate
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
				
			}//End Of Added By Rutuja D. on 7 Jan 2020 For Closing else bracket
            });
        }

        //Function for to get the date picker on click of the textbox
        function CustomfiledDatePicker(customfileddateid) {
            var filedid = "#dt" + customfileddateid;
            $(filedid).datepicker({
                //autoclose: true
                changeMonth: true,
                dateFormat: 'd M yy',
                changeYear: true,//2021
                onClose: function () {
                    $(':focus').blur();
                }
            });
        }

        ////this is funtion used for check customer droup down list hide or show
       // function ProductFiledFlag(commonProp1) {
        function ProductFiledFlag(commonProperty) {

            var EmployeeID = "<%= Session("intUserID") %>  ";
           // commonProperty = null;
            var empName;
           // var commonProp = commonProp1;
            var commonProp = commonProperty;
            //// global define varaiable sotred parameter current funtion
           // commonProperty = commonProp1;
          //  var productField = { commonProperty: commonProp };
            var productField = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId };
            var param = JSON.stringify(productField);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/ProductFiledFlag", param, false);
            if (result != undefined) {
                flag = null;
                flag = result.FildFlag;

                if (result.FildFlag == true) {
                    $('#divCustomerIssueID').show();
                    $('#divProductFields').show();
                    $('#rowProductFields').show();
                    //Added By swapnagandha K. On 24 Oct 2019 For Issue-Product field displaying blank
                    // $('#cboProduct').empty();
                    //  $('#cboModule').empty();
                    //End Added By swapnagandha K. On 24 Oct 2019 For Issue-Product field displaying blank
                } else {
                    $('#divCustomerIssueID').hide();
                    ListOfProduct(result.FildFlag, null, commonProp);
                    getProductDevelopmentProject(commonProperty.ProjectId);
                }
            }
        }

        ////this function use when we will click on customer droup down list
        function Customerclick(customerid1) {
            customerid = null;
            customerid = customerid1;
            SelectedCustomerID = customerid1;

            ListOfProduct(flag, customerid, commonProperty);
            $('#cboModule').empty();
        }

        ////this function used for get product list and bind on product droup down list
        function ListOfProduct(flag, customerid, commonProperty) {
            if (flag == false) {
                flag = 0;
            }
            else {
                flag = 1;
            }
           // var productField = { commonProperty: commonProp1, FildFlag: flag, Customerid: customerid, FildFlag: true  };
            var productField = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId,
                FildFlag: flag, Customerid: customerid //, FildFlag: true// // Commneted By Dipali V On 3rd April 2023 For placeholder
            };
            var param = JSON.stringify(productField);         
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetProductList", param, false);
            if (result != undefined) {
                $("#cboModule").empty();
                $("#cboProduct").empty();
                var objCbo1 = document.getElementById("cboProduct");
                if (objCbo1 != null) {
                    $("#cboProduct option").remove();
                    for (var i = 0; i < result.length; i++) {
                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.ProductVersion;
                        objOption.value = Objresult.ProductVersionID;
                    }
                    AppendOptioncbo("Product", "Product");
                }
            }
        }

        ////when we will click or select product then bind the component  
        function ProductClick(ProductVersionId) {
            ProductVersionID = null;
            ProductVersionID = ProductVersionId;

            if (ProductVersionID != 0) {
                ListOfComponet1("ProductVersions_Components", SelectedCustomerID, commonProperty, ProductVersionID);
            } else {
                $("#cboModule").empty();
            }
        }

       // function ListOfComponet1(flag, customerid, commonProp1, ProductVersionID) {
        function ListOfComponet1(flag, customerid, commonProp1, ProductVersionID) {
           // var productField = { commonProperty: commonProp1, FildFlag: flag, Customerid: customerid, ProductVersionID: ProductVersionID,FildFlag: true };
            var productField = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId,
                FildFlag: flag, Customerid: customerid, ProductVersionID: ProductVersionID, FildFlag: true
            };
            var param = JSON.stringify(productField);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetComponetList", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById("cboModule");
                if (objCbo1 != null) {
                    $("#cboModule option").remove();

                    for (var i = 0; i < result.length; i++) {

                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.Component;
                        objOption.value = Objresult.ComponentID;
                    }

                    AppendOptioncbo("Module", "Module");
                }
            }
        }

        function GetTypes(commonProperty) {
            //var commonProperty = commonProperty;
            var commonProperty = {
                ProjectId: commonProperty.ProjectId,
                LoginType: commonProperty.LoginType,
                EmployeeId: commonProperty.EmployeeId,
                IssueID: commonProperty.IssueID,
                RoleId: commonProperty.RoleId,
                LoginId: commonProperty.LoginId
            }
            var param = JSON.stringify(commonProperty);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetTypes", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById("cboType");
                //Added By Dipali V On 5th April 2024 for clear Dropdown 
                $("#cboType option").remove();
                //End of Added By Dipali V On 5th April 2024 for clear Dropdown 
                for (var i = 0; i < result.length; i++) {
                    var Objresult = result[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = Objresult.FieldID;
                    objOption.value = Objresult.FieldName;
                }
                AppendOptioncbo("Type", "Type");                
                if (Typeproject != "")
                {
                    //Commented and added Dipali V On 9th Nov 2021 For Get Proper Data
                    //$("select#cboType option:contains(" + Typeproject + ")").attr('selected', 'selected');
                    $("#cboType").val(Typeproject);
                    //End of Commented and added Dipali V On 9th Nov 2021 For Get Proper Data
                }
            }
        }

        function GetCustomer(ProjectID, UserGivenCaption) {
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetCustomer", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById("cboCustomFieldCombo2");
                if (objCbo1 != null) {
                    $("#cboCustomFieldCombo2 option").remove();

                    for (var i = 0; i < result.length; i++) {
                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.CustomerName;
                        objOption.value = Objresult.CustomerName;
                    }

                    AppendOptioncbo("CustomFieldCombo2", UserGivenCaption);
                }
            }
        }

        function GetFieldValueForIssue(copyIssueID, commonProp)
        {
           // var copyIssueIDs = copyIssueID;
            var copyIssueIDs = {
                issueid: copyIssueID.issueid,
                strFieldName: copyIssueID.strFieldName,
               // issueid: IssueID, strFieldName: strFieldNames
            }
            var param = JSON.stringify(copyIssueIDs);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetFieldValueForIssue", param, false);
            if (result != undefined) {
                var fieldid = "#cbo" + copyIssueID.strFieldName;
                if (copyIssueID.strFieldName == "CustomerID" || copyIssueID.strFieldName == "ProductVersionID" || copyIssueID.strFieldName == "Kernel" || copyIssueID.strFieldName == "ComponentID" || copyIssueID.strFieldName == "CustomFieldTextArea1" || copyIssueID.strFieldName == "CustomFieldDate1" || copyIssueID.strFieldName.indexOf("CustomField") > -1) {
                    if (copyIssueID.strFieldName == "CustomerID") {
                        fieldid = "#cboCustomerID";
                        if (result != null) {
                            $(fieldid).val(result);
                            flag = true;
                            commonProperty = commonProp;
                            customerid = result;
                            Customerclick(result);
                        }
                    }
                    if (copyIssueID.strFieldName == "ProductVersionID") {
                        fieldid = "#cboProduct";
                        if (result != null) {
                            $(fieldid).val(result);
                            commonProperty = commonProp;
                            ProductClick(result);
                        }
                    }
                    if (copyIssueID.strFieldName == "Kernel") {
                        jQuery("select#cboKernel option[value=" + result + "  ]").attr("selected", "selected");
                    }

                    if (copyIssueID.strFieldName == "ComponentID") {
                        fieldid = "#cboModule";
                        if (result != null) {
                            $(fieldid).val(result);
                        }
                    }

                    if (copyIssueID.strFieldName.indexOf("CustomFieldCombo") > -1) {
                        if (result != null) {
                            //$("#cbo" + copyIssueID.strFieldName + " option:contains(" + result + ")").prop('selected', true);
                            //$("#cbo" + copyIssueID.strFieldName).find("[value=" + result + "]").prop("selected", true);
                            //Added By Rutuja D. on 4 Jun 2021
                            $("#cbo" + copyIssueID.strFieldName).val(result.trim()).change();
                            //End of Added By Rutuja D. on 4 Jun 2021
                        }
                        else {
                            $("#cbo" + copyIssueID.strFieldName + " option[value=0]").prop('selected', true);
                        }
                    }

                    //if (copyIssueID.strFieldName == "CustomFieldTextArea1" || copyIssueID.strFieldName == "CustomFieldTextArea2" || copyIssueID.strFieldName == "CustomFieldTextArea3") {
                    if (copyIssueID.strFieldName.indexOf("CustomFieldTextArea") > -1) {
                        fieldid = "#txt" + copyIssueID.strFieldName;
                        if (result != null) {
                            $(fieldid).html(result);
                        }
                    }

                    //if (copyIssueID.strFieldName == "CustomFieldText1" || copyIssueID.strFieldName == "CustomFieldText2" || copyIssueID.strFieldName == "CustomFieldText3" || copyIssueID.strFieldName == "CustomFieldText4" || copyIssueID.strFieldName == "CustomFieldText5" || copyIssueID.strFieldName == "CustomFieldText6" || copyIssueID.strFieldName == "CustomFieldText7" || copyIssueID.strFieldName == "CustomFieldText8" || copyIssueID.strFieldName == "CustomFieldText9" || copyIssueID.strFieldName == "CustomFieldText10") {
                    if (copyIssueID.strFieldName.indexOf("CustomFieldText") > -1) {
                        fieldid = "#txt" + copyIssueID.strFieldName;
                        if (result != null) {
                            $(fieldid).val(result);
                        }
                    }

                    if (copyIssueID.strFieldName.indexOf("CustomFieldDate") > -1) {
                        fieldid = "#dt" + copyIssueID.strFieldName;

                        if (result != null) {
                            var val1 = result.split('T')[0];
                            $(fieldid).val(val1);
                        }
                    }
                }
                else {
                    if (result != null) {
                        $("" + fieldid + " option:contains(" + result + ")").attr('selected', 'selected');
                    }
                }
            }
        }

        function GetExtFieldValueForIssue(extField, commonProp) {
           // var param = JSON.stringify(extField);
            var extField = {
                issueid: extField.issueid,
                strFieldName: extField.strFieldName,
                // issueid: IssueID, strFieldName: strFieldNames
            }

            
            var param = JSON.stringify(extField);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetExtFieldValueForIssue", param, false);
            if (result != undefined) {
                if (extField.strFieldName.indexOf("CustomField") > -1) {
                    if (extField.strFieldName.indexOf("CustomFieldCombo") > -1) {
                        if (result != null) {
                            //$("#cboext" + extField.strFieldName + " option:contains(" + result + ")").prop('selected', true);
                            //$("#cboext" + extField.strFieldName).find("[value=" + result + "]").prop("selected", true);
                            $("#cboext" + extField.strFieldName).val(result).change();
                        }
                        else {
                            $("#cboext" + extField.strFieldName + " option[value=0]").prop('selected', true);
                        }
                    }

                    if (extField.strFieldName.indexOf("CustomFieldTextArea") > -1) {
                        fieldid = "#txtext" + extField.strFieldName;
                        if (result != null) {
                            $(fieldid).html(result);
                            commonProperty = commonProp;
                        }
                    }

                    if (extField.strFieldName.indexOf("CustomFieldText") > -1) {
                        fieldid = "#txtext" + extField.strFieldName;
                        if (result != null) {
                            $(fieldid).val(result);
                            commonProperty = commonProp;
                        }
                    }

                    if (extField.strFieldName.indexOf("CustomFieldDate") > -1) {
                        fieldid = "#dtext" + extField.strFieldName;
                        if (result != null) {
                            var val1 = result.split('T')[0];
                            $(fieldid).val(val1);
                            commonProperty = commonProp;
                        }
                    }
                }
            }
        }

        //function ResponsiblePerson(projectId, Type) {
        //    var newIssue = { ProjectId: parseInt(projectId), Type: Type };
        //    var param = JSON.stringify(newIssue);
        //    var result = AJAXCallWithResult("/api/IB_IssueDetails/GetResponsiblePerson", param, false);
        //    if (result != undefined) {
        //        var objCbo1 = document.getElementById("cboAssignToName");
        //        if (objCbo1 != null) {
        //            $("#cboAssignToName option").remove();

        //            for (var i = 0; i < result.length; i++) {
        //                var Objresult = result[i];
        //                var objOption = document.createElement("OPTION");
        //                objCbo1.options.add(objOption);
        //                objOption.text = Objresult.UserName;
        //                objOption.value = Objresult.EmployeeID;
        //            }

        //            AppendOptioncbo("AssignToName", "AssignToName");
        //            //
        //            if (ResponsiblePersonName != "") {
        //                if (ResponsiblePersonName == "646") {
        //                    $("select#cboAssignToName option[value=" + ResponsiblePersonName + "  ]").attr("selected", "selected");
        //                }
        //                else {
        //                    $("select#cboAssignToName option:contains(" + ResponsiblePersonName + ")").attr('selected', 'selected');
        //                }
        //            }
        //        }
        //    }
        //}

        function Release_OnChange(Release) {
            GetIterationsByRelease(Release);
            Iteration_OnChange(0);
        }

        function GetIterationsByRelease(Release) {
            var Release = Release.trim();
            var issueParameters = {
                intReleaseID: Release,
                IntIssueId: IssueID,// Added By Reshma Chavan on 23rd Dec 2021 for not showing sprint in edit mode
            };
            console.log(issueParameters)
            var param = JSON.stringify(issueParameters);
            var result = AJAXCallWithResult("/api/IB_AddNewIssue/GetIterationName", param, false);

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

        }

        function Iteration_OnChange(Iteration) {
            GetUserStoriesByIteration(Iteration);
        }

        function GetUserStoriesByIteration(Iteration) {
            var issueParameters = {
                intIterationID: Iteration.trim()
            };

            var param = JSON.stringify(issueParameters);
            var result = AJAXCallWithResult("/api/IB_AddNewIssue/GetUserStoryName", param, false);

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
        }

        function ResponsiblePerson(projectId, Type) {
            var newIssue = { ProjectId: parseInt(projectId), Type: Type };
            var param = JSON.stringify(newIssue);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/GetResponsiblePerson", param, false);
            if (result != undefined) {
                var objCbo1 = document.getElementById("cboAssignToName");
                if (objCbo1 != null) {
                    $("#cboAssignToName option").remove();

                    for (var i = 0; i < result.length; i++) {
                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.UserName;
                        objOption.value = Objresult.EmployeeID;
                    }

                    // AppendOptioncbo("AssignToName", "AssignToName");
                    //AppendOptioncbo("AssignToName", "ResponsiblePersonName");
                    //debugger;
                    if (ResponsiblePersonName != "") {
                        $("select#cboAssignToName option[value=" + ResponsiblePersonName + "  ]").prop("selected", "selected");
                    }
                    else {
                        $("select#cboAssignToName option[value=0]").prop('selected', true);
                    }
                    $('#cboAssignToName > option:first-child')
                        .text("Select Responsible Person");
                }
            }
        }

        function GetIssueDetailsafterTypeOnchange() {
            var ReportedTm = TimeConvTo12(selectedIssuesDetails[0].ReportedTime);
            var ProjectReportedDate = selectedIssuesDetails[0].ReportedDate;
            ReportedTm = convertTime12to24(ReportedTm);
            $("#dtReportedTime").val(ReportedTm);
            $("#dtReportedDate").val(ProjectReportedDate);
            $("#dtStatusChangeDate").val(selectedIssuesDetails[0].StatusChangeDate);
            $("#dtStatusChangeTime").val(selectedIssuesDetails[0].StatusChangeTime);

            GetComboValues();
            //debugger;
            //$("#cboReleasePatch option").remove();
            GetCommonCboValues("GetDeliverable", "DeliverableID");
            if (selectedIssuesDetails[0].DeliverableID == "") {
                AppendOptioncbo("DeliverableID", "");
            }
            if (ReportedBy !== null && ReportedBy !== "" && ReportedBy !== " " && ReportedBy !== 0) {
                AssignComboValue("ReportedBy", ReportedBy);
            }
            ResponsiblePerson(selectedIssuesDetails[0].ProjectID, Typeproject);
            //Commented & Added By Dipali V On 5th April 2023 For Space Issue
            //GetIterationsByRelease(selectedIssuesDetails[0].ReleaseID);
            GetIterationsByRelease(selectedIssuesDetails[0].ReleaseID.trim());
            //End of Commented & Added By Dipali V On 5th April 2023 For Space Issue
            //Iteration_OnChange(0);
            if(selectedIssuesDetails[0].IterationID)
            {
                //Commented & Added By Dipali V On 5th April 2023 For Space Issue
                GetUserStoriesByIteration(selectedIssuesDetails[0].IterationID.trim());
                //GetUserStoriesByIteration(selectedIssuesDetails[0].IterationID);
                //End of Commented & Added By Dipali V On 5th April 2023 For Space Issue
            }
          
            const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            const today = new Date();
            today.setDate(today.getDate());
            const yyyy = today.getFullYear();
            let mm = month[today.getMonth()];
            let dd = today.getDate();

            if (dd < 10) dd = '0' + dd;
            if (mm < 10) mm = '0' + mm;
            const formattedToday = dd + ' ' + mm + ' ' + yyyy;
           
            $("#dtReportedDate").removeClass('hasDatepicker');
            $("#dtStatusChangeDate").removeClass('hasDatepicker');
            $(function () {
                //Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
                //$('#dtReportedDate,#dtStatusChangeDate').datepicker({
                $('#dtReportedDate').datepicker({
                    //End of Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
                    autoclose: true,
                    changeMonth: true,
                    dateFormat: 'd M yy',
                    changeYear: true, //2021
                    onClose: function () {
                        $(':focus').blur();
                    }
                });
            });
        }



        function Typeclick(Type) {
            //debugger;
            if (Type != 0) {
                //Added By Dipali V On 16th Nov 2022 For Type Base Layout changes
                var ProjectID = '<%= Session("IssueProject") %>';
                var UserName = "<%= Session("strUserName").ToString() %>";
                var RoleId = "<%=IssueRoleId%>";
                var EmployeeId = "<%= Session("intUserID").ToString() %>";
                var LoginType = "<%= Session("LoginType").ToString() %>";
                var LoginId = "<%= Session("intLoginID").ToString() %>";
                ////stroed all variable in common property
                activerow = [];
                Typeproject = Type;
                var commonProperty = { ProjectId: ProjectID, RoleId: RoleId, EmployeeId: EmployeeId, LoginType: LoginType, LoginId: LoginId, strMode: 'New', Type: Type };
                ////this function use for ploating all control using project id
                 GetControlPloatingProject(ProjectID, commonProperty);
               // debugger;
                GetTypes(commonProperty);
                GetIssueDetailsafterTypeOnchange();
                 //End of Added By Dipali V On 16th Nov 2022 For Type Base Layout changes
                GetSubType(ProjectID, Type);
                var RoleId = "<%= Session("intPostID").ToString() %>";
                var LoginType = "<%= Session("LoginType").ToString() %>";
                var UserId = "<%= Session("intUserID").ToString() %>";

                //// bind data on status droupdown list
                GetStatus(ProjectID, Type, RoleId);

                //Added by Chetan M on 8 Jan 2021 for Issue fixing
                DefaultValue(ProjectID, Type, "OnChange");
                Status_OnChange();
                //End of Added by Chetan M on 8 Jan 2021 for Issue fixing
                $("#CustomFieldsControl").empty();

                ////this funciton used for ploat the custon field control 
                var isCustomField = getCustomFieldsMaxRowColCount(ProjectID);
                if (isCustomField == true) {
                    PloatCustomFields(ProjectID, Type, RoleId, LoginType, UserId);
                }

            } else {
                $('#cboSubType').empty();
                $('#cboStatus').empty();
                AppendOptioncbo("SubType", "SubType");
                AppendOptioncbo("Status", "Status");
                $("#CustomFieldsControl").empty();
                var isCustomField = getCustomFieldsMaxRowColCount(ProjectID);
                if (isCustomField == true) {
                    PloatCustomFields(ProjectID, null, RoleId, LoginType, UserId);
                }
            }
            var strFieldNames = ["CustomerID", "ProductVersionID", "ComponentID", "CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo4", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5"];
            for (var i = 0; i < strFieldNames.length; i++) {
                var copyIssueIDs = { issueid: IssueID, strFieldName: strFieldNames[i] };
                GetFieldValueForIssue(copyIssueIDs, commonProperty);
            }
        }

        function AppendOptioncbo(FieldName, Caption) {
            var id = "cbo" + FieldName;
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
            } else if (FieldName == "DeliverableTypes") {
                //Commented By dipali V On 18th Sep 2019 Placeholder issue
                //FieldName = "Assign To Name";
                FieldName = "Deliverable Type";
                //End of Commented By dipali V On 18th Sep 2019 Placeholder issue
            }
            else if (FieldName == "DiscussionStatus") {
                //Commented By dipali V On 18th Sep 2019 Placeholder issue
                //FieldName = "Assign To Name";
                FieldName = "Status";
                //End of Commented By dipali V On 18th Sep 2019 Placeholder issue
            } else if (FieldName.indexOf("CustomFieldCombo") > -1) {
                FieldName = Caption;
            }
            else if (FieldName.indexOf("extCustomFieldCombo") > -1) {
                FieldName = Caption;
            }
            //added by dipali V on 10th Sep 2019 for Placeholder issue
            else if (FieldName == "SelectFields") {
                FieldName = Caption;
            }
            else if (FieldName == "Modified") {
                FieldName = Caption;
            }
            else if (FieldName == "SelectFields") {
                FieldName = Caption;
            }
            else if (FieldName == "DiscussionStatus") {
                FieldName = Caption;
            }
            else if (FieldName == "UserStory") {
                FieldName = "User Story";
            }

            else if (FieldName == "Iteration") {
                FieldName = "Sprint";
            }
            //End of added by dipali V on 10th Sep 2019 for Placeholder issue
            else if (FieldName == "SubType") {
                //debugger;
                FieldName = Caption;
            }
                // Added By Dipali V On 3rd April 2023 For placeholder
            else if (FieldName == "Severity") {
                FieldName = "Severity";
            }
                // End of Added By Dipali V On 3rd April 2023 For placeholder
            else if (FieldName == "ReportedBy") {
                FieldName = "Reported By";
            }
            var textval = "Select " + FieldName;
            //debugger;
            var cbofield = document.getElementById(id);
            if (cbofield != null && cbofield != undefined) {
                if (document.getElementById(id).innerHTML.indexOf(textval) == -1) { // Added By Dipali V On 3rd April 2023 For Check Data Is there or not
                    cbofield.insertBefore(new Option(textval, '0'), cbofield.firstChild);
                    $("#" + id + " option[value=0]").prop('selected', true);
                }
            }
        }
        //Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength
        function FindMaxLength(id) {

            var maxlen = $(id).attr('maxlength');

            //$(".alertify-notifier .ajs-message + .ajs-message").css({ "display": "none"});
            //$(this).next().next().children(".alertify-notifier .ajs-message").hide();
            $(".ajs-message:eq(0)").hide();

            var length = $(id).val().length;
            //Commented and added by Chetan M on 13th Aug 2020 for Issue ID  = 24209
            //if (length > (maxlen - 10)) {
            if (length > maxlen) {
                //End of Commented and added by Chetan M on 13th Aug 2020 for Issue ID  = 24209
                alertify.set('notifier', 'position', 'top-right');
                //Commented & Added by Chetan M on 21th Jully 2020 for Issue ID = 24209
                //alertify.notify('Max length ' + maxlen + ' characters only ', 'error', 25);
                setTimeout(function () {
                    alertify.notify('Max length ' + maxlen + ' characters only ', 'error');
                }, 1000);
                // End of Commented & Added by Chetan M on 21th Jully 2020 for Issue ID = 24209
                //$('#textarea_message').css('display', 'block');
                // $("#textarea_message").html('Max length ' + maxlen + ' characters only <button type="button" class="close">×</button>');


            }
            else {

                //$('#textarea_message').html('');
                // $('#textarea_message').css('display', 'none');
            }
        }
        //End Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength
        $(document).on('click', '.close', function () {
            $(this).parent().hide();
        });

    </script>


    <script type="text/javascript">
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
              //Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by
            //$('#dtReportedTime').datetimepicker({
            //    format: 'LT',
            //});
              //End of Added By Dipali V On 22nd Nov 2021 For Disabled Reported Date,Time & Reported by
        });
        //Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
        //$('#duedate, #dtStatusChangeDate, #CDdate, #reporteddate1, #bulkreporteddate1, #assignissueSdate, #assignissueSdate2, #assignissueEdate, #assignissueEdate2, #assignissueDuedate, #statuschangedate1').datepicker({
        $('#duedate, #CDdate, #reporteddate1, #bulkreporteddate1, #assignissueSdate, #assignissueSdate2, #assignissueEdate, #assignissueEdate2, #assignissueDuedate, #statuschangedate1').datepicker({
            //End of Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled
            autoclose: true,
            changeMonth: true,
            dateFormat: 'd M yy',
            changeYear: true, //2021
            onClose: function () {
                $(':focus').blur();
            }
        });
        $('#dtStatusChangeTime').datetimepicker({
            format: 'LT',
        });
        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        }
        //addrow
        $(document).ready(function () {
           
            GetDefaultTaskType();
            //DefaultValue(ProjectID, null, "PageLoad");
            generateAssignIssueRow(counter);
            $("#addassignissuerow").on("click", function () {
                counter++;
                generateAssignIssueRow(counter);
                //Added By Usha Pandit On 02.04.2020 For not setting default due date
                $("#dtAssignIssueDueDate" + counter).val("");
                //End Of Added By Usha Pandit On 02.04.2020 For not setting default due date
            });

            //closable-alert
            $('.alert-autocloseable-danger').hide();

            $(document).on('click', '.close', function () {
                $(this).parent().hide();
            });


        });

        function generateAssignIssueRow(counter) {
             //Modified By Nikhil A on 04-feb-2022 --> Extra row is getting added on click of Assign Issue Tab
            if ($('#addr' + counter).length == '0') {
                //End Of Modified By Nikhil A on 04-feb-2022 --> Extra row is getting added on click of Assign Issue Tab

                var newRow = $("<tr id='addr" + counter + "'>");
                var cols = "";

                cols += '<td class="" id="Resource' + counter + '"><select class="form-control" style="width:120px;" onchange="cbResourceOnchange(this)" id="cboAssignResource' + counter + '"><option value=0>Select Resource</option></select></td>';
                cols += '<td class=""id="Task' + counter + '"><select class="form-control" style="width:120px;" id="cboAssignIssueTask' + counter + '"><option value=0>Select Task Type</option></select></td>';
                //cols += '<td class=""id="SubTask' + counter + '"><select class="form-control" style="width:120px;" id="cboAssignIssueSubtask' + counter + '"><option value=0>Select TaskSubType</option></select></td>';
            <%-- Commented & Added By Dipali V On 2nd june 2020--%>
                cols += '<td class=""id="DueDate' + counter + '"><input type="text" class="form-control" autocomplete="off" id="dtAssignIssueDueDate' + counter + '" readonly  style="background-color:white"/></td>';
                cols += '<td class=""id="StartDate' + counter + '"><input type="text" class="form-control" autocomplete="off" id="dtAssignIssueStartDate' + counter + '" readonly style="background-color:white"/></td>';
                cols += '<td class=""id="EndDate' + counter + '"><input type="text" class="form-control" autocomplete="off" id="dtAssignIssueEndDate' + counter + '" readonly style="background-color:white"/></td>';
            <%-- End of Commented & Added By Dipali V On 2nd june 2020--%>
                //Commented & Added y Dipali V On 13th Oct 2021 For  Work HOurs Issues
                //cols += '<td class=""id="WorkHours' + counter + '"><input type="text" class="form-control wkhour" maxlength = "5" autocomplete="off" id="AssignIssueWorkHours' + counter + '"/></td>';
                cols += '<td class=""id="WorkHours' + counter + '"><input type="text" class="form-control wkhour" maxlength = "" autocomplete="off" id="AssignIssueWorkHours' + counter + '"/></td>';
                // End of Commented & Added y Dipali V On 13th Oct 2021 For  Work HOurs Issues
                cols += '<td style="display:none;" class=""id="ReopenTask' + counter + '">N/A</td>';
                cols += '<td class="" id="Save' + counter + '">';
                cols += '<div class="custom_chckbox"><input type="checkbox" id="AssignIssueIsBillable' + counter + '" /><label for="AssignIssueIsBillable' + counter + '"></div>';
                cols += '<div id="htid' + counter + '" style="display:none"></div>';
                cols += '</td > ';
                cols += '<td class="AI_save_and_Del"id="SaveAndDelete' + counter + '">';
                <%If m_blnEditAccess = True Then%>
                cols += '<a class="SaveAssignIssue" id="SaveAssignIssue' + counter + '" href="javascript:;"><i class="far fa-save" id="btnSaveAssignIssue' + counter + '"></i></a>';
                cols += '<a href="javascript:;"><i class="far fa-trash-alt" id="DeleteAssignedIssue' + counter + '"></i></a>';
                <%End If%>

                cols += '</td > ';

                newRow.append(cols);
                $("table.assignissue_order_list").append(newRow);
            }
            var ResourceID = "cboAssignResource" + counter;
            var TaskID = "cboAssignIssueTask" + counter;
            //var SubTaskID = "cboAssignIssueSubtask" + counter;
            var dueDate = "dtAssignIssueDueDate" + counter;
            $("#" + dueDate).val(Duedate);

            var dtDueDateId = "AssignIssueDueDate" + counter;
            CustomfiledDatePicker(dtDueDateId);

            var dtStartDateId = "AssignIssueStartDate" + counter;
            CustomfiledDatePicker(dtStartDateId);

            var dtEndDateId = "AssignIssueEndDate" + counter;
            CustomfiledDatePicker(dtEndDateId);

            GetDefaultTaskType();
            GetTaskTypesAddNew(TaskID);
            GetResourcesAddNew(ResourceID);
            getSelectedEmployees();
            //$("#" + TaskID).change(function () {
            //    var TaskTypeID = $(this).children("option:selected").val();
            //    GetSubTaskTypesAddNew(TaskTypeID, SubTaskID);
            //})

            var dtStartDate = "#dtAssignIssueStartDate" + counter;
            var dtEndDate = "#dtAssignIssueEndDate" + counter;
            var IdWorkHours = "#AssignIssueWorkHours" + counter;
            var IDDueDate = "#dtAssignIssueDueDate" + counter;
            var IDIsBillable = "#AssignIssueIsBillable" + counter;

            //To Save or Assign the issue to the Resource
            var btnSaveID = "btnSaveAssignIssue" + counter;
            //Commented By Dipali V On 28th Sep 2019 Button Should be Dissabled After saving
            //if ($("#cboResource").val() != "0") {
            //    $("#cboResource").prop("disabled", "disabled");
            //}
            //End of Commented By Dipali V On 28th Sep 2019 Button Should be Dissabled After saving
            //Added By Dipali V On 20th Dec 2019 For Multiple validation Alter Issues
            $("#" + btnSaveID).click(function () {
                // $(".SaveAssignIssue").click(function () {
                //End of Added By Dipali V On 20th Dec 2019 For Multiple validation Alter Issues
                //var btns = this.id;
                //$("#" + btns).prop("disabled", "disabled");
                //console.log('save');
                var ctr = this.id;
                //var btns = ctr.replace('btn', '');
                //$("#" + btns).prop("disabled", true);
                //
                //ctr = ctr.replace('SaveAssignIssue', '');
                ctr = ctr.replace('btnSaveAssignIssue', '');
                var taskid = $('#htid' + ctr).text();
                if (taskid != '') {
                    //return false;
                }
                var ResourceID = 'cboAssignResource' + ctr;
                var TaskID = 'cboAssignIssueTask' + ctr;
                var Resource = $('select#' + ResourceID + ' option:selected').val();
                var TaskTypeId = $('select#' + TaskID + ' option:selected').val();
                var ModuleName = $('select#' + TaskID + ' option:selected').text();
                //var SubTaskTypeId = $('select#' + SubTaskID + ' option:selected').val();
                var dtStartDate = "#dtAssignIssueStartDate" + ctr;
                var dtEndDate = "#dtAssignIssueEndDate" + ctr;
                var IdWorkHours = "#AssignIssueWorkHours" + ctr;
                var IDDueDate = "#dtAssignIssueDueDate" + ctr;
                var IDIsBillable = "#AssignIssueIsBillable" + ctr;

                var StartDate = $(dtStartDate).val();
                var EndDate = $(dtEndDate).val();
                var WorkHours = $(IdWorkHours).val();
                var DueDate = $(IDDueDate).val();
                var ReportedDate = $("#dtReportedDate").val();
                var IsBillable;
                if ($(IDIsBillable).prop("checked") == true) {
                    IsBillable = 1;
                }
                else {
                    IsBillable = 0;
                }

                if (Resource == 0) {
                    alertify.error("Please select the Resource..");
                    //Added By Dipali V On 20th Dec 2019 For Control Focus Issues
                    $("#cboAssignResource" + ctr).focus();
                    return false;
                }
                else if (TaskTypeId == 0) {
                    alertify.error("Please select the Task Type..");
                    //Added By Dipali V On 20th Dec 2019 For Control Focus Issues
                    $("#cboAssignIssueTask" + ctr).focus();
                    return false;
                }
                else if ($(IDDueDate).val() == "") {
                    alertify.error("Please select the Due Date..");
                    $("#dtAssignIssueDueDate" + ctr).focus();
                    return false;
                }
                //else if (SubTaskTypeId == 0) {
                //    alertify.error("Please select the SubTask Type..");
                //    return false;
                //}
                else if (StartDate == 0) {
                    alertify.error("Please select the Start Date..");
                   //Added By Dipali V On 20th Dec 2019 For Control Focus Issues
                    $("#dtAssignIssueStartDate" + ctr).focus();
                    return false;
                }
                else if (EndDate == 0) {
                    alertify.error("Please select the End Date..");
                    //Added By Dipali V On 20th Dec 2019 For Control Focus Issues
                    $("#dtAssignIssueEndDate" + ctr).focus();
                    return false;
                }
                //Commented And Added By Usha Pandit On 16.03.2020 for work hours validation
                //else if (validateWorkHours(WorkHours) == false) {
                //      //Added By Dipali V On 20th Dec 2019 For Control Focus Issues
                //    $("#AssignIssueWorkHours" + ctr).focus();
                //    return false;
                //}
                else if (ValidateWorkHourFormat(ctr) == false) {
                    //Added By Dipali V On 20th Dec 2019 For Control Focus Issues                    
                    $("#AssignIssueWorkHours" + ctr).focus();
                    return false;
                }
                //End Of Added By Usha Pandit On 16.03.2020 for work hours validation

                var ValMessage = ValidateAssignDate(ProjectID, StartDate, EndDate, DueDate, ReportedDate, dtStartDate, dtEndDate, Resource);
                if (ValMessage == false) {
                    return false;
                }
                //var btns = this.id;
                //$("#"+btns).prop("disabled", "disabled");
                WorkHours = convertWHToDecimal(WorkHours);
                //
                //var AssignIssue = { IssueId: IssueID, ProjectId: ProjectID, EmployeeId: Resource, Duration: WorkHours, StartDate: StartDate, EndDate: EndDate, BillableYN: IsBillable, TaskTypeId: TaskTypeId, SubTaskTypeId: SubTaskTypeId, Summary: Summary, Description: Description, ModuleName: ModuleName };
                var AssignIssue = { IssueId: IssueID, ProjectId: ProjectID, EmployeeId: Resource, Duration: WorkHours, StartDate: StartDate, EndDate: EndDate, BillableYN: IsBillable, TaskTypeId: TaskTypeId, Summary: Summary, Description: Description, ModuleName: ModuleName };
                var param = JSON.stringify(AssignIssue);
                var result = AJAXCallWithResult("/api/IB_IssueDetails/SaveAssignIssue", param, false);
                var result = result.split("&&");
                if (result[0] != undefined) {
                    if (result[0] == -1) {
                        UpdateIssueTable(WorkHours, DueDate);
                        //Commented & Added By Dipali V On 1st Dec 2021 For On Blur Get Hours 
                         calculateTotalWkHrs();
                       //End of Commented & Added By Dipali V On 1st Dec 2021 For On Blur Get Hours 
                        alertify.success("Issue is assigned sucessfully.");
                        $('#' + ResourceID).attr('disabled', 'disabled');
                        //start vishal mahajan 04-12-2019
                        $('#htid' + ctr).text(ctr);
                        //end vishal mahajan 04-12-2019
                        if (result[1] == "1") {
                            // debugger;
                            //Commented & Added By Dipali V  On 18th Feb 2021 For Task name Getting blank
                              window.open("../Email/SendEmail.aspx?MessageID=14&IssueID=" + IssueID + "&ProjectID=" + ProjectID + "&EmployeeID=" + EmployeeId + "&SelectedEmployeeID=" + Resource + "", '_blank', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                            //window.open("../Email/SendEmail.aspx?MessageID=14&IssueID=" + IssueID + "&ProjectID=" + ProjectID + "&EmployeeID=" + EmployeeId + "", '_blank', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                     
                        }
                        else {

                        }
                    }
                }
                //$("#"+btns).prop("disabled", false);
            })
            var btnDeleteID = "DeleteAssignedIssue" + counter;
            $("#" + btnDeleteID).click(function () {
                var ctr = this.id;
                ctr = ctr.replace('DeleteAssignedIssue', '');
                var taskid = $('#htid' + ctr).text();
                if (taskid == '') {
                    $("#addr" + ctr).remove();
                    calculateTotalWkHrs();
                    return false;
                }
                var EmployeeID = $('select#' + ResourceID + ' option:selected').val();
                //Added by Swapnagandha K On 22 Oct 2019 To Validate Assigned Issue
                if (ValidateDeleteAssignedIssue(EmployeeID) == "1") {
                    //End Added by Swapnagandha K On 22 Oct 2019 To Validate Assigned Issue

                    DeleteAssignedIssue(EmployeeID, ctr);
                    var DueDate = $(IDDueDate).val();
                    UpdateIssueTable(0, DueDate);
                }
            })
            //Added by Swapnagandha K On 22 Oct 2019 To Validate Assigned Issue
            function ValidateDeleteAssignedIssue(EmployeeID) {

                var ValidateAssignedIssue = { IssueId: IssueID, ProjectId: ProjectID, EmployeeID: EmployeeID };
                var param = JSON.stringify(ValidateAssignedIssue);
                var strResult = AJAXCallWithResult("/api/IB_IssueDetails/ValidateDeleteAssignedIssue", param, false);
                if (strResult[0].Column1 != "1") {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strResult[0].Column1, 'error', 25);
                    return "0";
                }
                else {
                    return "1";
                }
            }
            //End Added by Swapnagandha K On 22 Oct 2019 To Validate Assigned Issue
            //GetResourcesAddNew(ResourceID);
            $(IdWorkHours).blur(function () {
                //
                //var totalhrsdec = 0.0;
                //var totalhrs = 0;
                //$("table.assignissue_order_list .wkhour").each(function () {
                //    var id = this.id;
                //    var wkhr = $("#" + id).val();
                //    totalhrsdec += parseFloat(convertWHToDecimal(wkhr));
                //})
                //totalhrs = convertWHToTime(totalhrsdec);
                //$('#lblTotalWorkHours').text(totalhrs);
//Commented & Added By Dipali V On 1st Dec 2021 For On Blur Get Hours 
                //calculateTotalWkHrs();
//End of Commented & Added By Dipali V On 1st Dec 2021 For On Blur Get Hours 
            })
        }

        function calculateTotalWkHrs() {
            var totalhrsdec = 0.0;
            var totalhrs = 0;
            $("table.assignissue_order_list .wkhour").each(function () {
                var id = this.id;
                var wkhr = $("#" + id).val();
                wkhr = (wkhr == '' ? "0" : wkhr);
                totalhrsdec += parseFloat(convertWHToDecimal(wkhr));
            })
            if (totalhrsdec != undefined && totalhrsdec != null && totalhrsdec != "") {
                totalhrsdec = totalhrsdec.toFixed(2);
            }
            totalhrs = convertWHToTime(totalhrsdec);
            $('#lblTotalWorkHours').text(totalhrs);
        }
    </script>

    <!--checkbox-checkAll-->
    <script type="text/javascript">
        //Added By Usha Pandit On 14.04.2021 For datepicker display issue
        $(".assignissue_order_list").parent().scroll(function () {
            $(':focus').blur();
        });
        //End Of Added By Usha Pandit On 14.04.2021 For datepicker display issue
        $(document).ready(function () {
            //debugger;

           
            // Check or Uncheck All checkboxes
            $("#Attachments1").change(function () {
                var checked = $(this).is(':checked');
                if (checked) {
                    $(".chcktbl").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $(".chcktbl").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });

            // Changing state of CheckAll checkbox 
            $("#tbodyAttachment .chcktbl").click(function () {
                //  
                if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                    $(".chckHead").prop("checked", true);
                } else {
                    $(".chckHead").removeAttr("checked");
                }
            });

            $("#Attachments2").change(function () {
                //   
                var checked = $(this).is(':checked');
                if (checked) {
                    $(".chcktbld").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $(".chcktbld").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });

            // Changing state of CheckAll checkbox 
            $("#tbodyAttachment .chcktbld").click(function () {
                // 
                if ($(".chcktbld").length == $(".chcktbld:checked").length) {
                    $(".chckHeadd").prop("checked", true);
                } else {
                    $(".chckHeadd").removeAttr("checked");
                }
            });

        });


        var AllfileDataDiscussion =[];
        function SelectFile() {
            var strFileCount = $("#btnSelectFile").attr("FileCount");

            var objCurrentFileControl = $("#txtFileName" + strFileCount);
            if (FileCount_toDisable == 5) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("User can attach maximum five files at a time.", 'error', 25);
                return;
            }
            objCurrentFileControl.click();

            //Added by imran on 17-10-2022
            AllfileDataDiscussion.push(parseInt(strFileCount));
            //End of comment by imran on 17-10-2022
        }


        function SelectMainFile() {
            var strFileCount = $("#btnMainSelectFile").attr("MainFileCount");

            var objCurrentFileControl = $("#txtMainFileName" + strFileCount);
            if (MainFileCount_toDisable == 5) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("User can attach maximum five files at a time.", 'error', 25);
                return;
            }
            
            //Added by imran on 17-10-2022
            AllfileData.push(parseInt(strFileCount));
            //End of comment by imran on 17-10-2022

            objCurrentFileControl.click();
        }
        var files = "";
        var FileCount = 0;
        var AllfileData = [];
        function addFileinGrid() {
           // debugger;
            var LoginType = "<%= Session("LoginType").ToString() %>";
            var objtxtFileName = document.getElementById('txtFileName' + FileCount);
            var fileName = objtxtFileName.value;
            files = objtxtFileName.files;
            for (var i = 0; i < files.length; i++) {
                filedata.append(files[i].name, files[i]);
            }

            $.ajax({
                url: encodeURI(url + '/api/IB_AddNewIssue/GetFileType'),
                data: filedata,
                cache: false,
                async: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',

                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    if (result == true) {
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
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);

                        newCell.innerHTML = fileName;

                        newCell = newRow.insertCell(2);
                        //Commented And Added By Usha Pandit On 23.07.2020 For selecting description/comments upto 1000 characters
                        //newCell.innerHTML = "<Textarea wrap='Hard'  name='txtComments' id='txtComments" + FileCount + "' class='form-control' style='width:250px  ; height:50px  ; text-align:Left' maxlength='2000' onkeyup='FindMaxLength(this)' ></Textarea>";
                        newCell.innerHTML = "<Textarea wrap='Hard'  name='txtComments' id='txtComments" + FileCount + "' class='form-control' style='width:250px  ; height:50px  ; text-align:Left' maxlength='1000' onkeyup='FindMaxLength(this)' ></Textarea>";
                        //End Of Added By Usha Pandit On 23.07.2020 For selecting description/comments upto 1000 characters
                        //Added By Rutuja D. on 23 May 2022
                        newCell = newRow.insertCell(3);
                        var strHTML = "";
                        strHTML +='<% CommonFunctions.HTMLControls.DrawComboBox("cboDocumenttype" + "FileCount", "SELECT 'Select Document Type'",,, "class=""form-control"" onChange=""GetDocumentSubType(2)"" ",,,, , ).Replace("'", "\'")%>';
                        newCell.innerHTML = strHTML.replace(/FileCount/g, FileCount);
                        newCell = newRow.insertCell(4);
                        var strHTML1= "";
                        strHTML1 +='<% CommonFunctions.HTMLControls.DrawComboBox("cboDocumentSubtype" + "FileCount", "Select 'Select Document Sub Type'",,, "class=""form-control"" onChange=""""",,,, , ).Replace("'", "\'")%>';
                        newCell.innerHTML = strHTML1.replace(/FileCount/g, FileCount);
                        //End of Added By Rutuja D. on 23 May 2022
                        newCell = newRow.insertCell(5);

                        newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveAttachement(" + FileCount + ")' Title='Remove Attachment' >(Remove)</A>";

                        parentTD = objtxtFileName.parentNode;
                        objtxtFileName.style.display = "none";

                        GetDocumentType('tblFiles', 'FILENAME');
                       // GetDocumentSubType(2);

                        FileCount++;
                        FileCount_toDisable++;

                        var FileDiscControl;
                        FileDiscControl = document.createElement("INPUT");
                        FileDiscControl.type = "FILE";
                        FileDiscControl.id = "txtFileName" + FileCount;
                        FileDiscControl.name = "txtFileName" + FileCount;
                        FileDiscControl.className = 'clsTextBox clsDiscFileControl';
                        FileDiscControl.size = 74;
                        FileDiscControl
                        FileDiscControl.onkeydown = function () { return false; };
                        FileDiscControl.onbeforepaste = function () { return false; };
                        FileDiscControl.onpaste = function () { return false; };
                        FileDiscControl.onkeydown = function () { return false; };
                        FileDiscControl.onbeforepaste = function () { return false; };
                        FileDiscControl.onpaste = function () { return false; };
                        FileDiscControl.onchange = addFileinGrid;

                        //if (FileCount_toDisable == 5)
                        //    FileDiscControl.disabled = true;

                        parentTD.appendChild(FileDiscControl);

                        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                        objtxtFileName.style.display = "none";
                        $("#btnSelectFile").attr("FileCount", FileCount);
                        filedata = new FormData();
                    }
                    else {
                        alertify.error("Invalid Content Type!!");
                        //var index = fileName.lastIndexOf("\\");
                        //if (index == -1)
                        //    index = fileName.lastIndexOf("/");

                        //if (index != -1)
                        //    fileName = fileName.substring(index + 1, fileName.length);
                        ////alert(fileName);
                        //filedata.delete(fileName);
                        filedata = new FormData();
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

            objFileGrid.deleteRow(objTR.rowIndex);

            toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
            document.getElementById("txtFileName" + FileCount).disabled = false;;

            if (objFileGrid.rows.length == 1) {
                objFileGrid.style.display = 'none';
            }
            fileObject = [];
            FileCount_toDisable--;

            //Added by imran on 18-10-2022
            k = parseInt(FileNO);
            var index1 = AllfileDataDiscussion.indexOf(k);
            AllfileDataDiscussion.splice(index1, 1);
            //End of comment by imran on 18-10-2022
        }

        var MainFileCount = 0;
        var MainFileCount_toDisable = 0;
        var mainfileObject = [];
        var maindata = new FormData();
        var files = "";
        var isValidTypeExeCheck;
        async function addMainFileinGrid() {
            //debugger;
            var LoginType = "<%= Session("LoginType").ToString() %>";
            var objtxtFileName = document.getElementById('txtMainFileName' + MainFileCount);
            var fileName = objtxtFileName.value;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            //added by Parth Godshelwar
            var objFileName = objtxtFileName;
            isValidTypeExeCheck = false;

            //Commented and Added by Aditya J. on 25-11-2024
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            //End of comment Added by Aditya J. on 25-11-2024
            
            isValidTypeExeCheck = ValidExtsExe.includes(extension);
           
            if (isValidTypeExeCheck) {
                const file = objFileName.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alert("File is valid and ready to upload.");
                    })
                    .catch(error => {
                        console.log(error);
                        alert("Upload restricted: This file contains an embedded executable (EXE) file.");
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


            
            files = objtxtFileName.files;
            for (var i = 0; i < files.length; i++) {
                maindata.append(files[i].name, files[i]);
            }

            $.ajax({
                url: encodeURI(url + '/api/IB_AddNewIssue/GetFileType'),
                data: maindata,
                cache: false,
                contentType: false,
                processData: false,
                async: false,
                method: 'POST',
                type: 'POST',

                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    if (result == true) {

                        var LoginType = "<%= Session("LoginType").ToString() %>";
                        var objtxtFileName = document.getElementById('txtMainFileName' + MainFileCount);
                        //var objFileGrid = document.getElementById('tblMainFiles');
                        var objFileGrid = document.getElementById('bodyMainFiles');
                        objFileGrid.style.display = "";

                        $('#btnAddAttachment').css("visibility", "visible")
                        $('#tblMainFiles').show();
                        var newRow = objFileGrid.insertRow(objFileGrid.rows.length);
                        objtxtFileName.style.display = "none";
                        newRow.id = 'MAINFILENAME' + MainFileCount;
                        newRow.name = 'txtMainFileName';
                        newRow.className = "clsTREven";
                        var newCell = newRow.insertCell(0);
                        newCell.innerHTML = "<i class='fa fa-file-pdf-o' aria-hidden='true'></i>";

                        newCell = newRow.insertCell(1);
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);

                        newCell.innerHTML = fileName;

                        newCell = newRow.insertCell(2);
                        //Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength FindMaxLength()
                        newCell.innerHTML = "<Textarea wrap='Hard'  name='txtMainComments' id='txtMainComments" + MainFileCount + "' class='form-control' style='height:50px  ; text-align:Left' maxlength='2000' onkeyup='FindMaxLength(this)'></Textarea>";
                        //End Added by Swapnagandha K. On 07 nov 2019 For Issue -To add alert for maxlength FindMaxLength()
                        //Added By Rutuja D. on 23 May 2022
                        newCell = newRow.insertCell(3);
                        var strHTML = "";
                        strHTML +='<% CommonFunctions.HTMLControls.DrawComboBox("cboDocumenttype" + "MainFileCount", "SELECT 'Select Document Type'",,, "class=""form-control"" onChange=""GetDocumentSubType(1)"" ",,,, , ).Replace("'", "\'")%>';
                       /* strHTML += '<span id="" style="color:red;"> * </span>';*/
                        newCell.innerHTML = strHTML.replace(/MainFileCount/g, MainFileCount);
                        newCell = newRow.insertCell(4);
                        var strHTML1= "";
                        strHTML1 +='<% CommonFunctions.HTMLControls.DrawComboBox("cboDocumentSubtype" + "MainFileCount", "Select 'Select Document Sub Type'",,, "class=""form-control"" onChange=""""",,,, , ).Replace("'", "\'")%>';
                        newCell.innerHTML = strHTML1.replace(/MainFileCount/g, MainFileCount);
                        //End of Added By Rutuja D. on 23 May 2022
                        newCell = newRow.insertCell(5);
                        newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveMainAttachement(" + MainFileCount + ")' Title='Remove Attachment' >(Remove)</A>";

                        parentTD = objtxtFileName.parentNode;
                        objtxtFileName.style.display = "none";

                        MainFileCount++;
                        MainFileCount_toDisable++;
                        //GetDocumentType('tblMainFiles', 'MAINFILENAME');
                        GetDocumentType('bodyMainFiles', 'MAINFILENAME');
                        //GetDocumentSubType(1);

                        var FileControl;
                        FileControl = document.createElement("INPUT");
                        FileControl.type = "File";
                        FileControl.id = "txtMainFileName" + MainFileCount;
                        FileControl.name = "txtMainFileName" + MainFileCount;
                        FileControl.className = 'clsTextBox clsFileControl';
                        FileControl.size = 74;

                        FileControl.onkeydown = function () { return false; };
                        FileControl.onbeforepaste = function () { return false; };
                        FileControl.onpaste = function () { return false; };
                        FileControl.onkeydown = function () { return false; };
                        FileControl.onbeforepaste = function () { return false; };
                        FileControl.onpaste = function () { return false; };
                        FileControl.onchange = addMainFileinGrid;

                        //if (MainFileCount_toDisable == 5)
                        //    FileControl.disabled = true;

                        parentTD.appendChild(FileControl);

                        var objtxtFileName = document.getElementById('txtMainFileName' + MainFileCount);
                        objtxtFileName.style.display = "none";
                        $("#btnMainSelectFile").attr("MainFileCount", MainFileCount);
                        maindata = new FormData();
                        ArrFileCount.push(MainFileCount);
                    }
                    else {
                        alertify.error("Invalid Content Type!!");
                        //var index = fileName.lastIndexOf("\\");
                        //if (index == -1)
                        //    index = fileName.lastIndexOf("/");

                        //if (index != -1)
                        //    fileName = fileName.substring(index + 1, fileName.length);
                        //maindata.delete(fileName);
                        maindata = new FormData();
                    }
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }

        var k=0;
        function RemoveMainAttachement(FileNO) {
            
            //Added by imran on 17-10-2022
            k = parseInt(FileNO);
            var index1 = AllfileData.indexOf(k);
            AllfileData.splice(index1, 1);
            //End of comment by imran on 17-10-2022

            var objTR = document.getElementById('MAINFILENAME' + FileNO);
            var toRemoveFileControl = document.getElementById('txtMainFileName' + FileNO);
            var objFileGrid = document.getElementById('tblMainFiles');

            objFileGrid.deleteRow(objTR.rowIndex);

            toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
            document.getElementById("txtMainFileName" + MainFileCount).disabled = false;

            if (objFileGrid.rows.length <= 1) {
                objFileGrid.style.display = 'none';
                $('#btnAddAttachment').css("visibility", "hidden");
            }
            mainfileObject = [];
            MainFileCount_toDisable--;

            
        }

        function AddAttachment_OnClick() {
            var Comment = $("#txtMainComments0").val();
            if (ValidateAttachment('tblMainFiles', 'MAINFILENAME', 'txtMainFileName') == false) {
                return false;
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022          
            if (checkSpecialCharacter(Comment, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Comment should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                /*$(ControlValidationFieldID[i]).focus()*/
                $("#txtMainComments0").focus();
                return false;
            }
            MainAttachement(IssueID);
           // $('#tblMainFiles').html("");
            //Added by dipali V on 11th Sep 2019 for multiple insertation of attachments
            Clear_NewAttachment();
            //End of Added by dipali V on 11th Sep 2019 for multiple insertation of attachments
            var objFileGrid = document.getElementById('tblMainFiles');
            objFileGrid.style.display = 'none';
            $('#btnAddAttachment').css("visibility", "hidden");
            GetAttachmentDetails(IssueID);
            $("#tab_4").hide();
            clearTooltip();
        }

        //Added by dipali V on 11th Sep 2019 for multiple insertation of attachments
        function Clear_NewAttachment() {
            // document.getElementById('dIvaddattachment').style.display='none';

            $("#tblMainFiles").hide();
            //$(".bottom-bar").css("display","none")
            $("#tblMainFiles").find("thead").find(".clsTREven").remove();
            $("#tblMainFiles").find("tbody").find(".clsTREven").remove();
            $("#tblMainFiles").hide();

            $(".clsFileControl").remove();

            $("#txtMainFileName0").remove();

            var FileControl;

            FileControl = document.createElement("INPUT");
            FileControl.type = "FILE";
            FileControl.id = "txtMainFileName0";
            FileControl.name = "txtMainFileName0";
            FileControl.className = 'clsTextBox clsFileControl';
            FileControl.size = 100;
            FileControl.style = "display:none;";


            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onchange = addMainFileinGrid;
            FileControl.disabled = false;

            $("#btnMainSelectFile").attr("mainfilecount", 0);

            MainFileCount_toDisable = 0;
            MainFileCount = 0;
            $(".clsFileControl").hide();
            document.getElementById("MainFileControlUploadDiv").appendChild(FileControl);
            maindata = new FormData();
        }


        function clear_discussionattachement() {

            $("#tblFiles").hide();
            //$(".bottom-bar").css("display","none")
            $("#tblFiles").find("thead").find(".clsTREven").remove();
            $("#tblFiles").find("tbody").find(".clsTREven").remove();
            $("#tblFiles").hide();

            $(".clsDiscFileControl").remove();

            $("#txtFileName0").remove();

            var FileDiscControl;
            FileDiscControl = document.createElement("INPUT");
            FileDiscControl.type = "FILE";
            FileDiscControl.id = "txtFileName0";
            FileDiscControl.name = "txtFileName0";
            FileDiscControl.className = 'clsTextBox clsDiscFileControl';
            FileDiscControl.size = 100;
            FileDiscControl.style = "display:none;";


            FileDiscControl.onkeydown = function () { return false; };
            FileDiscControl.onbeforepaste = function () { return false; };
            FileDiscControl.onpaste = function () { return false; };
            FileDiscControl.onkeydown = function () { return false; };
            FileDiscControl.onbeforepaste = function () { return false; };
            FileDiscControl.onpaste = function () { return false; };
            FileDiscControl.onchange = addFileinGrid;
            FileDiscControl.disabled = false;
            $("#btnSelectFile").attr("filecount", 0);

            FileCount = 0;
            FileCount_toDisable = 0;
            $(".clsDiscFileControl").hide();
            document.getElementById("FileControlUploadDiv").appendChild(FileDiscControl);
            filedata = new FormData();

        }
        //End of Added by dipali V on 11th Sep 2019 for multiple insertation of attachments

        function removeDuplicates(arr) {
            return arr.filter((item,
                index) => arr.indexOf(item) === index);
        }


        var validateflag;
        function UpdateRequest_OnClick() {
            //
           // debugger;
            var AllValue = new Array();
            var ArrayAllData = new Array();
            var ArraySelectTag = new Array();
            var ArrayInputTag = new Array();
            var ArrayTextAreaTag = new Array();
            var ArrayExtCustomFields = new Array();

            // validateflag = 
            checkValidation();
           
            //Added By Dipali  V On 21st Oct 2020 For Validation
            if ($("#textsummary").val().trim() == "") {
                alertify.error("Summary should not be blank.");
                EditDetails();
                $("#textsummary").focus();
                validateflag = false;
                return;
            }

            if ($("#textIssueDescription").val().trim() == "") {
                alertify.error("Description should not be blank.");
                EditDetails();
                $("#textIssueDescription").focus();
                validateflag = false;
                return;
            }

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
            //Endof Added By Dipali V On 19th Jan 2022 For Special Char Res For Custom Fields

            //End of Added By Dipali  V On 21st Oct 2020 For Validation
            //  alert(validateflag);
            if (validateflag == true && CustomFieldValidation() == 0 && ExtCustomFieldValidation() == 0) {
                var ProjectId = "ProjectID=" + encodeURI(commonProperty.ProjectId);
                ArrayAllData.push(encodeURI(ProjectId));

                $('select', '#sidebarpanel').each(function () {
                    if (ArraySelectTag.indexOf($(this).attr('id')) === -1) {
                        ArraySelectTag.push($(this).attr('id'));
                        console.log($(this).attr('id'))
                    }
                });

                for (var i = 0; i < ArraySelectTag.length; i++) {
                    var ID = "#" + ArraySelectTag[i];
                    if ($(ID).is(":hidden") == false) {
                        if (ArraySelectTag[i].indexOf("cboextCustomField") != -1) {
                            var FieldName = ArraySelectTag[i].replace('cboext', '');
                            var cboSelectedValue = $(ID).children("option:selected").text();
                            var cboSelectedVal = $(ID).children("option:selected").val();
                            if (cboSelectedVal == 0) {
                                cboSelectedValue = "NULL";
                            }
                            else {
                                var NewSelectedValue = "'" + cboSelectedValue + "'";
                                cboSelectedValue = NewSelectedValue;
                            }
                            var NameValue = FieldName + "=" + encodeURI(cboSelectedValue);
                            ArrayExtCustomFields.push(NameValue);
                        }
                        else if (ArraySelectTag[i].indexOf("cboCustomField") != -1) {
                            var cboSelectedValue = $(ID).children("option:selected").text();
                            var cboSelectedVal = $(ID).children("option:selected").val();
                            var FieldName = ArraySelectTag[i].replace('cbo', '');

                            if (cboSelectedVal == 0) {
                                cboSelectedValue = "NULL";
                            }

                            if (cboSelectedValue == "NULL") {
                                var NewSelectedValue = "" + cboSelectedValue + "";

                                cboSelectedValue = NewSelectedValue;
                            }
                            else {
                                var NewSelectedValue = "'" + cboSelectedValue + "'";
                                cboSelectedValue = NewSelectedValue;
                            }
                            var NameValue = FieldName + "=" + encodeURI(cboSelectedValue);
                            ArrayAllData.push(NameValue);
                        }
                        else {
                            var cboSelectedValue = $(ID).children("option:selected").val();
                            //Added By Dipali V On 14th Sep 2019 For Deliverable tab Refresh Issue
                            if (ID == "#cboDeliverableID") {
                                if (cboSelectedValue == 0) {
                                    cboSelectedValue = "NULL";
                                    DeliverableID = 0;
                                }
                                else {
                                    $("#tab_4").hide();
                                    DeliverableID = cboSelectedValue;
                                }

                            }
                            //End of Added By Dipali V On 14th Sep 2019 For Deliverable tab Refresh Issue

                            if (cboSelectedValue == 0) {
                                cboSelectedValue = "NULL";
                            }

                            var FieldName = ArraySelectTag[i].replace('cbo', '');

                            if (FieldName == "Product") {
                                var NewFieldName = FieldName.replace("Product", "ProductVersionID");
                                FieldName = NewFieldName;
                            }
                            //if (FieldName == "CustomerIssueID") {
                            //    var NewFieldName = FieldName.replace("CustomerIssueID", "CustomerID");
                            //    FieldName = NewFieldName;
                            //}
                            if (FieldName == "AssignToName") {
                                var NewFieldName = FieldName.replace("AssignToName", "AssignTo");
                                FieldName = NewFieldName;
                            }
                            if (FieldName == "CodedByName") {
                                var NewFieldName = FieldName.replace("CodedByName", "CodedBy");
                                FieldName = NewFieldName;
                            }
                            if (FieldName == "ChangeRequestName") {
                                var NewFieldName = FieldName.replace("ChangeRequestName", "ChangeRequestID");
                                FieldName = NewFieldName;
                            }
                            if (FieldName == "UserStory") {
                                var NewFieldName = FieldName.replace("UserStory", "UserStoryID");
                                FieldName = NewFieldName;
                            }
                            if (FieldName == "Iteration") {
                                var NewFieldName = FieldName.replace("Iteration", "IterationID");
                                FieldName = NewFieldName;
                            }
                            if (FieldName == "Release") {
                                var NewFieldName = FieldName.replace("Release", "ReleaseID");
                                FieldName = NewFieldName;
                            }
                            if (FieldName == "Module") {
                                var NewFieldName = FieldName.replace("Module", "ComponentID");
                                FieldName = NewFieldName;
                            }

                            if ($.isNumeric(cboSelectedValue) != true) {
                                //debugger
                                if (cboSelectedValue == "NULL") {
                                    var NewSelectedValue = "" + cboSelectedValue + "";
                                    cboSelectedValue = NewSelectedValue;
                                }
                                else {
                                    //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                    //var NewSelectedValue = "'" + cboSelectedValue + "'";
                                    if (cboSelectedValue != undefined) {
                                        var NewSelectedValue = "'" + cboSelectedValue.replace(/\'/g, "''") + "'";
                                        //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                        cboSelectedValue = NewSelectedValue;
                                    }
                                }
                                if (cboSelectedValue == "'undefined'") {
                                    cboSelectedValue = "0";
                                    if (cboSelectedValue == 0) {
                                        cboSelectedValue = "NULL";
                                    }
                                    if (cboSelectedValue == "NULL") {
                                        var NewSelectedValue = "" + cboSelectedValue + "";
                                        cboSelectedValue = NewSelectedValue;
                                    }
                                }
                                var NameValue = FieldName + "=" + encodeURI(cboSelectedValue);
                                ArrayAllData.push(NameValue);
                            }
                            else {
                                var NameValue = FieldName + "=" + encodeURI(cboSelectedValue);
                                ArrayAllData.push(NameValue);
                            }
                        }
                    }
                }

                $('input', '#sidebarpanel').each(function () {
                    if (ArrayInputTag.indexOf($(this).attr('id')) === -1) {
                        ArrayInputTag.push($(this).attr('id'));
                    }
                });

                for (var j = 0; j < ArrayInputTag.length; j++) {
                    var ID = "#" + ArrayInputTag[j];
                    if (ArrayInputTag[j].indexOf("txtextCustomFieldText") != -1) {
                        var FieldName = ArrayInputTag[j].replace('txtext', '');
                        var txtvalue = $(ID).val();
                        if (txtvalue == 0) {
                            txtvalue = "NULL";
                        }
                        else {
                            //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                            //var NewSelectedValue = "'" + txtvalue + "'";
                            var NewSelectedValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                            //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                            txtvalue = NewSelectedValue;
                        }
                        var NameValue = FieldName + "=" + encodeURI(txtvalue);
                        ArrayExtCustomFields.push(NameValue);
                    }
                    else if (ArrayInputTag[j].indexOf("dt") != -1) {
                        if (ArrayInputTag[j].indexOf("dtextCustomFieldDate") != -1) {
                            var FieldName = ArrayInputTag[j].replace('dtext', '');
                            var txtvalue = $(ID).val();
                            if (txtvalue == 0) {
                                txtvalue = "NULL";
                            }
                            else {
                                //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                //var NewTextValue = "'" + txtvalue + "'";
                                var NewTextValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                                //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                txtvalue = NewTextValue;
                            }
                            var NameValue = FieldName + "=" + encodeURI(txtvalue);
                            ArrayExtCustomFields.push(NameValue);
                        }
                        else if (ArrayInputTag[j].indexOf("dtCustomFieldDate") != -1) {
                            var FieldName = ArrayInputTag[j].replace('dt', '');
                            var txtvalue = $(ID).val();
                            if (txtvalue == 0) {
                                txtvalue = "NULL";
                                var NameValue = FieldName + "=" + encodeURI(txtvalue);
                                ArrayAllData.push(NameValue);
                            }
                            else {
                                //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                //var NewTextValue = "'" + txtvalue + "'";
                                var NewTextValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                                //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                txtvalue = NewTextValue;
                                var NameValue = FieldName + "=" + txtvalue;
                                ArrayAllData.push(NameValue);
                            }
                        }
                        else {
                            var txtvalue = $(ID).val();
                            var FieldName = ArrayInputTag[j].replace('dt', '');//Added By Rutuja D. on 4 July 2022 For Get Exact FieldName
                            if (txtvalue == 0) {
                                txtvalue = "NULL";
                                var NameValue = FieldName + "=" + encodeURI(txtvalue);
                                ArrayAllData.push(NameValue);
                            }
                            else {
                                //debugger;
                                var FieldName = ArrayInputTag[j].replace('dt', '');

                                if (FieldName == "ReportedTime") {
                                    //var ConvertedTime = convertTime12to24(txtvalue);
                                    //var ConvertedTime = convertTime12to24(txtvalue);
                                    var ConvertedTime = txtvalue;
                                    var NewTextValue = "'" + ConvertedTime + "'";
                                    txtvalue = NewTextValue;
                                    var NameValue = FieldName + "=" + encodeURI(txtvalue);
                                    ArrayAllData.push(NameValue);
                                }
                                else {
                                    //Added By Usha Pandit On 26.05.2021 For getting 24 hour format
                                    if (FieldName == "StatusChangeTime") {
                                        txtvalue = convertTo24Hour(txtvalue.toLowerCase());
                                        txtvalue = txtvalue.trim();
                                    }
                                    //End Of Added By Usha Pandit On 26.05.2021 For getting 24 hour format
                                    //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                    //var NewTextValue = "'" + txtvalue + "'";
                                    var NewTextValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                                    //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                    txtvalue = NewTextValue;
                                    var NameValue = FieldName + "=" + encodeURI(txtvalue);
                                    ArrayAllData.push(NameValue);
                                }
                            }
                        }
                    }
                    else {
                        var FieldName = ArrayInputTag[j].replace('txt', '');

                        var txtvalue = $(ID).val();
                        if (txtvalue == 0) {
                            txtvalue = "NULL";

                            if (FieldName == "CustomerIssueID1") {
                                var NewFieldName = FieldName.replace("CustomerIssueID1", "CustomerIssueID");
                                if ($("#txtCustomerIssueID1").val().toString().trim() == "0") {
                                    txtvalue = 0;
                                }
                                var NewTextValue = "" + txtvalue + "";
                                txtvalue = NewTextValue;
                                var NameValue = NewFieldName + "=" + encodeURI(txtvalue);
                                ArrayAllData.push(NameValue);
                            }
                            else {
                                var NewTextValue = "" + txtvalue + "";
                                txtvalue = NewTextValue;
                                var NameValue = FieldName + "=" + encodeURI(txtvalue);
                                ArrayAllData.push(NameValue);
                            }
                        }
                        else {
                            var FieldName = ArrayInputTag[j].replace('txt', '');
                            if (FieldName == "CustomerIssueID1") {
                                var NewFieldName = FieldName.replace("CustomerIssueID1", "CustomerIssueID");
                                //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                //var NewTextValue = "'" + txtvalue + "'";
                                var NewTextValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                                //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                txtvalue = NewTextValue;
                                var NameValue = NewFieldName + "=" + encodeURI(txtvalue);
                                ArrayAllData.push(NameValue);
                            }
                            else {
                                //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                //var NewTextValue = "'" + txtvalue + "'";
                                var NewTextValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                                //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                txtvalue = NewTextValue;
                                var NameValue = FieldName + "=" + encodeURI(txtvalue);
                                ArrayAllData.push(NameValue);
                            }
                        }
                    }
                }

                $('textarea', '#sidebarpanel').each(function () {
                    if (ArrayTextAreaTag.indexOf($(this).attr('id')) === -1) {
                        ArrayTextAreaTag.push($(this).attr('id'));
                    }
                });

                for (var k = 0; k < ArrayTextAreaTag.length; k++) {
                    var ID = "#" + ArrayTextAreaTag[k];

                    if (ArrayTextAreaTag[k].indexOf("txtextCustomFieldText") != -1) {
                        var FieldName = ArrayTextAreaTag[k].replace('txtext', '');

                        var txtvalue = $(ID).val();
                        if (txtvalue == 0) {
                            txtvalue = "NULL";
                        }
                        else {
                            //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                            //var NewSelectedValue = "'" + txtvalue + "'";
                            var NewSelectedValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                            //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                            txtvalue = NewSelectedValue;
                        }
                        var NameValue = FieldName + "=" + encodeURI(txtvalue);
                        ArrayExtCustomFields.push(NameValue);

                    }
                    else {
                        var txtvalue = $(ID).val();
                        if (txtvalue == 0) {
                            txtvalue = "NULL";
                            var FieldName = ArrayTextAreaTag[k].replace('txt', '');
                            var NewTextValue = "" + txtvalue + "";
                            txtvalue = NewTextValue;
                            var NameValue = FieldName + "=" + encodeURI(txtvalue);
                            ArrayAllData.push(NameValue);
                        }
                        else {
                            var FieldName = ArrayTextAreaTag[k].replace('txt', '');
                            //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                            //var NewTextValue = "'" + txtvalue + "'";
                            var NewTextValue = "'" + txtvalue.toString().replace(/\'/g, "''") + "'";
                            //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                            txtvalue = NewTextValue;
                            var NameValue = FieldName + "=" + encodeURI(txtvalue);
                            ArrayAllData.push(NameValue);
                        }
                    }
                }

                var checkbox = document.querySelector('input[id="chkShowToCustomer"]');
                var strval;
                if ($("input[id='chkShowToCustomer']").is(":visible")) {
                    if (checkbox.checked == true) {
                        strval = "1";
                    }
                    else {
                        strval = "0";
                    }
                    if ("<%= Session("LoginType").ToString() %>" == "C") {
                        strval = "1";
                    }
                    var NameValue = "ShowToCustomer=" + strval;
                    ArrayAllData.push(NameValue);
                }
                var NameValueSummary = "Summary='" + $("#summary").text().replace(/\'/g, '\'\'') + "'";
                var NameValueDescription = "Description ='" + $("#txtIssueDescription").text().replace(/\'/g, '\'\'') + "'";
                var NameValue = "IssueID=" + IssueID;
                //ArrayAllData.push(NameValue);
                ArrayExtCustomFields.push(NameValue);
                var userName = "UserName='" + UserName + "'";
                ArrayExtCustomFields.push(userName);
                var creatorOrModifier = "CreatorOrModifier='" + UserName + "'";
                ArrayAllData.push(creatorOrModifier);
                ArrayAllData.push(NameValueDescription);
                ArrayAllData.push(NameValueSummary);
                ArrayAllData.push(NameValue);

                var ArrayallData = ArrayAllData.toString();
                //for (var i = 0; i < ArrayAllData.length; i++)
                //{
                //    var ObjItems = ArrayAllData[i];
                //    var CheckData = ObjItems.split("=");
                //    var Item = CheckData[0];
                //    var Value = CheckData[1];
                //    var ClosureParameter =
                //    {
                //        Item: encodeURI(Item),
                //        Value: encodeURI(Value)
                //    }
                //    var param = JSON.stringify(ClosureParameter);
                //    var strResult = AJAXCallWithResult("/api/IB_IssueDetails/UpdateIssue", param, false);
                //}

              
               
                //var updateIssueData = {issueid : IssueID, AllData: ArrayAllData, ExtData : ArrayExtCustomFields}
                //var param = JSON.stringify(ArrayAllData);
                var ArrayallData={
                    Allvalue: ArrayallData
                }
                var param = JSON.stringify(ArrayallData);
                var result = AJAXCallWithResult("/api/IB_IssueDetails/UpdateIssue", param, false);
                if (result != undefined) {
                    //attachement(result);
                    if ($("input[id='chkShowToCustomer']").is(":visible")) {
                        if (checkbox.checked == true) {
                            ShowToCustomer = "True";
                        }
                        else {
                            ShowToCustomer = "False";
                        }
                    }
                    updateExtData(ArrayExtCustomFields);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Issue Updated successfully.");
                    var Type = $('select#cboType option:selected').val();
                    var RoleId = "<%= Session("intPostID").ToString() %>";

                    //start vishal mahajan 04-12-2019 for ISSUE STATUS CHANGED
                    Status = $('select#cboStatus option:selected').val();
                    Typeproject= $('select#cboType option:selected').val();
                    var ProjectID = "<%= Session("IssueProject").ToString() %>";
                    var EmployeeId =  "<%= Session("intUserID").ToString() %>";
                    //var EmployeeId = $('select#cboAssignToName option:selected').val();
                    if (ExistingStatus != Status) {
                        ExistingStatus = Status;
                        SendMailCheckCondtion(result, ProjectID, EmployeeId);
                    }
                    //GetStatus(ProjectID, Type, RoleId);
                    //Added By Reshma Chavan on 18 Feb 2021 For SLA tab Refresh Issue
                    GetIssueSLADetails(IssueID);
                    //Added By Reshma Chavan on 18 Feb 2021 For SLA tab Refresh Issue
                    //END vishal mahajan 04-12-2019 for ISSUE STATUS CHANGED

                    var acttabid = $("#tabdetails li.active").find('a')[0].id;
                    if (acttabid == "ViewHistoryID") {
                        $("#" + acttabid).click();
                    }
                    //debugger;
                    if (acttabid == "divDiscussion") {
                        $("#" + acttabid).click();

                    }
                    // GetTypesForDiscussion();
                    //Added By Usha Pandit On 12.02.2021 For allowing to enter Summary and description properly
                    $("#textsummary").hide();
                    $("#textIssueDescription").hide();
                    $("#summary").show();
                    $("#txtIssueDescription").show();
                    //End Of Added By Usha Pandit On 12.02.2021 For allowing to enter Summary and description properly
                }
            }
            else {
                return false;
            }
        }

        function updateExtData(ArrayExtCustomFields) {
            var ArrayextCustomFields = {
                CustomFieldsdata: ArrayExtCustomFields.toString()
            }
            //var param = JSON.stringify(ArrayExtCustomFields);
            var param = JSON.stringify(ArrayextCustomFields);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/UpdateExtFields", param, false);
            if (result != undefined) { }
        }

        //const convertTime12to24 = (time12h) => {
        //    const [time, modifier] = time12h.split(' ');

        //    let [hours, minutes] = time.split(':');

        //    if (hours === '12') {
        //        hours = '00';
        //    }

        //    if (modifier === 'PM') {
        //        hours = parseInt(hours, 10) + 12;
        //    }

        //    return `${hours}:${minutes}`;
        //}


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

        function DownloadZipRequest() {
            var param = JSON.stringify(intDiscussionID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/DownloadZip", param, false);
            if (result != undefined) {
                if (result != true) {
                    var strTemp = '../../General/ViewAttachment.aspx?FromWhere=BTS/ZIPFile&FileName=Issue_' + IssueID + '.zip' + '&SystemFileName=Request_' + intDiscussionID + '.zip';
                    window.open(strTemp);
                }
            }
        }

        function DownloadZipRequestAttachment() {
            var param = JSON.stringify(IssueID);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/DownloadZipAttachments", param, false);
            if (result != undefined) {
                if (result != true) {
                    //Commented & added By Dipali V 28th Sep 2019 For Issue Should be File Name
                    //var strTemp = '../../General/ViewAttachment.aspx?FromWhere=BTS/ZIPFile&FileName=Request_' + intIssueID + '.zip' + '&SystemFileName=Request_' + intIssueID + '.zip';
                    var strTemp = '../../General/ViewAttachment.aspx?FromWhere=BTS/ZIPFile&FileName=Issue_' + IssueID + '.zip' + '&SystemFileName=Request_' + intIssueID + '.zip';
                    window.open(strTemp);
                    //End of Commented & added By Dipali V 28th Sep 2019 For Issue Should be File Name
                }
            }
        }

        function DownloadFile(value) {
            $('#tblDiscussionAttachment td').filter(function () {
                if ($(this).text() == value) {
                    var fileName = $(this).attr('id');
                    var strTemp = '../../General/ViewAttachment.aspx?FromWhere=BTS&FileName=' + fileName + '&SystemFileName=' + fileName;
                    window.open(strTemp);
                }
            });
        }

        function clearAllFieldsFromTracking() {
            $('#cboFlagTo option').each(function () {
                $(this).removeAttr("selected");
            });
            $('#clearflag').css('visibility', 'hidden');
            $("#trackingdate").val("");
            $("#trackingdate").datepicker({
                changeMonth: true,
                dateFormat: 'd M yy',
                changeYear: true,//2021
                onClose: function () {
                    $(':focus').blur();
                }
            });
            $("#flagcomplete1").prop("checked", false);
            //Added By Dipali V on 29th March 2023 for Clear Flag
            $("#cboFlagTo").val("-1");
            //End of Added By Dipali V on 29th March 2023 for Clear Flag

        }

        function ShowTrackingDetails(IssueID) {
            $("#isstrackingflag").modal("show");
            var Summery = $("#summary").html();
            //added By dipali V on 3rd Sep 2019 for display header
            $("#tblheader").css('display', 'block');
            //end of added By dipali V on 3rd Sep 2019 for display header
            $("#lblIssueID").text(IssueID);
            $("#txtSummary").html("<strong>Issue :</strong> " + Summery + "");
            clearAllFieldsFromTracking();

            var issueParameters = {
                intEmployeeID: EmployeeId,
                ContextID: IssueID,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetTrackingDetails", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var FlagTo = d.FlagTo;
                    var DueDate = d.DueDate;
                    var IsComplete = d.IsComplete;
                    $('#hdnUniqueID').val(d.UniqueID);
                    $('#clearflag').css('visibility', 'visible');
                    if (FlagTo != "") {
                        $('select[name=cboFlagTo]').val(FlagTo);
                    }

                    var date = new Date(DueDate);
                    $("#trackingdate").datepicker('setDate', date);

                    if (IsComplete == "1") {
                        $("#flagcomplete1").prop("checked", true);
                    }
                    else {
                        $("#flagcomplete1").prop("checked", false);
                    }
                    //start vishal mahajan 04-12-2019
                    if (IsComplete == "1") {
                        $('#clearflag').css('visibility', 'hidden');
                    } else {
                        $('#clearflag').css('visibility', 'visible');
                    }
                    //end vishal mahajan 04-12-2019
                }
            }
        }

        function SaveTrackingDetails() {
            if ($("#cboFlagTo").val() == "-1") {
                alertify.notify('Please Select Flag To.', 'error');
                //Added By Dipali V On 20th Sep 2019 For Control Focus
                $("#cboFlagTo").focus();
                return;
            }

            if ($("#trackingdate").val() == "") {
                alertify.notify('Please Select Due Date.', 'error');
                //Added By Dipali V On 20th Sep 2019 For Control Focus
                $("#trackingdate").focus();
                return;
            }
            //Added By Dipali V On 20th Dec 2019 For Tracking Date Validation
            if ($("#trackingdate").val() != "") {
                // debugger;
                var GivenDate = $("#trackingdate").val();

                // var CurrentDate = $.datepicker.formatDate('yy/mm/dd', new Date());
                // GivenDate = $.datepicker.formatDate('yy/mm/dd', new Date(GivenDate));
                var CurrentDate = SelectedCurrentdate.toShortFormat();
                var checkval = 0;
                if ($("#flagcomplete1").prop("checked") == true) {
                    checkval = 1;
                    if (ischeck == 1) {
                        if (Date.parse(GivenDate) < Date.parse(CurrentDate)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Please enter Due date greater than or equal to today's date.", 'error');
                            $("#trackingdate").focus();
                            return;
                        }
                    }
                }
                if (Date.parse(GivenDate) >= Date.parse(CurrentDate)) {


                }
                else {
                    if ($("#flagcomplete1").prop("checked") == false) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter Due date greater than or equal to today's date.", 'error');
                        $("#trackingdate").focus();
                        return
                    }
                    //}
                }
                //Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198
                var result = GetProjectStartDateEndDate();
                for (var i = 0; i < result.length; i++) {
                    var ObjDate = result[i];
                    if (Date.parse(ObjDate.expectedenddate) < Date.parse(GivenDate)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Due date should not be greater than 'Project End Date " + result[i].expectedenddate + "'", 'error');
                        $("#trackingtype").focus();
                        return
                    }
                }
				//End Of Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198



            }
            //End of Added By Dipali V On 20th Dec 2019 For Tracking Date Validation
            // return;
            var IssueID = $("#lblIssueID").text();
            var IsChecked = $("#flagcomplete1").is(':checked') ? 1 : 0;
            var DueDate = $("#trackingdate").val();
            var FlagTo = $("#cboFlagTo").val();
            //var ProjectID = ProjectID;
            var issueParameters = {
                intEmployeeID: EmployeeId,
                IssueID: IssueID,
                DueDate: DueDate,
                FlagTo: FlagTo,
                IsComplete: IsChecked,
                ProjectID: ProjectID
            }
            StartLoader("#bodyIssueDetails");
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/SaveTrackingDetails", param, false);
            if (strResult == "Success") {
                StopAjaxLoader("#bodyIssueDetails");
                ischeck = 0;
                ShowTrackingDetails(IssueID);
                UpdateIssueTrackingFlag();
                //Added By Dipali V On 20th Sep 2019 For Control Focus
                alertify.notify("Tracking Details saved successfully.", 'success');
                //Commented by dipali v on 3rd oct 2019 for rescrict to close popup
                // $("#isstrackingflag").modal("hide");
                //End of Commented by dipali v on 3rd oct 2019 for rescrict to close popup
            }
        }
        //added by dipali V On 23rd Dec 2019
        var ischeck = 0;
        $("#trackingdate").change(function () {
            ischeck = 1;
            var IschangedDate = $("#trackingdate").val();

        });



        //End of added by dipali V On 23rd Dec 2019
        function ClearTrackingFlag() {
            var uid = $('#hdnUniqueID').val();
            var issueParameters = {
                UniqueID: uid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/ClearTrackingDetails", param, false);
            if (strResult == "Success") {
                UpdateIssueTrackingFlag();
                $("#isstrackingflag").modal("hide");
            }
        }

        function UpdateIssueTrackingFlag() {
            var IssueDetailsPass = {
                intIssueidID: IssueID,
                EmployeeID: EmployeeId,
            }
            var param = JSON.stringify(IssueDetailsPass);
            var strResult = AJAXCallWithResult("/api/IB_IssueDetails/UpdateIssueTrackingFlag", param, false);
            if (strResult != undefined) {
                $('#flagto').html('');
                if (strResult == 'G') {
                    $('#flagto').html("<i class='fas fa-flag flag-success'></i>");
                }
                else if (strResult == 'L') {
                    $('#flagto').html("<i class='far fa-flag flagred'></i>");
                }
                else if (strResult == 'S') {
                    $('#flagto').html("<i class='far fa-flag flagorange'></i>");
                }
                else if (strResult == 'B') {
                    $('#flagto').html("<i class='fa fa-flag'></i>");
                }
                else {
                    //start vishal mahajan 05-12-2019
                    $('#flagto').html("<i class='far fa-flag'></i>");
                    //end vishal mahajan 05-12-2019
                }
            }
        }

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            //StartLoader("#bodyIssueDetails");
            $.ajax({
                url: encodeURI(strUrl + url),
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
                    //StopAjaxLoader("#bodyIssueDetails");
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    //StopAjaxLoader("#bodyIssueDetails");
                    console.log(err);
                }
            });
            return ajaxResult;
        }

        function GetCommonCboValues(method, cbo) {
            //debugger
            var ctrl = 'cbo' + cbo;
            var param = JSON.stringify(commonProperty);
            var result = AJAXCallWithResult("/api/IB_IssueDetails/" + method, param, false);
            if (result != undefined && result != null) {
                var objCbo1 = document.getElementById(ctrl);
                if (objCbo1 != null && objCbo1 != undefined) {
                    $("#" + ctrl + " option").remove();
                    for (var i = 0; i < result.length; i++) {
                        //debugger;
                        var Objresult = result[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = Objresult.FieldName;
                        objOption.value = Objresult.FieldID;
                    }
                }
            }

            if (DeliverableID != "") {
                // $("#cboDeliverableID").val(DeliverableID);
                AppendOptioncbo(cbo, DeliverableID);
            }
        }

        function AssignComboValue(cbo, cboVal) {
            //debugger;
            var id = "cbo" + cbo;
            cboVal = cboVal.toString().trim();
            if (cboVal != "") {
                //$("select#" + id + " option:contains(" + cboVal + ")").attr('selected', 'selected');
                $(id).val(cboVal);
                if (isNumeric(cboVal)) {

                    //Added & Commented By Dipali V On 2nd OCt 2020 For Data  Binding Issue
                    //$("select#" + id + " option[value=" + cboVal + "]").prop('selected', 'selected');

                    $("select#" + id + " option[value='" + cboVal + "' ]").prop('selected', 'selected');
                    //End of Added & Commented By Dipali V On 2nd OCt 2020 For Data  Binding Issue
                }
                else {
                    //$("select#" + id + " option:contains(" + cboVal + ")").prop('selected', 'selected');
                    $("select#" + id).val(cboVal).change();
                }
            }
            else {
                $(id).val(0);
                $("#" + id + " option[value=0]").prop('selected', 'selected');
            }
            //var title = $(id).val();
            //$(id).attr("title", title);
            //$(id).attr("data-toggle", "tooltip");
            //$(id).attr("data-placement", "bottom");
            //$(id).attr("data-container", "body");
            //$('[data-bs-toggle="tooltip"]').tooltip();

            if (DeliverableID != "") {
                // $("#cboDeliverableID").val(DeliverableID);
                $("select#" + id + " option[value=" + DeliverableID + " ]").prop('selected', 'selected');
            }

        }

        //backbtn code
        function goBack() {
            //Added By Dipali V On 5th April 2023 For Page Crash Issue
            var PageNO = '<%= Request.QueryString("intPageNo")%>'
            PageNO = PageNO.trim();
           //End of Added By Dipali V On 5th April 2023 For Page Crash Issue
            var HeaderCaption = $(parent.document.getElementById('mainHeadingTop'));
            HeaderCaption.text("");
            HeaderCaption.text("Issues > Issues");
            //Added by Swapnagandha K. for Session Project Issue On 18-Oct-2019
           <%-- window.location.href = "IssueList.aspx?FromWhere=Issue&View=" + viewApplied +
                "&ViewType=" + '<%= Request.QueryString("ViewType")%>' + "&intPageNo=" + '<%= Request.QueryString("intPageNo")%>' + "";--%>

            <%-- window.location.href = "IssueList.aspx?FromWhere=Issue&View=" + viewApplied +
                "&ViewType=" + '<%= Request.QueryString("ViewType")%>' + "&intPageNo=" + '<%= Request.QueryString("intPageNo")%>' + "";--%>
           // alert("<%= Session("SFilter")%>")
           // debugger;
           
           <%-- qid = "<%=qid%>";
            stext = "<%=stext%>";
            qtext = "<%=qtext%>";
            flist = "<%=flist%>";
            forder = "<%=forder%>";
             qType = "<%=qType%>";
            qname = "<%=qname%>";
            globalclose = "<%=globalclose%>";
            SelectedEmployeeID = "<%=SelectedEmployeeID%>";--%>
            
            // qid = unescape(params["qid"]);
            // secondfilter=unescape(params["secondfilter"]);
             //qtext=unescape(params["qtext"]);
             //flist=unescape(params["flist"]);
             //forder=unescape(params["forder"]);
             //qType=unescape(params["qType"]);
             //qname = unescape(params["qname"]);
             //globalclose = unescape(params["globalclose"]);
             //SelectedEmployeeID = unescape(params["SelectedEmployeeID"]);

            window.location.href = "IssueList.aspx?FromWhere=Issue&View=" + viewApplied +
                "&ViewType=" + '<%= Request.QueryString("ViewType")%>'
                + "&intPageNo=" + '<%= Request.QueryString("intPageNo")%>'
              //  Added By Dipali V  On 1st Nov 2021 For Check Page IS Redirect or not
                + "&IsBack=1"
             //End of Added By Dipali V  On 1st Nov 2021 For Check Page IS Redirect or not
             
            //alert(window.location.href);
            //EndAdded by Swapnagandha K. for Session Project Issue On 18-Oct-2019
        }
        //Added By Usha Pandit On 26.05.2021 For getting 24 hour format
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
        function formatAMPM(date) {
            var date = new Date(date);
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return strTime;
        }
        //End Of Added By Usha Pandit On 26.05.2021 For getting 24 hour format
        //Added By dipali vekhande on 3rd Sep 2019 for Status onchange Status date & Time should change
       
        function Status_OnChange() {

            $.ajax({
                url: encodeURI(url) + '/api/IB_AddNewIssue/GetCurrentDateTime',
                type: 'GET',
                //  data: JSON.stringify(ProjectId),
                dataType: 'json',
                async:false,
                //contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    //debugger;
                    //
                    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                    var d = new Date();
                    var dt = d.getDate() + " " + months[d.getMonth()] + " " + d.getFullYear();

                    var objStatusTime = document.getElementById('dtStatusChangeTime');
                    var objStatusDate = document.getElementById('dtStatusChangeDate');

                    var objCurrentDate = dt;
                    var objCurrentTime = result[1];

                    var WhizobjCurrentDate = dt;
                    selectedtime = objCurrentTime;
                    var objOldStatusChangeDate = globalStatusChangeDate;
                    var objOldStatusChangeTime = globalStatusChangeTime;
                    var objNewStatus = document.getElementById('cboStatus');
                    var objOldStatus = globalStatus


                    if (objOldStatus != null && objOldStatusChangeDate != null && objOldStatusChangeTime != null && objStatusDate != null && objStatusTime != null) {
                        if (objOldStatus == objNewStatus.value) {
                            if (objOldStatusChangeDate != objStatusDate.value || objOldStatusChangeTime != objStatusTime.value) {

                                objStatusDate.value = objOldStatusChangeDate;
                                // debugger;
                                //Commennted & Added By Dipali V On 5th Oct 2021 For Get Current Date & Tim
                                // objStatusTime.value = objOldStatusChangeTime;
                                var d = objCurrentTime;
                                var H = d.split(' ')[1].split(":")[0];
                                var PMAM = d.split(' ')[2];
                                var M = d.split(' ')[1].split(":")[1]
                                var Time = H + ":" + M + " " + PMAM
                                // d = "08:06 PM";
                                //alert(d);
                                // alert(objCurrentTime);
                                //return;
                                objStatusTime.value = convertTime12to24(Time);
                                //objStatusTime.value = convertTime12to24(objStatusTime.value);
                                //End of Commennted & Added By Dipali V On 5th Oct 2021 For Get Current Date & Time



                            }
                        }
                        else {

                            objStatusDate.value = objCurrentDate;
                            //2020
                            //objStatusTime.value = objCurrentTime;
                            //Commented  & Added By Dipali V On 25th Feb 2021 for Get Staus change date correct
                            // var d = objCurrentTime;
                            // d = d.split(' ')[1];
                            // // 5th oct 2021
                            ////objStatusTime.value = TimeConvTo12(d);
                            //      objStatusTime.value = TimeConvTo12(d);
                            //     objStatusTime.value = convertTime12to24(objStatusTime.value);
                            //// objStatusTime.value = d;

                            var d = objCurrentTime;
                            var H = d.split(' ')[1].split(":")[0];
                            var PMAM = d.split(' ')[2];
                            var M = d.split(' ')[1].split(":")[1]
                            var Time = H + ":" + M + " " + PMAM

                            objStatusTime.value = convertTime12to24(Time);


                            //objStatusTime.value = TimeConvTo12(objCurrentTime);
                            //End of Commented  & Added By Dipali V On 25th Feb 2021 for Get Staus change date correct
                            //alert(objStatusTime.value);
                        }
                    }

                },
                error: function (xhr, errorThrown) {

                }
            });



        }




        const convertTime12to24new = time12h => {
            const [time, modifier] = time12h.split(" ");

            let [hours, minutes] = time.split(":");

            if (hours === "12") {
                hours = "00";
            }

            if (modifier === "PM") {
                hours = parseInt(hours, 10) + 12;
            }

            return `${hours}:${minutes}`;
        };

        //var convertedTime = convertTime12to24("01:00 PM");
        //console.log(convertedTime);
        // Output: 13:00


        function EditDetails() {
            var myElements = $(".edit-input");
            var Controlvalues
            for (var i = 0; i < myElements.length; i++) {
                var ControlID = myElements[i].id;
                var ControlS = ControlID.replace("text", "")
                if (ControlS == "IssueDescription") {
                    ControlS = "txtIssueDescription";
                }
                Controlvalues = $("#" + ControlS).text();
                $("#" + ControlS).hide();
                $("#" + ControlID).show();
                $("#" + ControlID).val(Controlvalues);
                $("#lblsummary").css('display', 'inline-block')
                $("#lblDescription").css('display', 'inline-block')
            }
        }



        $(".edit-input").blur(function () {
            //
            var myElements = $(".edit-input");
            var Controlvalues
            for (var i = 0; i < myElements.length; i++) {
                var ControlID = myElements[i].id;
                var ControlS = ControlID.replace("text", "")
                if (ControlS == "IssueDescription") {
                    ControlS = "txtIssueDescription";
                }
                Controlvalues = $("#" + ControlID).val();
                //Commented By Usha Pandit On 12.02.2021 For allowing to enter Summary and description properly
                //$("#" + ControlS).show();
                //$("#" + ControlID).hide();
                //End Of Commented By Usha Pandit On 12.02.2021 For allowing to enter Summary and description properly
                $("#" + ControlS).text(Controlvalues);
            }
        });

        function blurFunction() {


            //var myElements = $(".edit-input");
            //var Controlvalues
            //for (var i = 0; i < 2; i++) {

            //    var ControlID = myElements[i].id;
            //    alert(ControlID)
            //    //var ControlS = ControlID.replace("text", "")
            //    //if (ControlS == "IssueDescription") {
            //    //    ControlS = "txtIssueDescription";
            //    //}
            //    //var Controlvalues = $("#" + ControlID).val();
            //    //// alert(ControlS)
            //    //$("#" + ControlS).show();
            //    //$("#" + ControlID).hide();
            //    //$("#" + ControlS).text(Controlvalues);

            //  }
            //dad.find('span').text(this.val())

        }
        //End of Added By dipali vekhande on 3rd Sep 2019 for Status onchange Status date & Time should change

        //start vishal mahajan 04-12-2019 for ISSUE STATUS CHANGED
        function SendMailCheckCondtion(IssueId, PorjectId, EmployeeId) {
            var issueid = IssueId;
            var projectid = PorjectId;
            var employeeid = EmployeeId;
            var messageId = 34;
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
                        xhr.setRequestHeader("Params", encryptString(isJson(mailData) ? param : JSON.stringify(mailData)));
                    }
                },
                success: function (result) {

                    if (result.ShowPopup == true) {
                        //alert("show popup");
                        window.open("../Email/SendEmail.aspx?MessageID=34&IssueID=" + issueid + "&ProjectID=" + projectid + "&EmployeeID=" + employeeid + "", '_blank', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
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
        //end vishal mahajan 04-12-2019

        //Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198
        function GetProjectStartDateEndDate() {
            var ProjectID = '<%=ProjectID%>';
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/Issue/GetProjectStartDateEndDate", param, false);
            if (result != undefined) {
                return result;
            }
        }
        //End of Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198
               
        function GetDocumentSubType(Flag) {
            var tbl = "";
            var FNAME = "";
            if (Flag == 1) {
                tbl = 'tblMainFiles';
                FNAME = 'MAINFILENAME';
            } else {
                tbl = 'tblFiles';
                FNAME = 'FILENAME';
            }
            $("#" + tbl + " tr").each(function () {
                var id = $(this).attr("id");
                if (id != undefined) {

                    var Filecount = id.split(FNAME)[1];
                    //Added by imran on 17-10-2022
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
                    if (SubType == "" || SubType == "Select Document Sub Type") {
                        $("#cboDocumentSubtype" + Filecount).empty();
                    }
                    //End of comment by imran on 17-10-2022
                    var selHTML = "";
                    selHTML += "<option  value='0'> Select Document Sub Type </option>";
                    var formData = {
                        DocumentTypeID: DocumentType,
                        ProjectId: '<%=ProjectID%>'
                    }
                    $.ajax({
                        url: strUrl + '/api/IB_IssueDetails/GetDocumentSubType',
                        method: 'Post',
                        data: JSON.stringify(formData),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (formData) {
                                xhr.setRequestHeader("Params", encryptString(isJson(formData) ? formData : JSON.stringify(formData)));
                            }
                        },
                        success: function (strResult) {
                            if (strResult != undefined) {
                                for (var i = 0; i < strResult.length; i++) {
                                    var d = strResult[i];
                                    var SubCategoryID = d.SubCategoryID;
                                    var SubCategory = d.SubCategory;
                                    selHTML += "<option  value='" + SubCategoryID + "' >" + SubCategory + "</option>";
                                }
                            }
                        },
                        error: function (xhr, errorThrown) {
                        }
                    });
                    $("#cboDocumentSubtype" + Filecount).html(selHTML);
                    //$("#cboDocumentSubtype" + Filecount).val(SubType);
                    $("#cboDocumentSubtype" + Filecount).val(0);

                    $('[data-bs-toggle="tooltip"]').tooltip();
                }
            });
        }

        function GetDocumentType(tbl, FNAME) {

            var tbl = tbl;
            var FNAME = FNAME;
            $("#" + tbl + " tr").each(function () {
                var id = $(this).attr("id");
                if (id != undefined) {
                    var Filecount = id.split(FNAME)[1];
                    var DocumentType = document.getElementById("cboDocumenttype" + Filecount);
                    DocumentType = DocumentType.value;
                    //Commented and added by imran on 17-10-2022
                    var Type = $("#cboDocumenttype" + Filecount).val();
                    //End of comment by imran on 17-10-2022
                    var formData = {
                        RoleID: '<%=Session("intPostID")%>',
                        ProjectId: '<%=ProjectID%>'
                    }
                    $.ajax({
                        url: strUrl + '/api/IB_IssueDetails/GetDocumentType',
                        method: 'Post',
                        data: JSON.stringify(formData),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            //Added By Dipali V On 4th April 2023 For ValidateHeader
                            if (formData) {
                                xhr.setRequestHeader("Params", encryptString(isJson(formData) ? formData : JSON.stringify(formData)));
                            }
                             //End of Added By Dipali V On 4th April 2023 For ValidateHeader
                        },
                        success: function (strResult) {
                            //$("#cboDocumenttype" + Filecount).empty();
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
                                $('[data-bs-toggle="tooltip"]').tooltip();
                            }
                        },
                        error: function (xhr, errorThrown) {
                        }
                    });
                }
            });
        }

        //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
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

        //added by Parth Godshelwar
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
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
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
        //Ended by Parth Godshelwar

        //$("#tabdetails").click(function () {
        //    $('.tooltip').removeClass('show');
        //});
        //$("#tabdetails").hover(function () {
        //    $('.tooltip').removeClass('show');
        //}); // commented unwanted code by pradip on 6-4-2023

    </script>
    <!--checkbox-checkAll-end-->
</body>
</html>