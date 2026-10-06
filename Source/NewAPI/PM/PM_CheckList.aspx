<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_CheckList.aspx.vb" Inherits="PbNIT.PM_CheckList" %>

<!DOCTYPE html>
<html>
      <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Project")%> 
<head>
 <%--   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>  
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 

    
</head>
<style>
        .custom_chckbox label {
            display: inline-block;
        }

        #tblCheckListDetails {
            margin: 0px auto;
            width: 97% !important;
        }

        .alertify-notifier {
            z-index: 9999 !important;
        }
        /*Added By Dipali V On 17th Dec 2020 For Aligenment issue*/
        .custmodal table tbody tr td {
            word-break: break-word!important;
            white-space: pre-wrap!important;
        }
         /*End of Added By Dipali V On 17th Dec 2020 For Aligenment issue*/

.custom-dropdown .form-select{ width:100%;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectCheckList">
        <div class="tab-pane pstbl_custom pt-0 practicesettinglist in active" id="pstbl_checklists">
            <div class="modalpgHead pt-1 pb-1 col-sm-12 mb-10">
                <span><%= MyBase.GetResourceString("C_Check_List") %></span>
            </div>
            <h5 class="float-start pl-20 pt-2 clearfix">Project Name : <span id="spnProjectName"></span></h5>
            <div class="right-side-save mb-10">
                <a href="javascript:;" class="btn borderbtn mr-5" onclick="CheckListbtnSelectChecklistClick()"><%= MyBase.GetResourceString("C_Select_Check_List") %></a>
                <a href="javascript:;" class="btn borderbtn" onclick="CheckListbtnDeleteClick()">Delete</a>
            </div>

            <%--Added By Rutuja D. 20 Dec 2019--%>
            <div class="clearfix"></div>
            <%--<div class="mb-10 red-note text-end">
            <span>(Red color indicates applied filter)</span>
        </div>--%>
            <%--End Added By Rutuja D. 20 Dec 2019--%>
            <table id="tblCheckListDetails" class="table table-stripped table-bordered">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_Copy") %></th>
                        <th><%= MyBase.GetResourceString("C_Checklist_Name") %></th>
                        <th><%= MyBase.GetResourceString("C_Revision_No") %> </th>
                        <th><%= MyBase.GetResourceString("C_Publish") %></th>
                        <th><%= MyBase.GetResourceString("C_Checklist_Type") %> </th>
                        <th><%= MyBase.GetResourceString("C_Active") %></th>
                        <th><%= MyBase.GetResourceString("C_Get_Latest_Revision") %>  </th>
                        <th class="inp-select">
                            <div class="custom_chckbox">
                                <input type="checkbox" id="chcklistSltAll" class="chckHead">
                                <label for="chcklistSltAll"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblbdyCheckListDetails">
                   
                </tbody>
            </table>

            <div id="TempdivCheckListDetails">
                <div class="accordian-body collapse" id="divCheckListDetails" aria-expanded="true" style="display: none;">
                    <div class="row pt-1 pb-1 bgwhite pad-10">
                        <div class="right-side-save mb-10 mr-0">
                            <a href="javascript:;" class="btn borderbtn mr-5 closeAcco" onclick="btncloseonclickindivCheckListDetails()"><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" class="btn btnyellow" onclick="btnsaveonclickindivCheckListDetails()"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                        <div class="chckli-inner">
                            <div class="page-main-head">
                                <h4><%= MyBase.GetResourceString("C_Checklists") %></h4>
                                <span id="spnProjectCheckListIDindivCheckListDetails"></span>
                                <span id="spnInheritedindivCheckListDetails"></span>
                                <span id="spnrowCheckListDetails"></span>
                            </div>
                            <div class="row pad-10 pb-0">
                                <div class="col-sm-3">
                                    <label class="required"><%= MyBase.GetResourceString("C_Checklist_Name") %> </label>
                                   
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtChecklistName", "txtChecklistName", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                                </div>
                                <div class="col-sm-3 pt-20 cont-center">
                                    <div class="inp-select d-inline-block">
                                        <div class="custom_chckbox">
                                           
                                            <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsActive", "chkIsActive", "chckHead chck-list-slt") %>
                                            <label for="chkIsActive"></label>
                                        </div>
                                    </div>
                                    <label class="d-inline-block"><%= MyBase.GetResourceString("C_Active") %></label>
                                </div>
                                <div class="col-sm-3">
                                    <label>Revision No</label>
                                    
                                    <%--//Commented & AAdded By Dipali V on 12th Jun 2020 For Issue ID  25082--%>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtRevisionNo", "txtRevisionNo", "form-control",,,,,,, True,,, "autocomplete='off'",,, True,,,, True) %>
                                   
                                    <%--//End of Commented & AAdded By Dipali V on 12th Jun 2020 For Issue ID  25082--%>
                                </div>
                            </div>
                        </div>
                        <div class="inner-tabing">
                            <ul class="nav nav-tabs">
                                <li class="active"><a class="active" data-bs-toggle="tab" href="#chcklistItems" aria-expanded="true"><%= MyBase.GetResourceString("C_Check_List") %> </a></li>
                                <!--  remove comment by omkar 09/01/2020 -->
                                <li class=""><a data-bs-toggle="tab" href="#chcklistSections" aria-expanded="false"><%= MyBase.GetResourceString("C_Checklist_Sections") %></a></li>
                                <!--end of remove comment by omkar 09/01/2020 -->
                            </ul>
                            <div class="tab-content">
                            </div>
                        </div>
                        <div class="tab-content">
                            <div id="chcklistItems" class="pad-10 tab-pane fade active in show">
                                <div class="page-main-head">
                                    <h4><%= MyBase.GetResourceString("C_Checklist_Items") %> </h4>
                                </div>
                                <div class="right-side-save mb-10 mr-0">
                                    <a href="javascript:;" class="btn borderbtn mr-5 closeAcco" onclick="btnAddonclickinChecklistItem()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %>Add</a>
                                    <a href="javascript:;" class="btn borderbtn mr-5 closeAcco" onclick="btnDeleteonclickinChecklistItem()">Delete</a>
                                </div>
                                <table id="tblChecklistItems" class="table table-stripped table-bordered">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("C_CheckList_Item_Name") %>  </th>
                                            <th><%= MyBase.GetResourceString("C_Mandatory") %></th>
                                            <th><%= MyBase.GetResourceString("C_IsActive") %></th>
                                            <th><%= MyBase.GetResourceString("C_Section") %></th>
                                            <th class="inp-select">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="chcklistItemAll" class="chckHead chkliacb" onchange="checklistitemallcheck()">
                                                    <label for="chcklistItemAll"></label>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblbdyChecklistItems">
                                      
                                    </tbody>
                                </table>
                            </div>
                            <div id="chcklistSections" class="pad-10 tab-pane fade">
                                <div class="page-main-head">
                                    <!-- Commented And added by omkar 09/01/2020 -->                                   
                                    <h4><%= MyBase.GetResourceString("C_Checklist_Sections") %></h4>
                                    <!-- End Of added by omkar 09/01/2020 -->
                                </div>
                                <%-- added by omkar 09/01/2020--%>
                                <div class="right-side-save mb-10 mr-0">
                                    <a href="javascript:;" class="btn borderbtn mr-5 closeAcco" onclick="btnAddonclickinChecklistSection()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %>Add</a>
                                    <a href="javascript:;" class="btn borderbtn mr-5 closeAcco" onclick="btnDeleteonclickinChecklistSection()">Delete</a>
                                </div>
                                <!-- End Of added by omkar 09/01/2020 -->
                                <table class="table table-stripped table-bordered">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("C_Section_Name") %></th>
                                            <th><%= MyBase.GetResourceString("C_Section_Code") %></th>
                                            <th><%= MyBase.GetResourceString("C_Order_Name") %></th>

                                            <th class="inp-select">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="sectionSltAll" class="chckHead" onchange="checklistSectionallcheck()">
                                                    <label for="sectionSltAll"></label>
                                                </div>
                                            </th>
                                             <!-- end of add by omkar 09/01/2020 -->
                                        </tr>
                                    </thead>
                                    <tbody id="tblbdychcklistSections">
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


                <!--Page modal start here-->

                <!--Associated Task modal start here -->
                <div class="modal custmodal fade" id="assoTaskModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="">Associated Task</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="page-main-head">
                                        <h5 id="">Task : Enhancement Development</h5>
                                    </div>
                                    <div class="row form-group mb-3">
                                        <div class="col-sm-4">
                                            <label>Order Name</label>
                                            <input type="text" name="" class="form-control" value="1">
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Revision No</label>
                                            <input type="text" name="" class="form-control" value="1">
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Task Type</label>
                                            <select class="selectpicker form-select">
                                                <option>Analysis</option>
                                                <option>Audio Visual Preparation</option>
                                                <option>Customer Support</option>
                                                <option>Design</option>
                                                <option>Development</option>
                                                <option>Estimation</option>
                                                <option>Functional Testing</option>
                                                <option>Internal Support</option>
                                                <option>Mail Campaign</option>
                                                <option>Meeting</option>
                                                <option>Presales</option>
                                                <option>Product Content Writing</option>
                                                <option>Project Management</option>
                                                <option>Release</option>
                                                <option>Requirement Gathering</option>
                                                <option>Review</option>
                                                <option>Rework</option>
                                                <option>Sales</option>
                                                <option>Social Media Post</option>
                                                <option>Study or Research</option>
                                                <option>Task</option>
                                                <option>Tech Documentation</option>
                                                <option>Testing</option>
                                                <option>Training</option>
                                                <option>Travel</option>
                                                <option>User Acceptance Test</option>
                                                <option>Web Page Design</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row form-group  mb-3">
                                        <div class="col-sm-4">
                                            <label>Accountable Role</label>
                                            <select class="form-select selectpicker">
                                                <option>ADMIN MANAGER</option>
                                                <option>APPLICATION ADMINISTRATOR</option>
                                                <option>BUSINESS DEVELOPMENT MANAGER</option>
                                                <option>DELIVERY MANAGER</option>
                                                <option>DEVELOPER CONSULTANT</option>
                                                <option>ENGINEER (VENDOR)</option>
                                                <option>FINANCE MANAGER</option>
                                                <option>HELPDESK EXECUTIVE</option>
                                                <option>HELPDESK LEAD / MANAGER</option>
                                                <option>HR MANAGER</option>
                                                <option>IMPLEMENTATION ENGG / BUSINESS ANALYST</option>
                                                <option>IT SUPPORT EXECUTIVE</option>
                                                <option>MANAGING DIRECTOR</option>
                                                <option>PRESIDENT</option>
                                                <option>PROJECT CO-ORDINATOR</option>
                                                <option>PROJECT MANAGER / SCRUM MASTER</option>
                                                <option>SALES EXECUTIVE</option>
                                                <option>SOFTWARE ENGINEER / TEAM MEMBER</option>
                                                <option>TEAM LEADER</option>
                                                <option>TEST ENGINEER</option>
                                                <option>TEST LEAD</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Review Task</label>
                                            <input type="text" name="" class="form-control">
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Review Type</label>
                                            <input type="text" name="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row form-group  mb-3">
                                        <div class="col-sm-4">
                                            <label>Check List</label>
                                            <input type="text" name="" class="form-control">
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Description</label>
                                            <textarea class="form-control"></textarea>
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Effort(%)</label>
                                            <input type="text" name="" class="form-control" value="100">
                                        </div>
                                    </div>
                                    <div class="row form-group  mb-3">
                                        <div class="col-sm-4">
                                            <label>Duration(Days)</label>
                                            <input type="text" name="" class="form-control">
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="inp-select d-inline-block pt-20">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="mandatorySlt" class="chckHead">
                                                    <label for="mandatorySlt"></label>
                                                </div>
                                            </div>
                                            <label>Mandatory</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="center-align">
                                    <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn mr-5">Close</a>
                                    <a href="javascript:;" data-bs-dismiss="modal" class="btn btnyellow">Save</a>
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
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Select_the_New_Approver") %> Copy CheckList</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="center-align">
                                    <span id="spncpychecklistID"></span>
                                    <div class="row form-group cont-center  mb-3">
                                        <div class="col-sm-6">
                                            <label class="required"><%= MyBase.GetResourceString("C_Checklist_Name") %> </label>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtcpychecklistname", "txtcpychecklistname", "form-control",,,,,,,,,, "Autocomplete='off'",,, True,,,,) %>
                                        </div>
                                    </div>
                                    <div class="btn-grp-new">
                                        <a href="javascript:;" class="btn borderbtn mr-5" onclick="copychecklistmodelbtncloseclick()"><%= MyBase.GetResourceString("C_Close") %></a>
                                        <a href="javascript:;" class="btn btnyellow" onclick="copychecklistmodelbtnsaveclick()"><%= MyBase.GetResourceString("C_Save") %></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Copy modal end here-->

                <!--Select Template modal start here-->
                <div class="modal custmodal fade" id="selectTempModal" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Select_Check_List") %>  </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <table id="tblSelectCheckList" class="table table-stripped table-bordered">
                                        <thead>
                                            <tr>
                                                <th><%= MyBase.GetResourceString("C_Check_List") %> </th>
                                                <th><%= MyBase.GetResourceString("C_Select_Checklists") %> </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblbdySelectCheckList">
                                           
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btn-grp-new">
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"  onclick="btncloseonclickinselectTempModal()"><%= MyBase.GetResourceString("C_Close") %></a>
                                    <a href="javascript:;" class="btn btnyellow" onclick="btnsaveonclickinselectTempModal()"><%= MyBase.GetResourceString("C_Save") %></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Select Template modal end here-->

                <!--Checklist modal start here-->
                <div class="modal custmodal fade" id="checklistModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Checklist_Items") %> </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="spnChecklistItemsIdindivchecklistModal"></span>
                                <span id="spnChecklistIdindivchecklistModal"></span>
                                <span id="spnInheritedindivchecklistModal"></span>
                                <span id="spnAnswerSetIdindivchecklistModal"></span>
                             
                                    <div class="form-group row mb-3">
                                        <div class="col-sm-4">
                                            <label class="required"><%= MyBase.GetResourceString("C_CheckList_Item_Name") %></label>
                                            <%-- <input type="text" name="" class="form-control">--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtCheckListItemName", "txtCheckListItemName", "form-control",, 200,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                                        </div>
                                        <div class="col-sm-4">
                                            <label><%= MyBase.GetResourceString("C_Section") %></label>
                                            <div class="custom-dropdown">                                              
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboSection", "Select 0,'-- select --'",,,, True,, "'form-select'",,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="required"><a href="javascript:;" onclick="binddataansersetview()"><%= MyBase.GetResourceString("C_Answer_Set") %> </a></label>
                                            <div class="custom-dropdown">
                                               
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboAnswerSet", "usp_Whizible2_Sel_tbl_Q_AnswerSet",,,, False,, "'form-select'",,, ) %>
                                            </div>
                                        </div>
                                    </div>
                            
                                <div class="row form-group  mb-3">
                                    <div class="col-sm-4 pt-20">
                                        <div class="inp-select d-inline-block">
                                            <div class="custom_chckbox">
                                                <%--<input type="checkbox" id="mandatoryStatus" class="chckHead chck-list-slt">--%>
                                                <% CommonFunctions.HTMLControls.DrawCheckBox("chkmandatoryStatus", "chkmandatoryStatus", "chckHead chck-list-slt") %>
                                                <label for="chkmandatoryStatus"></label>
                                            </div>
                                        </div>
                                        <label class="d-inline-block"><%= MyBase.GetResourceString("C_Mandatory") %></label>
                                    </div>
                                    <div class="col-sm-4 pt-20">
                                        <div class="inp-select d-inline-block">
                                            <div class="custom_chckbox">
                                                <%--<input type="checkbox" id="actStatusChck" checked class="chckHead chck-list-slt">--%>
                                                <% CommonFunctions.HTMLControls.DrawCheckBox("chkActiveStatus", "chkActiveStatus", "chckHead chck-list-slt") %>
                                                <label for="chkActiveStatus"></label>
                                            </div>
                                        </div>
                                        <label class="d-inline-block"><%= MyBase.GetResourceString("C_Active") %></label>
                                    </div>
                                </div>
                                <div class="btn-grp-new">
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" onclick="btncloseonclickinchecklistModal()"><%= MyBase.GetResourceString("C_Close") %></a>
                                    <a href="javascript:;" class="btn btnyellow" onclick="btnsaveonclickinchecklistModal()"><%= MyBase.GetResourceString("C_Save") %></a>
                                </div>
                            </div>
                        </div>
                    </div>
                
                <!--Checklist modal end here-->

                <!--Answer Set modal start here-->
                <div class="modal custmodal fade" id="ansSet" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Answer_Set_Preview") %> </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <table id="tblAnswerSetPreview" class="table table-stripped table-bordered">
                                        <thead>
                                            <tr>
                                                <th><%= MyBase.GetResourceString("C_Answer_Option") %> </th>
                                                <th><%= MyBase.GetResourceString("C_Is_Option_Negative") %>  </th>
                                                <th><%= MyBase.GetResourceString("C_Order_in_Which_To_Appear") %> </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblbdyAnswerSetPreview">
                                           
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btn-grp-new">
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Back") %></a>
                                    <a href="javascript:;" class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Answer Set modal end here-->

                <!--Section Name modal start here-->
                <div class="modal custmodal fade" id="sectionNameModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="">Checklist Sections</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                 <!--add by omkar 09/01/2020-->
                                 <span id="spnChecklistSectionIdsectionNameModal"></span>
                                <span id="spnChecklistIdsectionNameModal"></span>
                                <span id="spnInheritedindsectionNameModal"></span>
                              <!-- end of add by omkar 09/01/2020 -->
                                
                                <div class="row form-group  mb-3">
                                    <div class="col-sm-4">
                                        <label class="required"><%= MyBase.GetResourceString("C_Section_Name") %></label>
                                        
                                        <%--<input type="text" name="" id="txt" class="form-control">--%>
                                         <% CommonFunctions.HTMLControls.DrawTextBox("txtSectionName", "txtSectionName", "form-control", , 250,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                                    </div>
                                    <div class="col-sm-4">
                                        <label class="required"><%= MyBase.GetResourceString("C_Section_Code") %></label>
                                        <%--<input type="text" name="" class="form-control">--%>
                                         <% CommonFunctions.HTMLControls.DrawTextBox("txtSectionCode", "txtSectionCode", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                                    </div>
                                    <div class="col-sm-4">
                                        <label class="required"><%= MyBase.GetResourceString("C_Order_Name") %></label>
                                        <%--<input type="text" name="" class="form-control">--%>
                                         <% CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                                    </div>
                                </div>
                                <!-- end of added by omkar 09/01/2020 -->
                                <div class="center-align btn-grp-new">

                                     <!--Commented and added by omkar 09/01/2020-->
                                    <%--<a href="javascript:;" class="btn borderbtn" data-bs-dismiss="modal">Close</a>--%>                                    
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" onclick="btncloseonclickinchecklistSectionModal()"><%= MyBase.GetResourceString("C_Close") %></a>
                                     <a href="javascript:;" class="btn btnyellow" onclick="btnsaveonclickinchecklistSectionModal()"><%= MyBase.GetResourceString("C_Save") %></a>
                                     <!-- end of added by omkar 09/01/2020 -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Section Name modal end here-->

                <!--  DELETE IR Related Settings Invoice Generators Modal Start here-->
                <div id="deleteProjectCheckListinfomodal" class="modal fade custmodal" role="dialog">
                    <div class="modal-dialog modalsmall">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                <h5 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h5>
                            </div>

                            <div class="modal-body">
                                <span id="DeleteProjectOSId"></span>
                                <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>

                                <div class="mt-2">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-6 text-start">
                                            <button class="btn borderbtn ml-1" onclick="cancelProjectCheckListDeleted()"><%= MyBase.GetResourceString("C_No") %>No</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6">
                                            <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectCheeckListData()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %>Yes</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!-- DELETE IR Related Settings InvoiceGenerators Modal end here-->

                <!--  DELETE IR Related Settings Invoice Generators Modal Start here-->
                <div id="deleteProjectCheckListIteminfomodal" class="modal fade custmodal" role="dialog">
                    <div class="modal-dialog modalsmall">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                <h5 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h5>
                            </div>

                            <div class="modal-body">
                                <span id="spnChecklistItemsIdindeleteProjectCheckListIteminfomodal"></span>
                                <span id="spnChecklistIdindeleteProjectCheckListIteminfomodal"></span>
                                <span id="spnInheritedindeleteProjectCheckListIteminfomodal"></span>
                                <span id="spnAnswerSetIdindeleteProjectCheckListIteminfomodal"></span>
                                <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>
                                <div class="form-group mt-4">
                                    <div class="row  mb-3">
                                        <div class="col-xs-6 col-sm-6 text-start">
                                            <button class="btn borderbtn ml-1" onclick="cancelProjectCheckListItemDeleted()"><%= MyBase.GetResourceString("C_No") %>No</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6">
                                            <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectCheeckListItemData()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %>Yes</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!-- DELETE IR Related Settings InvoiceGenerators Modal end here-->

                    <!--  Add by omkar 09/01/2020 -->
                 <!--  DELETE IR Related Settings Invoice Generators Modal Start here-->
                <div id="deleteProjectCheckListSectioninfomodal" class="modal fade custmodal" role="dialog">
                    <div class="modal-dialog modalsmall">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                <h5 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h5>
                            </div>
                            <div class="modal-body">
                                <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>
                                <div class="form-group mt-4">
                                    <div class="row  mb-3">
                                        <div class="col-xs-6 col-sm-6 text-start">
                                            <button class="btn borderbtn ml-1" onclick="cancelProjectCheckListSectionDeleted()"><%= MyBase.GetResourceString("C_No") %>No</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6">
                                            <button class="btn btnyellow ml-1 float-end" onclick="DeleteProjectCheeckListSectionData()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %>Yes</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!-- DELETE IR Related Settings InvoiceGenerators Modal end here-->
                <!-- end of Add by omkar 09/01/2020 -->
 </div>
                <!--Checklist modal start here-->
                <div class="modal custmodal fade" id="checklistPublishModal" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Publish_CheckList") %> </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="spnProjectCheckListId"></span>
                                <span id="spnRevisionNo"></span>
                                <div class="form-group row mb-3">
                                    <label class="control-label col-sm-4 text-end required"><%= MyBase.GetResourceString("C_Revision_Date") %> </label>
                                    <div class="col-sm-8">
                                        <div class="input-group datefielddiv">
                                           <%-- Added By Dipali  V 0n 6th May 2020 For Issue ID-24103--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtRevisionDate", "txtRevisionDate", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRevisionDate", "txtRevisionDate", "form-control",,,,,,, True, "White",, "autocomplete='off'", ,, True,,,, True) %>
                                           <%--  End of Added By Dipali  V 0n 6th May 2020 For Issue ID-24103--%>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <div class="form-group row mb-3">
                                    <label class="control-label col-sm-4 text-end required"><%= MyBase.GetResourceString("C_Revised_By") %> </label>

                                    <div class="col-sm-8">
                                        <div class="custom-dropdown">
                                            <%--by vishal Mahajan 23-12-2019--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRevisedBy", "usp_Whizible2_Sel_tbl_PM_Project_EmployeeRole_CheckListSelection " & Request.QueryString("ProjectID"),,,, True,, "'form-control selectpicker '",,, ) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRevisedBy", "usp_Whizible2_Sel_tbl_PM_Project_EmployeeRole_CheckListSelection " & Request.QueryString("ProjectID"),,, "style='width:100%!important;'", True,, "'form-select '",,, ) %>
                                            <%--by vishal Mahajan 23-12-2019--%>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                                <div class="form-group row mb-3">
                                    <label class="control-label col-sm-4 text-end required"><%= MyBase.GetResourceString("C_Approved_By") %> </label>

                                    <div class="col-sm-8">
                                        <div class="custom-dropdown">
                                            <%--by vishal Mahajan 23-12-2019--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboApprovedBy", "usp_Whizible2_Sel_tbl_PM_Project_EmployeeRole_CheckListSelection " & Request.QueryString("ProjectID"),,,, True,, "'form-control selectpicker '",,, ) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboApprovedBy", "usp_Whizible2_Sel_tbl_PM_Project_EmployeeRole_CheckListSelection " & Request.QueryString("ProjectID"),,, "style='width:100%!important;'", True,, "'form-select'",,, ) %>
                                            <%--by vishal Mahajan 23-12-2019--%>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>



                                <div class="form-group row mb-3">
                                    <label class="control-label col-sm-4 text-end required"><%= MyBase.GetResourceString("C_Reason") %></label>

                                    <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtReason", "txtReason", "Enter Reason", "form-control",,,,, , ,,,,,,,,,,,,,,,,,,,) %>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="form-group row mb-3">
                                    <%--<label class="control-label col-sm-4 text-end">&nbsp;</label>--%>
                                    <div class="col-sm-12 btn-grp-new">
                                        <a href="javascript:;" class="btn borderbtn" onclick="btnCloseOnClickPublishCheckListModel()">Close</a>
                                        <button class="btn btnyellow ml-1 float-end" onclick="btnSaveOnClickPublishCheckListModel()">Save</button>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>


                            </div>
                          
                        </div>
                    </div>
                </div>
           
            <!--Checklist modal end here-->


            <!--Page modal end here-->

        </div>

     </div>
       
       
        <div clss="clearfix"></div>
          </div>

<%--     <!-- REQUIRED JS SCRIPTS -->
     <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>      
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>    
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
<%--        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
        <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
          <script src="../../General/CommonFunctions.js"></script>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>';
            var Browser = isIE();
            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
            var blnCheckListEditAccess = "<%=m_PM_CheckListEditAccess%>";
            var ViewAccess = "<%= m_PM_CheckListViewAccess %>";
            $(document).ready(function () {
                $("body").children().first().before($(".modal")); // Added by pradip on 5-4-2023

                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectCheckList").html(bodyHTML);
                    return;
                }
                
                //by vishal Mahajan 23-12-2019
                $('select[name=cboRevisedBy] > option:first-child').text('Select Revised By').val('');
                $('select[name=cboApprovedBy] > option:first-child').text('Select Approved By').val('');
                //by vishal Mahajan 23-12-2019

                //alert(ProjectID);
                //$("#chcklistSltAll").click(function () {
                //   $(".chck-list-slt").prop('checked', $(this).prop('checked'));
                //});

                //$(".chck-list-slt").change(function(){
                //    if (!$(this).prop("checked")){
                //        $("#chcklistSltAll").prop("checked",false);
                //    }
                //});
                //#pstbl_checklists > div.right-side-save.mb-10 > a:nth-child(2)
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
                $('#txtRevisionDate').datepicker({
                    autoclose: true,
                    changeMonth: true,
                    dateFormat: 'dd M yy'

                });
              <%If m_PM_CheckListAddAccess = False Then%>
                $("#pstbl_checklists > div.right-side-save.mb-10 > a:nth-child(1)").hide();

             <%End If %>

            <%If m_PM_CheckListDeleteAccess = False Then%>
                $("#pstbl_checklists > div.right-side-save.mb-10 > a:nth-child(2)").hide();

             <%End If %>
                $("#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll").click(function () {
                    // $(".expensechck").prop('checked', $(this).prop('checked'));
                    if ($(this).prop("checked")) {
                        $('#tblbdyCheckListDetails input[type="checkbox"]').prop('checked', true);
                    } else {
                        $('#tblbdyCheckListDetails input[type="checkbox"]').prop('checked', false);
                    }
                });
                // $("#tblChecklistItems > thead > tr > th> div>input#chcklistItemAll").click(function () {
                //  $(".chklIACB").click(function () {
                //    // $(".expensechck").prop('checked', $(this).prop('checked'));
                //      alert("dafs");
                //    if ($(this).prop("checked")) {
                //        $('#tblbdyChecklistItems input[type="checkbox"]').prop('checked', true);
                //    } else {
                //        $('#tblbdyChecklistItems input[type="checkbox"]').prop('checked', false);
                //    }
                //});

                $(".closeAcco").click(function () {
                    $(this).closest(".accordian-body").removeClass("in");
                });
                getProjectName(ProjectID);
                GetWorkOrderCheckListDetails(ProjectID);

                //add by omkar 09/01/2020
                $("#txtOrderNumber").bind("keypress", function (e) {
                    var keyCode = e.which ? e.which : e.keyCode

                    if (!(keyCode >= 48 && keyCode <= 57)) {
                        //$(".error").css("display", "inline");
                        return false;
                    } else {
                        //$(".error").css("display", "none");
                    }
                });               
               
                //end of add by omkar 09/01/2020
            });
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ToCheckList%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");
                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ToCheckList%>');
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
            function checkRevision(ProjectCheckListID, ProjectID) {
                try {

                    var curRevision = 0;
                    var Data = {
                        ProjectCheckListId: encodeURI(ProjectCheckListID)
                    }

                    $.ajax({
                        url: encodeURI(strUrl + '/api/PM_CheckList/Check_Revision'),
                        type: "POST",
                        data: JSON.stringify(Data),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        async: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (Data) {
                                xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                            }
                        },
                        success: function (Result) {
                            curRevision = Result;
                        },
                        error: function (err) {
                            // alert("error");
                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                    return curRevision;
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }
            function getLatestRevision(ProjectCheckListID, ProjectID) {
                var Data = {
                    ProjectCheckListId: encodeURI(ProjectCheckListID)
                }

                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_CheckList/Save_RevisionNo'),
                    type: "POST",
                    data: JSON.stringify(Data),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Data) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                        }
                    },
                    success: function (Result) {
                        GetWorkOrderCheckListDetails(ProjectID);
                    },
                    error: function (err) {
                        // alert("error");
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

            function GetWorkOrderCheckListDetails(ProjectId) {

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/GetWorkOrderCheckListDetails',
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
                        console.log(result);

                        var WorkOrderCheckList = result.WorkOrderCheckList;

                        // console.log();
                        arrProjectCheckListIds = [];
                        //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        arrProjectCheckListItemIds = [];
                        //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        $("#tblbdyCheckListDetails").empty();
                        var strHTML = "";

                        if (WorkOrderCheckList.length != 0) {


                            for (var i = 0; i < WorkOrderCheckList.length; i++) {
                                var val;
                                var ProjectCheckListID = WorkOrderCheckList[i]["ProjectCheckListID"];
                                var CheckListShortName = WorkOrderCheckList[i]["CheckListShortName"];
                                var RevisionNo = WorkOrderCheckList[i]["RevisionNo"];
                                var RevisionStatus = WorkOrderCheckList[i]["RevisionStatus"];
                                var IsCopyChecklist = WorkOrderCheckList[i]["IsCopyChecklist"];
                                if (IsCopyChecklist == false) {
                                    val = 0;
                                } else {
                                    val = 1;
                                }
                                var IsActive = WorkOrderCheckList[i]["IsActive"];
                                strHTML += "    <tr id='r" + i + "'>"
                                if (blnCheckListEditAccess == "False") {
                                    strHTML += "    <td><a id='checklistcpy" + ProjectCheckListID + "'  ><i  class='far fa-copy copy-icon' data-original-title='Copy' ></i></a></td>"
                                    strHTML += "     <td><a id='checklistlnk" + ProjectCheckListID + "," + val + "," + i + "'>" + CheckListShortName + "</a></td>"
                                }
                                else {
                                    strHTML += "    <td><a id='checklistcpy" + ProjectCheckListID + "'  href='javascript:;' onclick='btnCopyCheckListOnclick(this.id);' ><i  class='far fa-copy copy-icon' data-original-title='Copy' ></i></a></td>"
                                    //strHTML += "     <td><a id='checklistlnk" + ProjectCheckListID + "," + val + "," + i + "' href='javascript:;' onclick='lnkCheckListOnclick(this.id);' >" + CheckListShortName + "</a></td>"
                                    //add by omkar 18/12/2019
                                    //Commented & added By Rutuja D. on 19 March 2020 For passing RevisionStatus in function for issueid = 23138
                                    //strHTML += "     <td><a id='checklistlnk" + ProjectCheckListID + "," + val + "," + i + "," + IsCopyChecklist + "' href='javascript:;' onclick='lnkCheckListOnclick(this.id);' >" + CheckListShortName + "</a></td>"
                                    strHTML += "     <td><a id='checklistlnk" + ProjectCheckListID + "," + val + "," + i + "," + IsCopyChecklist + "' href='javascript:;' onclick='lnkCheckListOnclick(this.id"+ ',&quot;' + escape(RevisionStatus) + '&quot;' + ");' >" + CheckListShortName + "</a></td>"
                                    //End Commented & added By Rutuja D.  on 19 March 2020 For passing RevisionStatus in function for issueid = 23138

                                }

                                strHTML += "   <td>" + RevisionNo + "</td>"
                                if (RevisionStatus == 'D') {
                                    strHTML += "    <td class='big-read-txt'><a id='checklistlnkpublish" + ProjectCheckListID + "," + RevisionNo + "' href='javascript:;'onclick='lnpublishkCheckListOnclick(this.id);' >Publish</a></td>"
                                } else {
                                    strHTML += "    <td class='big-read-txt'><span style='color: red;'>Published</span></td>"
                                }
                                val = '';
                                if (IsCopyChecklist == false) {
                                    strHTML += "<td>Inherited</td> "
                                } else {
                                    strHTML += "<td>Project Specific</td> "
                                }

                                if (IsActive == true) {
                                    strHTML += "  <td>Yes</td>"
                                } else {
                                    strHTML += "  <td>No</td>"
                                }

                                if (IsCopyChecklist == false) {
                                    var chkRevision = 0;
                                    chkRevision = checkRevision(ProjectCheckListID, ProjectId);

                                    if (chkRevision == 0) {
                                        strHTML += "    <td><a href='javascript:;' onclick='getLatestRevision(" + ProjectCheckListID + ", " + ProjectId + ")'>Get Latest Revision</span></td>";
                                    }
                                    else {
                                        strHTML += "    <td class='big-read-txt'><span style='color: red;'>Latest</span></td>";
                                    }
                                } else {
                                    strHTML += "<td></td> "
                                }

                                strHTML += "    <td class='inp-select'>"
                                strHTML += "        <div class='custom_chckbox'>"
                                strHTML += "            <input type='checkbox' id='chcklistSlt" + ProjectCheckListID + "' class='chckHead chck-list-slt' onchange = 'CheckListchkbxclickevent(this.id)'>"
                                strHTML += "             <label for='chcklistSlt" + ProjectCheckListID + "'></label>"
                                strHTML += "       </div>"
                                strHTML += "</td>"
                                strHTML += "</tr>"

                                strHTML += "    <tr id='r" + i + 1 + "'>"
                                strHTML += "    <td id='c" + i + 1 + "' colspan='8' class='hiddenRow subCustomField text-start'>"
                                strHTML += "</td>"
                                strHTML += "</tr>"
                            }
                        } else {
                            strHTML += "<tr> <td colspan='8'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }

                        $("#tblbdyCheckListDetails").html(strHTML);
                        $('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').prop('checked', false);
                        //$("#tblTimeshetApprovers ").css('width','100%');
                        // add by omkar 18/12/2019
                        if (WorkOrderCheckList.length > 0) {
                            $('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').removeAttr("disabled");
                        } else {
                            $('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').attr("disabled", true);
                        }
                        //end

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function btnCopyCheckListOnclick(id) {
                // alert(id);
                var checklistid = id.replace('checklistcpy', '');
                $("#copyModal > div > div > div.modal-body > div > div > div>input#txtcpychecklistname").val('');
                $("#spncpychecklistID").removeAttr("value");
                $('#spncpychecklistID').attr('value', checklistid);


                $("#copyModal").modal("show");

            }

            function copychecklistmodelbtncloseclick() {
                $("#spncpychecklistID").removeAttr("value");
                $("#copyModal > div > div > div.modal-body > div > div > div>input#txtcpychecklistname").val('');

                $("#copyModal").modal("hide");
            }

            function copychecklistmodelbtnsaveclick() {

                var flag = true;
                var OldProjectCheckListID = $("#spncpychecklistID").attr("value");

                var CheckListShortName = $("#copyModal > div > div > div.modal-body > div > div > div>input#txtcpychecklistname").val();


                if (CheckListShortName.length == 0) {
                    //copychecklistmodelbtncloseclick();
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_CheckList_Name_should_not_be_left_blank") %>';
                    //alertify.error("CheckList Name should not be left blank.");
                    alertify.error(message);
                    $("#copyModal > div > div > div.modal-body > div > div > div>input#txtcpychecklistname").focus();
                    flag = false;
                    return false;
                }


                if (flag == true) {
                    //add by omkar 18/12/2019
                    // CheckListShortName = CheckListShortName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")
                    //end
                    var checkList = {
                        OldProjectCheckListID: encodeURI(OldProjectCheckListID),
                        CheckListShortName: encodeURI(CheckListShortName)


                    };

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_CheckList/CopyCheckList',
                        method: 'Post',
                        data: JSON.stringify(checkList),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (checkList) {
                                xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                            }
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                   // var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                            // if (ProjectSalesPersonID == 0) {
                            var message = '<%= MyBase.GetResourceString("C_Check_List_Successfully_Copied") %>';
                            // alertify.success("Check List Successfully Copied.");
                            alertify.success(message);
                        //alertify.success("Sales Commission Settings Save SuccessFully");
                   // } else {
                         // var message = '<%= MyBase.GetResourceString("C_Check_List_Successfully_Copied") %>';
                            //alertify.success("Sales Commission Settings Updated SuccessFully");
                            //alertify.success("Sales Commission Settings Updated SuccessFully");
                            //  }
                            copychecklistmodelbtncloseclick();
                            GetWorkOrderCheckListDetails(ProjectID);


                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });



                }

            }

            var arrProjectCheckListIds = [];
            //Added By Usha Pandit On 14.07.2020 For rephrasing alert
            var arrProjectCheckListItemIds = [];
            //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
            function tblCheckListDetailsCheckBoxChecked() {

                $('#tblCheckListDetails > tbody> tr').each(function (index, value) {
                    // debugger
                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);
                        //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        if (i == 1) {
                            curChecklistItemName = $(this).text();                            
                        }
                        //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        if (i == 7) {
                            var id = $(this).find('input[type=checkbox]').attr("id");
                            // console.log(id);


                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chcklistSlt', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (arrProjectCheckListIds.indexOf(id) == -1) {

                                    arrProjectCheckListIds.push(id);
                                }
                                //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                                if (arrProjectCheckListItemIds.indexOf(curChecklistItemName) == -1) {

                                    arrProjectCheckListItemIds.push(curChecklistItemName);
                                } 
                                //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                            }
                            //console.log(id);

                        }

                    });
                });
            }

            function CheckListchkbxclickevent(id) {
                CheckListAllchkbxchekedoruncheckd();
            }



            function CheckListAllchkbxchekedoruncheckd() {

                var ck_box_cnt = $('#tblbdyCheckListDetails input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdyCheckListDetails input[type="checkbox"]:checked').length;
                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').prop('checked', true);
                } else {
                    $('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').prop('checked', false);
                }
            }

            function CheckListbtnDeleteClick() {
                tblCheckListDetailsCheckBoxChecked();
                if (arrProjectCheckListIds.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Atleast_Select_One") %>';

                    //alertify.error("Atleast Select One ");

                    alertify.error(message);
                } else {
                    $("#deleteProjectCheckListinfomodal").modal('show');
                }

            }
            function cancelProjectCheckListDeleted() {
                arrProjectCheckListIds = [];
                //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                arrProjectCheckListItemIds = [];
                //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                $("#deleteProjectCheckListinfomodal").modal('hide');
            }

            function DeleteProjectCheeckListData(ProjectId) {

                var checkList = {
                    //Comment And Added By Riddhesh Patil on 21st March
                    //UniqueIDs: arrProjectCheckListIds,
                    //ProjectId: encodeURI(ProjectId)
                    UniqueIDs: arrProjectCheckListIds.toString(),
                    ProjectId: ProjectId
                    //End of Comment And Added By Riddhesh Patil on 21st March
                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/DeletedCheckList',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        alertify.set('notifier', 'position', 'top-right');
                        //Added & Commented By Dipali V On 6th May 2020 For IssueID=24104
                        <%--var message = '<%= MyBase.GetResourceString("C_Deleted_SuccessFully") %>';--%>
                        //Commented And Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        //var message = 'Checklist item deleted successfully';
                        var message = "Checklist item(s) - '" + arrProjectCheckListItemIds + "' deleted successfully";
                        //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        //End of Added & Commented By Dipali V On 6th May 2020 For IssueID=24104
                        var DeletedResult = result.DeletedResult;
                        if (DeletedResult.length > 0) {
                            for (var i = 0; i < DeletedResult.length; i++) {
                                alertify.error(DeletedResult[i]);
                            }
                        } else {
                            alertify.success(message);
                            refreshMyParent();
                        }

                        //  alertify.success("Deleted SuccessFully");

                        cancelProjectCheckListDeleted();
                        //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                        GetWorkOrderCheckListDetails(ProjectID);
                        $('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').prop('checked', false);


                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }


            function GetWorkOrderCheckListData(ProjectId) {
                if (ProjectId == undefined) {
                    ProjectId = 0;
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/GetWorkOrderCheckListData',
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
                        console.log(result);
                       
                        var WorkOrderCheckList = result.WorkOrderCheckList;
                        // console.log();
                        QuestionnaireIDs = [];
                        CheckListShortNames = [];
                        //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        CheckListShortNamesForDelete = [];
                        //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        $("#tblbdySelectCheckList").empty();
                        var strHTML = "";

                        if (WorkOrderCheckList.length != 0) {


                            for (var i = 0; i < WorkOrderCheckList.length; i++) {
                                var CheckListShortName = WorkOrderCheckList[i]["CheckListShortName"];
                                var QuestionnaireID = WorkOrderCheckList[i]["QuestionnaireID"];

                                strHTML += "    <tr>"
                                strHTML += "   <td>" + CheckListShortName + "</td>"


                                strHTML += "    <td class='inp-select'>"
                                strHTML += "        <div class='custom_chckbox'>"
                                //strHTML +="            <input type='checkbox' id='chcklistSCL"+QuestionnaireID+"' class='chckHead chck-list-slt' onchange = 'CheckListchkbxclickevent(this.id)'>"
                                //add by omkar 18/12/2019
                                strHTML += "            <input type='checkbox' id='chcklistSCL" + QuestionnaireID + "' class='chckHead chck-list-slt' >"
                                strHTML += "             <label for='chcklistSCL" + QuestionnaireID + "'></label>"
                                strHTML += "       </div>"
                                strHTML += "</td>"



                                strHTML += "</tr>"



                            }
                        } else {
                            strHTML += "<tr> <td colspan='5'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }

                        $("#tblbdySelectCheckList").html(strHTML);
                        //$('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').prop('checked', false);
                        //$("#tblTimeshetApprovers ").css('width','100%');
                        //add by omkar 18/12/2019
                        if (WorkOrderCheckList.length == 0) {
                            $("#selectTempModal > div > div > div > div > a.btn.btnyellow").hide();
                        } else {
                            $("#selectTempModal > div > div > div > div > a.btn.btnyellow").show();
                        }
                        //end

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function CheckListbtnSelectChecklistClick() {
                $("#selectTempModal").modal('show');
                GetWorkOrderCheckListData(ProjectID);

            }
            function btncloseonclickinselectTempModal() {
              //  $("#selectTempModal").modal('hide');//Commented By Dipali V On 20th May 2020 For Issue ID 23055
            }

            var QuestionnaireIDs = [];
            var CheckListShortNames = [];
            //Added By Usha Pandit On 14.07.2020 For rephrasing alert
            var CheckListShortNamesForDelete = [];
            var curChecklistName = "";
            var curChecklistItemName = "";
            //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
            function tblSelectCheckListCheckBoxChecked() {

                $('#tblSelectCheckList > tbody> tr').each(function (index, value) {

                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);
                        //add by omkar 18/12/2019
                        if (i == 1) {
                            var id = $(this).find('input[type=checkbox]').attr("id");

                            // console.log(id);


                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chcklistSCL', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (QuestionnaireIDs.indexOf(id) == -1) {

                                    QuestionnaireIDs.push(id);
                                }
                                
                                
                                //debugger
                                // var j = 0;
                                // if (i == i-1) {
                                var trno = parseInt(index) + 1;
                                var tdid = "#tblbdySelectCheckList > tr:nth-child(" + trno + ") > td:nth-child(1)"
                                var ChecklistName = $(tdid).text();


                                if (CheckListShortNames.indexOf(ChecklistName) == -1) {

                                    CheckListShortNames.push(ChecklistName);
                                }                                

                                // }

                            }


                        }
                        //end


                    });
                });
            }

            function btnsaveonclickinselectTempModal() {
                tblSelectCheckListCheckBoxChecked();
                if (QuestionnaireIDs.length > 0) {

                    //Added by Chetan M on 10 June 2021 for Crash on adding checklist on project
                    for (var i = 0; i < CheckListShortNames.length; i++) {                        
                        if (CheckListShortNames[i].indexOf("'") > -1) {
                            CheckListShortNames[i]= CheckListShortNames[i].replace(/'/g, "''");
                        }                        
                    }
                    //End of Added by Chetan M on 10 June 2021 for Crash on adding checklist on project
                    var checkList = {
                         //Comment And Added By Riddhesh Patil on 21st March
                       // QuestionnaireIDs: QuestionnaireIDs,
                       // CheckListShortNames: CheckListShortNames,
                        QuestionnaireIDs: QuestionnaireIDs.toString(),
                        CheckListShortNames: CheckListShortNames.toString(),
                        ProjectId: encodeURI(ProjectID)
                         //End of Comment And Added By Riddhesh Patil on 21st March
                    };

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_CheckList/InsertWorkOrderCheckList',
                        method: 'Post',
                        data: JSON.stringify(checkList),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (checkList) {
                                xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                            }
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Save_SuccessFully") %>';

                            alertify.success(message);
                            //alertify.success("Save SuccessFully");

                            //cancelProjectCheckListDeleted();
                            //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                            btncloseonclickinselectTempModal();
							$("#selectTempModal").modal('hide');
                            GetWorkOrderCheckListDetails(ProjectID);
                            $('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').prop('checked', false);
                            refreshMyParent();
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                } else {
                    //btncloseonclickinselectTempModal();
                  /*  /Commented & Added By Dipali V On 27th March for alert issue*/
                  <%--  var message = '<%= MyBase.GetResourceString("C_Atleast_Select_One") %>';--%>
                    var message = '<%= MyBase.GetResourceString("C_Atleast_Select_One_Save") %>';
                    ///End of Commented & Added By Dipali V On 27th March for alert issue
                    alertify.set('notifier', 'position', 'top-right');
                    // alertify.error("Atleast Selected One");
                    alertify.error(message);

                }

            }
            function lnpublishkCheckListOnclick(id) {
                //alert(id);checklistlnkpublish1210,0

                $("#spnProjectCheckListId").removeAttr("value");
                $("#spnRevisionNo").removeAttr("value");
                var TempId = id.replace('checklistlnkpublish', '');
                TempId = TempId.split(',');
                //console.log(TempId);
                WorkOrderCheckListGetSpecificDataCount(TempId[0]);
                //add by omkar 18/12/2019
                if (WorkOrderCheckListItemCount == 0) {
                    var message = '<%= MyBase.GetResourceString("C_Checklist_Publish") %>';
                    alertify.set('notifier', 'position', 'top-right');
                    // alertify.error("Atleast Selected One");
                    alertify.error(message);
                } else {
                    $('#spnProjectCheckListId').attr('value', TempId[0]);
                    $('#spnRevisionNo').attr('value', TempId[1]);
                    $('#checklistPublishModal').modal('show');
                }

            }
            function btnCloseOnClickPublishCheckListModel() {
                //Added By Rutuja D. 20 Dec 2019
                //$('#checklistPublishModal > div > div > div > div > div>input#txtRevisionDate').val('');
                $('#checklistPublishModal > div > div > div > div> div > div>input#txtRevisionDate').val('');
                //End Added By Rutuja D. 20 Dec 2019
                $("#checklistPublishModal > div > div > div > div > div>textarea#txtReason").val('');
                $("#spnProjectCheckListId").removeAttr("value");
                $("#spnRevisionNo").removeAttr("value");
                $('#checklistPublishModal').modal('hide');

            }

            function btnSaveOnClickPublishCheckListModel() {
                //#checklistPublishModal > div > div > div > div > div>input#txtRevisionDate
                //#checklistPublishModal > div > div > div > div > div>div>div>select#cboRevisedBy
                //#checklistPublishModal > div > div > div > div > div > div > div >select#cboApprovedBy
                //#checklistPublishModal > div > div > div > div > div>textarea#txtReason
                var Flag = true;
                var ProjectCheckListId = $("#spnProjectCheckListId").attr("value");
                var RevisionNo = $("#spnRevisionNo").attr("value");
                //by vishal Mahajan 23-12-2019
                //var RevisedBy = $("#checklistPublishModal > div > div > div > div > div>div>div>select#cboRevisedBy option:selected").val();
                //var ApprovedBy = $("#checklistPublishModal > div > div > div > div > div > div > div >select#cboApprovedBy option:selected").val();
                var RevisedBy = $("#checklistPublishModal select#cboRevisedBy option:selected").val();
                var ApprovedBy = $("#checklistPublishModal select#cboApprovedBy option:selected").val();
                //by vishal Mahajan 23-12-2019
                //Added By Rutuja D. 20 Dec 2019
                //var RevisionDate = $("#checklistPublishModal > div > div > div > div > div>input#txtRevisionDate").val();
                var RevisionDate = $("#checklistPublishModal > div > div > div > div> div > div>input#txtRevisionDate").val();
                //End Added By Rutuja D. 20 Dec 2019
                var Reason = $("#checklistPublishModal > div > div > div > div > div>textarea#txtReason").val();
                //parseDate
                if (RevisionDate.length == 0) {
                    //btnCloseOnClickPublishCheckListModel();
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Please_Enter_the_Revision_Date") %>';
                    // alertify.error("Please Enter the Revision Date");
                    alertify.error(message);

                    Flag = false;
                    return false;
                }

                if (parseDate(RevisionDate) == false) {
                    //btnCloseOnClickPublishCheckListModel();
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Invalid_Date_format_or_Invalid_Date") %>';
                    // alertify.error("Invalid Date format or Invalid Date.");
                    alertify.error(message);

                    Flag = false;
                    return false;
                }

                if (RevisedBy.length == 0) {
                    //btnCloseOnClickPublishCheckListModel();
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Please_Select_Revised_By") %>';
                    //alertify.error("Please Select  Revised By");
                    alertify.error(message);

                    Flag = false;
                    return false;
                }
                if (ApprovedBy.length == 0) {
                    //btnCloseOnClickPublishCheckListModel();
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Please_Select_Approved_By") %>';
                    //alertify.error("Please Select Approved By");
                    alertify.error(message);

                    Flag = false;
                    return false;
                }
                //Commented & Added By Dipali V On 7th Dec 2020 For Disallow blank space
                //if (Reason.length == 0) {
                if (Reason.trim().length == 0) {
                     //End of Commented & Added By Dipali V On 7th Dec 2020 For Disallow blank space
                    //btnCloseOnClickPublishCheckListModel();
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Reason_should_not_be_left_blank") %>';
                    //  alertify.error("Reason should not be left blank.");
                    alertify.error(message);

                    Flag = false;
                    return false;
                }



                if (Flag == true) {


                    var checkList = {

                        RevisionNo: encodeURI(RevisionNo),
                        ProjectId: encodeURI(ProjectID),
                        ProjectCheckListId: encodeURI(ProjectCheckListId),
                        Revisiondate: encodeURI(RevisionDate),
                        RevisedBy: encodeURI(RevisedBy),
                        ApprovedBy: encodeURI(ApprovedBy),
                        Reason: encodeURI(Reason)

                    };

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_CheckList/PublishCheckList',
                        method: 'Post',
                        data: JSON.stringify(checkList),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (checkList) {
                                xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                            }
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Check_List_Publish_SuccessFully") %>';

                            alertify.success(message);
                            // alertify.success("Check List Publish SuccessFully");

                            //cancelProjectCheckListDeleted();
                            //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                            btnCloseOnClickPublishCheckListModel();
                            GetWorkOrderCheckListDetails(ProjectID);



                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }
            var TempTRID;
            var Previousid = "";
            var GobalProjectCheckListID;
            var GobalInheritedVal;
            //add by  omkar 18/12/2019
            var ProjectChecklistId;
            // Commented & Added By Rutuja D.  on 19 March 2020 For Disabled Revision No. TextBox when Revision Status is Published issuedid = 23138
            //function lnkCheckListOnclick(id) {
            var RevisionStatus = "";
            function lnkCheckListOnclick(id, Status) {
            RevisionStatus = unescape(Status);

            // End Commented & Added By Rutuja D.  on 19 March 2020 For Disabled Revision No. TextBox when Revision Status is Published adding Revision status in function issuedid = 23138
               
                // alert(id);
                // debugger
                //checklistlnk1207,0
                //#c61>#divCheckListDetails
                var Tempid;
                // $('#divCheckListDetails').hide();
                ProjectChecklistId = "";
                ProjectChecklistId = id;
                Tempid = id.replace('checklistlnk', '');
                Tempid = Tempid.split(',');
                //add by omkar 18/12/2019
                //alert(Tempid[3]);
                if (Tempid[3] == "false") {
                  //  alert(1);
                    $("#chcklistItems > div > a:nth-child(1)").hide();
                    $("#chcklistItems > div > a:nth-child(2)").hide();
                } else {
                   // alert(2);
                    $("#chcklistItems > div > a:nth-child(1)").show();
                    $("#chcklistItems > div > a:nth-child(2)").show();
                }
                //end

                if (Previousid.length > 0) {
                    var Tempid1;
                    // $('#divCheckListDetails').hide();
                    //$('#divCheckListDetails').slideUp("slow");
                    GobalProjectCheckListID = "";
                    GobalInheritedVal = "";
                    $(".chkliacb#chcklistItemAll").prop("checked", false);
                    // var divId = $(Previousid+">#divCheckListDetails").clone();
                    // $("#TempdivCheckListDetails").append(divId);
                    $(Previousid).empty();
                }

                // Previousid = "";
                var Tempid;
                $('#divCheckListDetails').hide();
                Tempid = id.replace('checklistlnk', '');
                Tempid = Tempid.split(',');
                $("#spnProjectCheckListIDindivCheckListDetails").removeAttr("value");
                $('#spnProjectCheckListIDindivCheckListDetails').attr('value', Tempid[0]);
                $("#spnInheritedindivCheckListDetails").removeAttr("value");
                $('#spnInheritedindivCheckListDetails').attr('value', Tempid[1]);
                $('#spnrowCheckListDetails').attr('value', Tempid[2]);
                WorkOrderCheckListGetSpecificData(Tempid[0], Tempid[1]);
                GobalProjectCheckListID = Tempid[0];
                GobalInheritedVal = Tempid[1];

                var TrId = $("#divCheckListDetails").clone();
                // $("#divCheckListDetails").remove();
                // console.log(TrId);
                var colid = "#c" + Tempid[2] + "1";

                $(colid).append(TrId);
                //$('#divCheckListDetails').show();
                //$('#divCheckListDetails').toggle('slow');
                if (Previousid == colid) {
                    $('#divCheckListDetails').show();
                } else {

                    $('#divCheckListDetails').slideToggle('slow');
                }
                Previousid = "";
                Previousid = colid;

                //$('#divCheckListDetails').slideDown("slow");

                //add by omkar 09/01/2020
                $("#tblCheckListDetails>#tblbdyCheckListDetails>tr > td:nth-child(1)>a").addClass("clsEditEditchecklist");
                $("#tblCheckListDetails>#tblbdyCheckListDetails>tr > td:nth-child(2)>a").addClass("clsEditEditchecklist");
                $("#tblCheckListDetails>#tblbdyCheckListDetails>tr > td:nth-child(4)>a").addClass("clsEditEditchecklist");
                $('#pstbl_checklists > div.right-side-save.mb-10 > a:nth-child(1)').addClass("clsEditEditchecklist");
                $('#pstbl_checklists > div.right-side-save.mb-10 > a:nth-child(2)').addClass("clsEditEditchecklist");
                $(".clsEditEditchecklist").prop("disabled", true);
               
                if (Browser == 'IE') {
                }
                else {
                    $(".clsEditEditchecklist").css({ 'pointer-events': 'none' });
                }
                //end of add by omkar 09/01/2020

                
            }

            function btncloseonclickindivCheckListDetails() {
                //add by omkar 18/12/2019
                ProjectChecklistId = "";
                $("#spnProjectCheckListIDindivCheckListDetails").removeAttr("value");
                $("#spnInheritedindivCheckListDetails").removeAttr("value");
                $("#spnrowCheckListDetails").removeAttr("value");
                $('#divCheckListDetails').hide();
                //  Previousid = "";

                //add by omkar 09/01/2020
                $(".clsEditEditchecklist").attr("disabled", false);
                if (Browser == 'IE') {
                }
                else {
                    $(".clsEditEditchecklist").css({ 'pointer-events': 'initial', 'cursor': 'pointer' });
                }
                //end of add by omkar 09/01/2020
            }
            var ProjectCheckListItemIDs = [];
            function WorkOrderCheckListGetSpecificData(ProjectCheckListID, InheritedVal) {
            
                
                var checkList = {
                    ProjectCheckListId: encodeURI(ProjectCheckListID)
                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/WorkOrderCheckListGetSpecificData',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        //console.log(result.WorkOrderCheckList);
                        //console.log(result.WorkOrderCheckListItem);
                        ProjectCheckListItemIDs = [];
                        var WorkOrderCheckList = result.WorkOrderCheckList;
                        var WorkOrderCheckListItem = result.WorkOrderCheckListItem;
                        //add by omkar 09/01/2020
                        var WorkOrderCheckListSection = result.WorkOrderCheckListSection;
                        //end of add by omkar 09/01/2020
                        for (var i = 0; i < WorkOrderCheckList.length; i++) {
                            var CheckListShortName = WorkOrderCheckList[i]["CheckListShortName"];
                            var IsActive = WorkOrderCheckList[i]["IsActive"];
                            var RevisionNo = WorkOrderCheckList[i]["RevisionNo"];
                           
                            //commented and added by omkar 15/1/2020
                            //if (InheritedVal == 1) {
                            if (InheritedVal == 1 || InheritedVal == "undefined"|| InheritedVal == undefined) {                                     
                                //end of add by omkar 15/1/2020
                                
                                $("#divCheckListDetails > div > div> div> div>input#txtChecklistName").removeAttr("disabled");
                                //Commented & Added By Rutuja D. on 19 March 2020 For Disabled Revision No. TextBox when Revision Status is Published issuedid = 23138
                                //$("#divCheckListDetails > div > div > div > div>input#txtRevisionNo").removeAttr("disabled");
                                if (RevisionStatus == 'D' || RevisionStatus == '') {
                                $("#divCheckListDetails > div > div > div > div>input#txtRevisionNo").removeAttr("disabled");
                                }
                                else {
                                $("#divCheckListDetails > div > div > div > div>input#txtRevisionNo").attr("disabled", "disabled");
                                }
                                //End Commented & Added By Rutuja D. on 19 March 2020 For Disabled Revision No. TextBox when Revision Status is Published issuedid = 23138

                                $("#divCheckListDetails > div > div> div> div>input#txtChecklistName").val(CheckListShortName);
                                $("#divCheckListDetails > div > div > div > div>input#txtRevisionNo").val(RevisionNo);
                                $("#chcklistItems > div > div > a:nth-child(1)").show();
                                $("#chcklistItems > div > div > a:nth-child(2)").show();
                                 //add by omkar 09/01/2020
                                $("#chcklistSections > div.right-side-save.mb-10.mr-0 > a:nth-child(1)").show();
                                $("#chcklistSections > div.right-side-save.mb-10.mr-0 > a:nth-child(2)").show();
                                $("#sectionNameModal > div > div > div.modal-body > div.center-align > a.btn.btnyellow").show();

                                //end of add by omkar 09/01/2020
                            } else {
                                $("#divCheckListDetails > div > div> div> div>input#txtChecklistName").val(CheckListShortName);
                                $("#divCheckListDetails > div > div > div > div>input#txtRevisionNo").val(RevisionNo);
                                $("#divCheckListDetails > div > div> div> div>input#txtChecklistName").attr("disabled", "disabled");
                                $("#divCheckListDetails > div > div > div > div>input#txtRevisionNo").attr("disabled", "disabled");
                                $("#chcklistItems > div > div > a:nth-child(1)").hide();
                                $("#chcklistItems > div > div > a:nth-child(2)").hide();
                                //add by omkar 09/01/2020
                                $("#chcklistSections > div.right-side-save.mb-10.mr-0 > a:nth-child(1)").hide();
                                $("#chcklistSections > div.right-side-save.mb-10.mr-0 > a:nth-child(2)").hide();
                                $("#sectionNameModal > div > div > div.modal-body > div.center-align > a.btn.btnyellow").hide();

                                //end of add by omkar 09/01/2020
                            }

                            if (IsActive == true) {
                                $('#divCheckListDetails > div > div > div > div > div > div>input#chkIsActive').prop('checked', true);
                            } else {
                                $('#divCheckListDetails > div > div > div > div > div > div>input#chkIsActive').prop('checked', false);
                            }
                        }


                        $("#tblbdyChecklistItems").empty();
                        var strHTML = "";

                        if (WorkOrderCheckListItem.length != 0) {


                            for (var i = 0; i < WorkOrderCheckListItem.length; i++) {
                                var CheckListItemName = WorkOrderCheckListItem[i]["CheckListItemName"];
                                var ProjectCheckListItemID = WorkOrderCheckListItem[i]["ProjectCheckListItemID"];
                                 //add by omkar 15/1/2020
                                var ProjectCheckListID = WorkOrderCheckListItem[i]["ProjectCheckListID"];
                                //end of add by omkar 15/1/2020
                                var Compulsory = WorkOrderCheckListItem[i]["Compulsory"];
                                var IsActive1 = WorkOrderCheckListItem[i]["IsActive"];
                                var SectionName = WorkOrderCheckListItem[i]["SectionName"];
                                
                                strHTML += " <tr>"
                                strHTML += "       <td><a id='lnkChecklistItems" + ProjectCheckListItemID + "," + ProjectCheckListID + "," + InheritedVal + "' href='javascript:;' onclick='lnkChecklistItems(this.id);' >" + CheckListItemName + "</a></td>"
                                if (Compulsory == true) {
                                    strHTML += "                         <td>Yes</td>"
                                } else {
                                    strHTML += "                         <td>No</td>"
                                }
                                if (IsActive1 == true) {
                                    strHTML += "                         <td>Yes</td>"
                                } else {
                                    strHTML += "                         <td>No</td>"
                                }
                                //strHTML += "                         <td>"+IsActive1+"</td>"
                                if (SectionName == null) {
                                    SectionName = "";
                                }
                                strHTML += "                         <td>" + SectionName + "</td>"
                                strHTML += "    <td class='inp-select'>"
                                strHTML += "        <div class='custom_chckbox'>"
                                strHTML += "            <input type='checkbox' id='chcklistitem" + ProjectCheckListItemID + "' class='chckHead chck-list-slt' onchange = 'CheckListItemchkbxclickevent(this.id)'>"
                                strHTML += "             <label for='chcklistitem" + ProjectCheckListItemID + "'></label>"
                                strHTML += "       </div>"
                                strHTML += "</td>"

                                strHTML += "                     </tr>"

                            }
                        } else {
                            strHTML += "<tr> <td colspan='5'  height='5'><center>There are no items to show in this view.</center></td> </tr>";

                        }
                        $("#tblbdyChecklistItems").html(strHTML);

                        //add by omkar 09/01/2020

                         $("#tblbdychcklistSections").empty();
                        var strHTML = "";

                        if (WorkOrderCheckListSection.length != 0) {


                            for (var i = 0; i < WorkOrderCheckListSection.length; i++) {
                                var ProjectCategoryID = WorkOrderCheckListSection[i]["ProjectCategoryID"];
                                var ProjectCheckListID = WorkOrderCheckListSection[i]["ProjectCheckListID"];
                                var Description = WorkOrderCheckListSection[i]["Description"];
                                var CategoryCode = WorkOrderCheckListSection[i]["CategoryCode"];
                                var OrderNo = WorkOrderCheckListSection[i]["OrderNo"];

                                strHTML += " <tr>"
                                strHTML += "       <td><a id='lnkChecklistsection" + ProjectCategoryID + "," + ProjectCheckListID + "," + InheritedVal + "' href='javascript:;' onclick='lnkChecklistSection(this.id);' >" + Description + "</a></td>"

                                strHTML += "                         <td>" + CategoryCode + "</td>"
                                strHTML += "                         <td>" + OrderNo + "</td>"
                                strHTML += "    <td class='inp-select'>"
                                strHTML += "        <div class='custom_chckbox'>"
                                strHTML += "            <input type='checkbox' id='chcklistsection" + ProjectCategoryID + "' class='chckHead chck-list-slt' onchange = 'CheckListSectionchkbxclickevent(this.id)'>"
                                strHTML += "             <label for='chcklistsection" + ProjectCategoryID + "'></label>"
                                strHTML += "       </div>"
                                strHTML += "</td>"

                                strHTML += "                     </tr>"

                            }
                        } else {
                            strHTML += "<tr> <td colspan='5'  height='5'><center>There are no items to show in this view.</center></td> </tr>";

                        }
                        $("#tblbdychcklistSections").html(strHTML);

                        if (WorkOrderCheckListSection.length != 0) {
                            $("#chcklistSections > table > thead > tr > th.inp-select > div>input#sectionSltAll").removeAttr("disabled");
                        } else {
                            $("#chcklistSections > table > thead > tr > th.inp-select > div>input#sectionSltAll").attr("disabled", true);
                        }
                        //end of add by omkar 09/01/2020

                        //add by omkar 18/12/2019
                        if (WorkOrderCheckListItem.length != 0) {
                            $("#tblChecklistItems > thead > tr > th.inp-select > div>input#chcklistItemAll").removeAttr("disabled");
                        } else {
                            $("#tblChecklistItems > thead > tr > th.inp-select > div>input#chcklistItemAll").attr("disabled", true);
                        }
                        //end

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

            function btnsaveonclickindivCheckListDetails() {

                var Flag = true;
                var ProjectCheckListId = $("#spnProjectCheckListIDindivCheckListDetails").attr("value");
                var Inherited = $("#spnInheritedindivCheckListDetails").attr("value");
                var row = $("#spnrowCheckListDetails").attr("value");

                var ChecklistName = $("#divCheckListDetails > div > div> div> div>input#txtChecklistName").val();
                var RevisionNo = $("#divCheckListDetails > div > div > div > div>input#txtRevisionNo").val();
                var active;
                if ($("#divCheckListDetails > div > div > div > div > div > div>input#chkIsActive").prop("checked")) {
                    //active = true;
                    active = 1;
                } else {
                    //active = false;
                    active = 0;
                }

                if (ChecklistName.length == 0) {
                    btnCloseOnClickPublishCheckListModel();
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Please_Enter_Check_list_Name") %>';
                    // alertify.error("Please Enter Check list Name");
                    alertify.error(message);

                    Flag = false;
                    return false;
                }



                if (Flag == true) {


                    var checkList = {
                        //Comment And Added By Riddhesh Patil on 21st March
                        //CheckListShortName: encodeURI(ChecklistName),
                        CheckListShortName: ChecklistName,
                        //End of Comment And Added By Riddhesh Patil on 21st March
                        ProjectId: encodeURI(ProjectID),
                        IsActive: encodeURI(active),
                        ProjectCheckListId: encodeURI(ProjectCheckListId)
                    };

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_CheckList/Update_WorkOrderCheckList',
                        method: 'Post',
                        data: JSON.stringify(checkList),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (checkList) {
                                xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                            }
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Check_List_Updated_SuccessFully") %>';

                            alertify.success(message);
                            //Added By Dipali V On 14th Dec 2021 For Issue ID 31732
                            var Checklist = "";
                            if (Inherited == "0") {
                                Checklist = "false";
                            }
                            else {
                                Checklist = "true";
                            }
                            // alertify.success("Check List Updated SuccessFully");
                            if (Checklist != "") {
                                var id = "checklistlnk" + ProjectCheckListId + "," + Inherited + "," + row + "," + Checklist;
                            }
                            else {
                                var id = "checklistlnk" + ProjectCheckListId + "," + Inherited + "," + row;
                            }
                            //End of Added By Dipali V On 14th Dec 2021 For Issue ID 31732

                            GetWorkOrderCheckListDetails(ProjectID);
                            lnkCheckListOnclick(id);


                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }

            }

            function lnkChecklistItems(id) {
                //alert(id);
                //lnkChecklistItems1604
                var TempId = id.replace('lnkChecklistItems', '');
                TempId = TempId.split(',');
                $("#spnChecklistItemsIdindivchecklistModal").removeAttr("value");
                $('#spnChecklistItemsIdindivchecklistModal').attr('value', TempId[0]);
                $("#spnChecklistIdindivchecklistModal").removeAttr("value");
                $('#spnChecklistIdindivchecklistModal').attr('value', TempId[1]);
                $("#spnInheritedindivchecklistModal").removeAttr("value");
                $('#spnInheritedindivchecklistModal').attr('value', TempId[2]);
                BindDropDownListcboSection(TempId[1]);
                if (TempId[0] != 0) {
                    WorkOrderCheckListItemGetSpecificData(TempId[0]);
                }

                //add by omkar 08/01/2020 issue 21173
                //Commented and added by omkar 15/01/2020 issue 21173
                //if (TempId[2] == "1") {
                //    $("#checklistModal > div > div > div.modal-body > div> a.btn.btnyellow").show();
                //} else {
                //    $("#checklistModal > div > div > div.modal-body > div> a.btn.btnyellow").hide();
                //}
                if (TempId[2] == "1" || TempId[2] == "undefined" || TempId[2] == undefined) {
                    $("#checklistModal > div > div > div.modal-body > div> a.btn.btnyellow").show();
                } else {
                    $("#checklistModal > div > div > div.modal-body > div> a.btn.btnyellow").hide();
                }
                //end of added by omkar 15/01/2020 issue 21173

                $("#checklistModal").modal('show');

            }
            function WorkOrderCheckListItemGetSpecificData(ProjectCheckListItemID) {

                var checkList = {
                    ProjectCheckListItemID: encodeURI(ProjectCheckListItemID)

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/WorkOrderCheckListItemGetSpecificData',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        var WorkOrderCheckListItem = result.WorkOrderCheckListItem;
                        for (var i = 0; i < WorkOrderCheckListItem.length; i++) {
                            var CheckListItemName = WorkOrderCheckListItem[i]["CheckListItemName"];
                            var CatagoryId = WorkOrderCheckListItem[i]["CatagoryId"];
                            var IsActive = WorkOrderCheckListItem[i]["IsActive"];
                            var Compulsory = WorkOrderCheckListItem[i]["Compulsory"];
                            var AnswerSetId = WorkOrderCheckListItem[i]["AnswerSetId"];
                            var CatagoryId = WorkOrderCheckListItem[i]["CatagoryId"];
                            $("#spnAnswerSetIdindivchecklistModal").removeAttr("value");
                            $('#spnAnswerSetIdindivchecklistModal').attr('value', AnswerSetId);
                            $("#checklistModal select#cboAnswerSet option[value='" + AnswerSetId + "']").prop('selected', true);
                            $("#checklistModal select#cboSection option[value='" + CatagoryId + "']").prop('selected', true);

                            $("#checklistModal input#txtCheckListItemName").val(CheckListItemName);
                            if (IsActive == true) {
                                $('#checklistModal > div > div > div > div > div > div > div>input#chkActiveStatus').prop('checked', true);
                            } else {
                                $('#checklistModal > div > div > div > div > div > div > div>input#chkActiveStatus').prop('checked', false);
                            }

                            if (Compulsory == true) {
                                $('#checklistModal > div > div > div > div > div > div > div>input#chkmandatoryStatus').prop('checked', true);
                            } else {
                                $('#checklistModal > div > div > div > div > div > div > div>input#chkmandatoryStatus').prop('checked', false);
                            }
                        }

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
            function BindDropDownListcboSection(ProjectCheckListId) {
                var checkList = {
                    ProjectCheckListId: encodeURI(ProjectCheckListId)

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/CheckLIstProjectCategory',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        //console.log(result);

                        var strResult = result.WorkOrderCheckListItem;
                        //$("#checklistModal > div > div > div > div > div > div > div > div>select#cboSection").empty();
                        $("#checklistModal select#cboSection").empty();
                        if (strResult != undefined) {
                            var selHTML = "";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            selHTML += "<option value=''> Select Section </option>";
                            for (var i = 0; i < strResult.length; i++) {
                                //debugger;
                                var ProjectCategoryID = strResult[i]["ProjectCategoryID"];
                                var Description = strResult[i]["Description"];
                                // var ReportingTo = d.ReportingTo;
                                //var EmployeeName = d.EmployeeName;
                                //var Category = d.Category;
                                // selHTML += "<option  value='" + ProjectCategoryID + "'  >" + Description + "</option>";
                                selHTML += "<option  value='" + ProjectCategoryID + "'  >" + Description + "</option>";
                            }
                            // StopAjaxLoader("#bodyIssueList");

                            // $("#txtPhaseFilterResponsiblePerson").html(selHTML);
                            //$("#checklistModal > div > div > div > div > div > div > div > div>select#cboSection").html(selHTML);
                            $("#checklistModal select#cboSection").html(selHTML);
                            //$("#addsales > div > div > div.modal-body > div > div.row > div.form-group.col-sm-6 >select#cboSalesPerson").addClass("selectpicker");


                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        // $('#tblSalesPersonsDetails > thead > tr > th.sm-wid>div.custom_chckbox>input#resourceAll').prop('checked', false);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });


            }

            function btnsaveonclickinchecklistModal() {
                var Flag = true;
                var ChecklistItemsId = $("#spnChecklistItemsIdindivchecklistModal").attr("value");
                var ChecklistId = $("#spnChecklistIdindivchecklistModal").attr("value");
                var Inherited = $("#spnInheritedindivchecklistModal").attr("value");
                //var Inherited = $("#spnInheritedindivCheckListDetails").attr("value");
                // var row = $("#spnrowCheckListDetails").attr("value");

                //var CheckListItemName = $("#checklistModal > div > div > div > div > div > div>input#txtCheckListItemName").val();
                var CheckListItemName = $("#txtCheckListItemName").val();
                var CatagoryId = $("#checklistModal select#cboSection option:selected").val();
                var AnswerSet = $("#checklistModal select#cboAnswerSet option:selected").val();
                var active;
                if ($("#checklistModal > div > div > div > div > div > div > div>input#chkActiveStatus").prop("checked")) {
                    active = true;
                } else {
                    active = false;
                }
                var mandatory;
                if ($("#checklistModal > div > div > div > div > div > div > div>input#chkmandatoryStatus").prop("checked")) {
                    mandatory = true;
                } else {
                    mandatory = false;
                }

                if (CheckListItemName.length == 0) {
                    // btnCloseOnClickPublishCheckListModel();
                    //btncloseonclickinchecklistModal()
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Check_List_Item_Name_should_not_be_blank") %>';
                    //alertify.error("Check List Item Name should not be blank");
                    alertify.error(message);
                    $("#txtCheckListItemName").focus();
                    Flag = false;
                    return false;
                }
                if (AnswerSet == 0) {
                    // btnCloseOnClickPublishCheckListModel();
                    //btncloseonclickinchecklistModal()
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Please_Select_Answer_Set") %>';
                    //  alertify.error("Please Select Answer Set");
                    alertify.error(message);
                    $("#cboAnswerSet").focus();
                    Flag = false;
                    return false;
                }



                if (Flag == true) {

                    //Added by Nikhil Adkar on 5-Apr-2023 for Request Validate Header 
                    if (active == true) {
                        active = 1;
                    }
                    else {
                        active = 0;
                    }
                    if (mandatory == true) {
                        mandatory = 1;
                    }
                    else {
                        mandatory = 0;
                    }
                    //End Of Added By Nikhil Adkar for Request Validate Header
                    var checkList = {

                        ProjectId: encodeURI(ProjectID),
                        ProjectCheckListId: encodeURI(ChecklistId),
                        CheckListItemName: encodeURI(CheckListItemName),
                        CatagoryId: encodeURI(CatagoryId),
                        AnswerSetId: encodeURI(AnswerSet),
                        Compulsory: encodeURI(mandatory),
                        IsActive: encodeURI(active),
                        ProjectCheckListItemID: encodeURI(ChecklistItemsId)
                    };

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_CheckList/InsertWorkOrderCheckListItem',
                        method: 'Post',
                        data: JSON.stringify(checkList),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (checkList) {
                                xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                            }
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                        // var message = '<%= MyBase.GetResourceString("C_Check_List_Item_Save_SuccessFully") %>';
                        // var message = '<%= MyBase.GetResourceString("C_Check_List_Item_Updated_SuccessFully") %>';

                            // alertify.success(result);
                            if (ChecklistItemsId == 0) {
                                var message = '<%= MyBase.GetResourceString("C_Check_List_Item_Save_SuccessFully") %>';
                                //  alertify.success("Check List Item Save SuccessFully");
                                alertify.success(message);
                            } else {
                                var message = '<%= MyBase.GetResourceString("C_Check_List_Item_Updated_SuccessFully") %>';
                                // alertify.success("Check List Item Updated SuccessFully");
                                alertify.success(message);
                            }
                            //Commented And Added by omkar 08/01/2020
                            //btncloseonclickinchecklistModal();
                            //WorkOrderCheckListGetSpecificData(ChecklistId, Inherited);
                             
                            btncloseonclickinchecklistModal();
                            GetWorkOrderCheckListDetails(ProjectID);
                           
                            lnkCheckListOnclick(ChecklistId);
                            WorkOrderCheckListGetSpecificData(ChecklistId, Inherited);
                            //end of Added by omkar 08/01/2020


                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }

            }

            function checklistitemclear() {
                var CheckListItemName = $("#checklistModal > div > div > div > div > div > div>input#txtCheckListItemName").val('');

                $("#checklistModal > div > div > div > div > div > div > div>input#chkActiveStatus").prop("checked", false);

                $("#checklistModal > div > div > div > div > div > div > div>input#chkmandatoryStatus").prop("checked", false);

            }

            function btncloseonclickinchecklistModal() {
                $("#spnChecklistItemsIdindivchecklistModal").removeAttr("value");
                $("#spnChecklistIdindivchecklistModal").removeAttr("value");
                $("#spnInheritedindivchecklistModal").removeAttr("value");
                $("#checklistModal").modal('hide');
                $("#checklistModal select#cboAnswerSet").prop("selectedIndex", 0);
                $("#checklistModal select#cboSection").prop("selectedIndex", 0);
                //  var CatagoryId = $("#checklistModal select#cboSection option:selected").val();
                // var AnswerSet = $("#checklistModal select#cboAnswerSet option:selected").val();
            }
            function btnAddonclickinChecklistItem() {
                //spnProjectCheckListIDindivCheckListDetails,spnInheritedindivCheckListDetails,spnrowCheckListDetails
                var CheckListID = $("#spnProjectCheckListIDindivCheckListDetails").attr("value");
                var Inherited = $("#spnInheritedindivCheckListDetails").attr("value");
                $("#spnAnswerSetIdindivchecklistModal").removeAttr("value");
                $('#spnAnswerSetIdindivchecklistModal').attr('value', 0);
                checklistitemclear();
                var id = "lnkChecklistItems" + 0 + "," + CheckListID + "," + Inherited;
                lnkChecklistItems(id);
            }

            function binddataansersetview() {
                var AnswerSetID = $("#spnAnswerSetIdindivchecklistModal").attr("value");
                var checkList = {
                    AnswerSetID: encodeURI(AnswerSetID)
                }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/CheckList_Q_Answer',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        console.log(result);


                        var WorkOrderCheckList = result.tbl_Q_Answer;
                        // console.log();
                        QuestionnaireIDs = [];
                        CheckListShortNames = [];
                        //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        CheckListShortNamesForDelete = [];
                        //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        $("#tblbdyAnswerSetPreview").empty();
                        var strHTML = "";

                        if (WorkOrderCheckList.length != 0) {


                            for (var i = 0; i < WorkOrderCheckList.length; i++) {
                                var AnswerDescription = WorkOrderCheckList[i]["AnswerDescription"];
                                var IsNegative = WorkOrderCheckList[i]["IsNegative"];
                                var OrderInWhichToAppear = WorkOrderCheckList[i]["OrderInWhichToAppear"];

                                strHTML += "    <tr>"
                                strHTML += "   <td>" + AnswerDescription + "</td>"
                                if (IsNegative == true) {
                                    strHTML += "   <td>Yes</td>"
                                } else {
                                    strHTML += "   <td>No</td>"
                                }
                                strHTML += "   <td>" + OrderInWhichToAppear + "</td>"

                                strHTML += "</tr>"



                            }
                        } else {
                            strHTML += "<tr> <td colspan='3'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }

                        $("#tblbdyAnswerSetPreview").html(strHTML);
                        //$('#tblCheckListDetails > thead > tr > th.inp-select > div>input#chcklistSltAll').prop('checked', false);
                        //$("#tblTimeshetApprovers ").css('width','100%');


                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                $("#ansSet").modal('show');
            }



            function tblSelectCheckListItemCheckBoxChecked() {
                QuestionnaireIDs = [];
                //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                CheckListShortNamesForDelete = [];                
                //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert

                $('#tblChecklistItems > tbody> tr').each(function (index, value) {
                    // debugger
                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);
                        
                        //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        if (i == 0) {
                            curChecklistName = $(this).text();
                        }
                        //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        if (i == 4) {
                            var id = $(this).find('input[type=checkbox]').attr("id");

                            // console.log(id);
                            //chcklistitem1581

                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chcklistitem', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (QuestionnaireIDs.indexOf(id) == -1) {

                                    QuestionnaireIDs.push(id);
                                }   
                                //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                                if (CheckListShortNamesForDelete.indexOf(curChecklistName) == -1) {

                                    CheckListShortNamesForDelete.push(curChecklistName);
                                }
                                //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                            }


                        }

                        if (i == 0) {
                            var ChecklistName = $(this).text();


                            if (CheckListShortNames.indexOf(ChecklistName) == -1) {

                                CheckListShortNames.push(ChecklistName);
                            }
                             
                            
                        }

                    });
                });
            }

            function btnDeleteonclickinChecklistItem() {
                tblSelectCheckListItemCheckBoxChecked();
                //console.log(QuestionnaireIDs);
                if (QuestionnaireIDs.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                    var message = '<%= MyBase.GetResourceString("C_Atleast_Select_One") %>';
                    //alertify.error("Atleast Select One ");

                    alertify.error(message);
                } else {
                    $("#deleteProjectCheckListIteminfomodal").modal('show');
                }
            }
            function checklistitemallcheck() {

                //$("#tblChecklistItems > thead > tr > th> div>input#chcklistItemAll").click(function () {
                //  $(".chklIACB").click(function () {
                // $(".expensechck").prop('checked', $(this).prop('checked'));
                //alert("dafs");
                if ($(".chkliacb#chcklistItemAll").prop("checked")) {
                    $('#tblbdyChecklistItems input[type="checkbox"]').prop('checked', true);
                } else {
                    $('#tblbdyChecklistItems input[type="checkbox"]').prop('checked', false);
                }
                // });


            }

            function CheckListItemchkbxclickevent(id) {
                CheckListItemAllchkbxchekedoruncheckd();


            }


            function cancelProjectCheckListItemDeleted() {
                QuestionnaireIDs = [];
                //Added By Usha Pandit On 14.07.2020 For rephrasing alert
                CheckListShortNamesForDelete = [];
                //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                $("#deleteProjectCheckListIteminfomodal").modal('hide');
            }

            function DeleteProjectCheeckListItemData() {

                var checkList = {

                    ProjectCheckListItemIDs: QuestionnaireIDs.toString(),


                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/DeletedCheckListItem',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        alertify.set('notifier', 'position', 'top-right');
                        //Commented And Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        <%--var message = '<%= MyBase.GetResourceString("C_Deleted_SuccessFully") %>';--%>
                        var message = "Checklist item(s) - '" + CheckListShortNamesForDelete + "' deleted successfully";
                        //End Of Added By Usha Pandit On 14.07.2020 For rephrasing alert
                        alertify.success(message);
                        //alertify.success("Deleted SuccessFully");
                        
                        //cancelProjectCheckListDeleted();
                        //IRRelatedSettingsAddSalesPersonModelbtnCloseClick();
                        //GetWorkOrderCheckListDetails(ProjectID);
                        $('#tblChecklistItems > thead > tr > th.inp-select > div>input#chcklistItemAll.chckHead').prop('checked', false);

                        cancelProjectCheckListItemDeleted();
                        //add by omkar 18/12/2019

                        var id = ProjectChecklistId;

                        GetWorkOrderCheckListDetails(ProjectID);
                        lnkCheckListOnclick(id);
                        WorkOrderCheckListGetSpecificData(GobalProjectCheckListID, GobalInheritedVal);
                        //end
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }


            function CheckListItemAllchkbxchekedoruncheckd() {
                var row = $("#spnrowCheckListDetails").attr("value");
                var ck_box_cnt = $('#c' + row + '1 #tblbdyChecklistItems input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#c' + row + '1 #tblbdyChecklistItems input[type="checkbox"]:checked').length;
                var id = '#c' + row + '1 #chcklistItems #tblChecklistItems .chkliacb#chcklistItemAll';
                // alert(id);
                if (ck_box_cnt == chk_box_checked_cnt) {
                    //  $('#c'+row+'1 #chcklistItems #tblChecklistItems .chkliacb#chcklistItemAll').prop('checked', true);
                    $(id).prop('checked', true);
                } else {
                    // $('#c'+row+'1 #chcklistItems #tblChecklistItems .chkliacb#chcklistItemAll').prop('checked', false);
                    $(id).prop('checked', false);
                }
            }


            function getProjectName(ProjectId) {
                //var ProjectId = ProjectId;
                var Parameter = { ProjectId: ProjectId }
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
                        //console.log(result);
                        $("#spnProjectName").text(result);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            //add by omkar 18/12/2019
            var WorkOrderCheckListItemCount;
            function WorkOrderCheckListGetSpecificDataCount(ProjectCheckListID) {
                var checkList = {
                    ProjectCheckListId: encodeURI(ProjectCheckListID)
                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/WorkOrderCheckListGetSpecificData',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        //console.log(result.WorkOrderCheckList);
                        //console.log(result.WorkOrderCheckListItem);
                        // ProjectCheckListItemIDs = [];
                        // var WorkOrderCheckList=result.WorkOrderCheckList;
                        WorkOrderCheckListItemCount = "";
                        var WorkOrderCheckListItem = result.WorkOrderCheckListItem;
                        WorkOrderCheckListItemCount = WorkOrderCheckListItem.length;

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
        //end



            //add by omkar 09/01/2020
             function lnkChecklistSection(id) {
                // debugger;
                //lnkChecklistItems1604
                 //lnkChecklistItems0
                 //Commented & Added By Dipali V On 6th May 2020 For Issue ID-24110
                //var TempId = id.replace('lnkChecklistsection', ' ');

                 if (id.indexOf('lnkChecklistsection') != -1) {
                    var TempId = id.replace('lnkChecklistsection', ' ');
                 } else{
                    var TempId = id.replace('lnkChecklistItems', '');
                 }
                
                 TempId = TempId.split(',');
                 TempId[0] = TempId[0].split(" ").join("")
                 //End of Commented & Added By Dipali V On 6th May 2020 For Issue ID-24110
                $("#spnChecklistSectionIdsectionNameModal").removeAttr("value");
                $('#spnChecklistSectionIdsectionNameModal').attr('value', TempId[0]);
                $("#spnChecklistIdsectionNameModal").removeAttr("value");
                $('#spnChecklistIdsectionNameModal').attr('value', TempId[1]);
                $("#spnInheritedindsectionNameModal").removeAttr("value");
                $('#spnInheritedindsectionNameModal').attr('value', TempId[2]);
                
                if (TempId[0] != 0) {
                    WorkOrderCheckListSectionGetSpecificData(TempId[0]);
                }
                //add by omkar 08/01/2020 issue 21173
                if (TempId[2] == "1") {
                    $("#checklistModal > div > div > div.modal-body > div> a.btn.btnyellow").show();
                } else {
                    $("#checklistModal > div > div > div.modal-body > div> a.btn.btnyellow").hide();
                }
                //end of add by omkar 08/01/2020 issue 21173
                $("#sectionNameModal").modal('show');

            }

              function WorkOrderCheckListSectionGetSpecificData(ProjectCategoryID) {
               
                var checkList = {
                    ProjectCategoryID: encodeURI(ProjectCategoryID)

                };

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/WorkOrderCheckListSectionGetSpecificData',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                        var WorkOrderCheckListSection = result.WorkOrderCheckListSection;
                        //alert(WorkOrderCheckListSection);
                        for (var i = 0; i < WorkOrderCheckListSection.length; i++) {
                            var Description = WorkOrderCheckListSection[i]["Description"];
                            var CategoryCode = WorkOrderCheckListSection[i]["CategoryCode"];
                            var OrderNo = WorkOrderCheckListSection[i]["OrderNo"];
                           // $("txtSectionName").val();
                            $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionName").val(Description);
                            //$("txtSectionCode").val();
                            $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionCode").val(CategoryCode);
                           // $("txtOrderNumber").val();
                            $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtOrderNumber").val(OrderNo);
                          
                            
                        }

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

             function btncloseonclickinchecklistSectionModal() {
                $("#spnChecklistSectionIdsectionNameModal").removeAttr("value");
                $("#spnChecklistIdsectionNameModal").removeAttr("value");
                $("#spnInheritedindsectionNameModal").removeAttr("value");
                $("#sectionNameModal").modal('hide');
              
              
            }

            function btnsaveonclickinchecklistSectionModal() {
                 //debugger
                var Flag = true;
                var ProjectCategoryID = $("#spnChecklistSectionIdsectionNameModal").attr("value");
                var ChecklistId = $("#spnChecklistIdsectionNameModal").attr("value");
                var Inherited = $("#spnInheritedindsectionNameModal").attr("value");
               
                  var Description=$("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionName").val();
                        
                           var CategoryCode =$("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionCode").val();
                         
                var OrderNo = $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtOrderNumber").val();
                
                          

                

                if (Description.length == 0) {
                    // btnCloseOnClickPublishCheckListModel();
                    //btncloseonclickinchecklistModal()
                    alertify.set('notifier', 'position', 'top-right');
                   var message = '<%= MyBase.GetResourceString("C_Section_Name_should_not_be_blank") %>';
                   // alertify.error("Section Name should not be blank");
                    alertify.error(message);
                    $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionName").focus();
                    Flag = false;
                    return false;
                 }
                  if (CategoryCode.length == 0) {
                    // btnCloseOnClickPublishCheckListModel();
                    //btncloseonclickinchecklistModal()
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Section_Code_should_not_be_blank") %>';
                   // alertify.error("Section Code should not be blank");
                    alertify.error(message);
                    $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionCode").focus();
                    Flag = false;
                    return false;
                 }
                 if (OrderNo.length == 0) {
                    // btnCloseOnClickPublishCheckListModel();
                    //btncloseonclickinchecklistModal()
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_OrderNo_should_not_be_blank") %>';
                    //alertify.error("Section Code should not be blank");
                    alertify.error(message);
                    $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtOrderNumber").focus();
                    Flag = false;
                    return false;
                }
                OrderNo = parseInt(OrderNo);
                //Added By Dipali v On 12th June 2020 For Issue ID 25086
                //if (OrderNo < 0 || OrderNo > 999) {
                 if (OrderNo < 1 || OrderNo > 999) {
                    // btnCloseOnClickPublishCheckListModel();
                    //btncloseonclickinchecklistModal()
                    alertify.set('notifier', 'position', 'top-right');
                    var message = 'The value of Order Number should be in the range of (1-999)';
                    //alertify.error("The value of 'Order Number' should be in the range of (0-999)");
					//End of Added By Dipali v On 12th June 2020 For Issue ID 25086
                    alertify.error(message);
                    $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtOrderNumber").focus();
                    Flag = false;
                    return false;
                }
               


                if (Flag == true) {


                    var checkList = {

                        ProjectId: encodeURI(ProjectID),
                        ProjectCheckListId: encodeURI(ChecklistId),
                        ProjectCategoryID: encodeURI(ProjectCategoryID),
                        Description: encodeURI(Description),
                        CategoryCode: encodeURI(CategoryCode),
                        OrderNo: encodeURI(OrderNo)
                        
                    };

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_CheckList/InsertWorkOrderCheckListSection',
                        method: 'Post',
                        data: JSON.stringify(checkList),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (checkList) {
                                xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                            }
                        },
                        success: function (result) {
                           // console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                        // var message = '<%= MyBase.GetResourceString("C_Check_List_Item_Save_SuccessFully") %>';
                        // var message = '<%= MyBase.GetResourceString("C_Check_List_Item_Updated_SuccessFully") %>';

                            // alertify.success(result);
                            //alert(ProjectCategoryID);
                            if (ProjectCategoryID == 0) {
                                var message = '<%= MyBase.GetResourceString("C_Check_List_Section_Save_SuccessFully") %>';
                                //alertify.success("Check List Section Save SuccessFully");
                                alertify.success(message);
                            } else {
                                var message = '<%= MyBase.GetResourceString("C_Check_List_Section_Updated_SuccessFully") %>';
                                 //alertify.success("Check List Section Updated SuccessFully");
                               alertify.success(message);
                            }
                            //Add by omkar 08/01/2020
                            btncloseonclickinchecklistSectionModal();
                            GetWorkOrderCheckListDetails(ProjectID);
                           
                            lnkCheckListOnclick(ChecklistId);
                            WorkOrderCheckListGetSpecificData(ChecklistId, Inherited);
                             
                             $('#divCheckListDetails > div > div.inner-tabing > ul > li > a[href="#chcklistSections"]').tab('show');
                            //end of Add by omkar 08/01/2020


                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }

            }

             function btnAddonclickinChecklistSection() {
                //spnProjectCheckListIDindivCheckListDetails,spnInheritedindivCheckListDetails,spnrowCheckListDetails
                var CheckListID = $("#spnProjectCheckListIDindivCheckListDetails").attr("value");
                var Inherited = $("#spnInheritedindivCheckListDetails").attr("value");
                $("#spnChecklistSectionIdsectionNameModal").removeAttr("value");
                $('#spnChecklistSectionIdsectionNameModal').attr('value', 0);
                checklistSectionclear();
                var id = "lnkChecklistItems" + 0 + "," + CheckListID + "," + Inherited;
                lnkChecklistSection(id);
            }

              function checklistSectionclear() {
                 $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionName").val('');
                        
                 $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtSectionCode").val('');
                         
                 $("#sectionNameModal > div > div > div.modal-body > div.row.form-group > div>#txtOrderNumber").val('');

               

            }

             function checklistSectionallcheck() {

               
                if ($(".chckHead#sectionSltAll").prop("checked")) {
                    $('#tblbdychcklistSections input[type="checkbox"]').prop('checked', true);
                } else {
                    $('#tblbdychcklistSections input[type="checkbox"]').prop('checked', false);
                }
                // });


            }

            function CheckListSectionchkbxclickevent() {
                //debugger
                var row = $("#spnrowCheckListDetails").attr("value");
                var ck_box_cnt = $('#c' + row + '1 #tblbdychcklistSections input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#c' + row + '1 #tblbdychcklistSections input[type="checkbox"]:checked').length;
                var id = '#c' + row + '1 #chcklistSections .chckHead#sectionSltAll';
                // alert(id);
                if (ck_box_cnt == chk_box_checked_cnt) {
                    //  $('#c'+row+'1 #chcklistItems #tblChecklistItems .chkliacb#chcklistItemAll').prop('checked', true);
                    $(id).prop('checked', true);
                } else {
                    // $('#c'+row+'1 #chcklistItems #tblChecklistItems .chkliacb#chcklistItemAll').prop('checked', false);
                    $(id).prop('checked', false);
                }
            }

            function btnDeleteonclickinChecklistSection() {
                tblSelectCheckListsectionCheckBoxChecked();
                //console.log(QuestionnaireIDs);
                if (ProjectCategoryIDs.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    //var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                   var message = '<%= MyBase.GetResourceString("C_Atleast_Select_One_Check_List_Section") %>';
                   // alertify.error("Atleast Select One Check List Section");

                   alertify.error(message);
                } else {
                    $("#deleteProjectCheckListSectioninfomodal").modal('show');
                }
            }
            var ProjectCategoryIDs = [];
             function tblSelectCheckListsectionCheckBoxChecked() {
                 ProjectCategoryIDs = [];
                  var row = $("#spnrowCheckListDetails").attr("value");
                $('#tblbdychcklistSections > tr').each(function (index, value) {
                   
                    var message = "";
                   
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);

                        if (i == 3) {
                             //debugger
                            var id = $(this).find('input[type=checkbox]').attr("id");

                            // console.log(id);
                            //chcklistitem1581

                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                 //debugger
                                //console.log("checked");
                                id = id.replace('chcklistsection', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (ProjectCategoryIDs.indexOf(id) == -1) {

                                    ProjectCategoryIDs.push(id);
                                }

                            }


                        }

                       

                    });
                });
            }


             function cancelProjectCheckListSectionDeleted() {
                ProjectCategoryIDs = [];
                $("#deleteProjectCheckListSectioninfomodal").modal('hide');
            }

            function DeleteProjectCheeckListSectionData() {

                var checkList = {
                    //Commented & Added By Dipali V On 8th April 2023 For Delete Crash
                    //ProjectCategoryIDs: ProjectCategoryIDs
                    ProjectCategoryIDs: ProjectCategoryIDs.toString()
                    //End of Commented & Added By Dipali V On 8th April 2023 For Delete Crash

                };
               

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_CheckList/DeletedCheckListSection',
                    method: 'Post',
                    data: JSON.stringify(checkList),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (checkList) {
                            xhr.setRequestHeader("Params", encryptString(isJson(checkList) ? checkList : JSON.stringify(checkList)));
                        }
                    },
                    success: function (result) {
                       
                        

                        alertify.set('notifier', 'position', 'top-right');
                        var message = '<%= MyBase.GetResourceString("C_Check_List_Section_Deleted_SuccessFully") %>';

                       alertify.success(message);
                       
                        $('#chcklistSections .chckHead#sectionSltAll').prop('checked', false);

                        cancelProjectCheckListSectionDeleted();
                        //add by omkar 18/12/2019

                        var id = ProjectChecklistId;

                        GetWorkOrderCheckListDetails(ProjectID);
                        lnkCheckListOnclick(id);
                        WorkOrderCheckListGetSpecificData(GobalProjectCheckListID, GobalInheritedVal);
                          $('#divCheckListDetails > div > div.inner-tabing > ul > li > a[href="#chcklistSections"]').tab('show');
                        //end
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            //end of add by omkar 09/01/2020

        </script>

  
</body>

</html>
