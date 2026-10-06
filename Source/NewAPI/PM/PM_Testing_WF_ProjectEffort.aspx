<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Testing_WF_ProjectEffort.aspx.vb" Inherits="Whizible.PM_Testing_WF_ProjectEffort" %>

<!DOCTYPE html>
<html>
     <%CommonFunctions.General.PlotPageHeadTag("Project Effort")%>
<head>
     <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
     
    <!-- Tell the browser to be responsive to screen width -->
   <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
     <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
   
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/OverlayScrollbars.min.css">   

    <style type="text/css">
        .block_freeze {
            cursor: no-drop !important;
            opacity: 0.5;
        }
        .ui-datepicker {
            z-index: 9999 !important;
            width: max-content;
        }
        .bg_grayTD {
            background-color: #f9f9f9 !important;
        }

        .sticky_col {
            position: -webkit-sticky;
            position: sticky;
            background-color: white;
            z-index: 1;
            border: 1px solid #dee2e6;
        }

        .res_col {
             min-width: 250px; 
            width: 250px;
            /* min-width: 100px; */
            max-width: 600px;
            left: 0px;
            z-index: 1;

        }

        .Sr_col {
            width: 60px;
            min-width: 60px;
            max-width: 60px;
            left: 0px;
            z-index: 1;
        }

        .first_col {
            width: 80px;
            min-width: 80px;
            max-width: 80px;
            left: 0px;
            z-index: 1;
        }

        .Sr_sec_col {
            /* width: 250px; */
            width: 210px;
            min-width: 210px;
            max-width: 210px;
            left: 60px;
            z-index: 1;
        }

        .second_col {
            /* width: 250px; */
            width: 210px;
            min-width: 210px;
            max-width: 210px;
            left: 80px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .third_col {
            /* width: 100px; */
            width: 80px;
            min-width: 80px;
            max-width: 80px;
            left: 290px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .forth_col {
            /* width: 100px; */
            width: 85px;
            min-width: 85px;
            max-width: 85px;
            left: 370px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .text_small {
            font-size: 12px;
        }

        .lbtext_small {
            font-size: 12px;
        }

        .table-fixed-header thead tr th,
        .table thead tr th {
            font-weight: 400;
            background-color: #e7edf0;
            /* background-color: #f5f5f5; */
        }

        .table-fixed-header tbody tr td,
        .table tbody tr td {
            font-weight: 400;
            text-align: left;
            vertical-align: middle;
        }

        .table-fixed-header thead tr th,
        .table thead tr td {
            text-align: center;
            vertical-align: middle;
            /*background-color: #e7edf0;*/
            background-color: #fff;
        }

        /* label{
            font-weight:500;
        } */
        table>td {
            text-align: left !important;
        }

        .panel-body {
            padding: 3px;
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

        .form-group label {
            line-height: 1.2;
        }

        .custmodal .modal-content .modal-body {
            padding: 20px;
        }

        .custom_chckbox label:before {
            margin-right: 0;
        }

        .bootstrap-select .dropdown-menu {
            max-width: 100%;
            /* position: absolute !important;
            z-index: 7;
            min-height: 210px !important; */
        }

        .custom_chckbox input:checked+label:after {
            top: 1px;
        }

        .form-check-input:checked {
            background-color: #8b8b8b;
            border-color: #8b8b8b;
        }

        .form-check-input:focus {
            border-color: unset;
            outline: 0;
            box-shadow: none;
        }

        textarea::placeholder {
            font-size: 11px;
        }

        .logoImg {
            width: 85px;
            height: auto;
        }

        .greenbg {
            background-color: #0b6f6a;
            color: #FFF;
        }

        .detailPanel {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
        }

        .bgBlue {
            /* background-color: #304295; */
            background-color: #283b91;
            color: #FFF;
        }

        .bgGreen {
            /* background-color: #304295; */
            background-color: #0b6f6a;
            color: #FFF;
        }

        .textSky {
            color: #2fc2c2;
        }

        .checkIcn {
            font-size: 20px;
        }

        h6.pageTitle {
            color: #0b6f6a;
        }

        .sheetTitle {
            font-weight: 500;
        }

        .BG_Gray {
            background: #efefef !important;
        }

        .bg_Milestone {
            background-color: #f1f8ff !important;
            /* color: #124801 !important;*/
        }

        .allWorkflowTabsDiv {
            display: flex;
            justify-content: flex-start;
            flex-wrap: wrap;
        }

        /* .table-responsive {
            scrollbar-width: thin;
        } */
        .scrollTable{
            overflow: hidden !important;
        }
        .scrollTable:hover{
              overflow-y: auto !important;  
                overflow-x: hidden !important;
        }
        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 15px;
        }

        .slider:before {
            transform: translateX(-20px);
        }

        input:checked+.slider:before {
            transform: translateX(20px);
        }

        .tempTitle {
            font-size: 12px;
        }

        .inputWidth {
            width: 120px;
            margin: auto;
        }

        .bgGrey {
            background-color: #efefef !important;
        }

        .tblIcons>a {
            /* color: #1359a6 !important; */
            color: #414042 !important;
        }
        #DevAgile_MetricCarSec1 .stickyTblHeader {
            top: -8px;
        }
        .pro_RedBGscore {
            background-color: #ffcfcf !important;
            color: #d32222 !important;
            font-weight: 600;
            height: 19px;
            margin: 1px;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
        }
        .pro_GreenBGscore {
            background-color: #a7ff7e !important;
            color: #11a819 !important;
            font-weight: 600;
            height: 19px;
            margin: 1px;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
        }
        .WF_TopAccordianPanel .accordion-button {
            font-size: 12px;
        }
        .borderGrey{
            border: 1px solid #dee2e6;
        }
        .allWorkflowTabsDiv .nav {
            justify-content: flex-start;
        }
        .statusDiv {
            /* width: 110px; */
            width: 120px;
        }

        .disabled {
            /*pointer-events: none; */
            cursor: no-drop;                       
        }
        td.dataTables_empty {
            text-align: center !important;
        }

        .offcanvas {
            --bs-offcanvas-width: 82%!important;
        }

        .noRecordRow {
            padding: 5px;
            text-align: center;
            background-color: #FFF;
            height: 35px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed" id="ProjectEffortbody">
   <%If m_blnViewAccess = True Then%>
        <div class="container-fluid pt-1 pb-1 text-end graybg d-flex justify-content-between">
            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_PrEffort")%></h5>
        </div>
        <div class="bgwhite pageContent px-2">
            <!-- Main content -->
            <div class="content mt-0 pt-0">
                <div class="container-fluid mb-4 mt-3" id="ProjectDetlsExcel">
                    <div class="row py-2 mx-0">
                        <div class="col-sm-5">
                            <div class="row mb-2">
                                <label class="form-label col-sm-5 mt-1 text-end"><%=MyBase.GetResourceString("C_SelelctPr")%> </label>
                                <div class="col-sm-7">
                          

                               <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "Select 0, 'Select Project'",,, "class='selectpicker' data-live-search='true' data-dropup-auto='false' ",,,) %>

                                </div>
                            </div>
                            <div class="row">
                                <label class="form-label col-sm-5 mt-1 text-end"><%=MyBase.GetResourceString("C_Temp")%> : <br /><span
                                        class="text_bg">(Process Measurement Indicator)</span></label>
                            
                                <label class="form-label col-sm-7 mt-1" id="idTemplate"></label>
                            </div>
                        </div>
                        <div class="col-sm-4 d-flex align-items-center">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <span class="lbtext_small col-sm-6 text-end"><%=MyBase.GetResourceString("C_ClientName")%> :</span>
                                      
                                        <span class="text_small col-sm-6" id="idClient"></span>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="row">
                                        <span class="lbtext_small col-sm-6 text-end"><%=MyBase.GetResourceString("C_PrCode")%> :</span>
                                   
                                        <span class="text_small col-sm-6" id="idProjectCode"></span>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="row">
                                        <span class="lbtext_small col-sm-6 text-end"><%=MyBase.GetResourceString("C_PrType")%> :</span>
                                   
                                        <span class="text_small col-sm-6" id="idPractice"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                 <!-- Dev-Maintenance (Agile) Template Details Added by Gauri start here -->
                <div class="allMetricSec" id="MetricTemplateSec1">
                    <div class="allWorkflowTabsDiv">
                        <div class="row flex-1">
                            <div class="col-sm-6">
                                <ul class="nav nav-tabs mb-2 pe-3" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="DevAgile_TabProjectEffort" data-bs-toggle="tab"
                                            data-bs-target="#DevAgile_ProjectEffortTab" type="button" role="tab"
                                            aria-selected="false" tabindex="-1">
                                            <%=MyBase.GetResourceString("C_PrEffort")%>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="tab-content mt-2">
                        <div id="DevAgile_ProjectEffortTab" class="tab-pane active" role="tabpanel">
                            <div class="MetricTblPanel1" id="">
                                <div class="scrollTable table-responsive mb-3" id="DevAgile_PE_ScrollTable1">
                                
                                    <table id="DevAgile_ProjectEffortTbl1"
                                        class="table table-fixed-header borderGrey ProjectEffortTbl ExcelUploadTbl"
                                        style="width:100%;">
                                        <tbody class="stickyTblHeader" id="tbodyHeader">
                                          
                                        </tbody>

                                        <tbody id="tbodyProjectEffort">
                                          
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                           
                             <div class="row mb-2">
                                    <div class="col-sm-6 ps-4">
                                        <div class="ExcelTitle font-weight-500"><%=MyBase.GetResourceString("CRelDetail")%> - </div>
                                    </div>
                                    <div class="col-sm-6 text-end">
                                  

                                   <%If m_blnAddAccess = True Then%>
                                        <a class="btn borderbtn AddBtn me-2" id="addDevWF_ReleaseDetlsBtn" data-bs-toggle="modal" onclick="ShowRelPopUp()"> 
                                            <i class="fa fa-plus" data-bs-toggle="tooltip" data-bs-original-title="Add"></i>&nbsp;<%=MyBase.GetResourceString("C_Add")%> 
                                        </a>
                                        <%Else %>
                                   
                                    <%End If %>
                                       <div id="divNote"> <small><b> <span>Note:&nbsp </span><span id="txtNote" class=""></span></b></small></div>

                                    </div>
                                </div>
                             <div class="scrollTable table-responsive" id="DevWF_PE_ScrollTable2">
                                    <table id="DevWF_ProjectEffortTbl2"
                                        class="table table-color-header table-fixed-header borderGrey ExcelUploadTbl"
                                        style="width:100%;">

                                            <thead class="stickyTblHeader">
                                            <tr>

                                                <td class="sticky_col res_col bg_Milestone text-center"><%=MyBase.GetResourceString("C_RelName")%></td>
                                                <td class=" text-center"><%=MyBase.GetResourceString("C_PlStDate")%></td>
                                                <td class=" text-center"><%=MyBase.GetResourceString("C_PlEndDate")%></td>
                                                <td class=" text-center"><%=MyBase.GetResourceString("C_ActStDate")%></td>
                                                <td class=" text-center"><%=MyBase.GetResourceString("C_ActEndDate")%></td>
                                                <td class="colSmall text-center"></td>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyReleasetable">
                                                                                     
                                        </tbody>
                                    </table>
                                </div>
                           

                        </div>
                    </div>
                </div>
                <!-- Dev-Maintenance (Agile) Template Details Added by Gauri end here -->

                    <!-- offcanvas Section Start here Comment Added By Gauri-->
                    <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
                        id="offcanvas_ShowMetric_History">
                        <div class="offcanvas-body">
                            <div class="container-fluid py-2 graybg mb-2">
                                <div class="row align-items-center">
                                    <div class="col-sm-12">
                                        <div class="d-flex align-items-center font-weight-600">
                                              <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_PrEffortHistory")%></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="showHistorySec">
                                <div class="row">
                                    <div class="col-sm-12 text-end">
                                        <button class="btn borderbtn" type="button" id="closeBtn"
                                            data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip"
                                            title="Close">
                                            <%=MyBase.GetResourceString("C_Close")%>
                                        </button>
                                    </div>
                                </div>

                                <div class="showHistoryFltr">
                                    <div class="row d-flex justify-content-center my-3">
                                        <div class="col-sm-5">
                                            <div class="row">
                                                <div class="col-sm-6 d-flex justify-content-end">
                                                    <label><%=MyBase.GetResourceString("C_MfdField")%> : </label>
                                                </div>
                                                <div class="col-sm-6">
                                                    <select class="selectpicker" data-live-search="true"
                                                        id="ModifiedHisFieldInput">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <div class="row">
                                                <div class="col-sm-6 d-flex justify-content-end">
                                                    <label><%=MyBase.GetResourceString("C_MfdBy")%> : </label>
                                                </div>
                                                <div class="col-sm-6">
                                                    <select class="selectpicker" data-live-search="true"
                                                        id="ModifiedHisByInput">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="showHistoryContent">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table id="MetricShowHistoryTable" class="table" style="width:100%;">
                                                <thead>
                                                    <tr>                                                      
                                                        <th class="text-start"><%=MyBase.GetResourceString("C_MfdField")%></th>
                                                        
                                                        <th class="text-start"><%=MyBase.GetResourceString("C_SprintMsName")%></th> <%--Added & commented by Ajit L on 02/09/2024--%>
                                                       <%-- <th class="text-start"><%=MyBase.GetResourceString("C_Milestones")%></th>--%>

                                                        <th class="text-start"><%=MyBase.GetResourceString("C_OldValue")%></th>
                                                        <th class="text-start"><%=MyBase.GetResourceString("C_NewValue")%></th>
                                                        <th class="text-start"><%=MyBase.GetResourceString("C_MfdDate")%></th>
                                                        <th class="text-start"><%=MyBase.GetResourceString("C_MfdBy")%></th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodyMetricShowHistoryTable">                                        
                                                </tbody>
                                            </table>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- offcanvas Section End here Comment Added By Gauri-->

                 
                       <!-- Add/Edit Release Details Modal start here-->
                <div class="modal custmodal fade" id="EditReleaseDetlsModal" tabindex="-1" role="dialog" aria-hidden="true" data-bs-backdrop="static">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%=MyBase.GetResourceString("CRelDetail")%></h5>
                                <button type="button" class="close" data-bs-dismiss="modal">
                                    <span aria-hidden="true" style="font-size: 20px !important;">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-sm-12">
                                             <div class="row mb-3" id="divNoteEdit">
                                                  <small><b><span>Note:&nbsp </span><span id="txtNoteEdit"></span></b></small>
                                                 </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-4 col-4 text-end pe-0">
                                                    <label for="ReleaseNameInput" class="form-label required"><%=MyBase.GetResourceString("C_RelName")%>: </label>
                                                </div>
                                                <div class="col-sm-6 col-6">
                                                
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("ReleaseNameInput", "ReleaseNameInput", "form-control",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='90'",,, True,,,, True) %>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-4 col-4 text-end pe-0">
                                                    <label for="ReleasePlannedStartDate" class="form-label required"><%=MyBase.GetResourceString("C_PlStDate")%>: </label>
                                                </div>
                                                <div class="col-sm-6 col-6">
                                                    <div class="input-group">
                                                    
                                                      <% CommonFunctions.HTMLControls.DrawTextBox("ReleasePlannedStartDate", "ReleasePlannedStartDate", "form-control",,,,,,,,,, "readonly onpaste='return false' autocomplete ='off'",,, True,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button">
                                                                <i class="fas fa-calendar-alt"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-4 col-4 text-end pe-0">
                                                    <label for="ReleasePlannedEndDate" class="form-label required"><%=MyBase.GetResourceString("C_PlEndDate")%>: </label>
                                                </div>
                                                <div class="col-sm-6 col-6">
                                                    <div class="input-group">
                                                  
                                                          <% CommonFunctions.HTMLControls.DrawTextBox("ReleasePlannedEndDate", "ReleasePlannedEndDate", "form-control",,,,,,,,,, "readonly onpaste='return false' autocomplete ='off'",,, True,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button">
                                                                <i class="fas fa-calendar-alt"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-4 col-4 text-end pe-0">
                                                    <label for="ReleaseActualStartDate" class="form-label required"><%=MyBase.GetResourceString("C_ActStDate")%>: </label>
                                                </div>
                                                <div class="col-sm-6 col-6">
                                                    <div class="input-group">
                                               
                                                             <% CommonFunctions.HTMLControls.DrawTextBox("ReleaseActualStartDate", "ReleaseActualStartDate", "form-control",,,,,,,,,, "readonly onpaste='return false' autocomplete ='off'",,, True,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button">
                                                                <i class="fas fa-calendar-alt"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-4 col-4 text-end pe-0">
                                                    <label for="ReleaseActualEndDate" class="form-label required"><%=MyBase.GetResourceString("C_ActEndDate")%>: </label>
                                                </div>
                                                <div class="col-sm-6 col-6">
                                                    <div class="input-group">
                                                   
                                                              <% CommonFunctions.HTMLControls.DrawTextBox("ReleaseActualEndDate", "ReleaseActualEndDate", "form-control",,,,,,,,,, "readonly onpaste='return false' autocomplete ='off'",,, True,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button">
                                                                <i class="fas fa-calendar-alt"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col-sm-4 col-4 text-end pe-0">
                                                    <label for="cboMilestoneName" class="form-label"><%=MyBase.GetResourceString("C_Milestones")%>: </label>
                                                </div>
                                                <div class="col-sm-6 col-6">
                                                    <div class="input-group">
                                                   
                                                         <%-- <%CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneName", "Select 0, 'Milestone Name'",,, "class='selectpicker' data-live-search='true' data-dropup-auto='false' multiple ",,,) %>--%>
                                                          <%CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneName", "Select 0, 'Milestone Name'",,, "class='selectpicker' data-live-search='true' data-dropup-auto='false' multiple onchange='ChangeMilestone();' ",,,) %>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>

                                <div class="btnrow text-center">

                                 <%--   <%If m_blnAddAccess = True Then%>--%>
                                    <button id="saveReleaseBtn" class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveRelease()"><%=MyBase.GetResourceString("C_Save")%></button>
                                    <%--<%Else %>
                                   
                                    <%End If %>--%>
                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn" data-bs-toggle="tooltip" title="Cancel" id="IR_statHisCancelBtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                                </div>
                                <div class="clearfix"></div>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- Add/Edit Release Details Modal End here-->

                </div>
            </div>
        </div>

        <div class="clearfix"></div>


        <div id="ConfirmationModal" class="modal fade custmodal" role="dialog" aria-hidden="false" data-bs-backdrop="static">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title"><i class="far fa-check-circle confirmIcn me-2"></i><%= MyBase.GetResourceString("C_Confirmation") %></h4>
                </div>

                <div class="modal-body">
                    <p class="text-center" id="idConfirmationMsg"></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_No") %></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal" onclick="ReleaseInfo(1);"><%= MyBase.GetResourceString("C_Yes") %></button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>


    </div>


     <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess")%></p>
        </div>
    </div>
    <%End If %>
    <!-- REQUIRED JS SCRIPTS -->
     <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    
   <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>


    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
     <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script>

        var strUrl_Cust = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';

        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var SessionProjectID = '<%= Session("intProjectID") %>';
        var UserId = '<%= Session("intUserId") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var G_TemplateID = '';

        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();

            $("#sendApprovalSec").hide();
            $('.nav-link').click(function (e) {
                var targetTab = $(this).text().trim();
                if (targetTab === 'Derived Metric') {
                    $('#sendApprovalSec').removeClass("d-none");
                    $('#sendApprovalSec').addClass("d-block");
                } else {
                    // $('#sendApprovalSec').css('display', 'none !important');
                    $('#sendApprovalSec').addClass("d-none");
                    $('#sendApprovalSec').removeClass("d-block");
                }
            });

            // Truncate the text and add the popover trigger
            $('td.hideTblTxt').each(function () {
                var text = $(this).text();
                if (text.length > 12) {
                    var truncatedText = text.substring(0, 12);
                    var remainingText = text.substring(12);
                    var popoverTrigger = '<span class="more" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="' + text + '">' + truncatedText + '...</span>';
                    $(this).html(popoverTrigger + '<span class="full-text" style="display:none;">' + text + '</span>');
                }
            });

            $('[data-bs-toggle="popover"]').popover();

            const myCollapsible = document.getElementById('WF_ApprovalDtlsAcc')
            myCollapsible.addEventListener('hidden.bs.collapse', event => {
                $(".WF_ApprovalDtls_Info").hide();
                $(".WF_ApprovalDtls_Editable").show();
            })
        });

        $(".WF_ApprovalDtls_Info").hide();

        function EditApprovalDetls() {
            $("#WF_ApprovalAddDtlsTab").collapse('show');
            $(".WF_ApprovalDtls_Info").hide();
            $(".WF_ApprovalDtls_Editable").show();
        }

        function EditEdtApprovalDetls() {
            $("#WF_ApprovalAddDtlsTab").collapse('show');
            $(".WF_ApprovalDtls_Editable").hide();
            $(".WF_ApprovalDtls_Info").show();
        }

        function EditApprHisDetls() {
            $("#WF_ApprovalAddDtlsTab").collapse('show');

            $(".offcanvas-body").animate(
                {
                    scrollTop: $(".WF_ApprovalHistoryInfo").offset().top - 60,
                },
                "3000"
            );
        }

        //datepicker
        $('#ReleasePlannedStartDate, #ReleasePlannedEndDate, #ReleaseActualStartDate, #ReleaseActualEndDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });


   

        var EditAccess =''
        $(document).ready(function () {
           
           // $('.selectpicker').selectpicker();

            //$('#cboMilestoneName').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
            //    if ($(this).val().length === 0) {
            //        $(this).find('option:disabled').prop('selected', true);
            //    } else {
            //        $(this).find('option:disabled').prop('selected', false);
            //    }
            //    $(this).selectpicker('refresh');
            //});

            //$('#cboMilestoneName').find('option:disabled').prop('selected', true);


            //$('#cboMilestoneName').selectpicker('refresh');
            $(this).scrollTop(0);

            CheckCopyIsEnableorNot();
            GetProjectDetails(SessionProjectID);
            GetTemplatewiseAccessibleProject();
            $('#cboProjectName').val(SessionProjectID);

            BindPlaceholder("cboprojNameFilter", "Project");
            $(".selectpicker").selectpicker('refresh');
            GetRoleDetails();
      
            PlotEffortDetails();
            RefreshList();
            GetReleaseDetails();
            if (RoleDescription != "PM") {
                $("#divNote").show();
                $("#addDevWF_ReleaseDetlsBtn").hide();
                $("#txtNote").text('Please Configure Project Manager at Project level');
               
            }
            else {
                $("#divNote").hide();
                $("#addDevWF_ReleaseDetlsBtn").show();
                $("#txtNote").text('');
            }
        });

        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        function refreshPage() {
            window.location.reload();
        }

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
            $("#MetricShowHistoryTable_wrapper .dataTables_scroll").css({ height: tblheight - 280, "overflow-y": "auto" });
            $(".MetricTblPanel2 .scrollTable").css({ height: tblheight - 230, "overflow-y": "auto" });

            $("#DevWF_PE_ScrollTable1").css({ height: tblheight - 280, "overflow-y": "auto" });
            $("#DevWF_PE_ScrollTable2").css({ height: tblheight - 230, "overflow-y": "auto" });
           
        }

        $(window).on("load resize scroll", function () {
            resizeSection();
        });


        $(document).on('click', 'a.disabled', function (e) {
            e.preventDefault();
            return false;
        });


        //Get Project Details
        var ClientName = '';
        var ProjectCode = '';
        var Practice = '';
        var TemplateName = '';
        var DropdownProJID = '';
        var ProjectStartDate = '';
        var ProjectEndDate = '';
        function GetProjectDetails(ProjectID) {          
            var Parameter = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(Parameter);

            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetProjectDetails", param, false);
            if (strResult != null && strResult != undefined && strResult != "") {
             
                for (var i = 0; i < strResult.length; i++) {
                    G_TemplateID = strResult[i].PMIID;
                    ClientName = strResult[i].CustomerName;
                    ProjectCode = strResult[i].ProjectCode;
                    Practice = strResult[i].ProjectType;
                    TemplateName = strResult[i].TemplateName;               
                    ProjectStartDate = strResult[i].ExpectedStartDate;
                    ProjectEndDate = strResult[i].ExpectedEndDate;
                }
                $('#idTemplate').text(TemplateName);
                $('#idClient').text(ClientName);
                $('#idProjectCode').text(ProjectCode);
                $('#idPractice').text(Practice);
            }
        }

        //Get Templatewise Accessible Project    
        function GetTemplatewiseAccessibleProject() {
            var Parameter = {
                TemplateID: G_TemplateID,
                UserID: UserId,
                LoginType: LoginType
            }
            var param = JSON.stringify(Parameter);

            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetTemplatewiseAccessibleProject", param, false);
            if (strResult != null && strResult != undefined && strResult != "") {
                var strHTML = '';
                for (var i = 0; i < strResult.length; i++) {
                    var ListComponent = strResult[i];
                    strHTML += ('<option value="' + ListComponent.ProjectID + '">' + ListComponent.ProjectName + '</option>');                   
                }             
                $("#cboProjectName").html('');
                $("#cboProjectName").html(strHTML);
                $(".selectpicker").selectpicker('refresh');
            }
        }

        function BindPlaceholder(ID, Caption) {    
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);
                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }

        $('#cboProjectName').on('change', function () {
         
            SaveOnclick = 0;
            DropdownProJID = $('#cboProjectName').val();
            GetProjectDetails(DropdownProJID);
            GetRoleDetails();
        
            PlotEffortDetails();
            RefreshList();
            GetReleaseDetails();
        });

        var SelResourceId = '';
        var SelSprintId = '';
        var HisIds = [];
        var CopyIds = [];
        var EditIds = [];
        var HisMSIDs = [];
        var EnableFlag = 0;
        var ClickedColumn = '';

        var Cflag = 0;
        function PlotEffortDetails() {
           
            $("#tbodyHeader").html('');
            $("#tbodyHeader").removeClass("noRecordRow");
            $("#tbodyProjectEffort").html('');
            var columnIndex = '';
           
            var ProjectId = $('#cboProjectName').val();
            var TemplateId = G_TemplateID;

            var Parameter = {
                ProjectID: ProjectId,
                TemplateID: TemplateId
            };
            var param = JSON.stringify(Parameter);

            var strResultD = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetProjectEffortDetails", param, false);

            if (strResultD != null && strResultD != undefined && strResultD != "") {
                var strHTML = "";

                var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetProjectMileStoneList", param, false);

                // Filter out the placeholder object before sorting
                strResult = strResult.filter(milestone => milestone.MilestoneId !== 0 && milestone.MilestoneOrder !== 0 && milestone.PlannedCompletionDate !== null);

                // Sort milestones by PlannedCompletionDate and MilestoneOrder
                strResult.sort((a, b) => {
                    if (a.PlannedCompletionDate === b.PlannedCompletionDate) {
                        return a.MilestoneOrder - b.MilestoneOrder;
                    }
                    return new Date(a.PlannedCompletionDate) - new Date(b.PlannedCompletionDate);
                });

                strHTML += "<tr><td class='col-sm-1 sticky_col res_col bg_Milestone text-start'>Resources Details</td>";

                var milestoneDateMap = {};

                // Group milestones by PlannedCompletionDate
                strResult.forEach(milestone => {
                    if (!milestoneDateMap[milestone.PlannedCompletionDate]) {
                        milestoneDateMap[milestone.PlannedCompletionDate] = [];
                    }
                    milestoneDateMap[milestone.PlannedCompletionDate].push(milestone);
                });

                var PlottedMilestoneSequence = [];
                for (var date in milestoneDateMap) {
                    var milestones = milestoneDateMap[date];
                    milestones.forEach((milestone, index) => {
                       <%If m_blnEditAccess = True Then%>
                            if (RoleDescription == "PM") {
                              
                                var MilestoneName = milestone.Milestone;
                                var MilestoneID = milestone.MilestoneId;

                                //Added & Commented on 24/07/2024 for Performance
                                var IsFreezed = milestone.IsFreezed;
                               // var IsFreezed = GetDerivedMetricIsFreezed(MilestoneID);
                                //Added & Commented on 24/07/2024 for Performance

                                if (IsFreezed == 1) {
                                   
                                    strHTML += `<td id='${MilestoneID}' class="hideTblTxt sprintCol text-center"><i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i><span>${MilestoneName}</span></td>`;

                                } else {
                                    strHTML += "<td class='sprintCol text-center'>";
                                    strHTML += `<select class='selectpicker selectSprintInput' data-live-search='true' data-order="${index + 1}" onchange='SwapMilestone(this, ${index + 1})'>`;

                                    // Placeholder option
                                    strHTML += `<option value="" disabled${!milestones.some(m => m.MilestoneId === milestone.MilestoneId) ? " selected" : ""}>Select Milestone</option>`;

                                    milestones.forEach((m, idx) => {
                                        var selected = m.MilestoneId === milestone.MilestoneId ? " selected" : "";
                                        strHTML += `<option id="option_${m.MilestoneId}" value="${m.MilestoneId}" data-order="${idx + 1}" ${selected}>${m.Milestone}</option>`;
                                    });

                                    strHTML += "</select></td>";
                                }




                            } else {
                                   strHTML += "<td class='sprintCol text-center'>";
                                   strHTML += `<select class='selectpicker selectSprintInput' data-bs-toggle="tooltip" title="Only Project Manager can change the order of milestones" data-live-search='true' data-order="${index + 1}" disabled>`;

                                   // Placeholder option
                                   strHTML += `<option value="" disabled${!milestones.some(m => m.MilestoneId === milestone.MilestoneId) ? " selected" : ""}>Select Milestone</option>`;

                                   milestones.forEach((m, idx) => {
                                       var selected = m.MilestoneId === milestone.MilestoneId ? " selected" : "";
                                       strHTML += `<option id="option_${m.MilestoneId}" value="${m.MilestoneId}" data-order="${idx + 1}" ${selected}>${m.Milestone}</option>`;
                                   });

                                   strHTML += "</select></td>";
                            }

                        <%Else %>                       

                                strHTML += "<td class='sprintCol text-center'>";
                                strHTML += `<select class='selectpicker selectSprintInput' data-bs-toggle="tooltip" title="You don't have edit access" data-live-search='true' data-order="${index + 1}" disabled>`;

                                // Placeholder option
                                strHTML += `<option value="" disabled${!milestones.some(m => m.MilestoneId === milestone.MilestoneId) ? " selected" : ""}>Select Milestone</option>`;

                                milestones.forEach((m, idx) => {
                                    var selected = m.MilestoneId === milestone.MilestoneId ? " selected" : "";
                                    strHTML += `<option id="option_${m.MilestoneId}" value="${m.MilestoneId}" data-order="${idx + 1}" ${selected}>${m.Milestone}</option>`;
                                });

                                strHTML += "</select></td>";

                        <%End If%>


                        columnIndex++;
                        
                        //Commented & Added on 24/07/2024
                        //PlottedMilestoneSequence.push(milestone.MilestoneId);
                       
                        PlottedMilestoneSequence.push({
                        
                            MilestoneId: milestone.MilestoneId,
                            IsFreezed: milestone.IsFreezed,
                            IsCopied: milestone.IsCopied
                        });
                         //Commented & Added on 24/07/2024
                    });
                }

                if (Object.keys(milestoneDateMap).length > 1) {
                    strHTML +=
                        ` <td class="colSmall">
                        <div class="yearDiv d-flex justify-content-center">
                            <div>
                                <i class="far fa-caret-square-left Excel_PrevMonthBtn"
                                    data-bs-toggle="tooltip" title="Previous"
                                    id="DevAgilePE_PrevMonthBtn"></i>
                                <i class="far fa-caret-square-right Excel_NextMonthBtn"
                                    data-bs-toggle="tooltip" title="Next"
                                    id="DevAgilePE_NextMonthBtn"></i>
                            </div>
                        </div>
                    </td>`;
                }

                strHTML += "</tr>";

                strHTML += "<tr>";
                strHTML += "<td class='sticky_col first_col'></td>";

                if (Object.keys(milestoneDateMap).length >= 1) {
                
                    // Commented & Added on 24/07/2024
                    //var CurrentMilestoneId = PlottedMilestoneSequence[0];
                    var CurrentMilestoneId = PlottedMilestoneSequence[0].MilestoneId;
                    var IsFreezed = PlottedMilestoneSequence[0].IsFreezed;
                  
                     // Commented & Added on 24/07/2024



                    ShowHistory(0, CurrentMilestoneId);
                    // var IsFreezed = GetDerivedMetricIsFreezed(CurrentMilestoneId);  //// Commented on 24/07/2024
                   

                  <%If m_blnEditAccess = True Then%>
                    if (RoleDescription == "PM") {
                        if (IsFreezed == 1) {
                            strHTML += `<td class="sprintCol">
                                        <div class="td_iconsDiv1 d-flex justify-content-center gap-4">
                                            <div class="form-group d-flex justify-content-start gap-2">
                                                <label>Edit</label>
                                                <label class="switch" data-bs-toggle="tooltip" title="Milestone is freezed so you can not edit">
                                                    <input type="checkbox" class="disabled" id="enableEditDevAgilePE_Btn1" disabled>
                                                    <span class="slider disabled"></span>
                                                </label>
                                            </div>
                                            <div class="tblIcons d-flex gap-2">
                                                <a href="javascript:;" class="textUndrln" id="showHisDevAgilePE_Btn1"  data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ShowMetric_History" onclick="ShowHistory(0,'${CurrentMilestoneId}')">
                                                    <i class="fas fa-history" id="ShowHis1" data-bs-toggle="tooltip" title="Show History"></i>
                                                    </a>
                                                </div>
                                        </div>
                                    </td>`;
                        } else {

                                 strHTML +=`<td class="sprintCol">
                                        <div class="td_iconsDiv1 d-flex justify-content-center gap-4">
                                            <div class="form-group d-flex justify-content-start gap-2">
                                                <label>Edit</label>
                                                <label class="switch" data-bs-toggle="tooltip" title="Enable Edit"  onchange=Slider('enableEditDevAgilePE_Btn1')>
                                                    <input type="checkbox" id="enableEditDevAgilePE_Btn1" data-bs-toggle="tooltip" title="Enable Edit">
                                                    <span class="slider"></span>
                                                </label>
                                            </div>
                                            <div class="tblIcons d-flex gap-2">
                                                <a href="javascript:;" class="textUndrln" id="showHisDevAgilePE_Btn1"  data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ShowMetric_History" onclick="ShowHistory(0,'${CurrentMilestoneId}')">
                                                    <i class="fas fa-history" id="ShowHis1" data-bs-toggle="tooltip" title="Show History"></i>
                                                    </a>
                                                </div>
                                        </div>
                                    </td>`;

                        }

                    } else {
                        strHTML += `<td class="sprintCol">
                                        <div class="td_iconsDiv1 d-flex justify-content-center gap-4">
                                            <div class="form-group d-flex justify-content-start gap-2">
                                                <label>Edit</label>
                                                <label class="switch" data-bs-toggle="tooltip" title="Please configure project manager at project level">
                                                    <input type="checkbox" id="enableEditDevAgilePE_Btn1" data-bs-toggle="tooltip" title="Please configure project manager at project level" disabled>
                                                    <span class="slider"></span>
                                                </label>
                                            </div>
                                            <div class="tblIcons d-flex gap-2">
                                                <a href="javascript:;" class="textUndrln" id="showHisDevAgilePE_Btn1" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ShowMetric_History" onclick="ShowHistory(0,'${CurrentMilestoneId}')">
                                                    <i class="fas fa-history" id="ShowHis1" data-bs-toggle="tooltip" title="Show History"></i>
                                                    </a>
                                                </div>
                                        </div>
                                    </td>`;
                        }

                    <%Else %>
                            strHTML +=
                            `<td class="sprintCol">
                                        <div class="td_iconsDiv1 d-flex justify-content-center gap-4">
                                            <div class="form-group d-flex justify-content-start gap-2">
                                                <label>Edit</label>
                                                <label class="switch" data-bs-toggle="tooltip" title="You don't have edit access">
                                                    <input type="checkbox" id="enableEditDevAgilePE_Btn1" data-bs-toggle="tooltip" title="You don't have edit access" disabled>
                                                    <span class="slider"></span>
                                                </label>
                                            </div>
                                            <div class="tblIcons d-flex gap-2">
                                                <a href="javascript:;" class="textUndrln" id="showHisDevAgilePE_Btn1" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ShowMetric_History" onclick="ShowHistory(0,'${CurrentMilestoneId}')">
                                                    <i class="fas fa-history" id="ShowHis1" data-bs-toggle="tooltip" title="Show History"></i>
                                                    </a>
                                                </div>
                                        </div>
                                    </td>`;

                    <%End If%>
                                      
                }

                for (var i = 0; i < columnIndex - 1; i++) {
                   
                    //Commented & Added on 24/07/2024
                    //var OldMilestoneId = PlottedMilestoneSequence[i];
                    //var CurrentMilestoneId = PlottedMilestoneSequence[i + 1];
                    var OldMilestoneId = PlottedMilestoneSequence[i].MilestoneId;
                    var CurrentMilestoneId = PlottedMilestoneSequence[i + 1].MilestoneId;
                    //End of Commented & Added on 24/07/2024

                    var dynamicButtonId = 'showHisDevAgilePE_Btn' + CurrentMilestoneId;
                    var dynamicCopybtn = 'CopyExcelDevAgilePE_Btn' + CurrentMilestoneId;
                    var dynamicEditbtn = 'enableEditDevAgilePE' + CurrentMilestoneId;

                    //Commented & Added on 24/07/2024
                    //var IsFreezed = GetDerivedMetricIsFreezed(CurrentMilestoneId);
                    var IsFreezed = PlottedMilestoneSequence[i + 1].IsFreezed;
                    //End of Commented & Added on 24/07/2024

                   //Commented & Added by Ajit 29/07/2024
                    var IsCopied = PlottedMilestoneSequence[i + 1].IsCopied;
                    //var IsCopied = CopyStatus(CurrentMilestoneId);
                    //Commented & Added by Ajit 29/07/2024

                 <%If m_blnEditAccess = True Then%>
                    if (RoleDescription == "PM") {
                        if (IsFreezed == 1) {
                            strHTML +=
                                '<td class="sprintCol">' +
                                '<div class="td_iconsDiv1 d-flex justify-content-center gap-4">' +
                                '<div class="form-group d-flex justify-content-start gap-2">' +
                                '<label>Edit</label>' +
                                '<label class="switch" data-bs-toggle="tooltip" title="Milestone is freezed so you can not edit">' +
                                '<input type="checkbox" class="disabled" id="' + dynamicEditbtn + '" disabled>' +
                                '<span class="slider disabled"></span>' +
                                '</label>' +
                                '</div>' +
                                '<div class="tblIcons  d-flex gap-2">';

                        } else {
                            strHTML +=
                                '<td class="sprintCol">' +
                                '<div class="td_iconsDiv1 d-flex justify-content-center gap-4">' +
                                '<div class="form-group d-flex justify-content-start gap-2">' +
                                '<label>Edit</label>' +
                                '<label class="switch" data-bs-toggle="tooltip" title="Enable Edit" onchange="Slider(&quot;' + dynamicEditbtn + ' &quot;,\'' + OldMilestoneId + '\', \'' + CurrentMilestoneId + '\', \'' + dynamicCopybtn + '\')">' +
                                '<input type="checkbox" id="' + dynamicEditbtn + '">' +
                                '<span class="slider"></span>' +
                                '</label>' +
                                '</div>' +
                                '<div class="tblIcons  d-flex gap-2">';

                            //if (IsCopied == false) {
                            if (IsCopied == 0) {
                                strHTML +=
                                    '<a href="javascript:;" class="textUndrln copyfield " id="' + dynamicCopybtn + '" data-bs-toggle="tooltip" title="Copy from previous milestone " data-milestone-id="' + CurrentMilestoneId + '" onclick="CopyPrevMilestone(\'' + dynamicEditbtn + '\',\'' + OldMilestoneId + '\', \'' + CurrentMilestoneId + '\')" disabled>' +
                                    '<i class="far fa-copy"></i>' +
                                    '</a>';



                            } else {
                                strHTML +=
                                    '<a href="javascript:;" class="textUndrln copyfield disabled" id="' + dynamicCopybtn + '" data-bs-toggle="tooltip" title="Copied" data-milestone-id="' + CurrentMilestoneId + '" disabled>' +
                                    '<i class="far fa-copy"></i>' +
                                    '</a>';
                            }
                        }

                        strHTML +=
                            '<a href="javascript:;" class="textUndrln " id="' + dynamicButtonId + '" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ShowMetric_History" onclick="ShowHistory(0,\'' + CurrentMilestoneId + '\')">' +
                            '<i class="fas fa-history" data-bs-toggle="tooltip" title="Show History"></i>' +
                            '</a>';

                        strHTML +=
                            '</div>' +
                            '</div>' +
                            '</td>';


                    } else {
                        strHTML += `
                            <td class="sprintCol">
                                <div class="td_iconsDiv1 d-flex justify-content-center gap-4">
                                    <div class="form-group d-flex justify-content-start gap-2">
                                        <label>Edit</label>
                                        <label class="switch" data-bs-toggle="tooltip" title="Please configure project manager at project level">
                                            <input type="checkbox" id='${dynamicEditbtn}' disabled>
                                            <span class="slider"></span>
                                        </label>
                                    </div>
                                    <div class="tblIcons d-flex gap-2">
                                            <a href="javascript:;" class="textUndrln disabled" id='${dynamicCopybtn}' data-bs-toggle="tooltip" title="Please configure project manager at project level for copy from previous milestone">
                                                <i class="far fa-copy"></i>
                                            </a>

                                        <a href="javascript:;" class="textUndrln" id='${dynamicButtonId}' data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ShowMetric_History" onclick="ShowHistory(0,'${CurrentMilestoneId}')">
                                            <i class="fas fa-history" data-bs-toggle="tooltip" title="Show History"></i></a>
                                    </div>
                                </div>
                            </td>`;
                    }

                   <%Else %>

                    strHTML += `
                                  <td class="sprintCol">
                                    <div class="td_iconsDiv1 d-flex justify-content-center gap-4">
                                        <div class="form-group d-flex justify-content-start gap-2">
                                            <label>Edit</label>
                                            <label class="switch" data-bs-toggle="tooltip" title="You don't have edit access">
                                                <input type="checkbox" id='${dynamicEditbtn}' disabled>
                                                    <span class="slider"></span>
                                                    </label>
                                                </div>
                                            <div class="tblIcons d-flex gap-2">
                                                <a href="javascript:;" class="textUndrln disabled" id='${dynamicCopybtn}' data-bs-toggle="tooltip" title="You don't have edit access for copy from previous milestone">
                                                    <i class="far fa-copy"></i>
                                                </a>

                                                <a href="javascript:;" class="textUndrln" id='${dynamicButtonId}' data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ShowMetric_History" onclick="ShowHistory(0,'${CurrentMilestoneId}')">
                                                    <i class="fas fa-history" data-bs-toggle="tooltip" title="Show History"></i></a>
                                            </div>
                                        </div>
                                  </td>`;


                   <%End If%>

                        HisIds.push(dynamicButtonId);                                         
                        CopyIds.push(dynamicCopybtn);
                        EditIds.push(dynamicEditbtn);                  
                }

                strHTML += `<td>&nbsp</td>`;
                strHTML += "</tr>";

                $("#tbodyHeader").html('');
                $("#tbodyHeader").html(strHTML);


                $(".copyfield").addClass("disabled");

                //History  Link
                $("#showHisDevAgilePE_Btn1").hide();
                if (strHistoryResult.length != 0) {
                    $("#showHisDevAgilePE_Btn1").show();
                }

                for (var i = 0; i < HisIds.length; i++) {
                    $("#" + HisIds[i]).hide();
                }
               // alert(HisIds);

                HisMSIDs = [];
                for (var i = 0; i < HisIds.length; i++) {
                    //debugger
                    var MSID = (HisIds[i]);
                    var MilestoneID = MSID.match(/\d+$/)[0];
                    HisMSIDs.push(MilestoneID);
                }

                HistoryStatus();


                //for (var i = 0; i < HisIds.length; i++) {
                  
                //    var MSID = (HisIds[i]);
                //    var MilestoneID = MSID.match(/\d+$/)[0];

                //    ShowHistory(0, MilestoneID);

                //    if (strHistoryResult.length != 0) {
                //        $("#" + HisIds[i]).show();
                //    }
                //}

                //Copy Link
                if (IsCopyEnable == 1) {                  
                    for (var i = 0; i < CopyIds.length; i++) {
                        $("#" + CopyIds[i]).show();
                    }
                } else {
                    for (var i = 0; i < CopyIds.length; i++) {
                        $("#" + CopyIds[i]).hide();
                    }
                }

                $('.selectpicker').selectpicker('refresh');
            } else {
                var data = "No data available in table"
                $("#tbodyHeader").html('');
                $("#tbodyHeader").html(data);
                $("#tbodyHeader").addClass("noRecordRow");
            }


            var columnSums = {}; // Object to keep track of sums for each column 
            var columnHasValues = {}; // Object to check if there are any values in the column
            var columnIndexMap = {}; // Object to map column indices to sprint IDs
            var totalColumns = 0; // Track the number of columns
            var uniqueMilestones = {}; // Object to ensure only unique milestones are counted
            var HTMLbody = '';

         
            for (var i = 0; i < strResultD.length; i++) {
              
                var SelResourceId = strResultD[i].ResourceID;
                var ResourceDetails = strResultD[i].ResourceDetails;

                //Commented & Added by Ajit L on 11/09/2024
                if (ResourceDetails.indexOf("Test_WF") != -1) {
                    ResourceDetails = ResourceDetails.replace('Test_WF', '')
                }
               // HTMLbody += `<tr><td class="sticky_col res_col bg_grayTD">${strResultD[i].ResourceDetails}</td>`;
                HTMLbody += `<tr><td class="sticky_col res_col bg_grayTD">${ResourceDetails}</td>`;

                 //End of Commented & Added by Ajit L on 11/09/2024

                for (var key in strResultD[i]) {
                    if (strResultD[i].hasOwnProperty(key) && key !== 'ResourceDetails' && key !== 'ResourceID') {
                        var keyParts = key.split('_');
                        if (keyParts.length > 1) {
                            var milestoneId = parseInt(keyParts[0], 10);
                            var SelSprintId = milestoneId;
                            var Value = strResultD[i][key];
                            if (Value == null) {
                                Value = '';
                            } else {
                                //Value = parseFloat(Value).toFixed(2);
                                Value = Value;
                            }

                            // Initialize column tracking
                            if (!uniqueMilestones[milestoneId]) {
                                uniqueMilestones[milestoneId] = true;
                                columnSums[milestoneId] = 0;
                                columnHasValues[milestoneId] = false;
                                columnIndexMap[totalColumns] = milestoneId;
                                totalColumns++;                    
                            }

                            // Update column sums and check for values
                            if (Value !== '' && Value != 'NA') {
                                // Convert HH:MM to minutes and add to the sum
                                let valueInMinutes = convertToMinutes(Value);
                                if (!columnSums[milestoneId]) {
                                    columnSums[milestoneId] = 0;
                                }
                                columnSums[milestoneId] += valueInMinutes;
                                columnHasValues[milestoneId] = true;
                            }

                            var id = `AttrVal_${strResultD[i].ResourceDetails.replace(/\s+/g, '_')}_${key.replace(/\s+/g, '_')}`;

                            //// Converting back to HH:MM for display
                            //for (let sprintId in columnSums) {
                            //    let sumInMinutes = columnSums[sprintId] || 0;
                            //    let displayValue = columnHasValues[sprintId] ? convertToHHMM(sumInMinutes) : '';
                            //    console.log(`Sum for ${sprintId}: ${displayValue}`);  // Output the sum in HH:MM format
                            //}



                            //HTMLbody += `<td class="sprintCol " id="${id}">
                            //    <input type="text" class="form-control inputWidth" maxlength='9' disabled
                            //           value="${Value}" 
                            //           onblur="ValidateInput(this); if (this.value) { SaveOnBlur(this.value, ${SelResourceId}, ${SelSprintId}); }"
                            //           onkeypress="return (event.charCode >= 48 && event.charCode <= 57) || event.charCode === 58 || event.charCode === 8 || event.charCode === 0 || event.charCode === 13">
                            //</td>`;


                            if (ResourceDetails.indexOf("Automation-Manual from base metrics") == -1) {


                                HTMLbody += `<td class="sprintCol" id="${id}">
                                    <input type="text" class="form-control inputWidth" maxlength='9' disabled
                                           value="${Value}" 
                                           onblur="if (ValidateInput(this)) { 
                                                       if (isValidTimeFormat(this.value)) { 
                                                           SaveOnBlur(this.value, ${SelResourceId}, ${SelSprintId}); 
                                                       } else {
                                                           this.value = '';
                                                       }
                                                   } else {
                                                       this.value = '';
                                                   }"
                                           onkeypress="return (event.charCode >= 48 && event.charCode <= 57) || event.charCode === 58 || event.charCode === 8 || event.charCode === 0 || event.charCode === 13)">
                                </td>`;
                            }
                            else {

                                HTMLbody += `<td class="sprintCol" id="${id}">
                                   <input type="text" class="form-control inputWidth totalRow" disabled value="${Value}">
                                </td>`;
                            }
                        }
                    }
                }
                HTMLbody += `<td>&nbsp</td>`;
                HTMLbody += `</tr>`;
            }

            // Add the total row

            //if (strResultD.length > 0) {
            //    HTMLbody += `<tr><td class="sticky_col res_col bg_grayTD">Total - Available Hours</td>`;
            //    for (var i = 0; i < totalColumns; i++) {

            //        var sprintId = columnIndexMap[i];
            //        var sumInMinutes = columnSums[sprintId] || 0;
            //        var displayValue = columnHasValues[sprintId] ? convertToHHMM(sumInMinutes) : '';

            //        if (displayValue != '') {
            //            HTMLbody += `<td class="sprintCol"><input type="text" class="form-control inputWidth totalRow" disabled value="${displayValue}"></td>`;
            //        }
            //        else {
            //            HTMLbody += `<td class="sprintCol"><input type="text" class="form-control inputWidth totalRow" disabled value="NA"></td>`;

            //        }
            //    }
            //    HTMLbody += `</tr>`;
            //}
            

            $("#tbodyProjectEffort").html('');
            $("#tbodyProjectEffort").html(HTMLbody);
          

            if (SaveOnclick != 1) {
            
                $(".ProjectEffortTbl .switch input[type='checkbox']").on("change", function () {
                 
                    var currentColumn = $(this).closest("td").index();
              
                    ClickedColumn = currentColumn;
                    $(".ProjectEffortTbl .switch input[type='checkbox']").not($(this)).prop("checked", false);
                    $(".ProjectEffortTbl tr").each(function () {
                        $(this).find("td").removeClass("bgGrey");
                        $(this).find("input[type='text']").prop("disabled", true);
                    });

                    if ($(this).is(":checked")) {
                        Cflag = 1

                        EnableFlag = 1;
                        $(this).closest("table.ProjectEffortTbl").find("tr").each(function () {
                            var inputElement = $(this).find("td").eq(currentColumn).find("input[type='text']").not('.totalRow');
                            inputElement.prop('disabled', !inputElement.prop('disabled'));
                        });

                        $(this).closest("table.ProjectEffortTbl").find("tr").each(function () {
                            var tdElement = $(this).find("td").eq(currentColumn);
                            tdElement.toggleClass("bgGrey");
                        });
                      
                    } else {
                        EnableFlag = 0;
                        $(".ProjectEffortTbl .copyfield").addClass("disabled");
                    }
                    
                });

            } else {
                Cflag = 1
               
                //updateTableForColumn(ClickedColumn);  //05/07/2024
                updateTableForColumn();
            }
            SaveOnclick = 0;         
        }


        function HistoryStatus() {
            var Parameter = {
                MileStoneIDs: HisMSIDs.toString()
            };
            var param = JSON.stringify(Parameter);

            var strHisResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/HistoryStatus", param, false);
            if (strHisResult != null && strHisResult != undefined && strHisResult != "") {

                for (var i = 0; i < strHisResult.length; i++) {
                    $('#showHisDevAgilePE_Btn' + strHisResult[i].MilstoneID).show();
                }          
            }
        }

        var Isenable;
        var ObjID = "";
        var Copybtn = "";
        function Slider(Obj, OldId, NewId, CopybtnId) {

            ObjID = (Obj != null && Obj !== undefined) ? Obj.trim() : Obj;
            Copybtn = (CopybtnId != null && CopybtnId !== undefined) ? CopybtnId.trim() : CopybtnId;

            if ($("#" + ObjID).prop('checked') == true) {
                Isenable = 1; // enabled

                var IsCopied = CopyStatus(NewId);
                if (IsCopied == false) {
                    $("#" + Copybtn).removeClass("disabled");
                }            
            } else {
                Isenable = 0; // disabled
                $("#" + Copybtn).addClass("disabled");
                $(".copyfield").attr("disabled", true); // Disable all elements with the copyfield class
            }
        }


        function convertToMinutes(timeStr) {
            const [hours, minutes] = timeStr.split(':').map(Number);
            return (hours * 60) + minutes;
        }

        function convertToHHMM(minutes) {
            const hours = Math.floor(minutes / 60);
            const mins = minutes % 60;
            return `${hours.toString().padStart(2, '0')}:${mins.toString().padStart(2, '0')}`;
        }


        function updateTableForColumn() {

            var selectedcol = '';
            $(".ProjectEffortTbl .switch input[type='checkbox']").on("change", function () {

                if ($("#" + ObjID).prop('checked') == true) {
                    Isenable = 1//enabled
                } else {
                    Isenable = 0; //disabled
                }
                selectedcol = $(this).closest("td").index();
                ClickedColumn = selectedcol; //Added on 05/07
              
                $(".ProjectEffortTbl .switch input[type='checkbox']").prop("checked", false);
                $(".ProjectEffortTbl tr").each(function () {
                    $(this).find("td").removeClass("bgGrey");
                    $(this).find("input[type='text']").prop("disabled", true); // Disable all inputs
                });

                // Check the checkbox for the clicked column
                var colIndex = selectedcol - 1;
                if (Isenable == 0) {
                    $(".ProjectEffortTbl .switch input[type='checkbox']").eq(colIndex).prop("checked", false);

                    // Enable inputs and add background color for the clicked column
                    $(".ProjectEffortTbl tr").each(function () {
                        var inputElement = $(this).find("td").eq(selectedcol).find("input[type='text']").not('.totalRow');
                        inputElement.prop('disabled', true); // Enable inputs in the clicked column
                    });

                    $(".ProjectEffortTbl tr").each(function () {
                        var tdElement = $(this).find("td").eq(selectedcol);
                        tdElement.removeClass("bgGrey");
                    });

                } else {
                    $(".ProjectEffortTbl .switch input[type='checkbox']").eq(colIndex).prop("checked", true);

                    // Enable inputs and add background color for the clicked column
                    $(".ProjectEffortTbl tr").each(function () {
                        var inputElement = $(this).find("td").eq(selectedcol).find("input[type='text']").not('.totalRow');
                        inputElement.prop('disabled', false); // Enable inputs in the clicked column
                    });

                    $(".ProjectEffortTbl tr").each(function () {
                        var tdElement = $(this).find("td").eq(selectedcol);
                        tdElement.addClass("bgGrey");
                    });
                }

            });



            if (selectedcol) {

                EnableFlag = 1;
                // Check the checkbox for the clicked column
                var colIndex = selectedcol - 1;

                $(".ProjectEffortTbl .switch input[type='checkbox']").eq(selectedcol).prop("checked", true);

                //// Enable inputs and add background color for the clicked column
                $(".ProjectEffortTbl tr").each(function () {
                    var inputElement = $(this).find("td").eq(selectedcol).find("input[type='text']").not('.totalRow');
                    inputElement.prop('disabled', false); // Enable inputs in the clicked column
                });

                $(".ProjectEffortTbl tr").each(function () {
                    var tdElement = $(this).find("td").eq(selectedcol);
                    tdElement.addClass("bgGrey");
                });

            } else {
                EnableFlag = 1;
                var colIndex = ClickedColumn - 1;
                // Check the checkbox for the clicked column  
                if (Isenable == 0) {
                    $(".ProjectEffortTbl .switch input[type='checkbox']").eq(colIndex).prop("checked", false);

                    $(".ProjectEffortTbl tr").each(function () {
                        var inputElement = $(this).find("td").eq(ClickedColumn).find("input[type='text']").not('.totalRow');
                        inputElement.prop('disabled', true); // Enable inputs in the clicked column
                    });

                    $(".ProjectEffortTbl tr").each(function () {
                        var tdElement = $(this).find("td").eq(ClickedColumn);
                        tdElement.removeClass("bgGrey");
                    });
                } else {

                    $(".ProjectEffortTbl .copyfield").each(function () {
                        if ($(this).closest("td").index() === ClickedColumn) {

                            var MSID = $(this).data("milestone-id");
                            var IsCopied = CopyStatus(MSID);
                            if (IsCopied == false) {
                                $(this).removeClass("disabled");
                            }
                                                 
                        } 
                    });

                    $(".ProjectEffortTbl .switch input[type='checkbox']").eq(colIndex).prop("checked", true);

                    $(".ProjectEffortTbl tr").each(function () {
                        var inputElement = $(this).find("td").eq(ClickedColumn).find("input[type='text']").not('.totalRow');
                        inputElement.prop('disabled', false); // Enable inputs in the clicked column
                    });

                    $(".ProjectEffortTbl tr").each(function () {
                        var tdElement = $(this).find("td").eq(ClickedColumn);
                        tdElement.addClass("bgGrey");
                    });

                }
            }
        }


        function SwapMilestone(selectElement, newOrder) {
            SaveOnclick = 0;
            var ProjectId = $('#cboProjectName').val();
            var selectedOption = selectElement.options[selectElement.selectedIndex];
            var newMilestoneId = selectedOption.value;
            var newOrder = newOrder;

            // Get the old milestone id and its order
            var oldOrder= '';
            var oldMilestoneId = '';

            oldOrder = selectedOption.getAttribute('data-order');

            // Iterate over all options to find the previously selected milestone
            for (var i = 0; i < selectElement.options.length; i++) {
                var option = selectElement.options[i];
                if (option.getAttribute('data-order') == newOrder && option.value !== newMilestoneId) {
                    oldMilestoneId = option.value;
                    break;
                }
            }

            var Parameter = {
                ProjectID: ProjectId,
                NewMilestoneId: newMilestoneId,
                NewOrder: newOrder,
                OldMilestoneId: oldMilestoneId,
                OldOrder: oldOrder,
                CreatedBy: UserName
            };
            var param = JSON.stringify(Parameter);

            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/UpdateMilestoneOrder", param, false);

            if (strResult != null && strResult != undefined && strResult != "") {
                if (strResult == 'Updated') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("<%=MyBase.GetResourceString("A_OrderChangedW")%>");
                }
            }
            PlotEffortDetails();

            RefreshList();
        }


        function isValidTimeFormat(value) {
            const timePattern = /^\d+:[0-5][0-9]$/;
            return value === '' || timePattern.test(value);
        }

        function ValidateInput(input) {

            const regex = /^\d+:[0-5][0-9]$/;

            //Commented on 23/07/2024
            <%--if ((input.value) == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_AtLeastOneVal")%>");
                return false;
            }--%>
            //Commented on 23/07/2024

            if (input.value != '') {
                if (!regex.test(input.value)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<%=MyBase.GetResourceString("A_EffortFormat")%>");
                    // input.value = '';  // Clear the input if it is invalid
                    // input.value = -1;  // Clear the input if it is invalid
                    return false;
                }
            }
            return true;
        }


        var SaveOnclick = 0;
        function SaveOnBlur(value, SelResourceId, SelSprintId) {
         
            SaveOnclick = 1;
          
            var ProjectId = $('#cboProjectName').val();        
            var AttrValue = value.replace(/\s+/g, ' ').trim();

                var Parameter = {
                    TemplateID: G_TemplateID,
                    ProjectID: ProjectId,
                    MileStoneID: SelSprintId,
                    ResourceID: SelResourceId,
                    AttributeValue: AttrValue,
                    IsCreated: 1,
                    CreatedBy: UserName
                }

                var param = JSON.stringify(Parameter);
                var strResult1 = AJAXCallWithResult("/api/PM_ProjectEffort_TW/SaveProjectEffort", param, false);

                PlotEffortDetails();
                RefreshList();
                EnableFlag = 1;

                if (strResult1 != null && strResult1 != undefined && strResult1 != "") {
                    if (strResult1 == 'Inserted') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%=MyBase.GetResourceString("A_ProjectEffortSaved")%>");
                    }
                    else if (strResult1 == 'Updated') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%=MyBase.GetResourceString("A_ProjectEffortUpdated")%>"); 
                    }                
                }
           
           
        }     


        function CopyPrevMilestone(ClickedBtnId, PrevMilestoneId, CurMilestoneId) {
       
            if (EnableFlag == 1 && Isenable == 1 && ClickedBtnId == ObjID) {

                var Parameter = {
                    OldMilestoneId: PrevMilestoneId,
                    NewMilestoneId: CurMilestoneId,
                    CreatedBy: UserName
                }
                var param = JSON.stringify(Parameter);
                var strResult1 = AJAXCallWithResult("/api/PM_ProjectEffort_TW/CopyPrevMilestone", param, false);

                Cflag = 0;
                PlotEffortDetails();
                RefreshList();
                $(".tooltip").remove();

                if (strResult1 != null && strResult1 != undefined && strResult1 != "") {
                    if (strResult1 == 'not Exists') {
                        alertify.set('notifier', 'position', 'top-right');                   
                        alertify.error("<%=MyBase.GetResourceString("A_PrevMSNoDataW")%>");
                    }
                    else if (strResult1 == 'Copied') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%=MyBase.GetResourceString("A_MSCopiedW")%>");
                    }
                }

                
            } else {
               // alertify.set('notifier', 'position', 'top-right');
                //alertify.error("<%=MyBase.GetResourceString("A_EnabeEditforcopyW")%>"); 
                return false
            }
        }

        var HisMilestoneId = '';
        var strHistoryResult = '';
        function ShowHistory(flag, MilestoneId, ModifiedField, ModifiedBy) {
            HisMilestoneId = MilestoneId;

            if (flag == 0) {
                GetModifiedBy(HisMilestoneId);
                GetModifiedField(HisMilestoneId)
            }

            var strHTML = "";
            var NewModifiedField = "";
            var NewModifiedBy = "";
            if (ModifiedField == undefined && ModifiedBy == undefined) {
                NewModifiedField = "";
                NewModifiedBy = "";
            } else {
                NewModifiedField = ModifiedField;
                NewModifiedBy = ModifiedBy;
            }
            var NewModifiedField = unescape(NewModifiedField);
            var NewModifiedBy = unescape(NewModifiedBy);


            var parameter = {
                MilestoneID: MilestoneId,
                ModifiedField: NewModifiedField,
                HisModifiedBy: NewModifiedBy
            }

            var param = JSON.stringify(parameter);
            strHistoryResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/ShowHistory", param, false);
            $("#MetricShowHistoryTable").dataTable().fnDestroy();

            for (var i = 0; i < strHistoryResult.length; i++) {
                 //Commented & Added by Ajit L on 11/09/2024
                var ModifiedField = strHistoryResult[i].ModifiedField;             
                if (ModifiedField.indexOf("Test_WF") != -1) {
                    ModifiedField = ModifiedField.replace('Test_WF', '')
                }                              
                /* strHTML += "<tr><td>" + strHistoryResult[i].ModifiedField + "</td>";*/
                strHTML += "<tr><td>" + ModifiedField + "</td>";
                 //End of Commented & Added by Ajit L on 11/09/2024
             
                strHTML += "<td>" + strHistoryResult[i].Milestone + "</td>";
                strHTML += "<td>" + strHistoryResult[i].OldValue + "</td>";
                strHTML += "<td>" + strHistoryResult[i].NewValue + "</td>";
                strHTML += "<td>" + strHistoryResult[i].MfdDate + "</td>";
                strHTML += "<td>" + strHistoryResult[i].ModifiedBy + "</td>";

                strHTML += "</tr>";
            }
            $('#tbodyMetricShowHistoryTable').html('');
            $('#tbodyMetricShowHistoryTable').html(strHTML);

            $('#MetricShowHistoryTable').dataTable({
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
                "bAutoWidth": false,
                "ordering": false,
                "info": false,
            });
            $('#MetricShowHistoryTable').wrap('<div class="dataTables_scroll" />');
            return strHistoryResult;
        }


        $('#ModifiedHisFieldInput').on('change', function () {
            var currModifiedField = $('#ModifiedHisFieldInput').val();
            var currModifiedBy = $('#ModifiedHisByInput').val();

            ShowHistory(1, HisMilestoneId, currModifiedField, currModifiedBy);
        });

        $('#ModifiedHisByInput').on('change', function () {
            var currModifiedField = $('#ModifiedHisFieldInput').val();
            var currModifiedBy = $('#ModifiedHisByInput').val();

            ShowHistory(1, HisMilestoneId, currModifiedField, currModifiedBy);
        });

        function GetModifiedField(id) {
            var strHTML = "";
            var Parameters = {
                MilestoneID: id
            }

            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetModifiedField", param, false);

            //Commented & Added by Ajit L on 11/09/2024
            //for (var i = 0; i < strResult.length; i++) {
            //    var ListComponent = strResult[i];
            //    strHTML += ('<option value="' + ListComponent.ModifiedField + '">' + ListComponent.ModifiedField + '</option>');
            //}

            for (var i = 0; i < strResult.length; i++) {
                var ListComponent = strResult[i];
                var ChangedField = ListComponent.ModifiedField;
                if (ChangedField.indexOf("Test_WF") != -1) {
                    ChangedField = ChangedField.replace('Test_WF', '')
                }
                strHTML += ('<option value="' + ListComponent.ModifiedField + '">' + ChangedField + '</option>');
            }
            //End of Commented & Added by Ajit L on 11/09/2024

            $("#ModifiedHisFieldInput").html('');
            $("#ModifiedHisFieldInput").html(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        function GetModifiedBy(id) {
            var strHTML = "";
            var Parameters = {
                MilestoneID: id
            }

            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetModifiedBy", param, false);

            for (var i = 0; i < strResult.length; i++) {
                var ListComponent = strResult[i];
                strHTML += ('<option value="' + ListComponent.ModifiedBy + '">' + ListComponent.ModifiedBy + '</option>');
            }
            $("#ModifiedHisByInput").html('');
            $("#ModifiedHisByInput").html(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        var RoleDescription = '';
        function GetRoleDetails() {
            var ProjectId = $('#cboProjectName').val();
            var parameter = {
                UserID: UserId,
                ProjectID: ProjectId
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetRoleDetails", param, false);

            if (strResult.length !== 0) {
                for (var i = 0; i < strResult.length; i++) {
                    RoleDescription = strResult[i].RoleDescription;
                }
            } else {
                RoleDescription = ''
            }
        }

        var IsCopyEnable = 0;
        function CheckCopyIsEnableorNot() {
            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/CheckCopyIsEnableorNot", '', false);
            if (strResult == "False" || strResult == undefined || strResult == null) {
                IsCopyEnable = 0;
            } else {
                IsCopyEnable = 1;
            }
        }


        var InitialIndex = 0; // Declare InitialIndex globally so it can retain its value

        function RefreshList() {
            $(".sprintCol").hide();
            var ColumnsCnt = $('#DevAgile_ProjectEffortTbl1 tbody tr:first .sprintCol').length;

            function updateTableDisplay() {
                $('#DevAgile_ProjectEffortTbl1 tbody tr').each(function () {
                    $(this).find('td.sprintCol').hide();
                    $(this).find('td.sprintCol').slice(InitialIndex, InitialIndex + 3).css('display', 'table-cell');
                });

                $('#DevAgilePE_PrevMonthBtn').prop('disabled', InitialIndex <= 0);
                $('#DevAgilePE_NextMonthBtn').prop('disabled', InitialIndex >= ColumnsCnt - 3);
            }

            // Reapply InitialIndex value after refreshing
            updateTableDisplay();

            $('#DevAgilePE_NextMonthBtn').off('click').on('click', function () {
                if (InitialIndex < ColumnsCnt - 3) {
                    InitialIndex += 3;
                    updateTableDisplay();
                }
            });

            $('#DevAgilePE_PrevMonthBtn').off('click').on('click', function () {
                if (InitialIndex > 0) {
                    InitialIndex -= 3;
                    updateTableDisplay();
                }
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            EnableFlag = 0;
        }

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            StartLoader("#ProjectEffortbody");
            $.ajax({
                url: encodeURI(strUrl_Cust + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#ProjectEffortbody");
            return ajaxResult;
        }

        function StartLoader(bodyID) {

            var progress2 = new LoadingOverlayProgress({
                bar: {
                    "background": "#ddd",
                    "top": "50px",
                    "left": "0px",
                    "right": "0px",
                    "height": "90px",
                    "width": "90px",
                    "margin": "auto",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .2 ) 100% 100% no-repeat"
                },

            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }

        function StopLoader(bodyID) {
            jQuery(window).load(function () {
                $(bodyID).LoadingOverlay("hide", {

                });
            });
        }

        function StopAjaxLoader(bodyID) {
            $(bodyID).LoadingOverlay("hide", {

            });
        }


        function GetDerivedMetricIsFreezed(MilestoneId) {
            var ProjectID = $("#cboProjectName").val();
            var Parameters = {
                ProjectID: ProjectID,
                MileStoneID: MilestoneId
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetDerivedMetricIsFreezed", param, false);
            return strResult;
        }

        function CopyStatus(MilestoneId) {
            var Parameters = {
                MileStoneID: MilestoneId
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/CopyStatus", param, false);
            return strResult;
        }



        function GetReleaseDetails() {
          // debugger
            var ProjectId = $('#cboProjectName').val();
            var Parameters = {
                ProjectID: ProjectId
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetReleaseDetails", param, false);
            $('#DevWF_ProjectEffortTbl2').dataTable().fnDestroy();
           
            $("#tbodyReleasetable").html('');
            if (strResult != null && strResult != undefined && strResult != "") {
                var strHTML = "";
              
              
                for (var i = 0; i < strResult.length; i++) {
                    strHTML += `<tr>
                        <td class="bg_grayTD text-center">${strResult[i].ReleaseName}</td>                     
                        <td class="text-center">${strResult[i].PlannedStartDate}</td>
                        <td class="text-center">${strResult[i].PlannedEndDate}</td>
                        <td class="text-center">${strResult[i].ActualStartDate}</td>
                        <td class="text-center">${strResult[i].ActualEndDate}</td>
                        <td class="text-center">
                            <% If m_blnEditAccess = True Then %>
                                <a href="javascript:;" data-bs-toggle="modal" onclick="EditReleaseDetails(${strResult[i].ReleaseID})" >
                                    <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details"></i>
                                </a>
                            <% Else %>
                             
                            <% End If %>
                        </td>
                    </tr>`;
                }
                $("#tbodyReleasetable").html(strHTML);
            }

            $('#DevWF_ProjectEffortTbl2').dataTable({
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
                "bAutoWidth": false,
                "ordering": false,
                "info": false,
            });
            $('#DevWF_ProjectEffortTbl2').wrap('<div class="dataTables_scroll" />');
        }

        var ReleaseID = 0;
       
        function SaveRelease() {
           /* debugger*/
          //Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
            $('#cboMilestoneName option:disabled').prop('disabled', false);
            //End of Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
            var MSStartDate = '';
            var MSEndDate = '';
            Validation();
            var MilestoneIDs = $('#cboMilestoneName').val();
           
            if (IsValid == 1) {

                if (MilestoneIDs != undefined && MilestoneIDs != '' & MilestoneIDs != null & MilestoneIDs != 0) {

                    var MsStartDateArray = [];
                    var MsEndDateArray = [];

                    MilestoneIDs.forEach(function (MilestoneID) {

                        var Parameters = {
                            MilestoneID: MilestoneID
                        }
                        var param = JSON.stringify(Parameters);

                        var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetMilestoneDetails", param, false);
                        if (strResult != null && strResult != undefined && strResult != "") {
                            for (var i = 0; i < strResult.length; i++) {
                                MSStartDate = strResult[i].StartDate;
                                MSEndDate = strResult[i].EndDate;

                                MsStartDateArray.push(MSStartDate);
                                MsEndDateArray.push(MSEndDate);

                            }
                        }

                    });

                    
                    if (MsStartDateArray.length > 0) {
                        var dateObjectsArray = MsStartDateArray.map(dateString => new Date(dateString));

                         MSStartDate = new Date(Math.min(...dateObjectsArray));
                    }

                    if (MsEndDateArray.length > 0) {
                        var dateObjectsArray = MsEndDateArray.map(dateString => new Date(dateString));

                        MSEndDate = new Date(Math.max(...dateObjectsArray));
                    }

                    var PlStDate = $('#ReleasePlannedStartDate').val();
                    var PlEndDate = $('#ReleasePlannedEndDate').val();


                    if (new Date(MSStartDate) < new Date(PlStDate)) {
                        $('#ConfirmationModal').modal('show');
                        $('#idConfirmationMsg').text('<%= MyBase.GetResourceString("A_MSStartSmaller") %>');
                    }
                    else
                    if (new Date(MSStartDate) > new Date(PlEndDate)) {
                        $('#ConfirmationModal').modal('show');
                        $('#idConfirmationMsg').text('<%= MyBase.GetResourceString("A_MSStartGreater") %>');
                    }
                    else
                    if (new Date(MSEndDate) > new Date(PlEndDate)) {
                        $('#ConfirmationModal').modal('show');
                        $('#idConfirmationMsg').text('<%= MyBase.GetResourceString("A_MSEndGreater") %>');
                    }
                    else
                    if (new Date(MSEndDate) < new Date(PlStDate)) {
                        $('#ConfirmationModal').modal('show');
                        $('#idConfirmationMsg').text('<%= MyBase.GetResourceString("A_MSEndSmaller") %>');
                    }
                    else {
                        ReleaseInfo(0);
                    }
                }
                else {
                    ReleaseInfo(0);
                }
            }
        }

        function ReleaseInfo(flag) {
           
            var ProjectId = $('#cboProjectName').val();
            var ReleaseName = $('#ReleaseNameInput').val().replace(/<|>/g, '');
            ReleaseName = ReleaseName.replace(/\s+/g, ' ').trim();
            var PlStDate = $('#ReleasePlannedStartDate').val();
            var PlEndDate = $('#ReleasePlannedEndDate').val();
            var ActStDate = $('#ReleaseActualStartDate').val();
            var ActEndDate = $('#ReleaseActualEndDate').val();
            var MilestoneIDs = $('#cboMilestoneName').val();
           

                var Parameters = {
                    ReleaseID: ReleaseID,
                    ProjectID: ProjectId,
                    ReleaseName: ReleaseName,
                    PlanStartDate: PlStDate,
                    PlanEndDate: PlEndDate,
                    ActualStartDate: ActStDate,
                    ActualEndDate: ActEndDate,
                    MilestoneIDs: MilestoneIDs.toString(),
                    IsCreated: 1,
                    CreatedBy: UserName
                }
                var param = JSON.stringify(Parameters);

                var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/SaveRelease", param, false);
                if (strResult != null && strResult != undefined && strResult != "") {
                    if (strResult == 'Saved') {

                        $('#EditReleaseDetlsModal').modal('hide');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%=MyBase.GetResourceString("A_RelSaved")%>");
                        ClearFields();
                    }
                    else if (strResult == 'Updated') {
                        $('#EditReleaseDetlsModal').modal('hide');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%=MyBase.GetResourceString("A_RelUpdated")%>");
                        ClearFields();
                    } else if (strResult == 'NAME EXISTS') {
                        alertify.set('notifier', 'position', 'top-right');
                         alertify.error("<%=MyBase.GetResourceString("A_RelNameExist")%>");
                         //$('#ReleaseNameInput').focus();
                     }
            }
            //Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
            $('#cboMilestoneName option:disabled').prop('disabled', true);
            //End of Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
                $('#ConfirmationModal').modal('hide');

                 GetReleaseDetails();
            
        }



        function ClearFields() {
            $('#ReleaseNameInput').val('');
            $('#ReleasePlannedStartDate').val('');
            $('#ReleasePlannedEndDate').val('');
            $('#ReleaseActualStartDate').val('');
            $('#ReleaseActualEndDate').val('');
            $('#cboMilestoneName').val(0);
            $(".selectpicker").selectpicker('refresh');
        }

        var IsValid = 1;
        function Validation() {
            IsValid = 1;
            var ReleaseName = $('#ReleaseNameInput').val().replace(/<|>/g, '');
            ReleaseName = ReleaseName.replace(/\s+/g, ' ').trim();
            var PlStDate = $('#ReleasePlannedStartDate').val();
            var PlEndDate = $('#ReleasePlannedEndDate').val();
            var ActStDate = $('#ReleaseActualStartDate').val();
            var ActEndDate = $('#ReleaseActualEndDate').val();
            //var MilestoneName = $('#cboMilestoneName').val();

    
    
             if (ReleaseName.length == 0 || ReleaseName == ' ') {
                $("#ReleaseNameInput").focus();
                alertify.set('notifier', 'position', 'top-right');
                 alertify.error("<%= MyBase.GetResourceString("A_RelNameBlank") %>");
                 IsValid = 0;
                 return false;
             }

             if (checkSpecialCharacter(ReleaseName.trim(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Release Name should not contain any of " + regularExpression + " characters");
                 $("#ReleaseNameInput").focus();
                 IsValid = 0;
                    return false;
             }

            if (PlStDate.length == 0 || PlStDate == ' ') {
                $("#ReleasePlannedStartDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                 alertify.error("<%= MyBase.GetResourceString("A_PlStBlank") %>");
                IsValid = 0;
                return false;
            
            }

            if (PlEndDate.length == 0 || PlEndDate == ' ') {
                $("#ReleasePlannedEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                 alertify.error("<%= MyBase.GetResourceString("A_PlEndDtBlank") %>");
                IsValid = 0;
                 return false;
            }

            if (ActStDate.length == 0 || ActStDate == ' ') {
                $("#ReleaseActualStartDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                 alertify.error("<%= MyBase.GetResourceString("A_ActStDtBlank")%>");
                IsValid = 0;
                 return false;
            }

            if (ActEndDate.length == 0 || ActEndDate == ' ') {
                $("#ReleaseActualEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                  alertify.error("<%= MyBase.GetResourceString("A_ActEndDtBlank") %>");
                IsValid = 0;
                 return false;
            }


            if (new Date(ProjectStartDate) > new Date(PlStDate)) {
                $("#ReleasePlannedStartDate").focus();
                alertify.set('notifier', 'position', 'top-right');       
                alertify.error("Planned Start Date should be greater than Project Start Date " + ProjectStartDate + " ");
                IsValid = 0;
                return IsValid;
            }

            if (new Date(ProjectEndDate) < new Date(PlStDate)) {
                $("#ReleasePlannedStartDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Planned Start Date should not be greater than Project End Date " + ProjectEndDate + "");
                IsValid = 0;
                return IsValid;
            }

            if (new Date(ProjectStartDate) > new Date(ActStDate)) {
                $("#ReleaseActualStartDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Actual Start Date should be greater than Project Start Date " + ProjectStartDate + "");
                IsValid = 0;
                return IsValid;
            }

            if (new Date(ProjectEndDate) < new Date(ActStDate)) {
                $("#ReleaseActualStartDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Actual Start Date should not be greater than Project End Date " + ProjectEndDate + "");
                IsValid = 0;
                return IsValid;
            }

                
            if (new Date(ProjectEndDate) < new Date(PlEndDate)) {
                $("#ReleasePlannedEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');              
                alertify.error("Planned End Date should not be greater than Project End Date " + ProjectEndDate + "");
                IsValid = 0;
                return IsValid;
            }

            if (new Date(ProjectStartDate) > new Date(PlEndDate)) {
                $("#ReleasePlannedEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');              
                alertify.error("Planned End Date should be greater than Project Start Date " + ProjectStartDate + "");
                IsValid = 0;
                return IsValid;
            }
               
            if (new Date(ProjectEndDate) < new Date(ActEndDate)) {
                $("#ReleaseActualEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');               
                alertify.error("Actual End Date should not be greater than Project End Date " + ProjectEndDate + "");
                IsValid = 0;
                return IsValid;
            }

            if (new Date(ProjectStartDate) > new Date(ActEndDate)) {
                $("#ReleaseActualEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');            
                alertify.error("Actual End Date should be greater than Project Start Date " + ProjectStartDate + "");
                IsValid = 0;
                return IsValid;
            }

            if (new Date(PlEndDate) < new Date(PlStDate)) {
                $("#ReleasePlannedEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_PlanedEndDateSmall") %>");
                IsValid = 0;
                return IsValid;
            }

            if (new Date(ActEndDate) < new Date(ActStDate)) {
                $("#ReleaseActualEndDate").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_ActEndDateSmall") %>");
                IsValid = 0;
                return IsValid;
            }
            return IsValid;
        }

        
        function EditReleaseDetails(RelId) {

            if (RoleDescription != "PM") {
                $("#divNoteEdit").show();
                $("#saveReleaseBtn").hide();
                $("#txtNoteEdit").text('Please Configure Project Manager at Project level');
            }
            else {
                $("#divNoteEdit").hide();
                $("#saveReleaseBtn").show();
                $("#txtNoteEdit").text('');
            }
         var ProjectId = $('#cboProjectName').val();
            GetReleaseDMilestoneEdit(RelId);
             ReleaseID = RelId;
            var Parameters = {
                ProjectID: ProjectId,
                ReleaseID: ReleaseID
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetReleaseDetails", param, false);

           
            if (strResult != null && strResult != undefined && strResult != "") {
                $('#EditReleaseDetlsModal').modal('show');
                for (var i = 0; i < strResult.length; i++) {
                
                    var ReleaseName = strResult[i].ReleaseName;
                    var PlanStDate = strResult[i].PlannedStartDate;
                    var PlanEndDate = strResult[i].PlannedEndDate;
                    var ActStDate = strResult[i].ActualStartDate;
                    var ActEndDate = strResult[i].ActualEndDate;
                    var MilestoneIDs = strResult[i].MilestoneIds;
                    var FreezedMilestoneIDs = strResult[i].FreezedMilestones;

                    $('#ReleaseNameInput').val(ReleaseName);
                    $('#ReleasePlannedStartDate').val(PlanStDate);
                    $('#ReleasePlannedEndDate').val(PlanEndDate);
                    $('#ReleaseActualStartDate').val(ActStDate);
                    $('#ReleaseActualEndDate').val(ActEndDate);
                    //$('#cboMilestoneName').val(MilestoneIDs);

                    var MilestoneIDsArray = MilestoneIDs.split(',');

                    FreezedMilestoneIDs = FreezedMilestoneIDs.split(',');
                 //   alert(FreezedMilestoneIDs);
                    // Set the values to the select picker
                    $('#cboMilestoneName').val(MilestoneIDsArray);
                    //Added By Riddhesh Patil on 12 Aug 2024 for disable freezed milestone
                    $.each(FreezedMilestoneIDs, function (index, value) {
                        $('#cboMilestoneName option[value="' + value + '"]').prop('disabled', true);
                    });
                    //End of Added By Riddhesh Patil on 12 Aug 2024 for disable freezed milestone
                    //$('#cboMilestoneName option:selected').prop('disabled', true);

                    $(".selectpicker").selectpicker('refresh');
                }
            }
        }

        function ShowRelPopUp() {
            //debugger
            $('#EditReleaseDetlsModal').modal('show');
            $('#divNoteEdit').hide();
            ClearFields();
           // $("#cboMilestoneName").attr("multiple");
            ReleaseID = 0;
            GetReleaseMilestone();

        }

        var regularExpression = '';
        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
           
            if (WebConfigSpecialCharacters != '') {
                regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
                regularExpression += "'";
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


        function GetReleaseMilestone() {

            var ProjectId = $('#cboProjectName').val();
            var strHTML = "";
            $("#cboMilestoneName").html("");
            var parameter = {
                ProjectID: ProjectId,
            }

            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetReleaseMilestone", param, false);

            for (var i = 0; i < strResult.length; i++) {
                var obj = strResult[i];
                var MileStoneID = obj.MilestoneID;
                var MileStone = obj.MileStone;

                strHTML += '<option value="' + MileStoneID + '" data-index="' + i + '">' + MileStone + '</option>';
            }
            $("#cboMilestoneName").append(strHTML);

            $(".selectpicker").selectpicker('refresh');
            $('#cboMilestoneName').val(0);
            $(".selectpicker").selectpicker('refresh');
        }


        function GetReleaseDMilestoneEdit(RelId) {
           // debugger
            var ProjectId = $('#cboProjectName').val();
            var strHTML = "";
            $("#cboMilestoneName").html("");
            $(".selectpicker").selectpicker('refresh');
            var parameter = {
                ProjectID: ProjectId,
                ReleaseID: RelId
            }

            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/PM_ProjectEffort_TW/GetReleaseDMilestoneEdit", param, false);

            for (var i = 0; i < strResult.length; i++) {
                var obj = strResult[i];
                var MileStoneID = obj.MilestoneID;
                var MileStone = obj.MileStone;

                strHTML += '<option value="' + MileStoneID + '" data-index="' + i + '">' + MileStone + '</option>';
            }
            $("#cboMilestoneName").append(strHTML);
            $("#cboMilestoneName").val(0);
           $(".selectpicker").selectpicker('refresh');
        }

        //Added By Riddhesh Patil on 13 Aug 2024 for Multiselect functionality
        function ChangeMilestone() {
          // var disabledOptionsValues = $('#cboMilestoneName option:disabled').val();
            //Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
            $('#cboMilestoneName option:disabled').prop('disabled', false);
            //End of Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
            var selectedValues = $("#cboMilestoneName").val();
            //if (disabledOptionsValues != undefined) {
            //    selectedValues += selectedValues + ',' + disabledOptionsValues;
            //}
            
           
            if (selectedValues.length == 0) {
                selectedValues = ["0"];
                $("#cboMilestoneName").selectpicker('val', selectedValues);
            }
            else if (selectedValues.includes("0")) {
                selectedValues = selectedValues.filter(function (value) {
                    return value !== "0";
                });
                $("#cboMilestoneName").selectpicker('val', selectedValues); // Update the dropdown with the new selection
            }
            //Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
            $('#cboMilestoneName option:disabled').prop('disabled', true);
            //End of Added By Riddhesh Patil to save disabled milestone value on 14 Aug 2024
        }
        //End of Added By Riddhesh Patil on 13 Aug 2024 for Multiselect functionality
    </script>

</body>

</html>
