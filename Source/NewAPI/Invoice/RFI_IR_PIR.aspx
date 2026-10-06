<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RFI_IR_PIR.aspx.vb" Inherits="Whizible.RFI_IR_PIR" %>

<!DOCTYPE html>
<html>
                 <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("IR-PIR")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>IR-PIR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css"> -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
 <!-- Added By Madhuri.K On 01-04-2026 -->
 <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">


</head>
    <style type="text/css">

           /* Added by Vyankat Bhure on 1st April 2026 for aligning Select Project section */
        .project-section {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        /* End of added by Vyankat Bhure on 1st April 2026 */

        .Tblwrapper{
            overflow-x: hidden;
        }
        .dataTables_paginate {
            /*position: sticky;*/
            bottom: 0;
            background-color: #FFF;
            padding: 10px 0;
        }
        
       /* Added Ajit L on 29/12/2023 Start*/
        #MilestoneTable_wrapper .dataTables_paginate{
             position: relative;
        }
       
        #DeliverablesTable_wrapper .dataTables_paginate{
             position: relative;
        }
         /*end of    Added Ajit L on 29/12/2023 Start*/

        .red-text {
            color: darkred;
            font-weight: bold;
        }

        @media (min-width: 992px) {
            #ProjectTimesheetModal .modal-xl {
                --bs-modal-width: 981px;
            }
        }

        #PIRstatushistoryTbl .dataTables_sizing {
            height: 40px !important;
            overflow: visible !important;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .dataTables_paginate {
            float: unset !important;
            text-align: right;
        }

        /*.custmodal  {
            overflow: hidden;
        }*/

        .table-container {
            overflow: hidden;
            overflow-y: auto;
            height: 400px;
        }

        .stickyTblHeader th {
            position: sticky;
            top: 0;
            background-color: #f2f2f2;
            z-index: 1;
        }
       /* Added & Commented ruby Ajit label on 29/12/2023 Start*/
       /* #deleteIRModal .modal-header {
            background-color: #ff0000;
        }*/
        #deleteIRModal .modal-header {
        background-color: #f1170c;
        }
        /* Added & Commented ruby Ajit label on 29/12/2023 Start*/
        #txtDelete {
            display: block;
            text-align: center;
        }

        .ShowHideDiv {
            display: none !important;
        }

        .blue-text {
            font-size: 11.5px;
            color: #1359a6;
            font-weight: bold;
        }



        table.dataTable thead > tr > th.sorting::before, table.dataTable thead > tr > th.sorting::after, table.dataTable thead > tr > th.sorting_asc::before, table.dataTable thead > tr > th.sorting_asc::after, table.dataTable thead > tr > th.sorting_desc::before, table.dataTable thead > tr > th.sorting_desc::after, table.dataTable thead > tr > th.sorting_asc_disabled::before, table.dataTable thead > tr > th.sorting_asc_disabled::after, table.dataTable thead > tr > th.sorting_desc_disabled::before, table.dataTable thead > tr > th.sorting_desc_disabled::after, table.dataTable thead > tr > td.sorting::before, table.dataTable thead > tr > td.sorting::after, table.dataTable thead > tr > td.sorting_asc::before, table.dataTable thead > tr > td.sorting_asc::after, table.dataTable thead > tr > td.sorting_desc::before, table.dataTable thead > tr > td.sorting_desc::after, table.dataTable thead > tr > td.sorting_asc_disabled::before, table.dataTable thead > tr > td.sorting_asc_disabled::after, table.dataTable thead > tr > td.sorting_desc_disabled::before, table.dataTable thead > tr > td.sorting_desc_disabled::after {
            display: none;
            cursor: none;
        }

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
        }

        body::-webkit-scrollbar {
            display: none;
        }

        .btn-default {
            background-color: #f4f4f4;
            color: #444;
            border-color: #ddd;
        }

            .btn-default:hover,
            .btn-default:active,
            .btn-default.hover {
                background-color: #e7e7e7;
            }

        .table thead tr th span {
            display: inline;
        }

        h5.pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px
        }

        .form-group label {
            line-height: 1.2;
        }

        .custmodal .modal-content .modal-body {
            padding: 9px;
        }

        .IRPIR_Table thead tr th:nth-child(10) {
            min-width: 130px;
        }

        .dblock {
            display: block;
        }

        .mb-1 {
            margin-bottom: 10px
        }

        .toplinks {
            border-top: 1px solid #eee;
        }

        .topfltr .form-group select.form-control,
        .topfltr .form-group select.form-control {
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

        .PIRinfo {
            margin-top: 0;
            border: none;
            padding: 0;
            border-radius: 4px
        }

            .PIRinfo .custom_chckbox label:before {
                margin-right: 10px
            }

            .PIRinfo a {
                text-decoration: underline
            }

            .PIRinfo label {
                text-align: right;
                padding-right: 0
            }

        .nostylebtn {
            background: none;
            border: none
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
            z-index: 9999 !important;
        }

        .pr0 {
            padding-right: 0;
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
            margin: 0px 10px 0px 0px !important;
        }

        table tr th,
        table tr td {
            text-align: center !important
        }

            table tr th:last-child,
            table tr td:last-child {
                text-align: center;
            }

        .modalDTtabl {
            width: 100% !important;
        }

        .stastusbtn {
            display: block;
            cursor: auto;
        }

        .actionTD a {
            margin: 0px 5px;
        }
 #IRPIR_ChangeStatusModal .form-select{
            background-image: unset;
        }

        .bootstrap-select .dropdown-menu{
            max-width: 100%;
        }

        #SalesPeriodModal .modal-xl {
          --bs-modal-width: 930px;
        }
        


        .table-fixed-header thead tr th, .table thead tr th {
            font-size: 11.5px;
        }

        .table-fixed-header tbody tr th, .table tbody tr td {
            font-size: 11.5px;
        }

        /*Added by Vishal Mane on 29/12/23 stop solve data-table command bottom margin issue.*/
        table.table.table-bordered.completiontbl {
            margin-bottom: 0;
        }

      /*Added by Ajit on 05/01/2024*/
     
       @media (min-width: 500px) {
            #ProjMilestoneModal .modal-lg {
                --bs-modal-width: 981px;
            }
       }

        @media (min-width: 500px) {
            #ProjDeliverablesModal .modal-lg {
                --bs-modal-width: 981px;
            }
        }


          @media (min-width: 500px) {
            #IR_ShowHistorymodal .modal-lg {
                --bs-modal-width: 981px;
            }
          }
          /* End of Added by Ajit on 05/01/2024*/

        /* Added by Ajit on 08/01/2024*/
          #IRPIR_StatHistorymodal .dataTables_paginate{
              position:relative
          }
          /* End of Added by Ajit on 08/01/2024*/
    </style>

<body class="hold-transition bgwhite sidebar-mini fixed" id="RFI_MainBody">
    <%If m_blnViewAccess = True Then%>
    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 text-end graybg d-flex justify-content-between">
            <h5 class="pgtitle">Project Financials</h5>
            <input id="txtClearID" hidden />
            <div class="clearFilter d-flex">
                <a href="javascript:;" class="clearalllink pe-3" onclick="clearAll()" id="PMProjectReviewClearAllFilter"
                    data-bs-toggle="tooltip" data-bs-placement="bottom" title="Clear All"><strong><%=MyBase.GetResourceString("C_ClearAll")%></strong></a>
                <div class="filter inline">
                    <button data-bs-toggle="collapse" data-bs-target="#IR_Filterpanel" aria-expanded="false"
                        id="AdvanceFilterIcon" autocomplete="off">
                        <i class="fas fa-filter" data-bs-toggle="tooltip"
                            title="Filter"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <!--filter panel-->
        <div id="IR_Filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="nav-item dropdown" data-bs-toggle="tooltip" title="My Filters">
                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"
                                aria-expanded="false"><%=MyBase.GetResourceString("C_MyFilters")%></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                            </ul>
                        </li>
                        <li class="nav-item active" data-bs-toggle="tooltip" title="Basic Filters">
                            <a class="nav-link" href="#IR_BasicFilters" data-bs-toggle="tab" aria-expanded="true"><%=MyBase.GetResourceString("C_BasicFilters")%></a>
                        </li>
                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="IR_BasicFilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn"><%=MyBase.GetResourceString("C_SaveApply")%></button>
                                    <button class="btn btnyellow" onclick="ApplySavedFilter()"><%=MyBase.GetResourceString("C_Apply")%></button>
                                    <%--<button class="btn btnyellow" onclick="ApplyData()"><%=MyBase.GetResourceString("C_Apply")%></button>--%>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-sm-8">
                                        <div class="IRPIR_filterSec pt-3">
                                            <div class="row">
                                                <div class="col-12 col-sm-6 form-group mb-3" hidden>
                                                    <div class="row">
                                                        <label for="txtFilterID" class="col-sm-4"></label>
                                                        <div class="col-sm-8">
                                                            <input id="txtFilterID" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3" hidden>
                                                    <div class="row">
                                                        <label for="txtFilterName1" class="col-sm-4"></label>
                                                        <div class="col-sm-8">
                                                            <input id="txtFilterName1" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <label for="ProjectNameFilter" class="col-sm-4"><%=MyBase.GetResourceString("C_ProjectName")%></label>
                                                        <div class="col-sm-8">
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectFilter", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "onchange='PlotFilterProjetChange();' class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_Amount" class="col-sm-4"><%=MyBase.GetResourceString("C_Amount")%></label>
                                                        <div class="col-sm-8">
                                                            <div class="row">
                                                                <div class="col-sm-6 pe-0">
                                                                    <%--<input id="Fil_Amount" type="text" class="form-control" />--%>
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("Fil_Amount", "Fil_Amount", "form-control",,,,,,,,,, "onkeypress='return restrictDecimalNumeric(event)' onpaste='return false' ondrop='return false' autocomplete='Off' maxlength='200'",,, True,,,, True) %>
                                                                </div>
                                                                <div class="col-sm-6 ps-0">
                                                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboCurrencyFilter", "usp_Whizible2_Sel_tbl_PM_CurrencyMaster",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_IRID" class="col-sm-4"><%=MyBase.GetResourceString("C_IRID")%></label>
                                                        <div class="col-sm-8">
                                                            <%--<input id="Fil_IRID" type="text" class="form-control" />--%>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("Fil_IRID", "Fil_IRID", "form-control",,,,,,,,,, "onkeypress='return restrictNumericFilter(event)' onpaste='return false' ondrop='return false' autocomplete='Off' maxlength='200'",,, True,,,, True) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_IRPIR" class="col-sm-4"><%=MyBase.GetResourceString("C_IR_PIR1")%></label>
                                                        <div class="col-sm-8">
                                                            <%--<select class="selectpicker" data-live-search="true"
                                                                id="Fil_IRPIR">
                                                                <option>Select IR/PIR</option>
                                                                <option>IR</option>
                                                                <option>PIR</option>
                                                            </select>--%>
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboIRPIRFilter", "usp_Whizible2_Sel_IR_PIR",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_RaisedOnDate" class="col-sm-4"><%=MyBase.GetResourceString("C_RaisedOn")%></label>
                                                        <div class="col-sm-6">
                                                            <!-- <input id="Fil_RaisedOn" type="text" class="form-control" /> -->
                                                            <div class="input-group">
                                                                <input id="Fil_RaisedOnDate" class="form-control" onkeypress='return restrictNumericFilters(event)'>  <%-- onkeypress event added by Ajit L on 20/12/2023--%>
                                                                <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button">
                                                                        <i
                                                                            class="fas fa-calendar-alt"></i>
                                                                    </button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_Status" class="col-sm-4"><%=MyBase.GetResourceString("C_Status")%></label>
                                                        <div class="col-sm-8">
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboStatusFilter", "usp_Whizible2_Sel_tbl_PM_RFIStatus",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_Type" class="col-sm-4"><%=MyBase.GetResourceString("C_Type")%></label>
                                                        <div class="col-sm-8">
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboTypeFilter", "usp_Whizible2_Sel_Type_IR_PIR",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="amtFilSection pt-3">
                                            <div class="row">
                                                <div class="col-12 col-sm-12 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_AmountCB" class="col-sm-6"><%=MyBase.GetResourceString("C_AmountCompanyBase")%></label>
                                                        <div class="col-sm-6">
                                                            <%--<input id="Fil_AmountCB" type="text" class="form-control" />--%>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("Fil_AmountCB", "Fil_AmountCB", "form-control",,,,,,,,,, "onkeypress='return restrictDecimalNumeric(event)' onpaste='return false' ondrop='return false' autocomplete='Off' maxlength='200'",,, True,,,, True) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_EquivAmount" class="col-sm-6"><%=MyBase.GetResourceString("C_EquivAmount")%></label>
                                                        <div class="col-sm-6">
                                                            <%--<input id="Fil_EquivAmount" type="text" class="form-control" />--%>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("Fil_EquivAmount", "Fil_EquivAmount", "form-control",,,,,,,,,, "onkeypress='return restrictDecimalNumeric(event)' onpaste='return false' ondrop='return false' autocomplete='Off' maxlength='200'",,, True,,,, True) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 form-group mb-3">
                                                    <div class="row">
                                                        <label for="Fil_EquivAmount" class="col-sm-6"><%=MyBase.GetResourceString("C_AmountCurrency")%></label>
                                                        <%--<div class="col-sm-6"> <%=MyBase.GetResourceString("C_INR")%> (<span class="INRCurncy"></span>)
                                                        </div>--%>
                                                        <div class="col-sm-6" id="Fil_EquivAmountSign">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>

                <div class="clearfix"></div>
            </div>
        </div>

        <div class="clearfix"></div>

        <!--end filter panel-->

        <!-- Main content -->
        <div class="content pt-0">
            <!-- Filters -->
            <div class="filtersSection" id="filterSec">
                <div class="pt-3 form-inline topfltr">
                    <div class="row">
                          <div class="col-sm-4">
                                 <%-- Added by Vyankat Bhure on 1st April 2026 for adding the label for Select Project --%>
                            <div class="project-section">                      
                            <label for="cboProject" style="color: #374151; font-size: 0.875rem; font-weight: 500; margin: 0; margin-right: 0.5rem; white-space: nowrap;">Select Project</label>
                             <%--commented and added by Aditya J. on 20-08-2026 for showing closed projects in dropdown--%>
                            <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ",'" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,,) %>--%>
                                <%=CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_WithSelected " & Session("intUserID") & ",'" & Session("LoginType") & "',1,0,'[Over] = ''0''','ProjectName ASC'," & IIf(String.IsNullOrEmpty(Convert.ToString(Session("intProjectID"))) OrElse Convert.ToString(Session("intProjectID")) = "0", "NULL", Session("intProjectID")),,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true' data-width='260px'",,,) %>
                                <%--End of commented and added by Aditya J. on 20-08-2026 for showing closed projects in dropdown--%>
                        </div>
                                 <%-- End of added by Vyankat Bhure on 1st April 2026 --%>
                               </div>

                        <div class="col-sm-8">
                            <div class="text-end float-end" style="cursor: auto;">
                                <%If m_blnAddAccess = True Then%>
                                <a href="javascript:;" class="btn borderbtn addnewbtn" id="AddNewIRBtn"
                                    data-bs-toggle="offcanvas"
                                    aria-controls="offcanvasWithBothOptions" onclick="AddNewIR()"><i class="fas fa-plus"></i>
                                    <span><%=MyBase.GetResourceString("C_AddNew")%></span>
                                </a>
                                <% End If %>
                                <%If m_blnDeleteAccess = True Then%>
                                <button class="btn borderbtn" id="DeleteIRBtn" onclick="ValidateIRPIRDelete()"><i class="far fa-trash-alt mx-2"></i><span><%=MyBase.GetResourceString("C_Delete")%></span></button>
                                <% End If %>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <hr />

                <!-- Top filters -->
                <div class="py-2 mb-1 col-sm-12 text-end toplinks lightGrey topFilters">
                    <div class="form-group mb-0">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="row form-group">
                                    <div class="col-sm-3 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_IR_PIR1")%></label>
                                    </div>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboIRPIR", "usp_Whizible2_Sel_IR_PIR",,, "onchange='GetIRPIRList();' class='selectpicker' data-live-search='true'",,,) %>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="row form-group">
                                    <div class="col-sm-3 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_Type")%></label>
                                    </div>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboType", "usp_Whizible2_Sel_Type_IR_PIR",,, "onchange='GetIRPIRList();' class='selectpicker' data-live-search='true'",,,) %>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="row form-group">
                                    <div class="col-sm-3 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_Status")%></label>
                                    </div>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_Sel_tbl_PM_RFIStatus",,, "onchange='GetIRPIRList();' class='selectpicker' data-live-search='true'",,,) %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- IR-PIR List View starts here -->
            <%--<div class="table-responsive">
            <table id="IRPIR_Tbl" class="table table-bordered IRPIR_Table" style="width:100%;">--%>
            <div class="Tblwrapper">

                <table id="IRPIR_Tbl" class="table table-bordered IRPIR_Table tbl_rsrsselection" style="width: 100%;">
                    <thead class="stickyTblHeader" id="IRPIR_Tbl_header">
                        <tr>
                            <%--<th><%=MyBase.GetResourceString("C_IRID")%></th>
                            <th><%=MyBase.GetResourceString("C_IR_PIR1")%></th>
                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_ProjectName")%></th>
                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_Type")%></th>
                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_RaisedOn")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_Amount")%></th>
                            <th class="col-sm-1" id="txtCorpCurrencyCode"></th>
                            <th class="col-sm-1" id="txtCompCurrencyCode"></th>
                            <th class=""><%=MyBase.GetResourceString("C_CopyIR")%></th>
                            <th class=""><%=MyBase.GetResourceString("C_Status")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_Print_IR_Report")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_PrintInvoice")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_SubmitIR")%></th>
                            <th class="mx-auto">
                                <div class="custom_chckbox text-center">
                                    <input id="IRCheckAll" class="chckHead" type="checkbox" />
                                    <label for="IRCheckAll"></label>
                                </div>
                            </th>--%>
                            <th><%=MyBase.GetResourceString("C_IRID")%></th>
                            <th><%=MyBase.GetResourceString("C_IR_PIR1")%></th>
                            <th  class="col-sm-3"><%=MyBase.GetResourceString("C_ProjectName")%></th>
                            <th  class="col-sm-2"><%=MyBase.GetResourceString("C_Type")%></th>
                            <th  class="col-sm-1"><%=MyBase.GetResourceString("C_RaisedOn")%></th>
                            <th  class="col-sm-2"><%=MyBase.GetResourceString("C_Amount")%></th>
                            <th id="txtCorpCurrencyCode" class="col-sm-2"></th>
                            <th id="txtCompCurrencyCode" class="col-sm-2"></th>
                            <%--//Commented By Dipali V On 21st Feb 2024 For Hide Copy Link--%>
                            <%--<th  class=""><%=MyBase.GetResourceString("C_CopyIR")%></th>--%>
                            <%--End of Commented By Dipali V On 21st Feb 2024 For Hide Copy Link--%>
                            <th  class=""><%=MyBase.GetResourceString("C_Status")%></th>
                            <th  class=""><i class="fas fa-print text-danger"></i>&nbsp<%=MyBase.GetResourceString("C_Print_IR_Report")%></th>
                            <th  class=""><i class="fas fa-print text-danger"></i>&nbsp<%=MyBase.GetResourceString("C_PrintInvoice")%></th>
                            <th  class=""><%=MyBase.GetResourceString("C_SubmitIR")%></th>
                            <th class="mx-auto">
                                <div class="custom_chckbox text-center">
                                    <input id="IRCheckAll" class="chckHead" type="checkbox" />
                                    <label for="IRCheckAll"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="IRPIR_Tbl_Body">
                    </tbody>
                </table>

                <div class="clearfix"></div>
            </div>
            <%--<div class="clearfix"></div>
                <div id="pagination" class="pagination-container float-end" ></div>
            <div class="clearfix"></div>--%>

            <!-- IR-PIR List View ends here -->
        </div>

        <!-- 1st Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="true" tabindex="-1"
            id="offcvsIRPIR_Add_Screen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center font-weight-600">
                               <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IR_PIR")%></h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="IRPIR_DetailAddTab" class="IRPIRdetailinfo">
                    <div class="row">
                        <div class="col-sm-6">&nbsp;</div>
                        <div class="col-sm-6">
                            <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                <%If m_blnAddAccess = True Then%>
                                <button class="btn btnyellow" id="saveAddIRBtn" onclick="CreateIR(0);"><%=MyBase.GetResourceString("C_Save")%></button>
                                <%End If %>
                                <button class="btn borderbtn" type="button" id="closeAddIRBtn" onclick="ClearAll();" data-bs-dismiss="offcanvas"
                                    aria-label="Close">
                                    <%=MyBase.GetResourceString("C_Close")%></button>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">
                          <small>      (<font color="red">*</font>
                                <%=MyBase.GetResourceString("C_Mandatory")%>)</small></label>
                        </div>
                    </div>
                    <div class="PIRinfo">
                        <div class="d-flex justify-content-around mb-4">
                            <div class="">
                                <input type="radio" id="IR_Add" name="fav_language" value="IR" checked>
                                <label for="IR_Add"><%=MyBase.GetResourceString("C_IR_Invoice_Request")%></label><br>
                            </div>
                            <div class="">
                                <input type="radio" id="PIR_Add" name="fav_language" value="PIR">
                                <label for="PIR_Add"><%=MyBase.GetResourceString("C_PIR_Proforma_Invoice_Request")%></label><br>
                            </div>
                        </div>
                        <div class="addIRContent">
                            <div class="row form-group mt-3">
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="lb_projectname required"><%=MyBase.GetResourceString("C_Type")%></label>
                                        </div>
                                        <div class="col-sm-8  text-start">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRFIType", "select 0,'select Type'",,, "class='selectpicker custSelect ' data-live-search='true' ",,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="lb_Commercial required"><%=MyBase.GetResourceString("C_Creditdays")%></label>
                                        </div>
                                        <div class="col-sm-4 text-start">
                                            <%--<input type="text" class="form-control" id="input_ouWorking" />--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtCreditDays", "txtCreditDays", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPressCheck(event,this.id)' onpaste='return false' ondrop='return false' autocomplete='Off' maxlength='4'",,, True,,,, True) %>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row form-group mt-3">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row mb-1">
                                                <div class="col-sm-4 text-end">
                                                    <label class=" required "><%=MyBase.GetResourceString("C_Customer")%></label>
                                                </div>
                                                <div class="col-sm-8 pr-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "select 0,'select Customer'",,, "class='selectpicker custSelect ' data-live-search='true' onchange='ShowLink(0);' Disabled ",,,) %>

                                                    <a href="javascript:;" id="linkCustAddress" class="linkTxt textUndrln"
                                                        onclick="GetCustomerAddress(0);">
                                                        <span data-bs-toggle="tooltip"
                                                            title="Select Customer Address"><%=MyBase.GetResourceString("C_SelectCustomerAddress")%></span>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="required"><%=MyBase.GetResourceString("C_Currency")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                            <label class="mt-1" id="lblCurrencyAdd"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row form-group mt-3">
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="required lb_ouWorking"><%=MyBase.GetResourceString("C_ContactPerson")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboContactPer", "select 0,'select Contact Person'",,, "class='selectpicker custSelect ' data-live-search='true'  onchange='GetContactEmailID(this.value, 0);'",,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="required crsrLink"><%=MyBase.GetResourceString("C_SalesPeriod")%></label>
                                        </div>
                                        <div class="col-sm-6">
                                            <%-- <input type="text" class="form-control" id="input_Working_Hr" />--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtSalesPeriod", "txtSalesPeriod", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                            <input type="hidden" class="form-control" id="txthdnSalesPeriod" />
                                             <input type="hidden" class="form-control" id="txthdnContract" />
                                             <input type="hidden" class="form-control" id="txthdnIRID" />
                                        </div>
                                        <div class="col-sm-2 mt-1">
                                            <a href="javascript:;" data-bs-toggle="modal" onclick="GetRFISalesPeriod();"
                                                data-bs-target="#SalesPeriodModal">
                                                <i class="fa fa-link" aria-hidden="true" style="margin: 5px -17px 0;"
                                                    data-bs-toggle="tooltip" title="Select Sales Period"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row form-group mt-3">
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class=""><%=MyBase.GetResourceString("C_Emailconfirm")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmail_Confirm", "txtEmail_Confirm", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                            <%--<input type="text" class="form-control" id="Email_Confirm" />--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">

                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="control-label"><%=MyBase.GetResourceString("C_SalesPerson")%></label>
                                        </div>
                                        <div class="col-sm-6 pr-0">
                                            <%-- <input type="text" class="form-control" id="SalesPerson" />--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtSalesPerson", "txtSalesPerson", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                            <input type="hidden" class="form-control" id="txthdnSalesPer" />
                                        </div>
                                        <div class="col-sm-2 mt-1">
                                            <a href="javascript:;" data-bs-toggle="modal"
                                                data-bs-target="#SalesPersonModal" onclick="GetRFISalesPerson();">
                                                <i class="fa fa-link" aria-hidden="true" style="margin: 5px -17px 0;"
                                                    data-bs-toggle="tooltip" title="Select Sales Person"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row form-group mt-3">
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 mt-1 text-end">
                                            <label class="required control-label"><%=MyBase.GetResourceString("C_Contract")%></label>
                                        </div>
                                        <div class="col-sm-6 pr-0">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtContract", "txtContract", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                            <input type="hidden" id="TexthiddenContract" />
                                            <a href="javascript:;" class="linkTxt textUndrln" id="linkContractdetails" onclick="ShowContractDetails();">
                                                <span data-bs-toggle="tooltip" title="Show Details"><%=MyBase.GetResourceString("C_ShowDetails")%></span>
                                            </a>
                                        </div>
                                        <div class="col-sm-2 mt-1">
                                             <%--Commented and added by Vishal Mane on 29/12/23 to get alert of 'Please select the customer' for contract--%>
                                            <%--<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ContractDetailsModal" onclick="GetContractDetails(0);  GetRFIContractType();">--%>
                                            <a href="javascript:;" data-bs-toggle="modal" id="txtContractDetail">                                            
                                                <i class="fa fa-link" aria-hidden="true" style="margin: 5px -17px 0;"
                                                    data-bs-toggle="tooltip" title="Select Contract Details"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="lb_Site_Validation required"><%=MyBase.GetResourceString("C_IRItemsHeader")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                           <%-- <textarea class="form-control" id="txtAItemHead" maxlength="2000"></textarea>--%>
                                             <%CommonFunctions.HTMLControls.DrawTextArea("txtAItemHead", "txtAItemHead", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='2000' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%> 
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="row form-group mt-3">
                                <div class="col-sm-6">
                                    <div class="row mb-1">
                                        <div class="col-sm-4 text-end">
                                            <label class="required lb_invoice"><%=MyBase.GetResourceString("C_InvoiceConversionDate")%></label>
                                        </div>
                                        <div class="col-sm-5 text-start">
                                            <div class="input-group datefielddiv">
                                                <input id="toDateFilter" type="text" class="form-control">
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button">
                                                        <i
                                                            class="fas fa-calendar-alt icon_style"></i>
                                                    </button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 1st Section ends -->

        <!-- 2nd Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="true" tabindex="-1"
            id="offcvsIRPIR_Edit_Screen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center font-weight-600">
                               <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IR_PIR")%></h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="IRPIR_DetailEditTab" class="IRPIR_EditDetailinfo">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="row d-flex">
                                <div class="col-sm-3 text-end pe-0">
                                    <label><%=MyBase.GetResourceString("C_IRIDEdit")%></label>
                                </div>
                                <div class="col-sm-4">
                                    <input id="IR_ID_Filter" type="text" class="form-control">
                                </div>
                                <div class="col-sm-5">
                                    <a href="javascript:;" id="showEditIRBtn" class="textUndrln"
                                        data-bs-toggle="tooltip" title="Show"><%=MyBase.GetResourceString("C_Show")%></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-9 d-flex justify-content-end">
                            <div class="nextBtnDiv">
                                <button class="btn borderbtn" id="ViewChecklistEditIRBtn1" data-bs-toggle="modal"
                                    data-bs-target="#SubmitIRModal">
                                    <span><%=MyBase.GetResourceString("C_ViewChecklist")%></span></button>
                                <button class="btn borderbtn" id="ShowHisEditIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#IR_ShowHistorymodal">
                                    <span><%=MyBase.GetResourceString("C_ShowHistory")%></span></button>
                                <button class="btn borderbtn" type="button" data-bs-dismiss="offcanvas"
                                    aria-label="Close">
                                    <%=MyBase.GetResourceString("C_Close")%></button>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">
                                    <small>      (<font color="red">*</font>
                                <%=MyBase.GetResourceString("C_Mandatory")%>)</small></label>
                        </div>
                    </div>

                    <div class="accordion Off_acordian_panel mb-3 mt-3 " id="EditDetailsAcc">
                        <div class="accordion-item mb-3">
                            <h2 class="accordion-header" id="EditDetailsHeading">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#EditDetailsTab" aria-expanded="true" aria-controls="collapseOne">
                                    <%=MyBase.GetResourceString("C_Details")%>
                                </button>
                            </h2>
                            <div id="EditDetailsTab" class="accordion-collapse collapse show"
                                aria-labelledby="EditDetailsHeading" data-bs-parent="#EditDetailsAcc">
                                <div class="accordion-body">
                                    <div class="d-flex justify-content-around mb-4">
                                        <div class="">
                                            <input type="radio" id="IR_Edit" name="fav_language" value="IR">
                                            <label for="IR_Edit"><%=MyBase.GetResourceString("C_IR_Invoice_Request")%></label><br>
                                        </div>
                                        <div class="">
                                            <input type="radio" id="PIR_Edit" name="fav_language" value="PIR">
                                            <label for="PIR_Edit"><%=MyBase.GetResourceString("C_PIR_Proforma_Invoice_Request")%></label><br>
                                        </div>
                                    </div>

                                    <div class="editContent mb-3">
                                        <div class="row form-group mt-3">
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class="lb_projectname"><%=MyBase.GetResourceString("C_Type")%></label>
                                                    </div>
                                                    <div class="col-sm-8  text-start">
                                                        <label><%=MyBase.GetResourceString("C_Invoicing")%></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class="lb_Commercial"><%=MyBase.GetResourceString("C_Creditdays")%></label>
                                                    </div>
                                                    <div class="col-sm-8 text-start">
                                                        <label>30</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row form-group mt-2">
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-4 text-end">
                                                                <label class=" required "><%=MyBase.GetResourceString("C_Customer")%></label>
                                                            </div>
                                                            <div class="col-sm-8 pr-0">
                                                                <div>
                                                                    <label class="mb-0">Indian Blue Mart</label>
                                                                </div>
                                                                <div>
                                                                    <a href="javascript:;" class="linkTxt textUndrln"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#Select_Customer_Address">
                                                                        <span data-bs-toggle="tooltip"
                                                                            title="Select Customer Address"><%=MyBase.GetResourceString("C_SelectCustomerAddress")%></span>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class="required"><%=MyBase.GetResourceString("C_Currency")%></label>
                                                    </div>
                                                    <div class="col-sm-8 text-start">
                                                        <label class="">INR (<span class="INRCurncy"></span>)</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row form-group mt-2">
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class="required lb_ouWorking"><%=MyBase.GetResourceString("C_ContactPerson")%></label>
                                                    </div>
                                                    <div class="col-sm-8 text-start">
                                                        <label class="">IBM Mart</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class="required crsrLink"><%=MyBase.GetResourceString("C_SalesPeriod")%></label>
                                                    </div>
                                                    <div class="col-sm-8 text-start">
                                                        <label class="">2022/001</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row form-group mt-2">
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class=""><%=MyBase.GetResourceString("C_Emailconfirm")%></label>
                                                    </div>
                                                    <div class="col-sm-8 text-start">
                                                        <label class="">ibm@gmail.com</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">

                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class="control-label"><%=MyBase.GetResourceString("C_SalesPerson")%></label>
                                                    </div>
                                                    <div class="col-sm-8 pr-0">
                                                        <label class="">Admin</label>
                                                    </div>
                                                    <!-- <div class="col-sm-3">
                                                        <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#SalesPersonModal">
                                                            <i class="fa fa-link" aria-hidden="true" style=" margin: 5px -17px 0;" data-bs-toggle="tooltip" title="Select Sales Person"></i>    
                                                        </a>
                                                    </div> -->
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row form-group mt-2">
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class=" required control-label"><%=MyBase.GetResourceString("C_Contract")%></label>
                                                    </div>
                                                    <div class="col-sm-8 pr-0">
                                                        <div>
                                                            <label class="mb-0">2023</label>
                                                        </div>
                                                        <div>
                                                            <a href="javascript:;" class="linkTxt textUndrln"
                                                                data-bs-toggle="modal" data-bs-target="#ShowDetailsModal">
                                                                <span data-bs-toggle="tooltip" title="Show Details"><%=MyBase.GetResourceString("C_ShowDetails")%></span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-4 text-end">
                                                        <label class="required lb_Site_Validation"><%=MyBase.GetResourceString("C_IRItemsHeader")%></label>
                                                    </div>
                                                    <div class="col-sm-8 text-start">
                                                        <label class=""></label>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="PIRinfo">
                        <div class="invoiceTabs d-flex">
                            <ul class="nav nav-tabs main_graybgtbs" id="WBSTabs" style="pointer-events: auto;">
                                <li class="nav-item"><a class="nav-link active" href="#TabInvoiceItems" rol="tab"
                                    data-bs-toggle="tab" id=""><span data-bs-toggle="tooltip" title="Invoice Items"><%=MyBase.GetResourceString("C_InvoiceItems")%></span></a>
                                </li>
                            </ul>
                            <!-- <div class="text-end" style="cursor: auto;">
                                <button type="button" class="btn borderbtn addnewbtn" id="AddNewIRBtn"
                                    data-bs-toggle="modal" data-bs-target="#AddNewIRModal"><i class="fas fa-plus"></i>
                                    <span data-bs-toggle="tooltip" title="Add New">Add New</span> </button>
                                <button class="btn borderbtn" id="DeleteIRBtn" onclick="" data-bs-toggle="tooltip" title="Delete">Delete</button>
                            </div> -->
                        </div>
                    </div>
                    <div class="tab-content mt-2">
                        <!--Invoice Items tab start here-->
                        <div id="TabInvoiceItems" class="tab-pane active table-responsive">
                            <table id="IRPIR_EditDetailsTbl" class="table table-bordered IRPIR_EdtDetlsTableC"
                                style="width: 100%;">
                                <thead class="stickyTblHeader">
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_SrNo")%></th>
                                        <th><%=MyBase.GetResourceString("C_Description")%></th>
                                        <th><%=MyBase.GetResourceString("C_Discount")%></th>
                                        <th><%=MyBase.GetResourceString("C_Quantity")%></th>
                                        <th><%=MyBase.GetResourceString("C_Rate")%>(<span class="INRCurncy"></span>)</th>
                                        <th><%=MyBase.GetResourceString("C_Amount")%>(<span class="INRCurncy"></span>)</th>
                                        <th><%=MyBase.GetResourceString("C_EquivINR")%>(<span class="INRCurncy"></span>) <%=MyBase.GetResourceString("C_AmountCorporateBase")%></th>
                                        <th><%=MyBase.GetResourceString("C_EquivINR")%>(<span class="INRCurncy"></span>) <%=MyBase.GetResourceString("C_AmountCompanyBase")%> </th>
                                        <th>
                                            <div class="custom_chckbox text-center">
                                                <input id="EdtCheck0" class="EdtChckHead" type="checkbox">
                                                <label for="EdtCheck0"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="IRPIR_EdtDetlsTableBodyC">
                                </tbody>
                                <tfoot id="IRPIR_EdtDetlsTablefootC">
                                    <tr class="lightGrey">
                                        <td><%=MyBase.GetResourceString("C_TotalAmount")%></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 2nd Section ends -->

        <!-- 3rd Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-90" data-bs-scroll="true" tabindex="-1"
            id="offcvsIRPIR_2ndEdit_Screen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center font-weight-600">
                                <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IR_PIR")%></h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="IRPIR_DetailEditTab" class="IRPIR_EditDetailinfo">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="row d-flex">
                                <div class="col-sm-4 text-end pe-0">
                                    <label><strong><%=MyBase.GetResourceString("C_IRIDEdit")%></strong></label>
                                </div>
                                <div class="col-sm-6">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtEdtbleIR_ID_Filter", "txtEdtbleIR_ID_Filter", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPressCheck(event,this.id)'autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='10'",,, True,,,, True) %>
                                  <%-- Added Onkeypress function to validate the field by Ajit L on 14/12/2023--%>
                                    <input id="EdtbleIR_ID_Status" type="text" class="form-control" hidden>
                                </div>
                                <div class="col-sm-2 ps-0">
                                    <a href="javascript:;" id="showEditblIRBtn" class="ShowIR_Btn"
                                        data-bs-toggle="tooltip" title="Show"><%=MyBase.GetResourceString("C_Show")%></a>
                                    <input type="text" id="txtEditCopyFlag" hidden="hidden">
                                    <%--hidden="hidden"--%>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-9 d-flex justify-content-end ps-0">
                            <div class="nextBtnDiv nextBtnEditDiv">
                               <%-- <%If m_blnEditAccess = True Or m_blnAddAccess = True Then%>--%>
                                <%--<button class="btn btnyellow" id="saveEditblIRBtn" onclick="CreateIR(1);"><%=MyBase.GetResourceString("C_Save")%></button>
                                <button class="btn btnyellow" id="submitIREditblBtn"><span><%=MyBase.GetResourceString("C_SubmitIR")%></span></button>
                                 <button class="btn btnyellow" id="ResubmitIREditblBtn"><span>Re-Submit IR</span></button>--%>
                              <%--  <%End If %>--%>
                                <%--<button class="btn borderbtn" id="projMS_EditblIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#ProjMilestoneModal" onclick="ShowMileStones()">
                                    <span><%=MyBase.GetResourceString("C_ProjectMilestones")%></span></button>--%>

                                <a href="javascript:;" class="textUndrln me-3" id="projMS_EditblIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#ProjMilestoneModal" onclick="ShowMileStones()"><span data-bs-toggle="tooltip"
                                        title="Add Project Milestones"><%=MyBase.GetResourceString("C_ProjectMilestones")%></span></a>                                

                                <%--<button class="btn borderbtn" id="projDlvrbl_EditblIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#ProjDeliverablesModal" onclick="ShowProjectDeliverables()">
                                    <span data-bs-toggle="tooltip"
                                        title="Project Deliverables"><%=MyBase.GetResourceString("C_ProjectDeliverables")%></span></button>--%>

                                 <a href="javascript:;" class="textUndrln me-3" id="projDlvrbl_EditblIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#ProjDeliverablesModal" onclick="ShowProjectDeliverables()"><span data-bs-toggle="tooltip"
                                        title="Add Project Deliverables"><%=MyBase.GetResourceString("C_ProjectDeliverables")%></span></a>

                               <%-- <button class="btn borderbtn" id="projExpsEditblIRBtn" onclick="GetCurrencyType(); GetResources(); GetCostHeads();  GetProExpStatusType(); ShowProjectExpense(); ">
                                    <span data-bs-toggle="tooltip"
                                        title="Project Expenses"><%=MyBase.GetResourceString("C_ProjectExpenses")%></span></button>--%>

                                <a href="javascript:;" class="textUndrln me-3" id="projExpsEditblIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#ProjExpensesModal" onclick="GetCurrencyType(); GetResources(); GetCostHeads();  GetProExpStatusType(); ShowProjectExpense();">
                                    <span data-bs-toggle="tooltip"
                                        title="Add Project Expenses"><%=MyBase.GetResourceString("C_ProjectExpenses")%></span></a>

                               <%-- <button class="btn borderbtn" id="ProjectTS_EditblBtn" data-bs-toggle="modal"
                                    data-bs-target="#ProjectTimesheetModal" onclick="ShowTimeSheet();">
                                    <span><%=MyBase.GetResourceString("C_ProjectTimesheet")%></span></button>--%>

                                <a href="javascript:;" class="textUndrln me-3" id="ProjectTS_EditblBtn" data-bs-toggle="modal"
                                    data-bs-target="#ProjectTimesheetModal" onclick="ShowTimeSheet();"><span data-bs-toggle="tooltip"
                                        title="Add Project Timesheet"><%=MyBase.GetResourceString("C_ProjectTimesheet")%></span></a>

                               <%-- <button class="btn borderbtn" id="ViewChecklistEditIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#SubmitIRModal">
                                    <span id="ViewChecklistEditIRBtnSpan"><%=MyBase.GetResourceString("C_ViewChecklist")%></span></button>--%>

                                <a href="javascript:;" class="textUndrln me-2" id="ViewChecklistEditIRBtn" data-bs-toggle="modal"
                                    data-bs-target="##SubmitIRModal">
                                     <span data-bs-toggle="tooltip"
                                        title="View Checklist" id="ViewChecklistEditIRBtnSpan"><%=MyBase.GetResourceString("C_ViewChecklist")%></span></a>
                                


                               <%-- <button class="btn borderbtn" id="ShowHisEditblIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#IR_ShowHistorymodal" onclick=" GetModifiedField(); GetModifiedBy(); ShowHistory();">
                                    <span><%=MyBase.GetResourceString("C_ShowHistory")%></span></button>--%>

                                 <a href="javascript:;" class="textUndrln me-2" id="ShowHisEditblIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#IR_ShowHistorymodal" onclick=" GetModifiedField(); GetModifiedBy(); ShowHistory();">
                                     <span data-bs-toggle="tooltip"
                                        title="Show History"><%=MyBase.GetResourceString("C_ShowHistory")%></span></a>

                                  <%If m_blnEditAccess = True Or m_blnAddAccess = True Then%>
                                <button class="btn btnyellow me-2" id="saveEditblIRBtn" data-bs-toggle="tooltip"
                                    title="Save" onclick="CreateIR(1);"><%=MyBase.GetResourceString("C_Save")%></button>
                             <%--   <button class="btn btnyellow me-2" id="submitIREditblBtn" data-bs-toggle="modal" data-bs-target="#SubmitIRModal"><span data-bs-toggle="tooltip" title="Submit IR"><%=MyBase.GetResourceString("C_SubmitIR")%></span></button>
                                 <button class="btn btnyellow me-2" id="ResubmitIREditblBtn" data-bs-toggle="modal" data-bs-target="#SubmitIRModal"><span data-bs-toggle="tooltip" title="Re-Submit IR">Re-Submit IR</span></button>--%>

                                   <button class="btn btnyellow me-2" id="submitIREditblBtn" data-bs-toggle="modal"><span data-bs-toggle="tooltip" title="Submit IR"><%=MyBase.GetResourceString("C_SubmitIR")%></span></button>
                                 <button class="btn btnyellow me-2" id="ResubmitIREditblBtn" data-bs-toggle="modal"><span data-bs-toggle="tooltip" title="Re-Submit IR">Re-Submit IR</span></button>
                                 <%End If %>

                               <%-- <button class="btn btnyellow me-2" id="saveEditblIRBtn" data-bs-toggle="tooltip"
                                    title="Save">Save</button>
                                <button class="btn btnyellow me-2" id="submitIREditblBtn" data-bs-toggle="modal" data-bs-target="#SubmitIRModal">
                                    <span data-bs-toggle="tooltip" title="Submit IR">Submit IR</span></button>
                                <button class="btn borderbtn" type="button" id="closeEditblIRBtn" data-bs-dismiss="offcanvas"
                                    data-bs-toggle="tooltip" title="Close" aria-label="Close">Close</button>--%>

                                <button class="btn borderbtn" type="button" id="closeEditblIRBtn" data-bs-dismiss="offcanvas"
                                    data-bs-toggle="tooltip" title="Close" aria-label="Close">
                                    <%=MyBase.GetResourceString("C_Close")%></button>
                            </div>
                        </div>
                    </div>
                    <div id="ShowHideEditDiv">
                        <div class="row d-flex ">
                            <div class="col-sm-6 text-start">
                                <div class="row ">
                                    <div class="col-sm-3 text-start pe-0">
                                        <lable><strong>Project Name&nbsp;:</strong></lable>
                                    </div>
                                    <div class="col-sm-8 text-start">
                                        <lable id="lblProjectName"></lable>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 text-end">
                                <label class="form-label ">
                                    (<font color="red">*</font>
                                    <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                            </div>
                        </div>

                        <div class="accordion Off_acordian_panel mb-3 mt-3 " id="EditbleDetailsAcc">
                            <div class="accordion-item mb-3">
                                <h2 class="accordion-header" id="EditbleDetailsHeading">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#EditbleDetailsTab" aria-expanded="true"
                                        aria-controls="collapseOne">
                                        <%=MyBase.GetResourceString("C_Details")%>
                                    </button>
                                </h2>

                                <div id="EditbleDetailsTab" class="accordion-collapse collapse show"
                                    aria-labelledby="EditbleDetailsHeading" data-bs-parent="#EditbleDetailsAcc">
                                    <div class="accordion-body">
                                        <div class="d-flex justify-content-around mb-2">
                                            <div class="">
                                                <input type="radio" id="IR_AddE" name="fav_language" value="IR">
                                                <label for="IR_AddE"><%=MyBase.GetResourceString("C_IR_Invoice_Request")%></label><br>
                                            </div>
                                            <div class="">
                                                <input type="radio" id="PIR_AddE" name="fav_language" value="PIR">
                                                <label for="PIR_AddE"><%=MyBase.GetResourceString("C_PIR_Proforma_Invoice_Request")%></label><br>
                                            </div>
                                        </div>

                                        <div class="EditIRContent2 mb-4">
                                            <div class="row form-group mt-3">
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class="lb_projectname required"><%=MyBase.GetResourceString("C_Type")%></label>
                                                        </div>
                                                        <div class="col-sm-8  text-start">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRFITypeE", "select 0,'select Type'",,, "class='selectpicker custSelect ' data-live-search='true' ",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label for="EditblCreditDays"
                                                                class="lb_Commercial required">
                                                                <%=MyBase.GetResourceString("C_Creditdays")%></label>
                                                        </div>
                                                        <div class="col-sm-4 text-start">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtCreditDaysE", "txtCreditDaysE", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPressCheck(event,this.id)' onpaste='return false' ondrop='return false' autocomplete='Off' maxlength='4'",,, True,,,, True) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row form-group mt-3">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end">
                                                                    <label class="required"><%=MyBase.GetResourceString("C_Customer")%></label>
                                                                </div>
                                                                <div class="col-sm-8 pr-0">
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerE", "select 0,'select Customer'",,, "class='selectpicker custSelect ' data-live-search='true' onchange='ShowLink(1);' Disabled",,,) %>

                                                                    <a href="javascript:;" id="linkCustAddressE" class="linkTxt textUndrln"
                                                                        onclick="GetCustomerAddress(1);">
                                                                        <span data-bs-toggle="tooltip"
                                                                            title="Select Customer Address"><%=MyBase.GetResourceString("C_SelectCustomerAddress")%></span>
                                                                    </a>
                                                                </div>
                                                                <!-- <div class="col-sm-1">
                                                                <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#Select_Customer_Address">
                                                                    Select Customer Address
                                                                </a>
                                                            </div> -->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class="required"><%=MyBase.GetResourceString("C_Currency")%></label>
                                                        </div>
                                                        <div class="col-sm-8 text-start">
                                                            <%-- <label class="mt-1">INR (<span
                                                                class="INRCurncy"></span>)</label>--%>
                                                            <label class="mt-1" id="lblCurrencyE"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row form-group mt-3">
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class="required lb_ouWorking"><%=MyBase.GetResourceString("C_ContactPerson")%></label>
                                                        </div>
                                                        <div class="col-sm-8 text-start">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboContactPerE", "select 0,'select Contact Person'",,, "class='selectpicker custSelect ' data-live-search='true'  onchange='GetContactEmailID(this.value, 1);'",,,) %>
                                                            <%-- <select class="selectpicker" aria-label="Select Customer"
                                                            data-live-search="true" id="EditblContctPersn">
                                                            <option>Select Contact Person</option>
                                                            <option>Madhuri</option>
                                                            <option>Pratiksha</option>
                                                            <option>Sayali</option>
                                                        </select>--%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class="required crsrLink"><%=MyBase.GetResourceString("C_SalesPeriod")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtSalesPeriodE", "txtSalesPeriodE", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                                            <input type="hidden" class="form-control" id="txthdnSalesPeriodE" />
                                                            <%-- <input type="text" class="form-control"
                                                            id="EditblSalesPeriod" />--%>
                                                        </div>
                                                        <div class="col-sm-2 mt-1">
                                                            <a href="javascript:;" data-bs-toggle="modal" onclick="GetRFISalesPeriod();"
                                                                data-bs-target="#SalesPeriodModal">
                                                                <i class="fa fa-link" aria-hidden="true"
                                                                    style="margin: 5px -17px 0;" data-bs-toggle="tooltip"
                                                                    title="Select Sales Period"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row form-group mt-3">
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class=""><%=MyBase.GetResourceString("C_Emailconfirm")%></label>
                                                        </div>
                                                        <div class="col-sm-8 text-start">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEmail_ConfirmE", "txtEmail_ConfirmE", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                                            <%--   <input type="text" class="form-control"
                                                            id="EditblEmailConfrm" />--%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">

                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class="control-label"><%=MyBase.GetResourceString("C_SalesPerson")%></label>
                                                        </div>
                                                        <div class="col-sm-6 pr-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtSalesPersonE", "txtSalesPersonE", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                                            <input type="hidden" class="form-control" id="txthdnSalesPerE" />
                                                            <%--   <input type="text" class="form-control" id="EditblSalesPrsn" />--%>
                                                        </div>
                                                        <div class="col-sm-2 mt-1">
                                                            <a href="javascript:;" data-bs-toggle="modal"
                                                                data-bs-target="#SalesPersonModal" onclick="GetRFISalesPerson();">
                                                                <i class="fa fa-link" aria-hidden="true"
                                                                    style="margin: 5px -17px 0;" data-bs-toggle="tooltip"
                                                                    title="Select Sales Person"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row form-group mt-3">
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 mt-1 text-end">
                                                            <label class="required control-label"><%=MyBase.GetResourceString("C_Contract")%></label>
                                                        </div>
                                                        <div class="col-sm-6 pr-0">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtContractE", "txtContractE", "form-control",,,,,,,,,, "disabled autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                                            <input type="hidden" id="TexthiddenContractE" />
                                                            <%--   <input type="text" class="form-control" id="EditblContrct" />--%>
                                                            <%-- <a href="javascript:;" class="linkTxt textUndrln"
                                                            data-bs-toggle="modal" data-bs-target="#ShowDetailsModal">
                                                            <span data-bs-toggle="tooltip" title="Show Details">Show
                                                                Details</span>
                                                        </a>--%>
                                                            <a href="javascript:;" id="linkContractdetailsE" class="linkTxt textUndrln" onclick="ShowContractDetails(0);">
                                                                <span data-bs-toggle="tooltip" title="Show Details"><%=MyBase.GetResourceString("C_ShowDetails")%></span>
                                                            </a>
                                                        </div>
                                                        <div class="col-sm-2 mt-1">
                                                            <%--Commented and added by Vishal Mane on 29/12/23 to get alert of 'Please select the customer' for contract--%>
                                                            <%--<a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ContractDetailsModal" onclick="GetContractDetails(0);  GetRFIContractType();">--%>
                                                            <a href="javascript:;" data-bs-toggle="modal" id="txtContractDetailE">
                                                                <i class="fa fa-link" aria-hidden="true"
                                                                    style="margin: 5px -17px 0;" data-bs-toggle="tooltip"
                                                                    title="Select Contract Details"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class="lb_Site_Validation required"><%=MyBase.GetResourceString("C_IRItemsHeader")%></label>
                                                        </div>
                                                        <div class="col-sm-8 text-start">
                                                           <%-- Modified by vishal to limit 2000 characters on 18/12/23--%>
                                                            <%CommonFunctions.HTMLControls.DrawTextArea("txtAItemHeadE", "txtAItemHeadE", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='2000' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%> 
                                                         <%-- End of Modified by vishal to limit 2000 characters on 18/12/23--%> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row form-group mt-3">
                                                <div class="col-sm-6">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-4 text-end">
                                                            <label class="required lb_invoice"><%=MyBase.GetResourceString("C_InvoiceConversionDate")%></label>
                                                        </div>
                                                        <div class="col-sm-5 text-start">
                                                            <div class="input-group datefielddiv">
                                                                <input id="toDateFilterE" type="text" class="form-control" disabled>
                                                                <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button">
                                                                        <i
                                                                            class="fas fa-calendar-alt icon_style"></i>
                                                                    </button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <hr>

                        <div class="PIRinfo">
                            <div class="invoiceTabs d-flex">
                                <ul class="nav nav-tabs main_graybgtbs" id="WBSTabs" style="pointer-events: auto;">
                                    <li class="nav-item"><a class="nav-link active" href="#TabEditblInvoiceItems" rol="tab"
                                        data-bs-toggle="tab" id=""><span data-bs-toggle="tooltip"
                                            title="Invoice Items"><%=MyBase.GetResourceString("C_InvoiceItems")%></span></a></li>
                                </ul>
                                <div class="text-end" style="cursor: auto;">
                                    <!-- <a href="javascript:;" class="btn borderbtn addnewbtn" id="AddNewIRBtn" data-bs-toggle="modal" data-bs-target="#AddNewIRModal"><i class="fas fa-plus"></i> Add New</a> -->
                                    <%If m_blnEditAccess = True Or m_blnAddAccess = True Then%>
                                    <button type="button" class="btn borderbtn addnewbtn" id="AddNewIRItem" onclick="AddnewIrItem();"
                                        data-bs-toggle="modal" data-bs-target="#AddNewIRModal">
                                        <i class="fas fa-plus"></i>
                                        <span><%=MyBase.GetResourceString("C_AddNew")%></span>
                                    </button>
                                    <%End If %>
                                    <%If m_blnDeleteAccess = True Then%>
                                    <button class="btn borderbtn" id="DeleteIRItemBtn" onclick="DeleteIRPIRItems();"><i class="far fa-trash-alt mx-2"></i><span><%=MyBase.GetResourceString("C_Delete")%></span></button>
                                    <%End If %>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content mt-2">
                            <!--project Profitability tab start here-->
                            <div id="TabEditblInvoiceItems" class="tab-pane active">
                                <!-- <div class="row mb-2">
                                <div class="col-sm-6">
                                    &nbsp;
                                </div>
                                <div class="col-sm-6">
                                    <div class="text-end" style="cursor: auto;">
                                        <a href="javascript:;" class="btn borderbtn addnewbtn" id="AddNewIRBtn" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_Add_Screen" aria-controls="offcanvasWithBothOptions"><i class="fas fa-plus"></i> Add New</a>
                                        <button class="btn borderbtn" id="DeleteIRBtn" onclick="">Delete</button>
                                    </div>
                                </div>
                            </div> -->
                                <table id="IRPIR_EditblDetails" class="table table-bordered IRPIR_EdtDetlsTable"
                                    style="width: 100%;">
                                    <thead class="stickyTblHeader">
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_SrNo")%></th>
                                            <th><%=MyBase.GetResourceString("C_Description")%></th>
                                            <th><%=MyBase.GetResourceString("C_Discount")%></th>
                                            <th><%=MyBase.GetResourceString("C_Quantity")%></th>
                                            <th><%=MyBase.GetResourceString("C_Rate")%>(<span class="ItemCurncy"></span>)</th>
                                            <th><%=MyBase.GetResourceString("C_Amount")%>(<span class="ItemCurncy"></span>)</th>
                                            <th id="EquivCurrecnyCorp"><%=MyBase.GetResourceString("C_Equiv")%> (<span class="INRCurncyCorpB"></span>) <%=MyBase.GetResourceString("C_AmountCorporateBase")%> </th>
                                            <th id="EquivCurrecnyComp"><%=MyBase.GetResourceString("C_Equiv")%> (<span class="INRCurncyCompB"></span>) <%=MyBase.GetResourceString("C_AmountCompanyBase")%> </th>
                                            <th>
                                                <div class="custom_chckbox text-center">
                                                    <input id="EdtblCheck0" class="EdtblChckHead" type="checkbox">
                                                    <label for="EdtblCheck0"></label>
                                                </div>
                                            </th>

                                            <%--<th colspan="1">Sr.No.</th>
                                        <th colspan="2">Description</th>
                                        <th colspan="1">Discount</th>
                                        <th colspan="1">Quantity</th>
                                        <th colspan="1">Rate(<span class="INRCurncy"></span>)</th>
                                        <th colspan="1">Amount(<span class="INRCurncy"></span>)</th>
                                        <th colspan="2">Equiv. INR(<span class="INRCurncy"></span>) Amount (Corporate Base) </th>
                                        <th colspan="2">Equiv. INR(<span class="INRCurncy"></span>) Amount (Company Base) </th>
                                        <th colspan="1">
                                            <div class="custom_chckbox text-center">
                                                <input id="EdtblCheck0" class="EdtblChckHead" type="checkbox">
                                                <label for="EdtblCheck0"></label>
                                            </div>
                                        </th>--%>
                                        </tr>
                                    </thead>
                                    <tbody id="IRPIR_EdtDetlsTableBody">

                                        <%-- </tbody id="IRPIR_EdtDetlsfoot">--%>
                                    <tfoot id="IRPIR_EdtDetlsfoot">
                                        <%-- <tr class="lightGrey">
                                        <td>Total Amount</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>&nbsp;</td>
                                    </tr>--%>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div id="NotAuthDiv" class="tab-pane" style="height: 448px; display: none">
                        <div style="text-align: center">
                            <p style="margin-top: 136px; font-weight: 700;">You are not Authorized to view this Record! </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 3rd Section ends -->
    </div>
    <div class="clearfix"></div>
    <!-- modal pop up for Copy IR Confirmation starts here -->
    <div id="confirmCopyIRModal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" style="text-align: center;"><%=MyBase.GetResourceString("C_CopyIRPIRConfirmation")%></h4>
                </div>
                <div class="modal-body">
                    <div id="txtDrp1" class="text-center"><span id="txtRFIID" class="modalRFIID" hidden></span><span class="modalEditCopyFlag" hidden></span><%=MyBase.GetResourceString("C_Copy_IR")%></div>
                    <br />
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 text-left">
                            <button class="btn btnyellow ml-1 pull-right" onclick="NextResdetail()" style="float: right" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                        <div class="col-xs-6 col-sm-6">
                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal" id="okCopyBtn"><%=MyBase.GetResourceString("C_Ok")%></button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="clearfix"></div>
    </div>
        <!-- modal pop up for Copy IR Confirmation ends here -->

    <!-- modal pop up for delete IR starts here -->
    <div id="deleteIRModal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" style="text-align: center;"><%=MyBase.GetResourceString("C_DeleteStatus")%></h4>
                </div>
                <div class="modal-body">
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-12 text-center">
                                <span id="txtDelete" class="txtDeleteIRPIR"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-12 text-center">
                                <%--<button class="btn btnyellow ml-1 pull-right" style="float: right" data-bs-dismiss="modal">Cancel</button>--%>
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" id="deleteBtn"><%=MyBase.GetResourceString("C_Ok")%></button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- modal pop up for delete IR ends here -->

    <!-- IR-PIR Print report Section starts -->
    <div class="offcanvas offcanvas-end offcanvas-50" data-bs-scroll="true" tabindex="-1"
        id="offcanvas_ViewReport" aria-labelledby="offcanvas_View_reportLabel">
        <div class="offcanvas-body">
            <div id="View_Report_Details" class="View_Report_Details">
                <div class="View_Report_Details_Header d-flex justify-content-between">
                    <div class="Overlay-title"></div>
                    <div class="View_Report_Details_HeaderBtns">
                    </div>
                </div>
                <div class="graybg container-fluid pt-1 pb-1 mb-2">
                    <div class="row">
                        <div class="col-sm-12">
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ReportBuilder")%></h5>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2">
                    <div class="col-sm-12 ">
                        <div class="row">
                            <div class="col-sm-6">
                            </div>
                            <div class="col-sm-6 text-end">
                                <!-- <a href="javascript:;" class="btn borderbtn me-2" id="AddDshbordPRBtn" data-bs-toggle="modal" data-bs-target="#AddToDashboardModal">Add To Dashboard</a> -->
                                <button type="button" class="btn borderbtn closebtn text-end" id="IR_ReportCloseBtn"
                                    data-bs-dismiss="offcanvas">
                                    <%=MyBase.GetResourceString("C_Close")%>
                                </button>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="Print_Report_Details_content">
                    <div class="tab-content detailsmenutab">
                        <!--<%--Print_Report - Details --%>-->
                        <div class="tab-pane active" id="Print_Report_Tab">
                            <div class="BasicDetailsContent">
                                <div class="graybg py-2 mt-2 mb-3">
                                    <div class="row">
                                        <div class="col-sm-6 text-start">
                                            <strong><%=MyBase.GetResourceString("C_Invoice")%> </strong>
                                        </div>

                                        <div class="col-sm-6 text-end ">
                                            <!--<i data-bs-toggle="tooltip" data-bs-placement="bottom" data-title="Click here to download" class="fas fa-download" data-original-title="" title="" aria-describedby=""></i>-->
                                            <div class="dropdown filedownload float-end">
                                                <button type="button" class="nostylebtn dropdown-toggle"
                                                    data-bs-toggle="dropdown">
                                                    <i data-bs-toggle="tooltip"
                                                        title="Click here to Export" id="ExportDataPRBtn"
                                                        class="fas fa-download"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a href="#" id="txtPrintPdf" onclick="Export_PDFClick1('PDF')">
                                                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_Pdf")%></a></li>
                                                    <li><a href="#" onclick="Export_PDFClick1('HTML')">
                                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_Html")%></a></li>
                                                    <li><a href="#" onclick="Export_PDFClick1('RTF')">
                                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_RTF")%></a></li>
                                                    <li><a href="#" onclick="Export_PDFClick1('EXCEL')">
                                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_Excel")%></a></li>
                                                    <li><a href="#" onclick="Export_PDFClick1('CSV')">
                                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_CSV")%></a></li>
                                                    <li><a href="#" onclick="Export_PDFClick1('TEXT')">
                                                        <img src="../../../Whizible2.0-new/dist/img/doc.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_Text")%></a></li>
                                                    <li><a href="#" onclick="Export_PDFClick1('XML')">
                                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_XML")%></a></li>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="row form-group">
                                    <div class="col-sm-4 text-end">
                                        <label class="required"><%=MyBase.GetResourceString("C_InvoiceNumber")%></label>
                                    </div>
                                    <div class="col-sm-6">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboInvoiceNumber", "usp_Whizible2_Sel_tbl_PM_RFIInvoices",,, "class='selectpicker' data-live-search='true'",,,) %>
                                        <%--<select class="selectpicker" data-live-search="true">
                                            <option>Select Invoice Number</option>
                                            <option>44</option>
                                            <option>12</option>
                                            <option>10</option>
                                        </select>--%>
                                    </div>

                                    <div class="clearfix"></div>
                                </div>


                                <div class="container-fluid py-1 graybg clearfix bottom-note">
                                    <div class="float-start" id="IM_Program_Report_Footer">
                                        <span class="note-title"><%=MyBase.GetResourceString("C_Note")%></span><%=MyBase.GetResourceString("C_PrintNote")%>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- IR-PIR Print report Section ends -->

    <!-- Print Invoice(s) Section starts -->
    <div class="offcanvas offcanvas-end offcanvas-50" data-bs-scroll="true" tabindex="-1"
        id="offcanvas_PrintInvoice" aria-labelledby="offcanvas_View_reportLabel">
        <div class="offcanvas-body">
            <div id="View_Report_Details" class="View_Report_Details">
                <div class="View_Report_Details_Header d-flex justify-content-between">
                    <div class="Overlay-title"></div>
                    <div class="View_Report_Details_HeaderBtns">
                    </div>
                </div>
                <div class="graybg container-fluid pt-1 pb-1 mb-2">
                    <div class="row">
                        <div class="col-sm-12">
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_InvoiceList")%></h5>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 mb-2">
                    <div class="col-sm-12 ">
                        <div class="row">
                            <div class="col-sm-6">
                            </div>
                            <div class="col-sm-6 text-end">
                                <!-- <a href="javascript:;" class="btn borderbtn me-2" id="AddDshbordPRBtn" data-bs-toggle="modal" data-bs-target="#AddToDashboardModal">Add To Dashboard</a> -->
                              
                            <%--    <%If m_blnAddAccess = True Then%>
                                <button class="btn btnyellow" data-bs-dismiss="modal"
                                    id="savePrintInvoiceBtn">
                                    <%=MyBase.GetResourceString("C_Save")%></button>
                                <% End If%>--%>
                              <%--  Save button hidden by Ajit L on 20/12/2023 issue Id 36502--%>

                                <button type="button" class="btn borderbtn closebtn text-end"
                                    data-bs-dismiss="offcanvas">
                                    <%=MyBase.GetResourceString("C_Close")%>
                                </button>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="Print_Report_Details_content">
                    <div class="tab-content detailsmenutab">
                        <!--<%--Print_Report - Details --%>-->
                        <div class="tab-pane active" id="Print_Report_Tab">
                            <div class="BasicDetailsContent">
                                <div class="row mx-1 mb-2">
                                    <table
                                        class="table table-stripped table-bordered completiontbl printInvoiceTable mb-2"
                                        id="printInvoiceTbl" style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th><%=MyBase.GetResourceString("C_InvoiceID")%></th>
                                                <th><%=MyBase.GetResourceString("C_InvoiceNumber")%></th>
                                                <th><%=MyBase.GetResourceString("C_InvoiceDate")%></th>
                                                <th><%=MyBase.GetResourceString("C_ShowReport")%></th>
                                            </tr>
                                        </thead>
                                        <tbody id="printInvoiceTbl_Body">
                                            <%-- <tr>
                                                <td><a href="javascript:;">12</a></td>
                                                <td>ABS6000009</td>
                                                <td>04 Jan 2025</td>
                                                <td><a href="javascript:;" data-bs-toggle="modal"
                                                        data-bs-target="#IRPIRPrintReportmodal">Show Report</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="javascript:;">15</a></td>
                                                <td>ABS6000009</td>
                                                <td>06 May 2025</td>
                                                <td><a href="javascript:;" data-bs-toggle="modal"
                                                        data-bs-target="#IRPIRPrintReportmodal">Show Report</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="javascript:;">22</a></td>
                                                <td>ABS6000019</td>
                                                <td>05 Jul 2025</td>
                                                <td><a href="javascript:;" data-bs-toggle="modal"
                                                        data-bs-target="#IRPIRPrintReportmodal">Show Report</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="javascript:;">30</a></td>
                                                <td>ABS6000022</td>
                                                <td>20 May 2025</td>
                                                <td><a href="javascript:;" data-bs-toggle="modal"
                                                        data-bs-target="#IRPIRPrintReportmodal">Show Report</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="javascript:;">16</a></td>
                                                <td>ABS6000015</td>
                                                <td>14 Sept 2025</td>
                                                <td><a href="javascript:;" data-bs-toggle="modal"
                                                        data-bs-target="#IRPIRPrintReportmodal">Show Report</a></td>
                                            </tr>--%>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- Print Invoice(s) Section ends -->

    <!--IR-PIR Status History Modal start here-->
    <div class="modal custmodal fade" id="IRPIR_StatHistorymodal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_IRPIRStatusHistory")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <table id="PIRstatushistoryTbl" class="table table-stripped table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th><%=MyBase.GetResourceString("C_ChangetoStatus")%></th>
                                <th><%=MyBase.GetResourceString("C_ChangedBy")%></th>
                                <th><%=MyBase.GetResourceString("C_ChangedOn")%></th>
                                <th><%=MyBase.GetResourceString("C_Comments")%></th>
                            </tr>
                        </thead>
                        <tbody id="PIRstatushistoryTbl_Body">
                        </tbody>
                    </table>

                    <div class="clearfix"></div>

                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn" id="IR_statHisCancelBtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!-- IR-PIR Status History Modal End here-->

    <!--IR-PIR Print report Modal start here-->
    <div class="modal custmodal fade" id="IRPIRPrintReportmodal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_Invoice")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pt-1 pb-1 mb-2 text-end">
                        <!-- <a href="javascript:;" class="btn borderbtn me-2" id="AddDshbordPRBtn">Add To Dashboard</a> -->
                        <div class="dropdown filedownload float-end">
                            <button type="button" class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown">
                                <i
                                    data-bs-toggle="tooltip" title="Click here to Export" id="ExportDataPRBtnInvoice"
                                    class="fas fa-download"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a href="#" onclick="Export_PDFClick('PDF')">
                                    <img src="../../../Whizible2.0-new/dist/img/pdf.svg"
                                        width="18"><%=MyBase.GetResourceString("C_Pdf")%></a></li>
                                <li><a href="#" onclick="Export_PDFClick('HTML')">
                                    <img src="../../../Whizible2.0-new/dist/img/xml.svg"
                                        width="18"><%=MyBase.GetResourceString("C_Html")%></a></li>
                                <li><a href="#" onclick="Export_PDFClick('RTF')">
                                    <img src="../../../Whizible2.0-new/dist/img/xml.svg"
                                        width="18"><%=MyBase.GetResourceString("C_RTF")%></a></li>
                                <li><a href="#" onclick="Export_PDFClick('EXCEL')">
                                    <img src="../../../Whizible2.0-new/dist/img/xls.svg"
                                        width="18"><%=MyBase.GetResourceString("C_Excel")%></a></li>
                                <li><a href="#" onclick="Export_PDFClick('CSV')">
                                    <img src="../../../Whizible2.0-new/dist/img/xls.svg"
                                        width="18"><%=MyBase.GetResourceString("C_CSV")%></a></li>
                                <li><a href="#" onclick="Export_PDFClick('TEXT')">
                                    <img src="../../../Whizible2.0-new/dist/img/doc.svg"
                                        width="18"><%=MyBase.GetResourceString("C_Text")%></a></li>
                                <li><a href="#" onclick="Export_PDFClick('XML')">
                                    <img src="../../../Whizible2.0-new/dist/img/xml.svg"
                                        width="18"><%=MyBase.GetResourceString("C_XML")%></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="row form-group mb-3">
                        <div class="col-sm-5 text-end">
                            <label class="required"><%=MyBase.GetResourceString("C_InvoiceNumber")%></label>
                        </div>
                        <div class="col-sm-7">
                            <%CommonFunctions.HTMLControls.DrawComboBox("cboInvoiceNumber1", "usp_Whizible2_Sel_tbl_PM_RFIInvoices",,, "onchange='PlotInvoiceChange();' class='selectpicker' data-live-search='true'",,,) %>

                            <%--<select class="selectpicker" data-live-search="true">
                                <option>Select Invoice Number</option>
                                <option>44</option>
                                <option>12</option>
                                <option>10</option>
                            </select>--%>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="notebox graybg">
                        <strong><%=MyBase.GetResourceString("C_Note")%></strong> <%=MyBase.GetResourceString("C_PrintNote")%>
                    </div>

                    <hr />
                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" id="IR_printRepCancelBtn" class="btn canclesaveasbtn borderbtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!-- IR-PIR Print report Modal End here-->


    <!-- Delete IR-PIR Item Modal Start here-->
    <div id="deleteIrItem" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_Delete")%></h4>
                </div>

                <div class="modal-body">
                    <span id="DeleteId"></span>
                    <%-- Added by Chetan M on 13th Jan 2020 fot IssueID 21293 --%>
                    <span id="EmployeeID"></span>
                    <%--End of Added by Chetan M on 13th Jan 2020 fot IssueID 21293 --%>
                    <p align="center"><%=MyBase.GetResourceString("C_DeleteConfirmation")%></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="DeleteIRItems();" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Ok")%></button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Delete IR-PIR Item Modal END here-->

      <!-- Delete IR-PIR  Modal Start here-->
    <div id="deleteIRPIR" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_Delete")%></h4>
                </div>

                <div class="modal-body">
               
                    <p align="center"><%=MyBase.GetResourceString("C_DeleteConfirmation")%></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="DeleteIR_PIR();" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Ok")%></button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Delete IR-PIR  Modal END here-->

    <!--Print Invoice(s) Modal start here-->
    <div class="modal custmodal fade" id="PrintInvoiceModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_InvoiceList")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mx-1 mb-2">
                        <table class="table table-stripped table-bordered completiontbl printInvoiceTable"
                            id="printInvoiceMTbl">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_InvoiceID")%></th>
                                    <th><%=MyBase.GetResourceString("C_InvoiceNumber")%></th>
                                    <th><%=MyBase.GetResourceString("C_InvoiceDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_ShowReport")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    <div class="form-group text-center ">
                        <%If m_blnAddAccess = True Then%>
                        <button class="btn btnyellow mt-3" id="savePrintInvoiceBtn"><%=MyBase.GetResourceString("C_Save")%></button>
                        <%End If %>
                        <button class="btn borderbtn mt-3" id="cancelPrintInvoiceBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Print Invoice(s) modal end here-->

    <!--Submit IR modal start here-->
    <div class="modal custmodal fade" id="SubmitIRModal" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="txtRFIId" hidden></h5>
                    <h5 class="modal-title" id="txtRFICheckListId" hidden></h5>
                    <h5 class="modal-title" id="txtRFIChecklistInstanceID" hidden></h5>
                     <h5 class="modal-title" id="txtRFICurrentStatus" hidden></h5>
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_Checklist")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered" style="width: 100%;" id="submitIRTbl">
                        <thead>
                            <tr>
                                <th><%=MyBase.GetResourceString("C_SrNo")%></th>
                                <th><%=MyBase.GetResourceString("C_ChecklistItem")%></th>
                                <th><%=MyBase.GetResourceString("C_Yes")%></th>
                                <th><%=MyBase.GetResourceString("C_Comments")%></th>
                            </tr>
                        </thead>
                        <tbody id="submitIRTbl_Body">
                        </tbody>
                    </table>
                    <br />
                    <div class="clearfix"></div>
                    <div class="text-center">
                        <%If m_blnAddAccess = True Then%>
                        <button class="btn btnyellow" id="submitIRSaveBtn" onclick="SaveRFIChecklistItems()"><span><%=MyBase.GetResourceString("C_Save")%></span></button>
                        <%End If %>
                        <button class="btn borderbtn" id="submitIRCancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Submit IR modal end here -->

    <!--IR-PIR Status History Modal start here-->
    <div class="modal custmodal fade" id="IRPIR_ChangeStatusModal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_ChangeIRPIRStatus")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row form-group mb-3">
                                <div class="col-sm-3 d-flex justify-content-end">
                                    <label class="required"><%=MyBase.GetResourceString("C_Status1")%></label>
                                </div>
                                <div class="col-sm-8">
                                    <%--<select class="selectpicker" data-live-search="true" id="modifiedHisField">--%>
                                    <select id="modifiedHisField" class="form-select">
                                        <%--<option>Select Status</option>--%>
                                        <option id="cboSubmitIRStatus"><%=MyBase.GetResourceString("C_Submitted")%></option>
                                        <%-- <option>Approved</option>--%>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row form-group mb-3">
                                <div class="col-sm-3 d-flex justify-content-end">
                                    <label class="required"><%=MyBase.GetResourceString("C_Comment1")%></label>
                                </div>
                                <div class="col-sm-8">
                                    <textarea rows="3" class="form-control" id="txtsubmitIRcomment" maxlength="2000"></textarea>
                                   <%-- Maxlenght attribute Added by Ajit L on  19/12/2023--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-2 mb-2">
                        <%If m_blnAddAccess = True Then%>
                        <a href="javascript:;" class="btn borderbtn" onclick="SumbitIRDetails()"><%=MyBase.GetResourceString("C_Submit")%></a>
                        <%End If %>
                        <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></a>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!-- IR-PIR Status History Modal End here-->

    <!--Select Customer Address modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Select_Customer_Address" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">
                        <%=MyBase.GetResourceString("C_SelectCustomerAddress")%>
                    </h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">
                                (<font color="red">*</font>
                                <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-3">
                                            <div class="col-sm-6 text-end">
                                                <label><%=MyBase.GetResourceString("C_CustomerName")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="custname" id="lblCust_Name"></label>
                                                <input id="cboCustomerforChange" hidden />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-3">
                                            <div class="col-sm-6 text-end">
                                                <label class="required"><%=MyBase.GetResourceString("C_CustomerAddress")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start mb-3">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboCust_Address", "select 0,'select Customer Adress'",,, "class='selectpicker custSelect ' data-live-search='true' onchange='GetCustAddresson_Change(this.value);'",,,) %>
                                                <%--<select class="selectpicker " data-live-search="true">
                                                    <option>SSNA-D046</option>
                                                    <option>SSNA-D031</option>
                                                </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row mx-1">
                        <div class="col-sm-12 graybg">
                            <label class="pt-1 pb-1">
                                <%=MyBase.GetResourceString("C_AddressDetails")%>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-3">
                                            <div class="col-sm-2 text-end">
                                                <label><%=MyBase.GetResourceString("C_Address")%></label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="lblAddress"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%=MyBase.GetResourceString("C_City")%></label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="lblCity"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%=MyBase.GetResourceString("C_State")%></label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="lblState"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%=MyBase.GetResourceString("C_Country")%></label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="lblCountry"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%=MyBase.GetResourceString("C_ZIPCode")%></label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="lblZIPCode"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%=MyBase.GetResourceString("C_FaxNo")%></label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="lblFaxNo"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%=MyBase.GetResourceString("C_TelephoneNo")%></label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="lblTelephone"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-3">
                        <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                        <a href="javascript:;" class="btn btnyellow" id="custAddrSaveBtn" onclick="SaveCustAddrId();"><%=MyBase.GetResourceString("C_Save")%></a>
                        <%End If %>
                        <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"
                            id="custAddrCancelBtn"><%=MyBase.GetResourceString("C_Cancel")%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Select Customer Address modal end here-->

    <!--Contract Details Modal start here-->
    <div class="modal custmodal fade" id="ContractDetailsModal" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_ContractDetails")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row mt-3">
                                        <div class="col-sm-4 text-end"> <%-- Vishal 26/12--%>
                                            <label><%=MyBase.GetResourceString("C_ContractType")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start mb-3">   <%-- Vishal 26/12--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cbocontractType", "select 0,'select Contract Type'",,, "class='selectpicker custSelect ' data-live-search='true' onchange='GetContractDetails(this.value);'",,,) %>
                                            <%--   <select class="selectpicker " data-live-search="true"
                                                id="contractTypeFilter">
                                                <option>Output Based</option>
                                            </select>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mx-1 mb-2 table-responsive">
                        <table class="table table-stripped table-bordered completiontbl contrctTbl" id="contrctTable">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_CustomerName")%></th>
                                    <th><%=MyBase.GetResourceString("C_ContractSummary")%></th>
                                    <th><%=MyBase.GetResourceString("C_ContractTypeName")%></th>
                                    <th><%=MyBase.GetResourceString("C_CommencementDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_ContractSigningDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_ContractExpiryDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_POSOWNumber")%></th>
                                    <th><%=MyBase.GetResourceString("C_POSOWValue")%></th>
                                    <th><%=MyBase.GetResourceString("C_Currency")%></th>
                                    <th><%=MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="contrctTableBody">
                                <%--  <tr class="clsTRSectionHeader">
                                    <td colspan="11" class="footable-last-column footable-first-column text-start">
                                        <span class="footable-toggle"></span>Alcon Research, Ltd.
                                    </td>
                                </tr>
                                <tr class="clsTROdd">
                                    <td class="footable-first-column">
                                        <span class="footable-toggle"></span>
                                    </td>
                                    <td title="Contract Summary">
                                        <a href="JavaScript:;">Currency Change</a>
                                    </td>
                                    <td>Output based</td>
                                    <td>03 Jan 2023</td>
                                    <td>23 Mar 2023</td>
                                    <td>10 Apr 2023</td>
                                    <td>CC-89</td>
                                    <td>89.95</td>
                                    <td class="footable-last-column">Rupees</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="ContractCheck1" class="chcktbl" type="checkbox"
                                                data-bs-dismiss="modal">
                                            <label for="ContractCheck1"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="clsTROdd">
                                    <td class="footable-first-column">
                                        <span class="footable-toggle"></span>
                                    </td>
                                    <td title="Contract Summary">
                                        <a href="JavaScript:;">Currency Exchange</a>
                                    </td>
                                    <td>Output based</td>
                                    <td>03 Jan 2023</td>
                                    <td>23 Mar 2023</td>
                                    <td>10 Apr 2023</td>
                                    <td>CC-89</td>
                                    <td>80.15</td>
                                    <td class="footable-last-column">Rupees</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="ContractCheck2" class="chcktbl" type="checkbox"
                                                data-bs-dismiss="modal">
                                            <label for="ContractCheck2"></label>
                                        </div>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    <div class="form-group text-center ">
                        <button class="btn borderbtn mt-3" id="contrctDetlsCancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Contract Details modal end here-->

    <!--Show Details Modal start here-->
    <div class="modal custmodal fade" id="ShowDetailsModal" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_ShowDetails")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="accordion Init_acordian_panel mb-3 mt-3 " id="contractMasterAcc">
                        <div class="accordion-item mb-3">
                            <h2 class="accordion-header" id="contractMasterHeading">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#contractMasterTab" aria-expanded="true"
                                    aria-controls="collapseOne">
                                    <%=MyBase.GetResourceString("C_ContractMaster")%>
                                </button>
                            </h2>
                            <div id="contractMasterTab" class="accordion-collapse collapse show"
                                aria-labelledby="contractMasterHeading" data-bs-parent="#contractMasterAcc">
                                <div class="accordion-body">
                                    <div class="contractMasterDiv">
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class="" id="lblContractSummary"><%=MyBase.GetResourceString("C_ContractSummary1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="" id="lblCurrencyChange"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            <%--    <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end ">
                                                            <label class="" id="lblContractDetails"><%=MyBase.GetResourceString("C_ContractDetails1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="" id="lblContractDetail"></label>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                            </div>
                                        </div> 
                                        
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-3 text-end ">
                                                            <label class="" id="lblContractDetails"><%=MyBase.GetResourceString("C_ContractDetails1")%></label>
                                                        </div>
                                                        <div class="col-sm-9">
                                                            <label class="" id="lblContractDetail"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" " id="lblCustomer"><%=MyBase.GetResourceString("C_Customer1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=" " id="lblCustomerName"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_ContractType1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=" " id="lblContractType"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_CommencementDate1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="" id="lblCommencementDate"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_ContractSigningDate1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="" id="lblContrctSignDate"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end ">
                                                            <label class=""><%=MyBase.GetResourceString("C_ContractExpiryDate1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="" id="lblContrctEndDate"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end ">
                                                            <label class=""><%=MyBase.GetResourceString("C_POSOWNumber1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">

                                                            <label class="" id="lblPOSOWNumber"></label>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_POSOWValue1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">

                                                            <label class=" " id="lblPOSOWValue"></label>
                                                            <!--<input type="text" class="form-control" disabled />-->
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_Currency1")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=" " id="lblContcurrency"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>

                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=""><%=MyBase.GetResourceString("C_CRMRef")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=" " id="lblCRMNO"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=""><%=MyBase.GetResourceString("C_RemainPoVal")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=" " id="lbl_RemainPOVal"></label>
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

                        <div class="accordion-item mb-3">
                            <h2 class="accordion-header" id="Edit_fiter_heading">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#ContractAttachmentsTab" aria-expanded="false"
                                    aria-controls="collapseTwo">
                                    <%=MyBase.GetResourceString("C_ContractAttachments")%>
                                </button>
                            </h2>
                            <div id="ContractAttachmentsTab" class="accordion-collapse collapse "
                                aria-labelledby="Edit_fiter_heading" data-bs-parent="#contractMasterAcc">
                                <div class="accordion-body">
                                    <div class="ContractAttachmentsDiv">
                                        <div class="row">
                                            <table class="table table-stripped table-bordered completiontbl mb-2"
                                                id="ContractAttachTbl" style="width: 100%;">
                                                <thead>
                                                    <tr>
                                                        <th><%=MyBase.GetResourceString("C_SrNo")%></th>
                                                        <th><%=MyBase.GetResourceString("C_FileName")%></th>
                                                        <th><%=MyBase.GetResourceString("C_AttachedBy")%></th>
                                                        <th><%=MyBase.GetResourceString("C_AttachedDate")%></th>
                                                        <th><%=MyBase.GetResourceString("C_Description1")%></th>
                                                    </tr>
                                                </thead>
                                                <tbody id="ContractAttachTblBody">
                                                    <%--  <tr>
                                                        <td>1</td>
                                                        <td><a href="javascript:;" class="textUndrln">Demo File 1</a>
                                                        </td>
                                                        <td>3KB</td>
                                                        <td>John C</td>
                                                        <td>4th Aug 2022</td>
                                                        <td>lorem ipsum is a dummy content.</td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td><a href="javascript:;" class="textUndrln">Demo File 2</a>
                                                        </td>
                                                        <td>3KB</td>
                                                        <td>John C</td>
                                                        <td>4th Aug 2022</td>
                                                        <td>lorem ipsum is a dummy content.</td>
                                                    </tr>
                                                    <tr>
                                                        <td>3</td>
                                                        <td><a href="javascript:;" class="textUndrln">Demo File 3</a>
                                                        </td>
                                                        <td>4KB</td>
                                                        <td>John C</td>
                                                        <td>4th Apr 2022</td>
                                                        <td>lorem ipsum content.</td>
                                                    </tr>
                                                    <tr>
                                                        <td>4</td>
                                                        <td><a href="javascript:;" class="textUndrln">Demo File 4</a>
                                                        </td>
                                                        <td>5KB</td>
                                                        <td>John C</td>
                                                        <td>4th Jun 2022</td>
                                                        <td>lorem ipsum is a dummy content.</td>
                                                    </tr>
                                                    <tr>
                                                        <td>5</td>
                                                        <td><a href="javascript:;" class="textUndrln">Demo File 5</a>
                                                        </td>
                                                        <td>3KB</td>
                                                        <td>John C</td>
                                                        <td>4th Jul 2022</td>
                                                        <td>lorem ipsum is a dummy content.</td>
                                                    </tr>--%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group text-center mt-3">
                        <button class="btn borderbtn" id="showDtlsCancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Show Details modal end here-->

    <!--Sales Period Modal start here-->
    <div class="modal custmodal fade" id="SalesPeriodModal" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_IRSalesPeriod")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="salesPersonFilter mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%=MyBase.GetResourceString("C_IsOpen")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                        <select data-live-search='true' class='selectpicker clsComboBox' disabled id="salesPeriodIsOpenF" name="salesPeriodIsOpen">
                                            <font size="1">
                                                <option title="Yes" value="Yes">Yes</option>
                                                <option title="No" value="No">No</option>
                                            </font>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%=MyBase.GetResourceString("C_SalesPeriodStartDate")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="input-group">
                                            <input id="salesPeriodStartDateF" autocomplete="off" onpaste="return false" onkeypress="return Date_OnKeyPress(event)" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button">
                                                    <i
                                                        class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%=MyBase.GetResourceString("C_SalesPeriodEndDate")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="input-group">
                                            <input id="salesPeriodEndDateF" autocomplete="off" onpaste="return false" onkeypress="return Date_OnKeyPress(event)" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button">
                                                    <i
                                                        class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%=MyBase.GetResourceString("C_SalesPeriodMonth")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control" id="salesPeriodMonthF" onkeypress="return restrictAlphabets(event)" maxlength="3">
                                             <!-- MaxLegth attribute added by Ajit L for restricting month digith length -->
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%=MyBase.GetResourceString("C_SalesPeriodYear")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control" id="salesPeriodYearF" onkeypress="return restrictAlphabets(event)" maxlength="4">
                                       <!-- MaxLegth attribute added by Ajit L for restricting Year digith length -->
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <a href="javascript:;" id="showSP_FilterBtn" class="textUndrln" data-bs-toggle="tooltip" title="Show" onclick="GetRFISalesPeriod();"><%=MyBase.GetResourceString("C_Show")%></a>
                            </div>
                        </div>
                    </div>

                    <div class="notebox graybg">
                        <strong><%=MyBase.GetResourceString("C_Note")%></strong><span><%=MyBase.GetResourceString("C_SalesNote")%></span>
                    </div>

                    <div class="row mb-2">
                        <table class="table table-stripped table-bordered completiontbl mb-2" id="salesPeriodTbl"
                            style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_SalesPeriodMonth")%></th>
                                    <th><%=MyBase.GetResourceString("C_SalesPeriodYear")%></th>
                                    <th><%=MyBase.GetResourceString("C_SalesPeriodStartDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_SalesPeriodEndDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_IsOpen")%></th>
                                    <th><%=MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="salesPeriodTblBody">
                                <%-- <tr>
                                    <td><a href="javascript:;">012</a></td>
                                    <td>2021</td>
                                    <td>01 Jan 2025</td>
                                    <td>09 May 2025</td>
                                    <td>Yes</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="salesperiod1" class="mainchck" type="checkbox"
                                                data-bs-dismiss="modal">
                                            <label for="salesperiod1"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><a href="javascript:;">013</a></td>
                                    <td>2021</td>
                                    <td>01 Jan 2025</td>
                                    <td>09 May 2025</td>
                                    <td>Yes</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="salesperiod2" class="mainchck" type="checkbox"
                                                data-bs-dismiss="modal">
                                            <label for="salesperiod2"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><a href="javascript:;">014</a></td>
                                    <td>2021</td>
                                    <td>01 Jan 2025</td>
                                    <td>09 May 2025</td>
                                    <td>Yes</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="salesperiod3" class="mainchck" type="checkbox"
                                                data-bs-dismiss="modal">
                                            <label for="salesperiod3"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><a href="javascript:;">015</a></td>
                                    <td>2021</td>
                                    <td>01 Jan 2025</td>
                                    <td>09 May 2025</td>
                                    <td>Yes</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="salesperiod4" class="mainchck" type="checkbox"
                                                data-bs-dismiss="modal">
                                            <label for="salesperiod4"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><a href="javascript:;">012</a></td>
                                    <td>2021</td>
                                    <td>01 Jan 2025</td>
                                    <td>09 May 2025</td>
                                    <td>Yes</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="salesperiod5" class="mainchck" type="checkbox"
                                                data-bs-dismiss="modal">
                                            <label for="salesperiod5"></label>
                                        </div>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>

                    <div class="form-group text-center ">
                        <button class="btn borderbtn" id="cancelSalesPeriodBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Sales Period modal end here-->

    <!--Sales Person Modal start here-->
    <div class="modal custmodal fade" id="SalesPersonModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_SalesPerson")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="salesPersonFilter mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-5">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_SalesPersonName")%> </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtsalesPersonInput", "txtsalesPersonInput", "form-control",,,,,,,,,, "autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                        <%--<input type="text" class="form-control" id="salesPersonInput">--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_SalesCommission")%>&nbsp;% </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtsalesComissionInput", "txtsalesComissionInput", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPressCheck(event,this.id)' autocomplete='Off' onpaste='return false' ondrop='return false' maxlength='200'",,, True,,,, True) %>
                                        <%--<input type="text" class="form-control" id="salesComissionInput">--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <a href="javascript:;" id="showSaleP_FilterBtn" class="textUndrln" data-bs-toggle="tooltip" title="Show" onclick="GetRFISalesPerson();"><%=MyBase.GetResourceString("C_Show")%></a>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <table class="table table-stripped table-bordered completiontbl mb-2" id="salesPersonTbl"
                            style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_SalesPersonName")%></th>
                                    <th><%=MyBase.GetResourceString("C_SalesCommission")%> %</th>
                                    <th><%=MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="salesPersonTblBody">
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    <div class="form-group text-center ">
                        <button class="btn btnyellow" id="saveSalesPersonBtn" onclick="selectSalesPerson();"><%=MyBase.GetResourceString("C_Save")%></button>
                        <button class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Sales Person modal end here-->

    <!--Add New IR on Edit Screen Modal start here-->
    <div class="modal custmodal fade" id="AddNewIRModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_IRPIRItemdetails")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="IRItemMasterDiv">
                        <div class="row ">
                            <div class="col-sm-12 text-end">
                                <label class="form-label ">
                                    (<font color="red">*</font>
                                    <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <div class="row" id="divRow">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="txtIRDescAddNew" id="lblDesc"><%=MyBase.GetResourceString("C_Description")%></label>
                                        </div>
                                        <div class="col-sm-7" id="divDesc">
                                          <%--  <%=CommonFunctions.HTMLControls.DrawTextArea("txtIRDescAddNew", "txtIRDescAddNew", , "form-control", , , ,,,, 2000, TabIndex:=1, EnableHTMLEncode:=True)%>--%>
                                           <%-- <%=CommonFunctions.HTMLControls.DrawTextArea("txtIRDescAddNew", "txtIRDescAddNew", , "form-control", , "form-control", "", , , , 2000,,,,,,,, , True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True)%>
                                        --%>
                                         <%CommonFunctions.HTMLControls.DrawTextArea("txtIRDescAddNew", "txtIRDescAddNew", "", "form-control", , , , , , , 2000, , , , , , , , "maxlength='2000' ondrag= 'return false'; ondrop='return false;'", , , , , , , , , , True)%>
                                       <%-- Maxlength Attribute added by Ajit on 19/12/2023--%>
                                        
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="IRDiscntAddNew" id="lblDiscount"><%=MyBase.GetResourceString("C_IsDiscount")%></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <div class="custom_chckbox">
                                                <input id="IRDiscntAddNew" class="chcktbl" type="checkbox">
                                                <label for="IRDiscntAddNew"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="IRQuantityAddNew" id="lblQuantity"><%=MyBase.GetResourceString("C_Quantity")%></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtIRQuantityAddNew", "txtIRQuantityAddNew", "form-control",,,,,,,,,, "onchange='getTotalAmount();' onpaste='return false' ondrop='return false' onkeypress='return Field_OnKeyPressCheck(event,this.id)' autocomplete='Off' maxlength='7'",,, True,,,, True) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="txtIRRateAddNew" id="lblRate">
                                                <%=MyBase.GetResourceString("C_Rate")%>(<span
                                                    class="INRBillCurncy"></span>)</label>
                                        </div>
                                        <div class="col-sm-7">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtIRRateAddNew", "txtIRRateAddNew", "form-control",,,,,,,,,, "onchange='getTotalAmount();' onpaste='return false' ondrop='return false' onkeypress='return Field_OnKeyPressCheck(event,this.id)' autocomplete='Off' maxlength='12'",,, True,,,, True) %>
                                             <label>&nbsp(Billing Currency)</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="txtIRAmountAddNew" id="lblAmount">
                                                <%=MyBase.GetResourceString("C_Amount")%>(<span
                                                    class="INRBillCurncy"></span>)</label>
                                        </div>
                                        <div class="col-sm-7">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtIRAmountAddNew", "txtIRAmountAddNew", "form-control",,,,,,,,,, "disabled onchange='convertedTotalAmount();' onkeypress='return Field_OnKeyPressCheck(event,this.id)' autocomplete='Off' maxlength='200'",,, True,,,, True) %>
                                           <label>&nbsp(Billing Currency)</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="IRSequenceNoAddNew" class="required"><%=MyBase.GetResourceString("C_SequenceNumber")%></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtIRSequenceNoAddNew", "txtIRSequenceNoAddNew", "form-control",,,,,,,,,, "autocomplete='Off'  onpaste='return false' ondrop='return false' onkeypress='return Field_OnKeyPressCheck(event,this.id)' maxlength='4'",,, True,,,, True) %>
                                            <%-- <input type="number" class="form-control" id="txtIRSequenceNoAddNew" />--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <%--Added By Riddhesh Patil on 09 Jan 2024 for issue Corporate Base Currency Textbox--%>
                        <div class="form-group mb-3" id="dvBaseAmount">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="txtIRAmountAddNew" id="lblBaseCurrencyAmount">
                                                <%=MyBase.GetResourceString("C_Amount")%>(<span
                                                     class="INRBaseCurncy"></span>)</label>
                                        </div>
                                        <div class="col-sm-7">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtBaseCurrencyAmount", "txtBaseCurrencyAmount", "form-control",,,,,,,,,, "disabled onchange='convertedTotalAmount();' onkeypress='return Field_OnKeyPressCheck(event,this.id)' autocomplete='Off' maxlength='200'",,, True,,,, True) %>
                                             <label>&nbsp(Corporate Base Currency)</label>
                                        </div>
                                    </div>
                                </div>

                                 <div class="col-sm-6">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class=""><%=MyBase.GetResourceString("C_StandardRate")%></label>
                                            </div>
                                            <div class="col-sm-6">
                                                <label class="" id="lblStdRate2"></label>
                                                <!--<input type="text" class="form-control" value="Currecny CHange" disabled />-->
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6 text-end ">
                                                <label class=""><%=MyBase.GetResourceString("C_AppliedRate")%></label>
                                            </div>
                                            <div class="col-sm-6">
                                                <label class="" id="lblAppliedRate2"></label>
                                                <!--<textarea class="form-control" value="Currecny CHange" disabled></textarea>-->
                                            </div>
                                        </div>
                                      </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>


                         <%--End of Added By Riddhesh Patil on 09 Jan 2024 for issue Corporate Base Currency Textbox--%>

                    </div>

                    <div class="my-4 contractMaster" id="currAmtAcc">
                        <div class="">
                            <div class="container-fluid py-2 graybg mb-2">
                                <div class="row align-items-center">
                                    <div class="col-sm-12">
                                        <div class="d-flex align-items-center font-weight-600">
                                           <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_CompanyBaseCurrencyAmount")%></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="currAmtTab">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class=""><%=MyBase.GetResourceString("C_StandardRate")%></label>
                                            </div>
                                            <div class="col-sm-6">
                                                <label class="" id="lblStdRate"></label>
                                                <!--<input type="text" class="form-control" value="Currecny CHange" disabled />-->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="row">
                                            <div class="col-sm-6 text-end ">
                                                <label class=""><%=MyBase.GetResourceString("C_AppliedRate")%></label>
                                            </div>
                                            <div class="col-sm-6">
                                                <label class="" id="lblAppliedRate"></label>
                                                <!--<textarea class="form-control" value="Currecny CHange" disabled></textarea>-->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="row">
                                            <div class="col-sm-6 text-end ">
                                                <label class="required">
                                                    <%=MyBase.GetResourceString("C_Amount")%> (<span class="" id="lblAmountCurncyCode"></span>)
                                                    <%=MyBase.GetResourceString("C_CompanyBaseCurrency")%></label>
                                            </div>
                                            <div class="col-sm-6">
                                                <label class="amtCompanyBase font-weight-600" id="lblTotalAmount"></label>
                                                <!--<textarea class="form-control" value="Currecny CHange" disabled></textarea>-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group text-center">
                        <button class="btn borderbtn" data-bs-target="#IR_ShowHistoryRfimodal" id="ShowIrItemHistoryBtn" data-bs-toggle="modal" title="Show History" onclick=" GetItemModifiedField(); GetItemModifiedBy(); ShowItemHistory();"><%=MyBase.GetResourceString("C_ShowHistory")%></button>
                        <%If m_blnAddAccess = True Then%>
                        <button class="btn btnyellow" id="saveIREditBtn" onclick="SaveIRItem();"><%=MyBase.GetResourceString("C_Save")%></button>
                        <%End If %>
                        <button class="btn borderbtn" data-bs-dismiss="modal" id="cancelIREditBtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Add New IR on Edit Screen modal end here-->

    <!--Project Milestone Modal start here-->
    <div class="modal custmodal fade" id="ProjMilestoneModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_SelectProjectMilestones")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row align-items-center">
                        <div class="col-sm-8">
                            <div class="row mb-1">
                                <div class="col-sm-10">
                                    <div class="row">
                                        <div class="col-sm-4 text-end">
                                            <label class=""><%=MyBase.GetResourceString("C_Project")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                            <label class="project" id="txtProject"></label>
                                            <%--<label class="">Sonata</label>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 text-end">
                            <div class="input-group">
                                <input id="milestoneInput" type="text" placeholder="Search.."
                                    onkeyup="searchMilestones()" class="form-control input-sm">
                                <div class="input-group-btn">
                                    <button class="btn btn-default srchBtn" type="submit">
                                        <i
                                            class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row p-3">
                        <table class="table table-stripped table-bordered MilestoneTbl" id="MilestoneTable"
                            style="width: 100%;">
                            <thead>
                                <tr>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_Milestone")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_StartDate")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_EndDate")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_BillingAmount")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_BilledAmount")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_BalanceAmount")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="tbodyMileStone">

                                <%--   <tr>
                                    <td>Milestone 1</td>
                                    <td class="">26 May 2023</td>
                                    <td class="">31 May 2023</td>
                                    <td><span class="INRCurncy"></span> 5000</td>
                                    <td class="text-success"><span class="INRCurncy"></span> 2000</td>
                                    <td class="textOrange"><span class="INRCurncy"></span> 3000</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="milestoneCheck1" class="chcktbl">
                                            <label for="milestoneCheck1"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Milestone 2</td>
                                    <td class="">22 Apr 2023</td>
                                    <td class="">20 Jun 2023</td>
                                    <td><span class="INRCurncy"></span> 15000</td>
                                    <td class="text-success"><span class="INRCurncy"></span> 12000</td>
                                    <td class="textOrange"><span class="INRCurncy"></span> 3000</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="milestoneCheck2" class="chcktbl">
                                            <label for="milestoneCheck2"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Milestone 3</td>
                                    <td class="">01 Jun 2023</td>
                                    <td class="">05 Aug 2023</td>
                                    <td><span class="INRCurncy"></span> 22000</td>
                                    <td class="text-success"><span class="INRCurncy"></span> 12000</td>
                                    <td class="textOrange"><span class="INRCurncy"></span> 10000</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="milestoneCheck3" class="chcktbl">
                                            <label for="milestoneCheck3"></label>
                                        </div>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>

                    <div class="form-group text-center">
                        <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                        <button class="btn borderbtn" id="CreateMSIRItem" onclick="ValidateMileStones();">
                            <%-- data-bs-target="#IR_CreateMilestoneModal">--%>


                            <span>Create IR Item</span></button>
                        <%-- <button class="btn btnyellow" data-bs-toggle="tooltip" id="IR_SaveMS_Btn" title="Save" >Save</button>--%>
                        <%End If%>
                        <button class="btn borderbtn" data-bs-dismiss="modal" id="IR_CancelMS_Btn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Project Milestone modal end here-->

    <!-- Create Milestones Invoice Item Modal start here-->
    <div class="modal custmodal fade" id="IR_CreateMilestoneModal" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_CreateIRItem")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-4 form-inline hstryfltr">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <%=MyBase.GetResourceString("C_IR_CreateMilestone")%>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn borderbtn" id="IR_MS_CancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        <button class="btn btnyellow" id="IR_MS_OK_Btn" onclick="SaveMileStones()"><%=MyBase.GetResourceString("C_Ok")%></button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Create Milestones Invoice Item Modal end here-->

    <!--Project Deliverable Modal start here-->
    <div class="modal custmodal fade" id="ProjDeliverablesModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_SelectProjectDeliverables")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row align-items-center">
                        <div class="col-sm-8">
                            <div class="row mb-1">
                                <div class="col-sm-10">
                                    <div class="row">
                                        <div class="col-sm-4 text-end">
                                            <label class=""><%=MyBase.GetResourceString("C_Project")%></label>
                                        </div>
                                        <div class="col-sm-8 text-start">
                                            <label class="" id="txtProDel"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 text-end">
                            <div class="input-group">
                                <input id="delvrbleInput" type="text" placeholder="Search.."
                                    onkeyup="searchDeliverables()" class="form-control input-sm">
                                <div class="input-group-btn">
                                    <button class="btn btn-default srchBtn" type="submit">
                                        <i
                                            class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row p-3">
                        <table class="table table-stripped table-bordered DeliverablesTbl" id="DeliverablesTable"
                            style="width: 100%;">
                            <thead>
                                <tr>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_Deliverables")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_StartDate")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_EndDate")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_BillingAmount")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_BilledAmount")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_BalanceAmount")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="tbodyDeliverable">

                                <%--  <tr>
                                    <td>Deliverable 1</td>
                                    <td class="">26 May 2023</td>
                                    <td class="">31 May 2023</td>
                                    <td><span class="INRCurncy"></span> 5000</td>
                                    <td class="text-success"><span class="INRCurncy"></span> 2000</td>
                                    <td class="textOrange"><span class="INRCurncy"></span> 3000</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="DeliverableCheck1" class="chcktbl">
                                            <label for="DeliverableCheck1"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Deliverable 2</td>
                                    <td class="">22 Apr 2023</td>
                                    <td class="">20 Jun 2023</td>
                                    <td><span class="INRCurncy"></span> 15000</td>
                                    <td class="text-success"><span class="INRCurncy"></span> 12000</td>
                                    <td class="textOrange"><span class="INRCurncy"></span> 3000</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="DeliverableCheck2" class="chcktbl">
                                            <label for="DeliverableCheck2"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Deliverable 3</td>
                                    <td class="">01 Jun 2023</td>
                                    <td class="">05 Aug 2023</td>
                                    <td><span class="INRCurncy"></span> 22000</td>
                                    <td class="text-success"><span class="INRCurncy"></span> 12000</td>
                                    <td class="textOrange"><span class="INRCurncy"></span> 10000</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="DeliverableCheck3" class="chcktbl">
                                            <label for="DeliverableCheck3"></label>
                                        </div>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>

                    <div class="form-group text-center">
                        <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                        <button class="btn borderbtn" id="CreateDelvrblIRItem"
                            onclick="ValidateDeliverables();">

                            <span>Create IR Item</span></button>
                        <%--    <button class="btn btnyellow" id="IR_SaveDlvrbl_Btn" data-bs-toggle="tooltip" title="Save" >Save</button>--%>
                        <%End If %>
                        <button class="btn borderbtn" id="IR_CancelDlvrbl_Btn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Project Deliverable modal end here-->

    <!-- Create Deliverable Invoice Item Modal start here-->
    <div class="modal custmodal fade" id="IR_CreateDelvrblModal" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_CreateIRItem")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-4 form-inline hstryfltr">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <%=MyBase.GetResourceString("C_IR_CreateDeliverable")%>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn borderbtn" id="IR_DelvrblCancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        <button class="btn btnyellow" id="IR_DelvrblOK_Btn" onclick="SaveProjectDeliverables()"><%=MyBase.GetResourceString("C_Ok")%></button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Create Deliverable Invoice Item Modal end here-->

    <!--Project Expenses Modal start here-->
    <div class="modal custmodal fade" id="ProjExpensesModal" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_SelectProjectExpenses")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="projExpensesFilter px-2">
                        <div class="row mb-3">
                            <div class="col-sm-8"></div>
                            <!-- <div class="col-sm-4 text-end">
                                <button class="btn borderbtn" id="CreateInvoiceItem" data-bs-toggle="modal"
                                    data-bs-target="#IR_CreateExpensesModal">Create Invoice Item</button>
                            </div> -->
                        </div>

                        <div class="row">
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-4 text-end"> <%--col-sm value changed from 3 to 4 by Ajit for UI issue--%>
                                        <label class=""><%=MyBase.GetResourceString("C_Project")%></label>
                                    </div>
                                    <div class="col-sm-8 text-start">  <%--col-sm value changed from 9 to 8 by Ajit for UI issue--%>
                                        <label class="" id="txtProforExp"></label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-3 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_Resources")%></label>
                                    </div>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboResources", "Select 0, 'select Resources '",,, "class='selectpicker' data-live-search='true'onchange='ShowProjectExpense();'",,,) %>
                                        <%--<select class="selectpicker" data-live-search="true">
                                            <option>Select Resources</option>
                                            <option>James</option>
                                            <option>Robin</option>
                                            <option>Madhuri</option>
                                            <option>Sayali</option>
                                        </select>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-3 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_Currency")%></label>
                                    </div>
                                    <div class="col-sm-9">

                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", "Select 0, 'select Currency '",,, "class='selectpicker' data-live-search='true'onchange='ShowProjectExpense();'",,,) %>

                                        <%--<select class="selectpicker" data-live-search="true">
                                            <option>Select Currency</option>
                                            <option>INR</option>
                                            <option>USD</option>
                                        </select>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-3 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_CostHead")%></label>
                                    </div>
                                    <div class="col-sm-9">

                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboCostHead", "Select 0, 'select CostHead '",,, "class='selectpicker' data-live-search='true'onchange='ShowProjectExpense();'",,,) %>

                                        <%-- <select class="selectpicker" data-live-search="true">
                                            <option>Select Cost Head</option>
                                            <option>25000</option>
                                            <option>50000</option>
                                            <option>75000</option>
                                            <option>100000</option>
                                        </select>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-3 pe-0 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_Status")%></label>
                                    </div>
                                    <div class="col-sm-9">

                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboStatusProExp", "Select 0, 'select status '",,, "class='selectpicker' data-live-search='true'onchange='ShowProjectExpense();'",,,) %>

                          
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="projExpensesContent">
                        <div class="row p-3">
                            <div class="table-container">
                                <table class="table table-stripped table-bordered ExpensesTbl" id="ExpensesTable"
                                    style="width: 100%;">
                                    <thead class="stickyTblHeader">
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_CostHead")%></th>
                                            <th><%=MyBase.GetResourceString("C_EmployeeName")%></th>
                                            <th><%=MyBase.GetResourceString("C_Description")%></th>
                                            <th><%=MyBase.GetResourceString("C_ExpensesYear")%></th>
                                            <th><%=MyBase.GetResourceString("C_ExpensesMonth")%></th>
                                            <th><%=MyBase.GetResourceString("C_Currency")%></th>
                                            <th><%=MyBase.GetResourceString("C_Amount")%></th>
                                            <th><%=MyBase.GetResourceString("C_Select")%></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyProExpense">
                                    </tbody>
                                    <tfoot id="tfootProjectExpenss">
                                        <%--  <tr>
                                        <td class="text-start font-weight-500" colspan="6">Total Expense Amount For USD
                                        </td>
                                        <td class="font-weight-500"><span class="USDCurncy"></span> 5000.00</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="text-start font-weight-500" colspan="6">Total Expense Amount In
                                            Project Currency (INR)</td>
                                        <td class="font-weight-500"><span class="INRCurncy"></span> 14000.00</td>
                                        <td>&nbsp;</td>
                                    </tr>--%>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="form-group text-center">
                        <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                        <button class="btn borderbtn" id="CreateExpIRItem"
                            onclick="ValidateProjectExpences();">

                            <span>Create IR Item</span>
                        </button>
                        <!-- <button class="btn btnyellow" id="saveIRExpenseBtn" data-bs-toggle="tooltip" title="Save">Save</button> -->
                        <%End If %>
                        <!-- <button class="btn btnyellow" id="saveIRExpenseBtn" data-bs-toggle="tooltip" title="Save">Save</button> -->
                        <button class="btn borderbtn" id="CancelIRExpenseBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Project Expenses modal end here-->

    <!-- Create Invoice Item Modal start here-->
    <div class="modal custmodal fade" id="IR_CreateExpensesModal" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_CreateIRItem")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--<div class="pb-4 form-inline hstryfltr">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <%=MyBase.GetResourceString("C_IR_CreateProjectExpense")%>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn btnyellow" id="IR_CI_OK_Btn" onclick="SaveProExpences();"><%=MyBase.GetResourceString("C_Ok")%></button>
                        <button class="btn borderbtn" id="IR_CI_CancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>--%>
                    <p align="center"><%=MyBase.GetResourceString("C_IR_CreateProjectExpense")%></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn btnyellow ml-1 float-end" id="IR_CI_CancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn borderbtn ml-1" id="IR_CI_OK_Btn" onclick="SaveProExpences();" ><%=MyBase.GetResourceString("C_Ok")%></button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Create Invoice Item Modal end here-->


      <!-- Create Invoice Item Modal start here-->
    <div class="modal custmodal fade" id="IR_ValidateExpensesModal" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Confirmation Alert</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                 
                    <p align="center" id="txtConfirm"></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn btnyellow ml-1 float-end" id="IR_CI_Conf_CancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn borderbtn ml-1" id="IR_CI_Conf_Btn" onclick="ShowCreatePopup();" ><%=MyBase.GetResourceString("C_Ok")%></button>
                                
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Create Invoice Item Modal end here-->



    <!--Project Timesheet Modal start here-->
    <div class="modal custmodal fade" id="ProjectTimesheetModal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_SelectProjectTimesheet")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="row form-group">
                                <div class="col-sm-4 text-end">
                                    <label class=""><%=MyBase.GetResourceString("C_Project")%></label>
                                </div>
                                <div class="col-sm-8 text-start">
                                    <label class="" id="lblPrjName"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <ul class="d-flex justify-content-end mb-0">
                                <li>
                                    <%--<label class="me-2"><%=MyBase.GetResourceString("C_Legends")%></label></li>--%>
                                <li><span class="partiallyUtilized me-1" data-bs-toggle="tooltip" data-bs-container="body" aria-label="Partially Billed" data-bs-original-title="Partially Billed"></span><%=MyBase.GetResourceString("C_PartiallyBilled")%></li>
                            </ul>
                        </div>
                    </div>

                    <div class="container-fluid py-1 mb-2">
                        <p class="mb-0 text-end">
                            <i class="fas fa-sticky-note me-2"></i><small><%=MyBase.GetResourceString("T_Note1")%></small>
                        </p>
                    </div>
                    <div class="table-responsive">
                        <table id="ProjectTimesheetTbl" class="table table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_TimesheetID")%></th>
                                    <th><%=MyBase.GetResourceString("C_FromDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_ToDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_TimesheetHours")%></th>
                                    <!-- <th>Remaining Available Hours</th> -->
                                    <th><%=MyBase.GetResourceString("C_ProjectedAmount")%>(<span class="INRCurncy"></span>)</th>
                                    <th><%=MyBase.GetResourceString("C_CreatedDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_ApprovedDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="ProjectTimesheetTblBody">
                                <%-- <tr class="bgColor">
                                    <td>15</td>
                                    <td>01 Oct 2023</td>
                                    <td>02 Nov 2023</td>
                                    <td>
                                        <div class="TS_HoursCol">
                                            12:00 <img src="../../../Whizible2.0-new/dist/img/info-circle-red.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Hours to Billed: 2.00">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="TS_ProjAmt">
                                            2000.00 <img src="../../../Whizible2.0-new/dist/img/info-circle-red.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Projected Amount: 2000.00">
                                        </div>
                                    </td>
                                    <td>22 Sep 2023</td>
                                    <td>28 Oct 2023</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="TSCheck1" class="chcktbl">
                                            <label for="TSCheck1"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>16</td>
                                    <td>01 Oct 2023</td>
                                    <td>02 Nov 2023</td>
                                    <td>20:00</td>
                                    <td>5000.00</td>
                                    <td>22 Sep 2023</td>
                                    <td>28 Oct 2023</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="TSCheck2" class="chcktbl">
                                            <label for="TSCheck2"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="bgColor">
                                    <td>30</td>
                                    <td>01 Oct 2023</td>
                                    <td>02 Nov 2023</td>
                                    <td>
                                        <div class="TS_HoursCol">
                                            06:00 <img src="../../../Whizible2.0-new/dist/img/info-circle-red.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Hours to Billed: 2.00">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="TS_ProjAmt">
                                            12000.00 <img src="../../../Whizible2.0-new/dist/img/info-circle-red.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Projected Amount: 2000.00">
                                        </div>
                                    </td>
                                    <td>22 Sep 2023</td>
                                    <td>28 Oct 2023</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="TSCheck3" class="chcktbl">
                                            <label for="TSCheck3"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>37</td>
                                    <td>01 Oct 2023</td>
                                    <td>02 Nov 2023</td>
                                    <td>24:00</td>
                                    <td>25000.00</td>
                                    <td>02 Feb 2023</td>
                                    <td>14 Mar 2023</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="TSCheck4" class="chcktbl">
                                            <label for="TSCheck4"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="bgColor">
                                    <td>40</td>
                                    <td>01 Oct 2023</td>
                                    <td>02 Nov 2023</td>
                                    <td>
                                        <div class="TS_HoursCol">
                                            30:00 <img src="../../../Whizible2.0-new/dist/img/info-circle-red.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Hours to Billed: 2.00">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="TS_ProjAmt">
                                            20000.00 <img src="../../../Whizible2.0-new/dist/img/info-circle-red.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Projected Amount: 2000.00">
                                        </div>
                                    </td>
                                    <td>02 Mar 2023</td>
                                    <td>15 Apr 2023</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input type="checkbox" id="TSCheck5" class="chcktbl">
                                            <label for="TSCheck5"></label>
                                        </div>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>

                    <div class="clearfix"></div>
                    <div class="clearfix"></div>

                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                        <button class="btn borderbtn" id="CreateTS_IRItem" onclick="SelectPrjTimesheet();">
                            <span><%=MyBase.GetResourceString("C_CreateIRItem")%></span>
                        </button>
                        <%End If %>
                        <button data-bs-dismiss="modal" id="IR_ProjTSCancelBtn" class="btn canclesaveasbtn borderbtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Project Timesheet Modal End here-->

    <!-- Create Timesheet Invoice Item Modal start here-->
    <div class="modal custmodal fade" id="IR_CreateTSModal" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_CreateIRItem")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%--<div class="pb-4 form-inline hstryfltr">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <%=MyBase.GetResourceString("C_IR_CreateProjectTimesheet")%>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn btnyellow" id="IR_TS_OK_Btn" onclick="SavePrjTimesheet();"><%=MyBase.GetResourceString("C_Ok")%></button>
                        <button class="btn borderbtn" id="IR_TS_CancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>--%>

                    <p align="center"><%=MyBase.GetResourceString("C_IR_CreateProjectTimesheet")%></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn btnyellow ml-1 float-end" id="IR_TS_CancelBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn borderbtn ml-1" id="IR_TS_OK_Btn" onclick="SavePrjTimesheet();" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Ok")%></button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Create Timesheet Invoice Item Modal end here-->
        <!-- Create Timesheet Invoice Item Modal start here Added by Ajit for showing if IR & Timesheet Conversion Dates are diff-->
    <div class="modal custmodal fade" id="IR_CreateTSModalDate" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("A_Confirmation")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-4 form-inline hstryfltr">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                               <%=MyBase.GetResourceString("A_ConfirmAlert")%>
                            </div>
                        </div>
                    </div>
                   <%-- Added by Ajit L on 26/12/23 for button position start--%>
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn btnyellow ml-1 float-end" id="IR_TS_BtnCancel" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                        <button class="btn borderbtn ml-1" id="IR_TS_Btn_OK" onclick="SaveProTimesheet();"><%=MyBase.GetResourceString("C_Ok")%></button>
                            </div>
                            </div>
                    </div>
                    <%-- Added by Ajit L on 26/12/23 for button position End--%>
                </div>
            </div>
        </div>
    </div>
    <!-- Create Timesheet Invoice Item Modal end here-->

    <!-- Show History Modal start here-->
    <div class="modal custmodal fade" id="IR_ShowHistorymodal" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_ShowHistory")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pt-1 pb-1 form-inline hstryfltr ">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row form-group">
                                    <div class="col-sm-6 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_ModifiedField")%></label>
                                    </div>
                                    <div class="col-sm-6">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", " ",,, "class='selectpicker' data-live-search='true' onchange='ShowHistory();'",,,) %>

                                        <%-- <select class="selectpicker" data-live-search="true" id="modifiedHisField">
                                            <option>Select Option</option>
                                            <option>Equiv. INR Amount (Corporate Base)</option>
                                            <option>Equiv. INR Amount (Company Base)</option>
                                        </select>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="row form-group">
                                    <div class="col-sm-6 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_ModifiedBy")%></label>
                                    </div>
                                    <div class="col-sm-6">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "Select 0, 'select Modified By '",,, "class='selectpicker' data-live-search='true' onchange='ShowHistory();'",,,) %>

                                        <%--<select class="selectpicker" data-live-search="true" id="modifiedHisBy">
                                            <option>Select Option</option>
                                            <option>User 1</option>
                                            <option>User 2</option>
                                            <option>User 3</option>
                                        </select>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="container-fluid py-2 graybg mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-12">
                                <div class="d-flex">
                                    <span><%=MyBase.GetResourceString("C_AuditTrail")%></span>
                                    <span><%=MyBase.GetResourceString("C_IR_PIR")%></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <table id="IRAShowHistoryTable" class="table table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th><%=MyBase.GetResourceString("C_ModifiedField1")%></th>
                                <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                                <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                                <th><%=MyBase.GetResourceString("C_NewValue")%></th>
                                <th><%=MyBase.GetResourceString("C_ModifiedBy1")%></th>
                            </tr>
                        </thead>
                        <tbody id="tbodyShowHistory">

                          
                        </tbody>
                    </table>
                    <br>
                    <div class="clearfix"></div>

                    <div class="text-center">
                        <button class="btn borderbtn" id="IR_ShowHisBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Show History Modal end-->

    <!-- Show History Modal for RFI Items start here-->
    <div class="modal custmodal fade" id="IR_ShowHistoryRfimodal" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_ShowHistory")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pt-1 pb-1 form-inline hstryfltr ">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row form-group">
                                    <div class="col-sm-6 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_ModifiedField")%></label>
                                    </div>
                                    <div class="col-sm-6">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboItemModifiedField", " ",,, "class='selectpicker' data-live-search='true' onchange='ShowItemHistory();'",,,) %>

                                        <%-- <select class="selectpicker" data-live-search="true" id="modifiedHisField">
                                            <option>Select Option</option>
                                            <option>Equiv. INR Amount (Corporate Base)</option>
                                            <option>Equiv. INR Amount (Company Base)</option>
                                        </select>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="row form-group">
                                    <div class="col-sm-6 d-flex justify-content-end">
                                        <label><%=MyBase.GetResourceString("C_ModifiedBy")%></label>
                                    </div>
                                    <div class="col-sm-6">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboItemModifiedBy", "Select 0, 'select Modified By '",,, "class='selectpicker' data-live-search='true' onchange='ShowItemHistory();'",,,) %>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="container-fluid py-2 graybg mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-12">
                                <div class="d-flex">
                                    <span><%=MyBase.GetResourceString("C_AuditTrail")%></span>
                                    <span><%=MyBase.GetResourceString("C_IR_PIR_Item")%></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <table id="RFIItemShowHistoryTable" class="table table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th><%=MyBase.GetResourceString("C_ModifiedField1")%></th>
                                <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                                <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                                <th><%=MyBase.GetResourceString("C_NewValue")%></th>
                                <th><%=MyBase.GetResourceString("C_ModifiedBy1")%></th>
                            </tr>
                        </thead>
                        <tbody id="tbodyRFIItemShowHistory">
                        </tbody>
                    </table>
                    <br>
                    <div class="clearfix"></div>

                    <div class="text-center">
                        <button class="btn borderbtn" id="IR_ShowHistoryBtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Show History Modal for RFI Items end-->
    <!--Alert Modal start here-->
    <div class="modal custmodal fade" id="IR_ContractAlertModal" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_Contract")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-4 form-inline hstryfltr">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <%=MyBase.GetResourceString("C_SelectContract")%>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        <button class="btn btnyellow" id="alertOkBtn"><%=MyBase.GetResourceString("C_Ok")%></button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Alert Modal end here-->

    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="svFilterAs"><%=MyBase.GetResourceString("C_SaveFilterAs")%></h5>
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
                                        <label class="control-label col-md-4 p-0 text-end"><%=MyBase.GetResourceString("C_FilterName")%></label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" name="" id="txtFilterName" /><br />
                                            <div class="btnrow">
                                                <button id="sveFilterbtn"
                                                    class="btn btnyellow float-start" onclick="SaveFilterQuery()">
                                                    <%=MyBase.GetResourceString("C_Save")%></button>
                                                <button data-bs-dismiss="modal"
                                                    class="btn canclesaveasbtn borderbtn float-end">
                                                    <%=MyBase.GetResourceString("C_Cancel")%></button>
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
    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %> </p>
        </div>
    </div>
    <%End If %>


    <div class="clearfix"></div>

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script> -->
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
    <%--Added on 03/11/2023 by Vishal--%>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>

    <script>

        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionProjectId = '<%= Session("intProjectID") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var SessionProjectID = '<%= Session("intProjectID") %>';
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var GFlag = 0;
        var Cust_Flag = 0;

        /*
        Created By : Vishal Mane
        Created Date : 03/11/2023
        Purpose : To get default project on project dropdown
        */
        window.onload = function GetSessionProject(changeProjectID) {
            if (SessionProjectID.length) {
                $("#cboProject").val(SessionProjectID);
                //$("#cboProject").trigger("change");
                //$('#tabActive').css('tab-slider-trigger,.active');
                $(".selectpicker").selectpicker('refresh');
            }
            else {
            }
        }

        $(document).ready(function () {
            if (ViewAccess == 'True') {
                $("#IRPIRAprvltbl_wrapper .dataTable").resize();

                //$("span.INRCurncy").append('<i class="fas fa-rupee-sign iconBlue"></i>');
                //$("span.USDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');

                GetCurrencyCodes();
                //MyFilters(SessionProjectID);
                GetProjectCurrency(0);
                var FilterID = UpdateDefaultFilter();
                MyFilters(SessionProjectID, FilterID);
                GetGlobalCurrencies(SessionProjectID);
                let isFilChecked = $(".setDefaultFilter").is(":checked");

                if (isFilChecked) {
                    $("#AdvanceFilterIcon").attr("aria-expanded", "true");
                    $("#PMProjectReviewClearAllFilter").show();
                }
                else {
                    $("#AdvanceFilterIcon").attr("aria-expanded", "false");
                    $("#PMProjectReviewClearAllFilter").hide();
                }
            }

        });


        /*
                Created By : Vishal Mane
                Created Date : 21/11/2023
                Purpose : To update default filter
                */
        function UpdateDefaultFilter() {
            var ProjectID = SessionProjectID;
            var FilterFields = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(FilterFields)
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/UpdateDefaultFilter", param, false);
            var FilterID = Result;
            return FilterID;
        }


        /*
         Created By : Vishal Mane
         Created Date : 03/11/2023
         Purpose : To get Resource List and Task List as per selected Project 
         */
        function PlotProjectonChange() {
            $("#cboProjectFilter").val(0);
            $("#Fil_Amount").val("");
            $("#Fil_IRID").val("");
            $("#Fil_RaisedOnDate").val("");
            $("#Fil_AmountCB").val("");
            $("#Fil_EquivAmount").val("");
            $("#txtFilterID").val("");
            $("#txtFilterName").val("");
            /* $("#cboProjectFilter").val(0);*/
            $("#cboIRPIRFilter").val(1);
            $("#cboCurrencyFilter").val(0);
            var textStatus = $("#cboStatusFilter").find(":selected").text();
            if (textStatus != "Select Status") {
                $("#cboStatusFilter").val(0);
                $("#cboStatusFilter").find(":selected").text("Select Status");
            }
            $("#cboTypeFilter").val(0);
            $(".selectpicker").selectpicker('refresh');
            var ProjectID = $("#cboProject").val();
            //GetIRPIRList(ProjectID);
            MyFilters(ProjectID);
            GetProjectCurrency(0);
            GetGlobalCurrencies(ProjectID);
        }

        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();

            var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
            var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
                return new bootstrap.Popover(popoverTriggerEl);
            });
        })

        $(document).on("click", function () {
            $(".tooltip").remove();
        });

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

        $("#IR_Filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });

        $("#IR_Filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        function searchMilestones() {
            var SearchText = $("#milestoneInput").val();

            var FilterTitle = mileStones.filter(function (x) { return x.MileStone.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableSearchForMileStone(FilterTitle);
        }
        //Changed on 04/01/2023
        function ReloadTableSearchForMileStone(List) {
            
            $('#MilestoneTable').dataTable().fnDestroy();
            var strHTML = "";
            $("#tbodyMileStone").html('');
            if (List != null && List.length > 0) {
                $.each(List, function (index, obj) {

                    strHTML += '<tr>' +
                        '<td class="text-centre">' + obj.MileStone + '</td>' +
                        '<td class="text-centre">' + obj.StartDate + '</td>' +
                        '<td class="text-centre">' + obj.EndDate + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BillingAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.UsedAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BalanceAmount + '</td>';

                    strHTML += '<td><input type="checkbox" class="chcktblMl" id= ' + obj.MileStoneID + '> </td>';
                    strHTML += '</tr>';

                });
              // $('#MilestoneTable').dataTable().fnDestroy();//04/01
                $("#tbodyMileStone").html(strHTML);         
            }
            else {             
              //  $('#MilestoneTable').dataTable().fnDestroy();//04/01
               // $("#tbodyMileStone").html(strHTML);
                $("#tbodyMileStone").prop("colspan", 7);
            }
            $('#MilestoneTable').dataTable({
                // "scrollY": true,
                //"scrollX": true,//04/01
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,               
                "columns": [
                    { "width": "150px" },
                    { "width": "150px" },
                    { "width": "150px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },

                ],
                "autoWidth": false
            });
            $(".selectpicker").selectpicker('refresh');
        }

        function searchDeliverables() {
            var SearchText = $("#delvrbleInput").val();

            var FilterTitle = deliverables.filter(function (x) { return x.Title.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableSearchForDeliverable(FilterTitle);
        }
           //Changed on 04/01/2023
        function ReloadTableSearchForDeliverable(List) {
            var strHTML = "";
            $('#DeliverablesTable').dataTable().fnDestroy();
            $("#tbodyDeliverable").html('');
            if (List != null && List.length > 0) {
                $.each(List, function (index, obj) {

                    strHTML += '<tr>' +
                        '<td class="text-centre">' + obj.Title + '</td>' +
                        '<td class="text-centre">' + obj.StartDate + '</td>' +
                        '<td class="text-centre">' + obj.EndDate + '</td>' +             
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BillingAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BilledAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BalanceAmount + '</td>';

                    strHTML += '<td><input type="checkbox" class="chcktbldel" id= ' + obj.ScheduleID + '> </td>';
                    strHTML += '</tr>';

                });
                $('#DeliverablesTable').dataTable().fnDestroy();//04/01
                $("#tbodyDeliverable").html(strHTML);
              
            }
            else {

                $("#tbodyDeliverable").prop("colspan", 7);
                //strHTML = '<tr><td class="text-center"colspan="7">' + NoDataFound + ' </td></tr>';           
                //$("#tbodyDeliverable").html(strHTML);
            }

            $('#DeliverablesTable').dataTable({
                // "scrollY": true,
                //"scrollX": true,
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                "columns": [
                    { "width": "150px" },
                    { "width": "150px" },
                    { "width": "150px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },

                ],
                "autoWidth": false
            });
            $(".selectpicker").selectpicker('refresh');
        }

        //datepicker
        $('#Fil_RaisedOnDate, #toDate, #toDateFilter, #toDateFilterE, #salesPeriodStartDate, #salesPeriodEndDate, #salesPeriodStartDateF, #salesPeriodEndDateF').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        //$("#IRCheckAll").change(function () {
        //    
        //    //var allPages = G_IRPIR_Tbl.fnGetNodes();
        //    var allPages = G_IRPIR_Tbl.fnGetNodes();           
        //    if (checked) {
        //        $('input[type="checkbox"]', allPages).prop('checked', true);
        //        var rows = $("#LTListTbl").dataTable().fnGetNodes();
        //        for (var i = 0; i < rows.length; i++) {
        //            SelectedHelpdeskID.push(parseInt($(rows[i]).find("#txthid").val()));
        //        }
        //    } else {
        //        $('input[type="checkbox"]', allPages).prop('checked', false);
        //        SelectedLeaveID = [];
        //    }
        //});

        var G_IRPIR_Tbl = "";
        //$(".task-checkbox").change(function () {

        //    if (G_IRPIR_Tbl.$('input:checked').length == G_IRPIR_Tbl.fnGetNodes().length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").prop("checked", false);
        //        $(".chckHead").removeAttr("checked");
        //    }
        //});

        // Check or Uncheck All checkboxes on Edit Screen
        $("#EdtblCheck0").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".EdtblCheck").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".EdtblCheck").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".EdtblCheck").click(function () {
            if ($(".EdtblCheck").length === $(".EdtblCheck:checked").length) {
                $("#EdtblCheck0").prop("checked", true);
            } else {
                $("#EdtblCheck0").prop("checked", false);
            }
        });

        // Check or Uncheck All checkboxes on Edit Screen
        $("#EdtCheck0").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".EdtCheck").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".EdtCheck").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".EdtCheck").click(function () {
            if ($(".EdtCheck").length === $(".EdtCheck:checked").length) {
                $("#EdtCheck0").prop("checked", true);
            } else {
                $("#EdtCheck0").prop("checked", false);
            }
        });

        ////datatable
        //$('#IRPIR_Tbl').dataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 10,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "ordering": false,
        //    "info": false,
        //});

        $('#IRPIR_Tbl').wrap('<div class="dataTables_scroll" />');

        //Added for Detailpanel Table
        //datatable
        var table = $('#IRinvoiceItemsTbl').dataTable({
            "scrollY": true,
            "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
            "fnInitComplete": function () {
                this.css("visibility", "visible");
            }
        });

        //Edit 1st screen datatable
        var table = $('#IRPIR_EditDetailsTbl').dataTable({
            "scrollY": true,
            "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
            "fnInitComplete": function () {
                this.css("visibility", "visible");
            }
        });

        //Edit 2nd screen datatable
        //var table = $('#IRPIR_EditblDetails').dataTable({
        //    "scrollY": true,
        //    "scrollX": true,
        //    "paging": true,
        //    "pageLength": 5,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "ordering": false,
        //    "info": false,
        //    "fnInitComplete": function () {
        //        this.css("visibility", "visible");
        //    }
        //});

        $('#ContractAttachTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });

        //$('#salesPeriodTbl').dataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 5,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "ordering": false,
        //    "info": false,
        //});

        $('#salesPersonTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });

        $('#submitIRTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });

        $('#PIRstatushistoryTbl').dataTable({
            "scrollY": true,
            "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });

        $('#printInvoiceTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });

        //$('#MilestoneTable').dataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 5,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "ordering": false,
        //    "info": false,
        //});

        //$('#DeliverablesTable').dataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 5,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "ordering": false,
        //    "info": false,
        //});

        $('#ExpensesTable').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });

        $('#ProjectTimesheetTable').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
            columnDefs: [{ width: 150, targets: 4 }],
            fixedColumns: true,
        });

        $('#IRAShowHistoryTable').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
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
            $('#IRPIR_Tbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 288, "overflow-y": "auto" });
            // $('#IRPIR_EditblDetails_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 457, "overflow-y": "auto" });
            // $('#IRPIR_EditDetailsTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 457, "overflow-y": "auto" });
            // $('#ProjectTimesheetTable_wrapper .dataTables_scroll').css({ 'height': tblheight - 390, "overflow-y": "auto" });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $(document).ready(function () {
            $("#IRPIRAprvltbl_wrapper .dataTable").resize();

            //$("span.INRCurncy").append('<i class="fas fa-rupee-sign iconBlue"></i>');
            //$("span.USDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
            GetStatusType();
            $('#ExpensesTable').DataTable();
        });

        /*
       Created By : Vishal Mane
       Created Date : 03/11/2023
       Purpose : To dispaly the list of IR/PIR's for selected project
       */
        function GetIRPIRList(ID) {
           
            var strHTML = "";
            var IR = "IR";
            var PIR = "PIR";
            var NA = "NA";
            var ProjectID;
            $("#IRPIR_Tbl").dataTable().fnDestroy();
            if (ID == null || ID == "" || ID == undefined || ID == "0") {
                ProjectID = $("#cboProject").val();
                if (ProjectID == null || ProjectID == undefined || ProjectID == 0) {
                    ProjectID = SessionProjectID;
                }
            }
            else {
                ProjectID = ID;
            }

            GetGlobalCurrencies(ProjectID);
            //var ProjectID = $("#cboProject").val();
            var RFIID = $("#cboIRPIR").val();
            var RFITypeID = $("#cboType").val();
            var Status = $("#cboStatus").find(":selected").text();

            if (RFIID == 1) {
                RFIID = "";
            }
            if (RFIID == 2) {
                RFIID = 0;
            }
            if (RFIID == 3) {
                RFIID = 1;
            }
            var ProjectDetails = {
                ProjectID: encodeURI(ProjectID),
                RFIID: encodeURI(RFIID),
                RFITypeID: encodeURI(RFITypeID),
                Status: Status,
            }
            var param = JSON.stringify(ProjectDetails)
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetIRPIRList", param, false);
            if (strResult.length != 0) {
                var openBracket = "(";
                var closeBracket = ")";
                var blueText = $('<span class="blue-text">' + CompanyBaseCurrencySymbol + '</span>');
                var blueText1 = $('<span class="blue-text">' + CorporateBaseCurrencySymbol + '</span>');
                var blueText2 = $('<span class="blue-text">' + CompanyBaseCurrencySymbol + '</span>');                
                //var blueText = $('<span class="blue-text">' + strResult[0].BaseCurrencySymbol + '</span>');
                //var blueText1 = $('<span class="blue-text">' + CorpCurrencySymbol + '</span>');
                //var blueText2 = $('<span class="blue-text">' + strResult[0].BaseCurrencySymbol + '</span>');
                $("#txtCorpCurrencyCode").text('Equiv. ' + BaseCurrency + '');
                $("#txtCompCurrencyCode").text('Amount ' + CompanyBaseCurrencyCode + '');
                $("#Fil_EquivAmountSign").text(strResult[0].BaseCurrencyCode);

                $("#txtCorpCurrencyCode").append(openBracket, blueText1, closeBracket);
                $("#txtCorpCurrencyCode").append(" Amount (Corporate base)");
                $("#txtCompCurrencyCode").append(openBracket, blueText2, closeBracket);
                $("#txtCompCurrencyCode").append("(Company Base)");
                $("#Fil_EquivAmountSign").append(openBracket, blueText, closeBracket);

                if (strResult.length != 0) { 
                    $.each(strResult, function (index, obj) {
                     //   alert(JSON.stringify(obj));
                        var Invoicegenerated = obj.InvoiceGenerated;
                        var CurrentStatus = obj.CurrentStatus;
                        var Amount = obj.Amount;
                        strHTML += '<tr><td class="text-centre">' + obj.RFIID + '<input hidden type="text" value=' + obj.RFIID + '></td>';
                        if (obj.IsProforma == false) {
                            if (EditAccess == 'True' || ViewAccess == 'True') {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit" onclick="EditIRPIR(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\', 0);" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_2ndEdit_Screen" aria - controls="offcanvasWithBothOptions">' + IR + '</a></td>';
                            } else {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit">' + IR + '</a></td>';
                            }
                        } else {
                            if (EditAccess == 'True' || ViewAccess == 'True') {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit" onclick="EditIRPIR(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\', 0);" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_2ndEdit_Screen" aria - controls="offcanvasWithBothOptions">' + PIR + '</a></td>';
                            } else {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit">' + PIR + '</a></td>';
                            }

                        }
                        strHTML += '<td class="text-centre">' + obj.ProjectName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.RFITypeName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.RFIRaisedOn + '</td>';
                        //if (obj.BillingCurrencyCode == "INR") {
                        //    strHTML += '<td><span class="INRCurncy"><i class="fas fa-rupee-sign iconBlue"></i></span>' + obj.Amount + '</td>';
                        //} else if (obj.BillingCurrencyCode == "USD") {
                        //    strHTML += '<td><span class="USDCurncy"><i class="fas fa-dollar-sign iconBlue"></i></i></span>' + obj.Amount + '</td>';
                        //}
                        //Added space after span to get space between symbol and amount by Vishal Mane on 02/01/2023
                        strHTML += '<td><span class="blue-text">' + obj.BillingCurrencySymbol + '</span> ' + obj.Amount + '</td>';
                        strHTML += '<td class="text-centre">' + obj.EquivAmount + '</td>';
                        //if (obj.BaseCurrencyCode == "INR") {
                        //    strHTML += '<td><span class="INRCurncy"><i class="fas fa-rupee-sign iconBlue"></i></span>' + obj.CompanyBaseCurrencyAmount + '</td>';
                        //} else if (obj.BaseCurrencyCode == "USD") {
                        //    strHTML += '<td><span class="USDCurncy"><i class="fas fa-dollar-sign iconBlue"></i></i></span>' + obj.CompanyBaseCurrencyAmount + '</td>';
                        //}
                        //Added space after span to get space between symbol and amount by Vishal Mane on 02/01/2023
                        strHTML += '<td><span class="blue-text">' + obj.BaseCurrencySymbol + '</span> ' + obj.CompanyBaseCurrencyAmount + '</td>';
                        //Added Commented By Dipali V On 21st Feb 2024 For Hide Copy Link
                        //if (EditAccess == 'True' || ViewAccess == 'True') {
                        //    strHTML += '<td class="text-centre"><a href="javascript:;" onclick="ConfirmCopyIR(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\', 1)"><i class="far fa-copy" style="color: grey;" data-bs-toggle="tooltip" title="Copy IR"></i></a></td>';
                        //} else {
                        //    strHTML += '<td class="text-centre"><a href="javascript:;"><i class="far fa-copy" data-bs-toggle="tooltip" title="Copy IR"></i></a></td>';
                        //}
                        //Commented By Dipali V On 21st Feb 2024 For Hide Copy Link
                        //strHTML += '<td class="text-centre"><a href="javascript:;" onclick="EditIRPIR(' + obj.RFIID + ', 1)" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_2ndEdit_Screen" aria-controls="offcanvasWithBothOptions"><i class="far fa-copy" data-bs-toggle="tooltip" title="Copy IR"></i></a></td>';
                        if (obj.CurrentStatus == "Submitted") {
                            strHTML += "<td><span class='statusBox statusSubmitted mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Submitted'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Approved") {
                            strHTML += "<td><span class='statusBox statusApproved mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Approved'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Rejected") {
                            strHTML += "<td><span class='statusBox statusRejected mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Rejected'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Re-Submitted") {
                            strHTML += "<td><span class='statusBox statusReSubmitted mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Re-Submitted'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Cancelled") {
                            strHTML += "<td><span class='statusBox statusCancelled mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Cancelled'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Closed") {
                            strHTML += "<td><span class='statusBox statusClosed mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Closed'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Draft") {
                            strHTML += "<td><span class='statusBox statusDraft mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Draft'>" + obj.CurrentStatus + "</label></a></td>";
                        }
                        else if (obj.CurrentStatus == "Revenue Reversed" || obj.CurrentStatus == "Partially Reversed") {
                            strHTML += "<td><span class='statusBox statusDraft mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Draft'>" + obj.CurrentStatus + "</label></a></td>";
                        }
                        else {
                            strHTML += "<td><span class='statusBox statusDraft mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Unknown'>" + obj.CurrentStatus + "</label></a></td>";
                        }
                        strHTML += '<td class="text-centre"><a href="javascript:;" id="cboInvoiceNumber' + obj.RFIID +'"  onclick="GetInvoiceNo(this.id);" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ViewReport" aria - controls="offcanvasWithBothOptions" ><i class="fas fa-print text-danger"  data-bs-toggle="tooltip" title="Print IR Report"></i></a ></td>';
                        if (Invoicegenerated == false) {
                            strHTML += "<td class='text-centre'>" + NA + "</td>";
                        } else {
                            strHTML += '<td class="text-centre"><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_PrintInvoice" onclick = GetInvoiceList(' + obj.RFIID + '); aria - controls="offcanvasWithBothOptions" ><i class="fas fa-print text-danger" data-bs-toggle="tooltip" title="Print Invoice"></i></a></td>';
                        }
                        //if (CurrentStatus == "Submitted" || CurrentStatus == "Closed" || (CurrentStatus == "Draft" && Amount == "0.00")) {
                        //    strHTML += "<td class='text-centre'>" + NA + "</td>";
                        //} else {
                        //    strHTML += '<td class="text-centre"><a href="javascript:;" onclick = GetRFIChecklistItems(' + obj.RFIID + ');><i class="fas fa-share-square" style="color: grey;" data-bs-toggle="tooltip" title="Submit IR"></i></a></td>';
                        //}

                        if (CurrentStatus == "Submitted" || CurrentStatus == "Closed" || CurrentStatus == "Re-Submitted" || CurrentStatus == "Cancelled" || obj.CurrentStatus == "Approved" || (CurrentStatus == "Draft" && Amount == "0.000")) {
                            strHTML += "<td class='text-centre'>" + NA + "</td>";
                        } else if (CurrentStatus == "Rejected") {
                            strHTML += '<td class="text-centre"><a href="javascript:;" onclick = "GetRFIChecklistItems(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\',4,' + obj.ContractID + ')"><i class="fas fa-share-square" style="color: grey;" data-bs-toggle="tooltip" title="Resubmit IR"></i></a></td>';
                        } else {
                            strHTML += '<td class="text-centre"><a href="javascript:;" onclick = "GetRFIChecklistItems(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\',4,' + obj.ContractID + ')"><i class="fas fa-share-square" style="color: grey;" data-bs-toggle="tooltip" title="Submit IR"></i></a></td>';
                        }
                       // strHTML += '<td <div class="custom_chckbox task-checkbox " type="checkbox"><input id="' + obj.RFIID + '" class="chcktask IR_Check" type="checkbox"><label for="' + obj.RFIID + '" ></label></div></td></tr> ';

                       // strHTML += '<td><div class="custom_chckbox task-checkbox " type="checkbox"><input id="' + obj.RFIID + '" class="chcktask" type="checkbox"><label for="' + obj.RFIID + '" ></label></div></td></tr> ';
                        strHTML += '<td><div class="custom_chckbox task-checkbox " type="checkbox"><input id="' + obj.RFIID + '" class="chcktask" type="checkbox" onchange="ChkUnChkHead();"><label for="' + obj.RFIID + '" ></label></div></td></tr> ';

                       // strHTML += '<td><input id="' + obj.RFIID + '" class="chcktask" type="checkbox" onchange="ChkUnChkHead();"><label for="' + obj.RFIID + '" ></label></td></tr> ';
                    });
                }
            }


            $("#IRPIR_Tbl_Body").html(strHTML);

           $('#IRPIR_Tbl').DataTable({
                "paging": true,
                "pageLength": 8,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                "bAutoWidth": false,
           });
        }



        /*
        Created By : Vishal Mane
        Created Date : 06/11/2023
        Purpose : To get Status Type List
        */
        function GetStatusType() {
            //
            var strHTML = "";
            $("#cboStatus").html("");
            /*var param = JSON.stringify(parameter)*/
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetStatusType", '', false);
            for (var i = 0; i < strResult.length; i++) {
                var obj = strResult[i];
                strHTML += '<option value=' + obj.ID + ' >' + obj.Status + '</option>';
                //strHTML += "<option>" + "<span class='statusBox statusApproved mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";                

                //if (obj.Status == "Submitted") {
                //    strHTML += "<option>" + "<span class='statusBox statusSubmitted mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";
                //} else if (obj.Status == "Approved") {
                //    strHTML += "<option>" + "<span class='statusBox statusApproved mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";
                //} else if (obj.Status == "Rejected") {
                //    strHTML += "<option>" + "<span class='statusBox statusRejected mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";
                //} else if (obj.Status == "Re-submitted") {
                //    strHTML += "<option>" + "<span class='statusBox statusReSubmitted  mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";
                //} else if (obj.Status == "Cancelled") {
                //    strHTML += "<option>" + "<span class='statusBox statusCancelled  mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";
                //} else if (obj.Status == "Closed") {
                //    strHTML += "<option>" + "<span class='statusBox statusClosed  mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";
                //} else if (obj.Status == "Draft") {
                //    strHTML += "<option>" + "<span class='statusBox statusDraft  mx-2'>&nbsp;</span>" + "<label>" + obj.Status + "</label>" + "</option>";
                //}
            }
            $("#cboStatus").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        /*
         Created By : Vishal Mane
         Created Date : 06/11/2023
         Purpose : To save filter query for IR/PIR filter
         */
        function SaveFilterQuery(flag) {

            var IsFilterFlag = 0;
            var IsAllowTosave = 0;
            var IsOnlyApplyFlag;
            var FilterID = $("#txtFilterID").val();
            if (flag == undefined) {
                /* IsOnlyApplyFlag = '';*/
                if (FilterID == undefined || FilterID == "") {
                    IsFilterFlag = ValidateFilterName();
                    if (IsFilterFlag == 0) {
                        IsOnlyApplyFlag = '';
                        IsAllowTosave = 0;
                    } else {
                        IsAllowTosave = 1;
                    }
                } else {
                    IsOnlyApplyFlag = '';
                    IsAllowTosave = 0;
                }

            } else {
                IsOnlyApplyFlag = flag;
            }
            if (IsAllowTosave == 0) {
                var UserName = '<%= Session("strUserName") %>';
                if (FilterID == null || FilterID == undefined || FilterID == "") {
                    FilterID = 0;
                }
                var IsProforma = $("#cboIRPIRFilter").val();
                if (IsProforma == 1 || IsProforma == null || IsProforma == undefined) {
                    IsProforma = '';
                }
                //var Status = $("#cboStatusFilter").val();
                var Status = $("#cboStatusFilter").find(":selected").text();
                if (Status == "Select Status") {
                    Status = '';
                }
                var RFITypeID = $("#cboTypeFilter").val();
                if (RFITypeID == 0 || RFITypeID == null || RFITypeID == undefined) {
                    RFITypeID = '';
                }
                var ProjectID = $("#cboProjectFilter").val();
                if (ProjectID == 0 || ProjectID == null || ProjectID == undefined) {
                  ProjectID = $("#cboProject").val();             
                }
                //Ajit
                //if (ProjectID == 0 || ProjectID == null || ProjectID == undefined) {
                //    ProjectID = 0
                //} 
                //else {
                //    ProjectID = $("#cboProject").val();
                //}
                var BillingCurrencyCode = $("#cboCurrencyFilter").find(":selected").text();
                if (BillingCurrencyCode == "Currency") {
                    BillingCurrencyCode = '';
                }
                var RFIRaisedOn = $("#Fil_RaisedOnDate").val();


                var BillingCurrencyAmount = $("#Fil_Amount").val();
                var formattedBillingCurrencyAmount;
                if (BillingCurrencyAmount != "") {
                    formattedBillingCurrencyAmount = parseFloat(BillingCurrencyAmount) % 1 === 0
                        ? parseInt(BillingCurrencyAmount, 10)
                        : parseFloat(BillingCurrencyAmount);
                } else {
                    formattedBillingCurrencyAmount = "";
                }

                var BaseCurrencyAmount = $("#Fil_AmountCB").val();
                var formattedBaseCurrencyAmount;
                if (BaseCurrencyAmount != "") {
                    formattedBaseCurrencyAmount = parseFloat(BaseCurrencyAmount) % 1 === 0
                        ? parseInt(BaseCurrencyAmount, 10)
                        : parseFloat(BaseCurrencyAmount);
                } else {
                    formattedBaseCurrencyAmount = "";
                }

                var EquivAmount = $("#Fil_EquivAmount").val();
                var formattedEquivAmount;
                if (EquivAmount != "") {
                    formattedEquivAmount = parseFloat(EquivAmount) % 1 === 0
                        ? parseInt(EquivAmount, 10)
                        : parseFloat(EquivAmount);
                } else {
                    formattedEquivAmount = "";
                }


                var filterData = {
                    'ProjectID': encodeURI(ProjectID),
                    'BillingCurrencyCode': encodeURI(BillingCurrencyCode),
                    //'BillingCurrencyAmount': encodeURI($("#Fil_Amount").val()),
                    'BillingCurrencyAmount': encodeURI(formattedBillingCurrencyAmount),
                    'RFIID': encodeURI($("#Fil_IRID").val()),
                    'IsProforma': encodeURI(IsProforma),
                    'RFIRaisedOn': RFIRaisedOn,
                    'Status': encodeURI(Status),
                    'RFITypeID': encodeURI(RFITypeID),
                    //'BaseCurrencyAmount': encodeURI($("#Fil_AmountCB").val()),
                    'BaseCurrencyAmount': encodeURI(formattedBaseCurrencyAmount),
                    'EquivAmount': encodeURI(formattedEquivAmount),
                    'FilterName': encodeURI($("#txtFilterName").val()),
                    //'BaseCurrencyAmount': encodeURI($("#Fil_AmountCB").val()),
                    'FilterID': FilterID,
                    'CreatedBy': UserName,
                    'IsOnlyApplyFlag': IsOnlyApplyFlag,
                }

                //$("#cboStatus").find(":selected").text();
                var param = JSON.stringify(filterData)
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/SaveFilterQuery", param, false);
                if (strResult.length != 0) {

                    $.each(strResult, function (index, obj) {
                        if (obj.Result == 0) { //if obj.Result == 0 or 1 >> To apply filter only

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('<%=MyBase.GetResourceString("C_FilterApply")%>');
                            var whereClause = obj.WhereClause;
                            var FilterIDforUpdate = obj.FilterIDforUpdation;
                            ApplyFilterData(whereClause);
                        }
                        else if (obj.Result == 1) {
                            //
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('<%=MyBase.GetResourceString("C_FilterApply")%>');
                            var whereClause = obj.WhereClause;
                            var FilterIDforUpdate = obj.FilterIDforUpdation;
                            ApplyFilterData(whereClause);
                            //MyFilters(ProjectID);
                        } else if (obj.Result == 2) {                       //if obj.Result == 2 >> Save or update filter
                            //
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('<%=MyBase.GetResourceString("C_FilterApply")%>');
                            var whereClause = obj.WhereClause;
                            var FilterIDforUpdate = obj.FilterIDforUpdation;
                            ApplyFilterData(whereClause);
                            MyFilters(ProjectID, FilterIDforUpdate);
                            $("#cboProjectFilter").val(0);
                            $("#Fil_Amount").val("");
                            $("#Fil_IRID").val("");
                            $("#Fil_RaisedOnDate").val("");
                            $("#Fil_AmountCB").val("");
                            $("#Fil_EquivAmount").val("");
                            $("#txtFilterID").val("");
                            $("#txtFilterName").val("");
                            /* $("#cboProjectFilter").val(0);*/
                            $("#cboIRPIRFilter").val(1);
                            $("#cboCurrencyFilter").val(0);
                            var textStatus = $("#cboStatusFilter").find(":selected").text();
                            if (textStatus != "Select Status") {
                                $("#cboStatusFilter").val(0);
                                $("#cboStatusFilter").find(":selected").text("Select Status");
                            }
                            $("#cboTypeFilter").val(0);
                            $(".selectpicker").selectpicker('refresh');
                            updateFilter(FilterIDforUpdate);

                        }
                    });
                    $("#Issuesavefilter").modal('hide');
                    //MyFilters(ProjectID);

                }

            }
        }


        /*
       Created By : Vishal Mane
       Created Date : 07/11/2023
       Purpose : To Validate Filter Name for IR/PIR filter
       */
        function ValidateFilterName() {
            var IsFilterFlag = 0;
            //var FilterName = $("#txtFilterName").val();
            var FilterName = $("#txtFilterName").val().trim();
            //Filtername value trimed by Ajit L to restrict blank space in filter Name on 21/12/2023
            if (FilterName == "" || FilterName == undefined) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("C_FilterBlank")%>');
                IsFilterFlag = 1;
                return IsFilterFlag
            }
            var filterData = {
                FilterName: encodeURI(FilterName),
            }
            var param = JSON.stringify(filterData)
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateFilterName", param, false);
            if (strResult == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_FNameAlredyExist")%>');
                IsFilterFlag = 1;
                return IsFilterFlag;
            } else {
                IsFilterFlag = 0;
                return IsFilterFlag;
            }

        }



        /*
       Created By : Vishal Mane
       Created Date : 07/11/2023
       Purpose : To apply filter for IR/PIR filter
       */
        function ApplyFilterData(whereClause) {

            //$("#AdvanceFilterIcon").prop("aria-expanded", true);   
            var strHTML = "";
            var IR = "IR";
            var PIR = "PIR";
            var NA = "NA";
            $("#IRPIR_Tbl").dataTable().fnDestroy();
            var filterData = {
                whereClause: whereClause,
            }
            var param = JSON.stringify(filterData)
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ApplyFilterData", param, false);
            if (strResult.length != 0) {
                var ProjectID = strResult[0].ProjectID;
                GetGlobalCurrencies(ProjectID);
                var openBracket = "(";
                var closeBracket = ")";
                var blueText = $('<span class="blue-text">' + CompanyBaseCurrencySymbol + '</span>');
                var blueText1 = $('<span class="blue-text">' + CorporateBaseCurrencySymbol + '</span>');
                var blueText2 = $('<span class="blue-text">' + CompanyBaseCurrencySymbol + '</span>');                
                //var blueText = $('<span class="blue-text">' + strResult[0].BaseCurrencySymbol + '</span>');
                //var blueText1 = $('<span class="blue-text">' + CorpCurrencySymbol + '</span>');
                //var blueText2 = $('<span class="blue-text">' + strResult[0].BaseCurrencySymbol + '</span>');
                $("#txtCorpCurrencyCode").text('Equiv. ' + BaseCurrency + '');
                $("#txtCompCurrencyCode").text('Amount ' + CompanyBaseCurrencyCode + '');
                $("#Fil_EquivAmountSign").text(strResult[0].BaseCurrencyCode);

                $("#txtCorpCurrencyCode").append(openBracket, blueText1, closeBracket);
                $("#txtCorpCurrencyCode").append(" Amount (Corporate base)");
                $("#txtCompCurrencyCode").append(openBracket, blueText2, closeBracket);
                $("#txtCompCurrencyCode").append("(Company Base)");
                $("#Fil_EquivAmountSign").append(openBracket, blueText, closeBracket);

                if (strResult.length != 0) {
                    
                    $.each(strResult, function (index, obj) {
                        //
                        var Invoicegenerated = obj.InvoiceGenerated;
                        var CurrentStatus = obj.CurrentStatus;
                        var Amount = obj.Amount;
                        strHTML += '<tr><td class="text-centre">' + obj.RFIID + '<input hidden type="text" value=' + obj.RFIID + '></td>';
                        if (obj.IsProforma == false) {
                            if (EditAccess == 'True' || ViewAccess == 'True') {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit" onclick="EditIRPIR(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\', 0)" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_2ndEdit_Screen" aria - controls="offcanvasWithBothOptions">' + IR + '</a></td>';
                            } else {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit">' + IR + '</a></td>';
                            }
                        } else {
                            if (EditAccess == 'True' || ViewAccess == 'True') {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit" onclick="EditIRPIR(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\', 0)" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_2ndEdit_Screen" aria - controls="offcanvasWithBothOptions">' + PIR + '</a></td>';
                            } else {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit">' + PIR + '</a></td>';
                            }

                        }
                        strHTML += '<td class="text-centre">' + obj.ProjectName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.RFITypeName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.RFIRaisedOn + '</td>';
                        //if (obj.BillingCurrencyCode == "INR") {
                        //    strHTML += '<td><span class="INRCurncy"><i class="fas fa-rupee-sign iconBlue"></i></span>' + obj.Amount + '</td>';
                        //} else if (obj.BillingCurrencyCode == "USD") {
                        //    strHTML += '<td><span class="USDCurncy"><i class="fas fa-dollar-sign iconBlue"></i></i></span>' + obj.Amount + '</td>';
                        //}
                        //Added space after span to get space between symbol and amount by Vishal Mane on 02/01/2023
                        strHTML += '<td><span class="blue-text">' + obj.BillingCurrencySymbol + '</span> ' + obj.Amount + '</td>';
                        strHTML += '<td class="text-centre">' + obj.EquivAmount + '</td>';
                        //if (obj.BaseCurrencyCode == "INR") {
                        //    strHTML += '<td><span class="INRCurncy"><i class="fas fa-rupee-sign iconBlue"></i></span>' + obj.CompanyBaseCurrencyAmount + '</td>';
                        //} else if (obj.BaseCurrencyCode == "USD") {
                        //    strHTML += '<td><span class="USDCurncy"><i class="fas fa-dollar-sign iconBlue"></i></i></span>' + obj.CompanyBaseCurrencyAmount + '</td>';
                        //}
                        //Added space after span to get space between symbol and amount by Vishal Mane on 02/01/2023
                        strHTML += '<td><span class="blue-text">' + obj.BaseCurrencySymbol + '</span> ' + obj.CompanyBaseCurrencyAmount + '</td>';
                        //Added Commented By Dipali V On 21st Feb 2024 For Hide Copy Link
                        //if (EditAccess == 'True' || ViewAccess == 'True') {
                        //    strHTML += '<td class="text-centre"><a href="javascript:;" onclick="ConfirmCopyIR(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\', 1)"><i class="far fa-copy" style="color: grey;" data-bs-toggle="tooltip" title="Copy IR"></i></a></td>';
                        //} else {
                        //    strHTML += '<td class="text-centre"><a href="javascript:;"><i class="far fa-copy" data-bs-toggle="tooltip" title="Copy IR"></i></a></td>';
                        //}
                        //Commented By Dipali V On 21st Feb 2024 For Hide Copy Link
                        //strHTML += '<td class="text-centre"><a href="javascript:;" onclick="EditIRPIR(' + obj.RFIID + ', 1)" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_2ndEdit_Screen" aria-controls="offcanvasWithBothOptions"><i class="far fa-copy" data-bs-toggle="tooltip" title="Copy IR"></i></a></td>';
                        if (obj.CurrentStatus == "Submitted") {
                            strHTML += "<td><span class='statusBox statusSubmitted mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Submitted'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Approved") {
                            strHTML += "<td><span class='statusBox statusApproved mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Approved'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Rejected") {
                            strHTML += "<td><span class='statusBox statusRejected mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Rejected'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Re-Submitted") {
                            strHTML += "<td><span class='statusBox statusReSubmitted mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Re-Submitted'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Cancelled") {
                            strHTML += "<td><span class='statusBox statusCancelled mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Cancelled'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Closed") {
                            strHTML += "<td><span class='statusBox statusClosed mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Closed'>" + obj.CurrentStatus + "</label></a></td>";
                        } else if (obj.CurrentStatus == "Draft") {
                            strHTML += "<td><span class='statusBox statusDraft mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Draft'>" + obj.CurrentStatus + "</label></a></td>";
                        }
                        else if (obj.CurrentStatus == "Revenue Reversed" || obj.CurrentStatus == "Partially Reversed") {
                            strHTML += "<td><span class='statusBox statusDraft mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Draft'>" + obj.CurrentStatus + "</label></a></td>";
                        }
                        else {
                            strHTML += "<td><span class='statusBox statusDraft mx-2'>&nbsp;</span><a href='javascript: ;' data-bs-toggle='modal' onclick = GetRFIStatusHistory(" + obj.RFIID + ") data-bs-target='#IRPIR_StatHistorymodal'><label class='crsrLink' data-bs-toggle='tooltip' title='Unknown'>" + obj.CurrentStatus + "</label></a></td>";
                        }
                        strHTML += '<td class="text-centre"><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ViewReport" aria - controls="offcanvasWithBothOptions" ><i class="fas fa-print text-danger" data-bs-toggle="tooltip" title="Print IR Report"></i></a ></td>';
                        if (Invoicegenerated == false) {
                            strHTML += "<td class='text-centre'>" + NA + "</td>";
                        } else {
                            strHTML += '<td class="text-centre"><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_PrintInvoice" onclick = GetInvoiceList(' + obj.RFIID + '); aria - controls="offcanvasWithBothOptions" ><i class="fas fa-print text-danger"  data-bs-toggle="tooltip" title="Print Invoice"></i></a></td>';
                        }
                        //if (CurrentStatus == "Submitted" || CurrentStatus == "Closed" || (CurrentStatus == "Draft" && Amount == "0.00")) {
                        //    strHTML += "<td class='text-centre'>" + NA + "</td>";
                        //} else {
                        //    strHTML += '<td class="text-centre"><a href="javascript:;" onclick = GetRFIChecklistItems(' + obj.RFIID + ');><i class="fas fa-share-square" style="color: grey;" data-bs-toggle="tooltip" title="Submit IR"></i></a></td>';
                        //}
                        if (CurrentStatus == "Submitted" || CurrentStatus == "Closed" || CurrentStatus == "Re-Submitted" || CurrentStatus == "Cancelled" || obj.CurrentStatus == "Approved" || (CurrentStatus == "Draft" && Amount == "0.000")) {
                            strHTML += "<td class='text-centre'>" + NA + "</td>";
                        } else if (CurrentStatus == "Rejected") {
                            strHTML += '<td class="text-centre"><a href="javascript:;" onclick = "GetRFIChecklistItems(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\',0,' + obj.ContractID + ')"><i class="fas fa-share-square" style="color: grey;" data-bs-toggle="tooltip" title="Resubmit IR"></i></a></td>';
                        } else {
                            strHTML += '<td class="text-centre"><a href="javascript:;" onclick = "GetRFIChecklistItems(' + obj.RFIID + ', \'' + obj.CurrentStatus + '\',0,' + obj.ContractID + ')"><i class="fas fa-share-square" style="color: grey;" data-bs-toggle="tooltip" title="Submit IR"></i></a></td>';
                        }
                        //strHTML += '<td> <div class="custom_chckbox task-checkbox " type="checkbox"><input id="' + obj.RFIID + '" class="chcktask IR_Check" type="checkbox"><label for="' + obj.RFIID + '"></label></div></td></tr> ';
                        strHTML += '<td><div class="custom_chckbox task-checkbox " type="checkbox"><input id="' + obj.RFIID + '" class="chcktask" type="checkbox" onchange="ChkUnChkHead();"><label for="' + obj.RFIID + '" ></label></div></td></tr> ';
                        //Added & commented by Ajit L for check uncheck all on 21/12/2023

                    });
                }
            }

            $("#IRPIR_Tbl_Body").html(strHTML);
            G_IRPIR_Tbl = $('#IRPIR_Tbl').DataTable({
                "paging": true,
                "pageLength": 8,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                "bAutoWidth": false,
                /* "dom": '<"pagination-container"p>rt',*/
            });

        }



        /*
       Created By : Vishal Mane
       Created Date : 07/11/2023
       Purpose : To get My Filters list for IR/PIR filter
       */
        var G_FilterId = 0;
        function MyFilters(ID, FilterID) {

            var strHTML = "";
            var ProjectID;

            if (ID == null || ID == "" || ID == undefined || ID == "0") {
                ProjectID = $("#cboProject").val();
            }
            else {
                ProjectID = ID;
            }
            $("#MyFiltersdropdown").empty();
            //var ProjectID = $("#cboProject").val();
            var FilterFields = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(FilterFields)
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetFilterList", param, false);
            if (Result.length != 0) {
                if (FilterID == null || FilterID == "" || FilterID == undefined || FilterID == "0") {
                    for (var i = 0; i < Result.length; i++) {
                        if (Result[i]["SetDefault"] === true) {
                            G_FilterId = Result[i]["FilterID"];
                            break;
                        }
                        else {
                            G_FilterId = 0;
                        }
                    }
                } else {
                    G_FilterId = FilterID;
                }

                for (var i = 0; i < Result.length; i++) {
                    strHTML += "<li>";

                    if (Result[i]["SetDefault"] === true) {
                        strHTML += "<label class='customradio'>";
                        strHTML += "<input type='hidden' name='hdnrm_filterid' id='hdnrm_filterid' value='" + Result[i]["FilterID"] + "' class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom'>"
                        strHTML += "<input id='" + Result[i]["FilterID"] + "' type='radio'  value='" + Result[i]["FilterID"] + "' onclick='SetDefaultFilter(this.id);' checked='checked' class='setDefaultFilter'>"
                        strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Remove Default filter' class='checkmark'></span>";
                        strHTML += "</label>";
                        updateFilter(Result[i]["FilterID"]);
                    }

                    else {
                        strHTML += "<label class='customradio'>";
                        strHTML += "<input type='hidden' name='hdnrm_filterid' id='hdnrm_filterid' value='" + Result[i]["FilterID"] + "' class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom'>"
                        strHTML += "<input id='" + Result[i]["FilterID"] + "' type='radio' value='" + Result[i]["FilterID"] + "' onclick='SetDefaultFilter(this.id);'>"
                        strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Set Default filter' class='checkmark'></span>";
                        strHTML += "</label>";
                    }

                    strHTML += "<label>";
                    strHTML += "<span class='radiotextsty filtername'>" + Result[i]["FilterName"] + "</span>"
                    strHTML += "</label>";

                    strHTML += "<div class='custom_chckbox_markblue'>";

                    if (Result[i]["ApplyDefault"] === true) {
                        strHTML += "<input id='RiskselproOne_" + Result[i]["FilterID"] + "' checked='checked' type='checkbox' name=''>";
                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + Result[i]["FilterID"] + "' id='" + Result[i]["FilterID"] + "' onclick='ApplyFilter(this.id);'></label>";
                    } else {
                        strHTML += "<input id='RiskselproOne_" + Result[i]["FilterID"] + "' type='checkbox' name=''>";
                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + Result[i]["FilterID"] + "' id='" + Result[i]["FilterID"] + "' onclick='ApplyFilter(this.id);'></label>";
                    }

                    strHTML += "</div>";
                    strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter ml-1'>";
                    strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Edit filter' id='" + Result[i]["FilterID"] + "' class='fas fa-pencil-alt' onclick='updateFilter(this.id);'></i>";
                    strHTML += "</span>";

                    strHTML += "<span class='ml-1'>";
                    strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + Result[i]["FilterID"] + "' class='far fa-trash-alt' onclick='deleteFilter(this.id);'></i>";
                    strHTML += "</span>";

                    strHTML += "</li>";
                }
            }
            else {
                G_FilterId = 0;
            }

            $("#MyFiltersdropdown").append(strHTML);
            if (G_FilterId > 0) {

                /*ApplySavedFilter(G_FilterId);*/
                AppliedFilter(G_FilterId);
                $("#PMProjectReviewClearAllFilter").show();
                clearAllFlag = 0;
            }
            else {
                GetIRPIRList(ProjectID);
                $("#PMProjectReviewClearAllFilter").hide();
                clearAllFlag = 1;
            }

        }

        /*
       Created By : Vishal Mane
       Created Date : 07/11/2023
       Purpose : To delete filter for IR/PIR filter
       */
        function deleteFilter(Id) {
            var ProjectID = $("#cboProject").val();
            var FilterFields = {
                FilterID: Id
            }
            var param = JSON.stringify(FilterFields)
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/DeleteFilterById", param, false);
            if (Result == 'Deleted') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_FilterDelete")%>');
            }
            MyFilters(ProjectID);
        }

        /*
        Created By : Vishal Mane
        Created Date : 07/11/2023
        Purpose : To update filter for IR/PIR filter
        */
        function updateFilter(Id) {
            //

            var FilterFields = {
                FilterID: Id
            }
            var param = JSON.stringify(FilterFields)
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetDefaultWhereClase", param, false);
            var WhereClause = Result[0]["WhereClause"];
            //var conditions = WhereClause.replace(/LIKE/g, '=').replace(/%/g, '').replace(/1 = 1/g, '');
            // var conditions = WhereClause.replace(/LIKE/g, '=').replace(/%/g, '').replace(/1 = 1/g, '').replace(/RFI\./g, '').replace(/BIL\./g, '');
            var conditions = WhereClause.replace(/LIKE/g, '=').replace(/%/g, '').replace(/1 = 1/g, '').replace(/RFI\./g, '').replace(/BIL\./g, '').replace(/CONVERT\(NVARCHAR, (\w+), 106\) = '([^']+)'/g, '$1 = \'$2\'');

            var conditions = conditions.split(' AND ');
            var FilterField = {};

            // Iterate through conditions and extract key-value pairs
            conditions.forEach(function (condition) {
                var parts = condition.split('=');
                if (parts.length === 2) {
                    var key = parts[0].trim();
                    var value = parts[1].trim().replace(/'/g, '')
                    FilterField[key] = value;
                }
            });


            $("#cboProjectFilter").val(FilterField.ProjectID);
            //$("#Fil_Amount").val(FilterField.BillingCurrencyAmount);
            $("#Fil_Amount").val(FilterField.BillingCurrencyAmount);
            $("#Fil_IRID").val(FilterField.RFIID);
            if (FilterField.IsProforma == "" || FilterField.IsProforma == undefined || FilterField.IsProforma == null) {
                $("#cboIRPIRFilter").val(1);
            } else if (FilterField.IsProforma == "0") {
                $("#cboIRPIRFilter").val(2);
            } else {
                $("#cboIRPIRFilter").val(3);
            }
            $("#Fil_RaisedOnDate").val(FilterField.RFIRaisedOn);
            $("#cboStatusFilter").find(":selected").text(FilterField.CurrentStatus);
            if (FilterField.RFITypeID == "" || FilterField.RFITypeID == undefined || FilterField.RFITypeID == null) {
                $("#cboTypeFilter").val(0);
            } else {
                $("#cboTypeFilter").val(FilterField.RFITypeID);
            }
            $("#Fil_AmountCB").val(FilterField.CompanyBaseCurrencyAmount);
            $("#Fil_EquivAmount").val(FilterField.BaseCurrencyAmount);
            $("#txtFilterID").val(Result[0]["FilterID"]);
            $("#txtFilterName").val(Result[0]["FilterName"]);

            $(".selectpicker").selectpicker('refresh')

        }


        /*
       Created By : Vishal Mane
       Created Date : 07/11/2023
       Purpose : To set filter for IR/PIR filter
       */
        function SetDefaultFilter(FilterID) {
            //
            var ProjectID = $("#cboProject").val();
            var FilterFields = {
                FilterID: FilterID,
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(FilterFields)
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/SetDefaultFilter", param, false);
            if (Result == 'Default Set') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_SetdefaultFilter")%>');
                clearAll();
                updateFilter(FilterID);
                MyFilters(ProjectID);
                $("#PMProjectReviewClearAllFilter").show();
                clearAllFlag = 0;
            }
            else if (Result == 'Default Removed') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_RemovedDefaultFilter")%>');
                MyFilters(ProjectID);
                GetIRPIRList();
                $("#PMProjectReviewClearAllFilter").hide();
                clearAllFlag = 1;

                $("#Fil_Amount").val("");
                $("#Fil_IRID").val("");
                $("#Fil_RaisedOnDate").val("");
                $("#Fil_AmountCB").val("");
                $("#Fil_EquivAmount").val("");
                $("#txtFilterID").val("");
                $("#txtFilterName").val("");
                $("#cboProjectFilter").val(0);
                $("#cboIRPIRFilter").val(1);
                $("#cboCurrencyFilter").val(0);
                var Status = $("#cboStatusFilter").val();
                var textStatus = $("#cboStatusFilter").find(":selected").text();
                if (textStatus != "Select Status") {
                    $("#cboStatusFilter").val(0);
                    $("#cboStatusFilter").find(":selected").text("Select Status");
                }
                $("#cboTypeFilter").val(0);
                $(".selectpicker").selectpicker('refresh');

            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 26/11/2023
        Purpose : To validate currency
        */
        $("#svfilterbtn").click(function () {
         
            var IsValidateTextField = ValidateTextField();
            
            var IsValidCurrencyCode = ValidateCurrencyCode();
           // if (IsValidCurrencyCode == 0) {
            if (IsValidCurrencyCode == 0 && IsValidateTextField == 0) {
                $("#Issuesavefilter").modal("show");
            } else {
                $("#Issuesavefilter").modal("hide");
            }
        });

        /*
       Created By : Vishal Mane
       Created Date : 07/11/2023
       Purpose : To Apply saved filter for IR/PIR filter
       */
        function ApplySavedFilter(ID) {
            var IsValidateTextField = ValidateTextField();
            var IsValidCurrencyCode = ValidateCurrencyCode();
            if (IsValidCurrencyCode == 0 && IsValidateTextField == 0) {
                var FilterID;
                if (ID == undefined) {
                    FilterID = $("#txtFilterID").val();
                    if (FilterID == undefined || FilterID == "") {
                        SaveFilterQuery(0);
                        clearAllFlag = 0;
                        $("#PMProjectReviewClearAllFilter").show();
                    } else {
                        SaveFilterQuery(1);
                        clearAllFlag = 0;
                        $("#PMProjectReviewClearAllFilter").show();
                    }
                } else {
                    var FilterFields = {
                        FilterID: ID
                    }
                    var param = JSON.stringify(FilterFields)
                    var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetDefaultWhereClase", param, false);
                    var WhereClause = Result[0]["WhereClause"];
                    ApplyFilterData(WhereClause);
                }
            }
        }

        <%--/*
        Created By : Vishal Mane
        Created Date : 08/11/2023
        Purpose : To validate the currency dropdown if amount is entered but currency code is not selected.
        */
        var IsValidCurrencyCode;
        function ValidateCurrencyCode() {
            //
            IsValidCurrencyCode = 0;
            var Amount = $("#Fil_Amount").val();
            var Currency = $("#cboCurrencyFilter").val();
            if (Amount == null || Amount == undefined || Amount == "") {
                return IsValidCurrencyCode;
            } else if (Currency == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_AmountCurrency")%>');
                IsValidCurrencyCode = 1;
                $("#cboCurrencyFilter").focus();               
                return IsValidCurrencyCode;
                $(".selectpicker").selectpicker('refresh');
            } else {
                return IsValidCurrencyCode = 0
            }
        }--%>

        /*
        Created By : Vishal Mane
        Created Date : 08/11/2023
        Purpose : To validate the amount if currency dropdown is selected but Amount is not entered.
        */
        var IsValidCurrencyCode;
        function ValidateCurrencyCode() {

            IsValidCurrencyCode = 0;
            var Amount = $("#Fil_Amount").val();
            var Currency = $("#cboCurrencyFilter").val();
            if (Currency > 0) {
                if (Amount == null || Amount == undefined || Amount == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_AmountBlank")%>');
                    IsValidCurrencyCode = 1;
                    $("#Fil_Amount").focus();
                    return IsValidCurrencyCode;
                } else {
                    return IsValidCurrencyCode = 0
                }
            } else if (Currency == 0) {
                if (Amount != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_AmountCurrency")%>');
                    IsValidCurrencyCode = 1;
                    $("#cboCurrencyFilter").focus();
                    return IsValidCurrencyCode;
                    $(".selectpicker").selectpicker('refresh');
                } else {
                    return IsValidCurrencyCode = 0
                }
            } else {
                return IsValidCurrencyCode = 0
            }

        }

        /*
         Created By : Vishal Mane
         Created Date : 11/11/2023
         Purpose : To Get RFI Checklist Items
         */
        function GetRFIChecklistItems(RFIID, CurrentStatus, IsDisplayItems, ContractID) {
            RFIItemAdvisedIDs = [];
            $("#txthdnIRID").val(RFIID);
            $("#txthdnContract").val(ContractID);
            //End of Added By Dipali V On 16th Jan 2024 For Validate Contract Value
            var IsAlertContractValue = "";
            if (IsDisplayItems == 4) {
                GFlag = 2;
             IsAlertContractValue = ValidateContractValue();

            }
            if (IsAlertContractValue != "" && (IsValidateContractValue == true || IsValidateContractValue == 1)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(IsAlertContractValue);
                //IsValidate = false;
                return false
            }
            else {
                $("#txtRFICurrentStatus").text(CurrentStatus);
                var ValidateApprover = 0;
                ValidateApprover = ValidateIRApprover();
                if (ValidateApprover == 0) {

                    var IsDisplayCheckitemsItems = IsDisplayItems;
                    var strHTML = "";
                    $("#submitIRTbl").dataTable().fnDestroy();
                    var ProjectID = $("#cboProject").val();
                    $("#txtRFIId").text(RFIID);
                    var ChecklistFields = {
                        RFIID: encodeURI(RFIID),
                        ProjectID: encodeURI(ProjectID),
                    }
                    var param = JSON.stringify(ChecklistFields)
                    var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIChecklistItems", param, false);
                    var RFICheckListInstanceID = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICheckListInstanceID", param, false);
                    $("#txtRFICheckListId").text("");
                    $("#txtRFICheckListId").text(strResult[0].RFIChecklistID);
                    $("#txtRFIChecklistInstanceID").text(strResult[0].RFIChecklistInstanceID);

                    //Added by Vishal Mane to handle null condition 
                    if (RFICheckListInstanceID == null || RFICheckListInstanceID == undefined) {
                        RFICheckListInstanceID = "";
                    }
                    if (IsDisplayCheckitemsItems == 1) {
                        //Commented and Added By Riddhesh Patil on 04 Jan 2024 for double pop up Showing Issue
                        //$("#IRPIR_Tbl").dataTable().fnDestroy();
                        $("#submitIRTbl").dataTable().fnDestroy();
                        //Commented and Added By Riddhesh Patil on 04 Jan 2024 for double pop up Showing Issue
                        $("#SubmitIRModal").modal("show");
                        $("#submitIRSaveBtn").hide();
                        $("#submitIRCancelBtn").hide();
                        var ChecklistFields = {
                            //Commented and added by Vishal Mane to handle null condition 
                            //RFICheckListInstanceID = strResult[0].RFIChecklistInstanceID,
                            RFIChecklistInstanceID: RFICheckListInstanceID,
                        }
                        var param = JSON.stringify(ChecklistFields)
                        var strResults = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICheckListInstances", param, false);
                        //var strResults = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIChecklistItems", param, false);
                        if (RFICheckListInstanceID == "" || RFICheckListInstanceID == null || RFICheckListInstanceID == "") {
                            StrHTML = "";
                            $("#submitIRTbl_Body").html(StrHTML);

                        }
                        else {
                            if (strResults.length != 0) {
                                $.each(strResults, function (index, obj) {
                                    strHTML += '<tr><td class="text-centre">' + obj.RFIChecklistItemID + '<input hidden type="text" value=' + obj.RFIChecklistItemID + '><input hidden class="RFIChecklistInstanceItemID" type="text" value=' + obj.RFIChecklistInstanceItemID + '></td>';
                                    strHTML += '<td class="text-centre">' + obj.RFIChecklistItem + '<input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td>';
                                    if (obj.RFIChecklistItemResponse == true) {
                                        //Added 'disabled' property By Vishal Mane on 30/12/23 to disable checkbox for view perpose
                                        strHTML += '<td><div class="custom_chckbox"><input type="checkbox" id="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '" value=' + obj.RFIChecklistInstanceItemID + ' checked disabled><label for="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '"></label></div></td>';
                                    } else {
                                        //Added 'disabled' property By Vishal Mane on 30/12/23 to disable checkbox for view perpose
                                        strHTML += '<td><div class="custom_chckbox"><input type="checkbox" id="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '" value=' + obj.RFIChecklistInstanceItemID + ' disabled><label for="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '"></label></div></td>';
                                    }
                                    //strHTML += '<td class="text-centre"><textarea class="form-control submitComments readonly" readonly>' + obj.Comments + '</textarea><input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td></tr>';
                                    if (obj.Comments == null || obj.Comments == "") {
                                        strHTML += '<td class="text-centre"><textarea class="form-control submitComments readonly" readonly maxlength="2000"></textarea><input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td></tr>';
                                    } else {
                                        strHTML += '<td class="text-centre"><textarea class="form-control submitComments readonly readonly" readonly maxlength="2000">' + obj.Comments + '</textarea><input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td></tr>';
                                        //maxlength attribute added by Ajit on 19/12/2023 
                                    }

                                });
                                $("#submitIRTbl_Body").html(strHTML);
                            }

                        }

                    }
                    else
                        if (RFICheckListInstanceID == null || RFICheckListInstanceID == undefined || RFICheckListInstanceID == "") {
                            $("#SubmitIRModal").modal("show");
                            $("#submitIRSaveBtn").show();
                            $("#submitIRCancelBtn").show();
                            if (strResult.length != 0) {
                                $.each(strResult, function (index, obj) {
                                    strHTML += '<tr><td class="text-centre">' + obj.RFIChecklistItemID + '<input hidden type="text" value=' + obj.RFIChecklistItemID + '><input hidden class = "RFIChecklistInstanceItemID" type="text" value=' + obj.RFIChecklistInstanceItemID + '></td>';
                                    strHTML += '<td class="text-centre">' + obj.RFIChecklistItem + '<input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td>';
                                    strHTML += '<td <div class="custom_chckbox"><input type = "checkbox" id="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '" value=' + obj.RFIChecklistInstanceItemID + '><label for="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '"></label></div></td>';
                                    strHTML += '<td class="text-centre"><textarea class="form-control submitComments" maxlength="2000"></textarea><input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td></tr>';
                                });
                                $("#submitIRTbl_Body").html(strHTML);
                            }
                        }
                        else {
                            if (CurrentStatus == "Rejected") {

                                $("#submitIRSaveBtn").show();
                                $("#submitIRCancelBtn").show();
                                var ChecklistFields = {
                                    //Commented and added by Vishal Mane to handle null condition 
                                    //RFICheckListInstanceID = strResult[0].RFIChecklistInstanceID,
                                    RFIChecklistInstanceID: RFICheckListInstanceID,
                                }
                                var param = JSON.stringify(ChecklistFields)
                                var strResults = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICheckListInstances", param, false);
                                if (strResults.length != 0) {
                                    $("#SubmitIRModal").modal("show");
                                    $.each(strResults, function (index, obj) {
                                        strHTML += '<tr><td class="text-centre">' + obj.RFIChecklistItemID + '<input hidden type="text" value=' + obj.RFIChecklistItemID + '><input hidden class="RFIChecklistInstanceItemID" type="text" value=' + obj.RFIChecklistInstanceItemID + '></td>';
                                        strHTML += '<td class="text-centre">' + obj.RFIChecklistItem + '<input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td>';
                                        if (obj.RFIChecklistItemResponse == true) {
                                            strHTML += '<td><div class="custom_chckbox"><input type="checkbox" id="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '" value=' + obj.RFIChecklistInstanceItemID + ' checked><label for="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '"></label></div></td>';
                                        } else {
                                            strHTML += '<td><div class="custom_chckbox"><input type="checkbox" id="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '" value=' + obj.RFIChecklistInstanceItemID + '><label for="' + obj.RFIChecklistInstanceItemID + ' + ' + index + '"></label></div></td>';
                                        }
                                        if (obj.Comments == null || obj.Comments == "") {
                                            strHTML += '<td class="text-centre"><textarea class="form-control submitComments readonly"  maxlength="2000"></textarea><input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td></tr>';
                                        } else {
                                            strHTML += '<td class="text-centre"><textarea class="form-control submitComments readonly" maxlength="2000">' + obj.Comments + '</textarea><input hidden type="text" value=' + obj.RFIChecklistInstanceID + '></td></tr>';
                                        }
                                    });
                                    $("#submitIRTbl_Body").html(strHTML);
                                } else {
                                    $("#SubmitIRModal").modal("hide");
                                    //Commented By Riddhesh Patil on 04 Jan 2024 for double pop up Showing Issue
                                    // $("#IRPIR_ChangeStatusModal").modal("show");
                                    //End of Commented By Riddhesh Patil on 04 Jan 2024 for double pop up Showing Issue
                                    $("#cboSubmitIRStatus").text("Re-Submitted");
                                    $("#txtsubmitIRcomment").val('');
                                }
                            }
                            else {
                                $("#SubmitIRModal").modal("hide");
                                $("#IRPIR_ChangeStatusModal").modal("show");
                                $("#cboSubmitIRStatus").text("Submitted");//Added by Ajit L on 29/12/2023
                                $("#txtsubmitIRcomment").val('');
                            }
                            //if (CurrentStatus == "Submitted") {
                            //    $("#SubmitIRModal").modal("hide");
                            //    $("#IRPIR_ChangeStatusModal").modal("show");
                            //} else {
                            //    $("#SubmitIRModal").modal("hide");
                            //    $("#IRPIR_ChangeStatusModal").modal("show");
                            //    //Added & Commented by Ajit L on 19/12/2023 start
                            //   // $("#cboSubmitIRStatus").text("Re-Submitted");
                            //    $("#cboSubmitIRStatus").text("Submitted");
                            //     //Added & Commented by Ajit L on 19/12/2023 end
                            //}

                        }
                }
                else {
                    $("#SubmitIRModal").modal("hide");
                    //$("#IRPIR_ChangeStatusModal").modal("show");
                }

                $('#submitIRTbl').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bFilter": false,
                    "ordering": false,
                    "info": false,
                });
             
            }
        }





        function AddNewIR() {

            var Validate = CheckIRGenerationValidation();
            if (Validate == true) {
                ClearAll();
                $("#IR_Add").prop("checked", true);
                Cust_Flag = 0;
                $("#txtEdtbleIR_ID_Filter").val("");//Added By Dipali V On 16th Jan 2024 For Clear RFI ID
                //$("#AddNewIRBtn").attr('data-bs-target', "#offcvsIRPIR_Add_Screen");
                // $("#offcvsIRPIR_Add_Screen").addClass('show');
                var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcvsIRPIR_Add_Screen'));
                myOffcanvas.show();
                $("#offcvsIRPIR_Add_Screen").show();
                GetProjectDetails();
                //if (G_ProjectOrProduct == "Product") {
                //    $("#cboCustomer").removeAttr("disabled");    
                //}
                //else {
                //    $("#cboCustomer").attr("disabled");
                //}
                if (G_ProjectOrProduct == "Product") {
                    $("#cboCustomer").removeClass("disabled").removeAttr("disabled");
                } else {
                    $("#cboCustomer").addClass("disabled").attr("disabled", true);
                }

                ////Modified by Vishal to solve refresh issue of Currency symbol on 19/12/2023 
                //GetRfiTypes(0);
                //GetRfiCustomer(0);
                //GFlag = 0;
                //GetCurrencySymbol(0);
                //GetRFIContactPerson(0);
                //GetRFIDefaultPrjAddress(0);
                ////End of Modified by Vishal to solve refresh issue of Currency symbol on 19/12/2023 

                GetRfiTypes(0);
                GetRfiCustomer(0);
                GFlag = 0;  //Added by Vishal on 28/12/2023 to solve 1. First Edit IRPIR 2.Then Add new IRPIR at that time Currency symbol not showing
                GetCurrencySymbol(0);
                GetRFIContactPerson(0);
                GetRFIDefaultPrjAddress(0);
                //GFlag = 0;  //Commented by Vishal on 28/12/2023
                var today = new Date();
                var TodaysDate = convertIDate(today);
                $("#toDateFilter").val(TodaysDate);
                // alert(TodaysDate);

            }
        }

        function ClearAll() {
            $("#cboRFIType").val(0);
            $("#cboCustomer").val(0);
            $("#cboContactPer").val(0);
            $("#txtEmail_Confirm").val('');
            $("#txtContract").val('');
            $("#TexthiddenContract").val('');
            $("#toDateFilter").val('');
            $("#txtCreditDays").val('');
            $("#lblCurrency").text('');
            $("#txtSalesPeriod").val('');
            $("#txthdnSalesPeriod").val('');
            $("#txtSalesPerson").val('');
            $("#txthdnSalesPer").val('');
            $("#txtAItemHead").val('');
            // $("#offcvsIRPIR_Add_Screen").removeClass('show');
            $(".selectpicker").selectpicker('refresh');
        }

        /*
         Created By : Vishal Mane
         Created Date : 19/11/2023
         Purpose : To clear Edit mode fields 
         */
        function ClearAllEditMode() {
            $("#cboRFITypeE").val(0);
            $("#cboCustomerE").val(0);
            $("#cboContactPerE").val(0);
            $("#txtEmail_ConfirmE").val('');
            $("#txtContractE").val('');
            $("#TexthiddenContractE").val('');
            $("#toDateFilterE").val('');
            $("#txtCreditDaysE").val('');
            $("#lblCurrencyE").text('');
            $("#txtSalesPeriodE").val('');
            $("#txthdnSalesPeriodE").val('');
            $("#txtSalesPersonE").val('');
            $("#txthdnSalesPerE").val('');
            $("#txtAItemHeadE").val('');
            // $("#offcvsIRPIR_Add_Screen").removeClass('show');
            $(".selectpicker").selectpicker('refresh');
        }
        function GetRfiTypes(flag) {
            var strHTML = "";
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFITypes", '', false);
            for (var i = 0; i < Result.length; i++) {
                var listComponent = Result[i];
                strHTML += ('<option value=' + listComponent.RFITypeID + ' >' + listComponent.RFITypeName + '</option>');

            }
            if (flag == 0) {
                $("#cboRFIType").html(strHTML);
            }
            else {
                $("#cboRFITypeE").html(strHTML);
            }
            $(".selectpicker").selectpicker('refresh');
        }

        var billingcurencyId = 0; //Added by Ajit
        var billingcurencyCode = 0; 
        function GetCurrencySymbol() {

            var Projectid = $("#cboProject").val();
            var RequestParameters = {
                ProjectID: Projectid
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIProjectCurrency", param, false);
            for (var i = 0; i < Result.length; i++) {
             
                billingcurencyId = (Result[i].CurrencyID); //Added by ajit , required for comparision with contract currency on 19/12/23
                billingcurencyCode = (Result[i].CurrencyCode);
                $("#lblCurrencyAdd").text(Result[i].CurrencyCode);
                $("#lblcurrency").text(Result[i].CurrencyCode);

                var spanElement = $("<span class='lblCurncySymb'>(" + Result[i].CurrencySymbol + ")</span>");
                var spanElement2 = $("<span class='lblcurncySymb'>(" + Result[i].CurrencySymbol + ")</span>");
                if (GFlag == 0) {
                    $("#lblCurrencyAdd").append(spanElement);
                    $("#lblcurrency").append(spanElement2);
                }
                else {
                    $("#lblCurrencyE").text(Result[i].CurrencyCode);
                    $("#lblCurrencyE").append(spanElement);
                }

            }


        }

        function GetRfiCustomer(flag) {
            var strHTML = "";
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICustomer", '', false);
            for (var i = 0; i < Result.length; i++) {
                var listComponent = Result[i];
                strHTML += ('<option value=' + listComponent.Customer + ' >' + listComponent.CustomerName + '</option>');

            }
            if (flag == 0) {
                $("#cboCustomer").html(strHTML);
            }
            else {
                $("#cboCustomerE").html(strHTML);
            }

            $(".selectpicker").selectpicker('refresh');
            GetRfiDefaultCustomer(flag);
        }

        function GetRFIContactPerson(flag) {
           //
            var strHTML = "";
            if (flag == 0) {
                var CustomerID = $("#cboCustomer").val();
            }
            else {
                var CustomerID = $("#cboCustomerE").val();
            }

            if (CustomerID == 0) {
                CustomerID = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
            }
            var RequestParameters = {
                CustomerID: CustomerID
            }

            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIContactPerson", param, false);
            for (var i = 0; i < Result.length; i++) {
                var listComponent = Result[i];
                strHTML += ('<option value=' + listComponent.CustomerContactID + ' >' + listComponent.ContactPerson + '</option>');

            }
            if (flag == 0) {
                $("#cboContactPer").html(strHTML);
            }
            else {
                $("#cboContactPerE").html(strHTML);
            }

            $(".selectpicker").selectpicker('refresh');
        }
        //var SessionProjectId = '<%= Session("intProjectID") %>';
        function GetRfiDefaultCustomer(flag) {
            var Projectid = $("#cboProject").val();
            var RequestParameters = {
                ProjectID: Projectid
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIProjectCustomer", param, false);
            var Customer = Result[0].Customer;
            var CreditPeriod = Result[0].CreditPeriod;
            if (flag == 0) {
                $("#cboCustomer").val(Customer);
            }
            else {
                $("#cboCustomerE").val(Customer);
            }
            $("#txtCreditDays").val(CreditPeriod);
            $("#lblCust_Name").text(Result[0].CustomerName);
            $(".selectpicker").selectpicker('refresh');
        }

        function GetCustomerAddress(flag) {
            
            $("#lblCust_Name").text('');
            
            Cust_Flag = 1;
            if (flag == 0) {
                var CustomerID = $("#cboCustomer").val();
            }
            else {
                var CustomerID = $("#cboCustomerE").val();
            }

            if (CustomerID == 0) {
                CustomerID = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
            }

            $("#cboCustomerforChange").val(CustomerID);
            //Added by Vishal Mane 20/12/23 to get current customer Name
            var RequestParameters = {
                CustomerID: CustomerID
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetCustomerName", param, false);
            $("#lblCust_Name").text(Result[0].CustomerName);
            //End of Added by Vishal Mane 20/12/23 to get current customer Name
            //CustomerID = 0;
            //if (Cust_Flag == 0) {
            GetRFICustomerPrjAddress(CustomerID);
            //  }

        }

        /*
           Created By : Vishal Mane
           Created Date : 11/11/2023
           Purpose : To Save RFI Checklist Items
           */
        function SaveRFIChecklistItems() {
            
            var CurrentStatus = $("#txtRFICurrentStatus").text();
            var IsCommentValid = ValidateComments();
            if (IsCommentValid == 0) {
                $("#SubmitIRModal").modal('hide');
                //$("#submitIRSaveBtn").attr('data-bs-dismiss','modal');
                $("#IRPIR_ChangeStatusModal").modal("show");
                $("#txtsubmitIRcomment").val('');

                var RFIChecklistInstanceID = $("#txtRFIChecklistInstanceID").text();
                var RFIID = $("#txtRFIId").text();
                var ProjectID = $("#cboProject").val();
                var RFIChecklistID = $("#txtRFICheckListId").text();
                var UserName = '<%= Session("strUserName") %>';

                var InvoiceID = "";
                if (RFIChecklistInstanceID == null || RFIChecklistInstanceID == "" || RFIChecklistInstanceID == undefined || RFIChecklistInstanceID == "0") {
                    /* var RFIChecklistInstanceID = null;*/
                    var RFIChecklistInstanceID = "";
                    var ChecklistInstanceIDFields = {
                        'RFIChecklistInstanceID': RFIChecklistInstanceID,
                        ProjectID: parseInt(ProjectID),
                        RFIChecklistID: parseInt(RFIChecklistID),
                        'RFIID': encodeURIComponent(RFIID),
                        'InvoiceID': encodeURIComponent(InvoiceID),
                    };
                    var param = JSON.stringify(ChecklistInstanceIDFields)
                    //var param = ChecklistInstanceIDFields
                    var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetChecklistInstanceID", param, false);
                    RFIChecklistInstanceID = strResult;
                }
                var RFIChecklistItems = [];
                $('#submitIRTbl tr').each(function () {
                    var row = $(this);
                    var RFIChecklistItemID = row.find('td:first-child input[type="text"]').val();
                    var RFIChecklistItem = row.find('td:eq(1)').text();
                    //var RFIChecklistInstanceID = row.find('input[type="text"]').last().val();
                    //if (RFIChecklistInstanceID == "null" || RFIChecklistInstanceID == undefined || RFIChecklistInstanceID == "") {
                    //    RFIChecklistInstanceID = "";
                    //}
                    var RFIChecklistInstanceItemID = row.find('.RFIChecklistInstanceItemID').val();
                    if (RFIChecklistInstanceItemID == "null" || RFIChecklistInstanceItemID == undefined || RFIChecklistInstanceItemID == "") {
                        RFIChecklistInstanceItemID = 0;
                    }
                    var ChecklistComment = row.find('.submitComments').val();
                    var checkbox = $(this).find('td:nth-child(3) input[type="checkbox"]');
                    if (checkbox.is(':checked')) {
                        var RFIChecklistItemResponse = 1;
                    } else {
                        var RFIChecklistItemResponse = 0;
                    }
                    if (RFIChecklistItemID != undefined) {
                        var ChecklistItems = { RFIChecklistItemID, RFIChecklistItem, RFIChecklistInstanceItemID, RFIChecklistInstanceID, ChecklistComment, RFIChecklistItemResponse };
                        RFIChecklistItems.push(ChecklistItems);
                        var CheckedlistFields = {
                            'RFIID': encodeURIComponent(RFIID),
                            ProjectID: parseInt(ProjectID),
                            RFIChecklistID: parseInt(RFIChecklistID),
                            'RFIChecklistItemID': encodeURIComponent(RFIChecklistItemID),
                            'RFIChecklistItem': RFIChecklistItem,
                            RFIChecklistInstanceItemID: parseInt(RFIChecklistInstanceItemID),
                            'RFIChecklistInstanceID': RFIChecklistInstanceID,
                            'ChecklistComment': encodeURIComponent(ChecklistComment),
                            RFIChecklistItemResponse: parseInt(RFIChecklistItemResponse),
                            'CreatedBy': encodeURIComponent(UserName),
                        }
                        var param = JSON.stringify(CheckedlistFields)
                        var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/SaveRFIChecklistItems", param, false);
                    }
                });

                if (CurrentStatus == "Rejected") {
                    $("#SubmitIRModal").modal("hide");
                    $("#IRPIR_ChangeStatusModal").modal("show");
                    $("#cboSubmitIRStatus").text("Re-Submitted");
                    $("#txtsubmitIRcomment").val('');

                } else {
                    $("#SubmitIRModal").modal("hide");
                    $("#IRPIR_ChangeStatusModal").modal("show");
                    $("#cboSubmitIRStatus").text("Submitted");
                    $("#txtsubmitIRcomment").val('');
                }

                //}
            }
            else {
                $("#IRPIR_ChangeStatusModal").modal("hide");

            }

        }

        /*
      Created By : Vishal Mane
      Created Date : 16/11/2023
      Purpose : To validate Checklist Items comments
      */
        var IsCommentValid;
        function ValidateComments() {
            //
            var IsCommentValid = 0;
            var rows = $('#submitIRTbl tr');

            for (var i = 0; i < rows.length; i++) {
                //
                var row = $(rows[i]);
                var ChecklistComment = row.find('.submitComments').val();
                if (ChecklistComment === "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_CommentBlank")%>');
                    row.find('.submitComments').focus(); // Focus on the textarea
                    IsCommentValid = 1;
                    break; // Exit the loop
                }
            }
            return IsCommentValid;
        }

        /*
        Created By : Vishal Mane
        Created Date : 16/11/2023
        Purpose : To submit IR Details
        */
        function SumbitIRDetails() {

            var IsSubmitIRCommentValid = ValidateSubmitIRComments();
            var RFIID = $("#txtRFIId").text();
            var ProjectID = $("#cboProject").val();
            var Status = $("#cboSubmitIRStatus").val();
            var UserName = '<%= Session("strUserName") %>';
            var SubmitIRComments = $("#txtsubmitIRcomment").val();
            var intEmployeeID = '<%= Session("intUserID") %>';
            if (IsSubmitIRCommentValid == 0) {
                var SumbitIRDetails = {
                    ProjectID: encodeURI(ProjectID),
                    RFIID: encodeURI(RFIID),
                    Status: encodeURI(Status),
                    CreatedBy: encodeURI(UserName),
                    SubmitIRComments: encodeURI(SubmitIRComments),
                }
                var param = JSON.stringify(SumbitIRDetails)
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/SumbitIRDetails", param, false);
                if (strResult = 1) {
                    
                    $("#IRPIR_ChangeStatusModal").modal("hide");
                    MyFilters(ProjectID);
                    if (Status == "Submitted") {
                        window.open("../Email/SendEmail.aspx?MessageID=51&IRFlag=1&RFIID=" + RFIID + "&ProjectID=" + ProjectID + "&intEmployeeID=" + intEmployeeID + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');

                    } else {
                        window.open("../Email/SendEmail.aspx?MessageID=55&IRFlag=1&RFIID=" + RFIID + "&ProjectID=" + ProjectID + "&intEmployeeID=" + intEmployeeID + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');

                    }
                    //Added by Vishal Mane on 25/12/2023 to update submitted IR details
                    EditIRPIR(RFIID, Status, 0);
                    //End of Added by Vishal Mane on 25/12/2023 to update submitted IR details
                }


            } else {
                $("#IRPIR_ChangeStatusModal").modal("show");
                 //Added by Vishal Mane on 19/12/2023 to clear IR comments
                $("#txtsubmitIRcomment").val('');
                 //End of Added by Vishal Mane on 19/12/2023 to clear IR comments
            }
        }


        /*
        Created By : Vishal Mane
        Created Date : 16/11/2023
        Purpose : To validate submit IR comments
        */
        var IsSubmitIRCommentValid;
        function ValidateSubmitIRComments() {

            var IsSubmitIRCommentValid = 0;
            var SubmitIRComment = $("#txtsubmitIRcomment").val();
            if (SubmitIRComment === "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_BlankComment")%>');
                $("#txtsubmitIRcomment").focus();
                IsSubmitIRCommentValid = 1;
            }
            return IsSubmitIRCommentValid;
        }

    
        /*
          Created By :Ajit L
          Created Date : 13/12/2023
          Purpose : To validate RFI records before delete 
        */
       
        var RFIIDs = [];
        var RFIIDsString = '';
        function ValidateIRPIRDelete() {
            
            RFIIDs = [];
            var table = $('#IRPIR_Tbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            $('.chcktask:checked', rows).map(function () {
                RFIIDs.push($(this).attr("id"));          
            })

            RFIIDsString = RFIIDs.join(',');
            if (RFIIDsString == undefined || RFIIDsString == null || RFIIDsString == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectOneRecordDel")%>');
                deleteFlag = 1;
            }
            else {
                RFIIDs = RFIIDsString;
                $("#deleteIRPIR").modal('show');
            }
            
        }


        /*
           Created By : Vishal Mane
           Created Date : 11/11/2023
           Purpose : To delete RFI Record
           */
        function DeleteIR_PIR() {


            var ProjectID = $("#cboProject").val();
          
            RFIIDs = RFIIDs
            var deleteFlag = 0;
          <%--  $('#IRPIR_Tbl tr').each(function () {
                var checkbox = $(this).find('td:nth-child(14) input[type="checkbox"]');
                if (checkbox.prop('checked')) {
                    var row = $(this);
                    var RFIID = row.find('td:nth-child(1) input[type="text"]').val();
                    RFIIDs.push(RFIID);
                }
            });

            var RFIIDsString = RFIIDs.join(',');
            if (RFIIDsString == undefined || RFIIDsString == null || RFIIDsString == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectOneRecordDel")%>');
                deleteFlag = 1;
            }
            else {

                $("#deleteIRPIR").modal('show');
            }--%>
            if (deleteFlag == 0) {
                var DeleteIRDetails = {
                    ProjectID: encodeURI(ProjectID),
                    RFIIDs: encodeURI(RFIIDs),
                }
                var param = JSON.stringify(DeleteIRDetails)
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/DeleteIRPIR", param, false);

                if (strResult.length !== 0) {
                    var resultText = strResult.join('<br>');
                    $("#deleteIRModal").modal("show");
                    $('.txtDeleteIRPIR').html(resultText);
                }

                GetIRPIRList(ProjectID);

            }


        }




        function GetRFISalesPeriod() {

            var IsOpen = $("#salesPeriodIsOpenF").val();
            var salesPeriodStartDate = $("#salesPeriodStartDateF").val();
            var salesPeriodYear = $("#salesPeriodYearF").val();
            var salesPeriodEndDate = $("#salesPeriodEndDateF").val();
            var salesPeriodMonth = $("#salesPeriodMonthF").val();
            if (IsOpen == "Yes") {
                IsOpen = 1;
            } else {
                IsOpen = 0;
            }


            var ProjectID = $("#cboProject").val();
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                IsOpen: encodeURI(IsOpen),
                salesPeriodStartDate: encodeURI(salesPeriodStartDate),
                salesPeriodYear: encodeURI(salesPeriodYear),
                salesPeriodEndDate: encodeURI(salesPeriodEndDate),
                salesPeriodMonth: encodeURI(salesPeriodMonth)
            }
            var strHTML = "";
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetSalesPeriodDetails", param, false);
            if (Result.length > 0 && Result.length != null && Result != undefined) {
                for (var i = 0; i < Result.length; i++) {

                    var SalesPeriodID = Result[i]["SalesPeriodID"];
                    var SalesPeriodMonth = Result[i]["SalesPeriodMonth"];
                    var SalesPeriodYear = Result[i]["SalesPeriodYear"];
                    var SalesPeriodStartDate = Result[i]["SalesPeriodStartDate"];
                    var SalesPeriodEndDate = Result[i]["SalesPeriodEndDate"];
                    var IsOpen = Result[i]["IsOpen"];
                    if (IsOpen == true) {
                        IsOpen = "Yes"
                    }
                    else {
                        IsOpen = "No"
                    }
                    strHTML += '<tr>'
                    strHTML += '<td>' + SalesPeriodMonth + '</td>'
                    strHTML += '<td>' + SalesPeriodYear + '</td>'
                    strHTML += '<td>' + SalesPeriodStartDate + '</td>'
                    strHTML += '<td>' + SalesPeriodEndDate + '</td>'
                    strHTML += '<td>' + IsOpen + '</td>'
                    strHTML += '<input type="hidden" id="SalesPeriod' + SalesPeriodID + '" value="' + SalesPeriodYear + '/' + SalesPeriodMonth + '" />';
                    if (IsOpen == "Yes") {
                        strHTML += '<td> <div class="custom_chckbox">  <input id="descrGridcheck' + SalesPeriodID + '" name="checksalesPeriod" data-bs-dismiss="modal" class="chcktbl" type="checkbox" value="' + SalesPeriodID + '" onclick="selectSalesPeriod(' + SalesPeriodID + ');" /> <label for="descrGridcheck' + SalesPeriodID + '"></label>   </div></td>'
                    }
                    else {
                        strHTML += '<td> <div class="custom_chckbox">  <input id="descrGridcheck' + SalesPeriodID + '" name="checksalesPeriod" disabled data-bs-dismiss="modal" class="chcktbl" type="checkbox" value="' + SalesPeriodID + '" onclick="selectSalesPeriod(' + SalesPeriodID + ');" /> <label for="descrGridcheck' + SalesPeriodID + '"></label>   </div></td>'
                    }
                    strHTML += '</tr>'
                }


            }

            $('#salesPeriodTbl').dataTable().fnDestroy();

            $("#salesPeriodTblBody").html(strHTML);
            $('#salesPeriodTbl').dataTable({
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "destroy": true,
                "bFilter": false,
                /*  "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] }]*/
            });
            $(".table").resize();
            if ($("#txthdnSalesPeriod").val() != 0) {
                var $checkbox = $('input[type="checkbox"][value="' + $("#txthdnSalesPeriod").val() + '"]');
                if ($checkbox.length > 0) {
                    var checkboxId = $checkbox.attr("id");
                    $("#" + checkboxId).prop("checked", true);
                }
            }

            if (GFlag == 0) {
                if ($("#txthdnSalesPeriod").val() != "") {
                    var hdnIDs = $("#txthdnSalesPeriod").val();
                    //var arrMasterIDs = hdnIDs.split(',');
                    //for (var i = 0; i < arrMasterIDs.length; i++) {
                    if ($("#descrGridcheck" + hdnIDs).val() == hdnIDs) {
                        $("#descrGridcheck" + hdnIDs).prop("checked", true);

                    }
                }
            }
            else {
                if ($("#txthdnSalesPeriodE").val() != "") {
                    var hdnIDs = $("#txthdnSalesPeriodE").val();
                    //var arrMasterIDs = hdnIDs.split(',');
                    //for (var i = 0; i < arrMasterIDs.length; i++) {
                    if ($("#descrGridcheck" + hdnIDs).val() == hdnIDs) {
                        $("#descrGridcheck" + hdnIDs).prop("checked", true);

                    }
                }

            }

        }

        function GetRFICustomerPrjAddress(CustomerID) {
            if (CustomerID == 0) {
                $("#linkCustAddress").removeAttr('data - bs - toggle', 'modal')

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_BlankCustomer")%>');
                $("#cboCustomer").focus();
            }
            else {
                var strHTML = "";
                var RequestParameters = {
                    CustomerID: CustomerID
                }
                var param = JSON.stringify(RequestParameters);
                var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICustomerPrjAddress", param, false);
                for (var i = 0; i < Result.length; i++) {
                    var listComponent = Result[i];
                    strHTML += ('<option value=' + listComponent.CustomerAddressID + ' >' + listComponent.AddressCode + '</option>');

                }

                $("#cboCust_Address").html(strHTML);
                $(".selectpicker").selectpicker('refresh');
                GetRFICustomerDefaultPrjAddressDetails(CustomerID);
                $("#Select_Customer_Address").modal('show');

            }
        }



        function GetRFIDefaultPrjAddress() {

            if (Cust_Flag == 0) {
                var Projectid = $("#cboProject").val();
                //  var strHTML = "";
                var CustomerId = $("#cboCustomer").val();

                if (CustomerId == 0) {
                    CustomerId = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
                }
                var RequestParameters = {
                    CustomerID: CustomerId,
                    ProjectID: Projectid
                }
                var param = JSON.stringify(RequestParameters);
                var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICustomerDefaultPrjAddress", param, false);

                //AddressID = Result[0].CustomerAddressID;                
                //$("#cboCust_Address").val(Result[0].CustomerAddressID);

                if (Result.length > 0) {
                    AddressID = Result[0].CustomerAddressID;
                    $("#cboCust_Address").val(Result[0].CustomerAddressID);
                } else {
                    $("#cboCust_Address").val(AddressID);
                }

            }
            else {
                $("#cboCust_Address").val(AddressID);
            }

        }

        var AddressID = 0;
        function GetRFICustomerDefaultPrjAddressDetails(CustomerID) {
            var Projectid = $("#cboProject").val();
            if (CustomerID == 0) {
                CustomerID = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
            }
            //  var strHTML = "";
            var RequestParameters = {
                CustomerID: CustomerID,
                ProjectID: Projectid
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICustomerDefaultPrjAddress", param, false);
            if (Result.length > 0) {
                AddressID = Result[0].CustomerAddressID;
            } else {
                AddressID = 0;
            }
            
            //alert(AddressID);
            if (Cust_Flag == 0) {
                if (Result.length > 0) {
                    
                    $("#cboCust_Address").val(Result[0].CustomerAddressID);
                    $("#lblAddress").text(Result[0].Address);
                    $("#lblCity").text(Result[0].City);
                    $("#lblState").text(Result[0].State);
                    $("#lblCountry").text(Result[0].Country);
                    $("#lblZIPCode").text(Result[0].PinCode);
                    $("#lblFaxNo").text(Result[0].FaxNumber);
                    $("#lblTelephone").text(Result[0].TelephoneNumber);
                } else {
                    
                    $("#cboCust_Address").val('');
                    $("#lblAddress").text('');
                    $("#lblCity").text('');
                    $("#lblState").text('');
                    $("#lblCountry").text('');
                    $("#lblZIPCode").text('');
                    $("#lblFaxNo").text('');
                    $("#lblTelephone").text('');
                }
               
            }
            else {
                $("#cboCust_Address").val(AddressID);
                GetCustAddresson_Change(AddressID);

            }
            $(".selectpicker").selectpicker('refresh');

        }

        function GetCustAddresson_Change(CustomerAddrId) {
            //  var strHTML = "";      
            //  AddressID = CustomerAddrId;
            $("#lblAddress").text('');
            $("#lblCity").text('');
            $("#lblState").text('');
            $("#lblCountry").text('');
            $("#lblZIPCode").text('');
            $("#lblFaxNo").text('');
            $("#lblTelephone").text('');
            var CustomerId = 0;
            if (GFlag == 0) {
                CustomerId = $("#cboCustomer").val();
            }
            else {
                CustomerId = $("#cboCustomerE").val();
            }
            if (CustomerId == 0) {
                CustomerId = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
            }
            var RequestParameters = {
                CustomerID: CustomerId,
                CustomerAddrID: CustomerAddrId
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFICustomerAddress", param, false);
            if (Result.length > 0) {
                $("#lblAddress").text(Result[0].Address);
                $("#lblCity").text(Result[0].City);
                $("#lblState").text(Result[0].State);
                $("#lblCountry").text(Result[0].Country);
                $("#lblZIPCode").text(Result[0].PinCode);
                $("#lblFaxNo").text(Result[0].FaxNumber);
                $("#lblTelephone").text(Result[0].TelephoneNumber);
            } else {
                $("#lblAddress").text('');
                $("#lblCity").text('');
                $("#lblState").text('');
                $("#lblCountry").text('');
                $("#lblZIPCode").text('');
                $("#lblFaxNo").text('');
                $("#lblTelephone").text('');

                $("#cboCust_Address").val(0);
                
            }
            $(".selectpicker").selectpicker('refresh');

        }

        function SaveCustAddrId() {
            
            var CustomerID = $("#cboCustomerforChange").val();
            var AddressID = $("#cboCust_Address").val();
            var RequestParameters = {
                CustomerID: CustomerID,
                CustomerAddrID: AddressID
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/SetDefaultCustomerAddress", param, false);


            $("#Select_Customer_Address").modal('hide');
        }

        function GetContractDetails(ContractTypeId) {
            //
            /*Added by Vishal Mane on 29/12/23 to solve data-table issue if there is no contracts available against selected customer*/
            $("#contrctTable").dataTable().fnDestroy();
            var StrHTML = "";
            var CustomerID = 0;
            if (GFlag == 0) {
                CustomerID = $("#cboCustomer").val();
            }
            else {
                CustomerID = $("#cboCustomerE").val();
            }

            if (CustomerID == 0) {
                CustomerID = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
            }

            var RequestParameters = {
                CustomerID: CustomerID,
                ContractTypeID: ContractTypeId
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIContract", param, false);

            //var CustID = "";
            /*Commented by Vishal Mane on 29/12/23 to solve data-table issue if there is no contracts available against selected customer*/
            //if (strResult != "") {
            /*Added by Vishal Mane on 29/12/23 to solve data-table issue if there is no contracts available against selected customer*/
            if (strResult.length != 0) {
                //$("#contrctTableBody").html('');
                //CustID == strResult[0].CustomerID;
                for (var i = 0; i < strResult.length; i++) {
                    /*Commented by Vishal Mane on 29/12/23 to solve data-table issue if there is no contracts available against selected customer*/

                    //if (CustID == "") {
                    //    StrHTML += '<tr class="clsTRSectionHeader">';
                    //    StrHTML += '<td colspan="11" class="footable-last-column footable-first-column text-start">';
                    //    StrHTML += '<span class="footable-toggle"></span>' + strResult[i].CustomerName;
                    //    StrHTML += '</td>';
                    //    StrHTML += '</tr>';
                    //    StrHTML += '<tr class="clsTROdd">';
                    //    StrHTML += ' <td class="footable-first-column">';
                    //    StrHTML += '<span class="footable-toggle"></span>';
                    //    StrHTML += ' </td>';
                    //    StrHTML += '<td title="' + strResult[i].ContractSummary + '">';
                    //    StrHTML += '<a href="JavaScript:;">' + strResult[i].ContractSummary + '</a>';
                    //    StrHTML += ' </td>';
                    //    StrHTML += '<td>' + strResult[i].ContractTypeName + '</td>';
                    //    StrHTML += '<td>' + strResult[i].ContractStartDate + '</td>';
                    //    StrHTML += '<td>' + strResult[i].ContractSummaryDate + '</td>';
                    //    StrHTML += '<td>' + strResult[i].ContractEndDate + '</td>';
                    //    StrHTML += '<td>' + strResult[i].PONumber + '</td>';
                    //    StrHTML += '<td>' + strResult[i].POValue + '</td>';
                    //   // StrHTML += '<td class="footable-last-column">' + strResult[i].Currency + '</td>';
                    //    StrHTML += '<td class="footable-last-column">' + strResult[i].CurrencyCode + '</td>';
                    //   //Added & commented by Ajit L for comparission of Contract & Billing Cuerrency on 18/12/2023
                    //    StrHTML += '<td>';
                    //    StrHTML += '<div class="custom_chckbox">';
                    //    StrHTML += '<input type="hidden" id="Contract' + strResult[i].ContractTypeID + '" value="' + strResult[i].ContractSummary + '" />';
                    //    //Added 'strResult[i].ContractSummary' to function  selectContract() by Vishal on 29/12/23 to solve issue of Contract Name not getting correctly displayed
                    //    StrHTML += '<input id="ContractCheck_' + strResult[i].ContractID + '" class="chcktbl" type="checkbox" data-bs-dismiss="modal" value="' + strResult[i].ContractID + '" onclick="selectContract(' + strResult[i].ContractTypeID + ',' + strResult[i].ContractID + ',' + strResult[i].CurrencyID + ',\'' + strResult[i].ContractSummary + '\')">';  
                    //    StrHTML += '<label for="ContractCheck_' + strResult[i].ContractID + '"></label>';
                    //    StrHTML += '</div>';
                    //    StrHTML += '</td>';
                    //    StrHTML += '</tr>';

                    //}
                    //else
                       /* if (CustID == strResult[i].CustomerID) {*/
                        StrHTML += ' <tr class="clsTROdd">';
                        StrHTML += ' <td class="footable-first-column">';
                        StrHTML += '<span class="footable-toggle"></span>';
                        StrHTML += ' </td>';
                        StrHTML += '<td title="' + strResult[i].ContractSummary + '">';
                        StrHTML += '<a href="JavaScript:;">' + strResult[i].ContractSummary + '</a>';
                        StrHTML += ' </td>';
                        StrHTML += '<td>' + strResult[i].ContractTypeName + '</td>';
                        StrHTML += ' <td>' + strResult[i].ContractStartDate + '</td>';
                        StrHTML += '<td>' + strResult[i].ContractSummaryDate + '</td>';
                        StrHTML += ' <td>' + strResult[i].ContractEndDate + '</td>';
                        StrHTML += '<td>' + strResult[i].PONumber + '</td>';//Added By Ajit L for replacing N/A value on 14/12/2023
                        StrHTML += '<td>' + strResult[i].POValue + '</td>';
                       // StrHTML += '<td class="footable-last-column">' + strResult[i].Currency + '</td>';
                        StrHTML += '<td class="footable-last-column">' + strResult[i].CurrencyCode + '</td>';
                         //Added & commented by Ajit L for comparission of Contract & Billing Cuerrency on 18/12/2023
                        StrHTML += ' <td>';
                        StrHTML += '<div class="custom_chckbox">';
                        StrHTML += '<input type="hidden" id="Contract' + strResult[i].ContractTypeID + '" value="' + strResult[i].ContractSummary + '" />';
                        //Added 'strResult[i].ContractSummary' to function  selectContract() by Vishal on 29/12/23 to solve issue of Contract Name not getting correctly displayed
                        StrHTML += '<input id="ContractCheck_' + strResult[i].ContractID + '" class="chcktbl" type="checkbox" data-bs-dismiss="modal" value="' + strResult[i].ContractID + '" onclick="selectContract(' + strResult[i].ContractTypeID + ',' + strResult[i].ContractID + ',' + strResult[i].CurrencyID + ',\'' + strResult[i].ContractSummary + '\')">';
                        StrHTML += '<label for="ContractCheck_' + strResult[i].ContractID + '"></label>';
                        StrHTML += '</div>';
                        StrHTML += '</td>';
                        StrHTML += '</tr>';

                    //}
                    /*Commented by Vishal Mane on 29/12/23 to solve data-table issue if there is no contracts available against selected customer*/
                    //CustID = strResult[i].CustomerID;

                }
            }
                $("#contrctTableBody").html(StrHTML);//Added by Vishal on 03/01/2023
            /*Commented by Vishal Mane on 29/12/23 to solve data-table issue if there is no contracts available against selected customer*/
            //else {

            //    StrHTML = '<tr><td colspan="9">No data available in table</td></tr>';
            //}
           /* $('#contrctTable').dataTable().fnDestroy();*/

                        
            //s$(".table").resize();
            $('#contrctTable').DataTable({
                "paging": true,
                /*"pageLength": 3,*/
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                "bAutoWidth": false,
            });

            //if (GFlag == 0) {
            //    $("#TexthiddenContract").val(ContractID);

            //    ContractCheck_
            //}
            //else {


            //}



            if (GFlag == 0) {
                if ($("#TexthiddenContract").val() != "") {
                    var hdnIDs = $("#TexthiddenContract").val();
                    //var arrMasterIDs = hdnIDs.split(',');
                    //for (var i = 0; i < arrMasterIDs.length; i++) {
                    if ($("#ContractCheck_" + hdnIDs).val() == hdnIDs) {
                        $("#ContractCheck_" + hdnIDs).prop("checked", true);

                    }
                }
            }
            else {
                if ($("#TexthiddenContractE").val() != "") {
                    var hdnIDs = $("#TexthiddenContractE").val();
                    //var arrMasterIDs = hdnIDs.split(',');
                    //for (var i = 0; i < arrMasterIDs.length; i++) {
                    if ($("#ContractCheck_" + hdnIDs).val() == hdnIDs) {
                        $("#ContractCheck_" + hdnIDs).prop("checked", true);

                    }
                }

            }
        }

        var BaseCurrency = "";
        var LocalCurrency = "";
        var CorpCurrencyID = "";
        var CorpCurrencySymbol = "";
        function GetCurrencyCodes() {

            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetCurrencyCodes", '', false);
            BaseCurrency = Result.BaseCurncy;
            LocalCurrency = Result.LocalCurncy;
            CorpCurrencySymbol = Result.CorpCurrencySymbol;
            CorpCurrencyID = Result.BaseCurncyID;
        }


        var ProjectCurrency = "";
        var ProjectCurrencyCode = "";
        function GetProjectCurrency(flag) {
            debugger
            if (flag == 0) {
                var ProjectID = $("#cboProject").val();
                var RequestParameters = {
                    ProjectID: 655
                }
                var param = JSON.stringify(RequestParameters);
                var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetProjectCurrency", param, false);
                //ProjectCurrency = Result;
                ProjectCurrency = Result[0].ProjectCurrency;
                ProjectCurrencyCode = Result[0].CurrencyCode;

                
            } else {
                var FilterProjectID = $("#cboProjectFilter").val();
                var RequestParameters = {
                    ProjectID: FilterProjectID
                }
                var param = JSON.stringify(RequestParameters);
                var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetProjectCurrency", param, false);
                var FilterProjectCurrency = Result[0].ProjectCurrency;
                return FilterProjectCurrency;
            }

        }


        function GetRFIContractType() {
            ////
            if (GFlag == 0) {
                var CustomerID = $("#cboCustomer").val();
            } else {
                var CustomerID = $("#cboCustomerE").val();
            }

            if (CustomerID == 0) {
                CustomerID = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
            }
            var strHTML = "";
            
            var RequestParameters = {
                CustomerID: CustomerID
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIContractType", param, false);

            for (var i = 0; i < Result.length; i++) {
                var listComponent = Result[i];
                strHTML += ('<option value=' + listComponent.Contracttypeid + ' >' + listComponent.contracttypename + '</option>');

            }

            $("#cbocontractType").html(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        function ShowContractDetails() {
           // debugger;
            var Contract = "";
            if (GFlag == 0) {
                Contract = $("#txtContract").val();
            }
            else {
                Contract = $("#txtContractE").val();
            }
            if (Contract == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Blankcontract")%>');
                if (GFlag == 0) {
                    $("#txtContract").focus();
                }
                else {
                    $("#txtContractE").focus();
                }
            }
            else {
                $("#ShowDetailsModal").modal('show');
                var CustomerID = "";
                var ContractTypeId = "";
                if (GFlag == 0) {
                    CustomerID = $("#cboCustomer").val();
                    ContractTypeId = $("#TexthiddenContract").val();
                }
                else {
                    CustomerID = $("#cboCustomerE").val();
                    ContractTypeId = $("#TexthiddenContractE").val();
                   
                }


                if (CustomerID == 0) {
                    CustomerID = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
                }

                //var CustomerID =     $("#cboCustomer").val();
                //var ContractTypeId = $("#TexthiddenContract").val();
                var RequestParameters = {
                    CustomerID: CustomerID,
                    ContractTypeID: ContractTypeId
                }
                var param = JSON.stringify(RequestParameters);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ShowRFIContract", param, false);

                $("#lblCurrencyChange").text(strResult[0].ContractSummary);
                
                
                
                $("#lblCustomerName").text(strResult[0].CustomerName);
                //$("#lblCommencementDate").text(strResult[0].ContractSummaryDate);

                //Commented and Added By Riddhesh Patil on 08 Jan 2024
                $("#lblCommencementDate").text(strResult[0].ContractStartDate);
                $("#lblContrctEndDate").text(strResult[0].ContractEndDate);
                //End of Commented and Added By Riddhesh Patil on 08 Jan 2024

                //$("#lblContractDetail").text(strResult[0].ContractSummary);
                $("#lblContractDetail").text(strResult[0].InvoiceingMilestones);
                $("#lblPOSOWNumber").text(strResult[0].PONumber);
                $("#lblPOSOWValue").text(strResult[0].POValue);
                $("#lblCRMNO").text(strResult[0].CRMNO);
                $("#lblContractType").text(strResult[0].ContractTypeName);

                //Commented and Added By Riddhesh Patil on 08 Jan 2024
                //$("#lblContrctSignDate").text(strResult[0].ContractStartDate);
                $("#lblContrctSignDate").text(strResult[0].ContractSummaryDate);
                //End of Commented and Added By Riddhesh Patil on 08 Jan 2024

                //Added & Commented by Ajit L on 14/12/2023 to solve issue of contract Currency start
                $("#lblContcurrency").text(strResult[0].CurrencyCode);
                //GetCurrencySymb();
                 //Added & Commented by Ajit L on 14/12/2023 to solve issue of contract Currency end                
                if (strResult[0].RemainingPOWVal < 0) {
                    $("#lbl_RemainPOVal").css('color', 'red');
                    $("#lbl_RemainPOVal").text(strResult[0].RemainingPOWVal);
                }
                else {
                    $("#lbl_RemainPOVal").css('color', 'green');
                    $("#lbl_RemainPOVal").text(strResult[0].RemainingPOWVal);
                }
                GetRFIContractDocument();

            }
        }



        function GetRFIContractDocument() {
            var strHTML = "";
            var Projectid = $("#cboProject").val();
            var RequestParameters = {
                ContractID: SelectedContractID
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIContractDocument", param, false);
            if (Result.length > 0 && Result.length != null && Result != undefined) {
                for (var i = 0; i < Result.length; i++) {
                    var ContractAttachmentID = Result[i]["ContractAttachmentID"];
                    var ContractID = Result[i]["ContractID"];
                    var OriginalFileName = Result[i]["OriginalFileName"];
                    var FileSize = Result[i]["FileSize"];
                    var AttachedBy = Result[i]["AttachedBy"];
                    var AttachedOn = Result[i]["AttachedOn"];
                    var Description = Result[i]["Description"];
                    var SystemFileName = Result[i]["SystemFileName"];
                    strHTML += '<tr>'
                    strHTML += '<td> ' + (i + 1) + '</td>'
                    strHTML += '<td> <a href="javascript:;" class="textUndrln" onclick="DownloadFile(\'' + OriginalFileName + '\',\'' + SystemFileName + '\') ">' + OriginalFileName + '</a></td>'
                    strHTML += '<td>' + AttachedBy + '</td>'
                    strHTML += '<td>' + AttachedOn + '</td>'
                    strHTML += '<td>' + Description + '</td>'
                    strHTML += '</tr>'
                }
            }

            $('#ContractAttachTbl').dataTable().fnDestroy();

            $("#ContractAttachTblBody").html(strHTML);
            $('#ContractAttachTbl').dataTable({
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "destroy": true,
                "bFilter": false,
                /*  "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] }]*/
            });
            $(".table").resize();
        }

        function DownloadFile(OriginalFileName, SystemFileName) {
            if (SystemFileName == null) {
                SystemFileName = '';
            }
            var strTemp = '../../General/ViewAttachment.aspx?FromWhere=Contracts&FileName=' + OriginalFileName + '&SystemFileName=' + SystemFileName;
            window.open(strTemp);
        }

        function GetRFISalesPerson() {
            var strHTML = "";
            var ProjectId = $("#cboProject").val();
            var SalesPerson = $("#txtsalesPersonInput").val();
            var SalesPersCommision = $("#txtsalesComissionInput").val();
            var RequestParameters = {
                ProjectID: ProjectId,
                SalesPerson: SalesPerson,
                SalesPersCommision: SalesPersCommision
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFISalesPerson", param, false);
            if (Result.length > 0 && Result.length != null && Result != undefined) {
                for (var i = 0; i < Result.length; i++) {
                    var ProjectSalesPersonID = Result[i]["SalesPersonID"];
                    //Commented and Added by Riddhesh Patil on 28 Dec 2023 for filter issue

                    //var UserName = Result[i]["UserName"];
                    var UserName = Result[i]["employeename"];

                    //End of Commented and Added by Riddhesh Patil on 28 Dec 2023 for filter issue
                    var SalesCommissionPercentage = Result[i]["SalesCommissionPercentage"];
                    strHTML += '<tr>'
                    strHTML += '<td>' + UserName + '</td>'
                    strHTML += '<td>' + SalesCommissionPercentage + '</td>'
                    strHTML += '<input type="hidden" id="hdnSalesPer' + ProjectSalesPersonID + '" value="' + UserName + '" />';
                    strHTML += '<td> <div class="custom_chckbox">  <input id="descrGridcheck' + ProjectSalesPersonID + '" name="checksalesPerson" class="chcktbl" type="checkbox" value="' + ProjectSalesPersonID + '" /> <label for="descrGridcheck' + ProjectSalesPersonID + '"></label>   </div></td>'

                    strHTML += '</tr>'
                }
            }

            $('#salesPersonTbl').dataTable().fnDestroy();

            $("#salesPersonTblBody").html(strHTML);
            $('#salesPersonTbl').dataTable({
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "destroy": true,
                "bFilter": false,
                /*  "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] }]*/
            });
            $(".table").resize();


            if (GFlag == 0) {
                if ($("#txthdnSalesPer").val() != "") {
                    var hdnIDs = $("#txthdnSalesPer").val();
                    var arrMasterIDs = hdnIDs.split(',');
                    for (var i = 0; i < arrMasterIDs.length; i++) {
                        //if ($("#descrGridcheck" + arrMasterIDs[i]).val() == arrMasterIDs[i]) {
                        //    $("#descrGridcheck" + arrMasterIDs[i]).prop("checked", true);

                        //}
                        if ($("#descrGridcheck" + arrMasterIDs[i].trim()).val() == arrMasterIDs[i].trim()) {
                            $("#descrGridcheck" + arrMasterIDs[i].trim()).prop("checked", true);

                        }
                    }
                }
            }
            else {
                if ($("#txthdnSalesPerE").val() != "") {
                    var hdnIDs = $("#txthdnSalesPerE").val();
                    var arrMasterIDs = hdnIDs.split(',');
                    for (var i = 0; i < arrMasterIDs.length; i++) {
                        //if ($("#descrGridcheck" + arrMasterIDs[i]).val() == arrMasterIDs[i]) {
                        //    $("#descrGridcheck" + arrMasterIDs[i]).prop("checked", true);

                        //}
                        if ($("#descrGridcheck" + arrMasterIDs[i].trim()).val() == arrMasterIDs[i].trim()) {
                            $("#descrGridcheck" + arrMasterIDs[i].trim()).prop("checked", true);

                        }
                    }
                }
            }






        }



        function GetContactEmailID(ContactPer, flag) {
            
            //var CustomerID = $("#cboCustomer").val();
            //var RequestParameters = {
            //    CustomerID: CustomerID,
            //    CustomerContactID: ContactPer
            //}
            //var param = JSON.stringify(RequestParameters);
            //var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIContactEmail", param, false);

            //if (Result != "" || Result != undefined) {
            //    $("#txtEmail_Confirm").val(Result);
            //}

            //Modified by Vishal on 19/12/2023 to get correct Email ID while adding or editing IR/PIR
            if (flag == 0) {
                var CustomerID = $("#cboCustomer").val();
            } else {
                var CustomerID = $("#cboCustomerE").val();
            }

            if (CustomerID == 0) {
                CustomerID = ($("#cboCustomer").val()) || $("#cboCustomerE").val();
            }
            var RequestParameters = {
                CustomerID: CustomerID,
                CustomerContactID: ContactPer
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIContactEmail", param, false);
            if (flag == 0) {
                if (Result != "" || Result != undefined) {
                    $("#txtEmail_Confirm").val(Result);
                }
            } else {
                if (Result != "" || Result != undefined) {
                    $("#txtEmail_ConfirmE").val(Result);
                }
            }
            //End of Modified by Vishal on 19/12/2023 to get correct Email ID while adding or editing IR/PIR
        }


        function GetRFIProjectbillingCurrency() {
            var ProjectID = $("#cboProject").val();
            var RequestParameters = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIProjectbillingCurrency", param, false);
            GCurrencyID = Result;
            return Result;
        }

        function selectSalesPeriod(SalesPeriodId) {
            var SalesPeriod = $("#SalesPeriod" + SalesPeriodId).val()
            if (GFlag == 0) {
                $("#txthdnSalesPeriod").val(SalesPeriodId);
                $("#txtSalesPeriod").val(SalesPeriod);
            }
            else {
                $("#txthdnSalesPeriodE").val(SalesPeriodId);
                $("#txtSalesPeriodE").val(SalesPeriod);
            }
        }


        function selectSalesPerson() {

            var SalesPerson = [];
            var table = $('#salesPersonTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var SalesPerId = $('input[name=checksalesPerson]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrMasterIDs = SalesPerId.split(',');
            // if (arrMasterIDs.length > 1) {
            for (var i = 0; i < arrMasterIDs.length; i++) {
                SalesPerson.push($("#hdnSalesPer" + arrMasterIDs[i]).val());
            }
            //}
            // else {

            // }
            $("#SalesPersonModal").modal('hide');
            //$("#saveSalesPersonBtn").attr('data-bs-dismiss', 'modal')
            var strSalesPerson = SalesPerson.join(',');
            if (GFlag == 0) {
                $("#txthdnSalesPer").val(SalesPerId);

                $("#txtSalesPerson").val(strSalesPerson);
            }
            else {
                $("#txthdnSalesPerE").val(SalesPerId);

                $("#txtSalesPersonE").val(strSalesPerson);
            }


            // alert($("#txthdnSalesPer").val());
        }
        //Added by Ajit L on 29/12/23
        var SelectedContractID = "";
        var SelectedContractCurncy = ""
        function selectContract(ContractTypeID, ContractID, CurrencyId, ContractSummary) {
            //debugger;
            if (GFlag == 0) {
                //$("#TexthiddenContract").val(ContractID);
                //Commented & Added By Dipali V on 15th Jan 2024 For Contract Details showing wronge
                //$("#TexthiddenContract").val(ContractTypeID);
                $("#TexthiddenContract").val(ContractID);
                  //End of Commented & Added By Dipali V on 15th Jan 2024 For Contract Details showing wronge
                //Commentec and Added 'ContractSummary' to selectContract() by Vishal on 29/12/23 to solve issue of Contract Name not getting correctly displayed
                //var ContractName = $("#Contract" + ContractTypeID).val();
                //$("#txtContract").val(ContractName);                
                $("#txtContract").val(ContractSummary);
                SelectedContractID = ContractID;
                SelectedContractCurncy = CurrencyId
            }
            else {
                //$("#TexthiddenContractE").val(ContractID);
                  //Commented & Added By Dipali V on 15th Jan 2024 For Contract Details showing wronge
                //$("#TexthiddenContractE").val(ContractTypeID);
                $("#TexthiddenContractE").val(ContractID);
                  //End of Commented & Added By Dipali V on 15th Jan 2024 For Contract Details showing wronge
              
                //Commentec and Added 'ContractSummary' to selectContract() by Vishal on 29/12/23 to solve issue of Contract Name not getting correctly displayed
                //var ContractName = $("#Contract" + ContractTypeID).val();
                //$("#txtContractE").val(ContractName);
                $("#txtContractE").val(ContractSummary);
                SelectedContractID = ContractID;
                SelectedContractCurncy = CurrencyId
            }

        }
         //End of Added by Ajit L on 29/12/23




        var IsProjectOrBillingCurrencyCheck = 0;
        var BillingCurrencyID = 0;
        var BaseCurrencyID = 0;
        var LocalCurrencyID = 0;
        var IRApprover = 0;
        var IsAllValuesInSiteCurrency = 0;
        function CheckIRGenerationValidation() {
          //  debugger
            var Validate = true;
            var BillingCurrencyID = "";
            var Projectid = $("#cboProject").val();
            var Parameters = {
                ProjectID: Projectid
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateIRConfiguration", param, false);
            if (strResult != "") {
                for (var i = 0; i < strResult.length; i++) {
                    BillingCurrencyID = strResult[i].BillingCurrencyID
                    BaseCurrencyID = strResult[i].BaseCurrencyID
                    LocalCurrencyID = strResult[i].LocalCurrencyID
                    CompanyBaseCurrencyID = strResult[i].CompanyBaseCurrencyID
                    InvoiceResponsiblePerson = strResult[i].InvoiceResponsiblePerson
                    IRApprover = strResult[i].IRApprover
                    CORPORATE_BASE_CONVERSRIONRATE = strResult[i].CORPORATE_BASE_CONVERSRIONRATE
                    IRCOMPANY_BASE_CONVERSRIONRATE = strResult[i].IRCOMPANY_BASE_CONVERSRIONRATE
                    IsProjectOrBillingCurrencyCheck = strResult[i].IsProjectOrBillingCurrencyCheck
                    IsAllValuesInSiteCurrency = strResult[i].IsAllValuesInSiteCurrency
                }
            }

            if (IRApprover == 0 || IRApprover == null) {
                IRApprover = "";
            }

            if (InvoiceResponsiblePerson == 0 || InvoiceResponsiblePerson == null) {
                InvoiceResponsiblePerson = "";
            }

            alertify.set('notifier', 'position', 'top-right');
            if (BillingCurrencyID == 0 || BillingCurrencyID == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_BILLING")%>');
                Validate = false;
                return false
            }

            else if (BaseCurrencyID == 0 || BaseCurrencyID == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_BASECODE")%>');
                Validate = false;
                return false

            }
            else if (CompanyBaseCurrencyID == 0 || CompanyBaseCurrencyID == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_COMPANYBASECODE")%>');
                Validate = false;
                return false

            }
            else if (IRApprover == 0 || IRApprover == "") {
                alertify.error('<%=MyBase.GetResourceString("A_SetIRApprover")%>');
                Validate = false;
                return false

            }
            else if (InvoiceResponsiblePerson == 0 || InvoiceResponsiblePerson == "") {
                alertify.error('<%=MyBase.GetResourceString("A_SetIRRespPerson")%>');
                Validate = false;
                return false

            }
            else if (CORPORATE_BASE_CONVERSRIONRATE == "NO_CORPORATE_BASE_CONVERSRIONRATE") {
                alertify.error('<%=MyBase.GetResourceString("A_CorporateBaseCurrencyConversionRate")%>');
                Validate = false;
                return false

            }
            else if (IRCOMPANY_BASE_CONVERSRIONRATE == "NO_IRCOMPANY_BASE_CONVERSRIONRATE") {
                alertify.error('<%=MyBase.GetResourceString("A_IRCompanyBaseCurrencyConversionRate")%>');
                Validate = false;
                return false

            }

            //Commented by Ajit L for avoiding project, Billing curency comparision Contract on 19/12/2023 start
     <%--       if (IsProjectOrBillingCurrencyCheck == 1) {
                if ($("#txtContractE").val() != BillingCurrencyID) {
                    alertify.error('<%=MyBase.GetResourceString("A_ProjectAndContractCurrency")%>');
                    $("#txtContract").focus();
                    IsValidate = false;
                    return false
                }
                else {
                    if ($("#txtContractE").val() != BaseCurrencyID) {
                        alertify.error('<%=MyBase.GetResourceString("A_BillingAndContractCurrency")%>');
                        $("#txtContract").focus();
                        IsValidate = false;
                        return false;
                    }

                }
            }--%>
            //Commented by Ajit L for avoiding project, Billing curency comparision Contract on 19/12/2023 end

            return Validate;
        }


        var ProjectStartdate = "";
        var ProjectEnddate = "";
        var ISProjectOver = "";
        
        function GetProjectSettingsDetails() {
           
            var ProjectId = $("#cboProject").val();

            var RequestParameters = {
                ProjectID: ProjectId,
               
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetProjectSettingsDetails", param, false);
            for (var i = 0; i < Result.length; i++) {
                LocationId = Result[i].LocationID;
                ProjectStartdate = Result[i].ProjectStartDate;
                ProjectEnddate = Result[i].ProjectEndDate;
                ISProjectOver = Result[i].ISProjectActive;


            }
            return Result;
        }

        var IsValidate = true;
        //for validate While IR creation
        function ValidateIR(flag,ProjectID) {
            
            GetGlobalCurrencies(ProjectID);
            //ProjectCurrency
            alertify.set('notifier', 'position', 'top-right');
            IsValidate = true;
            //CheckIRGenerationValidation();
            var Result = GetProjectSettingsDetails();
            var prjStartDate = Result[0].ProjectStartDate

            var today = new Date();
            var TodaysDate = convert(today);
            if (flag == 1) {
                if ($("#cboRFITypeE").val() == 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_TypeBlank")%>');
                    $("#cboRFITypeE").focus();
                    IsValidate = false;
                    return false
                }
                if ($("#cboCustomerE").val() == 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_CustomerBlank")%>');
                    $("#cboCustomerE").focus();
                    IsValidate = false;
                    return false
                }

                if ($("#cboContactPerE").val() == 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_ContactPersonBlank")%>');
                    $("#cboContactPersonE").focus();
                    IsValidate = false;
                    return false
                }
                if ($("#txtEmail_ConfirmE").val() != "") {
                    if (ValidateEmailID($("#txtEmail_ConfirmE").val()) == false) {
                        alertify.error('<%=MyBase.GetResourceString("A_ValidEmail")%>');
                        $("#txtEmail_ConfirmE").focus();
                        IsValidate = false;
                        return false

                    }
                }

                if ($("#txtContractE").val() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_ContractBlank")%>');
                    $("#txtContractE").focus();
                    IsValidate = false;
                    return false
                }



                //var InConvDate = convertIDate($("#toDateFilterE").val().trim());
                //ProjectStartdate = convertIDate(ProjectStartdate.trim())


                var InConvDate = new Date($("#toDateFilterE").val());
                prjStartDate = new Date(prjStartDate);

                if ($("#toDateFilterE").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_ICDateBlank")%>');
                    $("#toDateFilterE").focus();
                    IsValidate = false;
                    return false
                }
                else if ($("#toDateFilterE").val().trim() != "") {
                    if (InConvDate > today) {
                        alertify.error('<%=MyBase.GetResourceString("A_ICDategreaterthantoday")%>');
                        $("#toDateFilterE").focus();
                        IsValidate = false;
                        return false
                    }
                    else if (InConvDate.getTime() < prjStartDate.getTime()) {
                        alertify.error('<%=MyBase.GetResourceString("A_ICDateandPrjDateless")%> (' + ProjectStartdate + ').');
                        $("#toDateFilterE").focus();
                        IsValidate = false;
                        return false
                    }
                }


                if ($("#txtCreditDaysE").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_CredityDaysBlank")%>');
                    $("#txtCreditDaysE").focus();
                    IsValidate = false;
                    return false
                }

                if ($("#txtSalesPeriodE").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_SalesPeriodBlank")%>');
                    $("#txtSalesPeriodE").focus();
                    IsValidate = false;
                    return false
                }

                if ($("#txtAItemHeadE").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_ItemHeaderBlank")%>');
                    $("#txtAItemHeadE").focus();
                    IsValidate = false;
                    return false
                }

                //Added by Aditya J. on 19-11-2024
                if (checkSpecialCharacter($("#txtAItemHeadE").val().trim(), WebConfigSpecialCharacters) == true) {                   
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('IR Items Header should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtAItemHeadE").focus();
                    IsValidate = false;
                    return false;
                }
                //End of Added by Aditya J. on 19-11-2024

                //Added and commented by Ajit L for comparision of Contract currency with Project & billing currency on 19/12/2023 start
        <%--        if (IsProjectOrBillingCurrencyCheck == 1) {
                    if ($("#txtContractE").val() != "") {
                        if (SelectedContractCurncy != GCurrencyID) {
                            alertify.error('<%=MyBase.GetResourceString("A_ProjectAndContractCurrency")%>');
                            IsValidate = false;
                            return false
                        }
                        else {
                            if (SelectedContractCurncy != BaseCurrencyID) {
                                alertify.error('<%=MyBase.GetResourceString("A_BillingAndContractCurrency")%>');
                                IsValidate = false;
                                return false;
                            }

                        }
                    }
                }--%>

                //Added by Vishal on 21/12/2023 to solve If Billing to IR company base currency conversion rate not defined 
                var CustomerID = $("#cboCustomerE").val();
                var ContractTypeId = $("#TexthiddenContractE").val();              
                var RequestParameters = {
                    CustomerID: CustomerID,
                    ContractTypeID: ContractTypeId
                }
                var param = JSON.stringify(RequestParameters);
                var strResultE = AJAXCallWithResult("/api/RFI_IR_PIR/ShowRFIContract", param, false);
                if (strResultE.length > 0) {
                    var SelectedContractCurncyE = strResultE[0].CurrencyID;
                } else {
                    alertify.error('Please define the contract currency. Please contact Administrator or define the contract currency');
                    IsValidate = false;
                    return false;
                }                             
                if (IsProjectOrBillingCurrencyCheck == 1) {
                    if ($("#txtContractE").val() != "") {
                        if (SelectedContractCurncyE != GCurrencyID) {
                         //Commented and Added By Riddhesh Patil for issue: same alert is displaying
                           <%-- alertify.error('<%=MyBase.GetResourceString("A_BillingAndContractCurrency")%>');--%>
                            alertify.error('<%=MyBase.GetResourceString("A_ProjectAndContractCurrency")%>');
                            //End of Commented and Added By Riddhesh Patil for issue: same alert is displaying
                            IsValidate = false;
                            return false
                        }
                        
                    }
                }


                else if (IsProjectOrBillingCurrencyCheck == 0)  {
                    //if (SelectedContractCurncy != BaseCurrencyID) {
                    if (SelectedContractCurncyE != billingcurencyId) {
                        
                         alertify.error('<%=MyBase.GetResourceString("A_BillingAndContractCurrency")%>');
                         IsValidate = false;
                         return false;
                    }
                }

                //Added by Vishal on 21/12/2023 to solve If Billing to IR base currency conversion rate is not defined 
                var RFIID = G_RFIID;
               
                var InvoiceConversionDate = $('#toDateFilterE').val();
                var ExpencesCurrencyIDsDetails = {
                    ExpencesCurrencyIDs: BillingCurrencyID,
                    InvoiceConversionDate: InvoiceConversionDate,
                    CorpBaseCurrencyID: CorporateBaseCurrencyID,
                    RFIID: RFIID
                }
                var param = JSON.stringify(ExpencesCurrencyIDsDetails);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpenseCurrencyIDs", param, false);
                if (strResult != null) {
                    $.each(strResult, function (index, obj) {                        
                        if (obj.Flag == 0 && obj.CurrencyID != CorporateBaseCurrencyID) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Currency Conversion rate on invoice conversion date (' + InvoiceConversionDate + ') of Billing Currency(' + BillingCurrencyCode + ') to  Corporate Base Currency(' + CorporateBaseCurrencyCode +') is not defined. Please contact Administartor!');
                            IsValidate = false;
                            return false;
                        }                        
                    });
                }

                 //Vishal 26/12
                var RFIID = G_RFIID;
                var ExpencesCurrencyIDsDetails = {
                    ExpencesCurrencyIDs: BillingCurrencyID,
                    InvoiceConversionDate: InvoiceConversionDate,
                    CorpBaseCurrencyID: CompanyBaseCurrencyID,
                    RFIID: RFIID
                }
                var param = JSON.stringify(ExpencesCurrencyIDsDetails);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpenseCurrencyIDs", param, false);
                if (strResult != null) {
                    $.each(strResult, function (index, obj) {
                        //if (obj.Flag == 0 && obj.CurrencyID != CorporateBaseCurrencyID) {     //Commented by Vishal on 28/12/2023 
                        if (obj.Flag == 0 && obj.CurrencyID != CompanyBaseCurrencyID) {         //Added by Vishal on 28/12/2023
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Currency Conversion rate on invoice conversion date (' + InvoiceConversionDate + ') of Billing Currency(' + BillingCurrencyCode + ') to  Comapny Base Currency(' + CompanyBaseCurrencyCode + ') is not defined. Please contact Administartor!');
                            IsValidate = false;
                            return false;
                        }
                    });
                }
                 //End of Vishal 26/12
                //End of Added by Vishal on 21/12/2023 to solve If Billing to IR  base currency conversion rate is not defined 
              //Added and commented by Ajit L for comparision of Contract currency with Project & billing currency on 19/12/2023 start
            }

            else {
                if ($("#cboRFIType").val() == 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_TypeBlank")%>');
                    $("#cboRFIType").focus();
                    IsValidate = false;
                    return false
                }
                if ($("#cboCustomer").val() == 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_CustomerBlank")%>');
                    $("#cboCustomer").focus();
                    IsValidate = false;
                    return false
                }

                if ($("#cboContactPer").val() == 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_ContactPersonBlank")%>');
                    $("#cboContactPerson").focus();
                    IsValidate = false;
                    return false
                }
                if ($("#txtEmail_Confirm").val() != "") {
                    if (ValidateEmailID($("#txtEmail_Confirm").val()) == false) {
                        alertify.error('<%=MyBase.GetResourceString("A_ValidEmail")%>');
                        $("#txtEmail_Confirm").focus();
                        IsValidate = false;
                        return false

                    }
                }
                if ($("#txtContract").val() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_ContractBlank")%>');
                    $("#txtContract").focus();
                    IsValidate = false;
                    return false
                }



                var InConvDate = new Date(convertIDate($("#toDateFilter").val().trim()));
                prjStartDate = new Date(prjStartDate);
                if ($("#toDateFilter").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_ICDateBlank")%>');
                    $("#toDateFilter").focus();
                    IsValidate = false;
                    return false
                }
                else if ($("#toDateFilter").val().trim() != "") {
                    if (InConvDate > today) {
                        alertify.error('<%=MyBase.GetResourceString("A_ICDategreaterthantoday")%>');
                        $("#toDateFilter").focus();
                        IsValidate = false;
                        return false
                    }
                    else if (InConvDate.getTime() < prjStartDate.getTime()) {
                        alertify.error('<%=MyBase.GetResourceString("A_ICDateandPrjDateless")%> (' + ProjectStartdate + ').');
                        $("#toDateFilter").focus();
                        IsValidate = false;
                        return false
                    }
                }

                if ($("#txtCreditDays").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_CredityDaysBlank")%>');
                    $("#txtCreditDays").focus();
                    IsValidate = false;
                    return false
                }

                if ($("#txtSalesPeriod").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_SalesPeriodBlank")%>');
                    $("#txtSalesPeriod").focus();
                    IsValidate = false;
                    return false
                }


                if ($("#txtAItemHead").val().trim() == "") {
                    alertify.error('<%=MyBase.GetResourceString("A_ItemHeaderBlank")%>');
                    $("#txtAItemHead").focus();
                    IsValidate = false;
                    return false
                }

                //Added by Aditya J. on 19-11-2024
                if (checkSpecialCharacter($("#txtAItemHead").val().trim(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('IR Items Header should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtAItemHead").focus();
                    IsValidate = false;
                    return false;
                }
                //End of Added by Aditya J. on 19-11-2024

                   //Added and commented by Ajit L on 19/12/2023 to compare Project, Billing with contract Currency -start
<%--                if (IsProjectOrBillingCurrencyCheck == 1) {
                    if ($("#txtContract").val() != "") {

                        if (SelectedContractCurncy != GCurrencyID) {
                            alertify.error('<%=MyBase.GetResourceString("A_ProjectAndContractCurrency")%>');
                            IsValidate = false; 
                            return false
                        }
                        else {
                            if (SelectedContractCurncy != BaseCurrencyID) {
                                alertify.error('<%=MyBase.GetResourceString("A_BillingAndContractCurrency")%>');
                                IsValidate = false;
                                return false;
                            }

                        }
                    }
                }--%>

             
                if (IsProjectOrBillingCurrencyCheck == 1) {
                    if ($("#txtContract").val() != "") {

                        if (SelectedContractCurncy != GCurrencyID) {
                            //Commented and Added By Riddhesh Patil for issue: same alert is displaying
                           <%-- alertify.error('<%=MyBase.GetResourceString("A_BillingAndContractCurrency")%>');--%>
                            alertify.error('<%=MyBase.GetResourceString("A_ProjectAndContractCurrency")%>');
                            //End of Commented and Added By Riddhesh Patil for issue: same alert is displaying
                            IsValidate = false;
                            return false
                        }
                        
                    }
                }


                else if (IsProjectOrBillingCurrencyCheck == 0)  {
                    //if (SelectedContractCurncy != BaseCurrencyID) {
                    if (SelectedContractCurncy != billingcurencyId) {

                        alertify.error('<%=MyBase.GetResourceString("A_BillingAndContractCurrency")%>');
                        IsValidate = false;
                        return false;
                    }

                }
                //Added by Vishal on 21/12/2023 to solve If Billing to IR base currency conversion rate is not defined 
                var RFIID = G_RFIID;
                var InvoiceConversionDate = $('#toDateFilter').val();
                var ExpencesCurrencyIDsDetails = {
                    ExpencesCurrencyIDs: BillingCurrencyID,
                    InvoiceConversionDate: InvoiceConversionDate,
                    CorpBaseCurrencyID: CorporateBaseCurrencyID,
                    RFIID: RFIID
                }
                var param = JSON.stringify(ExpencesCurrencyIDsDetails);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpenseCurrencyIDs", param, false);
                if (strResult != null) {
                    $.each(strResult, function (index, obj) {
                        if (obj.Flag == 0 && obj.CurrencyID != CorporateBaseCurrencyID) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Currency Conversion rate on invoice conversion date (' + InvoiceConversionDate + ') of Billing Currency(' + BillingCurrencyCode + ') to  Corporate Base Currency(' + CorporateBaseCurrencyCode + ') is not defined. Please contact Administartor!');
                            IsValidate = false;
                            return false;
                        }
                    });
                }

                 //Vishal 26/12
                var RFIID = G_RFIID;
                var ExpencesCurrencyIDsDetails = {
                    ExpencesCurrencyIDs: BillingCurrencyID,
                    InvoiceConversionDate: InvoiceConversionDate,
                    CorpBaseCurrencyID: CompanyBaseCurrencyID,
                    RFIID: RFIID
                }
                var param = JSON.stringify(ExpencesCurrencyIDsDetails);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpenseCurrencyIDs", param, false);
                if (strResult != null) {
                    $.each(strResult, function (index, obj) {
                        //if (obj.Flag == 0 && obj.CurrencyID != CorporateBaseCurrencyID) {     //Commented by Vishal on 28/12/2023 
                        if (obj.Flag == 0 && obj.CurrencyID != CompanyBaseCurrencyID) {         //Added by Vishal on 28/12/2023
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Currency Conversion rate on invoice conversion date (' + InvoiceConversionDate + ') of Billing Currency(' + BillingCurrencyCode + ') to  Comapny Base Currency(' + CompanyBaseCurrencyCode + ') is not defined. Please contact Administartor!');
                            IsValidate = false;
                            return false;
                        }
                    });
                }
                 //End of Vishal 26/12
                  //End of Added by Vishal on 21/12/2023 to solve If Billing to IR  base currency conversion rate is not defined
            }

            return IsValidate;

        }

        var GCurrencyID = 0;
        var UserName = '<%= Session("strUserName") %>';
        function CreateIR(flag) {
           
            //var EditCopyFlag = $("#txtEditCopyFlag").val();
            var IsProforma = 0;
            GetRFIProjectbillingCurrency();
            //CheckIRGenerationValidation();
            var ProjectID = $("#txtProjectID").val();
            var Validate = ValidateIR(flag, ProjectID);
            //Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
            var Currentstatus = "";
            //End of Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
           
                if (Validate == true) {
                    if (flag == 0) {
                        if ($("#IR_Add").prop('checked') == true) {
                            IsProforma = 0;
                        } else {
                            IsProforma = 1;
                        }
                        var RFITypeID = $("#cboRFIType").val();
                        var RFID = 0;
                        //var ProjectID = 0;
                        var CustomerID = $("#cboCustomer").val();
                        var CustomerContactID = $("#cboContactPer").val();
                        //var CustomerAddressID = $("#cboCust_Address").val();
                        var BillingCurrencyID = GCurrencyID
                        var CreditDays = $("#txtCreditDays").val();
                        var ConfirmEmailID = $("#txtEmail_Confirm").val();
                        var LOC = 0;
                        var MilestoneID = 0;
                        var ContractID = $("#TexthiddenContract").val();

                        //var RFIHeader = $("#txtAItemHead").val().trim();
                        //Modified by vishal to limit 2000 characters on 18/12/23
                        var RFIHeader = $("#txtAItemHead").val().trim().replace(/'/g, "''");
                        // Modified by vishal to limit 2000 characters on 18/12/23


                        var SalesPeriodID = $("#txthdnSalesPeriod").val();
                        var CreatorOrModifier = UserName
                        var InvoiceDate = $("#toDateFilter").val();
                        //var InvoiceDate = $("#txtInvoiceDate").val();
                        var SalesPersonIDs = $("#txthdnSalesPer").val();
                        var ProjectID = $("#cboProject").val();
                        //alert(AddressID);
                        //Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
                        Currentstatus = "Draft";
                        //End of Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
                    }
                    else {

                        if ($("#IR_AddE").prop('checked') == true) {
                            IsProforma = 0;
                        } else {
                            IsProforma = 1;
                        }
                        var RFITypeID = $("#cboRFITypeE").val();
                        var RFID = $("#txtEdtbleIR_ID_Filter").val();
                        /*var RFID;*/
                        //if (EditCopyFlag == 1) {
                        //    RFID = 0
                        //} else {
                        //    RFID = $("#txtEdtbleIR_ID_Filter").val();
                        //}

                        //var ProjectID = 0;
                        var CustomerID = $("#cboCustomerE").val();
                        var CustomerContactID = $("#cboContactPerE").val();
                        //var CustomerAddressID = $("#cboCust_Address").val();
                        var BillingCurrencyID = GCurrencyID
                        var CreditDays = $("#txtCreditDaysE").val();
                        var ConfirmEmailID = $("#txtEmail_ConfirmE").val();
                        var LOC = 0;
                        var MilestoneID = 0;
                        var ContractID = $("#TexthiddenContractE").val();

                        //var RFIHeader = $("#txtAItemHeadE").val().trim(); 
                        //Modified by Vishal Mane to limit 2000 characters on 18/12/23 and to solve crash due to RFIHeader
                        var RFIHeader = $("#txtAItemHeadE").val().trim().replace(/'/g, "''");
                        //End of Modified by Vishal Mane to limit 2000 characters on 18/12/23 and to solve crash due to RFIHeader

                        var SalesPeriodID = $("#txthdnSalesPeriodE").val();
                        var CreatorOrModifier = UserName
                        var InvoiceDate = $("#toDateFilterE").val();
                        //var InvoiceDate = $("#txtInvoiceDate").val();
                        var SalesPersonIDs = $("#txthdnSalesPerE").val();
                        var ProjectID = $("#cboProject").val();
                        //Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
                        Currentstatus = $("#EdtbleIR_ID_Status").text();
                        //End of Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
                        //alert(AddressID);
                    }
                    var Parameters = {
                        ProjectID: encodeURI(ProjectID),
                        RFID: encodeURI(RFID),
                        IsProforma: encodeURI(IsProforma),
                        RFITypeID: encodeURI(RFITypeID),
                        CustomerID: encodeURI(CustomerID),
                        CustomerContactID: encodeURI(CustomerContactID),
                        CustomerAddrID: encodeURI(AddressID),
                        BillingCurrencyID: encodeURI(BillingCurrencyID),
                        CreditDays: encodeURI(CreditDays),
                        ConfirmEmailID: encodeURI(ConfirmEmailID),
                        LOC: encodeURI(LOC),
                        MilestoneID: encodeURI(MilestoneID),
                        ContractID: encodeURI(ContractID),
                        RFIHeader: encodeURI(RFIHeader),
                        SalesPeriodID: encodeURI(SalesPeriodID),
                        CreatorOrModifier: encodeURI(CreatorOrModifier),
                        InvoiceDate: InvoiceDate,
                        SalesPersonIDs: SalesPersonIDs,
                        Status: Currentstatus
                    }
                    //return;
                    var param = JSON.stringify(Parameters);
                    var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/CreateIRItem", param, false);
                    if (strResult != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        if (flag == 0) {
                            // alertify.success('<%=MyBase.GetResourceString("A_IRCreated")%>');  //Vishal 26/12
                            $("#offcvsIRPIR_Add_Screen").hide();
                            // $("#offcvsIRPIR_2ndEdit_Screen").modal('show');
                            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcvsIRPIR_2ndEdit_Screen'));
                            myOffcanvas.show();
                            $(".offcanvas-backdrop").removeClass("show");
                            //Added by Vishal on 18/12/23
                            $("#txtAItemHead").val('');
                            EditIRPIR(strResult.RFID);
                            alertify.success('<%=MyBase.GetResourceString("A_IRCreated")%>');  //Vishal 26/12
                        }
                        else {
                            //alertify.success('<%=MyBase.GetResourceString("A_IRUpdated")%>');  //Vishal 26/12
                            //Added by Vishal on 18/12/23
                            $("#txtAItemHeadE").val('');
                            //Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
                            EditIRPIR(strResult.RFID, Currentstatus, 0);
                            $("#txtAItemHeadE").css('height', '50px').css('width', '220px');
                            //End of Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
                            alertify.success('<%=MyBase.GetResourceString("A_IRUpdated")%>');  //Vishal 26/12
                        }

                        //Commenterd And Added by Vishal on 02/01/2023 to solve refresh issue
                        //var ProjectID = $("#cboProject").val();
                        //GetIRPIRList(ProjectID);
                        MyFilters(ProjectID);
                        //End of Commenterd And Added by Vishal on 02/01/2023 to solve refresh issue
                        if (strResult != undefined) {
                            var m_intChecklistInstanceID = strResult.m_intChecklistInstanceID;
                            var m_intChecklistID = strResult.m_intChecklistID;
                            var m_RFID = strResult.RFID;
                        }
                        //  GetCheckListItemsDetails(m_intChecklistID, m_RFID);
                        //Added by Ajit L on 28/11/23

                        var historyData = ShowHistory();

                        if (historyData.length > 0 && historyData != undefined) {
                            $("#ShowHisEditblIRBtn").show();
                        }
                        else {
                            $("#ShowHisEditblIRBtn").hide();
                        }
                    }
                }

        }

        function convert(str) {
            var date = new Date(str);
            var currentMonthIndex = date.getMonth(); // Returns a zero-based index
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

            var currentMonthName = months[currentMonthIndex];

            // mnth = ("0" + (date.getMonth() + 1)).slice(-2),
            day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), currentMonthName, day].join(" "); txt
        }

        function convertIDate(str) {
            var date = new Date(str);
            var currentMonthIndex = date.getMonth(); // Returns a zero-based index
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

            var currentMonthName = months[currentMonthIndex];

            // mnth = ("0" + (date.getMonth() + 1)).slice(-2),
            day = ("0" + date.getDate()).slice(-2);
            return [day, currentMonthName, date.getFullYear()].join(" "); txt
        }

        var SalesPersonIDs = "";
        var SalesPersonNames = "";
        function GetSalesPerson(IRPIRid) {
            //Added by Vishal mane on 19/12/23 to solve issue og "In Edit Mode Sales Person Name Showing 2 Times"
            SalesPersonIDs = "";
            SalesPersonNames = "";
            //End of Added by Vishal mane on 19/12/23 to solve issue og "In Edit Mode Sales Person Name Showing 2 Times"
            var Parameters = {
                RFID: IRPIRid
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetSalesPerson", param, false);

            for (var i = 0; i < strResult.length; i++) {
                var salesPerson = strResult[i];
                SalesPersonIDs += salesPerson.SalesPersonID;
                SalesPersonNames += salesPerson.SalesPersonName;

                // Add a comma if it's not the last element
                if (i < strResult.length - 1) {
                    SalesPersonIDs += ', ';
                    SalesPersonNames += ', ';
                }
            }



        }

        var G_ContractType = "";
        var G_ProjectType = "";
        var G_ProjectName = "";
        var G_ProjectOrProduct = "";
        function GetProjectDetails() {
         
            //Added & Commented by Ajit L on 08/01/2024  
            //var ProjectID = $("#cboProject").val();
            if (PRJID != undefined && PRJID != null && PRJID != 0) {
                var ProjectID = PRJID;
            } else {
                var ProjectID = $("#cboProject").val();
            }
                //Added & Commented by Ajit L on 08/01/2024
           
            var Parameters = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetProjectDetails", param, false);
            G_ContractType = strResult[0].ContractType;
            G_ProjectType = strResult[0].ProjectType;
            G_ProjectName = strResult[0].ProjectName;
            G_ProjectOrProduct = strResult[0].ProjectOrProduct;
            // return G_ProjectType;

        }

        var GFlag = 0;
        var G_RFIID = 0;
        var BillingCurrencyCode = "";
        var BillingToBaseConversionRate = "";
        var LocalToBaseConversionRate = "";
        var CompanyBaseCurrencyConversionRate = "";
        var CompanyBaseCurrencyCode = "";
        var BaseCurrencyAmount = "";
        var CompanyBaseCurrencyAmount = "";
        var BillingCurrencySymbol = "";
        var EditProjectId = "";
        var EditProjectName = "";
        var G_CurrentStatus = "";
        function EditIRPIR(IRPIRid, CurrentStatus, EditCopyFlag) {
           // debugger;
            ClearAll();
            $("#txthdnIRID").val(IRPIRid);
            $("#ShowHideEditDiv").removeClass("ShowHideDiv");
            $("#NotAuthDiv").hide();
            $("#saveEditblIRBtn").show();
            $("#submitIREditblBtn").show();
            $("#ResubmitIREditblBtn").hide();
            $("#projMS_EditblIRBtn").show();
            $("#projDlvrbl_EditblIRBtn").show();
            $("#projExpsEditblIRBtn").show();
            $("#ProjectTS_EditblBtn").show();
            $("#ViewChecklistEditIRBtn").show();
            $("#txtSalesPersonE").val('');
            $("#txthdnSalesPerE").val('');
            //added By Riddhesh Patil on 17 Jan 2024
            RFIItemAdvisedIDs = [];
            //End of added By Riddhesh Patil on 17 Jan 2024
            //Added by Ajit L for hiding Add New and Delete buttons when status is closed start
            //if(CurrentStatus == 'Closed' || CurrentStatus == 'closed')
            //{
            //    $("#AddNewIRItem").hide();
            //    $("#DeleteIRItemBtn").hide();
            //}
            //if (CurrentStatus == 'Cancelled' || CurrentStatus == 'cancelled') {
            //    $("#AddNewIRItem").hide();
            //    $("#DeleteIRItemBtn").hide();
            //}
            //if (CurrentStatus == 'Draft' || CurrentStatus == 'draft') {
            //    $("#AddNewIRItem").show();
            //    $("#DeleteIRItemBtn").show();
            //}
            //Added by Ajit L for hiding Add New and Delete buttons when status is closed start
            
            //Added & Commented by Ajit L on 08/01/2024            
            if (PRJID != undefined && PRJID != null && PRJID != 0) {
                var ProjectID = PRJID;
            } else {
                var ProjectID = $("#cboProject").val();
            }
                //Added & Commented by Ajit L on 08/01/2024



            var strResultIRPIRid;
            Cust_Flag = 1;
            if (EditCopyFlag == 1) {
                //Added by Vishal on 20/11/2023 To copy RFI (IR/PIR) abd update the RFI status
                var UserName = '<%= Session("strUserName") %>';
              //var ProjectID = $("#cboProject").val();
                ProjectID = ProjectID; //Added byAjit L on 08/01/2024

                 var SubmitIRComments = '-';
                 var CopyParameters = {
                     RFID: IRPIRid,
                     CreatedBy: encodeURI(UserName),
                 }
                 var param = JSON.stringify(CopyParameters);
                 strResultIRPIRid = AJAXCallWithResult("/api/RFI_IR_PIR/CopyRFI", param, false);

                 if (strResultIRPIRid != "" || strResult != null) {
                     var CopyStatus = "Draft"
                     var ChangeRFIStatusParam = {
                         RFID: strResultIRPIRid,
                         ProjectID: ProjectID,
                         Status: encodeURI(CopyStatus),
                         SubmitIRComments: encodeURI(SubmitIRComments),
                         CreatedBy: encodeURI(UserName),
                     }
                     var param = JSON.stringify(ChangeRFIStatusParam);
                     var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/UpdateRFIStatus", param, false);
                 }
                 //End of Added by Vishal on 20/11/2023 To copy RFI (IR/PIR) abd update the RFI status

             }
             $("#txtEditCopyFlag").val(EditCopyFlag);
             ClearAllCopyIR();
             //G_RFIID = IRPIRid;
            GFlag = 1;
            GetProjectDetails();
            if (G_ProjectOrProduct == "Product") {
                $("#cboCustomerE").removeClass("disabled").removeAttr("disabled");
            } else {
                $("#cboCustomerE").addClass("disabled").attr("disabled", true);
            }
            GetRfiTypes(1);
            GetRfiCustomer(1);
            GetCurrencySymbol(1);
            GetRFIContactPerson(1);
            GetCurrencyCodes();
            if (EditCopyFlag == 0 && (CurrentStatus == "Closed" || CurrentStatus == "Submitted" || CurrentStatus == "Re-Submitted" || CurrentStatus == "Cancelled" || CurrentStatus == "Approved")) {
                //alert(1);
                $("#saveEditblIRBtn").hide();
                 $("#submitIREditblBtn").hide();
                 $("#ResubmitIREditblBtn").hide();
                 $("#projMS_EditblIRBtn").hide();
                 $("#projDlvrbl_EditblIRBtn").hide();
                 $("#projExpsEditblIRBtn").hide();
                 $("#ProjectTS_EditblBtn").hide();
                $("#ShowHisEditblIRBtn").hide();
                //Added by Vishal mane on 18/12/23 to hide Add New and delete button of invoice Items 
                $("#AddNewIRItem").hide();
                $("#DeleteIRItemBtn").hide();
				//End of Added by Vishal mane on 18/12/23 to hide Add New and delete button of invoice Items 
                //Coomented by Ajit L to show Checklist  when CurrentStatus is Cancelled issue -36535
                 //if (CurrentStatus == "Cancelled") {
                 //    $("#ViewChecklistEditIRBtn").hide();
                 //} else {
                 //    $("#ViewChecklistEditIRBtn").show();
                 //}

             }
            else if (EditCopyFlag == 0 && CurrentStatus == "Rejected") {
               // alert(2);
                 $("#ResubmitIREditblBtn").show();
                $("#submitIREditblBtn").hide();
                //Added by Vishal mane on 18/12/23 to hide Add New and delete button of invoice Items 
                $("#AddNewIRItem").show();
                $("#DeleteIRItemBtn").show();
                //End of Added by Vishal mane on 18/12/23 to hide Add New and delete button of invoice Items
             }
             else {
                $("#ViewChecklistEditIRBtn").hide();
                //Added by Vishal mane on 18/12/23 to hide Add New and delete button of invoice Items 
                $("#AddNewIRItem").show();
                $("#DeleteIRItemBtn").show();
                //End of Added by Vishal mane on 18/12/23 to hide Add New and delete button of invoice Items
             }
             if (G_ContractType == "2" || G_ContractType == "6" || G_ContractType == "3" || G_ContractType == "4" || G_ContractType == "7") {
              
                 if (CurrentStatus == "Closed" || CurrentStatus == "Submitted" || CurrentStatus == "Re-Submitted" || CurrentStatus == "Cancelled" || CurrentStatus == "Approved") {
                     $("#projMS_EditblIRBtn").hide();
                     $("#projDlvrbl_EditblIRBtn").hide();
                     $("#ProjectTS_EditblBtn").hide();
                 }
                 else {
                     $("#projMS_EditblIRBtn").hide();
                     $("#projDlvrbl_EditblIRBtn").hide();
                     $("#ProjectTS_EditblBtn").show();
                 }

             }
             else if (G_ContractType == "1") {
                 if (CurrentStatus == "Closed" || CurrentStatus == "Submitted" || CurrentStatus == "Re-Submitted" || CurrentStatus == "Cancelled" || CurrentStatus == "Approved") {
                     $("#ProjectTS_EditblBtn").hide();
                     $("#projMS_EditblIRBtn").hide();
                     $("#projDlvrbl_EditblIRBtn").hide();
                 } else {
                     $("#ProjectTS_EditblBtn").hide();
                     $("#projMS_EditblIRBtn").show();
                     $("#projDlvrbl_EditblIRBtn").show();
                 }

             }

             //Added by Vishal on 20/11/2023 To copy RFI (IR/PIR) abd update the RFI status
             var Parameters;
             if (EditCopyFlag == 1) {
                 G_RFIID = strResultIRPIRid;
                 GetSalesPerson(strResultIRPIRid);
                 Parameters = {
                     RFID: strResultIRPIRid
                 }
             } else {
                 G_RFIID = IRPIRid;
                 GetSalesPerson(IRPIRid);
                 Parameters = {
                     RFID: IRPIRid
                 }
             }
         
           
             //End of Added by Vishal on 20/11/2023 To copy RFI (IR/PIR) abd update the RFI status
             var param = JSON.stringify(Parameters);
             var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetIrDetails", param, false);
            if (strResult.length > 0) {
                BillingCurrencyCode = strResult[0].BillingCurrencyCode;
                BillingCurrencySymbol = strResult[0].BillingCurrencySymbol;
                BillingToBaseConversionRate = strResult[0].BillingToBaseConversionRate;
                LocalToBaseConversionRate = strResult[0].LocalToBaseConversionRate;
                //Added & commented by Ajit L on for rounding to 2 digit on 14/12/2023 start
                CompanyBaseCurrencyConversionRate = strResult[0].CompanyBaseCurrencyConversionRate;
                //CompanyBaseCurrencyConversionRate = strResult[0].BaseConversionRate;
                //Added & commented by Ajit L on for rounding to 2 digit on 14/12/2023 end
                CompanyBaseCurrencyCode = strResult[0].CompanyBaseCurrencyCode;
                BaseCurrencyAmount = strResult[0].BaseCurrencyAmount;
                CompanyBaseCurrencyAmount = strResult[0].CompanyBaseCurrencyAmount;
                AddressID = strResult[0].CustomerAddressID;
                ProjectName = strResult[0].ProjectName;
                EditProjectId = strResult[0].ProjectID;
                EditProjectName = ProjectName;
                
                billingcurencyId = strResult[0].BillingCurrencyID;//Added by Riddhesh on 05/01
                //Added by Vishal on 20/11/2023 To copy RFI (IR/PIR) abd update the RFI status
                $("#EdtbleIR_ID_Status").text(CurrentStatus);
                $("#lblProjectName").text(ProjectName);
                $("#txtProjectID").val(strResult[0].ProjectID);
                if (EditCopyFlag == 1) {
                    $("#txtEdtbleIR_ID_Filter").val(strResultIRPIRid);
                } else {
                    $("#txtEdtbleIR_ID_Filter").val(IRPIRid);
                }
                if (strResult[0].IsProforma == false) {
                    $("#IR_AddE").prop("checked", true);
                } else {
                    $("#PIR_AddE").prop("checked", true);
                }
                //End of Added by Vishal on 20/11/2023 To copy RFI (IR/PIR) abd update the RFI status
                $("#cboRFITypeE").val(strResult[0].RFITypeID);
                $("#cboCustomerE").val(strResult[0].CustomerID);
                $("#cboContactPerE").val(strResult[0].CustomerContactID);
                $("#cboCust_Address").val(AddressID);
                $("#cboCust_Address").trigger("change");
                $(".selectpicker").selectpicker('refresh');
                //var CustomerAddressID = $("#cboCust_Address").val();
                // var BillingCurrencyID = GCurrencyID
                $("#txtCreditDaysE").val(strResult[0].CreditDays);

                $("#txtEmail_ConfirmE").val(strResult[0].ConfirmEmailID);
                $("#txtContractE").val(strResult[0].InvoiceingMilestones);
                $("#toDateFilterE").val(convertIDate(strResult[0].RFIRaisedOn));
                $("#TexthiddenContractE").val(strResult[0].ContractID);
                $("#TexthiddenContractEID").val(strResult[0].ContractID);
                $("#txtSalesPeriodE").val(strResult[0].SalesPeriod);
                $("#txthdnSalesPeriodE").val(strResult[0].SalesPeriodID);
                $("#txtSalesPersonE").val(SalesPersonNames);
                $("#txthdnSalesPerE").val(SalesPersonIDs);

                // $("#toDateFilter").val();

                $("#txtAItemHeadE").val(decodeURIComponent(strResult[0].RFIHeader));
            }
            G_CurrentStatus = CurrentStatus;
             //Added by Vishal on 20/11/2023 To copy RFI (IR/PIR) abd update the RFI status
            if (EditCopyFlag == 1) {
               // alert(4);
                 //GetRFIItemsDetail(strResultIRPIRid);
                GetRFIItemsDetail(strResultIRPIRid, EditCopyFlag);
                 MyFilters(ProjectID);
             }
             else if (EditCopyFlag == 0 && (CurrentStatus == "Closed" || CurrentStatus == "Submitted" || CurrentStatus == "Re-Submitted" || CurrentStatus == "Cancelled" || CurrentStatus == "Approved")) {
               // alert(5);
                 GetRFIItemsDetail(IRPIRid);
                 //$("#submitIREditblBtn").hide();
                 $("#ResubmitIREditblBtn").hide();
                 //Added By Ajit L. on 28 dec 2023 for Issue Id=36537,36535
                 $("#submitIREditblBtn").hide();
                 $("#projMS_EditblIRBtn").hide();
                 $("#projDlvrbl_EditblIRBtn").hide();
                 $("#ProjectTS_EditblBtn").hide(); //Added by Vishal on 28/12/2023 to hide Project Timesheet issue id 36538
                 //End of Added By Ajit L. on 28 dec 2023 for Issue Id=36537,36535
             }
             else if (EditCopyFlag == 0 && CurrentStatus == "Rejected") {
                //alert(6);
                 GetRFIItemsDetail(IRPIRid);
                 $("#ResubmitIREditblBtn").show();
                 $("#submitIREditblBtn").hide();
             }
            else {
              //  alert(7);
                     var IRItemdetails = GetRFIItemsDetail(IRPIRid);
                     if (IRItemdetails.length > 0) {
                        // $("#ShowHisEditblIRBtn").show();
                         $("#ResubmitIREditblBtn").hide();
                     }
                     else {
                       // $("#ShowHisEditblIRBtn").hide();
                         $("#ResubmitIREditblBtn").hide();
                     }
                  }
            //Added Showhistory function at the end of edit mode fun as it should get EditProjectID by Ajit L on 15/12/2023
            historyData = ShowHistory();

            if (historyData.length > 0 && historyData != undefined) {
                $("#ShowHisEditblIRBtn").show();
            }
            else {
                $("#ShowHisEditblIRBtn").hide();
            }
           
            PRJID = '';//Added by Ajit L on 08/01/2024
        }

        var CompBaseAmount = 0;
        var CorpBaseAmount = 0;

        function GetRFIDetails(IRPIRid) {

            var Parameters = {
                RFIID: IRPIRid
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIDetails", param, false);
            return Result;
        }

        //Added By Riddhesh Patil on 2 Jan 2023 for Currency Issue
        var G_IRCurrencyCode = "";
        var G_IRCurrencySymb="";
        function GetRFICurrencyDetails(IRPIRid) {

            var Parameters = {
                RFIID: IRPIRid
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetIRCurrency", param, false);
            G_IRCurrencyCode = Result[0].CurrencyCode;
                G_IRCurrencySymb = Result[0].CurrencySymbol;
            /*return Result;*/
        }
        //End of Added By Riddhesh Patil on 2 Jan 2023 for Currency Issue
        var BaseCurrencyAmount
        var RFIItemAdvisedIDs = [];
        function GetRFIItemsDetail(IRPIRid, EditCopyFlag) {
            RFIItemAdvisedIDs = [];
            $("#lblCurrencyE").text('');
            //$(".lblCurncySymb").text('');
            $('#IRPIR_EditblDetails').dataTable().fnDestroy();
            GetCurrencySymb();
            GetRFICurrencyDetails(IRPIRid);
            //$(".INRCurncy").text(BillingCurrencySymbol);
            $(".ItemCurncy").text(G_IRCurrencySymb);
            $("#lblCurrencyE").text(G_IRCurrencyCode);
            var spanElement = $("<span class='lblCurncySymb'>(" + G_IRCurrencySymb + ")</span>");
            $("#lblCurrencyE").append(spanElement);
            // $(".lblCurncySymb").text('('+G_IRCurrencySymb+')');

            var BaseCurrencySymb = GetCurrencyDetails(BaseCurrency);
            var CompanyBaseCurrencyCodeSymb = GetCurrencyDetails(CompanyBaseCurrencyCode);


            $("#EquivCurrecnyCorp").text('Equiv. ' + BaseCurrency + '(' + BaseCurrencySymb + ') Amount(Corporate Base)');
            $("#EquivCurrecnyComp").text('Equiv. ' + CompanyBaseCurrencyCode + '(' + CompanyBaseCurrencyCodeSymb + ') Amount(Company  Base)');
            //$("#lblCurrencyCorpB").text(BaseCurrency);


            //$("#lblCurrencyCorpB").text(BaseCurrency);
            //$("#lblCurrencyCompB").text(CompanyBaseCurrencyCode);
            var strHTML = "";
            var StrHTML = "";
            var PrjTypeFlag = ''; //'0' flag value removed by Ajit L on 13/12/2023
            var TotalAmountDetail = GetRFIDetails(IRPIRid);
            var Parameters = {
                RFID: IRPIRid
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIItemsDetail", param, false);
            //console.log(Result);
            if (Result.length > 0 && Result.length != null && Result != undefined) {
                for (var i = 0; i < Result.length; i++) {
                    var RFIItemID = Result[i]["RFIItemID"];
                    //End of added By Riddhesh Patil on 17 Jan 2024
                    RFIItemAdvisedIDs.push(RFIItemID);
                    //End of added By Riddhesh Patil on 17 Jan 2024
                    var ItemDescription = Result[i]["ItemDescription"];
                    var Discount = Result[i]["IsDiscountItem"];
                    //Added by Ajit L for showing Is Discount on 18/12/2023 start
                    if (Discount == 1) {
                        Discount = 'Yes'
                    } else {
                        Discount = 'No'
                    }
                    //Added by Ajit L for showing Is Discount on 18/12/2023 end
                    var Quantity = Result[i]["Quantity"];
                    var Rate = Result[i]["Rate"];
                    var Amount = Result[i]["Amount"];
                    var ProjectTimesheetID = Result[i]["ProjectTimesheetID"];
                    var DeliverableID = Result[i]["DeliverableID"];
                    var MilestoneID = Result[i]["MilestoneID"];

                    //Added and Commented by Ajit L for show Milestone, Deleverable and Timesheet buttons according to Contract Type on 13/12/2023 -Start
                    //if (ProjectTimesheetID != 0 || ProjectTimesheetID != null) {
                    //    PrjTypeFlag = 0;             
                    //}

                    //if (MilestoneID != 0 || MilestoneID != null || DeliverableID != 0 || DeliverableID != null) {
                    //    PrjTypeFlag = 1;           
                    //}

                    if (ProjectTimesheetID != 0 && ProjectTimesheetID != null) {
                        PrjTypeFlag = 0;
                    }

                    if (MilestoneID != 0 && MilestoneID != null) {
                        PrjTypeFlag = 1;
                    }
                    if (DeliverableID != 0 && DeliverableID != null) {
                        PrjTypeFlag = 2;
                    }


                    if (G_ContractType == "5" && PrjTypeFlag === 0) {
                        $("#projMS_EditblIRBtn").hide();
                        $("#projDlvrbl_EditblIRBtn").hide();
                        $("#ProjectTS_EditblBtn").show();
                    }

                    else if (G_ContractType == "5" && PrjTypeFlag == 1) {
                        $("#projMS_EditblIRBtn").show();
                        $("#projDlvrbl_EditblIRBtn").hide();
                        $("#ProjectTS_EditblBtn").hide();
                    }
                    else if (G_ContractType == "5" && PrjTypeFlag == 2) {
                        $("#projMS_EditblIRBtn").hide();
                        $("#projDlvrbl_EditblIRBtn").show();
                        $("#ProjectTS_EditblBtn").hide();
                    }
                    else if (G_ContractType == "1" && PrjTypeFlag == 1) {
                        $("#projMS_EditblIRBtn").show();
                        $("#projDlvrbl_EditblIRBtn").hide();
                        $("#ProjectTS_EditblBtn").hide();
                    }
                    else if (G_ContractType == "1" && PrjTypeFlag == 2) {
                        $("#projMS_EditblIRBtn").hide();
                        $("#projDlvrbl_EditblIRBtn").show();
                        $("#ProjectTS_EditblBtn").hide();
                    }
                    //Added and Commented by Ajit L for show Milestone, Deleverable and Timesheet buttons according to Contract Type on 13/12/2023 -End


                    var CompanyBaseCurrencyAmount = Result[i]["CompanyBaseCurrencyAmount"];
                    var CompanyReportingCurrencyAmount1 = Result[i]["BaseCurrencyAmount"];

                    strHTML += '<tr>'
                    strHTML += '<td>' + (i + 1) + '</td>'
                    /*strHTML += '<td>' + ItemDescription + '</td>'*/
                    if (G_CurrentStatus == "Closed" || G_CurrentStatus == "Submitted" || G_CurrentStatus == "Re-Submitted" || G_CurrentStatus == "Cancelled" || G_CurrentStatus == "Approved") {
                        strHTML += '<td class="col-sm-2">' + ItemDescription + '</td>'
                    }
                    else {
                        strHTML += '<td class="col-sm-2"><a href="javascript:;"  data-bs-toggle="modal" data-bs-target="#AddNewIRModal" onclick="EditIRPIRItem(' + RFIItemID + ')">' + ItemDescription + '</a></td>'
                    }
                    strHTML += '<td>' + Discount + '</td>'//Added by Ajit L to show Discount on 18/12/2023
                    strHTML += '<td>' + Quantity + '</td>'
                    strHTML += '<td>' + Rate + '</td>'
                    strHTML += '<td>' + Amount + '</td>'
                    strHTML += '<td>' + CompanyReportingCurrencyAmount1 + '</td>'
                    strHTML += '<td>' + CompanyBaseCurrencyAmount + '</td>'
                    //strHTML += '<input type="hidden" id="SalesPeriod' + SalesPeriodID + '" value="' + SalesPeriodYear + '/' + SalesPeriodMonth + '" />';
                    strHTML += '<td> <div class="custom_chckbox">  <input id="descrGridcheck' + RFIItemID + '" name="checkRFIItem" data-bs-dismiss="modal" class="chcktblRfiItem" type="checkbox" value="' + RFIItemID + '" onclick="checkuncheck();" /> <label for="descrGridcheck' + RFIItemID + '"></label>   </div></td>'

                    strHTML += '</tr>'
                }
                // $("#submitIREditblBtn").show();
                //Added by Vishal to get current status of RFIID on 18/12/23 
                var Parameters = {
                    RFID: IRPIRid
                }
                var param = JSON.stringify(Parameters);
                var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetCurrentStatus", param, false);
                if (Result == "Rejected") {
                    $("#submitIREditblBtn").hide();
                    $("#ResubmitIREditblBtn").show();
                } else {
                    $("#submitIREditblBtn").show();
                    $("#ResubmitIREditblBtn").hide();
                }
                //End of Added by Vishal to get current status of RFIID on 18/12/23
            }
            else {

                //Added by Ajit L for show Milestone, Deleverable and Timesheet buttons when no IR Items added on 13/12/2023 -Start
                if (G_ContractType == "1" && (MilestoneID === 0 || MilestoneID == undefined) && (DeliverableID === 0 || DeliverableID == undefined)) {

                    $("#projMS_EditblIRBtn").show();
                    $("#projDlvrbl_EditblIRBtn").show();
                    $("#ProjectTS_EditblBtn").hide();
                }
                if (G_ContractType == "5" && (MilestoneID === 0 || MilestoneID == undefined) && (DeliverableID === 0 || DeliverableID == undefined) && (ProjectTimesheetID === 0 || ProjectTimesheetID == undefined)) {

                    $("#projMS_EditblIRBtn").show();
                    $("#projDlvrbl_EditblIRBtn").show();
                    $("#ProjectTS_EditblBtn").show();
                }
                //Added by Ajit L for show Milestone , Deleverable and Timesheet buttons when no IR Items added on 13/12/2023 -END
                $("#submitIREditblBtn").hide();
                $("#ResubmitIREditblBtn").hide();
            }


            StrHTML += ' <tr class="lightGrey">'
            StrHTML += '<td>Total Amount</td>'
            StrHTML += '<td>&nbsp;</td>'
            StrHTML += '<td>&nbsp;</td>'
            StrHTML += '<td>&nbsp;</td>'
            StrHTML += '<td>&nbsp;</td>'
            StrHTML += '<td>' + TotalAmountDetail[0].TotalAmountINR + '</td>'
            StrHTML += '<td>' + TotalAmountDetail[0].BaseCurrencyAmount + '</td>'
            StrHTML += '<td>' + TotalAmountDetail[0].CompanyBaseCurrencyAmount + '</td>'
            StrHTML += '<td>&nbsp;</td>'
            StrHTML += '</tr>'

            $("#IRPIR_EdtDetlsTableBody").html(strHTML);
            RFIItem_table = $('#IRPIR_EditblDetails').dataTable({
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
            });

            $("#IRPIR_EdtDetlsfoot").html(StrHTML);
            /* $("#IRPIR_EdtDetlsTable").find('tfoot').html(StrHTML);*/
            //Commented by Vishal To solve Refresh issue on 02/01/2023

            //Added by Vishal to refresh IR/PIR list on 18/12/23
            //Added by Vishal to refresh IR/PIR list on 18/12/23
            //var ProjectID = $("#cboProject").val();
            //GetIRPIRList(ProjectID);
            //End of Added by Vishal to refresh IR/PIR list on 18/12/23

            //End of Commented by Vishal To solve Refresh issue on 02/01/2023

            return Result;

        }
        var RFIItem_table = "";
        $("#EdtblCheck0").change(function () {
            var allPages = RFIItem_table.fnGetNodes();
            var checked = $(this).is(":checked");
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
               
            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
            }
        });


        function checkuncheck() {
            if (RFIItem_table.$('input:checked').length == RFIItem_table.fnGetNodes().length) {
                $(".EdtblChckHead").prop("checked", true);
            } else {
                $(".EdtblChckHead").prop("checked", false);
                $(".EdtblChckHead").removeAttr("checked");
            }
        }

        function AddnewIrItem() {
            G_Saveflag = 1;
            $("#IRDiscntAddNew").prop('checked', false);
            $("#txtIRDescAddNew").val('');
            $("#txtIRQuantityAddNew").val(0);
            $("#txtIRRateAddNew").val(0);
            //Added and Commented by Ajit L for showing default 0 value on Amount Field on 18/12/2023 -Star
           // $("#txtIRAmountAddNew").val('');
            $("#txtIRAmountAddNew").val(0);
            $("#txtIRSequenceNoAddNew").val('');
            $(".CustDiv").remove('');
            $("#ShowIrItemHistoryBtn").hide();//Added by Ajit L on 14/12/2023 for hiding history button on Add New Item 
            GetRFIItemAttributes();
            GetNextOrderNumber();

        }

        // 
        function GetNextOrderNumber() {
            var RFIId = G_RFIID;
            var Parameters = {
                RFIID: RFIId
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetNextOrderNumber", param, false);
            $("#txtIRSequenceNoAddNew").val(Result);
            GetOrderNumberlist(RFIId, Result)
        }

        var OrderNums = [];
        function GetOrderNumberlist(RFIId, G_OrderNum) {

            while (OrderNums.length > 0) {
                OrderNums.pop();
            }
            //
            var Parameters = {
                RFIID: RFIId,
                OrderNum: G_OrderNum
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetOrderNumbers", param, false);
            for (var i = 0; i < Result.length; i++) {
                OrderNums.push(Result[i].OrderNumber);
            }

            //console.log(OrderNums);
            //$("#txtIRSequenceNoAddNew").val(Result);
        }

        var CustField = [];
        function GetRFIItemAttributes() {
            $(".CustDiv").remove();
            var StrHTML = "";
            var RFITypeId = $("#cboRFITypeE").val();
            var Parameters = {
                RFITypeID: RFITypeId
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIItemAttributes", param, false);

            for (var i = 0; i < Result.length; i++) {
                var CustControl = Result[i];
                if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "ItemDescription") {
                    if (CustControl.IsMandatory == true) {
                        $("#lblDesc").addClass('required');
                    }
                }
                else if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "Quantity") {
                    if (CustControl.IsMandatory == true) {
                        $("#lblQuantity").addClass('required');
                    }
                }
                else if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "Rate") {
                    if (CustControl.IsMandatory == true) {
                        $("#lblRate").addClass('required');
                    }
                }
                else if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "Amount") {
                    if (CustControl.IsMandatory == true) {
                        $("#lblAmount").addClass('required');
                    }
                }

                if (CustControl.ControlTypeID == 3 && CustControl.FieldName == "IsDiscountItem") {
                    if (CustControl.IsMandatory == true) {
                        $("#lblDiscount").addClass('required');
                    }
                }

            }
            for (var i = 0; i < Result.length; i++) {
                var CustControl = Result[i];
                /* StrHTML += '<div id="CustDiv">'*/

                switch (CustControl.FieldName) {
                    case "CustomField1":
                        CustField.push('txt' + CustControl.FieldName);
                        if (CustControl.IsMandatory == true) {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="form-group mb-3 ><div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField1" id="lblCustomField1" class="required">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField1" id="txtCustomField1" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField1" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }
                        else {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="form-group mb-3 ><div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField1" id="lblCustomField1">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField1" id="txtCustomField1" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField1" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }
                        StrHTML += '</div></div></div></div></div></div>';

                        break;


                    case "CustomField2":
                        CustField.push('txt' + CustControl.FieldName);
                        if (CustControl.IsMandatory == true) {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="form-group mb-3 ><div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField2" id="lblCustomField2" class="required">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField2" id="txtCustomField2" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField2" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }
                        else {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="form-group mb-3 ><div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField2" id="lblCustomField2">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField2" id="txtCustomField2" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField2" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }

                        StrHTML += '</div></div></div></div></div></div>';
                        break;



                    case "CustomField3":
                        CustField.push('txt' + CustControl.FieldName);
                        if (CustControl.IsMandatory == true) {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="form-group mb-3 ><div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField3" id="lblCustomField3" class="required">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField3" id="txtCustomField3" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField3" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }
                        else {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="form-group mb-3 ><div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField3" id="lblCustomField3">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField3" id="txtCustomField3" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField3" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }
                        StrHTML += '</div></div></div></div></div></div>';
                        break;



                    case "CustomField4":
                        CustField.push('txt' + CustControl.FieldName);
                        if (CustControl.IsMandatory == true) {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField4" id="lblCustomField4" class="required">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField4" id="txtCustomField4" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField4" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }
                        else {
                            StrHTML += '<div class="form-group mb-3 CustDiv" >'
                            StrHTML += '<div class="row" id="divRow"><div class="col-sm-6"><div class="row"><div class="col-sm-5 text-end"><label for="txtCustomField4" id="lblCustomField4">' + CustControl.UserFriendlyCaption + '</label></div><div class="col-sm-7" id="">'
                            if (CustControl.ControlTypeID != 2) {
                                StrHTML += '<input type="Textbox" name="txtCustomField4" id="txtCustomField4" class="form-control" style="text-align:Left" value="" autocomplete="Off" maxlength="200">'
                          <%--  StrHTML += '<% CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", "form-control",,,,,, ,,,,,, ,,,,, True).Replace("'", "\'") %>';--%>
                            }
                            else {
                                StrHTML += '<select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="txtCustomField4" tabindex="1"> <option></option></select>'
                            <%--StrHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", "CustControl.StoredProcedure",,, "class=""form-control""",,,, , ).Replace("'", "\'")%>';--%>
                            }
                        }
                        StrHTML += '</div></div></div></div></div></div>';
                        break;

                    default:
                        // Default case logic if strFieldName doesn't match any specific case
                        break;
                }
                StrHTML += '</div>'

            }
            $(".IRItemMasterDiv").append(StrHTML);

            //if (CompanyBaseCurrencyCode <> PrjCurrencyCode) {
            var strhtmlStdRate = "1 " + BillingCurrencyCode + "=" + CompanyBaseCurrencyConversionRate + " " + CompanyBaseCurrencyCode;
            $("#lblStdRate").text(strhtmlStdRate);

            var strhtmlAppliedRate = "1 " + BillingCurrencyCode + "=" + CompanyBaseCurrencyConversionRate + " " + CompanyBaseCurrencyCode;
            $("#lblAppliedRate").text(strhtmlAppliedRate);

            $("#lblTotalAmount").text("0" + CompanyBaseCurrencyCode);
            $("#lblAmountCurncyCode").text(CompanyBaseCurrencyCode);

            $(".INRBillCurncy").text(G_IRCurrencySymb);
            if (CorporateBaseCurrencyCode == BillingCurrencyCode) {
                $("#dvBaseAmount").hide();
            }
            else {
                $("#dvBaseAmount").show();
                $(".INRBaseCurncy").text(CorporateBaseCurrencySymbol);
                var strhtmlStdRate = "1 " + BillingCurrencyCode + "=" + BillingToBaseConversionRate + " " + CorporateBaseCurrencyCode;
                $("#lblStdRate2").text(strhtmlStdRate);

                var strhtmlAppliedRate = "1 " + BillingCurrencyCode + "=" + BillingToBaseConversionRate + " " + CorporateBaseCurrencyCode;
                $("#lblAppliedRate2").text(strhtmlAppliedRate);
            }
        }


        function ValidateRFIItemAttributes() {
            var IsValidate = true;
            var ChckVal = 0;
            var RFITypeId = $("#cboRFITypeE").val();
            var Parameters = {
                RFITypeID: RFITypeId
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIItemAttributes", param, false);
            alertify.set('notifier', 'position', 'top-right');
            for (var i = 0; i < Result.length; i++) {
                var CustControl = Result[i];
                if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "ItemDescription") {
                    if (CustControl.IsMandatory == true) {
                        if ($("#txtIRDescAddNew").val() == "") {
                            alertify.error('<%=MyBase.GetResourceString("A_DescriptionBlank")%>');
                            $("#txtIRDescAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false
                        }
                        //Added by Aditya J. on 19-11-2024
                        else {
                            if (checkSpecialCharacter($("#txtIRDescAddNew").val().trim(), WebConfigSpecialCharacters) == true) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + 'special characters');
                                $("#txtIRDescAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false;
                            }
                        }
                        //End of Added by Aditya J. on 19-11-2024

                    }
                }
                else if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "Quantity") {
                    if (CustControl.IsMandatory == true) {
                        if ($("#txtIRQuantityAddNew").val() == "") {
                            alertify.error('<%=MyBase.GetResourceString("A_QuantityBlank")%>');
                            $("#txtIRQuantityAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false
                        }
                        else {
                            if (checkSpecialCharacter($("#txtIRQuantityAddNew").val().trim(), WebConfigSpecialCharacters) == true) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('<%=MyBase.GetResourceString("A_QuantitySpclChar")%> ' + WebConfigSpecialCharacters + ' characters');
                                $("#txtIRQuantityAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false;
                            }
                            else if ($("#txtIRQuantityAddNew").val() == 0) {
                                alertify.error('<%=MyBase.GetResourceString("A_QuantityNum")%>');
                                $("#txtIRQuantityAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false
                            }
                        }
                    }
                    else {
                        if ($("#txtIRQuantityAddNew").val() != "") {
                            if (checkSpecialCharacter($("#txtIRQuantityAddNew").val().trim(), WebConfigSpecialCharacters) == true) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('<%=MyBase.GetResourceString("A_QuantitySpclChar")%> ' + WebConfigSpecialCharacters + ' characters');
                                $("#txtIRQuantityAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false;
                            }
                            else if ($("#txtIRQuantityAddNew").val() == 0) {
                                alertify.error('<%=MyBase.GetResourceString("A_QuantityNum")%>');
                                $("#txtIRQuantityAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false
                            }
                        }

                        //Added by Vishal Mane on 21/12/2023 to solve crash due to blank value of Quantity
                        else if ($("#txtIRQuantityAddNew").val() == "") {
                            alertify.error('Please enter a positive numeric value greater than 0.');
                            $("#txtIRQuantityAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false                            
                        }
                        //End of Added by Vishal Mane on 21/12/2023 to solve crash due to blank value of Quantity
                    }
                }
                else if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "Rate") {
                    if (CustControl.IsMandatory == true) {
                        if ($("#txtIRRateAddNew").val() == "") {
                            alertify.error('<%=MyBase.GetResourceString("A_RateBlank")%>');
                            $("#txtIRRateAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false
                        }
                        else if (checkSpecialCharacter($("#txtIRRateAddNew").val().trim(), WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('<%=MyBase.GetResourceString("A_RateSpclChar")%>  ' + WebConfigSpecialCharacters + ' characters');
                            $("#txtIRRateAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false;
                        }
                        else if ($("#txtIRRateAddNew").val() == 0) {
                            alertify.error('<%=MyBase.GetResourceString("A_RateNum")%> ');
                            $("#txtIRRateAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false
                        }
                    }
                    else {
                        if ($("#txtIRRateAddNew").val() != "") {
                            if (checkSpecialCharacter($("#txtIRRateAddNew").val().trim(), WebConfigSpecialCharacters) == true) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('<%=MyBase.GetResourceString("A_RateSpclChar")%>  ' + WebConfigSpecialCharacters + ' characters');
                                $("#txtIRRateAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false;
                            }
                            if ($("#txtIRRateAddNew").val() == 0) {
                                alertify.error('<%=MyBase.GetResourceString("A_RateNum")%> ');
                                $("#txtIRRateAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false
                            }
                        }
                    }
                }
                else if (CustControl.ControlTypeID == 1 && CustControl.FieldName == "Amount") {
                    if (CustControl.IsMandatory == true) {
                        if ($("#txtIRAmountAddNew").val() == "") {
                            alertify.error('<%=MyBase.GetResourceString("A_AmountBlank")%>');
                            $("#txtIRAmountAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false
                        }
                        else if (checkSpecialCharacter($("#txtIRAmountAddNew").val().trim(), WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('<%=MyBase.GetResourceString("A_AmountSpclChar")%>  ' + WebConfigSpecialCharacters + ' characters');
                            $("#txtIRAmountAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false;
                        }
                        else if ($("#txtIRAmountAddNew").val() == 0) {
                            alertify.error('<%=MyBase.GetResourceString("A_AmountNum")%> ');
                            $("#txtIRAmountAddNew").focus();
                            IsValidate = false;
                            ChckVal = 1;
                            return false
                        }
                    }
                    else {

                        if ($("#txtIRAmountAddNew").val() != "") {
                            if (checkSpecialCharacter($("#txtIRAmountAddNew").val().trim(), WebConfigSpecialCharacters) == true) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('<%=MyBase.GetResourceString("A_AmountSpclChar")%>  ' + WebConfigSpecialCharacters + ' characters');
                                $("#txtIRAmountAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false;
                            }
                            if ($("#txtIRAmountAddNew").val() == 0) {
                                alertify.error('<%=MyBase.GetResourceString("A_AmountNum")%> ');
                                $("#txtIRAmountAddNew").focus();
                                IsValidate = false;
                                ChckVal = 1;
                                return false
                            }
                        }
                    }
                }


            }

            //if ($("#IRDiscntAddNew").prop('checked') == true) {
            //    if ($("#txtIRRateAddNew").val() > 0) {
            //        alertify.error('Please enter a negative numeric value for Rate.');
            //        $("#txtIRRateAddNew").focus();
            //        IsValidate = false;
            //        ChckVal = 1;
            //        return false
            //    }
            //}
            
            if ($("#txtIRSequenceNoAddNew").val() == "") {
                alertify.error('<%=MyBase.GetResourceString("A_SequenceNumBlank")%>');
                $("#txtIRSequenceNoAddNew").focus();
                IsValidate = false;
                ChckVal = 1;
                return false
            }
            else {
                for (var i = 0; i < OrderNums.length; i++) {
                    if ($("#txtIRSequenceNoAddNew").val() == OrderNums[i]) {
                        alertify.error('<%=MyBase.GetResourceString("A_Seq_Num_Exists")%>');
                        $("#txtIRSequenceNoAddNew").focus();
                        IsValidate = false;
                        ChckVal = 1;
                        return false
                    }
                    // OrderNums.push(Result[i].OrderNumber);
                }
            }

            if (ChckVal == 0) {
                IsValidate = true;
            }
            return IsValidate;
        }

        var G_RFIItemId = 0;
        function EditIRPIRItem(RFIItemId) {
            $('#divNoitems').remove();
            $('#currAmtTab').show();
            //
            GetRFIItemAttributes();
            G_RFIItemId = RFIItemId;
            G_Saveflag = 0;
            var Parameters = {
                RFIItemID: RFIItemId
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIItemsDetail", param, false);
            // 
            //BillingToBaseConversionRate
            // //console.log(Result);
            for (var i = 0; i < Result.length; i++) {
                var RFIItemDetails = Result[i];
                if (RFIItemDetails.IsDiscountItem == null || RFIItemDetails.IsDiscountItem == 0) {
                    $("#IRDiscntAddNew").prop('checked', false);
                }
                else {
                    $("#IRDiscntAddNew").prop('checked', true);
                }
                $("#txtIRDescAddNew").val(RFIItemDetails.ItemDescription);
                $("#txtIRQuantityAddNew").val(RFIItemDetails.Quantity);
                $("#txtIRRateAddNew").val(RFIItemDetails.Rate.replace(/,/g, ''));
                $("#txtIRAmountAddNew").val(RFIItemDetails.Amount.replace(/,/g, ''));
                $("#txtIRSequenceNoAddNew").val(RFIItemDetails.OrderNumber);
                $("#txtBaseCurrencyAmount").val(RFIItemDetails.BaseCurrencyAmount.replace(/,/g, ''));
                BaseCurrencyAmount = RFIItemDetails.BaseCurrencyAmount;
                CompanyBaseCurrencyAmount = RFIItemDetails.CompanyBaseCurrencyAmount
                BillingToBaseConversionRate = RFIItemDetails.BillingToBaseConversionRate
                  //  BillingCurrencyCode = RFIItemDetails.BillingCurrencyCode

                var CustomField = CustField;
                for (var i = 0; i < CustomField.length; i++) {


                    if (CustomField[i] == "txtCustomField1") {
                        $("#txtCustomField1").val(RFIItemDetails.CustomField1);
                    }
                    if (CustomField[i] == "txtCustomField2") {
                        $("#txtCustomField2").val(RFIItemDetails.CustomField2);
                    }
                    if (CustomField[i] == "txtCustomField3") {
                        $("#txtCustomField3").val(RFIItemDetails.CustomField3);
                    }
                    if (CustomField[i] == "txtCustomField4") {
                        $("#txtCustomField4").val(RFIItemDetails.CustomField4);
                    }
                }

            }
            GetOrderNumberlist(G_RFIID, $("#txtIRSequenceNoAddNew").val())

            if (CompanyBaseCurrencyCode == PrjCurrencyCode) {
                var strhtmlStdRate = "1 " + BillingCurrencyCode + "=" + CompanyBaseCurrencyConversionRate + " " + CompanyBaseCurrencyCode;
                $("#lblStdRate").text(strhtmlStdRate);

                var strhtmlAppliedRate = "1 " + BillingCurrencyCode + "=" + BillingToBaseConversionRate + " " + CompanyBaseCurrencyCode;
                $("#lblAppliedRate").text(strhtmlAppliedRate);
                $("#lblAmountCurncyCode").text(CompanyBaseCurrencyCode);
                $("#lblTotalAmount").text(CompanyBaseCurrencyAmount + " " + CompanyBaseCurrencyCode);

            } else {
                var strhtmlStdRate = "1 " + BillingCurrencyCode + "=" + CompanyBaseCurrencyConversionRate + " " + CompanyBaseCurrencyCode;
                $("#lblStdRate").text(strhtmlStdRate);

                var strhtmlAppliedRate = "1 " + BillingCurrencyCode + "=" + BillingToBaseConversionRate + " " + CompanyBaseCurrencyCode;
                $("#lblAppliedRate").text(strhtmlAppliedRate);

                $("#lblAmountCurncyCode").text(CompanyBaseCurrencyCode);
                $("#lblTotalAmount").text(CompanyBaseCurrencyAmount + " " + CompanyBaseCurrencyCode);
            }
            //Added by Ajit L on 28/11/2023
           
            var historyItemData = ShowItemHistory();

            if (historyItemData.length > 0 && historyItemData != undefined) {
                $("#ShowIrItemHistoryBtn").show();
            }
            else {
                $("#ShowIrItemHistoryBtn").hide();
            }
         
        }


        //var arrRFIChecklistItemID = [];
        //var arrRFIChecklistComments = [];
        //var arrRFIChecklistResponse = [];
        //var GChecklistID = "";
        //var GRFID = "";
        //function GetCheckListItemsDetails(ChecklistID, RFID) {
        //    GChecklistID = ChecklistID;
        //    GRFID = RFID;
        //    var Parameters = {
        //        ProjectID: encodeURI(ProjectID),
        //        RFID: encodeURI(RFID),
        //        ChecklistID: encodeURI(ChecklistID)

        //    }
        //    var param = JSON.stringify(Parameters);
        //    var checklistIR = "";
        //    var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetCheckListItemsDetails", param, false);
        //    if (strResult != "") {
        //        for (var i = 0; i < strResult.length; i++) {
        //            var Comments = strResult[i].Comments
        //            if (Comments == null) {
        //                Comments = "";
        //            } else {
        //                Comments = strResult[i].Comments;
        //            }
        //            arrRFIChecklistItemID.push(strResult[i].RFIChecklistItemID);
        //            checklistIR += '<tr>';
        //            checklistIR += '<td>' + strResult[i].RFIChecklistItemID + '</td>';
        //            checklistIR += '<td>' + strResult[i].RFIChecklistItem + '</td>';
        //            checklistIR += '<td>';
        //            checklistIR += '<div class="custom_chckbox">';
        //            checklistIR += '<input type="checkbox" id="submitYes_' + strResult[i].RFIChecklistItemID + '" class="chcktbl">';
        //            checklistIR += '<label for="submitYes_' + strResult[i].RFIChecklistItemID + '"></label>';
        //            checklistIR += '</div>';
        //            checklistIR += '</td>';
        //            checklistIR += '<td><textarea class="form-control submitComments" id="checklistDes_' + strResult[i].RFIChecklistItemID + '">' + Comments + ' </textarea></td>';
        //            checklistIR += '</tr>';
        //        }

        //    }
        //    $("#TbodySubmiteIR").html(checklistIR);
        //}


        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            
            //StartLoader("#ResReall_mainbody");
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                    ajaxResult = data;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //StopAjaxLoader("#ResReall_mainbody");
            return ajaxResult;
        }
        /*
        Created By : Vishal Mane
        Created Date : 03/11/2023
        Purpose : for Loader Start
        */
        function StartLoader(bodyID) {
            var progress2 = new LoadingOverlayProgress({
                bar: {
                    "background": "#ddd",
                    "top": "50px",
                    "height": "30px",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
                },
            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }

        /*
        Created By : Vishal Mane
        Created Date : 03/11/2023
        Purpose : for Loader Stop
        */
        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {
            });
        }




        //For Validate EmailID
        function ValidateEmailID(strEmailList) {
            var strEmailArray;
            var intCtr

            if (strEmailList == "") {
                return false;
            }

            objRegularExp = new RegExp("[\\,,\\ ,\\;]")
            strEmailArray = strEmailList.split(objRegularExp);

            if (strEmailArray.length == 0)
                return false;

            for (intCtr = 0; intCtr < strEmailArray.length; intCtr++) {
                if (isEmail(strEmailArray[intCtr]) == false) {
                    //alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
                    return false;
                }
            }
            return true;
        }

        //For Validate EmailID
        function isEmail(str) {
            var supported = 0;
            if (window.RegExp) {
                var tempStr = "a";
                var tempReg = new RegExp(tempStr);
                if (tempReg.test(tempStr)) supported = 1;
            }

            if (!supported)
                return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);

            var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
            var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");

            return (!r1.test(str) && r2.test(str));

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


        var PrjCurrencyCode = "";
        var PrjCurrencySymbol = "";
        function GetCurrencySymb() {
            var openBracket = document.createTextNode("(");
            var closeBracket = document.createTextNode(")");
            var ProjectID = $("#cboProject").val();
            var Projectid = ProjectID  // $("#cboProject").val();
            var RequestParameters = {
                ProjectID: Projectid
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIProjectCurrency", param, false);

            PrjCurrencyCode = Result[0].CurrencyCode;
            PrjCurrencySymbol = Result[0].CurrencySymbol;
            return Result[0].CurrencyCode;
        }


        function GetCurrencyDetails(CurrencyCode) {

            var RequestParameters = {
                CurrencyCode: CurrencyCode
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetCurrencyDetails", param, false);
            return Result[0].CurrencySymbol;
        }


        /*
    Created By : Ajit L
    Created Date : 03/11/2023
    Purpose : To Show Milestone Popup
    */

        var mileStones = '';
        function ShowMileStones() {
            
            $("#milestoneInput").val('');
            $("#txtProject").text(EditProjectName);
            var CurSymb = GetCurrencySymb();
            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            $('#MilestoneTable').dataTable().fnDestroy();
            var strHTML = "";
            var ProjectId = ProjectID;
            var RFIID = G_RFIID;
            var RequestParameters = {
                ProjectID: ProjectId,
                RFIID: RFIID
            }
            var param = JSON.stringify(RequestParameters);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetMileStones", param, false);

            if (ajaxResult != null) {
                mileStones = ajaxResult;
                $.each(mileStones, function (index, obj) {

                    strHTML += '<tr>' +
                        '<td class="text-centre">' + obj.MileStone + '</td>' +
                        '<td class="text-centre">' + obj.StartDate + '</td>' +
                        '<td class="text-centre">' + obj.EndDate + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BillingAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.UsedAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BalanceAmount + '</td>';                   
                    strHTML += '<td><input type="checkbox" class="chcktblMl" id= ' + obj.MileStoneID + '> </td>';
                    strHTML += '</tr>';

                });
               // $('#MilestoneTable').dataTable().fnDestroy();
                $("#tbodyMileStone").html(strHTML);

            } else {
               // $('#MilestoneTable').dataTable().fnDestroy();
               // $("#tbodyMileStone").html(strHTML);
                $("#tbodyMileStone").prop("colspan", 7);
            }
            $('#MilestoneTable').dataTable({
                // "scrollY": true,
               // "scrollX": true,//04/01
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                //Added by Ajit L on 05/01/2023
                "columns": [
                    { "width": "150px" }, 
                    { "width": "150px" },
                    { "width": "150px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },
                   
                ],
                "autoWidth": false

            });

            $(".selectpicker").selectpicker('refresh');

        }


        /*
     Created By : Ajit L
     Created Date : 23/11/2023
     Purpose :To Valdate Milestones
     */
        var selectedMileIds = [];
        function ValidateMileStones() {
            selectedMileIds = [];
            //$(".chcktblMl:checked").each(function () {              
            //    selectedMileIds.push($(this).attr("id"));         
            //});

            var table = $('#MilestoneTable').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            $('.chcktblMl:checked', rows).map(function () {
                selectedMileIds.push($(this).attr("id"));
            });

            if (selectedMileIds.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_MileStoneBlank")%>');

                return false;
            }
            else {
                $("#ProjMilestoneModal").modal('hide');
                $("#IR_CreateMilestoneModal").modal('show');
            }
        }

        /*
       Created By : Ajit L
       Created Date : 03/11/2023
       Purpose : To Save Milestones
       */

        function SaveMileStones() {

            var RFIID = G_RFIID;
            var MileStoneID = selectedMileIds.toString();


            if (MileStoneID.length > 0 && MileStoneID != ' ') {

                var param = {
                    RFIID: RFIID,
                    MileStoneID: MileStoneID

                };
            }
            var param = JSON.stringify(param);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/SaveMileStones", param, false);


            var Msg = ajaxResult;

            if (Msg != '' && Msg != undefined) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_MilestoneSave")%>');
                $("#IR_CreateMilestoneModal").modal('hide');
                //   ShowMileStones();
            }

            GetRFIItemsDetail(G_RFIID);
            var ProjectID = EditProjectId;
            GetIRPIRList(ProjectID);
        }


        /*
   Created By : Ajit L
   Created Date : 06/11/2023
   Purpose : To Show Project Deliverables Popup
   */

        var deliverables = '';
        function ShowProjectDeliverables() {
            $("#txtProDel").text(EditProjectName);
            $("#delvrbleInput").val('');
            var CurSymb = GetCurrencySymb();
            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            $('#DeliverablesTable').dataTable().fnDestroy();
            var strHTML = "";
            var ProjectId = ProjectID;
            var RFIID = G_RFIID;

            var RequestParameters = {
                ProjectID: ProjectId,
                RFIID: RFIID
            }
            var param = JSON.stringify(RequestParameters);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetDeliverables", param, false);
            if (ajaxResult != null) {
                deliverables = ajaxResult;
                $.each(deliverables, function (index, obj) {
                    strHTML += '<tr>' +
                        '<td class="text-centre">' + obj.Title + '</td>' +
                        '<td class="text-centre">' + obj.StartDate + '</td>' +
                        '<td class="text-centre">' + obj.EndDate + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BillingAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BilledAmount + '</td>' +
                        '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.BalanceAmount + '</td>';

                    strHTML += '<td><input type="checkbox" class="chcktbldel" id= ' + obj.ScheduleID + '> </td>';
                    strHTML += '</tr>';
                });

                $("#tbodyDeliverable").html(strHTML);

            } else {
                $("#tbodyDeliverable").prop("colspan", 7);            
            }

            $('#DeliverablesTable').dataTable({
                // "scrollY": true,
                // "scrollX": true,
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                //Added by Ajit L on 05/01/2023
                "columns": [
                    { "width": "150px" },
                    { "width": "150px" },
                    { "width": "150px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },
                    { "width": "100px" },

                ],
                "autoWidth": false
            });
            $(".selectpicker").selectpicker('refresh');
        }


        /*
     Created By : Ajit L
     Created Date : 23/11/2023
     Purpose :To Valdate Project Deliverables
     */
        var selectedDeliverableIds = [];
        function ValidateDeliverables() {
            selectedDeliverableIds = [];
            //$(".chcktbldel:checked").each(function () {
            //    selectedDeliverableIds.push($(this).attr("id"));
            //});

            var table = $('#DeliverablesTable').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            $('.chcktbldel:checked', rows).map(function () {
                selectedDeliverableIds.push($(this).attr("id"));
            });

            if (selectedDeliverableIds.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_DeliverableBlank")%>');
                return false;
            }
            else {
                $("#ProjDeliverablesModal").modal('hide');
                $("#IR_CreateDelvrblModal").modal('show');
            }
        }


        /*
          Created By : Ajit L
          Created Date : 06/11/2023
          Purpose : To Save ProjectDeliverables
          */

        function SaveProjectDeliverables() {

            var RFIID = G_RFIID;
            var DeliverableID = selectedDeliverableIds.toString();

            if (DeliverableID.length > 0 && DeliverableID != ' ') {

                var param = {
                    RFIID: RFIID,
                    DeliverableID: DeliverableID

                };
            }
            var param = JSON.stringify(param);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/SaveProjectDeliverables", param, false);


            var Msg = ajaxResult;

            if (Msg != '' && Msg != undefined) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_DeliverableSave")%>');
                $("#IR_CreateDelvrblModal").modal('hide');

            }
            GetRFIItemsDetail(G_RFIID);
            var ProjectID = EditProjectId;
            GetIRPIRList(ProjectID);
        }



        /*
     Created By : Ajit L
     Created Date : 03/11/2023
     Purpose : To Show Project Expenses Popup
     */

        var currentCurrency = null;
        var currencywiseTotal = '';
        function ShowProjectExpense() {
            $("#txtProforExp").text(EditProjectName);
            $('#ExpensesTable').dataTable().fnDestroy();

            var intResourceID = $('#cboResources').val();
            var intCurrencyID = $('#cboCurrency').val();
            var intCostHeadID = $('#cboCostHead').val();
            var intStatusID = $('#cboStatusProExp').val();
            //var flag = '';
            //if (intStatusID == 0 || intStatusID == 1) {
            //    var flag = 0
            //}
            //else {
            //    flag = 1
            //}


            var ProjectID = EditProjectId;

            var strHTML = "";
            var strHTMLExp = "";
            var ProjectId = ProjectID;
            var RFIID = G_RFIID;


            var RequestParameters = {
                ProjectID: ProjectId,
                RFIID: RFIID,
                intCurrencyID: intCurrencyID,
                intCostHeadID: intCostHeadID,
                intResourceID: intResourceID,
                Flag: intStatusID
            }
            var param = JSON.stringify(RequestParameters);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/ShowProjectExpense", param, false);

            if (ajaxResult != null) {

                var projectExpenses = ajaxResult.ProjectExpenses || [];
                var currencyWiseTotal = ajaxResult.ProjectExpensesCurrencyWiseTotal || [];
                var currentCurrency = null;

                $.each(projectExpenses, function (index, obj) {
                    var CostHead;
                    var EmployeeName;
                    var CurrencyCode;
                    if (obj.CostHead == null || obj.CostHead == undefined) { CostHead = ""; } else { CostHead = obj.CostHead }
                    if (obj.EmployeeName == null || obj.EmployeeName == undefined) { EmployeeName = ""; } else { EmployeeName = obj.EmployeeName }
                    if (obj.CurrencyCode == null || obj.CurrencyCode == undefined) { CurrencyCode = ""; } else { CurrencyCode = obj.CurrencyCode }

                    var matchingCurrencyTotal = findCurrencyTotal(obj.CurrencyCode, currencyWiseTotal);

                    if (matchingCurrencyTotal) {

                        if (currentCurrency !== obj.CurrencyCode) {

                            if (currentCurrency !== null) {
                                var previousCurrencyTotal = findCurrencyTotal(currentCurrency, currencyWiseTotal);
                                strHTML += '<tr>' +
                                    '<td class="text-start font-weight-500" >Total Expense Amount For ' + previousCurrencyTotal.CurrencyCode + ' </td ><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>' +
                                    '<td class="font-weight-500"><span>' + previousCurrencyTotal.CurrencySymbol + '</span> ' + previousCurrencyTotal.TotalAmount + '</td>' +
                                    '  <td>&nbsp;</td>'
                                strHTML += '</tr>';
                            }


                            currentCurrency = obj.CurrencyCode;
                        }

                        strHTML += '<tr>' +
                            '<td class="text-centre">' + CostHead + '</td>' +
                            '<td class="text-centre">' + EmployeeName + '</td>' +
                            '<td class="text-centre">' + obj.Description + '</td>' +
                            '<td class="text-centre">' + obj.ExpenseYear + '</td>' +
                            '<td class="text-centre">' + obj.ExpenseMonth + '</td>' +
                            '<td class="text-centre">' + CurrencyCode + '</td>' +
                            '<td><span class="blue-text">' + obj.CurrencySymbol + '</span> ' + obj.TotalAmount + '</td>';
                        strHTML += '<td><input type="checkbox" class="chcktblExp" id= ' + obj.ExpensesEntryID + ' name =' + obj.CurrencyID + '> </td>';
                        strHTML += '</tr>';
                    }
                });

                if (currentCurrency !== null) {
                    var lastCurrencyTotal = findCurrencyTotal(currentCurrency, currencyWiseTotal);
                    strHTML += '<tr>' +
                        '<td class="text-start font-weight-500" >Total Expense Amount For ' + lastCurrencyTotal.CurrencyCode + ' </td ><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>' +
                        '<td class="font-weight-500 "><span class="blue-text">' + lastCurrencyTotal.CurrencySymbol + '</span> ' + lastCurrencyTotal.TotalAmount + '</td>' +
                        '  <td>&nbsp;</td>'
                    strHTML += '</tr>';
                }

                function findCurrencyTotal(currencyCode, currencyWiseTotal) {
                    return currencyWiseTotal.find(function (totalObj) {
                        return totalObj.CurrencyCode === currencyCode;
                    });
                }

                $("#tbodyProExpense").html(strHTML);

                for (var i = 0; i < ajaxResult.ProjectExpensesTotal.length; i++) {
                    var data = ajaxResult.ProjectExpensesTotal[i]
                    strHTMLExp += '<tr>' +
                        '<td class="text-start font-weight-500" colspan="6">Total Expense Amount In Project Currency(' + data.CurrencyCode + ')</td >' +
                        '<td class="font-weight-500"><span class="blue-text">' + data.CurrencySymbol + '</span> ' + data.BillingAmount + '</td>' +
                        '  <td>&nbsp;</td>'
                    strHTMLExp += '</tr>';

                }
              
                $("#tfootProjectExpenss").html(strHTMLExp);
            }
            else {

                $("#tbodyProExpense").prop("colspan", 5);
                $("#tbodyProExpense").html("No data available in table");
                $("#tfootProjectExpenss").prop("colspan", 5);
                $("#tfootProjectExpenss").html("No data available in table");

            }


            $('#ExpensesTable').dataTable({
                // "scrollY": true,
                // "scrollX": true,
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
            });

            $(".selectpicker").selectpicker('refresh');

        }





        function GetProExpStatusType() {           
            var strHTML = "";
            $("#cboStatusProExp").html("");         
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetProExpStatusType", '', false);
            for (var i = 0; i < strResult.length; i++) {
                var obj = strResult[i];
           
                strHTML += '<option value=' + obj.Val + ' >' + obj.Status + '</option>';
            }
            $("#cboStatusProExp").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }


        function GetCurrencyType() {

            var strHTML = "";
            $("#cboCurrency").html("");
            // var ProjectID = $("#cboProject").val();

            var ProjectID = EditProjectId;
            var RIFID = G_RFIID;
            var RequestParameters = {
                ProjectID: ProjectID,
                RFIID: G_RFIID
            }

            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetCurrencyType", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var obj = strResult[i];
                strHTML += '<option value=' + obj.CurrencyID + ' >' + obj.CurrencyCode + '</option>';
            }
            $("#cboCurrency").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }


        function GetResources() {

            var strHTML = "";
            $("#cboResources").html("");

            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            var RequestParameters = {
                ProjectID: ProjectID

            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetResources", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var obj = strResult[i];
                strHTML += '<option value=' + obj.EmployeeId + ' >' + obj.UserName + '</option>';
            }
            $("#cboResources").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }


        function GetCostHeads() {

            var strHTML = "";
            $("#cboCostHead").html("");
            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            var RFIID = G_RFIID;

            var RequestParameters = {
                ProjectID: ProjectID,
                RFIID: RFIID

            }
            var param = JSON.stringify(RequestParameters);

            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetCostHeads", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var obj = strResult[i];
                strHTML += '<option value=' + obj.CostHeadID + ' >' + obj.CostHead + '</option>';
            }
            $("#cboCostHead").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }


        /*
Created By : Ajit L
Created Date : 23/11/2023
Purpose :To Valdate Project Deliverables
*/

        var selectedExpencesIds = [];
        var selectedExpencesCurrencyIDs = [];

        function ValidateProjectExpences() {
            var RFIID = G_RFIID;
            GetGlobalCurrencies(EditProjectId);
            selectedExpencesIds = [];
            selectedExpencesCurrencyIDs = [];
            GetProjectCurrency(0);
            var table = $('#ExpensesTable').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            $('.chcktblExp:checked', rows).map(function () {
                selectedExpencesIds.push($(this).attr("id"));
                selectedExpencesCurrencyIDs.push($(this).attr("name"));
            })
            if (selectedExpencesIds.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error('<%=MyBase.GetResourceString("A_ExpenceBlank")%>');
                alertify.error('Select atleast one project expense to create invoice item');
                return false;
            }
            var ProjectID = EditProjectId;
            var chckflag = ValidateExpenseCurrency(selectedExpencesCurrencyIDs);
            /*alert(chckflag);*/
            if (chckflag == true) {
                if (selectedExpencesCurrencyIDs.length != 0) {
                    var uniqueExpencesCurrencyIDs = Array.from(new Set(selectedExpencesCurrencyIDs));
                    var selectedExpencesCurrencyIDsString = uniqueExpencesCurrencyIDs.join(",");
                    var InvoiceConversionDate = $('#toDateFilterE').val();
                    var ExpencesCurrencyIDsDetails = {
                        ExpencesCurrencyIDs: selectedExpencesCurrencyIDsString,
                        InvoiceConversionDate: InvoiceConversionDate,
                        CorpBaseCurrencyID: CorporateBaseCurrencyID,
                        ProjectID: ProjectID,
                        RFIID :RFIID
                    }
                    var param = JSON.stringify(ExpencesCurrencyIDsDetails);
                    var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpenseCurrencyIDs", param, false);
                    if (strResult != null) {
                        var isValid = 0;
                        $.each(strResult, function (index, obj) {
                            //
                            /*alert(obj.Flag);*/
                            if (obj.Flag == 0 && obj.CurrencyID != CorporateBaseCurrencyID) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('Currency Conversion rate for invoice conversion date (' + InvoiceConversionDate + ') of Expense Currency (' + obj.CurrencyCode + ') to Corporate Base Currency (' + CorporateBaseCurrencyCode + ') is not defined.Please contact Administartor!');
                                //Added by Vishal Mane on 20/12/2023
                                var indicesToRemove = selectedExpencesCurrencyIDs.reduce(function (acc, currencyId, index) {
                                    if (currencyId == obj.CurrencyID) {
                                        acc.push(index);
                                    }
                                    return acc;
                                }, []);
                                selectedExpencesIds = selectedExpencesIds.filter(function (_, index) {
                                    return !indicesToRemove.includes(index);
                                });
                                isValid = 1;

                                //End of Added by Vishal Mane on 20/12/2023                             
                                return false;
                            }
                            else if (obj.Flag == 2 && obj.CurrencyID != CompanyBaseCurrencyCode) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('Currency Conversion rate for invoice conversion date (' + InvoiceConversionDate + ') of Expense Currency (' + obj.CurrencyCode + ') to Company Base Currency (' + CompanyBaseCurrencyCode + ') is not defined.Please contact Administartor!');
                                //Added by Vishal Mane on 20/12/2023
                                var indicesToRemove = selectedExpencesCurrencyIDs.reduce(function (acc, currencyId, index) {
                                    if (currencyId == obj.CurrencyID) {
                                        acc.push(index);
                                    }
                                    return acc;
                                }, []);
                                selectedExpencesIds = selectedExpencesIds.filter(function (_, index) {
                                    return !indicesToRemove.includes(index);
                                });
                                isValid = 1;

                                //End of Added by Vishal Mane on 20/12/2023                             
                                return false;
                            }
                            else if (obj.Flag == 3 && obj.CurrencyID != billingcurencyId) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('Currency Conversion rate for invoice conversion date (' + InvoiceConversionDate + ') of Expense Currency (' + obj.CurrencyCode + ') to billing Currency (' + billingcurencyCode + ') is not defined.Please contact Administartor!');
                                //Added by Vishal Mane on 20/12/2023
                                var indicesToRemove = selectedExpencesCurrencyIDs.reduce(function (acc, currencyId, index) {
                                    if (currencyId == obj.CurrencyID) {
                                        acc.push(index);
                                    }
                                    return acc;
                                }, []);
                                selectedExpencesIds = selectedExpencesIds.filter(function (_, index) {
                                    return !indicesToRemove.includes(index);
                                });
                                isValid = 1;

                                //End of Added by Vishal Mane on 20/12/2023                             
                                return false;
                            }
                            else {
                                $("#ProjExpensesModal").modal('hide');
                                $("#IR_CreateExpensesModal").modal('show');
                            }
                        });
                        if (isValid == 1) {
                            //commented and Added By Riddhesh Patil on 29 Dec 2023
                            //$("#ProjExpensesModal").modal('hide');
                            //$("#IR_CreateExpensesModal").modal('show');
                            $("#ProjExpensesModal").modal('show');
                            $("#IR_CreateExpensesModal").modal('hide');
                            //End of commented and Added By Riddhesh Patil on 29 Dec 2023
                        }
                    }
                }
                else {
                    $("#ProjExpensesModal").modal('hide');
                    $("#IR_CreateExpensesModal").modal('show');
                }
            }
            //else {
            //    $("#IR_ValidateExpensesModal").modal('show');
            //    $("#ProjExpensesModal").modal('hide');
            //    $("#IR_CreateExpensesModal").modal('hide');
            //}
        }

        function ShowCreatePopup() {
            $("#IR_ValidateExpensesModal").modal('hide');
            $("#IR_CreateExpensesModal").modal('show');
        }



        //PrjBillingCurrencyCode, CurrencyCode

        function ValidateExpenseCurrency(selectedExpencesCurrencyIDs) {
            var uniqueValues = [];
            var ProjectID = EditProjectId;
            var Parameters = {
                ProjectID: ProjectID,
                ExpencesCurrencyIDs: selectedExpencesCurrencyIDs.toString()

            }
            var Parameter = JSON.stringify(Parameters);
          
            var chckflag = true;
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpRate", Parameter, false);
            if (Result[0].CurrencyCode != "" ) {
                chckflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(Result[0].Result)
            }
            else {
                $.each(selectedExpencesCurrencyIDs, function (index, value) {
                    if ($.inArray(value, uniqueValues) === -1) {
                        uniqueValues.push(value);
                    }
                });

                // Output the number of different values
                var numberOfDifferentValues = uniqueValues.length;
                //  console.log(numberOfDifferentValues);
                if (numberOfDifferentValues > 1) {

                 

                    var RequestParameters = {
                        ProjectID: ProjectID,
                        ExpencesCurrencyIDs: selectedExpencesCurrencyIDs.toString()

                    }
                    var param = JSON.stringify(RequestParameters);
                    var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpenseCurrencyValues", param, false);

                    $("#txtConfirm").text(strResult);
                    // $("#IR_ValidateExpensesModal").show();
                    chckflag = false;
                    $("#IR_ValidateExpensesModal").modal('show');
                    $("#ProjExpensesModal").modal('hide');
                    $("#IR_CreateExpensesModal").modal('hide');
                }
                else {
                    chckflag = true;
                }
            }
            return chckflag;
        }
        /*
         Created By : Ajit L
         Created Date : 07/11/2023
         Purpose : To Save Project Expenses
         */
        function SaveProExpences() {

            var RFIID = G_RFIID;
            var ExpensesEntryIDs = selectedExpencesIds.toString();
            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            var CreatedBy = UserName;

            if (ExpensesEntryIDs.length > 0 && ExpensesEntryIDs != ' ') {

                var param = {
                    RFIID: RFIID,
                    ExpensesEntryIDs: ExpensesEntryIDs,
                    ProjectId: ProjectID,
                    CreatedBy: CreatedBy
                };
            }
            var param = JSON.stringify(param);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/SaveProExpences", param, false);


            var Msg = ajaxResult;

            if (Msg != '' && Msg != undefined) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_ExpenceSave")%>');
                $("#IR_CreateExpensesModal").modal('hide');
            }

            EditIRPIR(RFIID, G_CurrentStatus, 0)
          //  GetRFIItemsDetail(G_RFIID);
            var ProjectID = EditProjectId;
            GetIRPIRList(ProjectID);
        }


        /*
            Created By : Ajit L
            Created Date : 08/11/2023
            Purpose : To Show History Popup
       */

        function ShowHistory() {

            $('#IRAShowHistoryTable').dataTable().fnDestroy();
            var strHTML = "";
            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            var RFIID = G_RFIID;
            var UserId = $("#cboModifiedBy").val();
            var FieldName = $("#cboModifiedField").val();

            FieldName = unescape(FieldName);

            if (UserId == 0) {
                UserId = "";
            }
            if (FieldName == 0) {
                FieldName = "";
            }
            //Field Name value changed by Ajit L on 15/12/2023 to handle placholder case Start
            if (FieldName == "Select Modified By") {
                FieldName = "";
            }
            if (FieldName == "Select Modified Field") {
                FieldName = "";
            }
            //Field Name value changed by Ajit L on 15/12/2023 to handle placholder case end
            if (FieldName == "null") {
                FieldName = "";
            }

            var RequestParameters = {
                ProjectID: ProjectID,
                RFIID: RFIID,
                UserId: UserId,
                FieldName: FieldName
            }
            var param = JSON.stringify(RequestParameters);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/ShowHistory", param, false);

            if (ajaxResult.length != 0) {

                $.each(ajaxResult, function (index, obj) {

                    strHTML += '<tr>' +
                        '<td class="text-centre">' + obj.FieldName + '</td>' +
                        '<td class="text-centre">' + obj.ModifiedDate + '</td>' +
                        '<td class="text-centre">' + decodeURI(obj.Value) + '</td>' +
                        '<td class="text-centre">' + decodeURI(obj.NewValue) + '</td>' +
                        '<td class="text-centre">' + obj.ModifiedBy + '</td>' +
                        '</tr>';

                });

                $("#tbodyShowHistory").html(strHTML);

            } 

            $('#IRAShowHistoryTable').dataTable({
                // "scrollY": true,
                // "scrollX": true,
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                //Added by Ajit L on 05/01/2023
                "columns": [
                    { "width": "175px" },
                    { "width": "175px" },
                    { "width": "175px" },
                    { "width": "175px" },
                    { "width": "100px" },
                   
                ],
                "autoWidth": false
            });

            $(".selectpicker").selectpicker('refresh');
            return ajaxResult;
        }


        function GetModifiedField() {

            var strHTML = "";
            $("#cboModifiedField").html("");
            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            var RFIID = G_RFIID;
            var RequestParameters = {
                ProjectID: ProjectID,
                RFIID: RFIID
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetModifiedField", param, false);
            for (var i = 0; i < strResult.length; i++) {

                var obj = strResult[i];
                strHTML += '<option value=' + escape(obj.FieldName) + ' >' + obj.FieldName + '</option>';
            }
            $("#cboModifiedField").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }


        function GetModifiedBy() {

            var strHTML = "";
            $("#cboModifiedBy").html("");
            //var ProjectID = $("#cboProject").val();
            var ProjectID = EditProjectId;
            var RFIID = G_RFIID;
            var RequestParameters = {
                ProjectID: ProjectID,
                RFIID: RFIID
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetModifiedBy", param, false);
            for (var i = 0; i < strResult.length; i++) {

                var obj = strResult[i];
                strHTML += '<option value=' + obj.EmployeeId + ' >' + obj.ModifiedBy + '</option>';
            }
            $("#cboModifiedBy").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        function GetTimesheet(TimesheetIds) {
           
            var strHTML = "";
            var RequestParameters = {
                TimeSheetIDs: TimesheetIds.toString()
            }

            var param = JSON.stringify(RequestParameters);
            var Data = AJAXCallWithResult("/api/RFI_IR_PIR/GetTimesheetDetails", param, false);
           // 
           // for (var j = 0; j < TimesheetIds.length; j++) {
            //strMS += '<tr>';
            //strMS += '    <td colspan="9" id="milestone_detail_milestone' + projectid + '" class="milestone-detail">';
            strHTML += '<tr  id = "Row' + TimesheetIds + '"><td  id = "td' + TimesheetIds + '">'
            for (var i = 0; i < Data.length; i++) {
                    if (TimesheetIds == Data[i].TimesheetId) {
                        strHTML += '<div id="IR_Item_Acc' + TimesheetIds + '" class="accordion-collapse collapse "><div class="accordion-body"><div class="IR_Cards "><div class="row">'
                        //Added By Riddhesh Patil for no profile picture Issue on 21 Dec 2023
                        if (Data[i].SystemFilename != null) {
                            strHTML += '<div class="col-sm-2 d-flex align-items-center"><div class="ResImg"><div class="row"><img src="' + Data[i].SystemFilename + '" class="CardViewIniImg mx-auto" alt="">'
                        }
                        else {
                            strHTML += '<div class="col-sm-2 d-flex align-items-center"><div class="ResImg"><div class="row"><img src="../../../Whizible2.0-new/dist/img/blankprofile.png" class="CardViewIniImg mx-auto" alt="">'
                        }
                        //End of Added By Riddhesh Patil for no profile picture Issue on 21 Dec 2023
                        strHTML += '<label class="form-label IM_label">' + Data[i].EmployeeCode + '-' + Data[i].Employee + '</label></div></div></div><div class="col-sm-10 ps-0"><div class="card mb-2"><div class="card-body">'
                        strHTML += '<div class="row"><div class="col-sm-9"><div class="row"><div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end">'
                        strHTML += '<label class="form-label IM_label">Project Role:</label></div><div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label">' + Data[i].ProjectRole + '</label></div>'
                        strHTML += '</div></div><div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end"><label class="form-label IM_label">Actual Hrs:</label></div>'
                        strHTML += '<div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label">' + Data[i].ActualHr + '</label></div></div></div><div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end">'
                        strHTML += '<label class="form-label IM_label">Invoice Amount:</label></div><div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label greenAmt"><span class="">' + Data[i].CurrencySymbol + '</span> ' + Data[i].InvoiceAmount + '</label></div>'
                        strHTML += '</div></div><div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end"><label class="form-label IM_label">Location:</label></div><div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label">' + Data[i].Location + '</label></div></div></div>'
                        strHTML += '<div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end"><label class="form-label IM_label">No. of days worked:</label></div>'
                        strHTML += '<div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label">' + Data[i].DayWorked + '</label></div></div></div>'
                        strHTML += '<div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end"><label class="form-label IM_label">Edited Amount:</label></div>'
                        strHTML += '<div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label blueAmt"><span class="">' + Data[i].CurrencySymbol + '</span> ' + Data[i].FinalAmountPmEdit + '</label></div></div></div><div class="col-sm-4 px-0"><div class="row">'
                        strHTML += '<div class="col-sm-7 text-end"><label class="form-label IM_label">Billing Rate:</label></div><div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label"><span class="">' + Data[i].CurrencySymbol + '</span> ' + Data[i].BillingRate + '</label></div></div></div>'
                        strHTML += '<div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end"><label class="form-label IM_label">Daily Rate:</label></div><div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label"><span class="">' + Data[i].CurrencySymbol + '</span> ' + Data[i].DailyRate + '</label>'
                        strHTML += '</div></div></div><div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end"><label class="form-label IM_label">Difference (Final - Edited):</label></div><div class="col-sm-5 ps-0 text-start">'
                        strHTML += '<label class="form-label IM_label blueAmt"><span class="">' + Data[i].CurrencySymbol + '</span> ' + Data[i].PMEditDiffAmount + '</label></div></div></div><div class="col-sm-4 px-0"><div class="row"><div class="col-sm-7 text-end">'
                        strHTML += '<label class="form-label IM_label" >Working Day:</label></div><div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label">' + Data[i].WorkingDay + '</label></div></div></div><div class="col-sm-4 px-0">'
                        strHTML += '<div class="row"><div class="col-sm-7 text-end"><label class="form-label IM_label">Discount:</label></div><div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label">' + Data[i].Discount + '</label></div></div></div>'
                        strHTML += '<div class="col-sm-4 px-0"><div class="row dottedBrdr"><div class="col-sm-7 text-end"><label class="form-label IM_label">Final Amount:</label></div>'
                        strHTML += '<div class="col-sm-5 ps-0 text-start"><label class="form-label IM_label greenAmt"><span class="">' + Data[i].CurrencySymbol + '</span> ' + Data[i].FinaLAmount + '</label></div></div></div></div></div>'
                        strHTML += '<div class="col-sm-2 d-flex align-items-center"><div class="row"><div class="col-sm-12 "><label class="form-label IM_label remarkTxt">Remark: </label><span class="remarkTxt">' + Data[i].Remarks + '</span></div></div></div>'
                        //strHTML += '<div class="col-sm-1 d-flex justify-content-center" ><div class="custom_chckbox my-auto"><input type="checkbox" id="TSCheckAll21" class="TSCheck2"><label for="TSCheckAll21"></label></div>'
                        strHTML += '<div class="col-sm-1 d-flex justify-content-center" ><div class="custom_chckbox my-auto"><input id="descrGridchecks' + TimesheetIds + '_' + i + '" name="checkTimesheetItem' + TimesheetIds + '" class="chcktblTimesheet" type="checkbox" value="' + Data[i].AdviseId + '" onchange="selectTimesheetItem(' + TimesheetIds + ');" /> <label for="descrGridchecks' + TimesheetIds + '_' + i + '"></label></div>'
                        strHTML += '</div ></div ></div ></div ></div></div></div></div></div>'
                    }
                }
            strHTML += '</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>'

                //var rowIdToFind = "#Row" + TimesheetIds[j]; // Replace with the ID of the row you're looking for
                //var table = $('#ProjectTimesheetTbl').DataTable();

                //var $foundRow = table.rows().nodes().to$().each(function () {
                //    if ($(this).attr('id') == rowIdToFind) {
                //        return $(this).data('id');
                //    }
                //   // return $(this).data('id') === rowIdToFind;
                //});


              //  var $bulktasktblrow = $("#ProjectTimesheetTbl tbody tr#Row" + TimesheetIds[j])
                //return
             //   $bulktasktblrow.append(strHTML);
                //$("#Row" + TimesheetIds[j]).append(strHTML);
                //strHTML = "";
           // }

            return strHTML;
        }
      
        var G_TimesheetIds = [];
        function ShowTimeSheet() {
            $('#ProjectTimesheetTbl').dataTable().fnDestroy();
            $("#lblPrjName").text(G_ProjectName);
            var strHTML = "";
            var TimesheetIds = [];
            G_TimesheetIds = [];
            var ProjectId = $("#cboProject").val();
            var RFIId = $("#txtEdtbleIR_ID_Filter").val();
            var RequestParameters = {
                ProjectID: ProjectId,
                RFIID :RFIId
            }
           // 
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ShowTimeSheet", param, false);
            if (strResult != null) {

                for (var i = 0; i < strResult.length; i++) {
                    var Details = strResult[i];
                    TimesheetIds.push(Details.TimeSheetNo);
                    /*  var Data = GetTimesheet(Details.TimeSheetNo);*/
                    //  console.log(Data);
                    if (Details.PartiallyBillingFlag == 1) {
                        strHTML += '<tr class="bgColor">'
                    }
                    else {
                        strHTML += '<tr>'
                    }
                    strHTML += ' <td>' + Details.TimeSheetNo + '</td>' +
                        ' <td>' + Details.FromDate + '</td>' +
                        ' <td>' + Details.ToDate + '</td>'
                    if (Details.PartiallyBillingFlag == 1) {
                        strHTML += ' <td>' +
                            '<div class="TS_HoursCol">' + Details.BillableHours + ' <img src="../../../Whizible2.0-new/dist/img/info-circle-orange.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Hours to Billed : ' + Details.RemainingHrs + '"></div>' +
                            '</td>' +
                            '<td>' +
                            '<div class="TS_ProjAmt">' + Details.ProjectedAmount + '<img src="../../../Whizible2.0-new/dist/img/info-circle-orange.svg" alt="" class="ms-2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Remaining Projected Amount : ' + Details.ReaminingAmount + '"></div>' +
                            '</td>'
                    }
                    else {
                        strHTML += ' <td>' + Details.BillableHours + '</td>' +
                            ' <td>' + Details.ProjectedAmount + '</td>'
                    }

                    strHTML += ' <td>' + Details.CreatedDate + '</td>' +
                        ' <td>' + Details.ApprovedDate + '<span class="ps-2" data-bs-toggle="collapse" data-bs-target="#IR_Item_Acc' + Details.TimeSheetNo + '" aria-expanded="true"><i class="fas fa-angle-down" data-bs-toggle="tooltip" title="More Details" ></i></span></td>' +
                        '<td> <div class="custom_chckbox">  <input id="descrGridcheck' + i + '" name="CheckPrjTimesheet' + Details.TimeSheetNo + '" class="chcktbl" onchange="CheckTSUncheck(this.value); selectTimesheet(this.value);" type="checkbox" value="' + Details.TimeSheetNo + '" /> <label for="descrGridcheck' + i + '"></label>   </div></td>' +
                        '</tr>'
                    strHTML += GetTimesheet(Details.TimeSheetNo);
                    //strHTML += '</tr>'
                        /* '< tr id = "Row' + Details.TimeSheetNo + '" ><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td> </tr > '*/
                     /*   < tr id="Row' + Details.TimeSheetNo + '" >*/
                }
            }

            $("#ProjectTimesheetTblBody").html(strHTML);
            $('#ProjectTimesheetTbl').dataTable({
                // "scrollY": true,
                // "scrollX": true,
                "paging": true,
                "pageLength": 6,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                "drawCallback": function (settings) {
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
                    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
                        return new bootstrap.Popover(popoverTriggerEl);
                    });
                }
            });

            G_TimesheetIds = TimesheetIds;
            //Added By Riddhesh Patil on 25 Dec 2023 for grid plotting issue on project timesheet
                var table = $('#ProjectTimesheetTbl').DataTable();
            table.rows().every(function () {
                var rowData = this.node();
                var id = rowData.id; // Assuming the ID is in the first column

                for (var i = 0; i < TimesheetIds.length; i++) {
                    if (id === 'Row' + TimesheetIds[i]) {
                        $(this.node()).find('td:not(:first-child)').remove();
                        $(this.node()).find('td:first-child').attr('colspan', '8');
                    }
                }
            });
            //End of Added By Riddhesh Patil on 25 Dec 2023 for grid plotting issue on project timesheet
        }
        var G_TimesheetID = 0;
        function selectTimesheet(TimesheetID) {
           
            if ($('input[type="checkbox"][name="CheckPrjTimesheet' + TimesheetID + '"]').is(':checked') == true) {
                G_TimesheetID = TimesheetID;
                $('input[type="checkbox"][name="checkTimesheetItem' + TimesheetID + '"]').prop('checked', true);
            }
            else {
                G_TimesheetID = 0;
                $('input[type="checkbox"][name="checkTimesheetItem' + TimesheetID + '"]').prop('checked', false);
            }
        }

        
        /*$('input[type="checkbox"].TSCheck2').prop('checked', true);*/
        //function CheckUncheck(TimesheetID) {
        //   // alert();
        //  //  
           
        //  //  $('input[type="checkbox"][name="CheckPrjTimesheet' + TimesheetID + '"]').each(function () {
        //           // if ($(this).is(':checked')) {




        //                if (G_TimesheetID != TimesheetID || G_TimesheetID != 0) {
        //                    //$('input[type="checkbox"][name="CheckPrjTimesheet' + TimesheetID + '"]').not(this).prop('checked', false);
        //                    $('input[type="checkbox"][name="CheckPrjTimesheet' + TimesheetID + '"]').prop('checked', true);
        //                    $('input[type="checkbox"][name="checkTimesheetItem' + TimesheetID + '"]').prop('checked', true);
        //                    $('input[type="checkbox"][name="CheckPrjTimesheet' + G_TimesheetID + '"]').prop('checked', false);
        //                    $('input[type="checkbox"][name="checkTimesheetItem' + G_TimesheetID + '"]').prop('checked', false);

        //                }

        //                //if (G_TimesheetID == TimesheetID && ($('input[type="checkbox"][name="CheckPrjTimesheet' + TimesheetID + '"]').prop('checked') === true)) {
        //                //    //alert();
        //                //    $('input[type="checkbox"][name="CheckPrjTimesheet' + TimesheetID + '"]').prop('checked', false);
        //                //    $('input[type="checkbox"][name="checkTimesheetItem' + TimesheetID + '"]').prop('checked', false);
        //                //}
        //                //else {
                     
        //                //    $('input[type="checkbox"][name="CheckPrjTimesheet' + TimesheetID + '"]').prop('checked', true);
        //                //    $('input[type="checkbox"][name="checkTimesheetItem' + TimesheetID + '"]').prop('checked', true);
        //                //}
        //            //}
        //  //  });
          
        //    G_TimesheetID = TimesheetID;
        //}


        function CheckTSUncheck(TimesheetID) {
           // debugger
            G_TimesheetID = TimesheetID;
            var checked = "";
            for (var i = 0; i < G_TimesheetIds.length; i++) {
                if (G_TimesheetIds[i] == TimesheetID) {

                    //G_TimesheetID = TimesheetID;
                    checked = $('input[type="checkbox"][name="CheckPrjTimesheet' + G_TimesheetIds[i] + '"]').is(':checked');
                    if (checked) {
                        $('input[type="checkbox"][name="checkTimesheetItem' + G_TimesheetIds[i] + '"]').each(function () {
                            $(this).prop("checked", true);
                        });
                    } else {
                        $('input[type="checkbox"][name="checkTimesheetItem' + G_TimesheetIds[i] + '"]').each(function () {
                            $(this).prop("checked", false);
                        });
                    }


                }
                else {
                    $('input[type="checkbox"][name="CheckPrjTimesheet' + G_TimesheetIds[i] + '"]').prop("checked", false);
                    //checked = $('input[type="checkbox"][name="CheckPrjTimesheet' + G_TimesheetIds[i] + '"]').is(':checked');
                   
                        $('input[type="checkbox"][name="checkTimesheetItem' + G_TimesheetIds[i] + '"]').each(function () {
                            $(this).prop("checked", false);
                        });
                   
                }
            }
          

        }



        function selectTimesheetItem(ID) {
            if (G_TimesheetID != ID) {
                $('input[type="checkbox"][name="CheckPrjTimesheet' + G_TimesheetID + '"]').prop('checked', false);
                $('input[type="checkbox"][name="CheckPrjTimesheet' + ID + '"]').prop('checked', true);
                $('input[type="checkbox"][name="checkTimesheetItem' + G_TimesheetID + '"]').prop('checked', false);
            }
            else {
                var count = $('input[type="checkbox"][name="checkTimesheetItem' + ID + '"]:checked').length;

                $('input[type="checkbox"][name="checkTimesheetItem' + ID + '"]').each(function () {
                    if ($(this).prop("checked")) {
                        count++;
                    }
                    else {
                        count--;
                    }
                });
                if (count <= 0) {
                    $('input[type="checkbox"][name="CheckPrjTimesheet' + ID + '"]').prop('checked', false);
                }
                else {
                    $('input[type="checkbox"][name="CheckPrjTimesheet' + ID + '"]').prop('checked', true);
                }
            }
            G_TimesheetID = ID;

        }


        var TimesheetId = "";
        var AdvisedIds = [];
        var SiteCurrencyIds = [];
        
        function SelectPrjTimesheet() {
            debugger;
            //Added by Vishal Mane on 20/12/23 to solve issue of timesheet displaying 2-3 times in Invoice Item Tab when we click multiple times on Ok button.
            $("#IR_TS_OK_Btn").prop("disabled", false);
            //End of Added by Vishal Mane on 20/12/23 to solve issue of timesheet displaying 2-3 times in Invoice Item Tab when we click multiple times on Ok button.
            var table = $('#ProjectTimesheetTbl').DataTable();

            //Added by Ajit 26/12
            var rows = table.rows({ 'search': 'applied' }).nodes();
            TimesheetId = $('input[name=CheckPrjTimesheet' + G_TimesheetID + ']:checked', rows).map(function () {
                return this.value;
            }).get().join(',');

            //alert();
            $('#ProjectTimesheetTbl').on('change', 'input[type="checkbox"]', function () {
                //$('input[type="checkbox"]', rows).prop('checked', false);      
              /*  $(this).prop('checked', true);*/
                TimesheetId = $(this).val();
            });



            TimesheetId = TimesheetId.toString();
            TimesheetId = G_TimesheetID;
            AdvisedIds = $('input[name=checkTimesheetItem' + G_TimesheetID + ']:checked', rows).map(function () {
                return this.value;
            }).get().join(',');


            var ProjectID = EditProjectId;
            var RFIId = $("#txtEdtbleIR_ID_Filter").val();
            var TimesheetParam = {
                AdvisedIDs: AdvisedIds,
                ProjectID: ProjectID,
                RFIID: RFIId
            }
            var Parameters = JSON.stringify(TimesheetParam);

            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateTimesheetRate", Parameters, false);
            if (Result != "") {
                if (Result.indexOf("Different currency") != -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Resouce(s) on different site(s) with different currecy can not be billed under single IR');
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(Result);
                }
                $(".chcktbl").prop("checked", false);
                $(".chcktblTimesheet").prop("checked", false);
                SiteCurrencyIds = [];
            }
            else {
                /*SiteCurrencyIds = [];*/
                $('.chcktblTimesheet:checked', rows).map(function () {
                    SiteCurrencyIds.push($(this).attr("data-customattribute"));
                    //selectedSiteCurrencyIds.push($(this).attr("data-customattribute"));
                })

                //alert(AdvisedIds);
                var ProjectID = $("#cboProject").val();
                //var RequestParameters = {
                //    ProjectID: ProjectID
                //}
                GetGlobalCurrencies(ProjectID);
                //var param = JSON.stringify(RequestParameters);
                //var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIProjectbillingCurrency", param, false);
                //GCurrencyID = Result;
                var InvoiceConversionDate = $('#toDateFilterE').val();

                /*  var IsAlertContractValue = ValidateContractValue();*/
                //var CorporateBaseCurrencyID = CorporateBaseCurrencyID;
                if (TimesheetId == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_TimesheetBlank")%>');
                    return false;
                }
                //} else if (IsAlertContractValue != "" && (IsValidateContractValue == true || IsValidateContractValue == 1)) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error(IsAlertContractValue);
                //    //IsValidate = false;
                //    return false
                //}
                else {
                    var IsValidSite = ValidateSiteCurrency(SiteCurrencyIds, InvoiceConversionDate, ProjectCurrency);
                    var IsValidCorp = ValidateProjToCorpCurrencyRate(TimesheetId, InvoiceConversionDate, CorporateBaseCurrencyID, ProjectCurrency);
                   // return
                    var IsValidBilling = ValidateProjToBillingCurrencyRate(InvoiceConversionDate, ProjectCurrency, BillingCurrencyID);
                   
                    if (IsValidSite == 0 && IsValidCorp == 0 && IsValidBilling == 0) {
                        ValidateTSGenrationDate();//Ajit 08/01/2023
                        //$("#IR_CreateTSModal").modal('show'); // Commented by Ajit on 25/12
                    } else {
                        $("#IR_CreateTSModalDate").modal('hide');
                        $("#IR_CreateTSModal").modal('hide');
                    }
                }
            }
        }


        function ValidateSiteCurrency(SiteCurrencyIds, InvoiceConversionDate, ProjectCurrency) {
            
            var IsValid = 0;
            if (SiteCurrencyIds.length != 0) {
                var RFIID = G_RFIID;
                var uniqueSiteCurrencyIds = Array.from(new Set(SiteCurrencyIds));
                var selectedSiteCurrencyIdsString = uniqueSiteCurrencyIds.join(",");               
                var SiteCurrencyIdsDetails = {
                    ExpencesCurrencyIDs: selectedSiteCurrencyIdsString,
                    InvoiceConversionDate: InvoiceConversionDate,
                    CorpBaseCurrencyID: ProjectCurrency,
                    RFIID: RFIID
                }
                var param = JSON.stringify(SiteCurrencyIdsDetails);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateExpenseCurrencyIDs", param, false);
                if (strResult != null) {
                    $.each(strResult, function (index, obj) {
                        
                        if (obj.Flag == 0 && obj.CurrencyID != ProjectCurrency) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Currently, no Site currency to Project currency conversion rate is defined for this Invoice Conversion Date' + InvoiceConversionDate + '. Please define it ');
                            $("#IR_CreateTSModal").modal('hide');
                            IsValid = 1;
                            return IsValid;
                        } 
                    });
                }                
                else {
                    IsValid = 0;
                }
            }            
            return IsValid;
        }

        function ValidateProjToCorpCurrencyRate(TimesheetId, InvoiceConversionDate, CorporateBaseCurrencyID, ProjectCurrency) {
            debugger
            var IsValid = 0;

            if (TimesheetId != "" && ProjectCurrency != CorporateBaseCurrencyID) {
                var InvoiceConversionDate = $('#toDateFilterE').val();
                var TimesheetCurrencyCode = {
                    ExpencesCurrencyIDs: ProjectCurrency,
                    InvoiceConversionDate: InvoiceConversionDate,
                    BaseCurrencyCode: CorporateBaseCurrencyID
                }
                var param = JSON.stringify(TimesheetCurrencyCode);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateProjectCurrency", param, false);
             
                if (strResult == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    //Modified by Vishal Mane on 30/12/2023 to solve issue of 'Create IR Item Button not work on Project Timesheet'
                    alertify.error('Currency Conversion rate for invoice conversion date (' + InvoiceConversionDate + ') of Project Currency (' + ProjectCurrencyCode + ') to Corporate Base Currency (' + CorporateBaseCurrencyCode +') is not defined.Please contact Administartor!');
                    
                    $("#IR_CreateTSModal").modal('hide');
                    IsValid = 1;
                    return IsValid;
                }
                else if (ProjectCurrency != GCurrencyID) {
                    var InvoiceConversionDate = $('#toDateFilterE').val();
                    var TimesheetCurrencyCode = {
                        ExpencesCurrencyIDs: ProjectCurrency,
                        InvoiceConversionDate: InvoiceConversionDate,
                        BaseCurrencyCode: CorpCurrencyID
                    }
                    var param = JSON.stringify(TimesheetCurrencyCode);
                    var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateProjectCurrency", param, false);
                    if (strResult == 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_AmountSpclChar")%> ' + InvoiceConversionDate + ' <%=MyBase.GetResourceString("A_AmountNum")%>');
                        $("#IR_CreateTSModal").modal('hide');
                        IsValid = 1;
                        return IsValid;
                    }
                    else {
                        //if (IsValid != 1) {
                        //    ValidateTSGenrationDate();  //Added by Ajit
                        //    //  $("#IR_CreateTSModal").modal('show');
                        //}
                    }
                }
                else {
                    //if (IsValid != 1) {
                       
                    //    ValidateTSGenrationDate();  //Added by Ajit
                    //    //  $("#IR_CreateTSModal").modal('show');
                    //}
                }
            }
            else {
               // alert(IsValid);
                //if (IsValid != 1) {
                    
                //    ValidateTSGenrationDate();  //Added by Ajit
                //    //  $("#IR_CreateTSModal").modal('show');
                //   IsValid = 0;
                //}
                IsValid = 0;
            }
            G_IsValidflag = IsValid;
                return IsValid;
        }


        //Added by Ajit L for comparing Timesheeet genration & invoice conversion date on  22/12/2023
        var TimesheetIDs = [];
        function ValidateTSGenrationDate() {
            //alert(G_IsValidflag);
            if (G_IsValidflag != 1) { //Condition changed by Ajit on 08/01/2023

                var IRConversionDate = $('#toDateFilterE').val();
                var ProjectId = $("#cboProject").val();

                var table = $('#ProjectTimesheetTbl').DataTable();

                // Added & Commented by Ajit on 26/12 to select only on timesheet
                var rows = table.rows({ 'search': 'applied' }).nodes();
                TimesheetId = $('input[name=CheckPrjTimesheet' + G_TimesheetID + ']:checked', rows).map(function () {
                    return this.value;
                }).get().join(',');


                //Added & Commented by Ajit L on 25/12/23 start
                TimesheetId = TimesheetId.toString();

                if (TimesheetId == "") {

                    TimesheetId = G_TimesheetID.toString();
                }
                else {
                    TimesheetId = TimesheetId.toString();
                }
                //Added & Commented by Ajit L on 25/12/23 start
                var RequestParameters = {
                    ProjectID: ProjectId,
                    TimesheetIds: TimesheetId
                }

                var param = JSON.stringify(RequestParameters);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateTSGenrationDate", param, false);
              
                if (strResult != null) {
                    TimesheetIds = [];
                    for (var i = 0; i < strResult.length; i++) {

                        var Details = strResult[i];
                        // 
                        if (IRConversionDate != Details.InvoiceDate) {
                            $("#IR_CreateTSModalDate").modal('show');
                            $("#IR_CreateTSModal").modal('hide');
                        }
                        else {
                            $("#IR_CreateTSModal").modal('show');
                        }

                    }

                }
            }
        }
        function ValidateProjToBillingCurrencyRate(InvoiceConversionDate, ProjectCurrency, BillingCurrencyID) {
            debugger
            var IsValid = 0;
            if (ProjectCurrency != BillingCurrencyID) {
                //var InvoiceConversionDate = $('#toDateFilterE').val();
                var TimesheetCurrencyCode = {
                    ExpencesCurrencyIDs: ProjectCurrency,
                    InvoiceConversionDate: InvoiceConversionDate,
                    BaseCurrencyCode: BillingCurrencyID
                }
                var param = JSON.stringify(TimesheetCurrencyCode);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateProjectCurrency", param, false);
                if (strResult == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                <%--alertify.error('<%=MyBase.GetResourceString("A_CurrencyRate_Undefined")%> ' + InvoiceConversionDate + ' <%=MyBase.GetResourceString("A_CurrencyRate_Undefined_Contact")%>');--%>
                    alertify.error('Currency Conversion rate for invoice conversion date (' + InvoiceConversionDate + ') of Project Currency (' + ProjectCurrencyCode + ') to Billing Currency (' + BillingCurrencyCode + ') is not defined.Please contact Administartor!');
                    $("#IR_CreateTSModalDate").modal('hide');
                    $("#IR_CreateTSModal").modal('hide');
                    IsValid = 1;
                    return IsValid;
                }
                else {
                    if (IsValid != 1) {
                        ValidateTSGenrationDate();  //Added by Ajit
                        //  $("#IR_CreateTSModal").modal('show');
                    IsValid = 0;
                    }
                }
            }
           G_IsValidflag = IsValid;
            return IsValid;
        }
        var G_IsValidflag = 0;
        function SaveProTimesheet() {
            
            $("#IR_CreateTSModalDate").modal('hide');
            $("#IR_CreateTSModal").modal('show');
        }

        function SavePrjTimesheet() {
            //
            var ProjectId = $("#cboProject").val();
            var RFIId = $("#txtEdtbleIR_ID_Filter").val();
            var RequestParameters = {
                ProjectID: ProjectId,
                RFIID: RFIId,
                //TimeSheetID: TimesheetId,
                AdvisedIDs: AdvisedIds,
                CreatedBy: UserName
            }
            
            
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/InsertTimeSheet", param, false);
            if (strResult == "Save") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_TimesheetSave")%>');
                $("#IR_CreateTSModal").modal('hide');
                $("#ProjectTimesheetModal").modal('hide');
			    //Added by Vishal Mane on 20/12/23 to solve issue of timesheet displaying 2-3 times in Invoice Item Tab when we click multiple times on Ok button.
               $("#IR_TS_OK_Btn").prop("disabled", true);
               //End of Added by Vishal Mane on 20/12/23 to solve issue of timesheet displaying 2-3 times in Invoice Item Tab when we click multiple times on Ok button.
            }
            //Added By Riddhesh Patil on 08 Jan 2024 for Issue Invoice Amount=0
            else if (strResult == "UnSave") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Invoice Amount should be greater than 0');
                $(".chcktbl").prop("checked", false);
                $(".chcktblTimesheet").prop("checked", false);
                SiteCurrencyIds = [];
            }
            else if (strResult == "Different Currency") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Resouce(s) on different site(s) with different currecy can not be billed under single IR');
                $(".chcktbl").prop("checked", false);
                $(".chcktblTimesheet").prop("checked", false);
                SiteCurrencyIds = [];
            }
            //End of Added By Riddhesh Patil on 08 Jan 2024 for Issue Invoice Amount=0
            else {
               //Added by Vishal Mane on 20/12/23 to solve issue of timesheet displaying 2-3 times in Invoice Item Tab when we click multiple times on Ok button.
               $("#IR_TS_OK_Btn").prop("disabled", false);
               //End of Added by Vishal Mane on 20/12/23 to solve issue of timesheet displaying 2-3 times in Invoice Item Tab when we click multiple times on Ok button.
           }
            G_TimesheetID = 0;
            GetRFIItemsDetail(G_RFIID);
            GetIRPIRList(ProjectId);
           // EditIRPIR(G_RFIID, G_CurrentStatus, 0)
        }


        function restrictAlphabets(e) {

            var x = e.which || e.keycode;

            if ((x >= 48 && x <= 57) || x == 8 || (x >= 35 && x <= 40) || x == 46 || x == 58) {
                return true;
            }
            else {
                return false;
            }
        }

        function restrictNumericFilter(e) {
            var key = e.key;
            if ((key >= '0' && key <= '9') || key == 'Backspace' || key == 'Delete' || key == 'ArrowLeft' || key == 'ArrowRight' || key == 'ArrowUp' || key == 'ArrowDown') {
                return true;
            } else {
                //return false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_NumValue")%>');
                //e.preventDefault();
                return false;
            }
        }
        //Ajit by Ajit L for restricting special char in date textbox on 20/12/2023
        function restrictNumericFilters(e) {
            var key = e.key;
            if ((key >= '0' && key <= '9') || key == 'Backspace' || key == 'Delete' || key == 'ArrowLeft' || key == 'ArrowRight' || key == 'ArrowUp' || key == 'ArrowDown') {
                return true;
            } else {           
                     return false;
            }
        }
        function restrictDecimalNumeric(e) {
            var key = e.key;

            // Check if the key pressed is a numeric digit, dot, or a control key
            if ((key >= '0' && key <= '9') || key == '.' || key == 'Backspace' || key == 'Delete' || key == 'ArrowLeft' || key == 'ArrowRight' || key == 'ArrowUp' || key == 'ArrowDown') {
                return true;
            } else {
                // Show an alert and prevent the default action (e.g., input of the character)
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_NumValue")%>');
                e.preventDefault();
                return false;
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

        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPressCheck(e, id) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if (("#" + id) != ("#txtIRRateAddNew")) {
                    if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_RateNum")%>');
                        $("#" + id).focus();
                    }
                }
                else {

                    if (((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) && keyCode != 45) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%=MyBase.GetResourceString("A_RateNum")%>');
                        $("#" + id).focus();

                    }
                    else {
                        ret = true;
                    }
                }

            }
            return ret;
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

        var G_Saveflag = 0;
        function SaveIRItem() {
            var CustomField1 = "";
            var CustomField2 = "";
            var CustomField3 = "";
            var CustomField4 = "";
            var isDiscount = 0;

            //Added by Vishal on 19/12/23 for "If the Discount checkbox is checked then the for rate field alert should be come as "Please enter a negative numeric value for Rate.""
            var IsValidate = 0;
            if ($("#IRDiscntAddNew").prop('checked') == true) {
                isDiscount = 1;
            }
            else {
                isDiscount = 0;
            }
            if (isDiscount == 1) {
                var Rate = $("#txtIRRateAddNew").val();
                if (isNaN(Rate) || parseFloat(Rate) >= 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please enter a negative numeric value for Rate.');
                    $("#txtIRRateAddNew").focus();
                    IsValidate = 1;                    
                    return false
                }
            }
            else {
                var Rate = $("#txtIRRateAddNew").val();
                if (isNaN(Rate) || parseFloat(Rate) <= 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please enter a positive numeric value for Rate.');
                    $("#txtIRRateAddNew").focus();
                    IsValidate = 1;
                    return false
                }
            }

            //End of  //Added by Vishal on 19/12/23 for "If the Discount checkbox is checked then the for rate field alert should be come as "Please enter a negative numeric value for Rate.""            

            if (ValidateRFIItemAttributes() == true) {
                var RequestParameters = "";
                var isDiscount = 0;
                if ($("#IRDiscntAddNew").prop('checked') == true) {
                    isDiscount = 1;
                }
                else {
                    isDiscount = 0;
                }
                //Added and Commented by Ajit L on 19/12/2023 start
                //var ItemDesc = $("#txtIRDescAddNew").val();
                var ItemDesc = $("#txtIRDescAddNew").val().trim().replace(/'/g, "''");
                  //Added and Commented by Ajit L on 19/12/2023 end
                var Quantity = $("#txtIRQuantityAddNew").val();
                var Rate = $("#txtIRRateAddNew").val();
                var Amount = $("#txtIRAmountAddNew").val();
                var SeqNum = $("#txtIRSequenceNoAddNew").val();
                var RFIID = $("#txtEdtbleIR_ID_Filter").val();
                var G_BaseCurrencyAmount = BaseCurrencyAmount.toString().replace(/,/g, '');
                //var G_BaseCurrencyAmount = $("#txtBaseCurrencyAmount").val();
                var G_CompanyBaseCurrencyAmount = (CompanyBaseCurrencyAmount.toString().replace(/,/g, '')).toString();

                if (Quantity == "") {
                    Quantity = "0";
                }
                var CustomField = CustField;
                for (var i = 0; i < CustomField.length; i++) {


                    if (CustomField[i] == "txtCustomField1") {
                        CustomField1 = $("#txtCustomField1").val();
                    }
                    if (CustomField[i] == "txtCustomField2") {
                        CustomField2 = $("#txtCustomField2").val();
                    }
                    if (CustomField[i] == "txtCustomField3") {
                        CustomField3 = $("#txtCustomField3").val();
                    }
                    if (CustomField[i] == "txtCustomField4") {
                        CustomField4 = $("#txtCustomField4").val();
                    }
                }
                if (G_Saveflag == 0) {
                    RequestParameters = {
                        RFIItemID: G_RFIItemId,
                        RFIID: RFIID,
                        ItemDesc: ItemDesc,
                        Quantity: Quantity,
                        Rate: Rate,
                        OrderNum: SeqNum,
                        BaseCurrencyAmount: G_BaseCurrencyAmount,
                        BillingToBaseConversionRate: BillingToBaseConversionRate,
                        CompanyBaseCurrencyAmount: G_CompanyBaseCurrencyAmount,
                        CompanyBaseCurrencyConversionRate: CompanyBaseCurrencyConversionRate,
                        CreatedBy: UserName,
                        IsDiscount: isDiscount,
                        CustomField1: CustomField1,
                        CustomField2: CustomField2,
                        CustomField3: CustomField3,
                        CustomField4: CustomField4,
                        Amount: Amount
                    }
                }
                else {
                    RequestParameters = {
                        RFIItemID: 0,
                        RFIID: RFIID,
                        ItemDesc: ItemDesc,
                        Quantity: Quantity,
                        Rate: Rate,
                        OrderNum: SeqNum,
                        BaseCurrencyAmount: G_BaseCurrencyAmount,
                        BillingToBaseConversionRate: BillingToBaseConversionRate,
                        CompanyBaseCurrencyAmount: G_CompanyBaseCurrencyAmount,
                        CompanyBaseCurrencyConversionRate: CompanyBaseCurrencyConversionRate,
                        CreatedBy: UserName,
                        IsDiscount: isDiscount,
                        CustomField1: CustomField1,
                        CustomField2: CustomField2,
                        CustomField3: CustomField3,
                        CustomField4: CustomField4,
                        Amount: Amount
                    }
                }
                var param = JSON.stringify(RequestParameters);

                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/InsUpdRFIItems", param, false);
                G_RFIID = RFIID
                GetRFIItemsDetail(G_RFIID);
                $("#AddNewIRModal").modal('hide');
                var ProjectID = EditProjectId;
                GetIRPIRList(ProjectID);
            }
        }



        function getTotalAmount() {

            var Quantity = $("#txtIRQuantityAddNew").val();
            var Rate = $("#txtIRRateAddNew").val();
            var TotalAmount = "";
            if (Quantity == 0 || Quantity == "") {
                Quantity = 1
            }
            TotalAmount = Rate * Quantity;
              //Added By Dipali V On 15th Jan 2024 For Round By Issue
            //$("#txtIRAmountAddNew").val(TotalAmount);
            $("#txtIRAmountAddNew").val(TotalAmount.toFixed(3));
              //End of Added By Dipali V On 15th Jan 2024 For Round By Issue
            $("#txtIRAmountAddNew").trigger("change");
        }

         //Commented & Added by Ajit L on 08/01/2023 for Amount value Rounded by two digit--Start 
        function convertedTotalAmount() {
            var BillingCurncyAmnt = $("#txtIRAmountAddNew").val();
            var roundedAmount = "";

            if (BillingToBaseConversionRate == 0 || BillingToBaseConversionRate == undefined) {
                BaseCurrencyAmount = 0;
                //roundedAmount = BaseCurrencyAmount
            }
            else {
                BaseCurrencyAmount = BillingCurncyAmnt * BillingToBaseConversionRate;
               
            }

            if (CompanyBaseCurrencyConversionRate == 0 || CompanyBaseCurrencyConversionRate == undefined) {
                CompanyBaseCurrencyAmount = 0
                //Added By Dipali V On 15th Jan 2024 For Round By Issue
                //roundedAmount = CompanyBaseCurrencyAmount
                roundedAmount = CompanyBaseCurrencyAmount.toFixed(3);
                  //End of Added By Dipali V On 15th Jan 2024 For Round By Issue
            }

            else {
                CompanyBaseCurrencyAmount = BillingCurncyAmnt * CompanyBaseCurrencyConversionRate;
                 roundedAmount = CompanyBaseCurrencyAmount.toFixed(3);
            }
            //$("#txtBaseCurrencyAmount").val(BaseCurrencyAmount);
              //Added By Dipali V On 15th Jan 2024 For Round By Issue
            $("#txtBaseCurrencyAmount").val(BaseCurrencyAmount.toFixed(3));
            $("#lblTotalAmount").text(roundedAmount + " " + CompanyBaseCurrencyCode);
              //End of Added By Dipali V On 15th Jan 2024 For Round By Issue
             //Commented & Added by Ajit L on 03/01/2023 for Amount value Rounded by two digit--End 

        }

        function ClearAllCopyIR() {
            $("#cboRFIType").val(0);
            $("#cboCustomer").val(0);
            $("#cboContactPer").val(0);
            $("#txtEmail_Confirm").val('');
            $("#txtContract").val('');
            $("#TexthiddenContract").val('');
            $("#toDateFilter").val('');
            $("#txtCreditDays").val('');
            $("#lblCurrency").text('');
            $("#txtSalesPeriod").val('');
            $("#txthdnSalesPeriod").val('');
            $("#txtSalesPerson").val('');
            $("#txthdnSalesPer").val('');
            $("#txtAItemHead").val('');
            $("#offcvsIRPIR_Add_Screen").removeClass('show');
        }

        /*
          Created By : Vishal Mane
          Created Date : 07/11/2023
          Purpose : To update filter for IR/PIR filter
          */
        function clearAll() {

            ProjectID = $("#cboProject").val();
            //var ProjectIDFilter = $("#cboProjectFilter").val();
            //if (ProjectIDFilter == undefined || ProjectIDFilter == 0) {
            //    ProjectID = $("#cboProject").val();
            //} else {
            //    ProjectID = ProjectIDFilter;
            //}
            //var ProjectID = $("#cboProject").val();
            $("#Fil_Amount").val("");
            $("#Fil_IRID").val("");
            $("#Fil_RaisedOnDate").val("");
            $("#Fil_AmountCB").val("");
            $("#Fil_EquivAmount").val("");
            $("#txtFilterID").val("");
            $("#txtFilterName").val("");
            $("#cboProjectFilter").val(0);
            $("#cboIRPIRFilter").val(1);
            $("#cboCurrencyFilter").val(0);
            var Status = $("#cboStatusFilter").val();
            var textStatus = $("#cboStatusFilter").find(":selected").text();
            if (textStatus != "Select Status") {
                $("#cboStatusFilter").val(0);
                $("#cboStatusFilter").find(":selected").text("Select Status");
            }
            $("#cboTypeFilter").val(0);

            //to hide clear all 
            $("#PMProjectReviewClearAllFilter").hide();
            //for area expanded property of filter icon
            $("#AdvanceFilterIcon").attr('aria-expanded', 'false');

            $("#filterpanel").removeClass('show');


            GetIRPIRList(SessionProjectID);
            console.log(SessionProjectID);
            
            $("#cboProject").val(SessionProjectID);
            $(".selectpicker").selectpicker('refresh');
        }



        var g_ItemIds = "";
        function DeleteIRPIRItems() {
            var table = $('#IRPIR_EditblDetails').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var RFIItemIds = $('input[name=checkRFIItem]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrMasterIDs = RFIItemIds.split(',');
            if (arrMasterIDs == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelectOneRecordDel")%>');
            }
            else {
                g_ItemIds = RFIItemIds;
                $("#deleteIrItem").modal('show');
            }
        }


        function DeleteIRItems() {
            var IRItemIds = g_ItemIds.toString();
            var Parameter =
            {
                RFIItemIDs: IRItemIds
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/DeleteIRPIRItems", param, false);

            if (Result[0].length != 0) {
                if (Result[0].ack == "success") {
                    if (Result[0].strResult.toString().indexOf("deleted successfully") != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(Result[0].strResult);
                        $(".chckHead").prop("checked", false);
                        $(".EdtblChckHead").prop("checked", false);
                        $(".EdtblChckHead").removeAttr("checked");
                        //Added By Dipali V On 16th Jan 2024 For Refresh Issue after delete IR Items
                        var ProjectID = $("#cboProject").val();
                        GetIRPIRList(ProjectID);
                          //End of Added By Dipali V On 16th Jan 2024 For Refresh Issue after delete IR Items
                    }
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(Result[0].strResult);
                    $(".chckHead").prop("checked", false);
                }
            }

            GetRFIItemsDetail(G_RFIID);

        }


        /*
   Created By : Vishal Mane
   Created Date : 11/11/2023
   Purpose : To Get RFI Checklist Items
   */
        function GetInvoiceList(RFIID) {
            //
            var strHTML = "";
            $("#printInvoiceTbl").dataTable().fnDestroy();
            var ProjectID = $("#cboProject").val();
            $("#txtRFIId").text(RFIID);
            var ChecklistFields = {
                RFIID: encodeURI(RFIID),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ChecklistFields)
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetInvoiceList", param, false);
            if (strResult.length != 0) {
                $.each(strResult, function (index, obj) {
                    strHTML += '<tr><td class="text-centre">' + obj.InvoiceID + '<input hidden type="text" value=' + obj.InvoiceID + '></td>';
                    strHTML += '<td class="text-centre">' + obj.InvoiceNumber + '</td>';
                    strHTML += '<td class="text-centre">' + obj.InvoiceDate + '</td>';
                    strHTML += '<td class="text-centre"><a href="javascript:;" data-bs-toggle="modal" onclick="SetSelectedInvoice(' + obj.InvoiceID + ');" data-bs-target="#IRPIRPrintReportmodal">Show Report</a></td></tr>';
                });
            }
            $("#printInvoiceTbl_Body").html(strHTML);
        }

        function SetSelectedInvoice(InvoiceID) {
            $("#cboInvoiceNumber1").val(InvoiceID);    
            $(".selectpicker").selectpicker('refresh');
        }

        /*
        Created By : Vishal Mane
        Created Date : 11/11/2023
        Purpose : To print RFI report
        */
        function Export_PDFClick1(ReportFormat) {
            //
            var IsInvoiceValidated = ValidateInvoiceNumber();
            var InvoiceNumber = $("#cboInvoiceNumber").val();
            if (IsInvoiceValidated == 0) {
                //alert("ok");
                var Parameter = {
                    InvoiceNumber: encodeURI(InvoiceNumber),
                    ReportFormat: encodeURI(ReportFormat),
                }
                //var param = JSON.stringify(Parameter)
                //var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ExportToReport", param, false);
                $.ajax({
                    url: strUrl + '/api/RFI_IR_PIR/ExportToReport',
                    method: 'Post',
                    data: JSON.stringify(Parameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                        if (Parameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? param : JSON.stringify(Parameter)));
                        }
                    },
                    success: function (result) {
                        //
                        if (result != "0") {
                            window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 11/11/2023
        Purpose : To print RFI report
        */
        function Export_PDFClick(ReportFormat) {
            //            
            var InvoiceNumber = $("#cboInvoiceNumber1").val();
            var Parameter = {
                InvoiceNumber: encodeURI(InvoiceNumber),
                ReportFormat: encodeURI(ReportFormat),
            }
            //var param = JSON.stringify(Parameter)
            //var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ExportToReport", param, false);
            $.ajax({
                url: strUrl + '/api/RFI_IR_PIR/ExportToReport',
                method: 'Post',
                data: JSON.stringify(Parameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? param : JSON.stringify(Parameter)));
                    }
                },
                success: function (result) {
                    //
                    if (result != "0") {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }


        /*
        Created By : Vishal Mane
        Created Date : 11/11/2023
        Purpose : To validate Invoice number before printing RFI report
        */
        var IsInvoiceValidated;
        function ValidateInvoiceNumber() {
            //
            var IsInvoiceValidated = 0;

            var InvoiceNumber = $("#cboInvoiceNumber").val();
            if (InvoiceNumber == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_InvoiceNumBlank")%>');
                $("#cboInvoiceNumber").focus();
                IsInvoiceValidated = 1;
                return IsInvoiceValidated;
            } else {
                return IsInvoiceValidated;
            }
        }


        /*
       Created By : Vishal Mane
       Created Date : 11/11/2023
       Purpose : To Get IR/PIR Status History
       */
        function GetRFIStatusHistory(RFIID) {
            var strHTML = "";
            $("#PIRstatushistoryTbl").dataTable().fnDestroy();
            var ProjectID = $("#cboProject").val();
            var ChecklistFields = {
                RFIID: encodeURI(RFIID),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ChecklistFields)
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIStatusHistory", param, false);
            if (strResult.length != 0) {
                $.each(strResult, function (index, obj) {
                    if (obj.CurrentRFIStatus == "Rejected") {
                        strHTML += '<tr><td class="text-centre red-text">' + obj.CurrentRFIStatus + '</td>';
                    } else {
                        strHTML += '<tr><td class="text-centre">' + obj.CurrentRFIStatus + '</td>';
                    }
                    //strHTML += '<tr><td class="text-centre">' + obj.CurrentRFIStatus + '</td>';
                    strHTML += '<td class="text-centre">' + obj.ChangedBy + '</td>';
                    strHTML += '<td class="text-centre">' + obj.ChangedOn + '</td>';
                    if (obj.Comments == null) {
                        strHTML += '<td class="text-centre"></td></tr>';
                    } else {
                        //Commented and Added by Ajit L. on 08 Jan 2024
                        //strHTML += '<td class="text-centre">' + obj.Comments + '</td></tr>';
                        strHTML += '<td class="text-left">' + obj.Comments + '</td></tr>';
                        //End of Commented and Added by Ajit L. on 08 Jan 2024
                    }

                });
            }
            $("#PIRstatushistoryTbl_Body").html(strHTML);
            $('#PIRstatushistoryTbl').dataTable({
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
            });
        }


        /*
      Created By : Vishal Mane
      Created Date : 20/11/2023
      Purpose : To dispaly the modal pop-up for copy confirmation
      */
        function ConfirmCopyIR(IRPIRid, CurrentStatus, EditCopyFlag) {

            $(".modalRFIID").text("");
            $(".modalEditCopyFlag").text("");
            $("#confirmCopyIRModal").modal("show");
            $(".modalRFIID").text(IRPIRid);
            $(".modalEditCopyFlag").text(EditCopyFlag);
        }

        /*
        Created By : Vishal Mane
        Created Date : 20/11/2023
        Purpose : To create new IR/PIR when click on copy link
        */
        $('#okCopyBtn').on('click', function () {
            //$("#offcvsIRPIR_2ndEdit_Screen").show();

            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcvsIRPIR_2ndEdit_Screen'));
            myOffcanvas.show();
            $(".offcanvas-backdrop").removeClass("show");
            var modalRFIIDValue = $('.modalRFIID').text();
            var modalEditCopyFlagValue = $('.modalEditCopyFlag').text();
            
            EditIRPIR(modalRFIIDValue, 0, modalEditCopyFlagValue);
        });

        /*
        Created By : Vishal Mane
        Created Date : 20/11/2023
        Purpose : To show IR/PIR details as per entered IR/PIR ID
        */
        var PRJID;//Added by Ajit on 08/01/2024
        $('#showEditblIRBtn').on('click', function () {

            var RFIID = $("#txtEdtbleIR_ID_Filter").val();
            if (RFIID == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please Enter IR ID');
                $("#txtEdtbleIR_ID_Filter").focus();
                return false;
            }
            else {
                Parameters = {
                    RFID: RFIID
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetIrDetails", param, false);
                var CurrentStatus;
                if (strResult.length != 0) {
                    CurrentStatus = strResult[0].CurrentStatus;
                    PRJID = strResult[0].ProjectID;
                }

                var Parameters = {
                    UserId: SessionEmployeeId,
                    LoginType: SessionLoginType,
                    RFIID: RFIID
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIAccessOnProject", param, false);

                if (strResult.indexOf("Not Exists") != -1) {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('This is not a valid ID!');
                }
                else if (strResult == 1) {
                    EditIRPIR(RFIID, CurrentStatus, 0);
                    $("#ShowHideEditDiv").removeClass("ShowHideDiv");

                }
                if (strResult == 0) {
                    $("#ShowHideEditDiv").addClass("ShowHideDiv");
                    $("#NotAuthDiv").show();
                    $("#saveEditblIRBtn").hide();
                    $("#submitIREditblBtn").hide();
                    $("#ResubmitIREditblBtn").hide();
                    $("#projMS_EditblIRBtn").hide();
                    $("#projDlvrbl_EditblIRBtn").hide();
                    $("#projExpsEditblIRBtn").hide();
                    $("#ProjectTS_EditblBtn").hide();
                    $("#projMS_EditblIRBtn").hide();
                    $("#projDlvrbl_EditblIRBtn").hide();
                    $("#ProjectTS_EditblBtn").hide();
                    $("#ShowHisEditblIRBtn").hide();
                    $("#ViewChecklistEditIRBtn").hide();
                    //   $("#myElement").css("display", "none");     /*
                }
            }
        });


        /*
        Created By : Vishal Mane
        Created Date : 20/11/2023
        Purpose : To submit IR/PIR details for copy IR/PIR  
        */
        $('#submitIREditblBtn').on('click', function () {
            //Added By Dipali V On 16th Jan 2024 For Validate Contract Value
            var IsAlertContractValue = ValidateContractValue();
             //End of Added By Dipali V On 16th Jan 2024 For Validate Contract Value
            if (IsAlertContractValue != "" && (IsValidateContractValue == true || IsValidateContractValue == 1)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(IsAlertContractValue);
                //IsValidate = false;
                return false
            } else {
                var copyRFIIDValue = $("#txtEdtbleIR_ID_Filter").val();
                //GetRFIChecklistItems(copyRFIIDValue, 0);
                GetRFIChecklistItems(copyRFIIDValue, "", 0,0)
            }
        });

        $('#ResubmitIREditblBtn').on('click', function () {
             //Added By Dipali V On 16th Jan 2024 For Validate Contract Value
            var IsAlertContractValue = ValidateContractValue();
             //End of Added By Dipali V On 16th Jan 2024 For Validate Contract Value
            if (IsAlertContractValue != "" && (IsValidateContractValue == true || IsValidateContractValue == 1)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(IsAlertContractValue);
                //IsValidate = false;
                return false
            } else {
                var copyRFIIDValue = $("#txtEdtbleIR_ID_Filter").val();
                //GetRFIChecklistItems(copyRFIIDValue, 0);
                GetRFIChecklistItems(copyRFIIDValue, "Rejected", 0,0)
            }
        });

        /*
        Created By : Vishal Mane
        Created Date : 20/11/2023
        Purpose : To show IR/PIR check list items details 
        */
        $('#ViewChecklistEditIRBtn').on('click', function () {
            // 
            var copyRFIIDValue = $("#txtEdtbleIR_ID_Filter").val();
            //GetRFIChecklistItems(copyRFIIDValue, 1);
            GetRFIChecklistItems(copyRFIIDValue, "", 1,0)
        });

        /*
        Created By : Vishal Mane
        Created Date : 21/11/2023
        Purpose : To apply filter.
        */
        function ApplyFilter(FilterID) {

            clearAll();
            var ProjectID = $("#cboProject").val();
            var FilterFields = {
                FilterID: FilterID,
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(FilterFields)
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/ApplyDefaultFilter", param, false);
            if (Result == 'Applied Filter') {
                MyFilters(ProjectID, FilterID);
                alertify.set('notifier', 'position', 'top-right');
                //Added & commented by Ajit L on 21/12/2023
              <%-- alertify.error('<%=MyBase.GetResourceString("C_FilterApply")%>');--%>
                alertify.success('<%=MyBase.GetResourceString("C_FilterApply")%>');
                $("#PMProjectReviewClearAllFilter").show();
            }
            else {              
                alertify.set('notifier', 'position', 'top-right');             
                alertify.success('<%=MyBase.GetResourceString("C_FilterRemoved")%>');
                $("#PMProjectReviewClearAllFilter").hide();
            }



         
            clearAllFlag = 0;
        }

        /*
        Created By : Vishal Mane
        Created Date : 21/11/2023
        Purpose : To apply filter from Myfilter.
        */
        function AppliedFilter(FilterID) {
            var FilterFields = {
                FilterID: FilterID
            }
            var param = JSON.stringify(FilterFields)
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetDefaultWhereClase", param, false);
            var whereclause = Result[0]["WhereClause"];
            ApplyFilterData(whereclause);

        }


        /*
               Created By : Vishal Mane
               Created Date : 21/11/2023
               Purpose : To validate IR Aprover 
               */
        var IsValidateContractValue = 0;
        function ValidateIRApprover() {

            var Validate = 0;
            var Projectid = $("#cboProject").val();
            var Parameters = {
                ProjectID: Projectid
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateIRConfiguration", param, false);
            if (strResult != "") {
                IRApprover = strResult[0].IRApprover;
                IsValidateContractValue = strResult[0].IsValidateContractValue
                if (IRApprover == 0 || IRApprover == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_SetIRApprover")%>');
                    Validate = 1;
                }
            }
            return Validate
        }

        var clearAllFlag = 0;
        $("#PMProjectReviewClearAllFilter").click(function () {
            clearAllFlag = 1;

        });

        $('#AdvanceFilterIcon').on('click', function () {

            //var isNotExpanded = $(this).attr('aria-expanded') === 'true';           
            if (clearAllFlag == 1) {
                $("#PMProjectReviewClearAllFilter").hide();
            }
            else {
                $("#PMProjectReviewClearAllFilter").show();
            }
        });

        function PlotFilterProjetChange() {

            $("#Fil_Amount").val("");
            $("#Fil_IRID").val("");
            $("#Fil_RaisedOnDate").val("");
            $("#Fil_AmountCB").val("");
            $("#Fil_EquivAmount").val("");
            $("#txtFilterID").val("");
            $("#txtFilterName").val("");
            /* $("#cboProjectFilter").val(0);*/
            $("#cboIRPIRFilter").val(1);
            $("#cboCurrencyFilter").val(0);
            var textStatus = $("#cboStatusFilter").find(":selected").text();
            if (textStatus != "Select Status") {
                $("#cboStatusFilter").val(0);
                $("#cboStatusFilter").find(":selected").text("Select Status");
            }
            $("#cboTypeFilter").val(0);
            $(".selectpicker").selectpicker('refresh');
            var FilterProjectID = $("#cboProjectFilter").val();
            //if (FilterProjectID == 0 || FilterProjectID == null) {
            //    $("#cboProject").val(SessionProjectID);
            //} else {
            //    $("#cboProject").val(FilterProjectID);
            //}
            var FilterProjectCurrency = GetProjectCurrency(1);
            $("#cboCurrencyFilter").val(FilterProjectCurrency);

            //GetIRPIRList(FilterProjectID);
            $(".selectpicker").selectpicker('refresh');
        }

        function resizeSection() {
            var tblheight = $(window).height();
            $('.Tblwrapper').css({ 'height': tblheight - 200, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $("#projExpsEditblIRBtn").click(function () {
            $("#ProjExpensesModal").modal("show");
        });


        /*
             Created By : Ajit L
             Created Date : 28/11/2023
             Purpose : To Show History Popup of IR Item
        */

        function ShowItemHistory() {

            $('#RFIItemShowHistoryTable').dataTable().fnDestroy();
            var strHTML = "";
            //var ProjectID = $("#cboProject").val();
            var RFIID = G_RFIID;
            var RFIItemID = G_RFIItemId;
            // var UserId = SessionEmployeeId;
            var UserId = $("#cboItemModifiedBy").val();
            /*var FieldName = unescape($("#cboModifiedField").val());*/
            var FieldName = $("#cboItemModifiedField").val();

            FieldName = unescape(FieldName);

            if (UserId == 0) {
                UserId = "";
            }
            if (FieldName == 0) {
                FieldName = "";
            }
            //Field Name value changed by Ajit L on 15/12/2023 to handle placholder case Start
            if (FieldName == "Select Modified By") {
                FieldName = "";
            }
            if (FieldName == "Select Modified Field") {
                FieldName = "";
            }
            //Field Name value changed by Ajit L on 15/12/2023 to handle placholder case end

            if (FieldName == "null") {
                FieldName = "";
            }

            var RequestParameters = {
                //ProjectID: ProjectID,
                RFIID: RFIID,
                RFIItemId: RFIItemID,
                UserId: UserId,
                FieldName: FieldName
            }
            var param = JSON.stringify(RequestParameters);
            var ajaxResult = AJAXCallWithResult("/api/RFI_IR_PIR/ShowItemHistory", param, false);

            if (ajaxResult.length > 0) {
                // $("#ShowIrItemHistoryBtn").show();
                $.each(ajaxResult, function (index, obj) {

                    strHTML += '<tr>' +
                        '<td class="text-centre">' + obj.FieldName + '</td>' +
                        '<td class="text-centre">' + obj.ModifiedDate + '</td>' +
                        '<td class="text-centre">' + decodeURI(obj.Value) + '</td>' +
                        '<td class="text-centre">' + decodeURI(obj.NewValue) + '</td>' +
                        '<td class="text-centre">' + obj.ModifiedBy + '</td>' +
                        '</tr>';

                });

                $("#tbodyRFIItemShowHistory").html(strHTML);

            }
            //else {
            //    //$("#ShowIrItemHistoryBtn").hide();

            //    $("#tbodyRFIItemShowHistory").prop("colspan", 5);
            //    $("#tbodyRFIItemShowHistory").html("No data available in table");

            //}
            //Commented by Ajit L on 15/12/2023 to avoid double entry of ("No data available in table");
            $('#RFIItemShowHistoryTable').dataTable({
                // "scrollY": true,
                // "scrollX": true,
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
            });

            $(".selectpicker").selectpicker('refresh');
            return ajaxResult;
        }


        function GetItemModifiedField() {

            var strHTML = "";
            $("#cboItemModifiedField").html("");
            // var ProjectID = $("#cboProject").val();
            var RFIID = G_RFIID;
            var RFIItemID = G_RFIItemId;
            var RequestParameters = {
                //ProjectID: ProjectID,
                RFIID: RFIID,
                RFIItemID: RFIItemID
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetItemModifiedField", param, false);
            for (var i = 0; i < strResult.length; i++) {

                var obj = strResult[i];
                strHTML += '<option value=' + escape(obj.FieldName) + ' >' + obj.FieldName + '</option>';
            }
            $("#cboItemModifiedField").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }


        function GetItemModifiedBy() {

            var strHTML = "";
            $("#cboItemModifiedBy").html("");
            // var ProjectID = $("#cboProject").val();
            var RFIID = G_RFIID;
            var RFIItemID = G_RFIItemId;
            var RequestParameters = {
                //ProjectID: ProjectID,
                RFIID: RFIID,
                RFIItemID: RFIItemID
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetItemModifiedBy", param, false);
            for (var i = 0; i < strResult.length; i++) {

                var obj = strResult[i];
                strHTML += '<option value=' + obj.EmployeeId + ' >' + obj.ModifiedBy + '</option>';
            }
            $("#cboItemModifiedBy").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        /*
       Created By : Vishal Mane
       Created Date : 08/11/2023
       Purpose : To validate each empty field.
       */
        var IsValidateTextField;
        function ValidateTextField() {

            IsValidateTextField = 0;
            var FilterProject = $("#cboProjectFilter").val();
            var Amount = $("#Fil_Amount").val();
            var IRID = $("#Fil_IRID").val();
            var RaisedOnDate = $("#Fil_RaisedOnDate").val();
            var AmountCB = $("#Fil_AmountCB").val();
            var EquivAmount = $("#Fil_EquivAmount").val();
            var IRPIRFilter = $("#cboIRPIRFilter").val();
            var textStatus = $("#cboStatusFilter").val();
            var TypeFilter = $("#cboTypeFilter").val();

            if (FilterProject == 0 && Amount == "" && IRID == "" && RaisedOnDate == "" && AmountCB == "" && EquivAmount == ""
                && IRPIRFilter == 1 && textStatus == 0 && TypeFilter == 0) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Select at least one field');
                IsValidateTextField = 1;
                return IsValidateTextField;
            } else {
                return IsValidateTextField = 0
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 12/04/2023
        Purpose : To select and unselect all IR records when main checkbox is clicked
        */
        function selectAllRows() {
            var allPages = $("#IRPIR_Tbl").fnGetNodes();//added
            $(".chcktask ", allPages).prop('checked', true);
            // $(".IR_Check").prop("checked", true);             
        }
        function unselectAllRows() {

            var allPages = G_IRPIR_Tbl.fnGetNodes();//added
            $(".chcktask", allPages).prop("checked", false);
            // $(".IR_Check", allPages).prop("checked", false);
        }




        /*
        Created By : Vishal Mane
        Created Date : 06/12/2023
        Purpose : To show and hide 'Select Customer Address' link and 'Show Details' link
        */
        function ShowLink(flag) {
            if (flag == 0) {
                var CustomerID = $("#cboCustomer").val();
                if (CustomerID != 0) {
                    $("#linkCustAddress").show();
                    $("#linkContractdetails").show();
                    //Added by Vishal Mane on 29/12/23 to update Contact Person List according to change of customer
                    GetRFIContactPerson(0);
                    $("#txtEmail_Confirm").val('');
                    $("#txtContract").val('');
                    GetCreditDays(CustomerID);
                } else {
                    $("#linkCustAddress").hide();
                    $("#linkContractdetails").hide();
                    $("#txtEmail_Confirm").val('');
                    $("#txtContract").val('');
                    $("#txtCreditDays").val('');
                    GetRFIContactPerson(0);
                }
            } else {
                var CustomerID = $("#cboCustomerE").val();
                if (CustomerID != 0) {
                    $("#linkCustAddressE").show();
                    $("#linkContractdetailsE").show();
                    //Added by Vishal Mane on 29/12/23 to update Contact Person List according to change of customer
                    GetRFIContactPerson(1);
                    GetCreditDays(CustomerID);
                    $("#txtEmail_ConfirmE").val('');
                    $("#txtContractE").val('');
                } else {
                    $("#linkCustAddressE").hide();
                    $("#linkContractdetailsE").hide();
                    $("#txtContractE").val('');
                    $("#txtEmail_ConfirmE").val('');
                    $("#txtCreditDaysE").val('');
                    GetRFIContactPerson(1);
                }
            }

        }

        /*
    Created By : Ajit L
    Created Date : 20/12/2023
    Purpose : to bind placeholder by default in invoice no drop down in Print report 
    */
        // $("#cboInvoiceNumber").click(function () {
        function GetInvoiceNo(id) {

            $("#cboInvoiceNumber").val(0);
            $(".selectpicker").selectpicker('refresh');
        }
        // });


        $("#IRCheckAll").change(function () {

            var allPages = $('#IRPIR_Tbl').DataTable().rows().nodes();
            var checked = $(this).is(":checked");
            if (checked) {
                $('input[type="checkbox"]', allPages).prop('checked', true);
            } else {
                $('input[type="checkbox"]', allPages).prop('checked', false);
            }
        });





        function ChkUnChkHead() {


            var $table = $('#IRPIR_Tbl').DataTable();
            var $checkboxes = $('input[type="checkbox"]', $table.rows().nodes());
            var $headCheckbox = $(".chckHead");

            if ($checkboxes.length === $checkboxes.filter(':checked').length) {
                $headCheckbox.prop("checked", true);
            } else {
                $headCheckbox.prop("checked", false);
            }
        }

        var BillingCurrencyID = "";
        var BillingCurrencyCode = "";
        var BillingCurrencySymbol = "";
        var CorporateBaseCurrencyID = "";
        var CorporateBaseCurrencyCode = "";
        var CorporateBaseCurrencySymbol = "";
        var CompanyBaseCurrencyID = "";
        var CompanyBaseCurrencyCode = "";
        var CompanyBaseCurrencySymbol = "";

        function GetGlobalCurrencies(ProjectID) {
            //
            var ProjectID = $("#cboProject").val();
            var RequestParameters = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetGlobalCurrencies", param, false);
            //ProjectCurrency = Result;
            BillingCurrencyID = Result[0].BillingCurrencyID;
            BillingCurrencyCode = Result[0].BillingCurrencyCode;
            CorporateBaseCurrencyID = Result[0].CorporateBaseCurrencyID;
            CorporateBaseCurrencyCode = Result[0].CorporateBaseCurrencyCode;
            CompanyBaseCurrencyID = Result[0].CompanyBaseCurrencyID;
            CompanyBaseCurrencyCode = Result[0].CompanyBaseCurrencyCode;

            BillingCurrencySymbol = Result[0].BillingCurrencySymbol;
            CorporateBaseCurrencySymbol = Result[0].CorporateBaseCurrencySymbol;
            CompanyBaseCurrencySymbol = Result[0].CompanyBaseCurrencySymbol;
        }

        /*
        Created By : Vishal Mane
        Created Date : 29/12/2023
        Purpose : To get alert of 'Please select the customer' for contract
        */
        $("#txtContractDetail").click(function () {
            //
            var CustomerID = $("#cboCustomer").val();
            if (CustomerID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select the customer');
                $("#ContractDetailsModal").modal("hide");
                return false
            } else {
                $("#ContractDetailsModal").modal("show");
                GetContractDetails(0);
                GetRFIContractType();
            }
            
        });


        /*
        Created By : Vishal Mane
        Created Date : 29/12/2023
        Purpose : To get alert of 'Please select the customer' for contract
        */
        $("#txtContractDetailE").click(function () {
            //
            var CustomerID = $("#cboCustomerE").val();
            if (CustomerID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select the customer');
                $("#ContractDetailsModal").modal("hide");
                return false
            } else {
                $("#ContractDetailsModal").modal("show");
                GetContractDetails(0);
                GetRFIContractType();
            }
        });

        /*
        Created By : Vishal Mane
        Created Date : 29/12/2023
        Purpose : To get Credit Days of respective Customer
        */
        function GetCreditDays(CustomerID){
            var RequestParameters = {
                CustomerID: CustomerID
            }
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetCreditDays", param, false);
            if (GFlag == 0) {
                $("#txtCreditDays").val(Result);
            } else {
                $("#txtCreditDaysE").val(Result);
            }
        }



        var IsAlertContractValue = "";
        function ValidateContractValue() {
            var ContractTypeID = 0;
            if (GFlag == 0) {
                ContractTypeID = $("#TexthiddenContract").val();
                
            }
            else if (GFlag == 2) {
                ContractTypeID = $("#txthdnContract").val();
                
            }
            else {
                ContractTypeID = $("#TexthiddenContractE").val();

            }

            var Parameters = {
                ContractTypeID: encodeURI(ContractTypeID),
                //Commented and added By Riddhesh Patil on 17 Jan 2024
                //AdvisedIDs: encodeURI(AdvisedIds.toString())
                AdvisedIDs: encodeURI(RFIItemAdvisedIDs.toString()),
                RFIID: encodeURI($("#txthdnIRID").val()),
                //End of Commented and added By Riddhesh Patil on 17 Jan 2024
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/ValidateContractValues", param, false);
            IsAlertContractValue = strResult;
            IsValidateContractValue = 1;
            return IsAlertContractValue;
        }

    </script>

</body>

</html>
