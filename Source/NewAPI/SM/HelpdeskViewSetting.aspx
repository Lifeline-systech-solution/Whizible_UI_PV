<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HelpdeskViewSetting.aspx.vb" Inherits="PbNIT.HelpdeskViewSetting" %>

<!DOCTYPE html>
<html>
           <%-- Commented by Param for JQuery and Bootstrap version upgrade --%>
        <%CommonFunctions.General.PlotPageHeadTag("Helpdesk View Setting")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Helpdesk View Setting</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=1">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    

</head>
 <style type="text/css">
     #filterpanel .cust_tabpanel .nav-tabs>li>a:focus {
         color:#fff;
    background: #1359a6;
}
     .issfilter_actiondropdown {
    position: relative;
    top: 10px;
    right: 0;
}
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        .dataTables_scrollBody {
            overflow-x: hidden !important
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        .filterpanelbody .form-group {
            display: inline-flex
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .UpDowncollapseArrow {
            float: right;
            width: 15px;
            margin-right: 5px;
        }

            .UpDowncollapseArrow .downarrow {
                display: inline-block;
                width: 15px;
            }

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }
        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }


        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }

        .mr-5 {
            margin-right: 5px;
        }
        /**/
        .proratadetailTbl tr th:first-child {
            width: 300px;
        }

        .proratadetailTbl tr th {
            min-width: 132px;
        }

            .proratadetailTbl tr th:last-child {
                min-width: unset;
            }

        .borderbox {
            padding: 15px 10px 10px;
            border: 1px solid #ddd;
            min-height: 91px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5;
        }

        #exceluploadsteps .tab-pane .form-group {
            overflow: visible;
        }

        #exluploadTbl_wrapper tr th {
            white-space: nowrap;
            min-width: 200px;
        }

        #exluploadTbl_wrapper tr th {
            min-width: 80px;
        }

        table.dataTable,
        table.dataTable th,
        table.dataTable td {
            -webkit-box-sizing: content-box !important;
            -moz-box-sizing: content-box !important;
            box-sizing: content-box !important;
        }

        .tooltip {
            z-index: 9999 !important;
        }

        .custom_chckbox label:before {
            margin-right: 10px;
        }

        .ui-widget-content {
            z-index: 9999 !important;
        }

        .filterpanelbody label {
            text-align: right;
        }

        /* #MyFiltersdropdown {
            display: block;

        }*/
        .filterpanel .cust_tabpanel .MyFiltersdropdown.show {
            display: block;
        }

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        #DeleteConfirmation .modal-header {
            display: inline-block;
        }

        #Issuesavefilter .modal-header {
            display: inline-block;
        }
       .custmodal .modal-content .modal-body {
            padding: 12px!important;
        }

        #DeleteConfirmation .modal-dialog {
            max-width: 459px!important;
        }

         #deleteConfirmAlert .modal-header {
            display: inline-block;
        }
             #deleteConfirmAlert .modal-dialog {
            max-width: 459px!important;
        }
              th.sorting_disabled::after, th.sorting_disabled::before{
            display:none!important;
        }
.table-bordered {border: 1px solid #f4f4f4!important;}
body {
    font-weight: 500; color:#464a4c;
}
button, .btn, a{ font-weight:500;}
.form-select{padding-right: 26px!important;}

       /*added by dipali v on 5th April 2023 For UI Content should not bold*/ 
        #BodyELShowHistoryTbl, #bodyhelpdeskTbl {
            font-weight: 100;
        }
        /*End of added ruby dipali v on 5th April 2023 For UI Content should not bold*/
         /*added by dipali v on 8th april 2023 For Alert blur issue*/ 
        .alertify-notifier {
            z-index: 9999 !important;
        }
          /*End of added by dipali v on 8th april 2023 For Alert blur issue*/ 
    </style>  
<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-0 text-right graybg" style="display: table">
            <h5 class="pgtitle pull-left"><%= MyBase.GetResourceString("C_Caption") %></h5>

            <a href="javascript:;" class="clearalllink" style="" onclick="clearAll()" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong><%= MyBase.GetResourceString("C_ClearAll") %></strong></a>
            <div class="filter inline pull-right">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
        </div>
         <!--filter panel-->
         <div id="basicfilter" class="tab-pane">
        <div id="filterpanel" class="filterpanel collapse" style="margin-bottom: 10px;">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs" id="tabMyFilter">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" ><%= MyBase.GetResourceString("C_MyFilters") %>  <span class="caret"></span></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="project2" class="radiotextsty filtername"> </span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproOne" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproOne" data-original-title="Apply filter"></label>
                                            <input type="hidden" id="appliedfilter" />
                                            <input type="hidden" id="queryText" />
                                            <input type="hidden" id="editqueryid" />
                                            <input type="hidden" id="editqueryname" />
                                            <input type="hidden" id="editquerytext" />
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="task" class="radiotextsty">Task and milestones</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproTwo" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproTwo" data-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="groupcompany" class="radiotextsty">For group company</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproThree" type="checkbox" name="">
                                            <label data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" for="IssueselproThree" data-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item" id="tabBasicFilter">
                            <a class="nav-link" href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                        </li>


                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div style="text-align: center">
                                    <label class="editFilter" id="lblBasicFilterEdit" style="display: inline-block;"></label>
                                </div>
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" onclick="CheckFltrValidation()" data-bs-dismiss="modal"> <%= MyBase.GetResourceString("Btn_SaveandApply") %></button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()"><%= MyBase.GetResourceString("Btn_Apply") %></button>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6 form-group">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_Department") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboFltrDepartmentID", "EXEC usp_sel_whizible2_tbl_PM_DepartmentMaster_DepartmentFilter",,, "class='form-select text-truncate input-sm' onChange='javascript:Fltr_Dept_onChange(this.value);'", False,,) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 form-group">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_Customer") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboFltrCustomerID", "Exec usp_sel_whizible2_tbl_PM_Customer_Customer 0",,, "class='form-select text-truncate input-sm' onChange='javascript:Fltr_Cust_onChange(this.value);'", False,,) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6 form-group">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_ClientOfCustomer") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboFltrClientID", "EXEC usp_Sel_whizible2_AllClientsByCustomer 0",,, "class='form-select text-truncate input-sm' ", False,,) %>
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


            </div>
        </div>
             </div>
         <!--end filter panel-->


        <div class="container-fluid pt-1 pb-1 text-right">
            <a href="javascript:;" class="btn borderbtn" onclick="addphdetail()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("Btn_Add") %></a>
            <button class="btn borderbtn mr-5" id="" onclick="DeleteDetails()"><%= MyBase.GetResourceString("Btn_Delete") %></button>
        </div>
        <div class="content">
            <div class="clearfix"></div>
            <table id="helpdeskTbl" class="table table-bordered helpdeskTbl" style="width: 100%;">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("H_Department") %></th>
                        <th><%= MyBase.GetResourceString("H_Customer") %></th>
                        <th><%= MyBase.GetResourceString("H_ClientOfCustomer") %></th>
                        <th><%= MyBase.GetResourceString("H_HelpDeskViewAccess") %></th>
                        <th><%= MyBase.GetResourceString("H_HelpDeskEmailAccess") %></th>
                        <th>
                            <div class="custom_chckbox">
                                <input id="descrGridcheck0" class="chckHead" type="checkbox" />
                                <label for="descrGridcheck0"></label>
                            </div>
                        </th>
                    </tr>
                </thead>

                <tbody id="bodyhelpdeskTbl">
                </tbody>
            </table>
        </div>


        <div class="Resourcedetailpanel">
            <div class="pgdetailinner">
                <ul class="nav nav-tabs detailsubtabs">
                    <li><a href="#detailTab" class="active" data-bs-toggle="tab" id=""><%= MyBase.GetResourceString("H_Details") %></a><div></div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="detailTab" class="tab-pane active">
                        <div class="detailsubtabsbtn pb-1 text-right">
                            <button class="btn btnyellow mr-5" id="btnSave" onclick="SaveDetails(0)"><%= MyBase.GetResourceString("Btn_Save") %></button>
                            <button class="btn btnyellow mr-5" id="" onclick="SaveDetails(1)"><%= MyBase.GetResourceString("BtnSaveAndAdd") %></button>
                            <a href="javascript:;" class="btn borderbtn mr-5" id="HelpdeskViewHistory" onclick="HelpdeskViewHistory()" data-bs-toggle="modal" data-bs-target="#helpShowHistory"><%= MyBase.GetResourceString("BtnShowHistory") %></a>
                            <button class="btn borderbtn canceldetailpanel mr-5" id="" onclick="cancledetailpanel()"><%= MyBase.GetResourceString("BtnCancel") %></button>
                        </div>
                        <input id="txthid" type="text" hidden="hidden" />
                        <div class="row pt-1 mb-1 pb-1">
                            <div class="clearfix"></div>
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_Department") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "EXEC usp_sel_whizible2_tbl_PM_DepartmentMaster_Department",,, "class='form-select input-sm' onChange='javascript:Dept_onChange(this.value);'", False,,) %>
                            </div>
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_Customer") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "EXEC usp_sel_whizible2_tbl_PM_Customer_Customer",,, "class='form-select input-sm' onChange='javascript:Cust_onChange(this.value);'", False,,) %>
                            </div>
                            <div class="col-sm-4">
                                <label class=""><%= MyBase.GetResourceString("C_ClientOfCustomer") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboClientOfCust", "EXEC usp_Sel_whizible2_AllClientsByCustomer",,, "class='form-select input-sm' ", False,,) %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_HelpDeskViewAccess") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboHelpDeskViewAccess", "EXEC usp_sel_whizible2_HelpDeskViewAccess View_HD ",,, "class='form-select input-sm'", False,,) %>
                            </div>
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_HelpDeskEmailAccess") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboHelpDeskEmailAccess", "EXEC usp_sel_whizible2_HelpDeskViewAccess Emails",,, "class='form-select input-sm'", False,,) %>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>

        <div class="clearfix"></div>
    </div>



    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SaveFilterAs") %></h5>
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
                                        <label class="control-label col-md-4 p-0 text-right required"><%= MyBase.GetResourceString("C_FilterName") %></label>
                                        <span class="col-md-8">
                                            <input type="text" class="form-control" id="txtFltrName" name=""><br />
                                            <div class="btnrow">
                                                <button id="savefilterbtn" class="btn btnyellow pull-left" onclick="SaveVTFilterDetails()"><%= MyBase.GetResourceString("Btn_Save") %></button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right"><%= MyBase.GetResourceString("BtnCancel") %></button>
                                            </div>
                                        </span>
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
    
    <!--show history modal start here-->
    <div class="modal custmodal fade" id="helpShowHistory" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ShowHistory") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="ELShowHistoryTbl" class="table table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("H_FiledName") %></th>
                                <th><%= MyBase.GetResourceString("H_OldValue") %></th>
                                <th><%= MyBase.GetResourceString("H_NewValue") %></th>
                                <th><%= MyBase.GetResourceString("H_DateAndTime") %></th>
                                <th><%= MyBase.GetResourceString("H_UpdatedBy") %></th>
                            </tr>
                        </thead>
                        <tbody id="BodyELShowHistoryTbl"></tbody>
                    </table>
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("Btn_Close") %></button>
                    </div>

                </div>
            </div>
        </div>
    </div>



    <!--Delete confrimation modal for details start here -->
    <div class="modal custmodal Issuesave_filter fade" id="DeleteConfirmation" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><%= MyBase.GetResourceString("Btn_Delete") %></h5>
                    <button type="button" onclick="CancelConfirmation()" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <span id="CheckModal"></span>
                        <p><%= MyBase.GetResourceString("DeleteNote") %></p>
                    </div>
                    <br />
                      <div class="modal-body">
                                    <input type="text" id="deleteid" hidden="hidden" />
                                   
                                </div>
                    <div class="">
                        <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn pull-left" onclick="CancelConfirmation()"><%= MyBase.GetResourceString("BtnCancel") %></a>
                        <a href="javascript:;" data-bs-dismiss="modal" class="btn btnyellow  pull-right" onclick="DeleteConfirmation()"><%= MyBase.GetResourceString("Btn_Delete") %></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Delete confrimation modal end -->
    <!-- Delete confrimation modal for filter-->

         <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
                        <div class="modal-dialog ui-draggable">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header ui-draggable-handle">
                                     <button type="button" onclick="CancelConfirmation()" class="close" data-bs-dismiss="modal" aria-label="Close">
                                     <span aria-hidden="true">&times;</span>
                                          </button>
                                     <h5 class="modal-title"><%= MyBase.GetResourceString("Btn_Delete") %></h5>
                                </div>
                                <div class="modal-body">

                                    <input type="text" id="DFilterID" hidden="hidden" />
                                    <input type="text" id="DFilterName" hidden="hidden" />
                                    <input type="text" id="DIsApplyed" hidden="hidden" />
                                     <div class="text-center">
                                     <p><%= MyBase.GetResourceString("DeleteNote") %></p>
                                         </div>
                                </div>
                                <div class="modal-footer">
                                      <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn pull-left" onclick="CancelConfirmation()"><%= MyBase.GetResourceString("BtnCancel") %></a>
                        <a href="javascript:;" data-bs-dismiss="modal" class="btn btnyellow  pull-right" onclick="confirmDelete()"><%= MyBase.GetResourceString("Btn_Delete") %></a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>


    <!--Delete confrimation modal for filter End -->
    <!--show history modal end-->

    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%--<script src="../../General/CommonValidations.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script>
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        var AllEmpFilter = ["DepartmentID", "CustomerID", "ClientID"];
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString%>';

        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var UserName = '<%= Session("strUserName") %>';
        var SessionLoginType = '<%= Session("LoginType") %>';
        var loginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var intUserId = '<%= Session("intUserId") %>';
        var EmployeeID = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        var currentFilterID = 0;
        var hdnQueryText = "";
        var gflag = '';
        var module = 'Fltr';
        var gApplyfilterAlert = 0;
        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
           
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
            
        });
        //Detailpanel Script start from here
        function addphdetail() {
            $(".Resourcedetailpanel").show();
            $("html,body").animate(
                {
                    scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                },
                "slow"
            );
            //used for disable grid
            $("#helpdeskTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();

            gflag = 1;  // For Insert
            $("#HelpdeskViewHistory").hide();
            $("#txthid").val(0);
            cancledetailpanel();
        }

        function editdetail(DeptId) {
            $("#HelpdeskViewHistory").show();
            $("#txthid").val(DeptId);

            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $("html,body").animate(
                {
                    scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                },
                "slow"
            );
            //used for disable grid
            $("#helpdeskTbl_wrapper .dataTables_scrollBody, .backbtn, #helpdeskTbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();

            gflag = 2;  // For Update

            var DeptID = DeptId;

            var Parameter =
            {
                DeptID: DeptID,
                DeptCustClientMappingID: 0
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/getHelpdeskViewDetails", param, false);
           
            for (var i = 0; i < Result.length; i++) {
                var Emails = Result[i]["Emails"];
                var DepartmentID = Result[i]["DepartmentID"];
                var CustomerID = Result[i]["CustomerID"];
                var ClientID = Result[i]["ClientID"];
                var View_HD = Result[i]["View_HD"];
                $('#CboDepartment').val(DepartmentID).change();
                $('#CboCustomer').val(CustomerID).change();
                $('#CboClientOfCust').val(ClientID);
                //Commented and added By Riddhesh Patil on 11 May 2023
                //$('#CboHelpDeskViewAccess').val(View_HD);
                //$('#CboHelpDeskEmailAccess').val(Emails);

                if (View_HD == 0) {
                   
                    $("#CboHelpDeskViewAccess").val(2);
                }
                else {
                    $("#CboHelpDeskViewAccess").val(1);
                }
                if (Emails == 0) {
                    
                    $("#CboHelpDeskEmailAccess").val(2);
                }
                else {
                    $("#CboHelpDeskEmailAccess").val(1);
                }
                //End of Commented and added By Riddhesh Patil on 11 May 2023
            }
        }

        $(".BGdetalilink").click(function () {
            $(this).closest("tr").addClass("rowhiglight");
        });

        $(".canceldetailpanel").click(function () {
            $("table tr").removeClass("rowhiglight");
            $(".Resourcedetailpanel").hide();
            $("#helpdeskTbl_wrapper .dataTables_scrollBody, .backbtn, #helpdeskTbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            //$("#helpdeskTbl_wrapper .dataTables_scrollBody").css({ height: tblheight - 130, "overflow-y": "auto" });
            $("#helpdeskTbl_wrapper .dt-row").css({ height: tblheight - 180, "overflow-y": "auto" });
        }          
     
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

      //Added by Riddhesh On 11-Jan-2023 for Checkbox Functionality
        var SelectedHelpdeskID = [];
        $(".chckHead").change(function () {
            var allPages = HelpdeskTable.fnGetNodes();
            var checked = $(this).is(":checked");
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
                var rows = $("#LTListTbl").dataTable().fnGetNodes();
                for (var i = 0; i < rows.length; i++) {
                    SelectedHelpdeskID.push(parseInt($(rows[i]).find("#txthid").val()));
                }
            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
                SelectedLeaveID = [];
            }
        });

        function checkUncheck() {
            if (HelpdeskTable.$('input:checked').length == HelpdeskTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").prop("checked", false);
                $(".chckHead").removeAttr("checked");
            }
        }



        function GetSelectedHelpdeskSetting(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedHelpdeskID.push(parseInt(row.find('#txthid').val()));
            }
            else {
                if (SelectedHelpdeskID != 'undefined' && SelectedHelpdeskID.length > 0) {
                    var removeHelpdeskSetting = row.find('#txthid').val();
                    SelectedHelpdeskID.remove(parseInt(removeHelpdeskSetting));
                }
            }

        }
      //End of Added by Riddhesh On 11-Jan-2023
        //datatable
        // var HelpdeskTable = $("#helpdeskTbl").dataTable({
        //     scrollY: '60vh',
        //     scrollX: true,
        //     paging: true,
        //     pageLength: 10,
        //     bLengthChange: false,
        //     bFilter: false,
        //     responsive: true,
        //     destroy: false,
        //     retrieve: true,
        //     ordering: false,
        //     info: true,
        // });
        $(".collapse").on("show.bs.collapse", function (e) {
            $(".table").resize();
        });
        $(".collapse").on("hidden.bs.collapse", function (e) {
            $(".table").resize();
        });


        $(".modal").on("show.bs.collapse", function (e) {
            $(".table").resize();
        });
        $(".modal").on("hide.bs.collapse", function (e) {
            $(".table").resize();
        });


        $('a[data-bs-toggle="tab"]').on("shown.bs.tab", function (e) {
            $(".table").resize();
        });

        $(document).ready(function () {
            //HelpdeskViewDetails('');
            getMyFilters();
            getDefaultFilter();

        });

        function HelpdeskViewDetails(filterParams) {
            var strHTML = "";
            $('#helpdeskTbl').dataTable().fnDestroy();
            $("#bodyhelpdeskTbl").html('');
            var DeptID = 0; 
            if (filterParams == "") {
                var Parameter =
                {
                    DeptID: DeptID
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/getHelpdeskViewDetails", param, false);
            }
            else {
                var param = JSON.stringify(filterParams);
                var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/getHelpdeskViewDetailsbyFilter", param, false);
            }
           
            for (var i = 0; i < Result.length; i++) {
                var Emails = Result[i]["Emails"];
                var DepartmentID = Result[i]["DepartmentID"];
                var CustomerID = Result[i]["CustomerID"];
                var ClientID = Result[i]["ClientID"];
                var View_HD = Result[i]["View_HD"];
                var DeptCustClientMappingID = Result[i]["DeptCustClientMappingID"];
                var Department = Result[i]["Department"];
                var CustomerName = Result[i]["CustomerName"];
                var ClientName = Result[i]["ClientName"];
                var HelpDesk = Result[i]["HelpDesk"];
                var Email = Result[i]["Email"];

                if (ClientName == null) {
                    ClientName = '';
                }
                if (CustomerName == null) {
                    CustomerName = '';
                }
                if (Department == null) {
                    Department = '';
                }
                strHTML += '<tr>'
                strHTML += '<td><a href="#" onclick="editdetail(' + DeptCustClientMappingID + ')">' + Department + '</a></td>'
                strHTML += '<td>' + CustomerName + '</td>'
                strHTML += '<td>' + ClientName + '</td>'
                strHTML += '<td>' + HelpDesk + '</td>'
                strHTML += '<td>' + Email + '</td>'
                strHTML += '<td> <div class="custom_chckbox">  <input id="descrGridcheck' + DeptCustClientMappingID + '" name="checkHelpdesk" class="chcktbl" type="checkbox" value="' + DeptCustClientMappingID + '" onclick="checkUncheck();GetSelectedHelpdeskSetting(this);" /> <label for="descrGridcheck' + DeptCustClientMappingID + '"></label>   </div></td>'

                strHTML += '</tr>'
            }
            $("#bodyhelpdeskTbl").html(strHTML);
            $("#helpdeskTbl").dataTable({
                // scrollY: '60vh',
                // scrollX: true,
                paging: true,
                pageLength: 10,
                bLengthChange: false,
                bFilter: false,
                responsive: true,
                destroy: false,
                retrieve: true,
                ordering: false,
                info: true,
            });            
            $(".table").resize();
        }
        
        function cancledetailpanel() {
            $('#CboDepartment').val(0);
            $('#CboCustomer').val(0);
            $('#CboHelpDeskViewAccess').val(0);
            $('#CboHelpDeskEmailAccess').val(0);
            $('#CboClientOfCust').val(0);
            //$("#txthid").val('');
            flag = '';
        }

        function Dept_onChange(DeptId) {
            var DeptID = DeptId;
            if (DeptID == 0) {
                Cust_onChange(0)
            }
            else if (DeptID > 0) {
                $("#CboCustomer").html('');
                var Parameter =
                {
                    DeptID: DeptID,
                    DeptCustClientMappingID: 0
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/GetCustomerByDept", param, false);
                var s = '';
                for (var i = 0; i < Result.length; i++) {
                    var ObjRateCard = Result[i];
                    s += '<option value="' + ObjRateCard.Customer + '">' + ObjRateCard.CustomerName + '</option>';
                }
                $("#CboCustomer").html(s);
            }
        }

        function Cust_onChange(Customer) {
            var DeptID = $("#CboDepartment").val();
            var CustomerId = Customer;

            $("#CboClientOfCust").html('');
            var Parameter =
            {
                DeptID: DeptID,
                Customer: CustomerId,
                DeptCustClientMappingID: 0
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/GetClientByCustomer", param, false);
            var s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.ClientID + '">' + ObjRateCard.ClientName + '</option>';
            }
            $("#CboClientOfCust").html(s);

        }

        function CheckValidation() {
            if ($("#CboDepartment").val() == undefined || $("#CboDepartment").val() == "0" || $("#CboDepartment").val() == null) {
                $("#CboDepartment").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_Departmentshouldnotleftblank") %>");
                return false;
            }
            if ($("#CboCustomer").val() == undefined || $("#CboCustomer").val() == "0" || $("#CboCustomer").val() == null) {
                $("#CboCustomer").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_Customershouldnotleftblank") %>");
                return false;
            }
            if ($("#CboHelpDeskViewAccess").val() == undefined || $("#CboHelpDeskViewAccess").val() == "0" || $("#CboHelpDeskViewAccess").val() == null) {
                $("#CboHelpDeskViewAccess").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_HelpDeskViewAccessshouldnotleftblank") %>");
                return false;
            }
            if ($("#CboHelpDeskEmailAccess").val() == undefined || $("#CboHelpDeskEmailAccess").val() == "0" || $("#CboHelpDeskEmailAccess").val() == null) {
                $("#CboHelpDeskEmailAccess").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_HelpDeskEmailAccessshouldnotleftblank") %>");
                return false;
            }
            else {
                validateflag = true
            }
        }

        var validateflag
        function SaveDetails(flag1) {
            var View_accessHD = 0;
            var View_accessEmail = 0;
          

       
            var Msg = '';
            var ID = 0;
            CheckValidation();
            if (validateflag == true) {
                if ($("#CboHelpDeskViewAccess").val() == 2) {
                    View_accessHD = 0;
                }
                else {
                    View_accessHD = 1;
                }
                if ($("#CboHelpDeskEmailAccess").val() == 2) {
                    View_accessEmail = 0;
                }
                else {
                    View_accessEmail = 1;
                }
                var Parameter =
                {
                    DepartmentID: $("#CboDepartment").val(),
                    CustomerID: $("#CboCustomer").val(),
                    ClientID: $("#CboClientOfCust").val(),
                    View_HD: View_accessHD,
                    View_Email: View_accessEmail,
                    CreatedBy: UserName,
                    flag: gflag,
                    ID: $("#txthid").val()
                }
                var param = JSON.stringify(Parameter);

                var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/InsHelpdeskViewDetails", param, false);
                for (var i = 0; i < Result.length; i++) {
                    Msg = Result[i]["Msg"];
                    ID = Result[i]["ID"];
                }
                if (flag1 == 0) {
                    if (Msg == "AlreadyExists") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("<%= MyBase.GetResourceString("A_RecordAlreadyExistswithSameCombination") %>");
                 
                    }
                    else if (Msg == "save") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%= MyBase.GetResourceString("A_RecordSavesuccessfully") %>");
                        //Added By Riddhesh Patil on 11-Jan-2023 for update data on save button Click
                        editdetail(ID);
                        //End of Added By Riddhesh Patil on 11-Jan-2023
                    }
                    else if (Msg == "update") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%= MyBase.GetResourceString("A_Recordupdatesuccessfully") %>");
                        //$("#txthid").val(ID);
                        //cancledetailpanel();
                        //flag = 0;
                        //$("#txthid").val(0);
                        // HelpdeskViewHistory(a);
                    }

                HelpdeskViewDetails('');
                }

                else {
                       cancledetailpanel();
                       $("#HelpdeskViewHistory").show();
                       //$("#txthid").val(ID);
                       $("#txthid").val(0);

                    if (Msg == "AlreadyExists") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("<%= MyBase.GetResourceString("A_RecordAlreadyExistswithSameCombination") %>");
                        //$("#txthid").val(ID);
                    }
                    else if (Msg == "save") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%= MyBase.GetResourceString("A_RecordSavesuccessfully") %>");
                    }
                    else if (Msg == "update") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%= MyBase.GetResourceString("A_Recordupdatesuccessfully") %>");
                     //   $("#txthid").val(ID);
                        //cancledetailpanel();
                        //flag = 0;
                        //$("#txthid").val(0);
                        // HelpdeskViewHistory(a);
                    }

                    HelpdeskViewDetails('');
                }
            }
        }

        function DeleteDetails() {
           
            var table = $('#helpdeskTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var DeptIDs = $('input[name=checkHelpdesk]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrMasterIDs = DeptIDs.split(',');
            if (arrMasterIDs == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SelectAtLeastOneRecordForDelete") %>");
            }
            else {
                $("#DeleteConfirmation").modal('show');
            }
            //var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/DelHelpdeskViewDetails", param, false); 
        }

        function DeleteConfirmation() {
            
            var table = $('#helpdeskTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var DeptIDs = $('input[name=checkHelpdesk]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrMasterIDs = DeptIDs.split(',');
            
            var k = 0;

            for (var i = 0; i < arrMasterIDs.length; i++) {
                var MasterID = arrMasterIDs[i];
                var Parameter =
                {
                    ID: MasterID
                }
                var param = JSON.stringify(Parameter);
                var result = AJAXCallWithResult("/api/HelpdeskViewSetting/DelHelpdeskViewDetails", param, false);
                if (result != "AuthenticationFailed") {
                    k += 1;
                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }

            if (k >= 1) {
                HelpdeskViewDetails('');
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<%= MyBase.GetResourceString("A_Deleted") %>");
                $("#DeleteConfirmation").modal('hide');
                $(".chckHead").prop("checked",false);

            }
            else {
            }
        }

        function CancelConfirmation() {
            $("#DeleteConfirmation").modal('hide');
            $('#deleteConfirmAlert').modal('hide');
        }

        function Fltr_Dept_onChange(DeptId) {
            var DeptID = DeptId;


            $("#CboFltrCustomer").html('');
            var Parameter =
            {
                DeptID: DeptID,
                DeptCustClientMappingID: 0
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/GetCustomerByDeptForFilter", param, false);
            var s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.Customer + '">' + ObjRateCard.CustomerName + '</option>';
            }
            $("#CboFltrCustomer").html(s);

        }

        function Fltr_Cust_onChange(Customer) {
            var DeptID = $("#CboDepartment").val();
            var CustomerId = Customer;
            $("#CboFltrClientID").html('');
            var Parameter =
            {
                DeptID: DeptID,
                Customer: CustomerId,
                DeptCustClientMappingID: 0
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/GetClientByCustomerForFilter", param, false);
            var s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.ClientID + '">' + ObjRateCard.ClientName + '</option>';
            }
            $("#CboFltrClientID").html(s);
        }

        function ApplyFlter() {
            var filterFlag = true;
            var Dept = $("#CboFltrDepartmentID").val() == "" ? null : $("#CboFltrDepartmentID").val();
            var Cust = $("#CboFltrCustomerID").val() == "" ? null : $("#CboFltrCustomerID").val();
            var Client = $("#CboFltrClientID").val() == "" ? null : $("#CboFltrClientID").val();

          
            var filterWhereClause2 = GenerateBasicFilterQuery("Fltr", AllEmpFilter);
            var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");

            if ((Dept == null || Dept == 'undefined' || Dept == " " || Dept == 0)
                && (Cust == null || Cust == 'undefined' || Cust == " " || Cust == 0)
                && (Client == null || Client == 'undefined' || Client == " " || Client == 0)
            ) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_ApplyfilterForOneRecord") %>');
                filterFlag = false;
                return false;
                $('#Issuesavefilter').modal('hide');
            }

            if (filterFlag == true) {
                currentFilterID = 0;
                var filter = "";

                filter = { EmpWhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();
                HelpdeskViewDetails(filter);
                alertify.set('notifier', 'position', 'top-right');
                $("#filterpanel").removeClass("show");
                if (gApplyfilterAlert == 0) {
                    alertify.success("<%= MyBase.GetResourceString("A_Filterappliedsuccessfully") %>");
                }
            }
        }

        function GenerateBasicFilterQuery(module, filterField) {
            try {
               
                var strqtext = "";               
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strTXT = $('#Cbo' + module + filterField[i]).val();
                    if (strTXT != null && strTXT != 'undefined' && strTXT != "") {
                        strvalue = strTXT
                    }
                    if (filterField[i] == "DepartmentID" && strTXT > 0) {
                        var asd = "DepartmentID";
                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }

                    if (filterField[i] == "CustomerID" && strTXT > 0) {
                        var asd = "CustomerID";
                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    if (filterField[i] == "ClientID" && strTXT > 0) {
                        var asd = "ClientID";
                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                return strqtext;

            }
            catch (ex) {
                alert(ex.message);
            }
        }
        //function AddEscapeCharacter(stroriginalvalue) {

        //    if (stroriginalvalue.indexOf('_') != -1) {
        //        stroriginalvalue = stroriginalvalue.replace(/ /, "[_]");
        //    }
        //    if (stroriginalvalue.indexOf('%') != -1) {
        //        stroriginalvalue = stroriginalvalue.replace(/ /, "[%]");
        //    }
        //    return stroriginalvalue;
        //}

        function FindDuplicateFilter(filter, id) {
            var filters = document.getElementById("MyFiltersdropdown");
            for (var i = 0; i < filters.childNodes.length; i++) {
                if (filters.childNodes[i].innerText.trim().toUpperCase() == filter.toUpperCase() && filters.childNodes[i].childNodes[1].children[0].id != "f" + id) {
                    return true;
                    break;
                }
            }
        }

        var savedFilterName = "";
        function SaveVTFilterDetails() {
           
            var fltFilterName = $("#txtFltrName").val().trim();
            var isDuplicate = FindDuplicateFilter(fltFilterName, 0);
            var filterExists = 0; 
            var filterWhereClause2 = GenerateBasicFilterQuery("Fltr", AllEmpFilter);
            var filterWhereClause = (filterWhereClause2).replace(/"/g, "\''");
            
            if (fltFilterName == "" || fltFilterName == " ") {
                $("#savefilterbtn").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_PleaseenterFilterName") %>');
                $("#txtFltrName").focus();
            }
            else if (checkSpecialCharacter(fltFilterName.trim(), WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_ValidatespecialCharacter") %> ' + WebConfigSpecialCharacters + ' characters');
                $("#txtFltrName").focus();
                return false;
            }
          
          
            else if (filterWhereClause == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("SelectAtleastonefilter") %>');
            }
            else
            {
                var paramFilterID = 0;
                var paramFlag = 0;
                paramFilterID = currentFilterID;
                if (paramFilterID == 0) {
                    if (isDuplicate == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_FilterNamealreadyexists") %>', 'error', 5);
                        return false;
                    }
                    else {
                        paramFlag = 0;
                    }
                }
                else {
                    paramFlag = 1;
                }
              
                var Parameters =
                {
                    TagID: encodeURI(36079),
                    ProjectID: 0,
                    intEmployeeID: encodeURI(SessionEmployeeId),
                    fltFilterName: fltFilterName,
                    LoginType: encodeURI(SessionLoginType),
                    CreatedBy: encodeURI(UserName),
                    QueryText: filterWhereClause,
                    Flag: encodeURI(paramFlag),
                    FilterID: encodeURI(paramFilterID)
                }
             
                $.ajax({
                    url: encodeURI(strUrl) + '/api/HelpdeskViewSetting/SaveFilter',
                    method: 'Post',
                    data: JSON.stringify(Parameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Helpdesk"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));

                        }
                    },
                    success: function (data)
                    {                       
                        if (data != undefined && data != "") {
                            currentFilterID = data;
                            currentappliedfilter = currentFilterID
                        }
                        getMyFilters();
                        ApplyFlter();
                        savedFilterName = fltFilterName;
                        $("#txtFltrName").val('');
                        $('#Issuesavefilter').modal('hide');

                        $('#filterpanel').modal('hide');
                    },
                });
            }
        }

        function getDefaultFilter()
        {
            hdnQueryText = "";
            var projectParameters = {
                intEmployeeID: EmployeeID,
                LoginType: loginType,
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/HelpdeskViewSetting/GetDefaultFilter", param, false); 
            if (strResult != undefined) {
                $('#appliedfilter').val(strResult.FilterID);
                setfiltername(strResult.FilterName);
                var querytext = strResult.QueryText;
                if (querytext != '' && querytext != null) querytext = querytext.replace(/\'/g, '\'\'');
                $('#queryText').val(querytext);
                $('#newfiltername').val(strResult.FilterName);
                $('#editqueryid').val(strResult.FilterID);
                $('#editqueryname').val(strResult.FilterName);
                //$('#lblBasicFilterEdit').css('visibility', 'visible');
                //$('#lblBasicFilterEdit').text(strResult.FilterName);

                if (strResult.FilterID > 0) {
                    var qtext = strResult.QueryText.replace('[Over]', 'Over');
                    gApplyfilterAlert = 1;
                    hdnQueryText = strResult.QueryText;
                    BindBasicFilters(qtext, module);
                    EditFilter(strResult.FilterID);
                    ApplyFlter();
                }

                else {
                    HelpdeskViewDetails('');
                } 
            } 
            $("#MyFiltersdropdown").removeClass("clsShowHide"); 
        }
                
        function HelpdeskViewHistory(DeptId) {
            //var DeptID = $("#CboDepartment").val();
            var DeptID = $('#txthid').val();
         
            var strHTML = "";
            $('#ELShowHistoryTbl').dataTable().fnDestroy();
            $("#BodyELShowHistoryTbl").html('');

            var Parameter =
            {
                DeptID: DeptID
            }

            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/HelpdeskViewSetting/GetAuditTrailHistory", param, false);
            for (var i = 0; i < Result.length; i++) {
                var LogID = Result[i]["LogID"];
                var Date = Result[i]["Date"];
                var ModifiedBy = Result[i]["ModifiedBy"];
                var TagID = Result[i]["TagID"];
                var FieldName = Result[i]["FieldName"];
                var ProjectID = Result[i]["ProjectID"];
                var OldValue = Result[i]["OldValue"];
                var NewValue = Result[i]["NewValue"];
                var UniqueID = Result[i]["UniqueID"];
                var IsSubTagID = Result[i]["IsSubTagID"];
                strHTML += '<tr>'
                strHTML += '<td>' + FieldName + '</td>'
                strHTML += '<td>' + OldValue + '</td>'
                strHTML += '<td>' + NewValue + '</td>'
                strHTML += '<td>' + Date + '</td>'
                strHTML += '<td>' + ModifiedBy + '</td>'
                strHTML += '</tr>'
            }
            $("#BodyELShowHistoryTbl").html(strHTML);
            $("#ELShowHistoryTbl").dataTable({
                scrollY: '60vh',
                scrollX: true,
                paging: true,
                pageLength: 10,
                bLengthChange: false,
                bFilter: false,
                responsive: true,
                destroy: false,
                retrieve: true,
                ordering: false,
                info: true,
            });

            $(".table").resize();
        }

        function CheckFltrValidation() { 
            var filterWhereClause2 = GenerateBasicFilterQuery("Fltr", AllEmpFilter);
            var filterWhereClause = (filterWhereClause2).replace(/"/g, "\''");

            if (filterWhereClause == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("SelectAtleastonefilter") %>');
            }
            else {
                $("#Issuesavefilter").modal("show");
            }
        }
        var selectedqid = "";
        function getMyFilters() {
          
           // alert(selectedqid);
            var strlist = '';
           // var setid = $('#appliedfilter').val();
            setid = selectedqid;
            var projectParameters = {
                LoginType: loginType,
                intEmployeeID: EmployeeID,
            }
            var param = JSON.stringify(projectParameters);
            var data = AJAXCallWithResult("/api/HelpdeskViewSetting/GetFilters", param, false);
            $('#MyFiltersdropdown').html('');
            if (data != undefined) {
                for (var i = 0; i < data.length; i++) {
                    var d = data[i];
                    var fid = d.FilterId;
                    var fname = d.FilterName;
                   
                    var ftext = d.QueryText;
                    strlist += '<li>';
                    strlist += '    <label class="customradio">';
                    if (d.SetDefault == 1) {
                        strlist += '        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="f' + fid + '" type="checkbox" name="f' + fid + '" onchange="SetDefault(' + fid + ',&quot;default&quot; )" checked="checked"/>';
                        strlist += '        <span data-bs-toggle="tooltip" data-bs-placement="right" title="Default filter" class="checkmark"></span>';
                    }
                    else {
                        strlist += '        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="f' + fid + '" type="checkbox" name="f' + fid + '" onchange="SetDefault(' + fid + ',&quot;&quot; )"/>';
                        strlist += '        <span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>';
                    }
                    strlist += '    </label>';
                    strlist += '    <label class="">';
                    strlist += '    <span for="f' + fid + '" class="radiotextsty filtername">' + fname + '</span></label>';
                    strlist += '    <div class="issfilter_actiondropdown">';
                    strlist += '        <div class="custom_chckbox_markblue">';
                    if (fid == setid) {
                        strlist += '            <input id="txtAF' + fid + '" checked="" type="checkbox" name=""/>';
                        strlist += '            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Applied Filter" id="Apply' + fid + '" for="txtAF' + fid + '"';
                        strlist += "            onclick = 'clearAll()'></label> ";
                    }
                    else {
                        strlist += '            <input id="txtAF' + fid + '" type="checkbox" name=""/>';
                        strlist += '            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" id="Apply' + fid + '" for="txtAF' + fid + '"';
                        strlist += "            onclick = 'ApplyFilter(" + fid + ")'></label> ";
                    }

                    //strlist += '        </div>  <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt" onclick="EditFilter(' + fid + ');"></i></span>';
                    strlist += '        </div>  <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt" onclick="EditFilter(' + fid + ');"></i></span>';
                    if (d.EmployeeID == EmployeeID) {
                        strlist += '        <span onclick= btnDeleteFilter("' + fid + '")><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt"></i></span>';
                    }
                    else {
                        strlist += "		<span class='NoDrop' style='cursor: no-drop;'><i style='cursor: no-drop;opacity:0.5;' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='You do not have access to delete this filter' class='far fa-trash-alt'></i></span>";
                    }
                    strlist += '    </div>';
                    strlist += '</li>';
                }
            }
            $('#MyFiltersdropdown').html(strlist);
            //alert(strlist);
        }

        function btnDeleteFilter(qid) {

            $('#deleteid').val(qid);
            $('#deleteConfirmMsg').html("Are you sure to delete the selected filter?");
            $('#deleteConfirmAlert').modal('show');
        }

        function confirmDelete() {
            var qid = $('#deleteid').val();
            $('#deleteConfirmAlert').modal('hide');
            DeleteFilter(qid);
        }
      
        function ApplyFilter(qid)
        { 
            var Qid = qid; 
            var projectParameters = {
                QueryID: Qid
            }
            var param = JSON.stringify(projectParameters);
            var data = AJAXCallWithResult("/api/HelpdeskViewSetting/GetFilterById", param, false);
            if (data != undefined) {
              
                $('#appliedfilter').val(qid);
                selectedqid = qid;
                console.log(qid);
                //$('#appliedfiltername').html(data.FilterName);
                setfiltername(data.FilterName);
                //$('#lblBasicFilterEdit').css('visibility', 'visible');
                //$('#lblBasicFilterEdit').text(data.FilterName);
                $('#txtFltrName').val(data.FilterName);
                $('#editqueryname').val(data.FilterName);
                var querytext = data.QueryText.replace(/\'/g, '\'\'');
                $('#queryText').val(querytext);
                var qtext = data.QueryText.replace('[Over]', 'Over');
                hdnQueryText = querytext;
                BindBasicFilters(qtext, module);
                $('#PMProjectReviewClearAllFilter').css("display", "inline-block");

            }

            ApplyFlter();
            getMyFilters();
          
        }

        function setfiltername(fname) {
           
            if (fname != null && fname != '') {
                if (fname.length > 30) {
                    $('#appliedfiltername').html(fname.substr(0, 30) + '...');
                }
                else {
                    $('#appliedfiltername').html(fname);
                }
                $('#appliedfiltername').attr("title", fname);
                $('#lblAppliedFilter').css("visibility", 'visible');
                $('#btnClearAllFilters').css("display", "inline-block");
                if ($("#btnAdvancedFilter").hasClass("collapsed")) {
                    $("#btnAdvancedFilter").removeClass("collapsed");
                }
                $(".filter").addClass("active");
                $('#lblOpenProjectNote').css("visibility", 'hidden');
            }
            else {
                $('#appliedfiltername').html('');
                $('#lblAppliedFilter').css("visibility", 'hidden');
                $('#btnClearAllFilters').css("display", "none");
                if (!$("#btnAdvancedFilter").hasClass("collapsed")) {
                    $("#btnAdvancedFilter").addClass("collapsed");
                }
                $(".filter").removeClass("active");
                $('#lblOpenProjectNote').css("visibility", 'visible');
            }
        } 

        function SetDefault(qid, flag) { 
            if (flag == "default") {
                qid = 0;
            } 
            var projectParameters = {
                QueryID: qid,
                LoginType: loginType,
                intEmployeeID: EmployeeID,
            }
            var param = JSON.stringify(projectParameters); 
            var strResult = AJAXCallWithResult("/api/HelpdeskViewSetting/SetDefaultFilter", param, false);
            if (strResult != undefined)
            {
                if (strResult == "Success")
                {
                    gApplyfilterAlert = 1;
                    alertify.set('notifier', 'position', 'top-right');
                    if (qid != 0) {
                        EditFilter(qid);
                        ApplyFlter();
                        alertify.notify('<%= MyBase.GetResourceString("A_DefaultFilter") %>', 'success');
                        //$('#AdvanceFilterIcon').attr("aria-expanded", true);
                    }
                    else {
                        HelpdeskViewDetails('');
                        alertify.notify('<%= MyBase.GetResourceString("A_DefaultFilterremoved") %>', 'success');
                        FilterNotApplied();
                        //$('#AdvanceFilterIcon').attr("aria-expanded", false);
                    }
                }
                getMyFilters();
            }
        }

        function FilterApplied() {
             
            $(".clearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");
            $('#AdvanceFilterIcon').attr("aria-expanded", true);
        }

        function FilterNotApplied() {
            $(".clearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIcon').attr("aria-expanded", false);
        }

        function EditFilter(qid) {

            for (i = 0; i < AllEmpFilter.length; i++) {
                $("#CboFltr" + AllEmpFilter[i]).val(0);

            }

            $('#MyFiltersdropdown').modal('hide');
     
            var Qid = qid;            
            var qtext = '';
            var projectParameters = {
                QueryID: Qid
            }
            var param = JSON.stringify(projectParameters);           
            var data = AJAXCallWithResult("/api/HelpdeskViewSetting/GetFilterById", param, false);
          
            if (data != undefined) {
                $('#txtFltrName').val(data.FilterName);
                $('#newfiltername').val(data.FilterName);
                //$('#lblBasicFilterEdit').css('visibility', 'visible');
                //$('#lblBasicFilterEdit').text(data.FilterName);
                currentFilterID = data.FilterID;
                qtext = data.QueryText.replace('[Over]', 'Over');
                $("#basicfilters").addClass('active');
            }
            if (qtext != '') {
                hdnQueryText = qtext;
                BindBasicFilters(qtext, module);
                $('#tabBasicFilter').addClass('active');
                $('#basicfilter').addClass('active');
                $('#tabMyFilter').removeClass('active');
            }
        }



        function BindBasicFilters(qtext, module) {
            //ClearBasicFilter(module);
            var isAnd = qtext.indexOf(' AND ');
            if (isAnd > 0) {
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
            var val1 = "";
            var valstr = ""; 

            var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
            var opchar = opstr.substr(0, 1);
            
            op = opstr.substr(0, opstr.indexOf(' '));
            valstr = opstr.substr(op.length, opstr.length).trim();
            val1 = valstr.substr(1, valstr.length - 2);
            val1 = val1.replace('"', '');
            if (opchar == '=')
            {
                var cbo = "Cbo" + module + field; 
              $('#' + cbo).val(val1);
           
            }
        }

        function DeleteFilter(qid) {
            var Qid = qid;
            var setqid = $('#appliedfilter').val();
            parameter = {
                QueryID: Qid
            }
            $.ajax({
                url: strUrl + '/api/HelpdeskViewSetting/DeleteFilter',
                method: 'Post',
                data: JSON.stringify(parameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Helpdesk"));
                    if (parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(parameter) ? parameter : JSON.stringify(parameter)));

                    }
                },
                success: function (result) {
                
                    if (result != undefined) {
                        if (result == "Success") {
                           
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('<%= MyBase.GetResourceString("A_Filterdeletedsuccessfully") %>', 'success');
                            getMyFilters();
                            clearAll();

                            if (qid == setqid) {
                                $('#btnClearAllFilters').click();
                              
                            }
                           
                        }
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        function clearAll() {
        
            for (i = 0; i < AllEmpFilter.length; i++) {
                $("#CboFltr" + AllEmpFilter[i]).val(0);
             
            }
            FilterNotApplied();
            $('.custom_chckbox_markblue input[type="checkbox"]').not(this).prop('checked', false).parents('#MyFiltersdropdown li').removeClass('activefilter');
            $("#txtFltrName").val('');
            HelpdeskViewDetails('');
            $("#PMProjectReviewClearAllFilter").hide();
            $("#filterpanel").removeClass("clsShowHide");
            $("#filterpanel").removeClass("show");
            $(".filter").removeClass("active");
            selectedqid = "";
            getMyFilters();

        }
        var ajaxResult = "";
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Helpdesk"));
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


    </script>

</body>
</html>
