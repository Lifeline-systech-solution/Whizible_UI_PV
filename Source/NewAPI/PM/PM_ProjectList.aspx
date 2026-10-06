<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectList.aspx.vb" Inherits="PbNIT.PM_ProjectList" %>

<!DOCTYPE html>

<html>
<head>
     <!-- Commented by Madhuri.K for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Manage Projects")%>
    <head>
        <!-- <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Manage Projects</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=1">
        <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">

        <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" /> 
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2" />-->
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css" />
        
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/project-manage.css?v=1.9.11" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=3.2" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
        <!-- <link href="../../../Whizible2.0-new/Plugins/alertify/css/alertify.min.css" rel="stylesheet" /> -->

    </head>
    <style type="text/css">
/*        CSS added by Madhuri.K content 30-Aug-2024*/
        .IB_filterlist input.form-control.hasDatepicker + .btncalendar {
    position: absolute;
    right: 30px;
    top: 8px;
}

        /*        CSS added by Madhuri.K content 30-Aug-2024*/
        .alertify-notifier li {
            word-break: normal !important;
            white-space: normal !important;
        }

        .alertify-notifier .ajs-message {
            width: 300px;
            word-break: break-word;
        }


        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            font-family: "Open Sans",sans-serif !important;
            font-size: 14px !important;
            display: inline-block;
            word-break: break-word;
            white-space: normal;
        }

        .nodata {
            margin-left: 20px;
            font-size: medium;
            font-weight: 600;
        }

        .f_smaller {
            font-size: smaller;
        }

        .editFilter {
            color: #1359a6;
            border: 1px;
            border-style: dotted;
            background: none;
            border: none;
            margin: -7px 0px 10px;
            display: block !important;
        }

        /* .width99 {
            width: 99%;
        }*/

        .filter button[aria-expanded="true"] {
            background: none;
            color: #464a4c;
        }

        .filter.active button {
            background: #1359a6;
            color: #fff;
        }
        /*added by pradip on 09-04-2020*/
        body {
            background: #fff;
        }

        /*Added By Dipali V On 16th May 2020 For Loader Issues
        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            border: 3px solid #ababab;
            box-shadow: 1px 1px 10px #ababab;
            border-radius: 15px;
            background: #ddd;
            background-color: white;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }


        .MainDiv {
            overflow: auto;
            height: 75vh;
        }
        /*End of Added By Dipali V On 16th May 2020 For Loader Issues*/

        /*Added by Chetan M on 16th Sept 2020 for performance issue*/
        .divtotal {
            margin-right: -14px;
            margin-top: 7px;
        }

        .spntotal {
            float: right;
        }

        .fa-disabled {
            opacity: 0.6;
            cursor: not-allowed;
            /*pointer-events: none;*/
        }
        /*End of Added by Chetan M on 16


            /*Added By Dipali V On 4th Sep 2020 For Fixed Header*/
        #tblprojectlist table {
            text-align: left;
            position: relative;
            border-collapse: collapse;
        }

        #tblprojectlist th, td {
            padding: 0.25rem;
        }

        #tblprojectlist th {
            /*background: white;*/
            position: sticky;
            top: 0; /* Don't forget this, required for the stickiness */
            box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.4);
            /*Commented by Reshma Chavan on 4th Dec 2020 For Myfilter Delete UI Issue*/
            /*z-index:99999;*/
            /*End of Commented by Reshma Chavan on 4th Dec 2020 For Myfilter Delete UI Issue*/
        }

            #tblprojectlist th > a {
                padding: 0.25rem;
                z-index: 99999;
            }

        #tblprojectlist table-fixed-header thead tr th > i, .table thead tr th > i {
            background: #e7edf0;
            color: #464a4c;
        }
        /*End of Added By Dipali V On 4th Sep 2020 For Fixed Header*/


        #tblprojectlist tr:nth-child(2n) th {
            top: 26px;
        }

        .pagination {
            display: flex;
            white-space: nowrap;
        }
        /*added by pradip on 21-10-2020 for JD Issue*/
        /*added by pradip on 22-10-2020 for JD Issue*/
        .project-detail-table .label-default {
            margin-left: 0px !important;
        }

        .cstm_pagination {
            text-align: right;
        }

            .cstm_pagination .buttons {
                display: inline-flex;
                vertical-align: middle;
            }

        .pagination > li a.page-link {
            color: #1359ac;
            cursor: pointer;
        }

            .pagination > li a.page-link:hover {
                background: #1359ac;
                color: #fff;
            }

        .page-item.fa-disabled .page-link {
            cursor: not-allowed;
        }

        /*Added By Dipali V On 15th Jan 2020 For Moxila Filter Alignement*/
        /*.IB_filterlist .form-inline .form-control {
            width: 140px;
            margin-right: 5px;
 }*/
        /*End of Added By Dipali V On 15th Jan 2020 For Moxila Filter Alignement*/
        /*End added by pradip on 21-10-2020 for JD Issue*/

        /*css version change default style*/
        .pb-1 {
            padding-bottom: 10px !important;
        }

        .pt-1 {
            padding-top: 10px !important;
        }

        .table-fixed-header thead tr th, .table thead tr th {
            padding: 8px;
        }

        body {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

        .form-control, .btn, a, p, input, select.form-select {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

        .table {
            border-spacing: 0 0px;
        }

        table.dataTable thead .sorting:after {
            top: 8px;
        }
        /*End css version change default style*/
        /*page css*/
        .custmodal .modal-content .modal-header .close {
            background: transparent;
            top: 8px;
        }

        .stylish-input-group .input-group-addon {
            height: 34px;
            border: 1px solid;
        }

        .autocompletepicker .input-group .input-group-addon, .fplistbox .input-group .input-group-addon {
            border-radius: 4px 0px 0 4px;
            padding: 3px 8px;
            border: 1px solid #ddd;
            height: 30px;
        }

        .table-outer {
            padding: 0 15px 0px 0px;
        }

        .tblfiltering .input-group .input-group-addon {
            border-radius: 4px 0px 0 4px;
            padding: 4px 8px;
            border: 1px solid #ddd;
        }

        .spinner-border.text-info {
            width: 6rem;
            height: 6rem;
        }

        .filedownload .dropdown-menu li a {
            display: block;
        }

        .input-group.srchprolist {
            width: 200px;
            display: inline-flex;
        }

            .input-group.srchprolist input {
                margin-right: 0;
                height: 30px;
            }

        .srchprolist span.btn {
            width: 50px;
        }

        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            border-radius: 15px;
            background: #ddd;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

.tooltip{ position:absolute!important;}
.tooltip.show{ display:block!important;}
/*For Show Approvers Details By Dipali V*/
        .detailtab {
            margin-left: 20px;
            text-align: left !important;
        }
        /* Added By Gauri On 20th Aug 2024 For Alignment Issue */
        .issuefilter_container .form-group {
            display: unset !important;
        }
        /* End of Added By Gauri On 20th Aug 2024 For Alignment Issue */
        
        /* Custom styling for carousel control tooltips - black color */
        /* Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Prev/Next tooltip styling) */
        .carousel-control-prev[data-bs-toggle="tooltip"] + .tooltip,
        .carousel-control-next[data-bs-toggle="tooltip"] + .tooltip,
        .carousel-control-prev .tooltip,
        .carousel-control-next .tooltip {
            background-color: #000 !important;
            color: #fff !important;
        }
        
        .carousel-control-prev[data-bs-toggle="tooltip"] + .tooltip .tooltip-inner,
        .carousel-control-next[data-bs-toggle="tooltip"] + .tooltip .tooltip-inner,
        .carousel-control-prev .tooltip .tooltip-inner,
        .carousel-control-next .tooltip .tooltip-inner {
            background-color: #000 !important;
            color: #fff !important;
        }
        
        .carousel-control-prev[data-bs-toggle="tooltip"] + .tooltip .tooltip-arrow::before,
        .carousel-control-next[data-bs-toggle="tooltip"] + .tooltip .tooltip-arrow::before,
        .carousel-control-prev .tooltip .tooltip-arrow::before,
        .carousel-control-next .tooltip .tooltip-arrow::before {
            border-bottom-color: #000 !important;
        }
        
        /* Additional specificity for Bootstrap 5 tooltips */
        /* Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Prev/Next tooltip styling) */
        .tooltip.bs-tooltip-bottom .tooltip-inner,
        .tooltip.bs-tooltip-top .tooltip-inner {
            background-color: #000 !important;
            color: #fff !important;
        }
        
        .tooltip.bs-tooltip-bottom .tooltip-arrow::before {
            border-bottom-color: #000 !important;
        }
        
        .tooltip.bs-tooltip-top .tooltip-arrow::before {
            border-top-color: #000 !important;
        }
        
        /* Additional class for carousel tooltips */
        /* Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Prev/Next tooltip styling) */
        .tooltip.carousel-tooltip-black .tooltip-inner {
            background-color: #000 !important;
            color: #fff !important;
        }
        
         .tooltip.carousel-tooltip-black .tooltip-arrow::before {
             border-bottom-color: #000 !important;
         }
         
         /* Carousel controls styling for approval stages */
         .checkbox-container .carousel-control-prev,
         .checkbox-container .carousel-control-next {
             position: absolute;
             top: 50%;
             transform: translateY(-50%);
             width: 32px;
             height: 32px;
             border-radius: 50%;
             background: rgba(0,0,0,0.35);
             border: none;
             display: flex;
             align-items: center;
             justify-content: center;
             transition: background-color 0.2s ease;
             z-index: 10;
         }
         
         .checkbox-container .carousel-control-prev:hover,
         .checkbox-container .carousel-control-next:hover {
             background: rgba(0,0,0,0.5);
         }
         
         .checkbox-container .carousel-control-prev {
             left: 5px;
         }
         
         .checkbox-container .carousel-control-next {
             right: 5px;
         }
         
         .checkbox-container .carousel-control-prev i,
         .checkbox-container .carousel-control-next i {
             color: #fff;
             font-size: 18px;
         }
         
         /* Dots styling */
         .checkbox-container .round label {
             display: inline-block;
             width: 10px;
             height: 10px;
             border-radius: 50%;
             margin: 6px 6px;
             transition: transform .15s ease, box-shadow .2s ease;
             cursor: pointer;
         }
         
         .checkbox-container .round label:hover {
             transform: scale(1.15);
             box-shadow: 0 2px 6px rgba(0,0,0,.25);
         }
         
         .checkbox-container .round label.status-current {
             box-shadow: 0 0 0 3px rgba(19,89,166,.25);
         }
     </style>

<body id="bodyProjectList" class="hold-transition skin-blue-light sidebar-mini fixed">

    <%--Added by pradip on 11-08-2022--%>
    <%--<div id="bodyProjectList"> </div>--%>
    <%--End by pradip on 11-08-2022--%>

    <%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
    <%--<div id="divProjectList" >--%>

    <%-- <div class="clsShowHide" >--%>
    <div class="clsShowHide" id="maindiv">
        <%--  /*End of Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
        <!-- Content Wrapper. Contains page content -->
        <div class="">
            <!--filter_panel_section-->
            <section class="content" id="sectionProjectList">
                <!--Add New Project Section Starts here-->
                <div class="row" style="margin-top: 10px;">
                    <div class="col-sm-5 form-inline">
                        <%If m_blnAddAccess = True Then%>
                        <!--modified by pradip on 09-04-2020-->

                        <button class="btn borderbtn addproject" onclick="addproject();"><i class="fa fa-plus"></i>&nbsp;&nbsp;<span><%= MyBase.GetResourceString("C_AddNewProject") %></span></button>
                        <!--added by pradip on 09-04-2020-->
                        <%End If %>
                        <!--added by pradip on 09-04-2020-->
                        <div class="input-group flex-nowrap srchprolist">

                            <%-- Added By Vyankat B. on 19-Jun-2026 to invoke search functionality on Enter key press --%>
                            <input id="srchprolistfield" type="text" placeholder="Search.." class="form-control input-sm" autocomplete="off"
                             onkeypress="return handleSearchEnter(event);" />
                          <%-- End of Added By Vyankat B. on 19-Jun-2026 --%>

                            <%-- onkeypress="myFunction()--%>
                            <span class="btn btn-default" type="button" style="height: 30px;" onclick="myFunction()"><i class="fas fa-search" data-bs-toggle="tooltip" data-bs-container="body" title="Click For Search"></i></span>
                        </div>
                        <!--End added by pradip-->
                    </div>
                    <div class="col-sm-6">
                        <div class="form-inline float-end">
                            <label id="lblOpenProjectNote" class="mr-2" style="visibility: visible; color: red;">Note : By Default Open Projects are shown. </label>
                        </div>
                    </div>
                    <div class="col-sm-1">
                        <div class="">
                            <div class="filter float-end col-sm-offset-1">
                                <button id="btnAdvancedFilter" data-bs-toggle="collapse" class="initial" data-bs-target="#filterpanel"><i data-bs-toggle="tooltip" data-bs-placement="top" title="Filters" class="fas fa-filter"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <!--Add New Project Section Starts here-->
                <!--filter_panel_section_satrts_here-->
                <div id="filterpanel" class="collapse filterpanel">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                        <div class="row">
                            <div class="col-md-7 col-sm-7">
                                <div class="cust_tabpanel">
                                    <ul class="nav nav-tabs">
                                        <li id="tabMyFilter" class="dropdown show"><a class="dropdown-toggle" href="#" data-bs-toggle="dropdown"><%= MyBase.GetResourceString("C_MyFilters") %> </a>
                                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                            </ul>
                                        </li>
                                        <li id="tabBasicFilter"><a href="#basicfilter" data-bs-toggle="tab"><%= MyBase.GetResourceString("C_BasicFilters") %></a>
                                        </li>
                                        <%--<li><a href="#queryfilter" data-bs-toggle="tab">Advanced Filters</a>
                                    </li>--%>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-5 col-sm-5">
                                <div class="form-inline float-end">
                                    <label id="lblAppliedFilter" class="mr-2">
                                        <%= MyBase.GetResourceString("C_AppliedFilter") %> : <span id="appliedfiltername" data-bs-toggle="tooltip" data-bs-placement="top auto" data-bs-container="body" title="applied filter"></span>
                                        <input type="hidden" id="appliedfilter" />
                                        <input type="hidden" id="queryText" />
                                        <input type="hidden" id="editqueryid" />
                                        <input type="hidden" id="editqueryname" />
                                        <input type="hidden" id="editquerytext" />
                                    </label>
                                    <button id="btnClearAllFilters" class="btn borderbtn mrOnehalf clearfilterbtn" data-bs-toggle="tooltip" data-bs-placement="top" title="Reset Filters" onclick="ClearAllFilters()"><%= MyBase.GetResourceString("C_ClearAllFilters") %></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="issuefilter_container">
                        <div class="tab-content issuefilter_tabcontent">
                            <!--<div id="MyFilters" class="tab-pane active">
                                </div>-->
                            <div id="basicfilter" class="tab-pane">
                                <!--filter panel start here-->
                                <div class="filterpanelwrapbasicfilter">
                                    <div class="filterpanelbody" id="accordion">
                                        <div style="text-align: center">
                                            <label class="editFilter" id="lblBasicFilterEdit" style="display: inline-block;"></label>
                                        </div>
                                        <div class="fp_button text-center hidden-xs centerbtn" style="margin: 0 0 30px;">
                                            <button class="btn btnyellow" id="svfilterbtnTop" data-bs-toggle="modal" onclick="SaveAndApply()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_SaveandApply") %></button>
                                            <button class="btn btnyellow" id="applyfilterbtnTop" onclick="ApplyWOSave()"><%= MyBase.GetResourceString("C_Apply") %></button>
                                        </div>
                                        <div class="row hidden-xs IB_filterlist">
                                            <div class="form-inline">
                                                <div class="form-group p1" style="text-align: right">

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Over") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterOver", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterOver", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'",,,) %>
                                                        </div>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Billable") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterBillable", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select' style=''",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterBillable", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_AbbreviatedName") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterShortJobTitle", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPRFilterShortJobTitle", "txtPRFilterShortJobTitle", "form-control",,,,,,,,,, "autocomplete='off'",,,,,,, True) %>
                                                        </div>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_ProjectCode") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterProjectCode", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPRFilterProjectCode", "txtPRFilterProjectCode", "form-control",,,,,,,,,, "autocomplete='off'",,,,,,, True) %>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_ProjectName") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterProjectName", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPRFilterProjectName", "txtPRFilterProjectName", "form-control",,,,,,,,,, "autocomplete='off'",,,,,,, True) %>
                                                        </div>

                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_DraftOrConverted") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterDraftOrConverted", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterDraftOrConverted", "usp_Whizible2_Sel_Filter_DraftOrConverted ",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_ProjectGroup") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterProjectGroupID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterProjectGroupID", "usp_Whizible2_sel_PID_tbl_PM_ProjectGroup",,, "class='form-select'",,,) %>
                                                        </div>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_CommercialDetails") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterContractType", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterContractType", "usp_Whizible2_Sel_GetContractTypes ",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_StartDate") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterExpectedStartDate", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPRFilterExpectedStartDate", "txtPRFilterExpectedStartDate", "form-control",,,,,, ,,,, "autocomplete='off'",,, True,,,,) %>
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </div>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_EndDate") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterExpectedEndDate", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPRFilterExpectedEndDate", "txtPRFilterExpectedEndDate", "form-control",,,,,, ,,,, "autocomplete='off'",,, True,,,,) %>
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Currency") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterBaseCurrency", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterBaseCurrency", "usp_Whizible2_Sel_tbl_PM_CurrencyMaster",,, "class='form-select'",,,) %>
                                                        </div>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_ProjectStatus") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterProjectStatusID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterProjectStatusID", "usp_Whizible2_Sel_tbl_CNF_ProjectStatus ",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_BusinessGroup") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterBusinessGroupID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterBusinessGroupID", "usp_Whizible2_Sel_tbl_CNF_BusinessGroup",,, "class='form-select'",,,) %>
                                                        </div>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_OrganizationUnit") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterLocationID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterLocationID", "usp_Whizible2_sel_tbl_PM_Location_Location",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Practice") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterProjectTypeID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterProjectTypeID", "usp_Whizible2_sel_tbl_PRS_ProjectTypes_ProjectType",,, "class='form-select'",,,) %>
                                                        </div>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_Customer") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterCustomerID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterCustomerID", "usp_Whizible2_Sel_tbl_PM_Customer ",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label"><%= MyBase.GetResourceString("C_ProjectType") %></label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterMainProjectTypeID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterMainProjectTypeID", "usp_Sel_tbl_PRS_Main_ProjectType",,, "class='form-select'",,,) %>
                                                        </div>
                                                        <%-- Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT --%>
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label">Delivery Unit</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterResourcePoolID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterResourcePoolID", "usp_whizible2_sel_tbl_PM_DeliveryUnit",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>


                                                    <div class="row mb-3">
                                                        <div class="form-group col-sm-6">
                                                            <label class="control-label">Delivery Team</label>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboPRFilterResourceGroupID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtPRFilterResourceGroupID", "usp_whizible2_sel_tbl_PM_DeliveryTeam",,, "class='form-select'",,,) %>
                                                        </div>
                                                    </div>

                                                    <%--End of Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT --%>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="fp_button text-center hidden-xs centerbtn">
                                            <button class="btn btnyellow" id="svfilterbtnBottom" data-bs-toggle="modal" onclick="SaveAndApply()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_SaveandApply") %></button>
                                            <button class="btn btnyellow" id="applyfilterbtnBottom" onclick="ApplyWOSave()"><%= MyBase.GetResourceString("C_Apply") %></button>
                                        </div>
                                    </div>
                                </div>
                                <!--filter panel end here-->
                                <br />
                                <br />
                            </div>


                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <!-- Modal -->
                <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modalsmall ui-draggable">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header ui-draggable-handle">
                                <button type="button" class="close" data-bs-dismiss="modal">×</button>
                                <h4 class="modal-title">Confirmation</h4>
                            </div>
                            <div class="modal-body">
                                <input type="text" id="deleteid" hidden="hidden" />
                                <input type="text" id="deletetype" hidden="hidden" />
                                <input type="text" id="projecttype" hidden="hidden" />
                                <p id="deleteConfirmMsg"></p>
                            </div>
                            <div class="modal-footer">
                                <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal">No</button>
                                <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <!--save_filter-popup-->
                <!-- Modal -->
                <div class="modal custmodal Issuesave_filter fade" id="prjsavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modalsmall ui-draggable" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="">Save Filter As</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <!--save_filter_As-->
                                <div id="Issuesavrefilterbox" class="box-panel">
                                    <div class="box-body graybg">
                                        <div class="form-group mb-0">
                                            <div class="row">
                                                <div class="col-md-12 "> 
                                                    <div class="row">
                                                    <label class="col-md-4 p-0 text-end">Filter Name :<span style="color: red">*</span></label>
                                                    <div class="col-md-8">
                                                        <input id="newfiltername" type="text" class="form-control" name="" /><br />
                                                       
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="btnrow">
                                                            <button id="btnSaveFilter" onclick="SaveFilter()" class="btn btnyellow float-start">Save</button>
                                                            <button id="btnCancelSave" data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
                                                        </div> 
                                        </div>
                                    </div>
                                </div>
                                <!--save_filter_As-->
                                <!-- /.content -->
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--modalendhere-->

                <!--save_filter--popup_end-->



                <!--Model For History-->
                <div class="modal custmodal  fade" id="approval_status_history" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ApproverHistory") %></h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div id="historybody" class="modal-body">



                                <!-- /.content -->
                                <div class="clearfix"></div>
                            </div>
                            <div class="modal-footer">
                                <div class="btnrow btnrow text-end col-sm-12">
                                    <button data-bs-dismiss="modal" class="btn borderbtn">Ok</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--filter_panel_section_end-->


                <!-- Main content -->
                <!--Project Detail Table starts here-->
                <div class="bgwhitewrap">
                    <div class="MainDiv">
                        <table id="tblprojectlist" class="table bgwhite table-bordered table-fixed-header project-detail-table">
                            <thead>
                                <tr>
                                    <th id="ProjectName" class="sorting" rowspan="2" style="width: 23%!important;"><%= MyBase.GetResourceString("C_ProjectName") %> <i class="fas fa-sort"></i></th>
                                    <th id="ProjectStatus" class="sorting" rowspan="2"><%= MyBase.GetResourceString("C_Status") %> <i class="fas fa-sort"></i></th>
                                    <th id="Location" class="sorting" rowspan="2"><%= MyBase.GetResourceString("C_OrganizationUnit") %> <i class="fas fa-sort"></i></th>
                                    <th id="ExpectedDuration" class="sorting" rowspan="2"><%= MyBase.GetResourceString("C_Duration") %> <i class="fas fa-sort"></i></th>
                                    <th id="approvalstatus" rowspan="2"><%= MyBase.GetResourceString("C_ApprovalStatus") %></th>
                                    <th colspan="3"><%= MyBase.GetResourceString("C_Health") %></th>
                                    <%If m_blnEditAccess = True Or m_blnDeleteAccess = True Then%>
                                    <th rowspan="2" style="width: 6%;">Action
                                    </th>
                                    <%ELSE %>
                                    <%-- //Added By Dipali V On 19th June 2020 For Issue ID 25225--%>

                                    <th rowspan="2" style="width: 6%;"></th>
                                    <%End If%>
                                    <%-- //End of Added By Dipali V On 19th June 2020 For Issue ID 25225--%>
                                </tr>
                                <tr>
                                    <th>
                                        <%-- Commented and Added By Rehan C for ToolTip Issue on 21st Mar 2023 --%>
<%--                                        <button class="nostylebtn projectname" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Project Cost">--%>                                        
                                            <button class="nostylebtn projectname" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Project Cost">
                                        <%-- End OfComment and Added By Rehan C for ToolTip Issue on 21st Mar 2023 --%>
                                            <%--//Added By Dipali V On 19th Jun 2020 For TOOLTIP--%>
                                            <img src="../../../Whizible2.0-new/dist/img/rupee.svg" alt="Cost" width="16" title="" />
                                        </button>
                                    </th>
                                    <th>
                                        <%-- Commented and Added By Rehan C for ToolTip Issue on 21st Mar 2023 --%>
<%--                                        <button class="nostylebtn projectname" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Project Schedule">--%>
                                            <button class="nostylebtn projectname" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Project Schedule">
                                        <%-- End OfComment and Added By Rehan C for ToolTip Issue on 21st Mar 2023 --%>
                                        
                                            <%--//Added By Dipali V On 19th Jun 2020 For TOOLTIP--%>
                                            <img src="../../../Whizible2.0-new/dist/img/schedule.svg" alt="Schedule" width="20" title="" />
                                        </button>
                                    </th>
                                    <th>
                                        <%-- Commented and Added By Rehan C for ToolTip Issue on 21st Mar 2023 --%>
                                        <%--<button class="nostylebtn projectname" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Project Efforts">--%>
                                        <button class="nostylebtn projectname" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Project Efforts">
                                        <%-- End OfComment and Added By Rehan C for ToolTip Issue on 21st Mar 2023 --%>                                        
                                            <%--//Added By Dipali V On 19th Jun 2020 For TOOLTIP--%>
                                            <img src="../../../Whizible2.0-new/dist/img/efforts.svg" alt="Efforts" width="20" title="" />
                                        </button>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tbodyprojectlist">
                            </tbody>
                        </table>
                    </div>

                </div>

                <%--modified div by pradip on 22-10-2020 for JD--%>
                <div class="cstm_pagination" style="margin-top: 5px">


                    <div class="buttons">

                        <%--Commented and Added By Reshma Chavan on 5th Nov 2020 for JD-28075--%>
                        <%--<span class="spntotal" id="TotalRecords"></span>--%>
                        <span id="" class="spntotal">Total Records : </span>
                        <span class="spntotal" id="TotalRecords"></span>
                        <%--End of Commented and Added By Reshma Chavan on 5th Nov 2020 for JD-28075--%>
                    </div>
                    <div class="buttons" id="Pagination">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-end" style="margin: 0px!important">
                                <li class="page-item" id="btnprevious">
                                    <a class="page-link" aria-label="Previous" onclick='PrevList()' data-bs-toggle="tooltip" title="Previous" id="LinkPrevious">
                                        <%--Added By Reshma Chavan on 5th Nov 2020 for JD-28075--%>
                                        <i class="fas fa-angle-double-left"></i>
                                        <%--End of Added By Reshma Chavan on 5th Nov 2020 for JD-28075--%>
                                    </a>
                                </li>
                                <li class="page-item" id="btnnext">
                                    <a class="page-link" aria-label="Next" onclick='NextList()' data-bs-toggle="tooltip" title="Next" id="LinkNext">
                                        <%--Added By Reshma Chavan on 5th Nov 2020 for JD-28075--%>
                                        <i class="fas fa-angle-double-right"></i>
                                        <%--End of  Added By Reshma Chavan on 5th Nov 2020 for JD-28075--%>
                                    </a>
                                </li>
                            </ul>
                            <%--modified by pradip on22-10-2020 for JD issue--%>
                        </nav>

                    </div>
                </div>
                <%-- End of Commented and added by Chetan M on 16th Sept 2020 for Performance Issue --%>

                <%--</div>--%>
                <!--Project detaion section ends here-->
            </section>
            <section class="content" id="sectionNoData" style="display: none">
                <div class="row">
                    <p class="nodata"><%= MyBase.GetResourceString("C_NoAccess") %></p>
                </div>
            </section>
        </div>
        <!-- /.content-wrapper -->
    </div>

    <!-- ./wrapper -->

    <!-- Commented by Madhuri.K for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>

    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    
    <script src="../../../Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <script src="../../../Whizible2.0-new/Plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonFunctions.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> -->
    <%--<link href="../../General/loaderStylesheet.css" rel="stylesheet" />--%>
    <%-- <link href="../../General/Overlay.css" rel="stylesheet" />--%>

    <script src="../../../Whizible2.0-new/dist/js/Project_ProjectList.js?v=1.2.5.6"></script>
    <!-- <script src="../../../Whizible2.0-new/dist/js/common_filters.js?v=1.2.9"></script> -->
    <!-- <script src="../../../Whizible2.0-new/dist/js/custom.js"></script> -->

    <script>

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();

        //Added By Riddhesh Patil on 11-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        //alert(strUrl);
        var EmployeeID;
        var UserName;
        var LoginID;
        var loginType;
        var roleLevel;
        var costh, schth, effth;
        var costR, costA, costG;
        var schR, schA, schG;
        var effR, effA, effG;
        var pnlen = 40;
        var page = 1;
        //Commented and added by Chetan M on 17 Sept 2020 for Performance Issue
        //var pagesize = 10;
        var pagesize = 50;
        //End of Commented and added by Chetan M on 17 Sept 2020 for Performance Issue
        var orderby = '';
        var module = "PR";
        var hdnQueryText = "";
        //Added by Chetan M on 16 Sept 2020 for Performance Issue
        var intPageNo = 1;
        var GlobalProjectCount = 1;
            //End of Added by Chetan M on 16 Sept 2020 for Performance Issue
            //var AllFields = ["Over", "ShortJobTitle", "ProjectCode", "ProjectName", "Description", "ProjectGroupID", "Billable", "ContractType", "ExpectedStartDate", "ExpectedEndDate", "EstimatedEfforts", "ExpectedDuration", "ContractValue", "BaseCurrency", "BusinessGroupID", "LocationID", "ProjectTypeID", "CustomerID", "ProjectSize", "FundedBy", "LifeCycleID", "ProjectSizeUnitID", "ProposalNo", "ProjectStatusID"];
            <%--Commented and Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT --%>
        //var AllFields = ["Over", "ShortJobTitle", "ProjectCode", "DraftOrConverted", "ProjectName", "ProjectGroupID", "Billable", "ContractType", "ExpectedStartDate", "ExpectedEndDate", "BaseCurrency", "BusinessGroupID", "LocationID", "ProjectTypeID", "CustomerID", "ProjectStatusID", "MainProjectTypeID"];
        var AllFields = ["Over", "ShortJobTitle", "ProjectCode", "DraftOrConverted", "ProjectName", "ProjectGroupID", "Billable", "ContractType", "ExpectedStartDate", "ExpectedEndDate", "BaseCurrency", "BusinessGroupID", "LocationID", "ProjectTypeID", "CustomerID", "ProjectStatusID", "MainProjectTypeID", "ResourcePoolID", "ResourceGroupID"];
            <%--End of Commented and Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT --%>
        EmployeeID = '<%=m_UserId %>';
        UserName = '<%= m_UserName %>';
        LoginID = '<%= m_LoginID %>';
        loginType = '<%= m_LoginType %>';
        roleLevel = '<%= m_RoleLevel%>'
        $(document).ready(function () {

           
            //Initialize bootstrap tooltips
           

               // debugger;
 				<%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
                $("#divProjectList").removeClass("center");
                $("#divProjectList").removeClass("preloader");
                $("#maindiv").removeClass('clsShowHide');

                StopAjaxLoader("#divProjectList1");

                 <%--  /*End of Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
                var isView = '<%=m_blnViewAccess%>';
                if (isView == false || isView == "False") {
                    $('#sectionProjectList').hide();
                    //Commented And Added By Usha Pandit On 08.01.2020 for UI if view access is not htere
                    //$('#sectionNoData').css('display', 'block');
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;width: 100%;background-color:white;padding-top:3%;"><strong><center>You are not authorized to view this record. </center></strong></div>';
                    $('#divProjectList').html(bodyHTML);
                    //End Of Added By Usha Pandit On 08.01.2020 for UI if view access is not htere
                    return;
                }
                StartLoader("#bodyProjectList");
                $('[data-bs-toggle="tooltip"]').click(function () {
                    $('[data-bs-toggle="tooltip"]').tooltip("hide");

                });
                updateOptions();
                getHealthThreshold();

                getProjectHealthThreshold();
                getDefaultFilter();
                getProjectList();
                
                //Uncommented By Reshma Chavan on 17th Dec 2021 For not getting Apply filter
                getMyFilters();
                //End Uncommented By Reshma Chavan on 17th Dec 2021 For not getting Apply filter
                // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment
                
            });

        $(function () {
           
            // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment
            $('[data-bs-toggle="tooltip"]').tooltip({
                container: 'body',
               
            });

        });

        $(window).on('click', function () {
            $("#MyFiltersdropdown").hide();
            try {
                event.stopPropagation();
            }
            catch (ex) {

            }
        });

        $("#txtPRFilterExpectedStartDate,#txtPRFilterExpectedEndDate").datepicker(
            {
                dateFormat: "dd-M-yy",
            }
        );
        $('[data-bs-toggle="tooltip"]').tooltip({ trigger: "hover" });
        $(".history").tooltip();

        //Table header freezed
        //var height = $(window).height();
        //$(".project-detail-table").css({ "height": height - 140, "overflow-y": "auto" });
        //$('.project-detail-table').scroll(function (e) {
        //    $('.table-responsive thead').css("top", -$(".table-responsive tbody").scrollTop());
        //    $('.table-responsive thead tr th').css("top", $(".table-responsive table").scrollTop());

        //});

        //script for approver character trim
        $(".approvers").each(function (i) {
            var len = $(this).text().length;
            if (len > 25) {
                $(this).text($(this).text().substr(0, 25) + '..');
            }
        });

        //for hiding arrow if only one item in carousel
        // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Next/Prev handling)
        $('.checkbox-container').each(function () {
            if ($(this).find('.carousel-inner .carousel-item').length == 1) {
                var containerid = $(this).attr("id");
                $("#" + containerid).find('.carousel-control').hide()
            }
        });

        //$('#MyFiltersdropdown').on('click', function (e) {
        //    e.stopPropagation();
        //});

        // Initialize Bootstrap carousel depending on version (jQuery plugin in v3/4, class API in v5+)
        try {
            if ($ && $.fn && $.fn.carousel) {
                // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Carousel init for Next/Prev)
                $('.carousel').carousel({ interval: false });
                $('.myCarousel').on('slid.bs.carousel', checkitem);
            } else if (window.bootstrap && bootstrap.Carousel) {
                document.querySelectorAll('.carousel').forEach(function (el) {
                    // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Carousel init for Next/Prev)
                    new bootstrap.Carousel(el, { interval: false });
                    el.addEventListener('slid.bs.carousel', checkitem);
                });
            }
        } catch (e) { }


        // Added By Vyankat B. on 19-Jun-2026 to invoke search on Enter key press
        function handleSearchEnter(event) {
           // debugger
            if (event.key === "Enter") {
                myFunction();
                return false;
            }
        }
        // End of Added By Vyankat B. on 19-Jun-2026 to invoke search on Enter key press


        function checkitem() {
            var $this = $('.myCarousel1');
            // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Next/Prev handling)
            if ($('.carousel-inner .carousel-item:first').hasClass('active')) {
                $this.children('.carousel-control-prev').hide();
                $this.children('.carousel-control-next').show();
            } else if ($('.carousel-inner .carousel-item:last').hasClass('active')) {
                $this.children('.carousel-control-next').hide();
                $this.children('.carousel-control-prev').show();
            } else {
                $this.children('.carousel-control').show();
            }
        }
        
        // Initialize carousel controls for each project
        function initProjectCarousel(projectId) {
            var $carousel = $('#status' + projectId);
            if ($carousel.length === 0) return;
            
            // Initialize Bootstrap 5 carousel
            var carousel = new bootstrap.Carousel($carousel[0], {
                interval: false,
                ride: false,
                wrap: false
            });
            
            // Set up arrow visibility
            function toggleArrows() {
                var $items = $carousel.find('.carousel-inner .carousel-item');
                var $active = $items.filter('.active');
                var $prev = $carousel.find('.carousel-control-prev');
                var $next = $carousel.find('.carousel-control-next');
                
                if ($items.length <= 1) {
                    $prev.hide();
                    $next.hide();
                    return;
                }
                
                var isFirst = $items.first().is($active);
                var isLast = $items.last().is($active);
                
                if (isFirst) {
                    $prev.hide();
                    $next.show();
                } else if (isLast) {
                    $next.hide();
                    $prev.show();
                } else {
                    $prev.show();
                    $next.show();
                }
            }
            
            // Initial arrow setup
            toggleArrows();
            
            // Update arrows on slide change
            $carousel.on('slid.bs.carousel', toggleArrows);
        }
        
        // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment
        $('[data-bs-toggle="tooltip"]').tooltip();

        $(".closetab").click(function () {
            var tabid = $(this).closest('.tab').attr("id");
            $("#" + tabid).hide();
        });
        //Clear Query Filter

        function closeMS(pid) {
            $("#milestone_detail_milestone" + pid).hide();
        }

        function closeAS(pid) {
            $("#tab_tab" + pid).hide();
        }

        //clearfilter
        $('.clearfilterbtn').click(function () {
            $('.custom_chckbox_markblue input[type="checkbox"]').not(this).prop('checked', false).parents('#MyFiltersdropdown li').removeClass('activefilter');
        });

        //remove previous checkbox


        $('input.myfilter_selectprocheckbox').on('change', function () {
            $('input.myfilter_selectprocheckbox').not(this).prop('checked', false).parents('#MyFiltersdropdown li').removeClass('activefilter');
        });


        $('#MyFiltersdropdown li .customradio input[type="checkbox"]').click(function () {
            if ($(this).prop("checked") == true) {
                $(this).parents('#MyFiltersdropdown li').addClass('activefilter');
                $(this).parents('#MyFiltersdropdown li').find('.checkmark').tooltip('hide')
                    .attr('data-original-title', 'Removed Default Filter')
                //.tooltip('show');
            }
            else if ($(this).prop("checked") == false) {
                $(this).parents('#MyFiltersdropdown li').removeClass('activefilter');
                $(this).parents('#MyFiltersdropdown li').find('.checkmark').tooltip('hide')
                    .attr('data-original-title', 'Set Default filter')
                //.tooltip('show');
            }
        });

        /*when a user selects interest in an addtional service, add this to the additionalServices div*/
        $('#MyFiltersdropdown li .customradio input[type="checkbox"]').bind('change', function () {
            //debugger;
            var alsoInterested = '';
            $('input[type="checkbox"]').each(function (index, value) {
                if (this.checked) {
                    /*add*/ /*get label text associated with checkbox*/
                    alsoInterested += ($('span[for="' + this.name + '"]').html() + ', ');
                }
            });

            if (alsoInterested.length > 0) {
                alsoInterested = '' + alsoInterested.substring(0, alsoInterested.length - 2) + '.';
            } else {

            }

            //$('.filterproname').html(alsoInterested);
            //$('#filterpanel').addClass('in');
        });

        //filter-table


        $('.sorting').click(function () {
            $(".tab").hide();
            $(".milestone-detail").hide();
            $(".collapse").removeClass("show");
            $('.project-detail-table thead > tr').find("th.cell,th.monthcolumn").remove();
            $('.project-detail-table tbody > tr').find("td.cell").remove();
            var id = $(this).attr("id");

            //var table = $(this).parents('table').eq(0);
            //var rows = table.find('tr:gt(1)').toArray().sort(comparer($(this).index()))
            //this.asc = !this.asc;
            //if (!this.asc) {
            //    rows = rows.reverse();
            //}
            //for (var i = 0; i < rows.length; i++) {
            //    table.append(rows[i]);
            //}
            this.asc = !this.asc;
            var sort = " ASC";
            if (this.asc) sort = " DESC";
            orderby = id + sort;
            page = 1;
            getProjectList();
           
        });

        function comparer(index) {
            return function (a, b) {
                var valA = getCellValue(a, index), valB = getCellValue(b, index)
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
            }
        }
        function getCellValue(row, index) { return $(row).children('td').eq(index).text() }

        $('body').tooltip({
            selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
        });

        /*Start - Changes by Mangesh*/
        var ajaxResult;

        function AJAXCallWithResult(url, param, async) {
            StartLoader("#bodyProjectList");
            $.ajax({
                url: strUrl + url,
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
                    ajaxResult = data;
                    StopAjaxLoader("#bodyProjectList");
                },
                error: function (err) {
                    StopAjaxLoader("#bodyProjectList");
                    ajaxResult = undefined;
                    console.log(err);
                }
            });

            return ajaxResult;

        }
        function ajaxCall(url, type, contentType, dataType, data) {
            var ajaxResult;

            $.ajax({
                url: url,
                type: "POST",
                data: data,
                async: false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (data) {
                        xhr.setRequestHeader("Params", encryptString(isJson(data) ? data : JSON.stringify(data)));
                    }
                },
                success: function (data) {

                    ajaxResult = data;
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });

            return ajaxResult;
        }

        var IsData = 0;
        function getProjectList() {

            var qtext = "";
            if (searchtext != undefined) {
                //Commented And Added By Reshma Chavan on 15Jan 2021 For Search Filter IssueID-28988                 
                //qtext = searchtext;
                //qtext= 'ProjectName Like "%'+searchtext +'%"';
                qtext = $('#queryText').val();
                qtext = 'ProjectName Like "%' + searchtext + '%" AND ' + qtext + '';
                qtext = qtext.replace(/"/g, "''");
                //End of Commented And Added By Reshma Chavan on 15Jan 2021 For Search Filter IssueID-28988                 
            } else {
                qtext = $('#queryText').val();
            }

            //qtext = qtext.replace("undefined","abc 24");

            var projectParameters = {
                intEmployeeID: EmployeeID,
                LoginType: loginType,
                QueryText: qtext,
                PageNumber: page,
                PageSize: pagesize,
                OrderBy: orderby,
                UserName: UserName,
            }
            var param = JSON.stringify(projectParameters);
            //alert(param);
            // StartLoader("#bodyProjectList1");
            $.ajax({
                url: strUrl + "/api/PM_ProjectList/GetProjectListPaging",
                type: "POST",
                data: param,
                async: false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    if (data != undefined) {
                        //debugger;
                        StartLoader("#bodyProjectList");

                        $('#tbodyprojectlist').html('');
                        var strHtml = '';
                        var lstData = data.projectList;
                        var paging = data.pagingInfo;
                        //Added & Commented By Dipali V On 19th Oct 2020 For Pagination Issues
                        //generatePagination(paging);
                        $("#TotalRecords").html("");
                        $("#TotalRecords").html(paging.TotalRecords);
                        GlobalProjectCount = paging.TotalRecords;
                        //End of Added & Commented By Dipali V On 19th Oct 2020 For Pagination Issues
                        for (var i = 0; i < lstData.length; i++) {
                            var d = lstData[i];
                            var CurrentWFStatus = GetWFColor(d.ProjectID, d.CurrentWFStatus)
                            // alert(d);
                            IsData = 1;//Added By Dipali V On 19th Oct 2020 For Check Project Data Exist or not
                            var pname = (d.ProjectName.length > pnlen ? d.ProjectName.substr(0, pnlen) + "..." : d.ProjectName);
                            strHtml += '<tr>';
                            strHtml += '<td class="text-start">';
                            //strHtml += '<span class="label label-default">' + d.ProjectCode + '</span>';
                            //strHtml += '<span>  </span> <span class="f_smaller">[' + d.ExpectedStateDate + ' - ' + d.ExpectedEndDate + ']</span><br/>';
                            //strHtml += d.ProjectName + '</td>';
                            strHtml += '<span class="label label-default">' + d.ProjectCode + '</span><br/>';
                            strHtml += '<span class="pL_name" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container=".pL_name" title="' + d.ProjectName + '">' + pname + '</span><br/>';
                            strHtml += '<span class="f_smaller">[' + d.ExpectedStateDate + ' - ' + d.ExpectedEndDate + ']</span>';
                            strHtml += '<td><img data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"';
                            strHtml += getStatusIcon(d.ProjectStatus);
                            strHtml += 'alt = "" width = "26"  title = "' + d.ProjectStatus + '" > ';
                            strHtml += '</td>';
                            strHtml += '<td class="text-start">' + d.OUName + '</td>';
                            if (d.DraftOrConverted == 'C') {
                                strHtml += '<td>';
                                strHtml += '<div class="progress" id="milestone' + d.ProjectID + '" onclick="selectedmilestone(this);">'
                                if (d.PercentageCompletion >= 100) {
                                    strHtml += '<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="' + d.PercentageCompletion + '" aria-valuemin="0" aria-valuemax="100" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-bs-title="' + d.PercentageCompletion + '%"';
                                    strHtml += 'style = "width:100%" > ';
                                }
                                else {
                                    strHtml += '<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="' + d.PercentageCompletion + '" aria-valuemin="0" aria-valuemax="100" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-bs-title="' + d.PercentageCompletion + '%"';
                                    strHtml += 'style = "width:' + d.PercentageCompletion + '%" > ';
                                }
                                strHtml += d.Duration + '</div > ';
                                strHtml += '</div>';
                                strHtml += '</td>';
                                var pname = d.ProjectName.replace(/\'/g, '`');
                                //Commented AND Added by Vaijat 12-12-2020
                                //strHtml += getApprovalColumn(d.ProjectID, pname);
                                strHtml += "<td id='td" + d.ProjectID + "' projectName='" + pname + "' class='text-center' >"
                                // strHtml += "<a onclick=ShowProjectDetails(" + d.ProjectID + ") >Show</a>"
                                //strHtml += "<a onclick=\"ShowApprovalColumn('" + d.ProjectID + "', '" + d.CurrentWFStatus + "')\">Show</a>"
                                strHtml += "<a>" + CurrentWFStatus + "</a>"
                                strHtml += "</td>"
                                //End of commented
                                strHtml += '<td>';
                                //strHtml += '<button class="btn ' + getHealth("c", d.CostPercentage) + '" ';
                                strHtml += '<button class="btn ' + getProjectHealth("c", d.CostPercentage) + '" ';
                                strHtml += 'data-bs-toggle="tooltip" title = ' + d.CostPercentage + '% data-bs-placement="top"  data-bs-container="body" > ';
                                strHtml += '</button>';
                                strHtml += '</td>';
                                strHtml += '<td>';
                                //strHtml += '<button class="btn ' + getHealth("s", d.SchedulePercentage) + '" ';
                                strHtml += '<button class="btn ' + getProjectHealth("s", d.SchedulePercentage) + '" ';
                                strHtml += 'data-bs-toggle="tooltip" title = ' + d.SchedulePercentage + '% data-bs-placement="top"  data-bs-container="body" > ';
                                strHtml += '</button>';
                                strHtml += '</td>';
                                strHtml += '<td>';
                                //strHtml += '<button class="btn ' + getHealth("e", d.EffortPercentage) + '"  ';
                                strHtml += '<button class="btn ' + getProjectHealth("e", d.EffortPercentage) + '"  ';
                                strHtml += 'data-bs-toggle="tooltip" title = ' + d.EffortPercentage + '% data-bs-placement="top"  data-bs-container="body"> ';
                                strHtml += '</button>';
                                strHtml += '    <p class="dropdown-menu hide" id="popover-content-2">';
                                strHtml += '        <strong>Efforts</strong><br/>';
                                strHtml += '        <i>Running good on effort</i>';
                                strHtml += '    </p>';
                                strHtml += '</td>';
                                strHtml += '<td>';
                                    //Commented And Added By Usha Pandit On 30.12.2020 For setting correct access for Create Project / Project information
                           <%-- <%If m_blnEditAccess = True Then%>
                                    strHtml += '<button onclick="EditProject(' + d.ProjectID + ', &quot;' + d.ProjectName + '&quot;, &quot;' + d.DraftOrConverted + '&quot;)" class="nostylebtn projectname"><img data-bs-toggle="tooltip" data-bs-placement="top"  src="../../../Whizible2.0-new/dist/img/edit.svg" alt="edit" width="16" title="Edit" data-bs-container="body"></button>';
                            <%End If%>--%>
                                     <%If m_blnEditAccess = True Or m_blnViewAccess = True Then%>
                                    //Commented & Added By Dipali  V On 13th Jan for Icon Change
                                    //strHtml += '<button onclick="EditProject(' + d.ProjectID + ', &quot;' + d.ProjectName + '&quot;, &quot;' + d.DraftOrConverted + '&quot;)" class="nostylebtn projectname"><img data-bs-toggle="tooltip" data-bs-placement="top"  src="../../../Whizible2.0-new/dist/img/edit.svg" alt="edit" width="16" title="Edit" data-bs-container="body"></button>';
                                    strHtml += '<button onclick="EditProject(' + d.ProjectID + ', &quot;' + d.ProjectName + '&quot;, &quot;' + d.DraftOrConverted + '&quot;)" class="nostylebtn projectname"><img data-bs-toggle="tooltip" data-bs-placement="top" src="../../../Whizible2.0-new/dist/img/eye.svg" alt="Select/Edit" width="20" title="Select / Edit" data-bs-container="body"></button>';
                                    //End of Commented & Added By Dipali  V On 13th Jan for Icon Change
                                    <%End If%>
                                    //End Of Added By Usha Pandit On 30.12.2020 For setting correct access for Create Project / Project information
                            <%If m_blnDeleteAccess = True Then%>

                                    //Commented And Added By Usha Pandit On 13.04.2020 For checking if project is in use or not
                                    //strHtml += '<a href="#" data-bs-toggle="tooltip" title ="Delete" data-bs-placement="top auto"  data-bs-container="body">';
                                    //strHtml += '<i class="far fa-trash-alt" onclick="btnDelete(' + d.ProjectID + ', &quot;C&quot;)"></i></a > ';

                                    if (d.ProjectIsInUse == 1) {
                                        //Commented And Added By Usha Pandit On 22.04.2020 For showing ban-circle for delete buttons for projects in use
                                        //strHtml += '<a data-bs-toggle="tooltip" title ="Delete" data-bs-placement="top auto" data-bs-container="body">';
                                        strHtml += '<a data-bs-toggle="tooltip" title ="Delete" data-bs-placement="top" data-bs-container="body" style="cursor: not-allowed!important;">';
                                        //End Of Added By Usha Pandit On 22.04.2020 For showing ban-circle for delete buttons for projects in use
                                        strHtml += '<i class="far fa-trash-alt"></i></a > ';
                                    }
                                    else {
                                        strHtml += '<a href="#" data-bs-toggle="tooltip" title ="Delete" data-bs-placement="top auto"  data-bs-container="body">';
                                        strHtml += '<i class="far fa-trash-alt" onclick="btnDelete(' + d.ProjectID + ', &quot;C&quot;)"></i></a > ';
                                    }
                                    //End Of Added By Usha Pandit On 13.04.2020 For checking if project is in use or not

                            <%End If%>
                                    strHtml += '</td>';
                                }
                                else {
                                    strHtml += '<td>';
                                    strHtml += 'N/A';
                                    strHtml += '</td>';
                                    strHtml += '<td>';
                                    strHtml += 'N/A';
                                    strHtml += '</td>';
                                    strHtml += '<td>';
                                    strHtml += 'N/A';
                                    strHtml += '</td>';
                                    strHtml += '<td>';
                                    strHtml += 'N/A';
                                    strHtml += '</td>';
                                    strHtml += '<td>';
                                    strHtml += 'N/A';
                                    strHtml += '</td>';
                                    strHtml += '<td>';
                                    //Commented And Added By Usha Pandit On 31.12.2020 For setting correct access for Create Project / Project information
                           <%-- <%If m_blnEditAccess = True Then%>
                                    //strHtml += '<button onclick="EditProject(' + d.ProjectID + ', &quot;'+ d.DraftOrConverted +'&quot;)" class="nostylebtn projectname"><img data-bs-toggle="tooltip" data-bs-placement="top"  src="../../../Whizible2.0-new/dist/img/edit.svg" alt="edit" width="16" title="Edit" data-bs-container="body"></button>';
                                    strHtml += '<a href="#" data-bs-toggle="tooltip" title ="Edit" data-bs-placement="top auto"  data-bs-container="body" onclick="EditProject(' + d.ProjectID + ', &quot;' + d.ProjectName + '&quot;, &quot;' + d.DraftOrConverted + '&quot;)">';
                                    strHtml += '<img data-bs-toggle="tooltip" data-bs-placement="top"  src="../../../Whizible2.0-new/dist/img/edit.svg" alt="edit" width="16" title="Edit" data-bs-container="body"/></a > ';
                            <%End If%>--%>
                                     <%If m_blnEditAccess = True Or m_blnViewAccess = True Then%>
                                    //strHtml += '<button onclick="EditProject(' + d.ProjectID + ', &quot;'+ d.DraftOrConverted +'&quot;)" class="nostylebtn projectname"><img data-bs-toggle="tooltip" data-bs-placement="top"  src="../../../Whizible2.0-new/dist/img/edit.svg" alt="edit" width="16" title="Edit" data-bs-container="body"></button>';
                                    strHtml += '<a href="#" onclick="EditProject(' + d.ProjectID + ', &quot;' + d.ProjectName + '&quot;, &quot;' + d.DraftOrConverted + '&quot;)">';
                                    //Commented & Added By Dipali  V On 13th Jan for Icon Change
                                    //strHtml += '<img data-bs-toggle="tooltip" data-bs-placement="top"  src="../../../Whizible2.0-new/dist/img/edit.svg" alt="edit" width="16" title="Edit" data-bs-container="body"/></a > ';
                                    strHtml += '<img data-bs-toggle="tooltip" data-bs-placement="top"  src="../../../Whizible2.0-new/dist/img/eye.svg" alt="Select/Edit" width="20" title="Select / Edit" data-bs-container="body"/></a > ';
                                    //End of Commented & Added By Dipali  V On 13th Jan for Icon Change
                                    <%End If%>
                                    //End Of Added By Usha Pandit On 31.12.2020 For setting correct access for Create Project / Project information
                            <%If m_blnDeleteAccess = True Then%>
                                    strHtml += '<a href="#">';
                                strHtml += '<i class="far fa-trash-alt" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" data-bs-container="body" onclick="btnDelete(' + d.ProjectID + ',&quot;D&quot;)"></i></a > ';
                            <%End If%>
                                    strHtml += '</td>';
                                }
                                strHtml += '</tr>';
                                strHtml += createApprovalTab(d.ProjectID, d.ProjectName);
                                strHtml += createMilestoneTab(d.ProjectID);
                            }

                            //alert($("#tbodyprojectlist tr").length);
                            //if ($("#tbodyprojectlist tr").length == 0) {
                            //if (IsData == 0) {
                            // strHtml = "<tr><td colspan='7'>No data available in table</td></tr>"
                            //}
                            //}

                            $('#tbodyprojectlist').html(strHtml);
                            $('[data-bs-toggle="tooltip"]').tooltip();
                            //Added by Chetan M on 16 Sept 2020 for Performance Issue
                            //Pagination();
                            $("#TotalRecords").html("");
                            $("#TotalRecords").html(paging.TotalRecords);
                            GlobalProjectCount = paging.TotalRecords;
                            // alert(strHtml);
                            //End of Added by Chetan M on 16 Sept 2020 for Performance Issue
                            $('[data-bs-toggle="tooltip"]').tooltip();
                        }
                        StopAjaxLoader("#bodyProjectList");
                    },

                    error: function (err) {
                        StopAjaxLoader("#bodyProjectList");
                        console.log(err);
                    }

                });

        }

        function getStatusIcon(status) {
            var strHtml = '';
            switch (status.toLowerCase()) {
                case "closed":
                    strHtml += 'src = "../../../Whizible2.0-new/dist/img/tick-green.svg"';
                    break;
                case "ready for closure":
                    strHtml += 'src = "../../../Whizible2.0-new/dist/img/Inprocess.svg"';
                    break;
                default:
                    strHtml += 'src = "../../../Whizible2.0-new/dist/img/yettostart.svg"';
            }

            return strHtml;
        }

        function getHealth(type, val) {
            //debugger
            var cls;
            var th = 0.0;
            switch (type) {
                case "c":
                    th = costh;
                    break;
                case "s":
                    th = schth;
                    break;
                case "e":
                    th = effth;
                    break;
            }
            if (val >= 100) {
                cls = "red";
            }
            else if (val >= th) {
                cls = "yellow";
            }
            else {
                cls = "green";
            }
            return cls;
        }

        function getProjectHealth(type, val) {
            //debugger;
            var cls = "";
            var th = 0.0;


            var CostGreenCriteria_New = "";
            var CostAmberCriteria_New = "";
            var SchduleAmberCriteria_New = "";
            if (costG.indexOf("&&") > -1) {
                const myArray = costG.split("&&");
                CostGreenCriteria_New = myArray[1]
                // if (CostGreenCriteria_New != "") {
                costG = CostGreenCriteria_New.trim();
                // }
            }

            if (costA.indexOf("&&") > -1) {
                const myArray = costA.split("&&");
                CostAmberCriteria_New = myArray[1]
                // if (CostAmberCriteria_New != "") {
                costA = CostAmberCriteria_New.trim();
                // }
            }

            if (schA.indexOf("&&") > -1) {
                const myArray = schA.split("&&");
                SchduleAmberCriteria_New = myArray[1]
                // if (SchduleAmberCriteria_New != "") {
                schA = SchduleAmberCriteria_New.trim();
                //}

            }

            var EffortsAmberCriteria_New = "";
            if (effA.indexOf("&&") > -1) {
                const myArray = effA.split("&&");
                EffortsAmberCriteria_New = myArray[1]
                // if (EffortsAmberCriteria_New != "") {
                effA = EffortsAmberCriteria_New.trim();
                // }

            }

            switch (type) {
                case "c":
                    if (eval(val.toString() + costR)) {
                        cls = "red";
                    }

                    else if (eval(val.toString() + costG)) {
                        cls = "green";
                    }
                    else if (eval(val.toString() + costA + val.toString())) {
                        cls = "yellow";
                    }
                    else {
                        cls = "grey";
                    }
                    break;
                case "s":
                    if (eval(val.toString() + schR)) {
                        cls = "red";
                    }
                    else if (eval(val.toString() + schG)) {
                        cls = "green";
                    }
                    else if (eval(val.toString() + schA + val.toString())) {
                        cls = "yellow";
                    }
                    else {
                        cls = "grey";
                    }
                    break;
                case "e":
                    if (eval(val.toString() + effR)) {
                        cls = "red";
                    }
                    else if (eval(val.toString() + effG)) {
                        cls = "green";
                    }
                    else if (eval(val.toString() + effA + val.toString())) {
                        cls = "yellow";
                    }
                    else {
                        cls = "grey";
                    }
                    break;
            }

            return cls;
        }

        function createMilestoneTab(projectid) {
            var strMS = '';
            strMS += '<tr>';
            strMS += '    <td colspan="9" id="milestone_detail_milestone' + projectid + '" class="milestone-detail">';
            strMS += '        <div class="close-milestone-div">';
            strMS += '          <img src="../../../Whizible2.0-new/dist/img/close.svg" onclick=closeMS(' + projectid + ') class="close-milestone-detail" title="Close" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"/>';
            strMS += '        </div>';
            //strMS += '       <div class="close-milestone-div" style="float: left!important;">';
            //strMS += '         <div class="div_space"></div>';
            strMS += '       </div>';
            strMS += '       <div class="table-responsive" >';
            strMS += '         <table id="maintable' + projectid + '" class="table width99">';
            strMS += '            <thead id="ProjectMilestoneHeader' + projectid + '">';
            strMS += '            </thead>';
            strMS += '             <tbody id="ProjectMilestoneBody' + projectid + '">';
            strMS += '             </tbody>';
            strMS += '           </table>';
            strMS += '       </div>';
            strMS += '   </td>';
            strMS += '</tr>';

            return strMS;
        }

        function createApprovalTab(projectid, projectname) {
            strAppr = '';
            strAppr += '<tr class="tab" id="tab_tab' + projectid + '">';
            strAppr += '    <td colspan="9" >';
            strAppr += '        <div id="tab_content' + projectid + '" class="tab-content">';
            strAppr += '             <img src="../../../Whizible2.0-new/dist/img/history-icon.svg" class="history" title="History" data-bs-toggle="modal" data-bs-placement="bottom" data-bs-container="body" onclick="ShowHistory(' + projectid + ', \'' + projectname + '\')"/>';
            strAppr += '                        <img src="../../../Whizible2.0-new/dist/img/close.svg" onclick=closeAS(' + projectid + ') class="closetab" title="Close" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"/>';
            strAppr += '                        <div class="clearfix"></div>';
            strAppr += '        </div>';
            strAppr += '    </td>';
            strAppr += '</tr>';
            return strAppr;
        }

        function getApprovalTab(projectid, projectname) {
            var lastStage = 0;
            strAppr = '';
            strAppr += '             <img src="../../../Whizible2.0-new/dist/img/history-icon.svg" class="history" title="History" data-bs-toggle="modal" data-bs-placement="bottom" data-bs-container="body" onclick="ShowHistory(' + projectid + ', \'' + projectname + '\')"/>';
            strAppr += '                        <img src="../../../Whizible2.0-new/dist/img/close.svg" onclick=closeAS(' + projectid + ') class="closetab" title="Close" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"/>';
            strAppr += '                        <div class="clearfix"></div>';
            var projectParameters = {
                ProjectId: projectid
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/GetApprovalStatus", param, false);
            var stageCompleted = true;
            if (strResult != undefined) {
                var stgHead = '';
                var stgDetail = '';
                lastStage = strResult.length;
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    if (d.IsCurrentStage == 1) {
                        stageCompleted = false;
                    }
                    stgHead += '                              <li class=" col-sm-2" id="stage_tab' + projectid + '_' + d.OrderNo + '"><a>' + d.RequestStage + '</a></li>';
                    //Commented & Added By Dipali V On 13th April 2023 For Get Approver Details
                    //stgDetail += '                            <div id="stage_appr' + projectid + '_' + d.OrderNo + '" class="tab-pane fade in active in col-sm-2">';
                    stgDetail += '                            <div id="stage_appr' + projectid + '_' + d.OrderNo + '" class="tab-pane fade in active show in col-sm-2">';
                    if (d.OrderNo == 1) {
                        stgDetail += '                                <span>Created by<br/>' + d.CreatedBy + '</span>';
                    }
                    else {
                        if ((d.IsCurrentStage == 1) && i == (lastStage - 1)) {
                            stgDetail += '                                <span>Completed</span>';
                        }
                        else if (d.IsCurrentStage == 1 || stageCompleted == true) {
                            stgDetail += '                                <span>Approvers<br/>' + d.ApproverList + '</span>';
                        }
                        else {
                            stgDetail += '                                <span>Yet to reach this stage</span>';
                        }
                    }
                    stgDetail += '                            </div>';
                }
                strAppr += '             <div  class="carousel slide">';
                strAppr += '                <div class="carousel-inner col-sm-12">';
                strAppr += '                   <div class="carousel-item active" >';
                strAppr += '                         <ul class="nav nav-tabs" >';
                strAppr += stgHead;
                strAppr += '                         </ul>';
                strAppr += '                        <div class="detailtab">';
                strAppr += stgDetail;
                strAppr += '                        </div>';
                strAppr += '                   </div>';
                strAppr += '                </div>';
                strAppr += '            </div>';
            }
            return strAppr;
        }
        //Added by Vaijat 12-12-2020
        //function ShowApprovalColumn(projectid, projectname) {
        //    $("#td" + projectid).html(getApprovalColumn(projectid, $("#td" + projectid).attr("projectName")));
        //    $('[data-bs-toggle="tooltip"]').tooltip();
        //    // Initialize carousel for this project
        //    setTimeout(function() {
        //        initProjectCarousel(projectid);
        //    }, 100);
        //}
        function getApprovalColumn(projectid, projectname) {
            //debugger
            var lastStage = 0;
            var strApprC = '';
            //strApprC += '<td>';
            //strApprC += '    <div class="checkbox-container" id="tab' + projectid + '">';
            //strApprC += '        <div id="status' + projectid + '" class="carousel slide myCarousel">';
            //strApprC += '            <div class="carousel-inner">';
            var projectParameters = {
                ProjectId: projectid
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/GetApprovalStatus", param, false);
            var stageCompleted = true;
            if (strResult != undefined) {
                //Commented by Vaijat 12-12-2020
                //strApprC += '<td>';
                strApprC += '    <div class="checkbox-container" id="tab' + projectid + '">';
                strApprC += '        <div id="status' + projectid + '" class="carousel slide myCarousel">';
                strApprC += '            <div class="carousel-inner">';
                strApprC += '                <div class="carousel-item active" >';
                lastStage = strResult.length;
                for (var i = 0; strResult.length > i; i++) {
                    var d = strResult[i];
                    if (d.IsCurrentStage == 1) {
                        stageCompleted = false;
                    }

                    if (i == 0 || stageCompleted == true) {
                        strApprC += '                    <div class="round" >';
                        strApprC += '                        <label class="status-approve" data-bs-toggle="popover" data-bs-placement="bottom"  data-bs-container="body" id="tab' + projectid + '_' + d.OrderNo + '" onclick="selectedstatus(this, \'' + projectname + '\',' + lastStage + ');"></label>';
                        strApprC += '                    </div>';
                        //strApprC += '                    <div  class="dropdown-menu hide" id="popover-content-' + projectid + '">';
                        //strApprC += '                        <div class="status-approver"><strong>Start</strong><br/>';
                        //strApprC += '                            <i>Created by ' + projectid + '</i></div>';//Created by
                        //strApprC += '                        <div><strong>Sales head approval</strong><br/>';
                        //strApprC += '                            <i class="approvers">Approvers: ' + projectid + '</i></div>';//Approvers
                        //strApprC += '                    </div>';
                    }
                    else if (lastStage > 5 && i != 0 && i % 5 == 0) {
                        strApprC += '                </div>';
                        strApprC += '                <div class="carousel-item" >';
                    }
                    else {
                        strApprC += '                    <div class="round" >';
                        if ((d.IsCurrentStage == 1) && i != (lastStage - 1)) {
                            strApprC += '                        <label class="status-current" id="tab' + projectid + '_' + d.OrderNo + '" onclick="selectedstatus(this, \'' + projectname + '\',' + lastStage + ');"></label>';
                        }
                        else if ((d.IsCurrentStage == 1) && i == (lastStage - 1)) {
                            strApprC += '                        <label class="status-approve" id="tab' + projectid + '_' + d.OrderNo + '" onclick="selectedstatus(this, \'' + projectname + '\',' + lastStage + ');"></label>';
                        }
                        else {
                            strApprC += '                        <label class="needattention" id="tab' + projectid + '_' + d.OrderNo + '" onclick="selectedstatus(this, \'' + projectname + '\',' + lastStage + ');"></label>';
                        }
                        strApprC += '                    </div>';
                    }
                }
                strApprC += '                </div>';
                //if (lastStage == 0) {
                //    strApprC += '    <div class="round">';
                //    strApprC += '         <label></label>';
                //    strApprC += '        </div>';
                //    strApprC += '    <div class="round">';
                //    strApprC += '         <label></label>';
                //    strApprC += '        </div>';
                //    strApprC += '    <div class="round">';
                //    strApprC += '         <label></label>';
                //    strApprC += '        </div>';
                //    strApprC += '    <div class="round">';
                //    strApprC += '         <label></label>';
                //    strApprC += '        </div>';
                //    strApprC += '    <div class="round">';
                //    strApprC += '         <label></label>';
                //    strApprC += '        </div>';
                //}
                strApprC += '            </div>';
                if (lastStage > 5) {
                    // Added By Dipali V On 1st Oct 2025 For W26 Product Enhancment (Next/Prev controls markup)
                    strApprC += '            <a class="carousel-control-prev" id="prev' + projectid + '" href="#status' + projectid + '" role="button" data-bs-slide="prev" ><i class="fa fa-angle-left" data-bs-original-title="Previous" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"></i></a>';
                    strApprC += '            <a class="carousel-control-next" id="next' + projectid + '" href="#status' + projectid + '" role="button" data-bs-slide="next" ><i class="fa fa-angle-right" data-bs-original-title="Next" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"></i></a>';
                }
                strApprC += '        </div>';
                strApprC += '    </div>';
                //Commented by Vaijat 12-12-2020
                //strApprC += '</td>';
            }
            //strApprC += '            </div>';
            //if (lastStage > 5) {
            //    strApprC += '            <a class="left carousel-control" id="prev' + projectid + '" href=".myCarousel" data-slide="prev" ><i class="fa fa-angle-left" title="Previous" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"></i></a>';
            //    strApprC += '            <a class="right carousel-control" id="next' + projectid + '" href=".myCarousel" data-slide="next" ><i class="fa fa-angle-right" title="Next" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"></i></a>';
            //}
            //strApprC += '        </div>';
            //strApprC += '    </div>';
            //strApprC += '</td>';
            if (lastStage == 0) {
                strApprC = '<td class="text-center">';
                strApprC += 'N/A';
                strApprC += '</td>';
            }
            return strApprC;
        }

        //Approval status div
        var bgColor;
        function selectedstatus(obj, projectname, stgs) {
            $(".milestone-detail").css("display", "none");
            $(".tab").hide();
            var id = obj.id;
            var container = $("#" + id).closest('div.checkbox-container').attr("id");

            var pid = id.substr(0, id.indexOf('_')).replace('tab', '');

            var strcontent = getApprovalTab(pid, projectname);

            $('#tab_content' + pid).html('');
            $('#tab_content' + pid).html(strcontent);
            $("#tab_" + container).show();

            //var bgColor = $(obj).css('backgroundColor');
            //$("#stage_" + id).siblings().css({ "background": "#fff" });
            //$("#stage_" + id).css({ "background": bgColor, "border-bottom-color": bgColor });
            //$("#stage_" + id).closest('div.item').addClass("active");
            //$("#stage_" + id).parents("div").siblings().removeClass('active');

            for (var i = 0; i <= stgs; i++) {
                var stg = "tab" + pid.toString() + "_" + i.toString();
                var bgColor = $("#" + stg).css('backgroundColor');
                $("#stage_" + stg).css({ "background": bgColor, "border-bottom-color": bgColor });
            }
            $("#stage_" + id).parents("div").siblings().removeClass('active');
            $("#stage_" + id).closest('div.carousel-item').addClass("active");
        }

        function selectedmilestone(obj) {
            $(".milestone-detail").css("display", "none");
            var divid = obj.id;
            var pid = divid.replace('milestone', '');

            GetProjectScheduleDetails(pid);
            $("#milestone_detail_" + divid).show();
            $(".tab").hide();
        }

        function GetProjectScheduleDetails(intProjectID) {
            var projectParameters = {
                ProjectID: intProjectID,
            }
            var param = JSON.stringify(projectParameters);
            var data = AJAXCallWithResult("/api/PM_ProjectList/GetProjectScheduleDetails", param, false);
            //debugger
            if (data != undefined) {
                BindScheduleTable(intProjectID, data.ProjectScheduleDetailList, data.ProjectScheduleMilestoneList, data.ProjectScheduleReviewList, data.ProjectSchedulePhaseList);
            }
        }
        function BindScheduleTable(projectid, ProjectScheduleDetailList, ProjectScheduleMilestoneList, ProjectScheduleReviewList, ProjectSchedulePhaseList) {
            $("#ProjectMilestoneHeader" + projectid).html('');
            $("#ProjectMilestoneBody" + projectid).html('');

            var strHTMLHeader = '';
            var strHTMLBody = '';
            var iYear = 0;
            var iMonth = 0;
            strHTMLHeader += '<tr style="top: 0">';

            for (var i = 0; i < ProjectScheduleDetailList.length; i++) {


                var ScheduleObject = ProjectScheduleDetailList[i];
                if (ScheduleObject.RecordLevel == "H") {
                    dtStartDate = new Date(ScheduleObject.ExpectedStartDate);
                    dtEndDate = new Date(ScheduleObject.ExpectedEndDate);

                    iYear = ScheduleObject.YearHeader;
                    iMonth = ScheduleObject.MonthHeader;
                    strHTMLHeader += addYearHeader(iYear, iMonth);
                    strHTMLHeader += '</tr>';
                    strHTMLBody += '<tr>';
                    strHTMLBody += addMonthHeader(iYear, iMonth);
                    strHTMLBody += '</tr>';
                    //strHTMLBody += '<tr>';
                    //strHTMLBody += addProjectRow(iMonth, ScheduleObject, ProjectScheduleMilestoneList, ProjectScheduleReviewList, ProjectSchedulePhaseList);
                    //strHTMLBody += '</tr>';
                }
                else {
                    strHTMLBody += '<tr>';
                    strHTMLBody += addProjectRow(iMonth, ScheduleObject, ProjectScheduleMilestoneList, ProjectScheduleReviewList, ProjectSchedulePhaseList);
                    strHTMLBody += '</tr>';
                }

            }
            $("#ProjectMilestoneHeader" + projectid).html(strHTMLHeader);
            $("#ProjectMilestoneBody" + projectid).html(strHTMLBody);
            $("[data-bs-toggle=popover]").each(function (i, obj) {
                $(this).popover({
                    html: true,
                    trigger: 'hover',
                    content: function () {
                        var id = $(this).attr('id')
                        //alert(id);
                        return $('#popover-content-' + id).html();
                    }
                });
            });
            if ($('.today')[0] != undefined) {
                $('.today')[0].scrollIntoView({
                    behavior: 'auto',
                    block: 'center',
                    inline: 'center'
                });
            }
        }

        function ShowHistory(pid, projectname) {
            $('#historybody').html('');
            var strHTML = '';
            var pname = projectname.replace(/`/g, '\'');
            strHTML += '<div class="stage_name col-sm-12" style="margin-bottom: 20px;"><p>Project Name : ' + pname + ' </p></div>';

            var projectParameters = {
                ProjectID: pid,
            }
            var param = JSON.stringify(projectParameters);
            var data = AJAXCallWithResult("/api/PM_ProjectList/GetApprovalHistory", param, false);
            if (data != undefined) {
                var prevaction = '';
                var prevstage = '';
                for (var i = 0; data.length > i; i++) {
                    var d = data[i];
                    if (i == 0) {
                        strHTML += '<div class="stage_name col-sm-12" style="margin-bottom: 20px;"><p>Workflow : ' + d.WorkflowName + ' </p></div>';
                    }
                    if (prevstage != d.RequestStage) {
                        strHTML += '<div class="stage_name col-sm-12">';
                        strHTML += d.RequestStage;
                        strHTML += '</div>';
                    }
                    if (d.EventDate != "") {
                        if (prevstage != d.RequestStage) strHTML += '<div class="stage_bottom_border stage_status col-sm-4"></div>';
                        strHTML += '<div class="col-sm-12 stage-detail">';
                        strHTML += '    <div class="col-sm-2">';
                        strHTML += '        <p>' + d.EventDate + '</p>';
                        strHTML += '    </div>';
                        strHTML += '    <div class="col-sm-4">';
                        if (i == 0) {
                            strHTML += '    <p>Created by ' + d.UserName + '</p>';
                        }
                        else {
                            strHTML += '    <p>' + d.ActionType + ' by ' + d.UserName + '</p>';
                        }
                        strHTML += '    </div>';
                        strHTML += '    <div class="col-sm-6">';
                        strHTML += '        <p>' + d.Comments + '</p>';
                        strHTML += '    </div>';
                        strHTML += '</div>';
                        prevaction = d.ActionType;
                    }
                    else if ((i == data.length - 1) && (prevaction == 'Approved')) {
                        strHTML += '<div class="stage_bottom_border stage_status col-sm-4"></div>';
                        strHTML += '<div class="col-sm-12 stage-detail">';
                        strHTML += '    <p>Completed</p>';
                        strHTML += '</div>';
                    }
                    else {
                        strHTML += '<div class="stage_bottom_border col-sm-4"></div>';
                        strHTML += '<div class="col-sm-12 stage-detail">';
                        strHTML += '    <p>Not yet reached this stage</p>';
                        strHTML += '</div>';
                    }
                    prevstage = d.RequestStage;
                }
                $('#historybody').html(strHTML);
            }
            $("#approval_status_history").modal('show');
        }

        function getMyFilters() {
            var strlist = '';
            var setid = $('#appliedfilter').val();
            var projectParameters = {
                LoginType: loginType,
                intEmployeeID: EmployeeID,
            }
            var param = JSON.stringify(projectParameters);
            var data = AJAXCallWithResult("/api/PM_ProjectList/GetFilters", param, false);
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
                        strlist += "            onclick = 'ClearAllFilters()'></label> ";
                    }
                    else {
                        strlist += '            <input id="txtAF' + fid + '" type="checkbox" name=""/>';
                        strlist += '            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" id="Apply' + fid + '" for="txtAF' + fid + '"';
                        strlist += "            onclick = 'ApplyFilter(" + fid + ")'></label> ";
                    }

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
            //$('[data-bs-toggle="tooltip"]').tooltip();
            $('[data-bs-toggle="tooltip"]').tooltip({
                animated: 'fade',
                //placement: 'bottom',
                trigger: 'hover'
            });
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");

            });
        }

        function btnDeleteFilter(qid) {
            $('#deleteid').val(qid);
            $('#deletetype').val('F');
            $('#deleteConfirmMsg').html("Are you sure to delete the selected filter?");
            $('#deleteConfirmAlert').modal('show');
        }

        function confirmDelete() {
            var type = $('#deletetype').val();
            $('#deleteConfirmAlert').modal('hide');
            switch (type) {
                case "F":
                    filterDelete();
                    break;
                case "P":
                    DeleteProject();
                    break;
            }
        }

        function filterDelete() {
            var qid = $('#deleteid').val();
            var setqid = $('#appliedfilter').val();
            var projectParameters = {
                QueryID: qid,
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/DeleteFilter", param, false);
            if (strResult != undefined) {
                if (strResult == "Success") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Filter deleted successfully!', 'success');
                    getMyFilters();
                    if (qid == setqid) {
                        $('#btnClearAllFilters').click();
                    }
                }
            }
        }

        function EditFilter(qid) {
            $('#editqueryid').val(qid);
            var qtext = '';
            var projectParameters = {
                QueryID: qid
            }
            var param = JSON.stringify(projectParameters);
            var data = AJAXCallWithResult("/api/PM_ProjectList/GetFilterById", param, false);
            if (data != undefined) {
                $('#editqueryname').val(data.FilterName);
                $('#newfiltername').val(data.FilterName);
                $('#lblBasicFilterEdit').css('visibility', 'visible');
                $('#lblBasicFilterEdit').text(data.FilterName);
                qtext = data.QueryText.replace('[Over]', 'Over');
            }
            if (qtext != '') {
                hdnQueryText = qtext;
                BindBasicFilters(qtext, module);
                $('#tabBasicFilter').addClass('active');
                $('#basicfilter').addClass('active');
                $('#tabMyFilter').removeClass('active');
                //$('#btnClearAllFilters').css("display", "inline-block");
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
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/SetDefaultFilter", param, false);
            if (strResult != undefined) {
                if (strResult == "Success") {
                    alertify.set('notifier', 'position', 'top-right');
                    if (qid != 0) {
                        alertify.notify('Successfully set the filter as default!', 'success');
                    }
                    else {
                        alertify.notify('Successfully removed the default filter!', 'success');
                    }
                    setfiltername('');
                    getDefaultFilter();
                    page = 1;
                    getProjectList();
                    getMyFilters();
                }
            }
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

        $("#btnAdvancedFilter").click(function () {
            var af = $('#appliedfiltername').html();
            if (af != '') {
                if ($("#btnAdvancedFilter").hasClass("collapsed")) {
                    $("#btnAdvancedFilter").removeClass("collapsed");
                }
                $(".filter").addClass("active");
            }
            else {
                if (!$("#btnAdvancedFilter").hasClass("collapsed")) {
                    $("#btnAdvancedFilter").addClass("collapsed");
                }
                $(".filter").removeClass("active");
            }
        })

        function ApplyFilter(qid) {
            $('#editqueryid').val(qid);
            var projectParameters = {
                QueryID: qid
            }
            var param = JSON.stringify(projectParameters);
            var data = AJAXCallWithResult("/api/PM_ProjectList/GetFilterById", param, false);
            if (data != undefined) {
                $('#appliedfilter').val(qid);
                //$('#appliedfiltername').html(data.FilterName);
                setfiltername(data.FilterName);
                $('#lblBasicFilterEdit').css('visibility', 'visible');
                $('#lblBasicFilterEdit').text(data.FilterName);
                $('#newfiltername').val(data.FilterName);
                $('#editqueryname').val(data.FilterName);
                var querytext = data.QueryText.replace(/\'/g, '\'\'');
                $('#queryText').val(querytext);
                var qtext = data.QueryText.replace('[Over]', 'Over');
                hdnQueryText = querytext;
                BindBasicFilters(qtext, module);
                //$('#btnClearAllFilters').css("display", "inline-block");
            }
            page = 1;
            getProjectList();
            getMyFilters();
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");
            });

        }

        function getDefaultFilter() {
            hdnQueryText = "";
            var projectParameters = {
                intEmployeeID: EmployeeID,
                LoginType: loginType,
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/GetDefaultFilter", param, false);
            if (strResult != undefined) {
                $('#appliedfilter').val(strResult.FilterID);
                //$('#appliedfiltername').html(strResult.FilterName);
                setfiltername(strResult.FilterName);
                var querytext = strResult.QueryText;
                if (querytext != '' && querytext != null) querytext = querytext.replace(/\'/g, '\'\'');
                $('#queryText').val(querytext);
                $('#newfiltername').val(strResult.FilterName);
                $('#editqueryid').val(strResult.FilterID);
                $('#editqueryname').val(strResult.FilterName);
                $('#lblBasicFilterEdit').css('visibility', 'visible');
                $('#lblBasicFilterEdit').text(strResult.FilterName);
                if (strResult.FilterID > 0) {
                    var qtext = strResult.QueryText.replace('[Over]', 'Over');
                    //if ($("#btnAdvancedFilter").hasClass("initial") || $("#btnAdvancedFilter").hasClass("collapsed")) {
                    //    $("#btnAdvancedFilter").removeClass("initial");
                    //    $("#btnAdvancedFilter").click();
                    //}
                    //debugger                
                    hdnQueryText = strResult.QueryText;
                    BindBasicFilters(qtext, module);
                    $('#tabBasicFilter').addClass('active');
                    $('#tabMyFilter').addClass('collapse');
                    $('#tabMyFilter').attr('aria-expanded', false);
                    //$('#btnClearAllFilters').css("display", "inline-block");
                }
                else {
                    $('#lblBasicFilterEdit').css('visibility', 'hidden');
                    $('#queryText').val("[Over] = ''0''");
                    $('#tabBasicFilter').removeClass('active');
                    //if (!$("#btnAdvancedFilter").hasClass("initial") && !$("#btnAdvancedFilter").hasClass("collapsed")) {
                    //    $("#btnAdvancedFilter").click();
                    //}
                    //$('#btnClearAllFilters').css("display", "none");
                }
            }
        }

        function ClearAllFilters() {
            StartLoader("#bodyProjectList");
            ClearBasicFilter(module);
            hdnQueryText = "";
            $("#txtPRFilterOver option[value='0']").prop('selected', true);
            $('#newfiltername').val('');
            $('#appliedfilter').val('');
            //$('#appliedfiltername').html('');
            setfiltername('');
            $('#lblBasicFilterEdit').text('');
            $('#lblBasicFilterEdit').css('visibility', 'hidden');
            //$('#queryText').val('');
            $('#queryText').val("[Over] = ''0''");
            $('#editqueryid').val('');
            $('#editqueryname').val('');
            $('#editquerytext').val('');
            $("#btnAdvancedFilter").click();
            $('#tabMyFilter').removeClass('active');
            $('#tabBasicFilter').removeClass('active');
            //Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT 
            $('#txtPRFilterResourceGroupID').val('0');
            $('#txtPRFilterResourcePoolID').val('0');
            //End of Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT 
            //Commented And Added By reshma chavan on 7th jan 2022 not applying correct filter for first time
            $("#txtPRFilterProjectStatusID").val('0');
            //End of Commented And Added By reshma chavan on 7th jan 2022 not applying correct filter for first time
            //$('#btnClearAllFilters').css("display", "none");
            getMyFilters();
            page = 1;
            getProjectList();
            StopAjaxLoader("#bodyProjectList");
        }

        function ApplyWOSave() {
            //debugger
            page = 1;
            var strQuery = GenerateBasicFilterQuery(module, AllFields);
            strQuery = removeDefaultSelection(strQuery);
            if (strQuery != "") {
                var hquery = hdnQueryText.replace(/`/g, "");
                hquery = hquery.replace(/\'/g, "");
                var qry = strQuery.replace(/\'/g, "");
                if (qry.trim() != hquery.trim() || hquery == '') {
                    hdnQueryText = strQuery;
                    $('#queryText').val(strQuery);
                    $('#appliedfilter').val('');
                    $('#lblBasicFilterEdit').text('');
                    $('#lblBasicFilterEdit').css('visibility', 'hidden');
                    //$('#editqueryid').val('');
                    //$('#appliedfiltername').html('NA');
                    setfiltername('NA');
                    //$('#btnClearAllFilters').css("display", "inline-block");                
                    page = 1;
                    getProjectList();
                }
                $('#basicfilter').removeClass('active');
                //Added By Reshma Chavan on 4th Jan 2021 For not getting alert after Applying filter
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter Applied Successfully");
                //End of Added By Reshma Chavan on 4th Jan 2021 For not getting alert after Applying filter
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Apply filter on at least one field.', 'error');
            }
        }

        function removeDefaultSelection(strQuery) {

               <%--Commented and Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT --%>
                //var fields = ['BaseCurrency', 'BusinessGroupID'];
                //Commented And Added By reshma chavan on 7th jan 2022 not applying correct filter for first time
                //var fields = ['BaseCurrency', 'BusinessGroupID', 'ResourcePoolID', 'ResourceGroupID'];
                var fields = ['BaseCurrency', 'BusinessGroupID', 'ResourcePoolID', 'ResourceGroupID', 'ProjectStatusID'];
                //End of Commented And Added By reshma chavan on 7th jan 2022 not applying correct filter for first time
                <%--End of Commented and Added by Chetan M on 25th Aug 2021 for Filter the data by Using DU DT --%>
                strQuery = removeDefaultSelectionField(strQuery, fields[0]);
                strQuery = removeDefaultSelectionField(strQuery, fields[1]);
                <%--Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT --%>
                strQuery = removeDefaultSelectionField(strQuery, fields[2]);
                strQuery = removeDefaultSelectionField(strQuery, fields[3]);
                <%--End of Added by Chetan M on 25th Aug 2020 for Filter the data by Using DU DT --%>
            //Added By reshma chavan on 7th jan 2022 not applying correct filter for first time
            strQuery = removeDefaultSelectionField(strQuery, fields[4]);
            //End of Added By reshma chavan on 7th jan 2022 not applying correct filter for first time
            return strQuery;
        }

        function removeDefaultSelectionField(strQuery, field) {
            var cnt = strQuery.indexOf(field + " = ");
            if (cnt == 0) {
                if (strQuery = field + " = ''0''") {
                    strQuery = "";
                }
                else {
                    var strrep1 = field + " = ''0'' AND ";
                    strQuery = strQuery.replace(strrep1, "");
                }
            }
            else if (cnt > 0) {
                var strrep2 = " AND " + field + " = ''0''";
                strQuery = strQuery.replace(strrep2, "");
            }
            return strQuery;
        }

        function SaveAndApply() {
            var strQuery = GenerateBasicFilterQuery(module, AllFields);
            strQuery = removeDefaultSelection(strQuery);
            if (strQuery != "") {
                $('#prjsavefilter').modal('show');
                $('#newfiltername').focus();
                $('#editquerytext').val(strQuery);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Apply filter on at least one field.', 'error');
            }
        }

        //Added By Riddhesh Patil on 12-NOV-2022 
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
        //End of Added By Riddhesh Patil

        function SaveFilter() {
            var fname = $('#newfiltername').val().trim();
            var editname = $('#editqueryname').val();
            if (fname == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please specify Filter Name.', 'error', 5);
                return false;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            if (checkSpecialCharacter(fname, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#newfiltername").focus();
                return false;
            }
            //End of Added By Riddhesh Patil
            var qid = $('#editqueryid').val();
            var isDuplicate = FindDuplicateFilter(fname, qid);
            if (isDuplicate == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Filter Name already exists. Specify different Name.', 'error', 5);
                return false;
            }
            $('#prjsavefilter').modal('hide');
            var strQuery = $('#editquerytext').val();
            var flag = 1;
            if (qid > 0 && editname != fname) {
                flag = 0;
            }
            //debugger
            var projectParameters = {
                QueryID: qid,
                QueryName: fname,
                QueryText: strQuery,
                LoginType: loginType,
                intEmployeeID: EmployeeID,
                UserName: UserName,
                Flag: flag,
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/SaveFilter", param, false);
            if (strResult != undefined) {
                page = 1;
                $('#editqueryid').val(strResult);
                $('#appliedfilter').val(strResult);
                //$('#appliedfiltername').html(fname);
                setfiltername(fname);
                $('#lblBasicFilterEdit').css('visibility', 'visible');
                $('#lblBasicFilterEdit').text(fname);
                $('#queryText').val(strQuery);
                //$('#btnClearAllFilters').css("display", "inline-block");
                getMyFilters();
                $('#basicfilter').removeClass('active');
                page = 1;
                getProjectList();
                //Added By Reshma Chavan on 4th Jan 2021 For not getting alert after Applying filter
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter Applied Successfully");
                //End of Added By Reshma Chavan on 4th Jan 2021 For not getting alert after Applying filter
            }
        }

        function getHealthThreshold() {
            var projectParameters = {
                intEmployeeID: EmployeeID,
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/GetHealthThreshold", param, false);
            if (strResult != undefined) {
                costh = strResult.CostThreshold;
                schth = strResult.ScheduleThreshold;
                effth = strResult.EffortThreshold;
            }
        }

        function getProjectHealthThreshold() {
            //debugger
            var projectParameters = {
                intEmployeeID: EmployeeID,
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/getProjectHealthThreshold", param, false);
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var item = d.Item;
                    switch (item) {

                        case 'Cost':
                            costR = d.RedCriteria;
                            costA = d.AmberCriteria;
                            costG = d.GreenCriteria;
                            break;
                        case 'Schedule':
                            schR = d.RedCriteria;
                            schA = d.AmberCriteria;
                            schG = d.GreenCriteria;
                            break;
                        case 'Effort':
                            effR = d.RedCriteria;
                            effA = d.AmberCriteria;
                            effG = d.GreenCriteria;
                            break;
                    }
                }
            }
        }

        $('#paging').on('click', '.pg', function () {
            if ($(this).hasClass('disabled')) return false;
            var str = $(this).text();
            var prev = '<%= MyBase.GetResourceString("C_Previous") %>';
                var next = '<%= MyBase.GetResourceString("C_Next") %>';
                $('.pg').removeClass('Active');
                if (str == next) {
                    page += 1;
                }
                else if (str == prev) {
                    page -= 1;
                }
                else {
                    page = parseInt(str);
                }
                getProjectList();
            });

        function generatePagination(paging) {
            var curr = paging.CurrentPage;
            var tot = paging.TotalRecords;
            var nxt = paging.IsNextPage;
            var totpg = parseInt(tot / pagesize);
            //Added by Chetan M on 16th Sept 2020 for Performance Issue
            $("#TotalRecords").html("");
            $("#TotalRecords").html(tot);
            GlobalProjectCount = tot;
            //End of Added by Chetan M on 16th Sept 2020 for Performance Issue
            if ((tot % pagesize) > 0) totpg += 1;
            var strHtml = '';
            $('#paging').html('');
            strHtml += '<li id="pgPrev" class="pg disabled"><a href="#"><%= MyBase.GetResourceString("C_Previous") %></a></li>';
                var j = 1;
                for (var i = 1; i <= totpg; i++) {
                    cls = '';
                    if (curr == i) cls = 'active';
                    if (totpg <= 5) {
                        strHtml += '<li id="pg' + i.toString() + '" class="pg ' + cls + '">';
                        strHtml += '<a href="#">';
                        strHtml += i.toString() + '</a></li > ';
                    }
                    else {
                        if ((j == 1 && i == 1) || (j == 5 && i == totpg)) {
                            strHtml += '<li id="pg' + i.toString() + '" class="pg ' + cls + '">';
                            strHtml += '<a href="#">';
                            strHtml += i.toString() + '</a></li > ';
                            j++;
                        }
                        else if ((((j == 2) || (j == 3)) && (curr <= 3))) {
                            strHtml += '<li id="pg' + i.toString() + '" class="pg ' + cls + '">';
                            strHtml += '<a href="#">';
                            strHtml += i.toString() + '</a></li > ';
                            j++;
                        }
                        else if ((((j == 3) || (j == 4)) && (curr >= (totpg - 2)) && (i >= (totpg - 2)))) {
                            strHtml += '<li id="pg' + i.toString() + '" class="pg ' + cls + '">';
                            strHtml += '<a href="#">';
                            strHtml += i.toString() + '</a></li > ';
                            j++;
                        }
                        else if (((j == 3) && (i == curr))) {
                            strHtml += '<li id="pg' + i.toString() + '" class="pg ' + cls + '">';
                            strHtml += '<a href="#">';
                            strHtml += i.toString() + '</a></li > ';
                            j++;
                        }
                        else if ((j == 2) && (curr > 3) || ((j == 4) && (curr < (totpg - 2)))) {
                            cls = 'disabled';
                            strHtml += '<li id="pg' + i.toString() + '" class="pg ' + cls + '">';
                            strHtml += '<a href="#">';
                            strHtml += '...</a></li > ';
                            j++;
                        }
                    }
                }

                strHtml += '<li id="pgNext" class="pg disabled"><a href="#"><%= MyBase.GetResourceString("C_Next") %></a></li>';
            $('#paging').html(strHtml);

            if (curr > 1) $('#pgPrev').removeClass('disabled');
            if (nxt == true) $('#pgNext').removeClass('disabled');
            var pgst = (tot > 0 ? ((curr - 1) * pagesize) + 1 : 0);
            var pgend = ((curr - 1) * pagesize) + pagesize;
            if (pgend > tot) pgend = tot;
            var pageinfo = "Showing " + pgst.toString() + " to " + pgend.toString() + " of " + tot.toString();
            $('#lblPageInfo').text(pageinfo);
        }
        function FindDuplicateFilter(filter, id) {
            var filters = document.getElementById("MyFiltersdropdown");
            for (var i = 0; i < filters.childNodes.length; i++) {
                if (filters.childNodes[i].innerText.trim().toUpperCase() == filter.toUpperCase() && filters.childNodes[i].childNodes[1].children[0].id != "f" + id) {
                    return true;
                    break;
                }
            }
        }

        function updateOptions() {
            //var cbo = ['Over', 'Billable', 'ProjectGroupID', 'ContractType', 'LocationID', 'ProjectTypeID', 'CustomerID', 'LifeCycleID', 'ProjectSizeUnitID', 'ProjectStatusID'];
            //Commented By Reshma Chavan on 21st Dec 2021 For Duplicate Placeholder in Filter Section
            //var cbo = ['Over', 'Billable', 'DraftOrConverted', 'ProjectGroupID', 'ContractType', 'LocationID', 'ProjectTypeID', 'CustomerID', 'ProjectStatusID', 'MainProjectTypeID'];
            var cbo = ['Over', 'Billable', 'DraftOrConverted', 'ProjectGroupID', 'ContractType', 'LocationID', 'ProjectTypeID', 'CustomerID', 'MainProjectTypeID'];
            //End of Commented By Reshma Chavan on 21st Dec 2021 For Duplicate Placeholder in Filter Section
            for (var i = 0; i < cbo.length; i++) {
                AppendOptioncbo(cbo[i], '');
            }
            $("#txtPRFilterOver option[value='0']").prop('selected', true);
        }

        function AppendOptioncbo(FieldName, Caption) {
            var id = "txtPRFilter" + FieldName;
            if (FieldName == "ProjectGroupID") {
                FieldName = "Project Group";
            } else if (FieldName == "ContractType") {
                FieldName = "Commercial Details";
            } else if (FieldName == "LocationID") {
                FieldName = "Organization Unit";
            } else if (FieldName == "ProjectTypeID") {
                FieldName = "Practice";
            } else if (FieldName == "CustomerID") {
                FieldName = "Customer";
            } else if (FieldName == "LifeCycleID") {
                FieldName = "Life Cycle";
            } else if (FieldName == "ProjectSizeUnitID") {
                FieldName = "Project Size Unit";
            } else if (FieldName == "ProjectStatusID") {
                FieldName = "Project Status";
            } else if (FieldName == "DraftOrConverted") {
                FieldName = "Draft / Converted";
            } else if (FieldName == "MainProjectTypeID") {
                FieldName = "Project Type";
            } else if (FieldName == "Over") {
                FieldName = "Project Over";
            } else {
                FieldName = (Caption == '' ? FieldName : Caption);
            }
            var textval = "Select " + FieldName;

            var cbofield = document.getElementById(id);
            if (cbofield != null && cbofield != undefined) {
                cbofield.insertBefore(new Option(textval, ''), cbofield.firstChild);
                //Commented And Added By Usha Pandit On 21.01.2020
                //$("#" + id + " option[value='']").prop('selected', true);
                $("#" + id).val($("#" + id + " option:first").val());
                //End Of Added By Usha Pandit On 21.01.2020
            }
        }

        function btnDelete(pid, ptype) {
            $('#deleteid').val(pid);
            $('#deletetype').val('P');
            $('#projecttype').val(ptype);
            var msg = "";
            if (ptype == "C") {
                msg = "Are you sure to delete the selected Project?";
            }
            else {
                msg = "Are you sure to delete the selected Draft Project?";
            }
            $('#deleteConfirmMsg').html(msg);
            $('#deleteConfirmAlert').modal('show');
        }

        function DeleteProject() {
            var pid = $('#deleteid').val();
            var ptype = $('#projecttype').val();

            var projectParameters = {
                ProjectID: pid,
                DraftOrConverted: ptype,
            }
            var param = JSON.stringify(projectParameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectList/DeleteProject", param, false);
            if (strResult != undefined) {
                alertify.set('notifier', 'position', 'top-right');
                if (strResult.indexOf(" successfully.") > 0) {
                    alertify.notify(strResult, 'success');
                    page = 1;
                    getProjectList();
                }
                else {
                    alertify.notify(strResult, 'error');
                }
            }
        }

        $('#tabBasicFilter').click(function () {
            $('#basicfilter').addClass('active');
        });

        /*End - Changes by Mangesh*/
        //usha 12.11.2019
        /* $(".addproject").click(function () {*/
        function addproject() {

            var cur_PKToken = GenerateToken(0);
            window.location.href = "PM_CreateProject.aspx?FromWhereProjectId=" + 0 + "&FromWhereData=D" + "&PKToken=" + cur_PKToken + "&Mode=Add";

        }

        //$(document).on("click", ".addproject", function () {

        //    debugger;
        //            var cur_PKToken = GenerateToken(0);
        //            window.location.href = "PM_CreateProject.aspx?FromWhereProjectId=" + 0 + "&FromWhereData=D" + "&PKToken=" + cur_PKToken + "&Mode=Add";
        //        });
        //usha 12.11.2019

        //usha 12.11.2019
        function EditProject(currentProjectId, currentProjectName, WhichAction) {
            //Commented And Added By Usha Pandit On 17.08.2020 for refresh issue if Agile project is selected
            //var cur_PKToken = GenerateToken(currentProjectId);
            //window.location.href = "PM_CreateProject.aspx?FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit";
            //if (WhichAction == "C") {
            //    setSessionProject(currentProjectId, currentProjectName);
            //}    

            var cur_PKToken = GenerateToken(currentProjectId);
            if (WhichAction == "C") {
                setSessionProject(currentProjectId, currentProjectName);
                //window.open("../../General/Navigation.aspx?FromWhere=PM&FromOld=1258&FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit", "_top");
                //Changes for Azure AD

                //Commented and added by Vishal Mane on 09/03/2026 for Azure AD and SAML SSO Integration
                <%--<%If Session("AD") Is Nothing Then%>
                    window.open("../../General/Navigation.aspx?FromWhere=PM&FromOld=1258&FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit", "_top");
                <%Else%>
                    window.open("../../General/Navigation.aspx?AD=<%=Session("AD")%>&FromWhere=PM&FromOld=1258&FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit", "_top");
                <%End If%>--%>

                <%If Session("AD") Is Nothing And Session("SAML") Is Nothing Then%>
                    console.log("CASE 1: No AD and No SAML");
                    window.open("../../General/Navigation.aspx?FromWhere=PM&FromOld=1258&FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit", "_top");
                <%ElseIf Not Session("SAML") Is Nothing Then%>
                    console.log("CASE 2: SAML Session Used");
                    window.open("../../General/Navigation.aspx?SAML=<%=Session("SAML")%>&FromWhere=PM&FromOld=1258&FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit", "_top");
                <%ElseIf Not Session("AD") Is Nothing Then%>
                    console.log("CASE 2: AD Session Used");
                    window.open("../../General/Navigation.aspx?AD=<%=Session("AD")%>&FromWhere=PM&FromOld=1258&FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit", "_top");
                <%End If%>
                //End of Commented and added by Vishal Mane on 09/03/2026 for Azure AD and SAML SSO Integration

                //End Changes for Azure AD
            }
            else {
                window.location.href = "PM_CreateProject.aspx?FromWhereProjectId=" + currentProjectId + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit";
            }
            //End Of Added By Usha Pandit On 17.08.2020 for refresh issue if Agile project is selected
        }
        function GenerateToken(currentProjectId) {
            var SelectedProjectID = currentProjectId;
            var strSessionResult = ajaxCall("PM_ProjectList.aspx/GeneratePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: SelectedProjectID }));

            if (strSessionResult != undefined) {
                return (strSessionResult.d);
            }
            else
                return 0;
        }

        function setSessionProject(currentProjectId, currentProjectName) {
            var SelectedProjectID = currentProjectId;
            var SelectedProjectName = currentProjectName;
            var strSessionResult = ajaxCall("PM_ProjectList.aspx/SetSessionProject", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: SelectedProjectID, ProjectName: SelectedProjectName }));
        }
        //usha 12.11.2019
        //Added by pradip on 09-04-2020
        var searchtext = "";
        function myFunction() {
            // Declare variables
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("srchprolistfield");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblprojectlist");
            tr = table.getElementsByTagName("tr");
            //Commented By Dipali V On 18th Aug 2020 filter issue
            //// Loop through all table rows, and hide those who don't match the search query
            //for (i = 0; i < tr.length; i++) {
            //    td = tr[i].getElementsByTagName("td")[0];
            //    if (td) {
            //        txtValue = td.textContent || td.innerText;
            //        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            //            tr[i].style.display = "";
            //        } else {
            //            tr[i].style.display = "none";
            //        }
            //    }
            //    }
            //End of Commented By Dipali V On 18th Aug 2020 filter issue
            searchtext = filter;
            getProjectList();
            Pagination();
        }

        //Added by Chetan M on 16 Sept 2020 for Performance Issue
        function PrevList() {
            StartLoader("#bodyProjectList");
            if (page <= 1) {
                page = 1;
            }
            else {
                page -= 1;
            }
            var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            //getViewList(pid);
            getProjectList();


            Pagination();

            StopAjaxLoader("#bodyProjectList");
        }
        function NextList() {
            StartLoader("#bodyProjectList");

            page += 1;
            //intPageNo += 1;

            var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            //getViewList(pid);
            getProjectList();

            Pagination();

            StopAjaxLoader("#bodyProjectList");
        }

        function Pagination() {


            TotalRecords = GlobalProjectCount;
            // alert(SearchRecords);


            // if (ProjectID != 0) {
            //Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
            //var TotalRecords = $("#issueBody tr").length;
            // TotalRecords = GetFilteredIssueCount(ProjectID);
            var currentRecord = (page * pagesize);
            //alert(TotalRecords);
            if (parseInt(page) == 1) {
                //$("#btnprevious").attr("disabled", "disabled")
                //$("#btnnext").removeAttr("disabled");

                $("#btnprevious").addClass("fa-disabled");
                //$("#btnprevious").addClass("disabled");
                $("#btnnext").removeClass("fa-disabled");
                $("#LinkPrevious").prop("onclick", null).off("click");
                //$("#LinkPrevious").removeAttr("Onclick");
                $("#LinkNext").attr("Onclick", "NextList()");


            }
            if (parseInt(currentRecord) > parseInt(TotalRecords) && page == 1) {
                //$("#btnprevious").attr("disabled");
                //$("#btnnext").attr("disabled", "disabled")
                $("#btnprevious").addClass("fa-disabled");
                $("#btnnext").addClass("fa-disabled");

                // $("#LinkPrevious").removeAttr("Onclick");
                //$("#LinkNext").removeAttr("Onclick");
                $("#LinkPrevious").prop("onclick", null).off("click");
                $("#LinkNext").prop("onclick", null).off("click");
            }
            else if (parseInt(currentRecord) >= parseInt(TotalRecords)) {
                //$("#btnprevious").removeAttr("disabled");
                // $("#btnnext").attr("disabled", "disabled")

                $("#btnprevious").removeClass("fa-disabled");
                $("#btnnext").addClass("fa-disabled");

                $("#LinkPrevious").attr("Onclick", "PrevList()");
                //$("#LinkNext").removeAttr("Onclick");
                $("#LinkNext").prop("onclick", null).off("click");
            }

            else if (parseInt(page) > 1 && parseInt(currentRecord) < parseInt(TotalRecords)) {
                // $("#btnprevious").removeAttr("disabled");
                //$("#btnnext").removeAttr("disabled");
                $("#btnprevious").removeClass("fa-disabled");
                $("#btnnext").removeClass("fa-disabled");

                $("#LinkPrevious").attr("Onclick", "PrevList()");
                $("#LinkNext").attr("Onclick", "NextList()");

            }
            //if (parseInt(SearchRecords) == "1" && parseInt(currentRecord) >= parseInt(TotalRecords)) {
            ////if (parseInt(currentRecord) >= parseInt(TotalRecords)) {
            //    //$("#btnprevious").attr("disabled", "disabled")
            //    //$("#btnnext").attr("disabled", "disabled")
            //     $("#btnprevious").addClass("fa-disabled");
            //    $("#btnnext").addClass("fa-disabled");
            //     $("#LinkPrevious").removeAttr("Onclick");
            //     $("#LinkNext").removeAttr("Onclick");


            //}
            //} else {
            //    TotalRecords = 0;
            //   // $("#btnprevious").attr("disabled", "disabled");
            //    //$("#btnnext").attr("disabled", "disabled");
            //    $("#btnprevious").addClass("fa-disabled");
            //    $("#btnnext").addClass("fa-disabled");
            //     $("#LinkPrevious").removeAttr("Onclick");
            //         $("#LinkNext").removeAttr("Onclick");

            //}
            //Added By Dipali V On 4th Sep 2020 For Show Total Issue Count
            $("#TotalRecords").html("");
            $("#TotalRecords").html(TotalRecords);
            //End of Added By Dipali V On 4th Sep 2020 For Show Total Issue Count
            //End of Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde

        }

        function resizeSection() {

            var tblheight = $(window).height();
            $('#tblprojectlist').css({ 'height': tblheight - 150, "overflow-y": "auto" });
        }//modified by pradip on 22-10-2020 for JD issue
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
            //End of Added by Chetan M on 16 Sept 2020 for Performance Issue
    </script>

    <script>
        //var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
        //var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        //    return new bootstrap.Popover(popoverTriggerEl)
        //})
        //var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        //var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        //    return new bootstrap.Tooltip(tooltipTriggerEl)
        //})

        //// Ensure carousel control tooltips have black styling
        //function styleCarouselTooltips() {
        //    $('.carousel-control-prev, .carousel-control-next').each(function() {
        //        var $this = $(this);
        //        $this.on('show.bs.tooltip', function() {
        //            setTimeout(function() {
        //                var $tooltip = $('.tooltip');
        //                if ($tooltip.length) {
        //                    $tooltip.addClass('carousel-tooltip-black');
        //                }
        //            }, 10);
        //        });
        //    });
        //}

        //// Call the function after tooltips are initialized

        // Added by Dipali V on 7th OCT 2025 (W26): Show project details & workflow offcanvas
        //styleCarouselTooltips();
        //function ShowApprovalColumn(projectid, CurrentWFStatus) {
        //    $("#td" + projectid).html(GetWFColor(projectid,CurrentWFStatus));
        //}

      
        function GetWFColor(projectid,CurrentWFStatus) {
            let colorClass = "";
            let statusText = "";

            switch (CurrentWFStatus.toLowerCase()) {
                case "approval in progress":
                    colorClass = "orange";
                    statusText = "Approval In Progress";
                    break;
                case "approved":
                    colorClass = "green";
                    statusText = "Approved";
                    break;
                case "rejected":
                    colorClass = "red";
                    statusText = "Rejected";
                    break;
                case "pending approval":
                    colorClass = "grey";
                    statusText = "Pending Approval";
                    break;
                default:
                    colorClass = "black";
                    statusText = CurrentWFStatus;
            }

            // return `<span style="color: ${colorClass};font-size:11px;cursor:pointer" onclick="ShowProjectDetails(${projectid} )">${statusText}</span>`;
            // Check if statusText is "NA" (case insensitive)
            if (statusText.toLowerCase() === "na") {
                return `<span style="color: ${colorClass}; font-size: 11px;">${statusText}</span>`;
            } else {
                return `<span style="color: ${colorClass}; font-size: 11px; cursor: pointer" onclick="ShowProjectDetails(${projectid})">${statusText}</span>`;
            }

        }

        // End of Added by Dipali V on 7th OCT 2025 (W26): Show project details & workflow offcanvas
        // Added by Dipali V on 6th OCT 2025 (W26): Show project details & workflow offcanvas
        function ShowProjectDetails(projectId, CurrentWFStatus) {
            // Show loading state
           // $('#projectDetailsOffcanvas .offcanvas-body').html('<div class="text-center"><div class="spinner-border" role="status"><span class="visually-hidden">Loading...</span></div></div>');

            // Show the offcanvas
            //if (CurrentWFStatus.toLowerCase() !== "na") {
                var offcanvas = new bootstrap.Offcanvas(document.getElementById('projectDetailsOffcanvas'));
                offcanvas.show();

                // Fetch project details
                var projectParameters = {
                    ProjectID: projectId
                };
                var param = JSON.stringify(projectParameters);

                try {
                    var projectDetails = AJAXCallWithResult("/api/PM_ProjectList/GetProjectDetails", param, false);

                    if (projectDetails && projectDetails.ProjectID) {
                        // Populate project details (top section)
                        $('#oc_ProjectName').text(projectDetails.ProjectName || 'N/A');
                        $('#oc_BusinessGroup').text(projectDetails.BusinessGroup || 'N/A');
                        $('#oc_OrganizationUnit').text(projectDetails.OrganizationUnit || 'N/A');
                        $('#oc_WorkflowName').text(projectDetails.WorkflowName || 'N/A');
                        $('#oc_ProjectDuration').text(projectDetails.ProjectDuration || 'N/A');
                        $('#oc_Efforts').text(projectDetails.Efforts || 'N/A');
                        $('#oc_ProjectStartDate').text(projectDetails.ExpectedStartDate || 'N/A');
                        $('#oc_ProjectEndDate').text(projectDetails.ExpectedEndDate || 'N/A');
                        $('#oc_RevisionNo').text(projectDetails.RevisionNo || 'N/A');


                        // Populate workflow approval history section like screenshot
                        populateApprovalHistory(projectId);
                    } else {
                        // Show error message
                        $('#projectDetailsOffcanvas .offcanvas-body').html('<div class="alert alert-danger">Failed to load project details.</div>');
                    }
                } catch (error) {
                    console.error('Error loading project details:', error);
                    $('#projectDetailsOffcanvas .offcanvas-body').html('<div class="alert alert-danger">Error loading project details.</div>');
                }
            //}
        }
        
        // Added by Dipali V on 6th OCT 2025 (W26): Build Workflow Approval History grid
        var blnIsCurrentStagePassed = false;
        function populateApprovalHistory(projectId) {
            blnIsCurrentStagePassed = false;
            var projectParameters = { ProjectID: projectId };
            var param = JSON.stringify(projectParameters);
            var approvalHistory = [];
            try {
                approvalHistory = AJAXCallWithResult("/api/PM_ProjectList/GetApprovalHistory", param, false) || [];
            } catch (e) { approvalHistory = []; }

            var $tbody = $('#WF_ApprHisTable tbody');
            $tbody.empty();

            if (!approvalHistory || approvalHistory.length === 0) {
                $tbody.append('<tr><td colspan="6" class="text-center">No workflow data available</td></tr>');
                return;
            }

            approvalHistory.forEach(function (item) {
               
                // Check if this is the workflow completion record
                var isWorkflowCompletion = item.FromStage === "Complete" && item.StageStatus === 'Completed' &&
                    item.ToStage === '' &&
                    item.ApprovedBy === '';

                if (isWorkflowCompletion) {
                    var statusDot = '<span class="wf-dot ' + getHistoryDotClassFromFlags(item) + '"></span>';
                    var tr = '<tr>' +
                        '<td style="width:80px;">' + statusDot + '</td>' +
                        '<td>' + (item.FromStage || 'N/A') + '</td>' +
                        '<td></td>' +
                        '<td></td>' +
                        '<td></td>' +
                        '<td></td>' +
                        '</tr>';
                    $tbody.append(tr);
                } else {
                    var statusDot = '<span class="wf-dot ' + getHistoryDotClassFromFlags(item) + '"></span>';
                    var tr = '<tr>' +
                        '<td style="width:80px;">' + statusDot + '</td>' +
                        '<td>' + (item.FromStage || 'N/A') + '</td>' +
                        '<td>' + (item.ToStage || 'N/A') + '</td>' +
                        '<td>' + (item.Date || 'N/A') + '</td>' +
                        '<td>' + (item.ApprovedBy || 'N/A') + '</td>' +
                        '<td>' + (item.ApproverList || '') + '</td>' +
                        '</tr>';
                    $tbody.append(tr);
                }
            });
        }
        
        //// Helper function to get status class (legacy usage)
        //function getStatusClass(actionType) {
        //    switch(actionType) {
        //        case 'Approved':
        //        case 'Cleared':
        //            return 'text-success';
        //        case 'Current':
        //            return 'text-warning';
        //        case 'Delayed':
        //            return 'text-danger';
        //        case 'Skipped':
        //            return 'text-dark';
        //        default:
        //            return 'text-secondary';
        //    }
        //}
        
        // Helper function to get status icon (legacy usage)
        function getStatusIcon(actionType) {
            switch(actionType) {
                case 'Approved':
                case 'Cleared':
                    return '●';
                case 'Current':
                    return '●';
                case 'Delayed':
                    return '●';
                case 'Skipped':
                    return '●';
                default:
                    return '●';
            }
        }

       
      
        function getHistoryDotClassFromFlags(item) {
            if (!item) return 'dot-grey';
           // debugger;
            let blnIsCurrentStage = (item.IsCurrentStage === 1);
            let intIsDelayed = item.IsDelayed || 0;
            let strRequestStageID = (item.RequestStageID || '').toString();
            let strFillColor = 'dot-green';

            if (blnIsCurrentStage) {
                if (intIsDelayed !== 0 && strRequestStageID !== "3") {
                    strFillColor = 'dot-red'; // Delayed_CurrentStage_R.gif
                } else if (strRequestStageID === "3") {
                    strFillColor = 'dot-green'; // ClearedStage_R.gif
                } else {
                    strFillColor = 'dot-yellow'; // CurrentStage_R.gif
                }

                blnIsCurrentStagePassed = true;
            } else if (!blnIsCurrentStage && blnIsCurrentStagePassed) {
                strFillColor = 'dot-grey'; // Stage_Not_Reached_R.gif
            }

            return strFillColor;
        }
    </script>

    <!--  // Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas -->
      <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="projectDetailsOffcanvas">
       <div class="offcanvas-body">
           <div class="iniStageDetails">
               <div class="graybg container-fluid py-2 mb-2">
                   <div class="row">
                       <div class="col-sm-12">
                           <h5 class="pgtitle">Project Details</h5>
                       </div>
                   </div>
               </div>

               <div class="row my-2">
                   <div class="col-sm-12 ">
                       <div class="row">
                           <div class="col-sm-6">
                           </div>
                           <div class="col-sm-6 text-end">
                               <button type="button" class="btn borderbtn closebtn text-end" data-bs-toggle="tooltip"
                                   data-bs-dismiss="offcanvas" data-bs-container="body" data-bs-placement="top"
                                   data-bs-original-title="Close">
                                   Close
                               </button>
                           </div>
                       </div>
                   </div>
               </div>

               <div class="WF_DetailsMainContent">
                   <!-- Project details div desktop view starts -->
                   <div class="WF_DetlsDesktop py-3" id="projDetlsDesktop">
                       <div class="row">
                           <div class="details-main-sec">
                               <div class="d-sec1 px-4">
                                    <table class="table details-table1 mb-0">
                                        <tbody>
                                            <tr>
                                                <td class="label-td"><label>Project Name:</label></td>
                                                <td class="value-td" id="oc_ProjectName"></td>
                                                <td class="label-td"><label>Planned Effort:</label></td>
                                                <td class="value-td" id="oc_Efforts"></td>
                                            </tr>
                                            <tr>
                                                <td class="label-td"><label>Business Group:</label></td>
                                                <td class="value-td" id="oc_BusinessGroup"></td>
                                                <td class="label-td"><label>Organization Unit:</label></td>
                                                <td class="value-td" id="oc_OrganizationUnit"></td>
                                                
                                            </tr>
                                             <tr>
                                                 
                                                 <td class="label-td"><label>Project Start Date:</label></td>
                                                 <td class="value-td" id="oc_ProjectStartDate"></td>
                                                 <td class="label-td"><label>Project End Date:</label></td>
                                                 <td class="value-td" id="oc_ProjectEndDate"></td>
                                             </tr>
                                              <tr>
                                                  <td class="label-td"><label>Workflow Name:</label></td>
                                                  <td class="value-td" id="oc_WorkflowName"></td>
                                                  <td class="label-td"><label>Revision No:</label></td>
                                                  <td class="value-td" id="oc_RevisionNo"></td>
                                              </tr>
                                             </tbody>
                                    </table>
                               </div>
                               
                           </div>
                       </div>
                   </div>
                   <!-- Project details div desktop view ends -->
                   <!-- Project stages div starts -->
                   <div class="WFStagesDiv p-4" id="projStagesDiv">
                       <!-- <div class="row"> -->
                        <div class="stage-status">
                           <div class="stage-title">
                               <h5 class="mb-0">Legends</h5>
                           </div>

                            <div class="stage-content legends-inline">
                                <ul class="main-box">
                                   <li>
                                       <div class="stage-box green-box"></div>
                                       <div class="span-clrs">Cleared stage</div>
                                   </li>
                               </ul>
                                <ul class="main-box">
                                   <li>
                                       <div class="stage-box yellow-box"></div>
                                       <div class="span-clrs">Current stage</div>
                                   </li>
                               </ul>

                                 <ul class="main-box">
                                    <li>
                                        <div class="stage-box red-box"></div>
                                        <div class="span-clrs">Delayed Current stage</div>
                                    </li>
                                </ul>
                           
                                <ul class="main-box">
                                   <li>
                                       <div class="stage-box grey-box"></div>
                                       <div class="span-clrs">Stage not started yet</div>
                                   </li>
                               </ul>
                           </div>
                       </div>
                       <!-- </div> -->
                   </div>
                   <!-- Project stages div ends -->
                  
                  
                    <!--Workflow Approval History start here-->
                   <div class="WF_ApprHisDiv m-3" id="projApprHisSec">
                    
                       <div class="table-responsive">
                           <table class="table table-striped table-hover table-bordered init_borderedTbl"
                               id="WF_ApprHisTable">
                               <thead class="stickyTblHeader">
                                    <tr class="cart-table-head">
                                        <th style="width:80px;">Status</th>
                                        <th>From Stage</th>
                                        <th>To Stage</th>
                                        <th>Date</th>
                                        <th>Approved By</th>
                                        <th>Approver List</th>
                                    </tr>
                               </thead>
                               <tbody>
                                   
                               </tbody>
                           </table>
                       </div>
                   </div>
                   <!--Workflow Approval History end here-->
               </div>

               <div class="clearfix"></div>
           </div>
       </div>
   </div>
     <!--  End of Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas -->
    <style>
        /* Added by Dipali V on 6th OCT 2025 (W26): Offcanvas width */
        .offcanvas.offcanvas-70 { width: 85%!important; max-width: 1200px; }
        .graybg { background: #eef2f5; }
        .pgtitle { margin: 0; font-weight: 600; }
        .details-table1 td { padding: 8px 10px; vertical-align: middle; }
        .details-table1 .label-td { width: 18%; color: #333; text-align: left; white-space: nowrap; }
        .details-table1 .value-td { width: 32%; color: #000; font-weight: normal; }
        .closebtn { cursor: pointer; }
        .details-table1 tbody tr + tr td { border-top: 0; }
        .details-main-sec { display: block; }
        .details-main-sec .d-sec1, .details-main-sec .d-sec2 { width: 100%; }
        .details-table1 label { font-weight: 600; color: #333; }
        .stage-status .stage-title h5 { font-weight: 600; }
        .stage-content { display: flex; gap: 24px; flex-wrap: wrap; }
        .stage-content.legends-inline { flex-wrap: nowrap; align-items: center; }
        .stage-content .main-box { list-style: none; margin: 0; padding: 0; }
        .stage-content .main-box li { display: flex; align-items: center; gap: 8px; }
        .stage-box { width: 22px; height: 14px; border-radius: 2px; display: inline-block; margin-right: 8px; }
        .green-box { background: #27ae60; }
        .yellow-box { background: #f1c40f; }
        .red-box { background: #f12323; }
        .grey-box { background: #95a5a6; }
        /* Added by Dipali V on 6th OCT 2025 (W26): Approval history dots */
        .wf-dot { display:inline-block; width:14px; height:14px; border-radius:50%; }
        .dot-green { background:#27ae60; }
        .dot-yellow { background:#f1c40f; }
        .dot-red { background:#f12323; }
        .dot-grey { background:#95a5a6; }
        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
        }
        
        .offcanvas {
            width: 600px !important;
        }
        
        .form-control-plaintext {
            padding: 0.375rem 0;
            margin-bottom: 0;
            line-height: 1.5;
            color: #212529;
            background-color: transparent;
            border: solid transparent;
            border-width: 1px 0;
        }
        
        .table-sm th,
        .table-sm td {
            padding: 0.25rem;
            font-size: 11.5px;
        }
        #projectDetailsOffcanvas {
            overflow:auto!important
        }
    </style>


</body>
</html>
