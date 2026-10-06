<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Issue_Aging.aspx.vb" Inherits="PbNIT.Issue_Aging" %>

<!DOCTYPE html>
<html>
         <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Issue Aging")%> 
<head>  
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Issue Aging</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <!-- animate css -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css"  />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css?v=1" />

    

</head>
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
        .filter button.activfltr {
            background: #4263c1;
            color: white;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }
        .dataTables_scrollBody {
            margin-bottom: 10px
        }
        /*New Style*/
        .topfltr .form-group {
            margin-right: 15px
        }

            .topfltr .form-group select.form-control, .topfltr .form-group select.form-control {
                width: 200px
            }

        .rowheading {
            background: #e7edf0
        }

            .rowheading td {
                font-weight: 700
            }

        tfoot tr {
            background: #e7edf0
        }

            tfoot tr td {
                font-weight: 700
            }

        .filedownload {
            margin-left: 10px
        }

            .filedownload img {
                margin-right: 10px
            }

            .filedownload .dropdown-menu > li > a {
                padding: 3px 10px
            }

        .dataTables_paginate a.paginate_button.disabled {
            cursor: no-drop
        }

        .dataTables_paginate a.paginate_button {
            border: 1px solid #e9e9e9;
            min-width: 40px;
            display: inline-block;
            text-align: center;
            height: 32px;
            padding: 8px;
            line-height: 14px;
            color: #1359a6;
            margin-left: -1px;
            cursor: pointer
        }

            .dataTables_paginate a.paginate_button.current {
                background: #1359a6;
                color: #fff;
                cursor: pointer
            }

        .ui-datepicker {
            z-index: 9999 !important
        }

        .pr0 {
            padding-right: 0
        }

        .custom_radio input[type="radio"] {
            display: none
        }

            .custom_radio input[type="radio"] + label span {
                display: inline-block;
                width: 15px;
                height: 15px;
                background: transparent;
                vertical-align: middle;
                border: 1px solid #464a4c;
                border-radius: 50%;
                padding: 2px;
                margin: 0 12px
            }

            .custom_radio input[type="radio"]:checked + label span {
                width: 15px;
                height: 15px;
                background: #464a4c;
                background-clip: content-box
            }

        .custom_radio span {
            margin: 0 10px 0 0 !important
        }

        table tr th, table tr td {
            text-align: center !important
        }

            table tr th:last-child, table tr td:last-child {
                text-align: center
            }

        .modalDTtabl {
            width: 100% !important
        }

        span.time {
            display: block;
        }

        .mt-1 {
            margin-top: 10px;
        }

        .btn-light {
            background: #e2e6ea;
        }

        .stastusbtn {
            display: block;
            cursor: auto;
        }

        .btn-secondary {
            background: #5a6268;
            color: #fff !important;
        }

        #IssueAgingTbl_wrapper table th {
            min-width: 80px;
        }

        h5.ftitle {
            font-weight: bold;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 30px;
            color: #435a9c;
            margin-top: 0px;
        }
     /*   .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }*/
        .filterpanelbody .borderbox {
            border: 1px solid #ddd;
            padding: 15px;
            background: #fff;
            border-radius: 4px;
            height: 100%;
        }

        .row.row-eq-height {
            display: flex;
        }

        .filterleft .borderbox {
            margin-bottom: 15px;
        }

        span.met {
            color: green;
        }

        span.notmet {
            color: red;
        }

        .caret {
    display: inline-block;
    width: 0;
    height: 0;
    margin-left: 2px;
    vertical-align: middle;
    border-top: 4px dashed;
    border-top: 4px solid\9;
    border-right: 4px solid transparent;
    border-left: 4px solid transparent;
}

        .show {
    display: block!important;
}
        .table-bordered>:not(caption)>* {
    border-width: 0;
}
        label{font-weight:700}

        th.sorting_asc.sorting_disabled::after, th.sorting_asc.sorting_disabled::before
        {
            display:none !important;
        }
        /*.filter button[aria-expanded="true"] {
            background: #4263c1 !important;
            color: #4263c1 !important;
            padding: 4px 6px !important;
            font-size: 12px !important;
            border-radius: 4px !important;
        }*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyIssueAging">
<% If m_ViewAccess = True Then %>
    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left"><%= MyBase.GetResourceString("C_IssueAging")%></h5>
            <a href="javascript:;" class="clearalllink" style="" onclick="ClearAll()" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline pull-right">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
        </div>
        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse" style="margin-bottom:10px;">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
 
               <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="dropdown">
                            <%--<a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false" onclick="AllMyFilters()"><%= MyBase.GetResourceString("C_MyFilters")%><span class="caret"></span></a>--%>
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false" ><%= MyBase.GetResourceString("C_MyFilters")%><span class="caret"></span></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                            </ul>
                        </li>
                        <li class="">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true" id="CatBasicFilter"><%= MyBase.GetResourceString("C_BasicFilters")%></a>
                        </li>
                    </ul>
               </div>

               <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" onclick="btnSaveAndApplyFilter_Onclick()"><%= MyBase.GetResourceString("Btn_SaveandApply")%></button>
                                    <button class="btn btnyellow" id="btnApplyBasicFilter" onclick="ApplyFilter()"><%= MyBase.GetResourceString("Btn_Apply")%></button>
                                </div>
                                <br />

                                <div class="row mb-1">
                                    <div class="col-sm-12 filterleft">
                                        <div class="borderbox">
                                            <h5 class="ftitle"><%= MyBase.GetResourceString("C_ProjectLevel")%></h5>

                                            <div class="notebox graybg">
                                                <strong>Note :</strong> Project Selection is appliable only, where Aging Duration is Set at each Project (Accessible)
                                            </div>

                                            <div class="row">
                                            <div class="col-sm-6 form-group">
                                              <%--  Commented & added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                <%--<label class="col-sm-4 required">Project</label>--%>
                                                <label class="col-sm-4 required"><%= MyBase.GetResourceString("C_Project")%></label>
                                                  <%--End of Commented & added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                <div class="col-sm-8">
                                                    <div class="row">                                                       
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectIDFilter", "select '' ",,, "class='form-control' onChange='javascript:ProjectDrop_OnChange(this.value);'", True,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_IssueStatus")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">                                                        
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <%--Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatusFilter", "Exec usp_Whizible2_Sel_ProjectStatus " & Session("intProjectID") & ",NULL," & Session("intPostID"),,, "class='form-control'",) %>--%>
                                                             <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatusFilter", "Exec usp_Whizible2_Sel_ProjectStatus NULL,NULL," & Session("intPostID"),,, "class='form-control'",) %>
                                                             <%--End of Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                </div>
                                            <%--<div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Customer</label>
                                                <div class="col-sm-8">
                                                    <div class="row">                                                       
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerIDFilter", "Exec usp_Whizible2_Sel_CustomerName ",,, "class='form-control' onChange='javascript:Customer_OnChange(this.value);'", False,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <%--<div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Product</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProductVersionIDFilter", "Select '' ",,, "class='form-control' onChange='javascript:Product_OnChange(this.value);'", False,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <%--<div class="col-sm-6 form-group">
                                                <label class="col-sm-4">Module/Component</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboComponentIDFilter", "Select ''",,, "class='form-control'") %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <div class="row">                                            
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_Module")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboModuleNameFilter", "Exec usp_Whizible2_Sel_Module " & Session("intProjectID"),,, "class='form-control'",) %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboModuleNameFilter", "Select ''",,, "class='form-control'",) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_Type")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">                                                       
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                                 <%--Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                            <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboTypeNameFilter", "Exec usp_Whizible2_Sel_Type " & Session("intProjectID") & ",'T',Null,Null,Null,Null,Null," & Session("intPostID"),,, "class='form-control' onChange='javascript:Type_OnChange(this.value);'", False,,) %>---%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboTypeNameFilter", "Exec usp_Whizible2_Sel_Type NULL,'T',Null,Null,Null,Null,Null," & Session("intPostID"),,, "class='form-control' onChange='javascript:Type_OnChange(this.value);'", False,,) %>
                                                             <%--End of Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                </div>
                                            <div class="row">                                            
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_SubType")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboSubTypeFilter", "usp_Whizible2_Sel_SubTaskTypes " & Session("intProjectID") & ",S,''",,, "class='form-control'") %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboSubTypeFilter", "Select ''",,, "class='form-control'") %>
                                                        </div>
                                                    </div>
                                                </div>                                                
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_Iteration")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                                 <%--Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboIterationIDFilter", "Exec usp_Whizible2_Sel_Iteration " & Session("intProjectID"),,, "class='form-control'",) %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboIterationIDFilter", "Exec usp_Whizible2_Sel_Iteration NULL",,, "class='form-control' onChange='javascript:Iteration_OnChange(this.value);'",) %>
                                                             <%--End of Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                </div>
                                            <div class="row">
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_UserStories")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                                 <%--Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboUserStoryIDFilter", "Exec usp_Whizible2_Sel_UserstoryID " & Session("intProjectID"),,, "class='form-control'",) %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboUserStoryIDFilter", "Exec usp_Whizible2_Sel_UserstoryID NULL",,, "class='form-control'",) %>
                                                             <%--End of Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_ResponsiblePerson")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                                 <%--Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboAssignToFilter", "Exec usp_Whizible2_Sel_ResponsiblePerson " & Session("intProjectID"),,, "class='form-control'",) %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboAssignToFilter", "Exec usp_Whizible2_Sel_ResponsiblePerson NULL",,, "class='form-control'",) %>
                                                             <%--End of Commented & Added By Dipali V On 28th Nov 2022 For Base Ugradde--%>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                            </div>
                                                </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="borderbox">
                                            <h5 class="ftitle"><%= MyBase.GetResourceString("C_CorporateLevel")%></h5>
                                            <div class="row">
                                                <div class="col-sm-6 form-group">
                                                    <label class="col-sm-4"><%= MyBase.GetResourceString("C_CorporateStatus")%></label>
                                                    <div class="col-sm-8">
                                                        <div class="row">
                                                            <div class="col-xs-8 col-sm-8 pl-0">
                                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboCorporateStatusFilter", "Exec usp_Sel_tbl_IB_Issue_corporate ",,, "class='form-control'",) %>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>                                            
                                                <div class="col-sm-6 form-group">
                                                    <label class="col-sm-4"><%= MyBase.GetResourceString("C_Priority")%></label>
                                                    <div class="col-sm-8">
                                                        <div class="row">
                                                            <div class="col-xs-8 col-sm-8 pl-0">
                                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPriorityFilter", "Exec usp_Whizible2_Sel_Priority",,, "class='form-control'",) %>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6 form-group">
                                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_Severity")%></label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboSeverityFilter", "Exec usp_Whizible2_Sel_Severity",,, "class='form-control'",) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!--end filter panel-->

    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" style="display:block">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SaveFilterAs")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="Issuesavrefilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-right"><%= MyBase.GetResourceString("C_FilterName")%><span style="color: red">*</span></label>
                                            <div class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",,,,,, ,,,, "PlaceHolder = 'Enter Filter Name (Maxlength 100 Char)' autocomplete='Off' maxlength='100' ",,, True,,,,) %>
                                                <br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow pull-left" onclick="SaveFilterValidation()"><%= MyBase.GetResourceString("Btn_Save")%></button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right"><%= MyBase.GetResourceString("Btn_Cancel")%></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!-- Save filter Modal End here-->

        <div class="content pt-0">
            <!--<div class="pt-1 pb-1 text-right" style="cursor: auto;">
            <button class="btn borderbtn mr-5 addbtn" id="" onclick="addCRdetail()"><i class="fa fa-plus" aria-hidden="true"></i> Add</button>
            <a href="javascript:;" class="btn borderbtn mr-5 disablebtn" id="" data-bs-toggle="modal" data-bs-target="#exceluploadsteps">Excel Upload</a>
            <a href="javascript:;" class="btn borderbtn mr-5 disablebtn" id="">Delete</a>
        </div>-->
            <br />
            <div class="notebox graybg">
                <strong>Note :</strong><%= MyBase.GetResourceString("C_Note")%> <strong> [ <span id="IssueAgeDays"></span> ]</strong> Days
            </div>
            <table id="IssueAgingTbl" class="table table-bordered" style="width:100%;">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("T_Module")%></th> 
                        <th><%= MyBase.GetResourceString("T_ProjectName")%></th> 
                        <th><%= MyBase.GetResourceString("T_IssueID")%></th>
                        <th><%= MyBase.GetResourceString("T_IssueDescription")%></th>
                        <th><%= MyBase.GetResourceString("T_ResponsiblePerson")%></th>
                        <th><%= MyBase.GetResourceString("T_Aging(Days)")%></th>
                        <% If SLAEnabled = "True" Then %>
                        <th><%= MyBase.GetResourceString("T_SLA")%></th>
                        <% End If %>  
                        <th><%= MyBase.GetResourceString("T_Customer")%></th>
                        <th><%= MyBase.GetResourceString("T_Type")%></th>
                        <th><%= MyBase.GetResourceString("T_ReportedDate")%></th>
                        <th><%= MyBase.GetResourceString("T_Status")%></th>
                        <th><%= MyBase.GetResourceString("T_SystemStatus")%></th>
                        <th><%= MyBase.GetResourceString("T_StatusChangeDate-Time")%></th>
                    </tr>
                </thead>
                <tbody id="tbodyIssueAgingTbl"></tbody>
            </table>
        </div>

        <div class="Resourcedetailpanel">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li class="active"><a href="#IRaprvldetailinfoTab" data-bs-toggle="tab" id="">Details</a><div></div></li>
                    <!--<li class=""><a href="#IRInvoiceItemTab" data-bs-toggle="tab" id="">Invoice Items</a><div></div></li>-->
                </ul>
                <div class="tab-content">
                    <div id="IRaprvldetailinfoTab" class="tab-pane active">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-inline">
                                    <label>IR ID : </label> <select id="IRid" class="form-control ml-1" style="width:200px;">
                                        <option>Select ID</option>
                                        <option>22</option>
                                        <option>44</option>
                                        <option>20</option>
                                    </select>
                                    <a href="javascript:;" class="btn borderbtn ml-1">Previous</a>
                                    <a href="javascript:;" class="btn borderbtn">Next</a>
                                </div>
                            </div>
                            <div class="col-sm-6 text-right">
                                <div class="detailsubtabsbtn text-right">
                                    <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#IGstatusmodal">Change Status</a>
                                    <a href="javascript:;" class="btn borderbtn genrtInvslink">Generate Invoice</a>
                                    <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#viewchklistmodal">View Checklist</a>
                                    <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#IGaprvlshowhistorymodal">Show History</a>
                                    <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()">Cancel</button>
                                    <!--<a href="javascript:;" class="btn borderbtn">Help</a>-->
                                </div>
                            </div>
                        </div>

                        <div class="PIRinfo">
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <div class="row">
                                        <label class="col-sm-4">&nbsp;</label>
                                        <div class="col-sm-8">
                                            <div class="custom_radio d-inline-block">
                                                <input id="IGinvcreqst" name="IRAgroup1" value="srchbyemployeetblOuter" type="radio" checked="checked">
                                                <label for="IGinvcreqst"><span></span> IR (Invoice Request)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Type :</label>
                                        <div class="col-sm-8">New</div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Customer :</label>
                                        <div class="col-sm-8">Branch Coordination <a href="javascript:;" class="adreslink" data-bs-toggle="modal" data-bs-target="#custAddressmodal">Address</a></div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Contact Person :</label>
                                        <div class="col-sm-8">John C</div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Email confirm :</label>
                                        <div class="col-sm-8">test@test.com</div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Contact :</label>
                                        <div class="col-sm-8">Ok <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#contrctinfomodal">Show Details</a></div>
                                    </div>

                                </div>
                                <div class="col-sm-6 form-group">
                                    <div class="row">
                                        <label class="col-sm-4">&nbsp;</label>
                                        <div class="col-sm-8">
                                            <div class="custom_radio d-inline-block">
                                                <input id="PIRproformareqstchk" name="IRAgroup1" value="srchbyemployeetblOuter" type="radio">
                                                <label for="PIRproformareqstchk"><span></span> PIR (Proforma Invoice Request)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Credit days :</label>
                                        <div class="col-sm-8">30</div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Currency :</label>
                                        <div class="col-sm-8">INR</div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Sales Period :</label>
                                        <div class="col-sm-8">2022/008</div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">Sales Person :</label>
                                        <div class="col-sm-8">&nbsp;</div>
                                    </div>
                                    <div class="row">
                                        <label class="col-sm-4">IR Items Header :</label>
                                        <div class="col-sm-8">&nbsp;</div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>

         <!-- SLA Detail-->
        <div class="modal custmodal IssueSLAsave_filter fade" id="IssueSLA" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SLADetails")%></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="IssueSLAbox" class="box-panel">
                            <table id="IssueAgingSLATbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("T_SLA")%></th>
                                        <th><%= MyBase.GetResourceString("T_Norm")%></th>
                                        <th><%= MyBase.GetResourceString("T_Actual")%></th>
                                        <th><%= MyBase.GetResourceString("T_Met/NotMet")%></th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyIssueAgingSLATbl"></tbody>
                            </table>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
    

        <!--IR-PIR Status History Modal start here-->
        <!--<div class="modal custmodal fade" id="IRPIRhistorymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">IR-PIR Status History</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <table id="PIRstatushistoryTbl" class="table table-stripped table-bordered modalDTtabl">
                        <thead>
                            <tr>
                                <th>Change to Status</th>
                                <th>Changed By</th>
                                <th>Changed On</th>
                                <th>Comments</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Draft</td>
                                <td>User 1</td>
                                <td>02 Aug 2022</td>
                                <td>Lorem Ipsum content</td>
                            </tr>
                            <tr>
                                <td>Draft</td>
                                <td>User 2</td>
                                <td>02 Aug 2022</td>
                                <td>Lorem Ipsum content</td>
                            </tr>
                            <tr>
                                <td>Submitted</td>
                                <td>User 3</td>
                                <td>02 Aug 2022</td>
                                <td>Lorem Ipsum content</td>
                            </tr>
                            <tr>
                                <td>Draft</td>
                                <td>User 4</td>
                                <td>02 Aug 2022</td>
                                <td>Lorem Ipsum content</td>
                            </tr>
                            <tr>
                                <td>Submitted</td>
                                <td>User 5</td>
                                <td>02 Aug 2022</td>
                                <td>Lorem Ipsum content</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="clearfix"></div>
                    <hr />

                    <div class="btnrow text-center">-->
        <!--<button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>-->
        <!--<button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>-->
        <!-- IR-PIR Status History Modal End here-->


        <div class="clearfix"></div>
<% Else %>
    <div id="NotAuthorized">
        <div style="text-align: center; overflow: auto; width: 100%; background-color: white; margin-top: 3%;">
            <b style="margin-top: 6%; text-align: center;"><%= MyBase.GetResourceString("C_NotAuth")%></b>
        </div>
    </div>
<% End If %>

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery -->
  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- alertify -->
   <%-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now%>"></script>--%>
    
    <!-- Loader -->
    <%--<script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>--%>
    <!-- Loader -->

    <script> 
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>';
        alertify.set('notifier', 'position', 'top-right');
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginID = '<%= Session("intUserID") %>';
        var SessionProjectID = '<%= Session("intProjectID") %>';
        var ajaxResult;
        var VersionIDs = "";
        var GlobalApplyID = "";
        var GlobalQueryText = "";
        var savedFilterName = "";
        var GlobalFilterID = "0";
        var GlobalFilterName = "";
        var FilterID = "";
        var Flag = "";
        var GlobalFilterFlag = "0";
        var IssueAgeDays = "";
        //var AllFields = ["ProjectID", "ProjectStatus", "CustomerID", "ProductVersionID", "Type", "SubType", "ModuleName", "ComponentID", "AssignTo", "IterationID", "UserStoryID",  "CorporateStatus", "Priority", "Severity"];
        var AllFields = ["ProjectID", "ProjectStatus", "ModuleName", "TypeName", "SubType", "IterationID", "UserStoryID", "AssignTo", "CorporateStatus", "Priority", "Severity"];

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
        $('#Commencementdatefield, #contrctsigningdatefield, #Contrctexpirydatefield').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            //$(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            //$(".clearalllink").hide();
        });

        function InvGenrationdetails() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 60
            }, 'slow');
            //used for disable grid
            $("#IssueAgingTbl_wrapper .dataTables_scrollBody, .disablebtn, .backbtn, #RJPMtbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
        }

        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });

        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#IssueAgingTbl_wrapper .dataTables_scrollBody, .disablebtn, .backbtn, #RJPMtbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();

        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
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
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }

        });
        
        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });

        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $(".modal").on('show.bs.modal', function (e) {
            $(".table").resize();
        });

        $(".collapse").on('hidden.bs.modal', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('#IssueAgingTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 240, "overflow-y": "auto" });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $(document).ready(function () {
            
            $("#IssueAgingTbl_wrapper .dataTable").resize();
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                //$('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            }); $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                //$('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            
            var selHTML = "";
            selHTML = "<option  value='0' >Select Product</option>";
            $("#cboProductVersionIDFilter").html(selHTML);
            selHTML = "";
            selHTML = "<option  value='0' >Select Component</option>";
            $("#cboComponentIDFilter").html(selHTML);

            $("#cboProjectStatusFilter").html('');
            $("#cboProjectStatusFilter").prepend(new Option("Select Issue Status", "0"));
            $("#cboProjectStatusFilter").val(0);

            //$("#cboSubTypeFilter").html('');
            $("#cboSubTypeFilter").prepend(new Option("Select Sub Type", "0"));
            $("#cboSubTypeFilter").val(0);

            $("#cboTypeNameFilter").prepend(new Option("Select Type", "0"));
            $("#cboTypeNameFilter").val(0);            

            $("#cboModuleNameFilter").html('');
            $("#cboModuleNameFilter").prepend(new Option("Select Module", "0"));
            $("#cboModuleNameFilter").val(0);

            StartLoader("#bodyIssueAging");
            AllMyFilters();
            AccessableProject();
            StopAjaxLoader("#bodyIssueAging");
        });

        function IssueAgingDay()
        {
            var Parameter = {                
                // ProjectID: SessionProjectID,
                ProjectID: $("#cboProjectIDFilter").val(),
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/IssueAging/IssueAgingDay", param, false);
            for (var i = 0; i < Result.length; i++) {
                IssueAgeDays = Result[i]["IssueAgingDuration"];
            }
            if (IssueAgeDays == null || IssueAgeDays == "") {
                $("#IssueAgeDays").text('');
            }
            else {
                $("#IssueAgeDays").text(IssueAgeDays);
            }
            //GetDefaultFilter();
        }


        //active collapse panel
        $('.contrctinfomodal .panel-heading a').click(function () {
            $('.resourcereleasemodal .panel-heading').removeClass('active');

            //If the panel was open and would be closed by this click, do not active it
            if (!$(this).closest('.contrctinfomodal .panel').find('.resourcereleasemodal .panel-collapse').hasClass('in'))
                $(this).parents('.contrctinfomodal .panel-heading').addClass('active');
        });

        $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open', function (e) {
            e.stopPropagation();
        });

        //Get the default filter
        function GetDefaultFilter()
        {
            var Parameter = {
                TagID: 36010,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
            }
            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetDefaultFilter", param, false);
            if (strResult.Error != "Error") {
               
                FilterID = strResult.FilterID;
                var QueryText = strResult.QueryText;
                if (QueryText != null) {
                    GlobalApplyID = "Apply" + FilterID;
                    QueryText = QueryText.toString().replace(/'/g, "''");
                    GlobalQueryText = QueryText;
                    $(".filterpanel").removeClass('in');
                    $(".filter").css("color", "transperent");
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter .fa-filter").css("color", "#1359a6");
                    //$(".filter button").css("background", "#1359a6");
                    $(".fa-filter").css("color", "#FFFFFF");
                    $(".filter button").addClass("activfltr");
                }
                else {
                    $(".clearalllink").css({ "display": "none" });
                    $(".filter").css("color", "transperent");
                    $(".filter .fa-filter").css("color", "#464a4c");
                    $(".filter button").css("background", "none");
                }
                BindIssueAgingList(QueryText);
            }
            else {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
            }
        }

        var SLACheck = [];
        function BindIssueAgingList(QueryText)
        {
            IssueAgingDay();

            var Parameter = "";
            if (QueryText == undefined || QueryText == '' || QueryText == null) {
                QueryText = "";
                $("#ClearAllFilter").hide();
                $(".filterpanel").removeClass('in');
                //ClearBasicFilter("Version");
                GlobalApplyID = ''
                Parameter = {
                    ProjectID: $("#cboProjectIDFilter").val(),
                    Status: $("#cboProjectStatusFilter").val(),
                    CustomerID: $("#cboCustomerIDFilter").val(),
                    ProductVersionID: $("#cboProductVersionIDFilter").val(),
                    ComponentID: $("#cboComponentIDFilter").val(),
                    //ModuleName: $("#cboModuleNameFilter").val().trim(),
                    ModuleName: $("#cboModuleNameFilter").val(),
                    SubType: $("#cboSubTypeFilter").val(),
                    Assign: $("#cboAssignToFilter").val(),
                    IterationID: $("#cboIterationIDFilter").val(),
                    UserStoryID: $("#cboUserStoryIDFilter").val(),
                    TypeName: $("#cboTypeNameFilter").val(),
                    CorporateStatus: $("#cboCorporateStatusFilter").val(),
                    Priority: $("#cboPriorityFilter").val(),
                    Severity: $("#cboSeverityFilter").val(),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameter);
            }
            else {
                Parameter = QueryText.replace(new RegExp(/\"?\s*\+\s*form\s*\"?\s*\"?/g), '');
                var param = Parameter;
            }
            //debugger;
            $(".table").resize();
            var strHTML = "";
            SLACheck = [];
            $("#tbodyIssueAgingTbl").html('');
            $('#IssueAgingTbl').dataTable().fnDestroy();
        
            var Result = AJAXCallWithResult("/api/IssueAging/GetVersionList", param, false);
            if (Result != "AuthenticationError")
            {
                for (var i = 0; i < Result.length; i++)
                {
                    var ModuleName = Result[i]["ModuleName"];
                    var ProjectName = Result[i]["ProjectName"];
                    ProjectName = ProjectName.split(" ");
                    var IssueID = Result[i]["IssueID"];
                    var IssueDescription = Result[i]["IssueDescription"];
                    IssueDescription = IssueDescription.split(" ");
                    var Customer = Result[i]["Customer"];
                    var Type = Result[i]["Type"];
                    var ReportedDate = Result[i]["ReportedDate"];
                    var Status = Result[i]["Status"];
                    var StatusChange = Result[i]["StatusChange"];
                    var Aging = Result[i]["Aging"];
                    var ResponsiblePerson = Result[i]["ResponsiblePerson"];
                    var SLA = Result[i]["SLA"];
                    var StatusOfStatus = Result[i]["StatusOfStatus"];

                        if (Customer == null) {
                            Customer = "";
                        }

                        SLACheck.push(IssueID);
                    
                        strHTML += '<tr>'
                        strHTML += '<td>' + ModuleName + '</td>' 
                        //strHTML += '<td>' + ProjectName + '</td>' 
                        strHTML += '<td><a data-bs-toggle="tooltip" data-container="body" data-placement="top" title="' + Result[i]["ProjectName"] + '">' + Result[i]["ProjectName"] + '</a></td>'
                        strHTML += '<td>' + IssueID + '</td>'
                        //strHTML += '<td>' + IssueDescription + '</td>'
                        strHTML += '<td><a data-bs-toggle="tooltip" data-container="body" data-placement="top" title="' + Result[i]["IssueDescription"] + '">' + IssueDescription[0] + '</a></td>'
                        strHTML += '<td>' + ResponsiblePerson + '</td>'
                    
                        if (Aging == $("#IssueAgeDays").text())
                        {
                            strHTML += '<td><span class="">' + Aging + '</span></td>'
                        }
                        else {
                            strHTML += '<td><span class="notmet">' + Aging + '</span></td>'
                        }

                        //strHTML += '<td><a href="javascript:;" onclick="SLADetail(' + IssueID + ')">SLA Detail</a></td>'

                        <% If SLAEnabled = "True" Then %>
                            strHTML += '<td> <span class="met" id="Issue_' + IssueID + '"></span></td>'
                        <% End If %>                     
                        strHTML += '<td>' + Customer + '</td>'
                        strHTML += '<td>' + Type + '</td>'
                        strHTML += '<td>' + ReportedDate + '</td>'

                        if (Status == "Reviewed") {
                            strHTML += '<td><label class="stastusbtn btn btn-info">' + Status + '</label></td>'
                        }
                        else if (Status == "To Do") {
                            strHTML += '<td><label class="stastusbtn btn btn-secondary">' + Status + '</label></td>'
                        }
                        else if (Status == "On Hold") {
                            strHTML += '<td><label class="stastusbtn btn btn-warning">' + Status + '</label></td>'
                        }
                        else if (Status == "Sent For Review") {
                            strHTML += '<td><label class="stastusbtn btn btn-info">' + Status + '</label></td>'
                        }
                        else if (Status == "Open") {
                            strHTML += '<td><label class="stastusbtn btn btn-danger">' + Status + '</label></td>'
                        }
                        else if (Status == "Submitted") {
                            strHTML += '<td><label class="stastusbtn btn btn-success">' + Status + '</label></td>'
                        }
                        else if (Status == "Resolved") {
                            strHTML += '<td><label class="stastusbtn btn btn-success">' + Status + '</label></td>'
                        }
                        else {
                            strHTML += '<td>' + Status + '</td>'
                        }

                        if (StatusOfStatus == "Acknowledgement") {
                            strHTML += '<td><label class="stastusbtn btn btn-info">' + StatusOfStatus + '</label></td>'
                        }
                        else if (StatusOfStatus == "Close") {
                            strHTML += '<td><label class="stastusbtn btn btn-secondary">' + StatusOfStatus + '</label></td>'
                        }
                        else if (StatusOfStatus == "On Hold") {
                            strHTML += '<td><label class="stastusbtn btn btn-warning">' + StatusOfStatus + '</label></td>'
                        }
                        else if (StatusOfStatus == "Open") {
                            strHTML += '<td><label class="stastusbtn btn btn-danger">' + StatusOfStatus + '</label></td>'
                        }
                        else if (StatusOfStatus == "Resolved") {
                            strHTML += '<td><label class="stastusbtn btn btn-success">' + StatusOfStatus + '</label></td>'
                        }
                        else if (StatusOfStatus == "Response") {
                            strHTML += '<td><label class="stastusbtn btn btn-danger">' + StatusOfStatus + '</label></td>'
                        }
                        else {
                            strHTML += '<td>' + StatusOfStatus + '</td>'
                        }

                        //strHTML += '<td>' + StatusOfStatus + '</td>'
                        strHTML += '<td>' + StatusChange + '</td>'
                        strHTML += '</tr>' 
               }
               $("#tbodyIssueAgingTbl").html(strHTML);                
               //$("#IssueAgingTbl").dataTable({
               //     sScrollY: "200", 
               //    scrollX: true,
               //    paging: true,
               //    pageLength: 10, 
               //    bLengthChange: false,
               //    bFilter: false,
               //    ordering: false,
               //    responsive: true,
               //    destroy: false,
               //    retrieve: true,
               //    bFilter: false,
               //    ordering: false,
               //    info: true,
               //});
               // $(".table").resize();

                <% If SLAEnabled = "True" Then %>
                //    setTimeout(function ()
                //{
                    StartLoader("#bodyIssueAging");
                    for (k = 0; k < SLACheck.length; k++)
                    {
                        var Parameter =
                        {
                            IssueID: SLACheck[k]
                        }
                        var param = JSON.stringify(Parameter);
                        var Result = AJAXCallWithResult("/api/IssueAging/GetSLADetail", param, false);
                        if (Result.length > 0)
                        {
                            for (var l = 0; l < Result.length; l++) {
                                var METNOTMET = Result[l]["MET/NOTMET"];
                                if (METNOTMET == "NOT MET") {
                                    $("#Issue_" + Result[l]["IssueID"]).text("NOT MET"); 
                                }
                                else {
                                    $("#Issue_" + Result[l]["IssueID"]).text("MET");
                                }
                            }
                        }
                        else {                           
                            $("#Issue_" + SLACheck[k]).text("NOTMET");
                        }                        
                    }                    
                    $("#IssueAgingTbl").dataTable({
                        sScrollY: "200",
                        scrollX: true,
                        paging: true,
                        pageLength: 10,
                        bLengthChange: false,
                        bFilter: false,
                        ordering: false,
                        responsive: true,
                        destroy: true,
                        retrieve: true,
                        bFilter: false,
                        ordering: false,
                        info: true,
                    });
                    $(".table").resize();
                    StopAjaxLoader("#bodyIssueAging");
                //}, 2000);
                <% else%> 
                $("#IssueAgingTbl").dataTable({
                    sScrollY: "200",                   
                    scrollX: true,
                    paging: true,
                    pageLength: 10,
                    bLengthChange: false,
                    bFilter: false,
                    ordering: false,
                    responsive: true,
                    destroy: false,
                    retrieve: true,
                    bFilter: false,
                    ordering: false,
                    info: true,
                });
                $(".table").resize();
                <% End If %>  
            }
            else {
               window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
           }
       }

        //Only Apply Filter
        function ApplyFilter() { 
            if ($('#cboProjectIDFilter').val() == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SelectProject")%>", 'error');
                $('#cboProjectIDFilter').focus();
                return;
            }
            else
            {
            
                StartLoader("#bodyIssueAging"); 
                //BindIssueAgingList(QueryText);
                BindIssueAgingList('');
                 

                $("#filterpanel").removeClass("show");
                $("#AdvanceFilterIcon").addClass("activefilter");
                $(".clearalllink").css("display", "inline-block");
                $(".filter .fa-filter").css("color", "#1359a6");
                $(".filter button").css("background", "#1359a6");
                $(".fa-filter").css("color", "#FFFFFF");
                
                StopAjaxLoader("#bodyIssueAging");
                alertify.success("<%= MyBase.GetResourceString("A_Filterappliedsuccessfully")%>");
           }
        }


        $("#AdvanceFilterIcon").click(function () {
            
            $(".tooltip").removeClass('show');
            //if ($("#PMProjectReviewClearAllFilter").css("display") == "inline-block") {
            //    $(".filter .fa-filter").css("color", "white");
            //    $("#AdvanceFilterIcon").css("background", "#4263c1!important");
            //} else {
            //    $(".filter .fa-filter").css("color", "rgb(70, 74, 76)");
            //    $(".filter button[aria-expanded='true'] .fa-filter").css("background", "none!important");
            //}
        });

        $("#CatBasicFilter").click(function () {
          
            $(".tooltip").removeClass('show');
           
        });
        

        // Create Filter Query
        function GenerateBasicFilterQuery(module, AllFields) {
            var strqtext = "";
            for (var i = 0; i < AllFields.length; i++)
            {
                var strvalue = '';
                //var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();
                var strOp = "Exact Word";
                if ($("#cbo" + AllFields[i] + module).val() != null) {
                    strvalue = $("#cbo" + AllFields[i] + module).val().trim();
                }

                if (strvalue != "0" && strvalue != "" && strvalue != null && strvalue != "null") {
                    if (strqtext != "") strqtext += " AND ";
                    if (strOp == "Contains") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '%"';
                    }
                    else if (strOp == "Ends With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '"';
                    }
                    else if (strOp == "Exact Word") {
                        strqtext += 'tbl_ib_issue.'+ AllFields[i] + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    else if (strOp == "Not Contains") {
                        strqtext += AllFields[i] + " ";
                        strqtext += ' NOT LIKE "%' + strvalue + '%"';
                    }
                    else if (strOp == "Starts With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "' + strvalue + '%"';
                    }
                    else {
                        strqtext += AllFields[i] + " ";
                        strqtext += strOp + ' "' + strvalue + '"';
                    }
                }

                if (strOp == "=" && strCHK == true) {
                    if (strqtext != "" && strqtext != '' && strqtext != null && strqtext != undefined) {
                        strqtext += ' AND '
                    }
                    if (strvalue == "" || strvalue == undefined) {
                        strqtext += AllFields[i] + " = " + '"' + strCHK + '"';
                    }
                    else {
                        strqtext += AllFields[i] + "=" + '"' + strCHK + '"';
                    }
                }
                if (strOp == "<>" && strCHK == true) {
                    if (strqtext != "" && strqtext != '' && strqtext != null && strqtext != undefined) {
                        strqtext += ' AND '
                    }
                    if (strvalue == "" || strvalue == undefined) {
                        strqtext += AllFields[i] + " <> " + '"' + strCHK + '"';
                    }
                    else {
                        strqtext += AllFields[i] + "<>" + '"' + strCHK + '"';
                    }
                }
            }
            strqtext = strqtext.replace('Over', '[Over]');
            strqtext = strqtext.replace(/'/g, "''");
            strqtext = strqtext.replace(/tbl_ib_issue.ProjectStatus/g, "tbl_PM_project.ProjectStatus");
            return strqtext;
        }

        //Clear Applied Filter
        function ClearBasicFilter(IdCaption) {
            for (var i = 1; i < AllFields.length; i++)
            {
                document.getElementById('cbo' + AllFields[i] + 'Filter').selectedIndex = 0;
            }
        }

        function ClearAll() 
        { 
            StartLoader("#bodyIssueAging");
            $("#txtFilterName").val('');
            ClearBasicFilter('')
            //BindIssueAgingList(null);
            GlobalApplyID = "";
            GlobalQueryText = "";
            savedFilterName = "";
            GlobalFilterID = "0";
            GlobalFilterName = "";
            FilterID = "";
            $(".filterpanel").removeClass('in');
            $(".clearalllink").css({ "display": "none" });
            $(".filter").css("color", "transperent");
            $(".filter .fa-filter").css("color", "#464a4c");
            $(".filter button").css("background", "none");
             
            if (SessionProjectID != "" && TempProjectID !=0) {
                $("#cboProjectIDFilter").val(SessionProjectID).change();
                $("#tbodyIssueAgingTbl").html(''); 
                BindIssueAgingList('');
                AllMyFilters();
            }
            else {
                $("#cboProjectIDFilter").val(0);
                $("#tbodyIssueAgingTbl").html('');
                $("#IssueAgeDays").text(0);
            }
            StopAjaxLoader("#bodyIssueAging");
        }

        function btnSaveAndApplyFilter_Onclick() {
            //var QueryText = "";
            //QueryText = GenerateBasicFilterQuery('Filter', AllFields);
            //if (QueryText == "") {
            //    alertify.error("Please select at least one field to filter record.");
            //}
            if ($('#cboProjectIDFilter').val() == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SelectProject")%>", 'error');
                $('#cboProjectIDFilter').focus();
                return;
            }
            else {
                $("#Issuesavefilter").modal('show');
                $(".canclesaveasbtn").click(function () {
                    $("#txtFilterName").val('');
                });
            }
        }

        //For Duplicated Filter
        function checkDuplicateFilter(Flag, FilterID, filtername, TagID) {           
            var isFilterExists = 0;
            if (FilterID == "" || Flag ==0) {
                FilterID = "0";
                Flag = "0";
            }           
            var Parameters = {
                Flag: encodeURI(Flag),
                FilterID: encodeURI(FilterID),
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                UserID: UserID                
            }
            var param = JSON.stringify(Parameters);
            var data = AJAXCallWithResult("/api/IssueAging/chkFilterExists", param, false);
            if (data != "AuthenticationError") {
                if (data == 0) {
                    isFilterExists = 0;
                }
                else if (data == 1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<%= MyBase.GetResourceString("A_Filternamealreadyexists")%>");
                    $("#txtFilterName").focus();
                    isFilterExists = 1;
                }
            } else {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
            }
            return isFilterExists;
        }

        //Function to save the filter and Apply the filter 
        function SaveFilterValidation() {
            var FilterName = $("#txtFilterName").val().trim();
            FilterID = GlobalFilterID;
            if (FilterName != GlobalFilterName) {
                FilterID = 0;
                FilterId = 0;
            }
            FilterName = FilterName.replace(/'/g, "''");
            if (FilterName != "" && FilterName != null) {
                if (checkSpecialCharacter(FilterName, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("A_SpecialCharacter")%> ' + WebConfigSpecialCharacters + ' characters.');
                    $("#txtFilterName").focus();
                }
                else {
                    var filterExists = 0;
                    if (savedFilterName == "") {
                        filterExists = checkDuplicateFilter(GlobalFilterFlag, GlobalFilterID, FilterName, 36010);
                    }
                    if (filterExists == 0)
                    {
                        StartLoader("#bodyIssueAging");
                        SavedFilters(FilterName);
                         
                        IssueAgingDay(); 
                        AllMyFilters();
                        $("#filterpanel").removeClass("show");
                        $("#AdvanceFilterIcon").addClass("activefilter");
                        $(".clearalllink").css("display", "inline-block");
                        $(".filter .fa-filter").css("color", "#1359a6");
                        $(".filter button").css("background", "#1359a6");
                        $(".fa-filter").css("color", "#FFFFFF");

                        $("#Issuesavefilter").modal('hide');
                        StopAjaxLoader("#bodyIssueAging");
                    }
                }
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_Filtername")%>");
                $("#txtFilterName").focus();
            }
        }

        //SaveAndApply Filter Functionality
        function SavedFilters(FilterName) {
           // debugger;
            if (FilterName != GlobalFilterName && FilterID == "0") {
                Flag = 0;
            }
            else {
                Flag = 1;
            }

            //var QueryText = GenerateBasicFilterQuery('Filter', AllFields);
            var Parameter = {
                ProjectID: $("#cboProjectIDFilter").val(),
                Status: $("#cboProjectStatusFilter").val(),
                CustomerID: $("#cboCustomerIDFilter").val(),
                ProductVersionID: $("#cboProductVersionIDFilter").val(),
                ComponentID: $("#cboComponentIDFilter").val(),
                ModuleName: $("#cboModuleNameFilter").val().trim(),
                SubType: $("#cboSubTypeFilter").val(),
                Assign: $("#cboAssignToFilter").val(),
                IterationID: $("#cboIterationIDFilter").val(),
                UserStoryID: $("#cboUserStoryIDFilter").val(),
                TypeName: $("#cboTypeNameFilter").val(),
                CorporateStatus: $("#cboCorporateStatusFilter").val(),
                Priority: $("#cboPriorityFilter").val(),
                Severity: $("#cboSeverityFilter").val(),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameter);
            var QueryText = param;
            if (QueryText != '') {                 
                Parameter = {
                    TagID: 36010,
                    UserID: encodeURI(UserID),
                    FilterName: encodeURI(FilterName),
                    LoginType: encodeURI(LoginType),
                    QueryText: encodeURI(QueryText),
                    UserName: encodeURI(UserName),
                    Flag: encodeURI(Flag),
                    FilterID: encodeURI(FilterID) 
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/IssueAging/SavedFilters", param, false);
                if (strResult != null || strResult != "AuthenticationError") {
                    GlobalFilterID = strResult;
                    GlobalApplyID = strResult;
                    GlobalApplyID = "Apply" + GlobalApplyID
                    $('.filterpanelModule').removeClass('show');
                    ApplyCheckFilter(GlobalApplyID);
                    alertify.success("<%= MyBase.GetResourceString("A_Filterappliedsuccessfully")%>");
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter .fa-filter").css("color", "#1359a6");
                    $(".filter button").css("background", "#1359a6");
                    $(".fa-filter").css("color", "#FFFFFF");
                    $("#filterpanel").removeClass("show");
                    $("#AdvanceFilterIcon").removeClass("activefilter");
                } else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
        }
         

        // List Of All Module Filters
        function AllMyFilters() {           
            Parameter = {
                TagID: 36010,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/IssueAging/AllMyFilters", param, false);
            if (strResult.Error != "AuthenticationError") {
                MyFiltersList(strResult);
                GlobalFilterID = "";
                GlobalFilterFlag = "";
            }
            else {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
            }
        }

        // Plotting Filter In My Filter DropDown
        function MyFiltersList(result) {
            var strHTML = "";
           // debugger;
            for (var i = 0; i < result.length; i++) {
                var FilterID = result[i]["FilterId"];
                var FilterName = result[i]["FilterName"];
                var QueryText = result[i]["QueryText"];

                strHTML += ' <li>'
                if (result[i].SetDefault == true) {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" checked="checked" onclick="SetDefaultFilter(this.id,&quot;default&quot;)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-placement="right" title="Set Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="Default' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                else {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onclick="SetDefaultFilter(this.id)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-placement="right" title="Set Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply Filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                strHTML += '</div>'
                strHTML += '</li>'
            }
            $("#MyFiltersdropdown").html(strHTML);

            $('[data-bs-toggle="tooltip"]').tooltip();

            if (GlobalApplyID != null && GlobalApplyID != "") {
                ApplyCheckFilter(GlobalApplyID);
            }
            else {
                ClearFilterApplied();
            }

        }

        //To clear the applied filter arrow after click on clear filter button
        function ClearFilterApplied() {
            var sibling = $('label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($("#" + id).parent().find("input").prop("checked") == true) {
                    $("#" + id).parent().find("input").prop("checked", false);
                    $("#" + id).removeAttr("data-bs-original-title", "");
                    $("#" + id).attr("data-bs-original-title", "Apply Filter");
                }
            });
        }

        //Delete Filter 
        function DefaultDeleteFilter(DefaultID) {
            var NewDeleteFilterID = DefaultID.replace("Default", "");
            NewDeleteFilterID = DefaultID.replace("Apply", "");

            if (NewDeleteFilterID == DefaultID) {
                GlobalApplyID = '';
            }
            GlobalQueryText = null;
            if (DefaultID.indexOf("Default") > -1) {
                var FilterID = DefaultID.replace("Default", "");
                DeleteFilter(FilterID);
                if (SessionProjectID != "") {
                    BindIssueAgingList(null);
                }
                
                $('.filterpanelModule').removeClass('in');
            }
            else {
                DeleteFilter(DefaultID);
                if (SessionProjectID != "") {
                    GetDefaultFilter();
                }
            }

            $(".tooltip").removeClass('show');
        }

        function DeleteFilter(FilterID) {
            if (FilterID != undefined) {                
                Parameter = {
                    FilterID: encodeURI(FilterID),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/IssueAging/DeleteFilter", param, false);
                if (strResult != "AuthenticationError") {
                    alertify.success("<%= MyBase.GetResourceString("A_Filterdeleted")%>");
                    ClearAll();
                    AllMyFilters();
                    $("#txtFilterName").val('');

                    $("#filterpanel").removeClass("show");
                    $("#AdvanceFilterIcon").addClass("activefilter");
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter .fa-filter").css("color", "#1359a6");
                    $(".filter button").css("background", "#1359a6");
                    $(".fa-filter").css("color", "#FFFFFF");
                    $(".tooltip").removeClass('show');
                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
                $("button.filter").css("background", "none");
                $(".fa-filter").css("color", "#464a4c");
            }
        }

        //SetDefault Filter 
        var flag = 0;
        function SetDefaultFilter(DefaultFilterID, flag) {
            //debugger;
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var FilterID = DefaultFilterID.replace("Default", "");
            if (FilterID != undefined) {                
                Parameter = {
                    LoginType: encodeURI(LoginType),
                    UserID: encodeURI(UserID),
                    TagID: 36010,
                    FilterID: encodeURI(FilterID),
                    Flag: removeDefault
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/IssueAging/SetDefaultFilter", param, false);
                if (strResult != "AuthenticationError") {
                    if (removeDefault == 0) {
                        //debugger
                        FilterID = "Apply" + FilterID;
                        //$("#AdvanceFilterIcon").css("width", "21px!important");
                        ApplyCheckFilter(FilterID);
                        alertify.success("<%= MyBase.GetResourceString("A_Defaultfilterset")%>");
                        AllMyFilters();
                        $(".clearalllink").css("display", "inline-block");
                        $(".filter button").css("background", "#1359ac");
                        $(".fa-filter").css("color", "#ffffff");
                        $(".tooltip").removeClass('show');
                        
                    } else {
                        FilterID = "Apply" + FilterID;
                        //ApplyCheckFilter(FilterID);
                        GlobalQueryText = null;
                        //ClearBasicFilter('')
                        //AllMyFilters();
                        ////BindIssueAgingList(null);
                        //BindIssueAgingList('');
                        ClearAll();
                        alertify.success("<%= MyBase.GetResourceString("A_Defaultfilterremoved")%>");
                        $(".clearalllink").css({ "display": "none" });
                        $(".filter button").css("background", "none");
                        $(".fa-filter").css("color", "#464a4c");
                        $(".tooltip").removeClass('show');
                        
                    }
                    $('[data-bs-toggle="tooltip"]').tooltip('hide');
                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
        }

        //Edit ModuleFilter 
        function EditFilter(EditID) {
            //debugger;
            Flag = 1;
            FilterID = EditID.replace("Edit", "");
            if (FilterID != "") {
                GlobalFilterID = FilterID;
                GlobalFilterFlag = 1;               
                var Parameter = {
                    FilterID: encodeURI(FilterID),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameter);
                var result = AJAXCallWithResult("/api/IssueAging/EditFilterData", param, false);
                if (result != "AuthenticationError") {
                    for (var i = 0; i < result.length; i++) {
                        var QueryText = result[i].WhereClause;
                        GlobalFilterName = result[i].FilterName;
                    } 
                    //BindBasicFilters(QueryText, "Filter"); 
                    
                    var filterValues = jQuery.parseJSON(QueryText);
                    ProjectDrop_OnChange(filterValues.ProjectID);
                    $("#cboProjectIDFilter").val(filterValues.ProjectID).change();
                   
                    $("#cboCustomerIDFilter").val(filterValues.CustomerID);
                    $("#cboProductVersionIDFilter").val(filterValues.ProductVersionID);
                    $("#cboComponentIDFilter").val(filterValues.ComponentID);
                    $("#cboModuleNameFilter").val(filterValues.ModuleName);
                    
                    $("#cboAssignToFilter").val(filterValues.Assign);
                    $("#cboIterationIDFilter").val(filterValues.IterationID).change();
                    $("#cboUserStoryIDFilter").val(filterValues.UserStoryID);
                    $("#cboTypeNameFilter").val(filterValues.TypeName).change();
                    $("#cboSubTypeFilter").val(filterValues.SubType);
                    $("#cboProjectStatusFilter").val(filterValues.Status);

                    $("#cboCorporateStatusFilter").val(filterValues.CorporateStatus);
                    $("#cboPriorityFilter").val(filterValues.Priority);
                    $("#cboSeverityFilter").val(filterValues.Severity);

                    $("#txtFilterName").val(GlobalFilterName);
                    //Click on Edit SaveAndApply Section Will Be Display
                    $(".filterpanel").addClass("in");
                    $(".filterpanelbody").addClass("active");
                    $('.nav-tabs li:last-child').addClass('active');
                    $('#basicfilters').addClass('active');
                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
        }

        function BindBasicFilters(qtext, module) {
            ClearBasicFilter(module);
            var isAnd = qtext.indexOf(' AND ');
            qtext = qtext.replace(/tbl_ib_issue./g, "");
            qtext = qtext.replace(/tbl_PM_project./g, "");
            if (isAnd > 0)
            {
                var rowsAnd = qtext.split(' AND ');
                for (i = 0; i < rowsAnd.length; i++) {
                    BindBasicFilterValues(rowsAnd[i], module);
                }
            }
            else {
                BindBasicFilterValues(qtext, module);
            }
        }

        function BindBasicFilterValues(qtext, module) {
            var field = qtext.substr(0, qtext.indexOf(' '));
            var op = orgop = "";
            var val = valstr = "";
            var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
            var opchar = opstr.substr(0, 1);
            if (opchar == "N" || opchar == "L") {
                if (opchar == "N") {
                    op = "Not Contains";
                    orgop = "NOT LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                }
                if (opchar == "L") {
                    orgop = "LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    if (valstr.indexOf('%') == 1) {
                        if (valstr.substr(2, valstr.length).indexOf('%') > 0) {
                            op = "Contains";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                        }
                        else {
                            op = "Ends With";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 3);
                        }
                    }
                    else {
                        op = "Starts With";
                        val = valstr.substr(1, valstr.length - 3);
                    }
                }
            }
            else {
                op = opstr.substr(0, opstr.indexOf(' '));
                valstr = opstr.substr(op.length, opstr.length).trim();
                val = valstr.substr(1, valstr.length - 2);
            }
            if (op == '=') {
                var cbo = "cbo" + module + "Filter" + field;
                if ($("#" + cbo + " option[value='" + op + "']").length == 0) {
                    op = "Exact Word"
                }
            }
            $('#cbo' + field + 'Filter').val(val).change();   
        }

        
        //Restrict Special Charaters onkeypress
        function restrictSpecialChars(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
        }

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

        var TempProjectID = 0;
        function AccessableProject()
        { 
            $("#cboProjectIDFilter").html('');
            if (SessionProjectID != "") {
                var issueParameters = {
                    intEmployeeID: UserID,
                    strLoginID: LoginID,
                    ProjectID: SessionProjectID,
                    LoginType: LoginType,
                    SessionProjectID: '<%= Session("IntProjectID") %>',
                }
            }
            else {
                var issueParameters = {
                    intEmployeeID: UserID,
                    strLoginID: LoginID,
                    //ProjectID: SessionProjectID,
                    LoginType: LoginType,
                    //SessionProjectID: '<%= Session("IntProjectID") %>',
                }
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectDropdownValues", param, false);
            if (strResult != undefined) {
                var selHTML = "";
                for (var i = 0; i < strResult.length; i++) 
                {
                    var d = strResult[i];
                    var ProjectID = d.ProjectID;
                    var ProjectName = d.ProjectName;
                    selHTML += "<option  value='" + ProjectID + "' >" + ProjectName + "</option>";
                    if (ProjectID == SessionProjectID) {
                        TempProjectID = 1;
                    } 
                }
                $("#cboProjectIDFilter").html(selHTML); 
                $('[data-bs-toggle="tooltip"]').tooltip();

                if (TempProjectID == 1 && (SessionProjectID != undefined || SessionProjectID != "")) {
                    $("#cboProjectIDFilter").val(SessionProjectID);
                    ProjectDrop_OnChange(SessionProjectID);
                    GetDefaultFilter();
                } 
            }
        }

        function Customer_OnChange(CustomerID) {
            var Parameters = {                 
                ProjectID: SessionProjectID,
                CustomerID: CustomerID
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProductDropdownValues", param, false);
            if (strResult != undefined) {
                var selHTML = "";
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var ProductVersionID = d.ProductVersionID;
                    var ProductVersion = d.ProductVersion;
                    selHTML += "<option  value='" + ProductVersionID + "' >" + ProductVersion + "</option>";
                }
                $("#cboProductVersionIDFilter").html(selHTML);
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }

        function Product_OnChange(ProductID) {
            var Parameters = {
                ProjectID: SessionProjectID,
                CustomerID: $("#cboCustomerIDFilter").val(),
                ProductID: ProductID
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetModuleDropdownValues", param, false);
            if (strResult != undefined) {
                var selHTML = "";
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var ComponentID = d.ComponentID;
                    var Component = d.Component;
                    selHTML += "<option  value='" + ComponentID + "' >" + Component + "</option>";
                }
                $("#cboComponentIDFilter").html(selHTML);
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }

        function SLADetail(IssueID)
        {
            StartLoader("#bodyIssueAging");           
            var strHTML = "";
            $("#tbodyIssueAgingSLATbl").html('');
            $('#IssueAgingSLATbl').dataTable().fnDestroy();
            var Parameter = {
                IssueID: IssueID                
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/IssueAging/GetSLADetail", param, false);
            if (Result != "AuthenticationError")
            {
                for (var i = 0; i < Result.length; i++) {
                    var SLAName = Result[i]["SLAName"];
                    var PlanDuration = Result[i]["PlanDuration"];
                    var ActualDuration = Result[i]["ActualDuration"];
                    var METNOTMET = Result[i]["MET/NOTMET"];
                    strHTML += '<tr>'
                    strHTML += '<td>' + SLAName + '</td>'
                    strHTML += '<td>' + PlanDuration + '</td>'
                    strHTML += '<td>' + ActualDuration + '</td>'

                    if (METNOTMET == "MET") {
                        strHTML += '<td> <span class="met">' + METNOTMET + '</span></td>'
                    }
                    else if (METNOTMET == "Not MET") {
                        strHTML += '<td> <span class="notmet">' + METNOTMET + '</span></td>'
                    }
                    else {
                        strHTML += '<td>' + METNOTMET + '</td>'
                    }
                    //strHTML += '<td>' + METNOTMET + '</td>'
                    strHTML += '</tr>'
                }
            }
            $("#tbodyIssueAgingSLATbl").html(strHTML);
            $("#IssueAgingSLATbl").dataTable({
                scrollY: true,
                scrollX: true,
                paging: true,
                pageLength: 10,
                bLengthChange: false,
                bFilter: false,
                ordering: false,
                responsive: true,
                destroy: false,
                retrieve: true,
                bFilter: false,
                ordering: false,
                info: true,
            });
            if (strHTML == "") {
                $("#IssueAgingSLATbl tbody tr td").prop("colspan", 4);
            }
            $(".table").resize();
            $("#IssueSLA").modal('show');
            StopAjaxLoader("#bodyIssueAging");
        }

        function Type_OnChange(Type) {
            var ProjectId = $("#cboProjectIDFilter").val();
            $("#cboSubTypeFilter").html('');
            if (Type == 0) {
                var issueParameters = {

                    ProjectID: ProjectId,
                    TypeName: ""
                }
                var param = JSON.stringify(issueParameters);
                var strResult = AJAXCallWithResult("/api/IssueAging/GetSubTypeDropdownValues", param, false);
                if (strResult != undefined) {
                    for (var i = 0; i < strResult.length; i++) {
                        var d = strResult[i];
                        var FieldID = d.FieldID;
                        var FieldName = d.FieldName;
                        selHTML += "<option  value='" + FieldID + "' >" + FieldName + "</option>";
                    }
                    $("#cboSubTypeFilter").html(selHTML);

                    //$("#cboSubTypeFilter").html('');
                    $("#cboSubTypeFilter").prepend(new Option("Select Sub Type", "0"));
                    $("#cboSubTypeFilter").val(0);
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }
            }
            else {
                var selHTML = "";
                var issueParameters =
                {

                    ProjectID: $("#cboProjectIDFilter").val(),
                    TypeName: Type,
                }
                var param = JSON.stringify(issueParameters);
                var strResult = AJAXCallWithResult("/api/IssueAging/GetSubTypeDropdownValues", param, false);
                if (strResult != undefined) {
                    for (var i = 0; i < strResult.length; i++) {
                        var d = strResult[i];
                        var FieldID = d.FieldID;
                        var FieldName = d.FieldName;
                        selHTML += "<option  value='" + FieldID + "' >" + FieldName + "</option>";
                    }
                    $("#cboSubTypeFilter").html(selHTML);
                    $("#cboSubTypeFilter").prepend(new Option("Select Sub Type", "0"));
                    $("#cboSubTypeFilter").val(0);
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }



                //ProjectStatus
                selHTML = "";
                var Param = {
                    ProjectID: $("#cboProjectIDFilter").val(),
                    FromWhich: "ProjectStatus",
                    TypeName: Type,
                }
                var param = JSON.stringify(Param);
                var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectOnchange", param, false);
                if (strResult != undefined && $("#cboProjectIDFilter").val() != 0) {

                    for (var i = 0; i < strResult.length; i++) {
                        var d = strResult[i];
                        var FieldID = d.FieldID;
                        var FieldName = d.FieldName;
                        selHTML += "<option  value='" + FieldID + "' >" + FieldName + "</option>";
                    }
                    $("#cboProjectStatusFilter").html(selHTML);
                    $("#cboProjectStatusFilter").prepend(new Option("Select Issue Status", "0"));
                    $("#cboProjectStatusFilter").val(0);
                }
                else {
                    $("#cboProjectStatusFilter").html('');
                    $("#cboProjectStatusFilter").prepend(new Option("Select Issue Status", "0"));
                    $("#cboProjectStatusFilter").val(0);
                }
            }
            
        }

        function ProjectDrop_OnChange(ProjectID) {
            var selHTML = "";
            StartLoader("#bodyIssueAging");
  
            $("#cboProjectStatusFilter").html('');
            $("#cboModuleNameFilter").html('');
            $("#cboTypeNameFilter").html('');
            $("#cboIterationIDFilter").html('');
            $("#cboUserStoryIDFilter").html('');
            $("#cboAssignToFilter").html('');

            //ProjectStatus
            var Param = {
                ProjectID: ProjectID,
                FromWhich: "ProjectStatus",
            }
            var param = JSON.stringify(Param);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectOnchange", param, false);
            if (strResult != undefined && ProjectID !=0) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var FieldID = d.FieldID;
                    var FieldName = d.FieldName;
                    selHTML += "<option  value='" + FieldID + "' >" + FieldName + "</option>";
                }
                $("#cboProjectStatusFilter").html(selHTML);
                $("#cboProjectStatusFilter").prepend(new Option("Select Issue Status", "0"));
                $("#cboProjectStatusFilter").val(0);
            }
            else {
                $("#cboProjectStatusFilter").html('');
                $("#cboProjectStatusFilter").prepend(new Option("Select Issue Status", "0"));
                $("#cboProjectStatusFilter").val(0);
            }

            selHTML = "";
            //Module
            var Param = {
                ProjectID: ProjectID,
                FromWhich: "Module",
            }
            var param = JSON.stringify(Param);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectOnchange", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var Module = d.Module.trim();
                    var ModuleName = d.ModuleName.trim();
                    selHTML += "<option  value='" + Module + "' >" + ModuleName + "</option>";
                }
                $("#cboModuleNameFilter").html(selHTML);
            }

            selHTML = "";
            //Module
            var Param = {
                ProjectID: ProjectID,
                FromWhich: "Type",
            }
            var param = JSON.stringify(Param);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectOnchange", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var FieldID = d.FieldID;
                    var FieldName = d.FieldName;
                    selHTML += "<option  value='" + FieldID + "' >" + FieldName + "</option>";
                }
                $("#cboTypeNameFilter").html(selHTML);
                $("#cboTypeNameFilter").prepend(new Option("Select Type", "0"));
                $("#cboTypeNameFilter").val(0);

                //$("#cboSubTypeFilter").html('');
                //$("#cboSubTypeFilter").prepend(new Option("Select Sub Type", "0"));
                //$("#cboSubTypeFilter").val(0);
                //$('[data-bs-toggle="tooltip"]').tooltip();
            }

            selHTML = "";
            //Iteration
            var Param = {
                ProjectID: ProjectID,
                FromWhich: "Iteration",
            }
            var param = JSON.stringify(Param);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectOnchange", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var IterationID = d.IterationID;
                    var IterationName = d.IterationName;
                    selHTML += "<option  value='" + IterationID + "' >" + IterationName + "</option>";
                }
                $("#cboIterationIDFilter").html(selHTML);
            }

            selHTML = "";
            //UserstoryID
            var Param = {
                ProjectID: ProjectID,
                FromWhich: "UserstoryID",
            }
            var param = JSON.stringify(Param);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectOnchange", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var UserStoryID = d.UserStoryID;
                    var UserStoryName = d.UserStoryName;
                    selHTML += "<option  value='" + UserStoryID + "' >" + UserStoryName + "</option>";
                }
                $("#cboUserStoryIDFilter").html(selHTML);               
            }

            $("#cboAssignToFilter").html('');
            selHTML = "";
            //ResponsiblePerson
            var Param = {
                ProjectID: ProjectID,
                FromWhich: "ResponsiblePerson",
            }
            var param = JSON.stringify(Param);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetProjectOnchange", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var EmployeeID = d.EmployeeID;
                    var UserName = d.UserName; 
                    selHTML += "<option  value='" + EmployeeID + "' >" + UserName + "</option>";
                }
                $("#cboAssignToFilter").html(selHTML);
               // $("#cboAssignToFilter").prepend(new Option("Select Employee Name", "0"));
                $("#cboAssignToFilter").val(0);
            }

            $("#cboSubTypeFilter").html('');
            selHTML = "";
            var issueParameters = {

                ProjectID: $("#cboProjectIDFilter").val(),
                TypeName: '',
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetSubTypeDropdownValues", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var d = strResult[i];
                var FieldID = d.FieldID;
                var FieldName = d.FieldName;
                selHTML += "<option  value='" + FieldID + "' >" + FieldName + "</option>";
            }
            $("#cboSubTypeFilter").html(selHTML);
            $("#cboSubTypeFilter").prepend(new Option("Select Sub Type", "0"));
            $("#cboSubTypeFilter").val(0);
            //Added By Dipali V On 28th Nov 2022 For Getting Issue Aging
            //IssueAgingDay();
            //End of Added By Dipali V On 28th Nov 2022 For Getting Issue Aging
            StopAjaxLoader("#bodyIssueAging"); 
        }

        function Iteration_OnChange(IterationID)
        {
            $("#cboUserStoryIDFilter").html('');
            var selHTML = "";
            var Param = {
                ProjectID: $("#cboProjectIDFilter").val(),
                IterationID: IterationID 
            }
            var param = JSON.stringify(Param);
            var strResult = AJAXCallWithResult("/api/IssueAging/GetIterationIDUserStory", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var UserStoryID = d.UserStoryID;
                    var UserStoryName = d.UserStoryName;
                    selHTML += "<option  value='" + UserStoryID + "' >" + UserStoryName + "</option>";
                }
                $("#cboUserStoryIDFilter").html(selHTML);
            }
        }

        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Issue"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }


        // Getting QueryText From Perticular FilterID
        function ApplyCheckFilter(ApplyID) {
            if (GlobalApplyID == "") {
                GlobalApplyID = ApplyID;
            }
            else if (GlobalApplyID != ApplyID) {
                GlobalApplyID = ApplyID;
            }
            else {
                ApplyID = GlobalApplyID;
            }
            var FilterID = ApplyID.replace("Apply", "");
            if (FilterID != undefined) {
                //StartLoader("#bodyProgramView");
                var Parameter = {
                    FilterID: encodeURI(FilterID),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameter);
                var result = AJAXCallWithResult("/api/IssueAging/EditFilterData", param, false);
                if (result != "AuthenticationError") {
                    for (var i = 0; i < result.length; i++) {
                        var QueryText = result[i]["WhereClause"];
                        var NewQueryText = result[i]["WhereClause"];
                        GlobalFilterName = result[i]["FilterName"];
                    }
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                        $("#txtFilterName").val(GlobalFilterName);
                    }
                    
                    var filterValues = jQuery.parseJSON(QueryText);
                    ProjectDrop_OnChange(filterValues.ProjectID);
                    $("#cboProjectIDFilter").val(filterValues.ProjectID).change();

                    $("#cboCustomerIDFilter").val(filterValues.CustomerID);
                    $("#cboProductVersionIDFilter").val(filterValues.ProductVersionID);
                    $("#cboComponentIDFilter").val(filterValues.ComponentID);
                    $("#cboModuleNameFilter").val(filterValues.ModuleName);

                    $("#cboAssignToFilter").val(filterValues.Assign);
                    $("#cboIterationIDFilter").val(filterValues.IterationID).change();
                    $("#cboUserStoryIDFilter").val(filterValues.UserStoryID);
                    $("#cboTypeNameFilter").val(filterValues.TypeName).change();
                    $("#cboSubTypeFilter").val(filterValues.SubType);
                    $("#cboProjectStatusFilter").val(filterValues.Status);

                    $("#cboCorporateStatusFilter").val(filterValues.CorporateStatus);
                    $("#cboPriorityFilter").val(filterValues.Priority);
                    $("#cboSeverityFilter").val(filterValues.Severity);

                    $("#txtFilterName").val(GlobalFilterName);
                     
                    GlobalQueryText = QueryText; 
                    BindIssueAgingList(QueryText)

                    var sibling = $('label[id^="Apply"]')
                    if ($("#" + ApplyID).parent().find("input").prop("checked") == true) {
                        $("#" + ApplyID).parent().find("input").prop("checked", true);
                        $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                        $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                    }
                    else if ($("#" + ApplyID).parent().find("input").prop("checked") == false) {
                        $(sibling).each(function () {
                            var IsApplyFilter = 0;
                            var id = this.id;
                            if (ApplyID == this.id) {
                                IsApplyFilter = 1;
                                $("#" + id).parent().find("input").prop("checked", true);
                                $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                                $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                            }

                            else if ("Default" + ApplyID == this.id) {
                                if (IsApplyFilter != 1) {
                                    $("#" + id).parent().find("input").prop("checked", true);
                                    $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                                    $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                                }
                            }
                            else {
                                $("#" + id).parent().find("input").prop("checked", false);
                                $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                                $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                            }
                        });
                    }
                    $(".filter button[aria-expanded='true'] .fa-filter").css("color", "#1359a6");
                    $(".filter .fa-filter").css("color", "#1359a6");

                    $("#AdvanceFilterIcon").addClass("activefilter");
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter button").css("background", "#1359ac");
                    $(".filter button").css("width", "26px");
                    $(".fa-filter").css("color", "#ffffff");
                    $("#filterpanel").removeClass("show");
                    $(".tooltip").removeClass('show');
                    //StopAjaxLoader("#bodyProgramView");

                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
        } 
    </script>
</body>
</html>