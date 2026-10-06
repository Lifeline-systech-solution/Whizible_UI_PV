<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_stakeholders.aspx.vb" Inherits="Whizible.stakeholders" %>

<!DOCTYPE html>

<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Stakeholders")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8 " />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Stakeholders</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
</head>

    <style type="text/css">
         .alertify-notifier {
            z-index: 99999 !important;
         }

        .alertify-notifier {
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
        }
        html,
        body {
            background: #eee;
        }

        .issuefilter_container {
            margin-bottom: 10px;
            background: #fff;
        }

        .bgwhitewrap {
            min-height: 80vh;
            height: 100%;
        }

        div#DataTables_Table_0_info {
            float: left;
            padding-left: 15px;
        }

        div.dataTables_wrapper div.dataTables_paginate {
            margin: 0 15px 15px;
            white-space: nowrap;
            text-align: right;
            float: right;
        }


        /*added on 04-11-2019*/
        table.table td .add {
            display: none;
        }

        .dataTables_scrollFootInner, .dataTables_scrollFootInner table {
            width: 100% !important;
        }

        .dataTables_scrollHeadInner, .dataTables_scrollHeadInner table {
            width: 100% !important;
        }

        .dataTables_scroll {
            margin: 0 0 20px;
        }

        table.table td .cancelrowvalue {
            display: none;
        }

        /*
         Added By Usha Pandit On 04.11.2019 for discussion panel   
        */
        .clsShowHide {
            display: none !important;
        }
        /*
         Added By Usha Pandit On 04.11.2019 for discussion panel   
        */
        /*added by pradip on 06-11-2019*/
        .inheritcontct-dropdown .dropdown-content {
            display: none;
            padding: 10px;
            position: absolute;
            background-color: #fff;
            min-width: 230px;
            overflow: auto;
            border: 1px solid #ddd;
            z-index: 1;
        }

        .inheritcontct-dropdown {
            margin: 10px 10px 0 0;
        }

            .inheritcontct-dropdown .dropdown-content ul {
                margin: 10px -10px 0;
                padding: 0;
            }

                .inheritcontct-dropdown .dropdown-content ul li {
                    padding: 4px 10px;
                }

                .inheritcontct-dropdown .dropdown-content ul.dropdown-list {
                    margin: 0;
                    padding: 0;
                }

                .inheritcontct-dropdown .dropdown-content ul li label {
                    margin: 0;
                }

            .inheritcontct-dropdown .dropdown-content div.text-center {
                background: #f5f5f5;
                padding: 6px 0;
                margin: 0px -10px -10px;
            }


        .stacktabdetail .btnlistinline {
            margin: -36px 0 0;
        }

        .table tbody tr td {
            /*Commented & added By Rutuja D. on 21 Dec 2021 For Break the word IssueID = 31875*/
            /*word-break: break-all;*/
            word-wrap: break-word;
            /* End of Commented & added By Rutuja D. on 21 Dec 2021 For Break the word IssueID = 31875*/
        }

        div#tbl_info {
            margin-left: 10px;
        }

        .inheritcontct-dropdown span.caret {
            margin-left: 7px;
            margin-top: 7px;
            /* margin-bottom: 56px; */
            float: right;
        }
        #btninheritcontct .borderbtn:hover {
            background: #1359a6;
            color: #fff;
            border: 1px solid #1359a6;
        }

         #btninheritcontct .borderbtn {
           /* background: #1359a6;*/
            color: black;
            border: 1px solid #1359a6;
        }

        .inheriteaccess {
            pointer-events: none;
            opacity: 0.5;
        }

        .custom_chckbox input[type=checkbox][disabled] + label:before {
            margin-right: 15px;
            CURSOR: NOT-ALLOWED;
        }

        .disabledbutton {
            pointer-events: none;
            opacity: 0.7;
        }

        .filterpanel .cust_tabpanel .MyFiltersdropdown {
            z-index: 999;
        }

        .tablerequiredcontrol {
            width: 100% !important;
        }

        .dataTables_paginate a.paginate_button.disabled {
            cursor: not-allowed;
        }

        .inheritcontct-dropdown button:focus {
            background: #fff;
            color: #1359ac;
        }

        #StackReqReport td, #stackRisk td {
            padding-right: 15px;
        }

        .addnewrequiredreport span, .addnewrisks span {
            margin-right: -10px;
        }

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: black;
            padding: 4px 6px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            border-radius: 4px;
        }

        /*.fas fa-filter {
            color:black;
        }*/
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }
        /*added by pradip on 09-04-2020*/
        .srchstakeholder {
            max-width: 220px;
            margin-top: 10px;
            margin-right: 15px;
        }

        .dropdown.filedownload {
            margin-top: 4px;
        }
/*Added style for BS5 changes*/
.list-to-filter .search-box{ margin:0px 0px 10px;}
.list-to-filter .search-box .input-group-addon {
    display: table-cell;
    padding: 10px 10px;
    /* vertical-align: bottom; */
    border: 1px solid #d2d6de;
    background: #eee; margin:0px 0px;
}
 /* Modified By Madhuri.K On 26-03-2026 */ 
button#addattachnebtrow {font-size: 11.5px!important; white-space:nowrap;}
ul#tabs {background: #eee;padding: 5px 10px 0px;border: 1px solid #ddd;border-bottom: none;}


.IB_filterlist label + .form-select {
    width: 110px!important;
    margin-right: 5px;
}
.IB_filterlist .form-select, .IB_filterlist .form-control, .IB_filterlist .input-group {
    display: inline-block;
    width: 148px;
    height: 30px;
    vertical-align: top;
    font-size: 11.5px!important; /* Modified By Madhuri.K On 26-03-2026 */
}
.IB_filterlist .form-group label {
    min-width: 140px;
    font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
    text-align: right;
    padding-right: 10px;
}
.IB_filterlist .form-group {
    margin-bottom: 5px;
}
.stackbasicfilter .box .form-group{ display:inline-block; vertical-align: middle;}
.form-control.input-sm{ height:30px}

/*End css*/
        #CloseableAlert .close {
            float: right;
            border: none;
        }
button.dropdown-toggle::after{ display:none;}
.dataTables_scrollBody thead{visibility: collapse !important;}
label, li{ /* Modified By Madhuri.K On 26-03-2026 */
    font-size:11.5px; color:#464a4c;}
#stakedetailpanel{ border-top:none;}
        /*added style by pradip on 31-07-2020*/
        @media all and (-ms-high-contrast:none) {

            *::-ms-backdrop, table.dataTable thead .sorting:after, table.dataTable thead .sorting_asc:after, table.dataTable thead .sorting_desc:after {
                top: 5px;
            }
        }
        /*end style*/

        /* Added By Gauri On 21th Aug 2024 For Alignment Issue */
        /* .issuefilter_container .form-group {
            display: block !important;
        } */
        /* End of Added By Gauri On 21th Aug 2024 For Alignment Issue */

        /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        /* .form-control {
            height: unset;
        } */
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */

         /* Added By Gauri On 04th Sep 2024 For Alignment Issue */
         /* .issfilter_actiondropdown {
            position: relative;
            top: 0;
            right: 0;
        } */
        /* End of Added By Gauri On 04th Sep 2024 For Alignment Issue */
    </style>



<body id="bodystakeholder" class="hold-transition sidebar-mini fixed">
        <%--<div class="content-wrapper">--%>
        <div class="graybg container-fluid pt-1 pb-1 statckmainheader">


            <div class="row">
                <div class="col-sm-4">
                    <!--modified by pradi on 09-04-2020-->
                    <%--<div class="col-sm-3">--%>
                    <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-select'", False,, ) %>
                </div>
                <div class="col-sm-2 pl-0">
                    <%-- Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25378 --%>
                    <%--<button id="addstakeholdr" class="btn borderbtn ml-1 nobtnstyle-xs"><%= MyBase.GetResourceString("C_Add_Stakeholder") %></button>--%>
                    <button id="addstakeholdr" data-original-title="Add Stakeholder" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" class="btn borderbtn nobtnstyle-xs"><%= MyBase.GetResourceString("C_Add_Stakeholder") %></button>
                    <%-- End of Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25378 --%>
                </div>
                <div id="divstakeholderfilter" class="col-sm-6 form-inline text-end d-flex justify-content-end">
                    <div class="form-group dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectView", "usp_Whizible2_db_Sel_ListView",,, "class='form-select' onChange='javascript:ChangeView(this.value);'", False,, ) %>
                    </div>

                    <div class="form-group ml-1">
                        <a href="#" data-bs-target="#filterpanel" onclick="fillTableData(null)" style="display: none" id="StakeholderClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Clear all" data-bs-container="body"><strong><%= MyBase.GetResourceString("C_Clear_All_Filter") %></strong></a>
                    </div>
                    <div class="form-group ml-1">
                        <div class="filter float-end col-sm-offset-1">

                            <button data-bs-toggle="collapse" onclick="" data-bs-target="#filterpanel" id="btnAdvFilter">
                                <%-- Commented and Added By Vyankat B. on 1st April 2026 for adding the missing tooltip --%>

                                <%--                                <i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Advance_Filter") %>" class="fas fa-filter"></i>--%>
                                <i data-bs-toggle="tooltip" title="Filter" data-bs-placement="bottom" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Advance_Filter") %>" class="fas fa-filter"></i>
                                <%-- End of Commented and Added By Vyankat B. on 1st April 2026 for adding the missing tooltip --%>
                            </button>

                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!--filter_panel_section_satrts_here-->
        <div id="filterpanel" class="collapse filterpanel">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                <div class="row">
                    <div class="col-md-7 col-sm-7">
                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">
                                <li class="dropdown"><a class="dropdown-toggle" href="#" data-bs-toggle="dropdown"><%= MyBase.GetResourceString("C_My_Filter") %></a>
                                    <ul id="StakeholderMyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                    </ul>
                                </li>
                                <li id="basicfilterli"><a href="#presetfilter" onclick="ResetEditFilterID();" data-bs-toggle="tab"><%= MyBase.GetResourceString("C_Basic_Filter") %></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-5 col-sm-5">
                        <div class="form-inline float-end">
                        </div>
                    </div>
                </div>
            </div>
            <div class="issuefilter_container">
                <div class="tab-content issuefilter_tabcontent">
                    
                    <!-- Modal -->
                    <div class="modal custmodal  fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="true" >
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="">Save Filter As </h5>
                                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="box-panel">

                                        <div class="box-body graybg">
                                            <div class="form-group mb-0">
                                                <div class="row">
                                                    <div class="col-md-12 row">
                                                        <label class="control-label col-md-4 p-0 text-end">Filter Name <span style="color: red">*</span> :</label>
                                                        <div class="col-md-8">
                                                            <input type="hidden" name="FilterID" id="FilterID" value="0" />
                                                            <input type="hidden" name="QueryID" id="QueryID" value="0" />
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",, 500,,,, ,,,,,,, True,,,,) %><br />
                                                            <div class="btnrow">
                                                                <button class="btn btnyellow float-start savefilter" id="btnSaveBasicFilter" onclick="SaveStakeholderFilter()">Save</button>
                                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- /.content -->
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--modal-end-here-->
                    <div id="presetfilter" class="tab-pane stackbasicfilter">
                        <!--filter panel start here-->
                        <div class="filterpanelwrapbasicfilter">
                            <div class="filterpanelbody" id="divBasicfilter">
                                <div class="fp_button text-center hidden-xs centerbtn" style="margin: 0 0 40px;">
                                    <button class="btn btnyellow" id="btnsaveandapply1" onclick="btnStakeholderSaveAndApplyFilter_Onclick()"><%= MyBase.GetResourceString("C_Save_And_Apply") %></button>
                                    <button class="btn btnyellow" onclick="StakeholderbtnApplyFilter()"><%= MyBase.GetResourceString("C_Apply") %></button>
                                </div>
                                <div class="row hidden-xs IB_filterlist">
                                    <!--basic filter start here-->
                                    <div class="form-inline">

                                        <div class="box box-solid p1">
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Group1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterContactCategoryID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterContactCategoryID", "usp_Whizible2_Sel_ContactCategory_ForFilters ",,, "class='form-select'", True,, ) %>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                        <div class="box box-solid p1">
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Name1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterName", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterName", "txtPMFilterName", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Organisation_Name1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterOrganizationName", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterOrganizationName", "txtPMFilterOrganizationName", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Client1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterClientId", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterClientId", "usp_Whizible2_Sel_tbl_PM_Client " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select'", True,, ) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Designation1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterDesignation", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterDesignation", "txtPMFilterDesignation", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Type1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterTypeOfContactID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterTypeOfContactID", "usp_Whizible2_Sel_TypeOfContact_ForFilters ",,, "class='form-select bgwhite'", True,, ) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="clearfix"></div>
                                            <div class="form-group" style="display: block;">
                                                <label for="email"><%= MyBase.GetResourceString("C_Principle_Contact1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterPrincipalContact", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterPrincipalContact", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'", True,,) %>
                                                <div class="clearfix"></div>
                                            </div>

                                        </div>

                                        <div class="box box-solid p1">
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Phone11") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterPhone1", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterPhone1", "txtPMFilterPhone1", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Extension_No1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterExt1", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterExt1", "txtPMFilterExt1", "form-control",, 5,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Phone21") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterPhone2", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterPhone2", "txtPMFilterPhone2", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Extension_No21") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterExt2", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterExt2", "txtPMFilterExt2", "form-control",, 5,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Fax1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterFax", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterFax", "txtPMFilterFax", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Mobile_No1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterMobile", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterMobile", "txtPMFilterMobile", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Email_ID1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterEmailID", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterEmailID", "txtPMFilterEmailID", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_URL1") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterURL", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterURL", "txtPMFilterURL", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Active1") %></label>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterActiveStatus", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterActiveStatus", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'", True,,) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />


                                        </div>

                                        <div class="box box-solid p1">

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Address11") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterAddress1", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterAddress1", "txtPMFilterAddress1", "form-control",, 80,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Address21") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterAddress2", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterAddress2", "txtPMFilterAddress2", "form-control",, 80,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_City1") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterCity", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterCity", "txtPMFilterCity", "form-control",, 30,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Zip_Postal_Code1") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterZip", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterZip", "txtPMFilterZip", "form-control",, 20,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_State1") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterState", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterState", "txtPMFilterState", "form-control",, 30,,,,,,,,,,,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Country1") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterCountryID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterCountryID", "usp_Whizible2_Sel_tbl_PM_Country",,, "class='form-select'", True,, ) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <br />

                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Notes1") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterNotes", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="form-group" style="width: 61%">
                                                <% CommonFunctions.HTMLControls.DrawTextArea("txtPMFilterNotes", "txtPMFilterNotes", "form-control",,,,,,,, 1000,,,,,,,,, ,,,,,,,,, True) %>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Correspondance_Address1") %></label>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterCorrespondenceAddress", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterCorrespondenceAddress", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'", True,,) %>

                                                <div class="clearfix"></div>
                                            </div>

                                        </div>
                                    </div>
                                    <!--basic filter end here-->
                                    <div class="clearfix"></div>
                                </div>

                                <div class="fp_button text-center hidden-xs centerbtn">

                                    <button class="btn btnyellow" id="btnsaveandapply2" onclick="btnStakeholderSaveAndApplyFilter_Onclick()"><%= MyBase.GetResourceString("C_Save_and_Apply_Filter") %></button>
                                    <button class="btn btnyellow" onclick="StakeholderbtnApplyFilter()"><%= MyBase.GetResourceString("C_Apply_Filter") %></button>
                                </div>
                            </div>
                        </div>

                        <br />
                        <br />
                    </div>


                    <div id="queryfilter" class="tab-pane">

                        <div class="filterpanelbody">

                            <div class="row">
                                <div class="col-sm-8 col-md-8">

                                    <div id="addlistfilter" class="addfilterpanel issueorder-list">

                                        <div class="addfilterrow">
                                            <div class="order-list">
                                                <button data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Click here to Add More" id="addrow" class=""><%= MyBase.GetResourceString("C_Add_Rules") %><i class="fas fa-plus"></i></button>
                                            </div>

                                        </div>

                                    </div>
                                    <br />
                                    <br />

                                    <br />
                                    <br />
                                    <div class="col-sm-12">
                                        <div class="advancebuilder_save centerbtn">
                                            <input type="hidden" id="advCounter" value="0" />
                                            <button class="btn btnyellow" id="appendbtn" onclick="append();"><%= MyBase.GetResourceString("C_Append") %></button>
                                            <button class="btn btnyellow" id="btnsaveandapply3" onclick="saveADVAdvanceFilter()"><%= MyBase.GetResourceString("C_Save_And_Apply_Advance") %></button>
                                            <button class="btn btnyellow" id="btnadvappy" onclick="applyAdvancfilter()"><%= MyBase.GetResourceString("C_Apply_Advance") %></button>
                                        </div>

                                    </div>

                                </div>

                                <div class="col-sm-4 col-md-4">

                                    <div class="box box-panel box-solid graybg filterprofields" id="filterprofields">
                                        <div class="form-control" id="queryfilterclear">
                                            Filter Query
                                        </div>
                                        <input type="hidden" id="AdvancequeryFilter" value="" />
                                    </div>

                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--filter panel-end-here-->

        <div id="divstakeholdertableheader" class="timesheetrow container-fluid bgwhite ts_headerbot">
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-7">
                    <ul class="statustext hidden-xs">
                        <li id="liCustomer" data-bs-toggle="tooltip" data-bs-placement="top" title="Customer" class="criticle" data-original-title="Customer"><a href="javascript:;" class="customercount"><span class="statustextno" id="Customercount">0</span><%= MyBase.GetResourceString("C_Customer") %></a></li>
                        <li id="liOrganization" data-bs-toggle="tooltip" data-bs-placement="top" title="Organization" class="overdue" data-original-title="Organization"><a href="javascript:;" class="Organizationcount"><span class="statustextno" id="Organizationcount">0</span><%= MyBase.GetResourceString("C_Organisation") %></a></li>
                        <li id="liOther" data-bs-toggle="tooltip" data-bs-placement="top" title="Other" class="pending" data-original-title="Tester"><a href="javascript:;" class="Othercount"><span class="statustextno" id="Othercount">0</span><%= MyBase.GetResourceString("C_Other") %></a></li>
                    </ul>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-5 float-end">
                    <ul class="float-end btnlistinline" id="btnExportLinks">
                        <li>
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" id="btnstakeholderdownload" data-bs-toggle="dropdown" autocomplete="off" data-bs-placement="top" data-original-title="Download"><i class="fas fa-download" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Download"></i></button>

                                <ul class="dropdown-menu" id="fas-download">
                                    <li>
                                        <a href="#" onclick="DownloadReport('PDF')">
                                            <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('EXCEL')">
                                            <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('XML')">
                                            <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('TEXT')">
                                             <%--Commented & Added By Dipali V On 21st March 2023 For Doc should be text--%>
                                            <%--<img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc</a>--%>
                                            <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text</a>
                                            <%--//Commented & Added By Dipali V On 21st March 2023 For Doc should be text--%>
                                    </li>

                                </ul>
                            </div>

                        </li>
                      
                    </ul>
                    <!--added by pradip on 09-04-2020-->
                    <div class="input-group srchstakeholder float-end">
                        <input id="serchstakholders" type="text" placeholder="Search.." onkeyup="myFunctionUI()" class="form-control input-sm">
                        <div class="input-group-btn">
                            <button class="btn btn-default" type="submit" style="height: 30px;"><i class="fas fa-search"></i></button>
                        </div>
                    </div>
                    <%--Commented & Added By Dipali V On 24th March 2023 For Inherit Contact Funcationality not working--%>
                    <!--End added by pradip-->
                    <%--<div id="btninheritcontct" class="dropdown inheritcontct-dropdown float-end">
                        <button onclick="myFunction()" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Inherit Contact" class="dropbtn btn borderbtn">Inherit Contact</button>
                        <div id="myDropdown" class="dropdown-content">
                            <input type="text" placeholder="Search.." id="myInput" class="form-control" onkeyup="filterFunction()" />
                            <ul id="ulinheritcontct">
                            </ul>
                            <div class="text-center">
                                <button id="btninheritcontctok" class="btn btnyellow">OK</button>
                            </div>
                        </div>
                    </div>--%>


                      <div id="btninheritcontct" class="dropdown inheritcontct-dropdown float-end">
                        <button onclick="myFunction()" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Inherit Contact" class="dropbtn btn borderbtn">Inherit Contact<span class="caret"></span></button>
                        <div id="myDropdown" class="dropdown-content">
                            <input type="text" placeholder="Search.." id="myInput" class="form-control" onkeyup="filterFunction()" />
                            <ul id="ulinheritcontct">
                            </ul>
                            <div class="text-center">
                                <button id="btninheritcontctok" class="btn btnyellow">OK</button>
                            </div>
                        </div>
                    </div>
                       <%--End of Commented & Added By Dipali V On 24th March 2023 For Inherit Contact Funcationality not working--%>
                 

                </div>
                <div class="clearfix"></div>
            </div>
        </div>

        <!-- Main content -->
    <div class="bgwhite">
        <section id="sectionstakeholdermain" class="content">

            <div class="bgwhitewrap">
                <div id="hidestaklist" class="table-responsive">
                    <table class="table bgwhite table-bordered table-fixed-header Stakeholdertbl" id="tbl" style="width:100%!important;">
                        <thead>
                            <tr>
                                <th class="dropdown keep-inside-clicks-open text-center">Name 
                                    <button onclick="thdFltr()" class="dropdown-toggle nostylebtn" data-bs-toggle="dropdown" data-bs-auto-close="false"><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Name Filter" class="fas fa-filter"></i></button>
                                    <!--filter list start here-->
                                    <div aria-labelledby="filterpanel" class="dropdown-menu" id="nameFilterSearch">
                                        <div class="list-to-filter">
                                            <div class="search-box">
                                                <div class="input-group">
                                                    <span class="input-group-addon" id="search-icon5">
                                                        <span class="fa fa-search"></span>
                                                        <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                    </span>
                                                    <input type="text" placeholder="Search" id="stakeCategoriesSearchname" class="form-control stakeCategoriesSearch" tabindex="1" autocomplete="off" onkeyup="StakeNameSearchFuntion(this)"/>
                                                </div>
                                            </div>
                                            <ul id="stakeCategoriesSearchlistname" class="stakeCategoriesSearchlist">
                                            </ul>
                                        </div>
                                    </div>
                                    <!--filter list end here-->
                                </th>
                                <th id="stackstaus">Status </th>
                                <th class="dropdown keep-inside-clicks-open">Designation 
                                    <button class="dropdown-toggle nostylebtn" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Designation Filter" class="fas fa-filter"></i></button>
                                    <!--filter list start here-->
                                    <div aria-labelledby="filterpanel" class="dropdown-menu" id="descFilterSearch">
                                        <div class="list-to-filter">
                                            <div class="search-box">
                                                <div class="input-group">
                                                    <span class="input-group-addon" id="search-icon5">
                                                        <span class="fa fa-search"></span>
                                                        <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
                                                    </span>
                                                    <input type="text" placeholder="Search" id="stakeCategoriesSearchdesignation" class="form-control stakeCategoriesSearch" tabindex="1" autocomplete="off" onkeyup="StakeDesignationSearchFuntion(this)"/>
                                                </div>
                                            </div>
                                            <ul id="stakeCategoriesSearchlistdesignation" class="stakeCategoriesSearchlist">
                                            </ul>
                                        </div>
                                    </div>
                                    <!--filter list end here-->

                                </th>
                                <th id="" class="dropdown keep-inside-clicks-open">Contact Info 
                                </th>
                                <th id="" class="dropdown keep-inside-clicks-open">Type 
                                </th>
                                <th class="hoveractions">&nbsp;</th>
                                <th class="hidden">&nbsp;</th>
                            </tr>
                        </thead>

                    </table>
                    <div class="clearfix"></div>
                </div>

                <hr />

                <!--stakedetail section start here-->
                <div id="stakedetailpanel">
                    <div class="stackmaintab stacktabdetail p1">
                        <ul id="tabs" class="nav nav-tabs detailsubtabs" role="tablist">
                            <li id="tabDetails" class="nav-item"><a href="#stackDetail" class="nav-link active" data-bs-toggle="tab"><%= MyBase.GetResourceString("C_Details") %></a></li>
                            <li id="tabRisk" class="nav-item"><a data-bs-toggle="tab" class="nav-link" href="#stackRisk"><%= MyBase.GetResourceString("C_Risks") %></a></li>
                            <li id="tabReport" class="nav-item"><a data-bs-toggle="tab" class="nav-link" href="#StackReqReport"><%= MyBase.GetResourceString("C_Required_Reports") %></a></li>
                            <li id="tabAttachments" class="nav-item"><a href="#allAttachments"  class="nav-link" rol="tab" data-bs-toggle="tab">All Attachments</a></li>
                        </ul>
                        <div class="clearfix"></div>
                        <div class="tab-content">
                            <!--Details tab end here-->
                            <div class="tab-pane active" id="stackDetail">
                                <ul class="float-end btnlistinline">
                                    <li class="mt-1">

                                        <button class="btn borderbtn nobtnstyle-xs canclebtn"><%= MyBase.GetResourceString("C_Cancle") %></button>
                                        <!-- <button class="btn borderbtn nobtnstyle-xs editbtn">Edit</button> -->
                                        <button id="btnStakeholderDetailsSave" class="btn btnyellow nobtnstyle-xs savebtn"><%= MyBase.GetResourceString("C_Save") %></button>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Group") %><span style="color: red;">*</span></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("SContactCategoryID", "usp_Whizible2_Sel_ContactCategory_ForFilters ",,, "class='form-select'", True,, ) %>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row" id="divName">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Name") %><span style="color: red;">*</span></label>
                                            <div class="col-sm-8">
                                                <input type="hidden" id="ProjectContactID" value="0" />
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SName", "SName", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row" id="divNameforOrganization" style="display: none">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Name") %><span style="color: red;">*</span></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("SNameOrganization", "usp_Whizible2_Sel_tbl_PM_ProjectResources " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select'", True,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div class="row newproformrow" id="divCustmer" style="display: none">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-on  ehalf text-end"><%= MyBase.GetResourceString("C_Customer") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SCustomer", "SCustomer", "form-control",, 50,,,,, True,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>

                                    <div class="row newproformrow" id="divClient">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-on  ehalf text-end"><%= MyBase.GetResourceString("C_Client") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("SClientID", "usp_Whizible2_Sel_tbl_PM_Client " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select' Onchange='ClientOnchange()'", True,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>


                                    <div class="row newproformrow" id="divOrganization" style="display: none">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-on  ehalf text-end"><%= MyBase.GetResourceString("C_Organisation_Name") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SOrganizationName", "SOrganizationName", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>

                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Designation") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SDesignation", "SDesignation", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>

                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Type") %><span style="color: red;">*</span></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("STypeOfContactId", "usp_Whizible2_Sel_TypeOfContact_ForFilters ",,, "class='form-select bgwhite'", True,, ) %>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Principle_Contact") %></label>
                                            <div class="col-sm-8">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("SPrincipleContact", "SPrincipleContact", "chckHead",) %>
                                                    <label for="SPrincipleContact"></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <hr />
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Phone1") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("Sphone1", "Sphone1", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Extension_No") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SExt1", "SExt1", "form-control",, 5,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Phone2") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("Sphone2", "Sphone2", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Extension_No2") %></label>
                                            <div class="col-sm-8">
                                                <%--<input type="text" name="" class="form-control" id="SExt2" />--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SExt2", "SExt2", "form-control",, 5,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Fax") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("Sfax", "Sfax", "form-control",, 50,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Mobile_No") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SMobile", "SMobile", "form-control",, 10,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Email_ID") %><span id="MandatoryProduct" style="color: red;">*</span></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SEmailID", "SEmailID", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_URL") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SURL", "SURL", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Active") %></label>
                                            <div class="col-sm-8">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("SActive", "SActive", "chckHead", True) %>
                                                    <label for="SActive"></label>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Address1") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SAddress1", "SAddress1", "form-control",, 80,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Address2") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SAddress2", "SAddress2", "form-control",, 80,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_City") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SCity", "SCity", "form-control",, 30,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Zip_Postal_Code") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SZip", "SZip", "form-control",, 20,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_State") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("SState", "SState", "form-control",, 30,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Country") %></label>
                                            <div class="col-sm-8">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("SCountryID", "usp_Whizible2_Sel_tbl_PM_Country",,, "class='form-select'", True,, ) %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"><%= MyBase.GetResourceString("C_Notes") %><%= MyBase.GetResourceString("C_CoC_Correspondance_Addressuntry") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawTextArea("SNotes", "SNotes",, "form-control",,,,,,,, 1000,,,,,,,,,,,,,,,,, True) %>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row newproformrow">
                                        <div class="col-sm-6 row">
                                            <label class="control-label col-sm-4 mt-onehalf text-end"></label>
                                            <div class="col-sm-8">
                                                <div class="custom_chckbox">
                                                    <% CommonFunctions.HTMLControls.DrawCheckBox("SCorrecpondenceAddress", "SCorrecpondenceAddress", "chckHead",) %>
                                                    <label for="SCorrecpondenceAddress"><%= MyBase.GetResourceString("C_Correspondance_Address") %></label>
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                </div>
                            </div>
                            <!--Details tab end here-->

                            <!--stackRisk tab end here-->
                            <div class="tab-pane" id="stackRisk">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="headercontainer">
                                        <div class="table-responsive tablecontainer">
                                            <table class="table bgwhite table-bordered table-fixed-header StackholderRisktbl">
                                                <thead>
                                                    <tr>
                                                        <th width="25%">
                                                            <div>Risk</div>
                                                        </th>
                                                        <th width="38%">
                                                            <div>Description</div>
                                                        </th>
                                                        <th>
                                                            <div>Risk From/To Stakeholder</div>
                                                        </th>
                                                        <th style="min-width: 100px;">
                                                            <div></div>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodyStackholderRisktbl">
                                                </tbody>
                                                <tfoot class="orderattachlist">
                                                    <tr>
                                                        <td colspan="4" class="text-start">
                                                            <button id="addRiskrow" value="Add Row" class="btn borderbtn add-new"><%= MyBase.GetResourceString("C_Add_New_Risk") %></button>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <!--stackRisk tab end here-->


                            <!--Stackreport tab end here-->
                            <div class="tab-pane" id="StackReqReport">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="headercontainer">
                                        <div class="tablecontainer">
                                            <table id="stakereqreport" class="order-list table bgwhite table-bordered StackholderReqReporttbl">
                                                <thead>
                                                    <tr>
                                                        <th width="34%">
                                                            <div>Report Name</div>
                                                        </th>
                                                        <th width="12%">
                                                            <div>Frequency </div>
                                                        </th>
                                                        <th width="45%">
                                                            <div>Description</div>
                                                        </th>
                                                        <th class="text-center" width="15%">&nbsp;
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodyStackholderReqReporttbl">
                                                </tbody>
                                                <tfoot class="orderattachlist">
                                                    <tr>
                                                        <td colspan="4" class="text-start">
                                                            <button id="addRequiredReportrow" value="Add Row" class="btn borderbtn add-new"><%= MyBase.GetResourceString("C_Add_New_RequiredReport") %></button>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <!--Stackreport tab end here-->

                            <!--All Attachment tab start here-->
                            <div class="tab-pane" id="allAttachments">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="headercontainer">
                                        <div class="tablecontainer">
                                            <div class="commentboxbody">
                                                <div class="all_attachedfileslist col-sm-12">
                                                    <table id="atchmentTable" class="table table-fixed-header table-stripped order_attchmentlist">
                                                        <thead>
                                                            <tr>
                                                                <th width="2%" class="text-start">Sr No</th>
                                                                <th width="25%" class="text-start">File Name</th>
                                                                <th width="10%" class="text-start">File Size</th>
                                                                <th width="15%" class="text-start">Attached By</th>
                                                                <th width="15%" class="text-center">Date</th>
                                                                <th width="30%" class="text-start">Description</th>
                                                                <th class="text-start" width="5%"></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tbodyatchmentTable">
                                                        </tbody>
                                                        <tfoot class="orderattachlist">
                                                            <tr>
                                                                <td class="text-start">
                                                                    <button id="addattachnebtrow" value="Add Row" class="btn borderbtn"><%= MyBase.GetResourceString("C_Add_New_Attachment") %></button>
                                                                </td>
                                                                <td colspan="6">
                                                                    <button id="btnAttachment" disabled="disabled" type="button" class="btn btnyellow ml-1 float-end"><%= MyBase.GetResourceString("C_Upload") %></button>
                                                                </td>
                                                            </tr>
                                                        </tfoot>
                                                    </table>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--All Attachment tab end here-->

                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                </div>
                <!--stakedetail section end here-->

                <br />
                <br />
                <div class="clearfix"></div>
                <!--comment_section_start_here-->
                <div class="col-xs-12 convAndatchmnt_panel px-3">
                    <div class="box box-solid collapsed-box">
                        <div class="box-header with-border">
                            <h3 class="box-title"><%= MyBase.GetResourceString("C_Conversation_and_Attachments") %></h3>
                            <div class="box-tools float-end">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse" id="panelDiscussion">
                                    <%--Id Added By Usha Pandit On 25.10.2019--%>
                                    <i class="fas fa-chevron-down"></i>
                                </button>
                            </div>
                            <!-- /.box-tools -->
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <div class="conversationbox">
                                <div class="col-sm-12">
                                    <div class="box-footer box-comments col-md-12 mt-0 slim-scroll" id="stakeholderDiscussions">
                                    </div>
                                    <div class="commentedtitor col-sm-12" id="stakeholderEditDiscussion">
                                        <%--Id Added By Usha Pandit On 25.10.2019--%>
                                        <!-- the comment box -->
                                        <div class="box-comment">
                                            <!-- User image -->
                                            <span class="usernameshort circle-bggreen float-start">PP</span>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-1">
                                                <span class="usernameshort circle-bggreen">PP</span>
                                            </div>
                                            <div class="col-sm-11">
                                                <div class="box-body pad">
                                                    <textarea style="height: 80px;" class="textarea form-control" id="editorCmt" name="editor1" rows="5" cols="30">This is my textarea. Please enter your comment here.</textarea>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <button type="submit" name="say" id="saveCommentbtn" value="" class="btn comentbtn btnyellow float-end"><i class="fa fa-reply"></i><%= MyBase.GetResourceString("C_Comment") %></button>
                                        <div class="clearfix"></div>
                                    </div>


                                </div>



                            </div>
                        </div>
                        <!-- /.box-body -->
                    </div>
                </div>
                <!--comment_section_end_here-->

                <div class="clearfix"></div>

            </div>

            <!--comment_section_start_here-->

            <!--comment_section_end_here-->
            <div class="clearfix"></div>

        </section>
        <div class="clearfix"></div>
            </div>
        <!-- /.content-wrapper -->

        <%--Delete stakeholder details Modal Starts--%>
        <div id="deleteStakeholdermodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" onclick="cancelStakeholderDelete()" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <span id="DeleteStakeholderId"></span>
                        <p align="center">Do you want to Delete ?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelStakeholderDelete()">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteStakeholder()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <%--Delete Modal Ends--%>

        <%--Delete risk Modal Starts--%>
        <div id="deleteRiskmodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" onclick="cancelRiskDelete()" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <span id="DeleteRiskId"></span>
                        <p align="center">Do you want to Delete ?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelRiskDelete()">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteRisk()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <%--Delete Modal Ends--%>

        <%--Delete reports Modal Starts--%>
        <div id="deleteReqReportmodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" onclick="cancelReqReportDelete()" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <span id="DeleteReqReportId"></span>
                        <p align="center">Do you want to Delete ?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelReqReportDelete()">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteReqReport()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <%--Delete Modal Ends--%>

        <%--Inherite contact report Modal Starts--%>
        <div id="Inheritecontactmodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" onclick="cancelInheritecontact()" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title"><%= MyBase.GetResourceString("C_InheriteContact_Title") %></h4>
                    </div>

                    <div class="modal-body">
                        <span></span>
                        <p align="center"><%= MyBase.GetResourceString("C_InheriteContact_ConfirmationMessage") %></p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="noInheritecontact()">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="addInheritecontact()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <%--Inherite contact report Modal Ends--%>

        <!-- Bootsrap closable alert -->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
            <button type="button" onclick="CloseShowAlert()" class="close">×</button>
            <p id="alertMsg"></p>
        </div>



    <!-- REQUIRED JS SCRIPTS -->

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/common_filters.js"></script>

    <%--<script>--%>
    <%-- Added By Usha Pandit On 25.10.2019 for discussion panel   --%>
    <!-- Bootstrap slimscroll -->
    <script src="../../../Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <%-- End Of Added By Usha Pandit On 25.10.2019 for discussion panel   --%>

    <script>

        //Added By Riddhesh Patil on 10-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of Added By Riddhesh Patil
        var ReportFilterQuery;
        var projectcontactid = "";
        var counterFORattachment = 0;
        var i = "1";
        var j = "1";
        var k = "1";
        //===============================================================[Windows Onload Event]
        window.onload = function GetSessionProject(changeProjectID) {

            ReportFilterQuery = '';
            var UserName = '<%= Session("strUserName") %>';
        var SessionProjectId = '<%= Session("intProjectID") %>';
        var SessionRoleId = '<%= Session("intPostID") %>';
        let projectID = '<%= Request.QueryString("ProjectID")%>';
        fillprojectname();
        if (projectID != '') {
            $("#CboProject").val(projectID);
            $("#CboProject").trigger("change");
        }
        enableDisabledControls();
        fillFrequency();
        fillReportTagMaster();
        CheckUserRole(2104, SessionRoleId);
        if (SessionProjectId.length) {
            if (projectID.length) {
                $("#CboProject").val(projectID);
                $("#CboProject").trigger("change");
            }
            else {
                $("#CboProject").val(SessionProjectId);
                $("#CboProject").trigger("change");
                $('#tabActive').css('tab-slider-trigger,.active');
            }
        }
        else if (projectID.length) {
            //CboProject_OnChange(projectID);
            $("#CboProject").val(projectID);
            $("#CboProject").trigger("change");
        }
        else {
            showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
            }
        }
        //===============================================================[End Windows Onload Event]

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginId = '<%= Session("intLoginID") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var AddAccess = '<%=m_AddAccess%>';
        var EditAccess = '<%=m_EditAccess%>';
        var DeleteAccess = '<%=m_DeleteAccess%>';
        var ViewAccess = '<%=m_ViewAccess%>';
        var DailyTask;
        var selectedFilterId;
        var FilterID;
        var GlobalFilterName;
        var GlobalApplyID;
        var Flag = 0;
        var DeleteRole;
        var ProjectID = '<%= Session("intProjectID")%>';
        var editProjectID = "0";
        var projectContactID = 0;
        var table = $('#tbl').dataTable();
        var frequencyList;
        var reportTagMasterList;
        //#region checkRoles
        var gRunningID = 0;


        function CheckUserRole(TagId, RoleID) {

            var roleAccess = {
                TagID: TagId,
                RoleID: RoleID
            }

            SetUserAccess();
        }

        // Enable Stakeholder details Controls
        function EnableStakeholderControls() {
            $("#SName").prop('disabled', false);
            $("#SClientID").prop('disabled', false);
            $("#SDesignation").prop('disabled', false);
            $("#SContactCategoryID").prop('disabled', false);
            $("#Sphone1").prop('disabled', false);
            $("#Sphone2").prop('disabled', false);
            $("#SExt1").prop('disabled', false);
            $("#SExt2").prop('disabled', false);
            $("#SOrganizationName").prop('disabled', false);
            $("#Sfax").prop('disabled', false);
            $("#SMobile").prop('disabled', false);
            $("#SEmailID").prop('disabled', false);
            $("#SURL").prop('disabled', false);
            $("#SActive").prop('disabled', false);
            $("#SPrincipleContact").prop('disabled', false);
            $("#SAddress1").prop('disabled', false);
            $("#SAddress2").prop('disabled', false);
            $("#SCity").prop('disabled', false);
            $("#SZip").prop('disabled', false);
            $("#SState").prop('disabled', false);
            $("#SCountryID").prop('disabled', false);
            $("#SNotes").prop('disabled', false);
            $("#SCorrecpondenceAddress").prop('disabled', false);

        }

        //set user access
        function SetUserAccess() {
            //Commented and added by Chetan M on 30th Jul 2020 for Issue ID  = 25378
            //$("#addstakeholdr").tooltip();
            //$("#addstakeholdr").popover();

            //$("#addstakeholdr").prop('disabled', false);
            //$("#addstakeholdr").attr('title', 'Add Stakeholder');
            $("#addstakeholdr").prop('disabled', false);
            //End of Commented and added by Chetan M on 30th Jul 2020 for Issue ID  = 25378
            if (AddAccess == "False") {
                $("#addstakeholdr").prop('disabled', true);
                $("#addstakeholdr").tooltip();
                $("#addstakeholdr").popover();


                $("#addstakeholdr").attr('title', 'You Dont have access to add');
                $("#btninheritcontct").addClass("inheriteaccess");
                $("#btninheritcontct").attr('title', 'You Dont have access to add');
            }

            if (AddAccess == 'False' && EditAccess == 'False' && DeleteAccess == 'False' && ViewAccess == 'False') {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                $("#btnstakeholderdownload").attr('title', 'You Dont have access to download');
                $("#btnstakeholderdownload").addClass("inheriteaccess");
            }
        }

        //Filter code logic
        //To check is default filter is applied for user on Sub Project page Click
        function StakeholderDefaultFilter() {
            var TagID = 2104;

            //if (projectID == '0' || projectID == '' ) {
            //    projectID = -1;
            //}

            var StakeholderFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                TagID: encodeURI(TagID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }
            StartLoader("#bodystakeholder");
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/CheckStakeholderDefaultFilter',
                method: 'Post',
                data: JSON.stringify(StakeholderFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (StakeholderFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(StakeholderFilterParameter) ? StakeholderFilterParameter : JSON.stringify(StakeholderFilterParameter)));
                    }
                },
                success: function (result) {

                    var FilterID = result.FilterID;
                    var QueryText = result.QueryText;
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                    }
                    GlobalApplyID = "Apply" + FilterID;
                    fillTableData(QueryText);

                    if (AddAccess == "False") {
                        $("#btnAddStakeholder").hide();
                    }

                    if (FilterID != 0) {
                        $("#DivStakeholderFilter").addClass("active");
                    } else {
                        $("#DivStakeholderFilter").removeClass("active");
                    }
                    //$(".WBSMLlistdetailpanel").css('display', 'none');
                    //$(".WBSmodulelistdetailpanel").css('display', 'none');
                    //$(".WBSDeliverablelistdetailpanel").css('display', 'none');
                    ////$("#WBSStakeholderlistdetailpanel").css('display', 'none');
                    //$(".WBSphaselistdetailpanel").css('display', 'none');

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodystakeholder")
        }
        var SPFilterAllFields = ["ContactCategoryID", "Name", "OrganizationName", "ClientId", "Designation", "TypeOfContactID", "PrincipalContact", "Phone1", "Phone2", "Ext1", "Ext2", "Fax", "Mobile", "EmailID", "URL", "ActiveStatus", "Address1", "Address2", "City", "Zip", "State", "CountryID", "Notes", "CorrespondenceAddress"];
        var module = "PM";

        //Onclick of stakeholder Apply button 
        function StakeholderbtnApplyFilter() {
            //debugger;
            var strQuery = "";
            strQuery = GenerateBasicFilterQuery(module, SPFilterAllFields);
            if (strQuery == "1") {
                showAlert('<%= MyBase.GetResourceString("C_Filter_OneFieldOperatorIsNotSelected") %>', 'alert-danger');
            return;
        } else if (strQuery == "2") {
            showAlert('<%= MyBase.GetResourceString("C_Filter_OneFieldValueIsNotSelected") %>', 'alert-danger');
            return;
        }
        if (strQuery == "") {
            showAlert('<%= MyBase.GetResourceString("C_Filter_PleaseSelectAtLeastOneFilterOption") %>', 'alert-danger');
            }
            else {
                //cOMMENTED & added By Dipali V On issue id 25040
                //Added by Chetan M on 11th April 2020 for IssueId = 23186    
                //alert($("#txtPMFilterOrganizationName").val());
                if ($("#txtPMFilterOrganizationName").val() != "" && $("#txtPMFilterContactCategoryID option:selected").val() == "") {
                    strQuery = strQuery + " AND  ContactCategory = ''Other''";
                }


                // if ($("#txtPMFilterOrganizationName").val != ""  && $("#txtPMFilterContactCategoryID option:selected").val() == "") {
                //    strQuery = strQuery + " AND  ContactCategory = ''Other''";
                //}
                //End of Added by Chetan M on 11th April 2020 for IssueId = 23186
                //End of and cOMMENTED & added By Dipali V On issue id 25040
                fillTableData(strQuery);
                //$("#StakeholderClearAllFilter").removeClass("disabledbutton");
                //Added By Reshma Chavan on 3rd jan 2021 not getting alert
                showAlert("Filter applied Sucessfully", 'alert-success');
                //Added By Reshma Chavan on 3rd jan 2021 not getting alert
                $("#StakeholderClearAllFilter").show();
                $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                $(".filterpanel ").removeClass("in");
                $("#DivStakeholderFilter").addClass("active");
                $("#presetfilter").removeClass("active");
                $("#basicfilterli").hasClass("active"); {
                    $("#basicfilterli").removeClass("active");
                }
                //clearBasicFilters();
            }
            return strQuery;
        }

        //reset edit filters
        function ResetEditFilterID() {
            $(".stackbasicfilter").addClass("active");
            if ($("#basicfilterli").hasClass("active")) {

            } else {
                Flag = 0;
                FilterID = 0;

            }
        }




        //Save and apply filter
        function btnStakeholderSaveAndApplyFilter_Onclick() {

            if (CheckProjectIsSelect()) {
                var TagID = 2104;
                var strQuery = GenerateBasicFilterQuery(module, SPFilterAllFields);
                if (strQuery == "1") {
                    showAlert('<%= MyBase.GetResourceString("C_Filter_OneFieldOperatorIsNotSelected") %>', 'alert-danger');
                return;
            } else if (strQuery == "2") {
                showAlert('<%= MyBase.GetResourceString("C_Filter_OneFieldValueIsNotSelected") %>', 'alert-danger');
                return;
            }
            if (strQuery.length > 0) {
                $("#Issuesavefilter").modal("show");
                $('#spanTagId').attr('value', TagID);
            } else {
                showAlert('<%= MyBase.GetResourceString("C_Filter_PleaseSelectAtleastoneFilter") %>', 'alert-danger');
                }
            }
        }

        //savestakeholder filter
        function SaveStakeholderFilter() {
            if (CheckProjectIsSelect()) {
                var FilterName = replaceAllChar($("#txtFilterName").val().trim());
                var strQuery = GenerateBasicFilterQuery(module, SPFilterAllFields);
                if (strQuery == "1") {
                    showAlert('<%= MyBase.GetResourceString("C_Filter_OneFieldOperatorIsNotSelected") %>', 'alert-danger');
                return;
            } else if (strQuery == "2") {
                showAlert('<%= MyBase.GetResourceString("C_Filter_OneFieldValueIsNotSelected") %>', 'alert-danger');
                return;
            }
            if (strQuery == "") {
                showAlert('<%= MyBase.GetResourceString("C_Filter_PleaseSelectAtleastoneFilter") %>', 'alert-danger');
            }
            //Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter($("#txtFilterName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtFilterName").focus();
                return;
            }
            //End of Added By Riddhesh Patil
            //Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter($("#txtFilterName").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtFilterName").focus();
                return;
            }
            //End of Added By Riddhesh Patil
            else if (FilterName.trim() != '') {
                //Added by Chetan M on 11th April 2020 for IssueId = 23186
                if ($("#txtPMFilterOrganizationName").val() != "" && $("#txtPMFilterContactCategoryID option:selected").val() == "") {
                    strQuery = strQuery + " AND  ContactCategory = ''Other''";
                }
                //End of Added by Chetan M on 11th April 2020 for IssueId = 23186
                var IsFilterNameExists = "0";
                var StakeholderFilterParameter = {
                    TagID: encodeURI(2104),
                    ProjectID: encodeURI($("#CboProject :selected").val()),
                    UserID: encodeURI(UserID),
                    FilterName: encodeURI(FilterName),
                    LoginType: encodeURI(LoginType),
                    QueryText: encodeURI(strQuery),
                    CreatedBy: encodeURI(UserName),
                    Flag: encodeURI(Flag),
                    FilterID: encodeURI(FilterID)
                }
                StartLoader("#bodystakeholder");
                //Check fileter name duplicate 
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/IsDuplicateStakeholderBasicFilter',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(StakeholderFilterParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (StakeholderFilterParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(StakeholderFilterParameter) ? StakeholderFilterParameter : JSON.stringify(StakeholderFilterParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (!result) {
                            $.ajax({
                                url: encodeURI(strUrl) + '/api/PM_stakeholders/SaveStakeholderBasicFilter',
                                method: 'Post',
                                data: JSON.stringify(StakeholderFilterParameter),
                                dataType: 'json',
                                async: false,
                                contentType: "application/json",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    if (StakeholderFilterParameter) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(StakeholderFilterParameter) ? StakeholderFilterParameter : JSON.stringify(StakeholderFilterParameter)));
                                    }
                                },
                                success: function (result) {
                                    $("#Issuesavefilter").modal("hide");
                                    if (result != "") {
                                        GlobalApplyID = "Apply" + result;
                                        StakeholderGetMyFiltersList();
                                        StakeholderApplyCheckFilter(GlobalApplyID);
                                        showAlert("Filter applied Sucessfully", 'alert-success');
                                        $("#presetfilter").removeClass("active");
                                        $("#basicfilterli").hasClass("active"); {
                                            $("#basicfilterli").removeClass("active");
                                        }
                                    }
                                },
                                error: function (err) {
                                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                }
                            })
                        }
                        else {
                            showAlert('<%= MyBase.GetResourceString("C_Advance_Filter_Already_Exists") %>', 'alert-danger');
                            IsFilterNameExists = "1"
                            return;
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                    StopAjaxLoader("#bodystakeholder");
                    if (IsFilterNameExists == "0") {
                        clearBasicFilters();
                    }
                } else {
                    showAlert("Please enter filter name.", 'alert-danger');
                }
            }
        }

        //open basic filter tab
        function OpenBasicFilter() {
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
        }

        //Function for get the list of stakeholder filters on My filter dropdown
        function StakeholderGetMyFiltersList() {
            var projectID = ProjectID;
            //if (projectID == '0' || projectID == '') {
            //    projectID = -1;
            //}
        
            clearBasicFilters();
            var StakeholderFilterParameter = {
                TagID: encodeURI(2104),
                ProjectID: encodeURI(projectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/GetMyStakeholderFiltersList',
                method: 'Post',
                data: JSON.stringify(StakeholderFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (StakeholderFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(StakeholderFilterParameter) ? StakeholderFilterParameter : JSON.stringify(StakeholderFilterParameter)));
                    }
                },
                success: function (result) {
                    var strHTML = "";

                    $("#StakeholderMyFiltersdropdown").empty();
                    for (var i = 0; i < result.length; i++) {

                        strHTML += '<li id="li' + result[i].FilterId + '">'

                        if (result[i].SetDefault == true) {
                            strHTML += '<label class="customradio">'
                            strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + result[i].FilterId + '" type="checkbox" name="' + result[i].FilterId + '" onchange="StakeholderRemoveDefaultFilter(this.id)" checked="checked">'
                            strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Remove Default filter" class="checkmark"></span>'
                            strHTML += '</label>'
                            strHTML += '<label class="">'
                            strHTML += '<span for="project2" class="radiotextsty filtername">' + result[i].FilterName + '</span>'
                            strHTML += '</label>'
                            strHTML += '<div class="issfilter_actiondropdown">'
                            strHTML += '<div class="custom_chckbox_markblue">'
                            strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" checked="" type="radio" name="abc">'
                            strHTML += '<label data-bs-toggle="tooltip" data-original-title="Apply filter" data-bs-container="body" data-bs-placement="bottom" title="Default filter" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="StakeholderApplyCheckFilter(this.id)"></label>'
                            strHTML += '</div>'
                            strHTML += '<span onclick="OpenBasicFilter()"><i  data-original-title="Edit filter"  data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt edit_filter" id="' + result[i].FilterId + '" onclick="StakeholderEditMyFilter(this.id);"></i></span>'
                            strHTML += '<span><i data-bs-toggle="tooltip" data-original-title="Delete filter" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="Default' + result[i].FilterId + '" onclick="StakeholderDeleteMyFilter(this.id)"></i></span>'
                            strHTML += '</div>'
                            strHTML += '</li>'
                        }
                        else {
                            strHTML += '<label class="customradio">'
                            strHTML += '<input class="myfilter_selectprocheckbox" data-original-title="Set Default filter" data-bs-toggle="tooltip" data-bs-placement="bottom" id="' + result[i].FilterId + '" type="radio" name="project2" onchange="StakeholderSetDefaultFilter(this.id)">'
                            strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>'
                            strHTML += '</label>'
                            strHTML += '<label class="">'
                            strHTML += '<span for="project2" class="radiotextsty filtername">' + result[i].FilterName + '</span>'
                            strHTML += '</label>'
                            strHTML += '<div class="issfilter_actiondropdown">'
                            strHTML += '<div class="custom_chckbox_markblue">'
                            strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" type="radio" name="">'
                            strHTML += '<label data-bs-toggle="tooltip" data-original-title="Apply filter" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="StakeholderApplyCheckFilter(this.id)"></label>'
                            strHTML += '</div>'
                            strHTML += '<span onclick="OpenBasicFilter()"><i data-bs-toggle="tooltip" data-original-title="Edit filter" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt edit_filter" id="' + result[i].FilterId + '" onclick="StakeholderEditMyFilter(this.id);"></i></span>'
                            strHTML += '<span><i data-bs-toggle="tooltip" data-original-title="Delete filter" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="' + result[i].FilterId + '" onclick="StakeholderDeleteMyFilter(this.id)"></i></span>'
                            strHTML += '</div>'
                            strHTML += '</li>'
                        }
                    }
                    $("#StakeholderMyFiltersdropdown").append(strHTML);

                    if (GlobalApplyID != null) {
                        StakeholderApplyCheckFilter(GlobalApplyID);
                    }
                    else {
                        ClearFilterApplied(GlobalApplyID);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        //Delete Saved stakeholder filter
        function StakeholderDeleteMyFilter(FilterID) {
            $(".tooltip").tooltip("hide");
            if (FilterID.indexOf('Default') > -1) {
                var FilterID = FilterID.replace("Default", "");
                StakeholderDeleteFilter(FilterID);
                fillTableData(null);
                StakeholderGetMyFiltersList();
                $("#DivStakeholderFilter").removeClass("active");
                ClearBasicFilter(module);
            }
            else {
                StakeholderDeleteFilter(FilterID);
                StakeholderDefaultFilter();
                //StakeholderCheckDefaultFilter(2104);
                StakeholderGetMyFiltersList();
                ClearBasicFilter(module);
            }
        }


        //Delete Stakeholder Filter
        function StakeholderDeleteFilter(FilterID) {
            StartLoader("#bodystakeholder");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/DeleteStakeholderFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        showAlert("Filter is deleted successfully.", 'alert-success');
                        StakeholderGetMyFiltersList();
                    }
                }, error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodystakeholder")
        }


        //Apply saved stakeholder filter
        function StakeholderApplySavedFilter(FilterID) {
            StartLoader("#bodystakeholder");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/GetStakeholderWhereClauseOfFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    var Querytext = result;
                    var FilterID = result.FilterID;
                    var QueryText = result.QueryText;
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                    }
                    fillTableData(Querytext);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodystakeholder")
        }

        //To set the default filter of stakeholder.
        function StakeholderSetDefaultFilter(FilterID) {
            var StakeholderFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                TagID: encodeURI(2104),
                FilterID: encodeURI(FilterID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/SetStakeholderDefaultFilter',
                method: 'Post',
                data: JSON.stringify(StakeholderFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (StakeholderFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(StakeholderFilterParameter) ? StakeholderFilterParameter : JSON.stringify(StakeholderFilterParameter)));
                    }
                },
                success: function (result) {
                    //showAlert("Default filter is set.", 'alert-success');
                    // showAlert("Default filter is set.", 'alert-success');
                    showAlert("Default Filter Set Successfully", 'alert-success');
                    FilterID = "Apply" + FilterID;
                    StakeholderGetMyFiltersList();
                    StakeholderApplyCheckFilter(FilterID);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        //To remove the default filter of stakeholder.
        function StakeholderRemoveDefaultFilter(FilterID) {
            StartLoader("#bodystakeholder");
            FilterID = FilterID.replace("Default", "");
            var StakeholderFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                TagID: encodeURI(2104),
                FilterID: encodeURI(FilterID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/RemoveStakeholderDefaultFilter',
                method: 'Post',
                data: JSON.stringify(StakeholderFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (StakeholderFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(StakeholderFilterParameter) ? StakeholderFilterParameter : JSON.stringify(StakeholderFilterParameter)));
                    }
                },
                success: function (result) {
                    //showAlert("Default filter is removed.", 'alert-success');
                    showAlert("Default Filter Removed Successfully", "alert-success");
                    fillTableData(null);
                    StakeholderGetMyFiltersList();
                    $("#DivStakeholderFilter").removeClass("active");
                    ClearBasicFilter(module);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodystakeholder")
        }

        //CLEAR BASIC FILTERS
        function ClearBasicFilter(IdCaption) {
            $("[id*=cbo" + IdCaption + "Filter]").each(function (obj) {
                var cbo = this.id;
                $("#" + cbo + " option:first").prop('selected', 'selected');
            });

            $("[id*=txt" + IdCaption + "Filter]").each(function (obj) {
                var txt = this.id;
                $("#" + txt).val('').change();
            });
        }

        //bind basic filters
        function BindBasicFilters(qtext, module) {

            ClearBasicFilter(module);
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

        //bind basicfilter values
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
            $('#cbo' + module + 'Filter' + field).val(op).change();
            $('#txt' + module + 'Filter' + field).val(val).change();
        }


        //To Edit saved stakeholder filter
        function StakeholderEditMyFilter(FilterId) {

            Flag = 1;
            FilterID = FilterId;
            ClearBasicFilter(module);
            clearBasicFiltersforEdit();
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/EditStakeholderFilterData',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {

                    BindBasicFilters(result[0].WhereClause, module);
                    $("#txtFilterName").val(result[0].FilterName);
                    GlobalFilterName = result[0].FilterName;
                    $("#")
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        // Getting QueryText From Perticular FilterID
        function StakeholderApplyCheckFilter(ApplyID) {

            $("#" + ApplyID).attr("data-original-title");
            if ($("#" + ApplyID).attr("data-original-title") == "Applied filter" || $("#" + ApplyID).attr("data-original-title") == "Default filter") {
                return;
            }
            var FilterID = ApplyID.replace("Apply", "");
            if (FilterID != undefined) {
                StakeholderFilterParameter = {
                    FilterID: encodeURI(FilterID),
                }
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/GetWhereClauseFilter',
                    type: "POST",
                    data: JSON.stringify(StakeholderFilterParameter),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (StakeholderFilterParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(StakeholderFilterParameter) ? StakeholderFilterParameter : JSON.stringify(StakeholderFilterParameter)));
                        }
                    },
                    success: function (result) {
                        $(FilterID).attr("checked");

                        var QueryText = result;
                        if (QueryText != null) {
                            QueryText = QueryText.toString().replace(/'/g, "''");
                        }

                        var sibling = $('label[id^="Apply"]')
                        //if ($("#" + ApplyID).parent().find("input").prop("checked") == true) {

                        //    $("#" + ApplyID).parent().find("input").prop("checked", true);
                        //}
                        //else if ($("#" + ApplyID).parent().find("input").prop("checked") == false) {
                        $(sibling).each(function () {
                            var id = this.id;
                            if (ApplyID == this.id) {
                                $("#" + id).parent().find("input").prop("checked", true);
                                $("#" + id).attr("data-original-title", "Applied filter");
                            }
                            else {
                                $("#" + id).parent().find("input").prop("checked", false);
                                $("#" + id).attr("data-original-title", "Apply filter");
                            }
                        });
                        //}
                        fillTableData(QueryText);
                        $("#StakeholderClearAllFilter").show(); $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                        GlobalApplyID = "Apply" + FilterID;
                        $('#presetfilter').removeClass("active");
                        $('.filterpanel .cust_tabpanel li').removeClass("active");
                        $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
                        $("#DivStakeholderFilter").addClass("active");
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
        }

        //To clear the applied filter arrow after click on clear filter button
        function ClearFilterApplied(GlobalApplyID) {
            var sibling = $('label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($("#" + id).parent().find("input").prop("checked") == true) {
                    $("#" + id).parent().find("input").prop("checked", false);
                }
            });
        }
        ////End filter code

        //validate email id
        function validateEmailIDs(obj) {
            var hasError = false;
            var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

            if (obj == '') {
                return false;
            }

            else if (!emailReg.test(obj)) {
                return false;
            }
            return true;
        }

        function addressvalidation(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }
            var msg = (arguments.length > 1) ? arguments[1] : "";
            msg = replaceSubstring(msg, "&#39;", "'");
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            var spChars = (arguments.length > 3) ? arguments[3] : "[:*?+\"><|\\\\]";
            if (hasSpecialCharacters(getInputValue(obj), spChars)) {
                if (!isBlank(msg)) { alert(msg); }
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }

        function phonenovalidation(obj) {
            if (isBlank(getInputValue(obj))) { return false; } else {
                var spChars = "0123456789-";
                var objRegExp = /^[0-9-]*$/;
                if (objRegExp.test(getInputValue(obj))) { return false; } else {
                    return true;
                }
            }
            return false;
        }

        function zipcodevalidation(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }
            var msg = (arguments.length > 1) ? arguments[1] : "";
            msg = replaceSubstring(msg, "&#39;", "'");
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            var spChars = (arguments.length > 3) ? arguments[3] : "[/:*?+\"><|,\\\\]";
            if (hasSpecialCharacters(getInputValue(obj), spChars)) {
                if (!isBlank(msg)) { alert(msg); }
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }

        //validate stakeholder data
        function ValidateStakeHolder() {
            
            if (isBlank($("#SContactCategoryID :selected").val()) || $("#SContactCategoryID :selected").val() == '0') {
                showAlert('<%= MyBase.GetResourceString("C_Group_Mandatory") %>', 'alert-danger');
                return false;
            }
            else if (isBlank(Trim($("#SName").val())) && parseInt(($("#SNameOrganization :selected").val() == "") ? "0" : $("#SNameOrganization :selected").val(), 0) == 0) {
                var getContacttype = getContactCategory();
                if (getContacttype == 'O') {
                    showAlert('<%= MyBase.GetResourceString("C_Name_Mandatory_Selection") %>', 'alert-danger');
                } else {
                    showAlert('<%= MyBase.GetResourceString("C_Name_Mandatory_Text") %>', 'alert-danger');
                }
                return false;
            }
            else if (disallowSpecialCharacters(document.getElementById('SName'))) {
                showAlert('<%= MyBase.GetResourceString("C_Name_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
            //Added by Aditya J. on 18-11-2024
            else if (checkSpecialCharacter($("#SDesignation").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Designation should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#SDesignation").focus();
                return false;
            }
            else if (checkSpecialCharacter($("#SOrganizationName").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Organization Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#SOrganizationName").focus();
                return false;
            }
            //End of Added by Aditya J. on 18-11-2024
            else if (isBlank($("#STypeOfContactId :selected").val()) || $("#STypeOfContactId :selected").val() == '0') {
                showAlert('<%= MyBase.GetResourceString("C_Type_Mandatory") %>', 'alert-danger');
                return false;
            }
            else if (phonenovalidation(document.getElementById('Sphone1'))) {
                //Commented & Added By Rutuja D. on 16 Dec 2021 For repharse the alert IssueID = 31807
                //showAlert('<%= MyBase.GetResourceString("C_Phone1_Numeric") %>', 'alert-danger');
                showAlert("Please enter valid phone1 it will accept '-' (hyphen) and numeric values", 'alert-danger');
                //End Commented & Added By Rutuja D. on 16 Dec 2021 For repharse the alert IssueID = 31807
                return false;
            }
            <%--else if (disallowNegativeNumeric(document.getElementById('Sphone1'))) {
                showAlert('<%= MyBase.GetResourceString("C_Phone1_Numeric") %>', 'alert-danger');
                return false;
            }--%>
            else if (disallowSpecialCharacters(document.getElementById('SExt1'))) {
                showAlert('<%= MyBase.GetResourceString("C_ExtNo1_SpecialCharactorsNotAllowed") %>', 'alert-danger');
            }
            else if (disallowNegativeNumeric(document.getElementById('SExt1'))) {
                showAlert('<%= MyBase.GetResourceString("C_ExtNo1_Numeric") %>', 'alert-danger');
                return false;
            }
            else if (phonenovalidation(document.getElementById('Sphone2'))) {
                //Commented & Added By Rutuja D. on 16 Dec 2021 For repharse the alert IssueID = 31807
                //showAlert('<%= MyBase.GetResourceString("C_Phone2_Numeric") %>', 'alert-danger');
                showAlert("Please enter valid phone2 it will accept '-' (hyphen) and numeric values", 'alert-danger');
                //End Commented & Added By Rutuja D. on 16 Dec 2021 For repharse the alert IssueID = 31807
                return false;
            }
            <%--else if (disallowNegativeNumeric(document.getElementById('Sphone2'))) {
                showAlert('<%= MyBase.GetResourceString("C_Phone2_Numeric") %>', 'alert-danger');
                return false;
            }--%>
            else if (disallowSpecialCharacters(document.getElementById('SExt2'))) {
                showAlert('<%= MyBase.GetResourceString("C_ExtNo2_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
            else if (disallowNegativeNumeric(document.getElementById('SExt2'))) {
                showAlert('<%= MyBase.GetResourceString("C_ExtNo2_Numeric") %>', 'alert-danger');
                return false;
            }
            else if (disallowSpecialCharacters(document.getElementById('SMobile'))) {
                showAlert('<%= MyBase.GetResourceString("C_MobileNo_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
            else if (disallowNegativeNumeric(document.getElementById('SMobile'))) {
                showAlert('<%= MyBase.GetResourceString("C_MobileNo_Numeric") %>', 'alert-danger');
                return false;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter($("#Sfax").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Fax should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#Sfax").focus();
                return false;
            }
            //End of Added By Riddhesh Patil
            else if (!validateEmailIDs(Trim($("#SEmailID").val()))) {
                showAlert('<%= MyBase.GetResourceString("C_EmailID_Valid") %>', 'alert-danger');
                return false;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter($("#SURL").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('URL should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#SURL").focus();
                return false;
            }
            //End of Added By Riddhesh Patil
            else if (addressvalidation(document.getElementById('SAddress1'))) {
                showAlert('<%= MyBase.GetResourceString("C_Address1_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
            else if (addressvalidation(document.getElementById('SAddress2'))) {
                showAlert('<%= MyBase.GetResourceString("C_Address2_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
            else if (disallowSpecialCharacters(document.getElementById('SCity'))) {
                showAlert('<%= MyBase.GetResourceString("C_City_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
            else if (zipcodevalidation(document.getElementById('SZip'))) {
                showAlert('<%= MyBase.GetResourceString("C_ZIPPOstalCode_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter($("#SZip").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Zip/Postal Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#SZip").focus();
                return false;
            }
            //End of Added By Riddhesh Patil
            else if (!((Trim($("#SCity").val()).length > 0) ? isAlphabet($("#SCity").val()) : true)) {
                showAlert('<%= MyBase.GetResourceString("C_City_IsAlphabets") %>', 'alert-danger');
                return false;
            }
            else if (!((Trim($("#SState").val()).length > 0) ? isAlphabet($("#SState").val()) : true)) {
                showAlert('<%= MyBase.GetResourceString("C_State_IsAlphabets") %>', 'alert-danger');
                return false;
            }
            else if (disallowSpecialCharacters(document.getElementById('SNotes'))) {
                showAlert('<%= MyBase.GetResourceString("C_Notes_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                return false;
            }
                //Added By Riddhesh Patil on 12-NOV-2024
            else
                //End of Added By Riddhesh Patil on 12-NOV-2024
                //Added By Riddhesh Patil on 11-NOV-2022 
                if (checkSpecialCharacter($("#SNotes").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Notes should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#SNotes").focus();
                    return false;
                }
                //End of Added By Riddhesh Patil
                 //Added By Riddhesh Patil on 12-NOV-2024
                else {

            return true;
                }
             //End of Added By Riddhesh Patil on 12-NOV-2024
        }

        //Start Save StakeHolder details
        function SaveStakeHolder() {
            var flag = false;
            StartLoader("#bodystakeholder");
            if (ValidateStakeHolder()) {

                if ($("#SCountryID :selected").val() == "") {
                    var CountryID = 0;
                }
                else {
                    var CountryID = $("#SCountryID :selected").val();
                }

                if ($("#SClientID :selected").val() == "") {
                    var SClientID = 0;
                }
                else {
                    var SClientID = $("#SClientID :selected").val();
                }

                if ($("#STypeOfContactId :selected").val() == "") {
                    var STypeOfContactId = 0;
                }
                else {
                    var STypeOfContactId = $("#STypeOfContactId :selected").val();
                }


                var stakeholderparameter = {
                    ProjectContactID: $("#ProjectContactID").val(),
                    ContactCategoryID: $("#SContactCategoryID :selected").val(),
                    Name: Trim(replaceAllChar($("#SName").val())),
                    Designation: Trim(replaceAllChar($("#SDesignation").val())),
                    TypeOfContactID: STypeOfContactId,
                    ContactType: "S",
                    IsCorporateContact: $("#SPrincipleContact").is(':checked') == 1 ? 1 : 0,
                    SiteID: 0,
                    Address1: Trim(replaceAllChar($("#SAddress1").val())),
                    Address2: Trim(replaceAllChar($("#SAddress2").val())),
                    City: Trim(replaceAllChar($("#SCity").val())),
                    Zip: Trim(replaceAllChar($("#SZip").val())),
                    state: Trim(replaceAllChar($("#SState").val())),
                    CountryID: CountryID,
                    CorrespondenceAddress: $("#SCorrecpondenceAddress").is(':checked') == 1 ? 1 : 0,
                    Phone1: Trim(replaceAllChar($("#Sphone1").val())),
                    Phone2: Trim(replaceAllChar($("#Sphone2").val())),
                    Ext1: Trim(replaceAllChar($("#SExt1").val())),
                    Ext2: Trim(replaceAllChar($("#SExt2").val())),
                    Fax: Trim(replaceAllChar($("#Sfax").val())),
                    Mobile: Trim(replaceAllChar($("#SMobile").val())),
                    EmailID: Trim(replaceAllChar($("#SEmailID").val())),
                    URL: Trim(replaceAllChar($("#SURL").val())),
                    ActiveStatus: $("#SActive").is(':checked') == 1 ? 1 : 0,
                    ProjectID: $("#CboProject :selected").val(),
                    CreatedBy: '<%= Session("strUserName") %>',
                ModifiedBy: '<%= Session("strUserName") %>',
                EmployeeID: parseInt($("#SNameOrganization :selected").val() == "" ? "0" : parseInt($("#SNameOrganization :selected").val(), 0)),
                PrincipalContact: $("#SPrincipleContact").is(':checked') == 1 ? 1 : 0,
                OrganizationName: Trim(replaceAllChar($("#SOrganizationName").val())),
                Notes: Trim(replaceAllChar($("#SNotes").val())),
                ClientId: SClientID,

            }

            if (editProjectID != '0') {
                stakeholderparameter.ProjectID = editProjectID;
            }

            if (stakeholderparameter.EmployeeID != '' && stakeholderparameter.EmployeeID != '0')
                stakeholderparameter.Name = $("#SNameOrganization :selected").text();
            if (isPrincipleContact()) {

                flag = false;
                showAlert('<%= MyBase.GetResourceString("C_Stakeholder_IsPrincipleContactExist") %>', 'alert-danger');
            } else {
                //Check stakeholder duplicate name
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/IsDuplicateStakeholderName',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(stakeholderparameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (stakeholderparameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(stakeholderparameter) ? stakeholderparameter : JSON.stringify(stakeholderparameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (!result) {
                            $.ajax({
                                url: strUrl + '/api/PM_stakeholders/SaveStakeholderProjectContacts',// Path
                                type: "POST",                                       //HTTP TYPE get /post
                                data: JSON.stringify(stakeholderparameter),       // Parameters
                                dataType: "json",                                   //Retrun Type 
                                contentType: "application/json; charset=utf-8",     //
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    if (stakeholderparameter) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(stakeholderparameter) ? stakeholderparameter : JSON.stringify(stakeholderparameter)));
                                    }
                                },
                                async: false,
                                success: function (result) {
                                    if (parseInt(result) > 0) {
                                        fillTableData(ReportFilterQuery);
                                        //StakeholderDefaultFilter();
                                        if (stakeholderparameter.ProjectContactID != '0') {
                                            showAlert('<%= MyBase.GetResourceString("C_Update_successfully") %>', 'alert-success');
                                            flag = false;
                                        } else {
                                            showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                                            flag = true;
                                        }
                                    }
                                    else {
                                        showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
                                        flag = false;
                                    }
                                },
                                error: function (xhr, status, error) {
                                    var err = eval("(" + xhr.responseText + ")");
                                    if (xhr.responseText.includes("Violation of UNIQUE KEY constraint")) {
                                        showAlert('<%= MyBase.GetResourceString("C_Basic_Filter_Already_Exists") %>', 'alert-danger');
                                        document.getElementById('txtStageName').value = '';
                                    }
                                    flag = false;
                                }
                            });
                        }
                        else {
                            showAlert('<%= MyBase.GetResourceString("C_Name_NameIsAlreadyExist") %>', 'alert-danger');
                            flag = false;
                        }
                    },
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        if (xhr.responseText.includes("Violation of UNIQUE KEY constraint")) {
                            showAlert('<%= MyBase.GetResourceString("C_Basic_Filter_Already_Exists") %>', 'alert-danger');
                            document.getElementById('txtStageName').value = '';
                        }
                        flag = false;
                    }
                });
                }
            } else {
                flag = false;
            }
            StopAjaxLoader("#bodystakeholder")
            return flag;
        }

    //#endregion
    //****************************--------------------------
    </script>


    <%-- Created Date:   23 Oct 2019
     Purpose        :   
     Author         :   Vishal Mahajan--%>

    <script>
        $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open', function (e) {
            e.stopPropagation();
        });

        $('.replycomment a, .replilink').click(function () {
            $('.commentedtitor').hide();
            $('.commentedtitor').show();
        });

        //Added By Usha Pandit On 04.11.2019 for discussion panel   
        var currentUniqueID = 0;
        var currentDiscussionThreadId = 0;
        var currentDiscussionThreadLevel = '';
        var currentDiscussionThreadReplyIndex = 0;

        function showHidePanel(flag) {
            if (flag == "hide") {
                if (!$(".convAndatchmnt_panel").hasClass("clsShowHide")) {
                    $(".convAndatchmnt_panel").addClass("clsShowHide");
                }
            }
            if (flag == "show") {
                if ($(".convAndatchmnt_panel").hasClass("clsShowHide")) {
                    $(".convAndatchmnt_panel").removeClass("clsShowHide");
                }
            }
        }
        function collapseExpandPanel(flag) {
            var box = $("#panelDiscussion").parents(".box").first();
            var bf = box.find(".box-body, .box-footer");
            if (flag == "collapse") {
                box.addClass("collapsed-box");
                bf.slideUp();
            }
            if (flag == "expand") {
                box.removeClass("collapsed-box");
                bf.slideDown();
            }
        }
        function limitText(limitField, limitCount, limitNum) {

            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else {
                limitCount.innerHTML = (limitNum - limitField.value.length);

                if (limitCount.innerHTML != 0) {
                    IsFlagcountdownSummary = 0;
                    IsFlagcountdownFN = 0;
                    IsFlagcountdownAC = 0;
                    IsFlagSubus = 0;
                    IsFlag = 0;
                }
            }
        }
        function ShowLessMoreContent() {
            var showChar = 250;
            var ellipsestext = "...";
            var moretext = "More";
            var lesstext = "Less";
            $('.more').each(function () {
                var content = $(this).html();

                if (content.length > showChar) {

                    var c = content.substr(0, showChar);
                    //var h = content.substr(showChar - 1, content.length - showChar);
                    var h = content.substr(showChar, content.length - showChar);
                    var html = c + '<span class="moreellipses">' + ellipsestext + '</span><span class="morecontent" style="word-break: normal;"><span>' + h + '</span><a href="" class="morelink" >' + moretext + '</a></span>';

                    $(this).html(html);
                }
            });

            $(".morelink").click(function () {
                if ($(this).hasClass("less")) {
                    $(this).removeClass("less");
                    $(this).html(moretext);
                } else {
                    $(this).addClass("less");
                    // Commented By Rutuja D. on 30 March 220 Foe issueid = 23378
                    //  $(this).html("..." + lesstext);
                    $(this).html(lesstext);
                    //End Commented By Rutuja D. on 30 March 220 Foe issueid = 23378
                }
                $(this).parent().prev().toggle();
                $(this).prev().toggle();
                return false;
            });
        }
        function getShortName(fullName) {
            if (fullName != "") {
                var details1 = new Array();
                details1[0] = new Array(fullName.length);

                var names = fullName.toString().split(".");
                if (fullName.toString().indexOf(".") != -1) {
                    details1 = fullName.toString().split(".");
                }
                else if (fullName.toString().indexOf(",") != -1) {
                    details1 = fullName.toString().split(",");
                }
                else {
                    details1 = fullName.toString().split(" ");
                }

                var shortName = "";
                if (names.length > 0) {
                    if ((details1[0][0]) == undefined) {
                        shortName = (details1[details1.length - 1][0]).toString().toUpperCase();
                    }
                    else {
                        shortName = (details1[0][0]).toString().toUpperCase() + (details1[details1.length - 1][0]).toString().toUpperCase();
                    }
                }
                return shortName;
            }
            else
                return "";
        }
        function formatAMPM(curdate) {
            var hours = curdate.getHours();
            var minutes = curdate.getMinutes();
            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return strTime;
        }
        function getMonthDateYear(curdate) {
            var cursubmitDate = '';
            var month = curdate.getMonth() + 1;
            var date = curdate.getDate();
            var year = curdate.getFullYear();
            cursubmitDate = date + '/' + month + '/' + year;
            return cursubmitDate;
        }
        function setReplyDiscussion(DiscussionID, ThreadLevel, ReplyIndex) {
            currentDiscussionThreadId = DiscussionID;
            currentDiscussionThreadLevel = ThreadLevel;
            currentDiscussionThreadReplyIndex = ReplyIndex;
            $("#txtDiscussion").focus();
            //Added By Rutuja D. on 19 March 2020 For issueid = 23084
            //Commented & Added By Rutuja For Adding Space Before Replay Text
            // $("#btnSaveDiscussion").html('Reply');
            $("#btnSaveDiscussion").html(' Reply');
            //End Commented & Added By Rutuja For Adding Space Before Replay Text
            $("#btnSaveDiscussion").addClass('fa fa-reply')
            //End Added By Rutuja D. on 19 March 2020 For issueid = 23084
        }
        function saveDiscussion(UniqueDiscussionID) {
            var currentParentId = 0;
            var currentDiscussionLevel = "Level1";
            var currentReplyIndex = 0;
            var Conversation = $("#txtDiscussion").val(); //Added By Rehan C
            if (currentDiscussionThreadId != 0) {
                currentParentId = currentDiscussionThreadId;
                currentDiscussionLevel = currentDiscussionThreadLevel;
                currentReplyIndex = currentDiscussionThreadReplyIndex;
            }
            var currentDiscussion = $("#txtDiscussion").val();
            if (currentDiscussion == "") {
                alertify.set('notifier', 'position', 'top-right');
                <%--alert('<%= MyBase.GetResourceString("A_Comment") %>');--%>
            alertify.notify('<%= MyBase.GetResourceString("A_Comment") %>', 'error', 5);
                $("#txtDiscussion").focus();
                return;
            }
            //Added By Rehan C For SpecialChar Validation
            if (checkSpecialCharacter(Conversation, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Conversation should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                isValid = false;
                return false;
            }
            //End Of Comment By Rehan C
            PMDiscussionsParameter = {
                UniqueID: encodeURI(UniqueDiscussionID),
                ParentID: encodeURI(currentParentId),
                LoginID: encodeURI(UserID),
                DiscussionThread: encodeURI(currentDiscussion),
                SubmittedBy: encodeURI(UserName),
                LoginType: encodeURI(LoginType),
                IsShowToCustomer: 0,
                DiscussionLevel: currentDiscussionLevel,
                ReplyIndex: currentReplyIndex
            }
            $.ajax({
                url: strUrl + '/api/PM_Stakeholders/SaveDiscussion',
                method: 'Post',
                data: JSON.stringify(PMDiscussionsParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMDiscussionsParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMDiscussionsParameter) ? PMDiscussionsParameter : JSON.stringify(PMDiscussionsParameter)));
                    }
                },
                success: function (result) {
                    try {
                        getDiscussions(currentUniqueID);

                        if (currentDiscussionThreadId != 0) {
                            currentDiscussionThreadId = 0;
                        }
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        function getDiscussions(UniqueDiscussionID) {
            try {
                PMDiscussionsParameter = {
                    UniqueID: encodeURI(UniqueDiscussionID)
                }
                $.ajax({
                    url: strUrl + '/api/PM_Stakeholders/GetDiscussions',
                    method: 'Post',
                    data: JSON.stringify(PMDiscussionsParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMDiscussionsParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMDiscussionsParameter) ? PMDiscussionsParameter : JSON.stringify(PMDiscussionsParameter)));
                        }
                    },
                    success: function (result) {
                        try {
                            var ParentDiscussionsHTML = "";
                            var ReplyDiscussionsHTML = "";
                            var EditDiscussionsHTML = "";
                            var resultParent = [];
                            var cntChild = 0;

                            var arrLevel2ParentDiscussionId = [];
                            var arrLevel2ParentReplyCount = [];

                            var cntLevel2Parent = 0;
                            var blnLevel2Parent = false;

                            if (result.length > 0) {

                                for (var i = 0; i < result.length; i++) {
                                    var replyBody = "ReplyBody_" + result[i].DiscussionID;

                                    if (result[i].ParentID == 0) {
                                        resultParent[i] = result[i];

                                        var ObjMilestoneDiscussionsDtls = result[i];
                                        ParentDiscussionsHTML += "<div class='box-comment'>"; // div1

                                        var currentDiscussionId = ObjMilestoneDiscussionsDtls.DiscussionID;
                                        var FullName = ObjMilestoneDiscussionsDtls.SubmittedBy;
                                        var ShortName = getShortName(FullName);
                                        var ThreadReplyCount = ObjMilestoneDiscussionsDtls.ReplyCount;
                                        var ReplyIndex = ThreadReplyCount + 1;
                                        var currentdt = new Date();
                                        var submitdt = new Date(ObjMilestoneDiscussionsDtls.SubmittedDate);
                                        var submitTime = '';

                                        submitTime = formatAMPM(submitdt);
                                        submitDate = getMonthDateYear(submitdt);

                                        var currentdt = currentdt.setHours(0, 0, 0, 0);
                                        var submitdt = submitdt.setHours(0, 0, 0, 0);

                                        var blnSubmitToday = false;
                                        if (currentdt == submitdt) {
                                            blnSubmitToday = true;
                                        }

                                        ParentDiscussionsHTML += "<span class='usernameshort circle-bggreen float-start'>" + ShortName + "</span>";
                                        ParentDiscussionsHTML += "<div class='comment-text'>"; // div2
                                        ParentDiscussionsHTML += "<span class='username'>" + FullName;
                                        if (blnSubmitToday == true) {
                                            ParentDiscussionsHTML += "<span class='text-muted'>" + submitTime + " Today</span>";
                                        }
                                        else {
                                            ParentDiscussionsHTML += "<span class='text-muted'>" + submitTime + " On " + submitDate + "</span>";
                                        }
                                        ParentDiscussionsHTML += "</span>";

                                        ParentDiscussionsHTML += "<p style='word-break: break-word !important;' class='more'>" + ObjMilestoneDiscussionsDtls.DiscussionThread + "</p>";

                                        ParentDiscussionsHTML += "<div class='clearfix'></div>";

                                        ParentDiscussionsHTML += "<div class='replycomment'>"; // div3

                                        ParentDiscussionsHTML += "<span class='float-start'><a href='javascript:;' onclick='setReplyDiscussion(" + currentDiscussionId + ", &quot;Level2&quot;," + ReplyIndex + ")'>Reply <i class='fas fa-reply'></i></a></span>";

                                        ParentDiscussionsHTML += "<span class='float-start replycount'><a href='javascript:;'>" + ThreadReplyCount + " Replies </a></span>";

                                        ParentDiscussionsHTML += "<div class='clearfix'>";
                                        ParentDiscussionsHTML += "</div> ";

                                        for (var cntRecChild = 0; cntRecChild < ThreadReplyCount; cntRecChild++) {
                                            var indexChild = cntRecChild + 1;
                                            ParentDiscussionsHTML += " ReplyBody_" + currentDiscussionId + "_" + indexChild;
                                        }

                                        ParentDiscussionsHTML += "</div>"; // div3 end
                                        ParentDiscussionsHTML += "</div>"; // div2 end
                                        ParentDiscussionsHTML += "</div>"; // div1 end                                        
                                    } //result[i].ParentID==0 End If

                                    if (result[i].ParentID != 0) {
                                        var resultChild = result[i];

                                        if (resultChild.ReplyCount != 0) {
                                            arrLevel2ParentDiscussionId[cntLevel2Parent] = resultChild.DiscussionID;
                                            arrLevel2ParentReplyCount[cntLevel2Parent] = resultChild.ReplyCount;

                                            cntLevel2Parent = cntLevel2Parent + 1;

                                            blnLevel2Parent = true;
                                        }

                                        if (resultChild.DiscussionLevel == "Level2") {
                                            cntChild = cntChild + 1;
                                        }

                                        try {
                                            for (var recParents = 0; recParents < resultParent.length; recParents++) {
                                                var curParentDiscussionId = resultParent[recParents].DiscussionID;

                                                replyBody = "ReplyBody_" + curParentDiscussionId + "_" + cntChild;

                                                if (curParentDiscussionId == resultChild.ParentID && resultParent[recParents].ReplyCount != 0) {

                                                    var FullName = resultChild.SubmittedBy;
                                                    var ShortName = getShortName(FullName);

                                                    var ChildThreadReplyCount = resultChild.ReplyCount;
                                                    var ReplyIndex = ChildThreadReplyCount + 1;
                                                    var currentdt = new Date();
                                                    var submitdt = new Date(resultChild.SubmittedDate);
                                                    var submitTime = '';

                                                    submitTime = formatAMPM(submitdt);
                                                    submitDate = getMonthDateYear(submitdt);

                                                    var currentdt = currentdt.setHours(0, 0, 0, 0);
                                                    var submitdt = submitdt.setHours(0, 0, 0, 0);

                                                    var blnSubmitToday = false;
                                                    if (currentdt == submitdt) {
                                                        blnSubmitToday = true;
                                                    }

                                                    ReplyDiscussionsHTML = "";
                                                    ReplyDiscussionsHTML += "<div class='box-comment subbox_comment'>"; //div 1 for reply
                                                    ReplyDiscussionsHTML += "<span class='usernameshort circle-bgblue float-start'>" + ShortName + "</span>";
                                                    ReplyDiscussionsHTML += "<div class='comment-text'>"; //div 2 for comment-text
                                                    ReplyDiscussionsHTML += "<span class='username'>" + FullName;
                                                    if (blnSubmitToday == true) {
                                                        ReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " Today " + "<b style='color:#1359a6'>" + ChildThreadReplyCount + " Replies</b>";
                                                    }
                                                    else {
                                                        ReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " On " + submitDate + " <b style='color:#1359a6'>" + ChildThreadReplyCount + " Replies</b>";
                                                    }
                                                    ReplyDiscussionsHTML += "<a href='javascript:;' onclick='setReplyDiscussion(" + resultChild.DiscussionID + ",&quot;Level3&quot;," + ReplyIndex + ")' class='ml-1 replilink'>Reply <i class='fas fa-reply'></i></a>";

                                                    ReplyDiscussionsHTML += "</span>";

                                                    ReplyDiscussionsHTML += "</span>";

                                                    ReplyDiscussionsHTML += "<p style='word-break: break-word !important;' class='more'>" + resultChild.DiscussionThread + "</p>";
                                                    ReplyDiscussionsHTML += "<div class='clearfix'></div>";
                                                    ReplyDiscussionsHTML += "</div>";//div 2 end for comment-text

                                                    if (blnLevel2Parent == true) {
                                                        for (var cntRecChildLevel2 = 0; cntRecChildLevel2 < ChildThreadReplyCount; cntRecChildLevel2++) {
                                                            var indexChildLevel2 = cntRecChildLevel2 + 1;
                                                            ReplyDiscussionsHTML += " ReplyBody_" + resultChild.DiscussionID + "_" + indexChildLevel2;
                                                        }
                                                    }

                                                    ReplyDiscussionsHTML += "</div>"; //div 1 end for reply

                                                    ParentDiscussionsHTML = ParentDiscussionsHTML.replace(replyBody, ReplyDiscussionsHTML);
                                                    $("#stakeholderDiscussions").html(ParentDiscussionsHTML);
                                                    if (cntChild == resultParent[recParents].ReplyCount) {
                                                        cntChild = 0;
                                                    }
                                                }


                                                if (arrLevel2ParentDiscussionId.length != 0) {
                                                    for (var recLevel2Parent = 0; recLevel2Parent < arrLevel2ParentDiscussionId.length; recLevel2Parent++) {
                                                        if (resultChild.ParentID == arrLevel2ParentDiscussionId[recLevel2Parent] && resultParent[recParents].ReplyCount != 0) {
                                                            replyBody = "ReplyBody_" + arrLevel2ParentDiscussionId[recLevel2Parent] + "_" + resultChild.ReplyIndex;

                                                            var Reply2ReplyDiscussionsHTML = "";
                                                            var FullName = resultChild.SubmittedBy;
                                                            var ShortName = getShortName(FullName);

                                                            var ChildThreadReplyCount = resultChild.ReplyCount;
                                                            var currentdt = new Date();
                                                            var submitdt = new Date(resultChild.SubmittedDate);
                                                            var submitTime = '';

                                                            submitTime = formatAMPM(submitdt);
                                                            submitDate = getMonthDateYear(submitdt);

                                                            var currentdt = currentdt.setHours(0, 0, 0, 0);
                                                            var submitdt = submitdt.setHours(0, 0, 0, 0);

                                                            var blnSubmitToday = false;
                                                            if (currentdt == submitdt) {
                                                                blnSubmitToday = true;
                                                            }

                                                            Reply2ReplyDiscussionsHTML = "";
                                                            Reply2ReplyDiscussionsHTML += "<div class='box-comment subbox_comment'>"; //div 1 for reply
                                                            Reply2ReplyDiscussionsHTML += "<span class='usernameshort circle-bgblue float-start'>" + ShortName + "</span>";
                                                            Reply2ReplyDiscussionsHTML += "<div class='comment-text'>"; //div 2 for comment-text
                                                            Reply2ReplyDiscussionsHTML += "<span class='username'>" + FullName;
                                                            if (blnSubmitToday == true) {
                                                                Reply2ReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " Today ";
                                                            }
                                                            else {
                                                                Reply2ReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " On " + submitDate + " ";
                                                            }

                                                            Reply2ReplyDiscussionsHTML += "</span>";
                                                            Reply2ReplyDiscussionsHTML += "</span>";
                                                            Reply2ReplyDiscussionsHTML += "<p style='word-break: break-word !important;' class='more'>" + resultChild.DiscussionThread + "</p>";
                                                            Reply2ReplyDiscussionsHTML += "<div class='clearfix'></div>";
                                                            Reply2ReplyDiscussionsHTML += "</div>";//div 2 end for comment-text
                                                            Reply2ReplyDiscussionsHTML += "</div>"; //div 1 end for reply
                                                            ParentDiscussionsHTML = ParentDiscussionsHTML.replace(replyBody, Reply2ReplyDiscussionsHTML);
                                                            $("#stakeholderDiscussions").html(ParentDiscussionsHTML);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        catch (ex) {
                                            //alert(ex.message);
                                        }
                                    }//result[i].ParentID!=0 End If

                                    if (result[i].ReplyCount == 0) {
                                        $("#stakeholderDiscussions").html(ParentDiscussionsHTML);
                                    }
                                }
                            }
                            else {
                                $("#stakeholderDiscussions").html(ParentDiscussionsHTML);
                            }

                            EditDiscussionsHTML += '<div class="row">';

                            var ShortName = getShortName(UserName);
                            EditDiscussionsHTML += '<div class="col-sm-1"><span class="usernameshort circle-bggreen">' + ShortName + '</span></div>';

                            EditDiscussionsHTML += '<div class="col-sm-11">';
                            EditDiscussionsHTML += '<div class="box-body pad">';
                            EditDiscussionsHTML += '<%=CommonFunctions.HTMLControls.DrawTextArea("txtDiscussion", "txtDiscussion", , "form-control", , "form-control", "", , , , 2000,,,,,,,, "placeholder = 'Please Enter Your Comment Here' onkeyup='limitText(this,10,1000)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                        EditDiscussionsHTML += '</div>';
                        EditDiscussionsHTML += '</div>';
                        EditDiscussionsHTML += '<div class="clearfix"></div>';
                        EditDiscussionsHTML += '</div>';
                        EditDiscussionsHTML += '<button type="submit" id="btnSaveDiscussion" onclick="saveDiscussion(' + UniqueDiscussionID + ')" name="say" value="" class="btn comentbtn btnyellow float-end"><i class="fa fa-reply"></i> Comment </button>';
                        EditDiscussionsHTML += '<div class="clearfix"></div>';

                        $("#stakeholderEditDiscussion").html(EditDiscussionsHTML);
                    }
                    catch (ex) {
                        alert(ex.message);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
                ShowLessMoreContent();
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        $.fn.scrollGuard = function () {
            return this
                .on('mousewheel', function (e) {
                    var event = e.originalEvent;
                    var d = event.wheelDelta || -event.detail;
                    this.scrollTop += (d < 0 ? 1 : -1) * 30;
                    e.preventDefault();
                });
        };

        $(function () {
            $('.slim-scroll').scrollGuard();
        });

        //End Of Added By Usha Pandit On 04.11.2019 for discussion panel   



        //add attachment end here
        $(document).on('click', '.browse', function () {
            var file = $(this).parent().parent().parent().find('.file');
            file.trigger('click');
        });
        $(document).on('change', '.file', function () {
            $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        });



        $(function () {

            //bootstrap WYSIHTML5 - text editor
            $('.textarea').wysihtml5();
        });


        //dtatable
        table.DataTable({
            "pageLength": 5,
            // "scrollY": 400,
            // "scrollX": true,
            "lengthChange": false,
            "bFilter": true,
            "dom": 'lrtip',
            "ordering": false,
            "responsive": true,
            "bDestroy": true
        });

        //disable stakeholder details controls controls
        function DisableStakeHolderDetails() {
            $('#stackDetail').find(':input').each(function () {
                switch (this.type) {
                    case 'text': $(this).attr("disabled", true); break;
                    case 'checkbox': $(this).attr("disabled", true); break;
                    case 'select-one': $(this).attr("disabled", true); break;
                    case 'textarea': $(this).attr("disabled", true); break;
                }
            });
            $("#STypeOfContactId").removeClass("bgwhite");
            $("#SContactCategoryID").attr("disabled", false);
        }

        //enable stakeholder details controls
        function EnableStakeHolderDetails() {
            $('#stackDetail').find(':input').each(function () {
                switch (this.type) {
                    case 'text': $(this).attr("disabled", false); break;
                    case 'checkbox': $(this).attr("disabled", false); break;
                    case 'select-one': $(this).attr("disabled", false); break;
                    case 'textarea': $(this).attr("disabled", false); break;
                }
            });
            $("#SContactCategoryID").attr("disabled", false);
        }

        //Added By Riddhesh Patil on 11-NOV-2022 
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

        //check project is selected or not
        function CheckProjectIsSelect() {
            if ($("#CboProject :selected").val() == "" || $("#CboProject :selected").val() == "" || $("#CboProject :selected").val() == "0") {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
                return false;
            }
            else {
                return true;
            }
        }

        $(".statustext").on("click", "li", function () {

            $("#StakeholderClearAllFilter").show(); $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
        });

        //Add stakeholder
        $("#addstakeholdr").click(function () {
          
            showHidePanel("hide");
            $("#btnStakeholderDetailsSave")[0].innerText = '<%= MyBase.GetResourceString("C_Save") %>';
        editProjectID = '0';
        if (CheckProjectIsSelect()) {
            DisableStakeHolderDetails();
            $(".detailsubtabs>li.active").removeClass("active");
            $("#tabDetails").addClass("active");
            $("#stackDetail").addClass("active");
            $("#stackRisk").removeClass("active"); r
            $("#StackReqReport").removeClass("active");
            $("#allAttachments").removeClass("active");
            $("#SNameOrganization").empty();
            $("#SContactCategoryID").attr("disabled", false);
            fillOrganization(0);
            $("#tabRisk").hide();
            $("#tabReport").hide();
            $("#tabAttachments").hide();
            $("#divCustmer").hide();
            $("#divNameforOrganization").hide();
            $("#divOrganization").hide();
            $("#divName").show();
            $("#divClient").show();
            ClearStakeholderDetails();
            $("#SActive").attr('checked', true);
            $("#stakedetailpanel").show('fast');
            $('html, body').animate({
                scrollTop: $("#stakedetailpanel").offset().top -= 50
            }, 500);
            $("#SActive").attr('checked', true);
            $("#SContactCategoryID").focus();
            enableDisabledControlsForEdit(false);
        }
    });

        //Edit stakeholder
        $(".editstakebtn").click(function () {
            $(".Stakeholdertbl").find("tr").removeClass("tropen");
            $(this).closest("tr").addClass("tropen");
            $("#stakedetailpanel").show('fast');
            $('html, body').animate({
                scrollTop: $("#stakedetailpanel").offset().top -= 50
            }, 500);
        });

        //[For Edit Action] above method is not working when jquery datatable load data on dropdown change event that time dom is not loadead
        $("#tbl").on("click", ".editstakebtn", function () {
            $("#tabRisk").show();
            $("#tabReport").show();
            $("#tabAttachments").show();
            $(".Stakeholdertbl").find("tr").removeClass("tropen");
            $(this).closest("tr").addClass("tropen");
            $("#stakedetailpanel").show('fast');
            $('html, body').animate({
                scrollTop: $("#stakedetailpanel").offset().top -= 50
            }, 500);
        });


        //Cancle stakeholder detail panel
        $(".canclebtn").click(function () {
            enableDisabledControlsForEdit(true);
            isCustomerGroupAvailable();
            //Added By Usha Pandit On 04.11.2019 for discussion panel   
            showHidePanel("hide");
            //End Of Added By Usha Pandit On 04.11.2019 for discussion panel
            $(".Stakeholdertbl").find("tr").removeClass("tropen");
            $("#stakedetailpanel .detailsubtabs li:nth-child(2) a, #stakedetailpanel .detailsubtabs li:nth-child(3n) a").css("cursor", "pointer");
            $("#stakedetailpanel").hide('fast');
            $("#hidestaklist").show('fast');
            //Added by Riddhesh Patil for tab Navigation Issue on 12 April 2023
            $(".nav-link").removeClass('active');
            $("#tabDetails").addClass('active');
            $("#stackDetail").addClass('active');
            //End of Added by Riddhesh Patil for tab Navigation Issue on 12 April 2023
        });
        $(".savebtn").click(function () {

            if (CheckProjectIsSelect()) {
                if (SaveStakeHolder()) {
                    enableDisabledControlsForEdit(true);
                    isCustomerGroupAvailable();
                    $(".Stakeholdertbl").find("tr").removeClass("tropen");
                    $("#stakedetailpanel .detailsubtabs li:nth-child(2) a, #stakedetailpanel .detailsubtabs li:nth-child(3n) a").css("cursor", "pointer");
                    $("#stakedetailpanel").hide('fast');
                    $("#hidestaklist").show('fast');
                }
            }
        });

        var counter = 0;
        var resultSelectFields = "";
        var resultOperators = "";
        var resultCheckboxValues = "";
        
        $(document).on('click', '.dropdown-menu', function (e) {
            e.stopPropagation();
        });
        
        $(document).ready(function () {
         
            // $('.dropdown-menu').on('click', function(e) {
            //     // alert(111)
            //     $(this).addClass('show')
            //     // $('.dropdown-content').show();
            //     // e.stopPropagation();
            //     // $("#nameFilterSearch").addClass('show');
            // }); 
            
            // $('.dropdown-menu #stakeCategoriesSearchname').on('click', function(e) {
            $('#nameFilterSearch').on('click', function(e) {
            // $('.dropdown-menu').on('click', function(e) {
                e.stopPropagation();
            }); 

          
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
               // $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            $('select[name=txtPMFilterContactCategoryID] > option:first-child').text('Select Group');
            $('select[name=txtPMFilterTypeOfContactID] > option:first-child').text('Select Type');
            $('select[name=txtPMFilterPrincipalContact] > option:first-child').text('Select Principle Contact');
            $('select[name=txtPMFilterActiveStatus] > option:first-child').text('Select Active');
            $('select[name=txtPMFilterCountryID] > option:first-child').text('Select Country');
            $("#txtPMFilterCountryID option[value='0']").remove(); // Added By Rutuja D. For Select Country display two times
            $('select[name=txtPMFilterCorrespondenceAddress] > option:first-child').text('Select Correspondence Address');
            $('select[name=txtPMFilterClientId] > option:first-child').text('Select Client');


            $.each($("#CboProjectView option"), function (index, option) {
                $(this).removeAttr("title");
            });





            setAutoCompleteDisable();
            $("#SNotes").attr("maxlength", 1000);

            //Added By Usha Pandit On 04.11.2019 for discussion panel   
            showHidePanel("hide");
            $('.slim-scroll').slimScroll({
                //your options
                opacity: 0
            }).mouseover(function () {
                $(this).next('.slimScrollBar').css('opacity', 0.4);
            });
            //End Of Added By Usha Pandit On 04.11.2019 for discussion panel 
            /*     
             * Add collapse and remove events to boxes
             */
            $("[data-widget='collapse']").click(function () {
                //Find the box parent        
                var box = $(this).parents(".box").first();
                //Find the body and the footer
                var bf = box.find(".box-body, .box-footer");
                if (!box.hasClass("collapsed-box")) {
                    box.addClass("collapsed-box");
                    bf.slideUp();
                } else {
                    box.removeClass("collapsed-box");
                    bf.slideDown();
                    //Added By Usha Pandit On 04.11.2019 for discussion panel   
                    getDiscussions(currentUniqueID);
                    //End Of Added By Usha Pandit On 04.11.2019 for discussion panel
                }
            });


            //Added by imran on 16-12-2021 to check file uploaded or not validation
            function CheckAttachmentExitsOrNot() {
                var flag = false;
                var message = '';
                $('#atchmentTable>#tbodyatchmentTable > tr.attachments').each(function (index, value) {
                    isAnyAttachement = true;
                    var allColumns = $(this).find('td');
                    $(allColumns).each(function (i, v) {
                        if (i == 0) {
                            var curFileIndex = 0;
                            var id = $(this).find('*[id*=Afilname]').attr("id");
                            curFileIndex = id.replace(/Afilname/g, "");
                            var id = $('#tbodyatchmentTable > tr.attachments > td:nth-child(1)>#Afilname' + (curFileIndex));
                            var gerfileName = id[0].files[0];

                            if (gerfileName == undefined) {
                                if (message == '') {
                                    flag = true;

                                }
                            }
                        }
                    });
                });
                return flag;
            }
            //End by imran on 16-12-2021

            //add attachment   
            $("#addattachnebtrow").on("click", function () {
                try {
                    var cntDoc = 0;

                    $("table.order_attchmentlist tbody tr").each(function () {
                        cntDoc = cntDoc + 1;
                    });

                    if (cntDoc >= 1) {
                        //Added by imran on 16-12-2021 to check file uploaded or not
                        var IsFileExist = CheckAttachmentExitsOrNot();
                        if (IsFileExist == true) {
                            showAlert("<%= MyBase.GetResourceString("C_Attachment_PleaseSelectFile") %>", 'alert-danger');
                        return false;
                    }
                    //End by imran on 16-12-2021
                }

                if (cntDoc == 0) {
                    counter = 0;
                    i = 1;
                    j = 1;
                    k = 1;
                    l = 1;
                }
                $(".RiskDocumentTbl").dataTable().fnDestroy();
                $(".delattachbtn").prop('disabled', true);
                $(".delattachbtn").css("cursor", "not-allowed");
                $("#btnAttachment").prop('disabled', false);

                var newRow = $("<tr class='attachments'>");
                var cols = "";

                cols += '<td><input  id="Afilname' + j + '" type="file" name="img[]" class="file" onchange="ValidateAttachments(this)"><div class="input-group col-xs-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button"><i class="fas fa-paperclip"></i></button></span><input type="text"  id="FileName' + j + '" class="form-control" disabled="" placeholder="<%= MyBase.GetResourceString("C_Upload_Image") %>"></td>'
                //commented and added by Chetan M on 22 Dec 2020 for wrong textarea value
                //cols += '<td ><textarea id="Adescription' + i + '" class="form-control" maxlength="500" name="name' + counterFORattachment + '"/><textarea</td>';
                cols += '<td ><textarea id="Adescription' + i + '" class="form-control" maxlength="500" name="name' + counterFORattachment + '"/></textarea></td>';
                //End of commented and added by Chetan M on 22 Dec 2020 for wrong textarea value
                cols += '<td></td>';
                cols += '<td></td>';
                cols += '<td></td>';
                cols += '<td></td>';
                cols += '<td style="text-align: center"><button class="ibtnDel nostylebtn" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="Cancel"><i class="fa fa-times" value="Delete"></i></button></td> </tr>';

                newRow.append(cols);
                $("table.order_attchmentlist").append(newRow);
                $(".ibtnDel").tooltip({
                    placement: 'top'
                });
                i++;
                j++;
                k++;
            }
            catch (ex) {
            }

        });

        $("table.order_attchmentlist").on("click", ".ibtnDel", function (event) {
            $(this).closest("tr").remove();
            counterFORattachment -= 1
            if ($(".attachments").find(".ibtnDel").length == 0) {
                $(".delattachbtn").prop('disabled', false);
                $(".delattachbtn").css("cursor", "pointer");
                $("#btnAttachment").prop('disabled', true);
            }
        });

        //start bootstrap datepicker css  
        $('#mnthfield1').datepicker({
            autoclose: true,
        });



            $(".stakeCategoriesSearch").on("keyup", function () {
                //debugger;
            var value = $(this).val().toLowerCase();
            $(".stakeCategoriesSearchlist li").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1 || $(this).text().toLowerCase().indexOf("select all") > -1)
            });

            $(".stakeCategoriesSearchlist li").filter(function () {
                if ($(this).text().toLowerCase().indexOf(value) > -1 || $(this).text().toLowerCase().indexOf("select all") > -1) {
                    $(this)[0].style.display = "";
                }
                else {
                    $(this)[0].style.display = "none";
                }
            });
        });

        //Added script for search list in table header filter
        //Tooltip
        $('[data-bs-toggle="tooltip"]').click(function () {
            $('[data-bs-toggle="tooltip"]').tooltip("hide");

        });

        function loadAdvanceFilterControlData() {

            var basicfilterparameter =
            {
                TagID: 2104 //OLD TAG ID because masters are blank for new TAGID
            }

            if (resultSelectFields == "") {
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/GetAdvanceFilterSelectFields',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(basicfilterparameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (basicfilterparameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(basicfilterparameter) ? basicfilterparameter : JSON.stringify(basicfilterparameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        resultSelectFields = result;
                        $.ajax({
                            url: strUrl + '/api/PM_stakeholders/GetAdvanceFilterOperators',// Path
                            type: "POST",                                       //HTTP TYPE get /post
                            data: JSON.stringify(basicfilterparameter),       // Parameters
                            dataType: "json",                                   //Retrun Type 
                            contentType: "application/json; charset=utf-8",     //
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (basicfilterparameter) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(basicfilterparameter) ? basicfilterparameter : JSON.stringify(basicfilterparameter)));
                                }
                            },
                            async: false,
                            success: function (result) {
                                resultOperators = result;
                                $.ajax({
                                    url: strUrl + '/api/PM_stakeholders/GetAdvanceFilterCheckboxValues',// Path
                                    type: "POST",                                       //HTTP TYPE get /post
                                    data: JSON.stringify(basicfilterparameter),       // Parameters
                                    dataType: "json",                                   //Retrun Type 
                                    contentType: "application/json; charset=utf-8",     //
                                    beforeSend: function (xhr) {
                                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                        if (basicfilterparameter) {
                                            xhr.setRequestHeader("Params", encryptString(isJson(basicfilterparameter) ? basicfilterparameter : JSON.stringify(basicfilterparameter)));
                                        }
                                    },
                                    async: false,
                                    success: function (result) {
                                        resultCheckboxValues = result;
                                        calladdrow();
                                    },
                                    error: function (err) {
                                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                    }
                                });
                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            else {
                calladdrow();
            }
        }

        function calladdrow() {

            counter = $("#advCounter").val();
            $('[data-bs-toggle="tooltip"]').tooltip();
            var newRow = $("<ul class='addrowsmore' id='addrowsmore" + counter + "'>");
            var cols = "";
            if (counter != 0) {
                cols += '<li class="andorswitch" "name' + counter + '"><div class="btn-group" id="status" data-bs-toggle="buttons"><label class="btn btn-default btn-on btn-sm active"  ><input type="radio" value="AND" name="andor' + counter + '" checked="checked" id="and' + counter + '">AND</label><label class="btn btn-default btn-off btn-sm "><input type="radio" value="OR" name="andor' + counter + '"  id="or' + counter + '">OR</label></div></li>';
            }
            var issuefilter = '<option value="">Select Field</option>';
            $.each(resultSelectFields, function () {
                issuefilter += '<option value="' + this['ControlName'] + '">' + this['ControlCaption'] + '</option>';
            });
            var issuefilternumericoption = '<option value="">Select Field</option>';
            $.each(resultOperators, function () {
                issuefilternumericoption += '<option value="' + this['value'] + '">' + this['value'] + '</option>';
            });
            var advncfiltertextfieldvalue = '<select id="issuefilterValue_' + counter + '" class="form-select advncfiltercmdfieldvalue" name="name' + counter + '" style="display: none;"> <option value="">Select Field</option>';
            $.each(resultCheckboxValues, function () {
                advncfiltertextfieldvalue += '<option value="' + this['ActVal'] + '">' + this['ChkVal'] + '</option>';
            });
            advncfiltertextfieldvalue += "</select>";
            if (counter == 0) {
                $('button#addrow').prop('disabled', true).css({
                    'opacity': '0.5'
                });

                cols += '<li class="addrows_firstname"><label class="col-sm-4 control-label">Filter Name</label><div class="col-sm-8"><input type="text" class="form-control" id="AdvfilterName" value=""><div class="clearfix"></div><br/></div> </li>';
                cols += '<li style="width:120px"></li>';
                cols += '<li class=""><select id="issuefilter_' + counter + '" class="form-select issuefilter" name="name' + counter + '">' + issuefilter + '</select></li>';
                cols += '<li class=""><select id="issuefilternumericoption_' + counter + '" class="form-select issuefilternumericoption" name="name' + counter + '">' + issuefilternumericoption + '</select></li>';
                cols += '<li class=""><input id="advncfiltertextfieldvalue_' + counter + '" type="text" class="form-control advncfiltertextfieldvalue" value="" name="field' + counter + '"/>' + advncfiltertextfieldvalue + '</li>';

                cols += '<li class="del_add_rules"><button  id="ibtnDel" class="nostylebtn"><img src="dist/img/close.svg" width="13px" data-bs-toggle="tooltip" data-bs-placement="top" title="clear"></button></li>';
            }
            else {
                $('button#addrow').prop('disabled', false).css({
                    'opacity': '1'
                });
                cols += '<li class=""><select id="issuefilter_' + counter + '" class="form-select issuefilter" name="name' + counter + '">' + issuefilter + '</select></li>';
                cols += '<li class=""><select id="issuefilternumericoption_' + counter + '" class="form-select issuefilternumericoption" name="name' + counter + '">' + issuefilternumericoption + '</select></li>';
                cols += '<li class=""><input id="advncfiltertextfieldvalue_' + counter + '" type="text" class="form-control advncfiltertextfieldvalue" value="" name="field' + counter + '"/>' + advncfiltertextfieldvalue + '</li>';

                cols += '<li class="del_add_rules"><button  id="ibtnDel" class="nostylebtn"><img src="dist/img/close.svg" width="13px" data-bs-toggle="tooltip" data-bs-placement="top" title="clear"></button></li>';

            }
            newRow.append(cols);
            $("div.order-list").append(newRow);
            counter++;
            $("#advCounter").val(counter);
        }

        $("#addrow").on("click", function () {

            //----------------------[for advance Filter]
            loadAdvanceFilterControlData();

        });

        $(".addfilterrow").on("click", "#ibtnDel", function (event) {
            //
            $(this).closest("ul").remove();
            var id = $(this).closest("ul").attr('id').split("addrowsmore")[1];
            $("#queryfilterclear").find("#query_" + id).remove();
            //counter -= 1;

        });

        $(".addfilterrow").on("click", ".clearallbtn", function (event) {
            $(".issueorder-list").closest("ul").remove();
            counter -= 1
        });

        $('#addrow').prop('disabled', false);


        $('body').on("keyup", '.advncfiltertextfieldvalue', function () {
            var intcounter = $(this)[0].id.substring(12);
            if ($('.advncfiltertextfieldvalue').val() != '' || $('#issuefilterValue_' + intcounter + ' :selected').val() != '') {
                $('#addrow').prop('disabled', false).css({
                    'opacity': '1'
                });
            } else {
                $('#addrow').prop('disabled', true);
            }
        });

        //$('#advncfiltertextfieldvalue').keyup(function(){
        $('body').on("change", '.advncfiltercmdfieldvalue', function () {

            var intcounter = $(this)[0].id.substring(12);
            $("#advncfiltertextfieldvalue_" + intcounter).val('');

            if ($('#issuefilterValue_' + intcounter + ' :selected').val() != '') {
                $('#addrow').prop('disabled', false).css({
                    'opacity': '1'
                });
            }
        });

        $('body').on("change", '.issuefilter', function () {

            var rootnode = $(this).parent();
            var intcounter = $(this)[0].id.substring(12);
            $("#issuefilterValue_" + intcounter).hide();
            $("#advncfiltertextfieldvalue_" + intcounter).show();

            if ($(this).children("option:selected").val() != '') {
                if ($(this).children("option:selected").val() == "ActiveStatus" ||
                    $(this).children("option:selected").val() == "CorrespondenceAddress" ||
                    $(this).children("option:selected").val() == "PrincipalContact") {
                    $("#advncfiltertextfieldvalue_" + intcounter).hide();
                    $("#issuefilterValue_" + intcounter).show();
                }
            }

        });

        //show filter project textarea column
        $("#addrow").click(function () {
            $(".advancebuilder_save").show(0);
            $("#filterprofields").show(0);
            $("#queryfilterclear").show(0);

        });


          

    }); //document ready end here

        function setAutoCompleteDisable() {
            $('#stackDetail').find(':input').each(function () {
                switch (this.type) {
                    case 'text': $(this).attr("autocomplete", "new"); break;
                }
            });
        }


        function ClearStakeholderDetails() {
            $("#ProjectContactID").val('0');
            $('#stackDetail').find(':input').each(function () {
                switch (this.type) {
                    case 'text': if ($(this)[0].id != 'SCustomer') { $(this).val(''); } break;
                    case 'select-one': $(this).val(''); break;
                    case 'textarea': $(this).val(''); break;
                }
            });
            // Added by Vyankat B. on 1st April 2026 for setting the default value in Group dropdown
            $("#SContactCategoryID").val('0');
           // End of Added by Vyankat B. on 1st April 2026 for setting the default value in Group dropdown

            $("#SActive").attr('checked', true);
            $("#SPrincipleContact").attr('checked', false);
            $("#SCorrecpondenceAddress").attr('checked', false);
            $("#divName").show();
            $("#divNameforOrganization").hide();
        }

        function mapSqlOperatorforAppend(expression, value) {
            if (expression == "LIKE") {
                return "LIKE ''%" + value + "%''";
            }
            else if (expression == "NOT LIKE") {
                return "NOT LIKE ''%" + value + "%''";
            }
            else {
                return expression + " ''" + value + "''";
            }
        }
        function append() {
            //
            $("#queryfilterclear").text("");
            $("#AdvancequeryFilter").val('');
            var addrowsmore = $(".addrowsmore");
            var resultstr = "";

            var lastcount = $(".issuefilter").last().attr('id').substring(12);
            for (var i = 0; i <= lastcount; i++) {
                var selectfield = $.trim($("#issuefilter_" + i).val());
                var operator = $.trim($("#issuefilternumericoption_" + i).val());
                var txtValue = $.trim($("#advncfiltertextfieldvalue_" + i).val());
                var txtValue1 = $.trim($("#issuefilterValue_" + i).val());

                if (txtValue == "") {
                    txtValue = txtValue1;
                }
                if (selectfield != "") {
                    if (i == 0) {

                        resultstr = selectfield + ' ' + mapSqlOperatorforAppend(operator, txtValue);
                        $("#queryfilterclear").append("<span id='query_" + i + "'>" + selectfield + ' ' + mapSqlOperatorforAppend(operator, txtValue) + "</span>");

                    }
                    else {
                        var inputid = $("input[name=andor" + i + "]:checked").attr('id');
                        var checkid = $("#" + inputid).val();
                        $("#queryfilterclear").append("<span id='query_" + i + "'>" + ' ' + checkid + ' ' + selectfield + ' ' + mapSqlOperatorforAppend(operator, txtValue) + "</span>");
                        resultstr += ' ' + checkid + ' ' + selectfield + ' ' + mapSqlOperatorforAppend(operator, txtValue);
                    }
                }
            }
            $("#AdvancequeryFilter").val(resultstr);
        }

        //Clear Query Filter
        $(".clearqueryfilter").click(function () {
            $("#queryfilterclear").val('');
            $("#AdvancequeryFilter").val('');
        });

        //tooltip
        $('[data-bs-toggle="tooltip"]').tooltip();

        
        $(document).on("change", ".chckHead", function () {
            var $this = $(this);
            //var node = $this.parent();
            var checked = $this.is(':checked');
            if (checked) {               
                $this.closest(".list-to-filter").find("ul .chcktbl").each(function () {
                    var $this = $(this);
                    $this.prop("checked", true);

                });
            } else {
                $this.closest(".list-to-filter").find("ul .chcktbl").each(function () {
                    var $this = $(this);
                    $this.prop("checked", false);

                });
            }
        });

        // Changing state of CheckAll checkbox 
        $(".chcktbl").click(function () {
            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }

        });





        //function fltSelAll() {
        //    debugger;
        //    var checkhead = $("#stakeCategoriesSearchlistname li input.chckHead")
        //    var checked = $(checkhead).is(':checked');
        //    if (checked) {
        //        alert();
        //        //var chktbl = $(checked).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl");
        //        $(checked).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").each(function () {
        //            $(chktbl).prop("checked", true);
        //            /*var node = $(this).parent();*/
        //            var $this = $(this);
        //            var node = $this.parent();

        //            if ($(checked).parents().parents().find(".stakeCategoriesSearch").val().length > 0) {
        //                if (node.css('display') == 'none') {

        //                }
        //                else {
        //                    $(checked).prop("checked", true);
        //                    $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#1359ac" });
        //                }
        //            }
        //            else {
        //                $(this).prop("checked", true);
        //                $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#1359ac" });
        //            }
                    
        //        });
        //    } else {
        //        $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").each(function () {
        //            var node = $(this).parent();
        //            if ($(this).parents().parents().find(".stakeCategoriesSearch").val().length > 0) {
        //                if (node.css('display') == 'none') {

        //                }
        //                else {
        //                    $(this).prop("checked", false);
        //                    $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#464a4c" });
        //                }
        //            }
        //            else {
        //                $(this).prop("checked", false);
        //                $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#464a4c" });
        //            }
        //        });
        //    }

        //    if ($(this).closest(".Stakeholdertbl .dropdown-menu").find(".stakeCategoriesSearch")[0].id == "stakeCategoriesSearchname") {
        //        performFilter(this, 0, 'tbl');
        //    }
        //    else if ($(this).closest(".Stakeholdertbl .dropdown-menu").find(".stakeCategoriesSearch")[0].id == "stakeCategoriesSearchdesignation") {
        //        performFilter(this, 2, 'tbl');
        //    }
        //}

        //Commented and Added By Riddhesh Patil on 13 April 2023 for Filter related Issue
        //$("#stakeCategoriesSearchname").on("keyup", function () {
        //   // debugger
        //    var $this = $(this);
        //    var value = $this.val().toLowerCase();
        //    $("#stakeCategoriesSearchlistname li").filter(function () {
        //        var $this = $(this);
               
        //        $this.toggle($this.text().toLowerCase().indexOf(value) > -1)
        //    });
        //});

        //$("#stakeCategoriesSearchdesignation").on("keyup", function () {

        //    //debugger;
        //    var $this = $(this);
        //    var value = $this.val().toLowerCase();
        //    $("#stakeCategoriesSearchlistdesignation li").filter(function () {
        //        var $this = $(this);
        //        $this.toggle($this.text().toLowerCase().indexOf(value) > -1)
        //    });
        //});

        function StakeNameSearchFuntion(element) {
            var value = $(element).val().toLowerCase();
            $("#stakeCategoriesSearchlistname > li").each(function () {
                if ($(this).text().toLowerCase().indexOf(value) > -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }

        function StakeDesignationSearchFuntion(element) {
            var value = $(element).val().toLowerCase();
            $("#stakeCategoriesSearchlistdesignation > li").each(function () {
                if ($(this).text().toLowerCase().indexOf(value) > -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        
        //End of Commented and Added By Riddhesh Patil on 13 April 2023 for Filter related Issue


       // $(".Stakeholdertbl .dropdown-menu .list-to-filter .stakeCategoriesSearchlist li").on("click", ".chckHead", function () {
       //$(document).on('click, change', '.chckHead', function () {
       //   // alert();
       //    //$(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chckHead").prop('checked', true);
       //     var checked = $(this).is(':checked');
       //    //var checked = $(this.chcked);
       //    $(this).prop('checked');
       //     if (checked) {
                
       //         $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").each(function () {
       //             var node = $(this).parent();

       //             if ($(this).parents().parents().find(".stakeCategoriesSearch").val().length > 0) {
       //                 if (node.css('display') == 'none') {

       //                 }
       //                 else {
       //                     $(this).prop("checked", true);
       //                     $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#1359ac" });
       //                 }
       //             }
       //             else {
       //                 $(this).prop("checked", true);
       //                 $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#1359ac" });
       //             }
       //         });
       //     } else {
       //         $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").each(function () {
       //             var node = $(this).parent();
       //             if ($(this).parents().parents().find(".stakeCategoriesSearch").val().length > 0) {
       //                 if (node.css('display') == 'none') {

       //                 }
       //                 else {
       //                     $(this).prop("checked", false);
       //                     $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#464a4c" });
       //                 }
       //             }
       //             else {
       //                 $(this).prop("checked", false);
       //                 $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#464a4c" });
       //             }
       //         });
       //     }

       //     if ($(this).closest(".Stakeholdertbl .dropdown-menu").find(".stakeCategoriesSearch")[0].id == "stakeCategoriesSearchname") {
       //         performFilter(this, 0, 'tbl');
       //     }
       //     else if ($(this).closest(".Stakeholdertbl .dropdown-menu").find(".stakeCategoriesSearch")[0].id == "stakeCategoriesSearchdesignation") {
       //         performFilter(this, 2, 'tbl');
       //     }
       // });

        //  chckHeadDesignation

        //$(".Stakeholdertbl .dropdown-menu .list-to-filter").on("change", ".chcktbl", function () {            
        //    var checkedtbl = $(this).is(':checked');
        //    if (checkedtbl) {
                
        //        $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").each(function () {
        //            $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#1359ac" });

        //        });
        //    }
        //    else {
        //        $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").each(function () {
        //            $(".Stakeholdertbl th button.dropdown-toggle").css({ "color": "#464a4c" });
        //        });
        //        $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chckHead").prop('checked', false);
        //    }

        //    //check "select all" if all checkbox items are checked
        //    var CheckedCount = $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").filter(function (i, element) {
        //        return ($(element).prop('checked') == true && $(element).parent().css('display') != 'none');
        //    }).length;
        //    var AllVisibleCount = $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chcktbl").filter(function (i, element) {
        //        return ($(element).parent().css('display') != 'none');
        //    }).length

        //    if (CheckedCount == AllVisibleCount) {
        //        $(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chckHead").prop('checked', true);
        //        //$(this).closest(".Stakeholdertbl .dropdown-menu .list-to-filter").find("ul .chckHead").checked = true; //change "select all" checked status to true
        //    }
        //});

        function changeSelectAllState(control) {

        }

        //filter-table

        $('#Stakeholdername').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });
        $('#stackstaus').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('#stackrole').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('#stackcategory').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('#stacktype').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        function comparer(index) {
            return function (a, b) {
                var valA = getCellValue(a, index),
                    valB = getCellValue(b, index)
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
            }
        }

        function getCellValue(row, index) {
            return $(row).children('td').eq(index).text()
        }

        //replace 
        function replaceAllChar(text, replacechar, replacewith) {
            var replacetext = '';
            var _replacechar = '';
            var _replacewith = '';
            if (replacechar == undefined)
                _replacechar = "'";
            if (replacewith == undefined)
                _replacewith = "''";
            if (text != '') {
                var ch = '';
                for (var i = 0; i < text.length; i++) {
                    ch = text.charAt(i);
                    if (ch == _replacechar) {
                        replacetext = replacetext + _replacewith;
                    } else {
                        replacetext = replacetext + ch;
                    }
                }
            }
            return replacetext;
        }

        //replace 
        function replaceChar(text) {
            var replacetext = text;
            if (replacetext != '') {
                replacetext = replacetext.replace("''''", "''").replace("''", "'");
            }
            return replacetext;
        }

        //filter-table
        function DownloadReport(ReportFormat) {

            var WhichTask;
            var IsActiveTasks = "";
            var projectID = $("#CboProject option:selected").val();

            var objStakeholdersProjectContactExportParameter = {
                ProjectID: encodeURI(projectID),
                ReportFilterQuery: ReportFilterQuery,
                ReportFormat: encodeURI(ReportFormat)
            }



            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/ExportDocument',
                type: "POST",
                data: JSON.stringify(objStakeholdersProjectContactExportParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (objStakeholdersProjectContactExportParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objStakeholdersProjectContactExportParameter) ? objStakeholdersProjectContactExportParameter : JSON.stringify(objStakeholdersProjectContactExportParameter)));
                    }
                },
                success: function (data) {
                    if (data == "") {
                        showAlert('<%= MyBase.GetResourceString("C_Records_are_not_available to_download_report") %>', 'alert-danger');
                }
                else {
                    window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                }


            },
            error: function (err) {
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        })
        }

        //#region Alerts
        function showAlert(Msg, className, id) {
            //  
            $('.ClosaeblealertMsg').show();
            if (id != undefined) {
                $('#' + id).prop("disabled", true);
            }
            if (className == 'alert-danger') {
                $('#CloseableAlert').removeClass("alert-success");
                $('#CloseableAlert').addClass("alert-danger");
            }
            else if (className == 'alert-success') {
                $('#CloseableAlert').removeClass("alert-danger");
                $('#CloseableAlert').addClass("alert-success");
            }
            $('#alertMsg').html(Msg);
            $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }

        function showAlerts(Msg, className, id) {
            //  
            $('.ClosaeblealertMsg').show();
            if (id != undefined) {
                $('#' + id).prop("disabled", true);
            }
            if (className == 'alert-danger') {
                $('#CloseableAlerts').removeClass("alert-success");
                $('#CloseableAlerts').addClass("alert-danger");
            }
            else if (className == 'alert-success') {
                $('#CloseableAlerts').removeClass("alert-danger");
                $('#CloseableAlerts').addClass("alert-success");
            }
            $('#alertMsgs').html(Msg);
            $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function CloseShowAlerts() {
            $('.ClosaeblealertMsg').hide();
        }
        //endregion
        //kk<script><script type="text/javascript">

        //#region onchange()
        function GetSelectedTextValue(ddlFruits) {
            var selectedText = DrawComboBox.options[DrawComboBox.selectedIndex].innerHTML;
            var selectedValue = ddlFruits.value;
            alert("Selected Text: " + selectedText + " Value: " + selectedValue);
        }

        //#endregion

        //#region Get Card Details


        $("#CboProject").on("change", function () {
            isCustomerGroupAvailable();
            $(".canclebtn").click();
            enableDisabledControls();
            //Added By Usha Pandit On 25.10.2019 for discussion panel   
            showHidePanel("hide");
            //End Of Added By Usha Pandit On 25.10.2019 for discussion panel 

            ProjectID = $("#CboProject :selected").val();
            StakeholderDefaultFilter();
            StakeholderGetMyFiltersList();
            fillOrganization(0);
            fillCustomerName();
            fillclients();
            fillclientsforsavestakeholder();
            getStakeholderGroupByCount();

            var SessionRoleId = '<%= Session("intPostID") %>';
        CheckUserRole(2104, SessionRoleId);
    });

        function enableDisabledControls() {

            var id = $("#CboProject :selected").val();
            if (id == '' || id == '0') {
                $.each($("#divstakeholdertableheader").find("li,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $.each($("#divstakeholderfilter").find("li,select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                //$("#StakeholderClearAllFilter").addClass("disabledbutton");
                //$("#StakeholderClearAllFilter").css("display", "none");
                $("#StakeholderClearAllFilter").hide(); $("#btnAdvFilter").css({ "background": "NONE", "color": "UNSET" });
            } else {
                $.each($("#divstakeholdertableheader").find("li,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $.each($("#divstakeholderfilter").find("li,select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                //$("#StakeholderClearAllFilter").css("display", "block");
                // $("#StakeholderClearAllFilter").show();$("#btnAdvFilter").css({ "background": "#1359a6","color": "#fff"});
                //$("#StakeholderClearAllFilter").removeClass("disabledbutton");
            }
        }

        function enableDisabledControlsForEdit(flag) {

            if (!flag) {
                $.each($("#divstakeholdertableheader").find("li,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $.each($("#divstakeholderfilter").find("li,select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $.each($("#hidestaklist").find("table,div,li,select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $("#StakeholderClearAllFilter").addClass("disabledbutton");
            } else {
                $.each($("#divstakeholdertableheader").find("li,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $.each($("#divstakeholderfilter").find("li,select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $.each($("#hidestaklist").find("table,div,li,select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $("#StakeholderClearAllFilter").removeClass("disabledbutton");
            }
        }

        function getStakeholderGroupByCount() {

            var paramitersForGrid = {
                projectID: encodeURI($("#CboProject :selected").val())
            }

            if (paramitersForGrid.projectID == '0' || paramitersForGrid.projectID == '' ) {
                paramitersForGrid.projectID = -1;
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/GetStakeholderProjectContacts',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForGrid),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForGrid) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForGrid) ? paramitersForGrid : JSON.stringify(paramitersForGrid)));
                    }
                },
                success: function (result) {
                    // debugger;
                    if (result.length > 0) {
                        $('#Customercount').text(parseInt(result[0].CountofCustomers, 0));
                        $('#Organizationcount').text(parseInt(result[0].CountofOrganization, 0));
                        $('#Othercount').text(parseInt(result[0].CountofOthers, 0));
                    } else {
                        $('#Customercount').text('0');
                        $('#Organizationcount').text('0');
                        $('#Othercount').text('0');
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        function fillCustomerName() {
            var defaultFilterParameters = {
                ProjectID: $("#CboProject :selected").val()
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetCustomerNameOfStakeholder',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    if (result != undefined)
                        $("#SCustomer").val(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        function fillOrganization(EmployeeID) {
            var defaultFilterParameters = {
                ProjectID: $("#CboProject :selected").val(),
                EmployeeID: EmployeeID
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetOrganizationNames',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    $("#SNameOrganization").empty().append('<option value=""></option>');
                    $.each(result, function () {
                        $("#SNameOrganization").append($("<option></option>").val(this['EmployeeId']).html(this['EmployeeName']));
                    });
                    if (EmployeeID != '0') {
                        $("#SNameOrganization").val(result[0].EmployeeID);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        //GetContactCategory 
        function getContactCategory() {
            var type = "";
            var defaultFilterParameters = {
                ProjectContactID: '0',
                GroupID: $("#SContactCategoryID :selected").val() == '' ? '0' : $("#SContactCategoryID :selected").val()
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetContactCategory',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    type = result;
                },
                error: function (err) {
                    type = 'C';
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return type;
        }

        //fill type of contact
        function fillTypeOfContact(projectContactId) {
            var defaultFilterParameters = {
                ProjectContactID: projectContactId == '' ? '0' : projectContactId,
                GroupID: $("#SContactCategoryID :selected").val() == '' ? '0' : $("#SContactCategoryID :selected").val()
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetTypeOfContacts',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    $("#STypeOfContactId").empty().append('<option value=""></option>');
                    $.each(result, function () {
                        $("#STypeOfContactId").append($("<option></option>").val(this['TypeOfContactID']).html(this['TypeOfContact']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //fill all clients 
        function fillclients() {
            var defaultFilterParameters = {
                ProjectID: $("#CboProject :selected").val()
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetClients',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {

                    $("#txtPMFilterClientId").empty().append('<option value="">Select Client</option>');
                    $("#SClientID").empty().append('<option value=""></option>');
                    $.each(result, function () {
                        $("#SClientID").append($("<option></option>").val(this['ClientId']).html(this['ClientName']));
                        $("#txtPMFilterClientId").append($("<option></option>").val(this['ClientId']).html(this['ClientName']));
                    });

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        //fill clients for save stakeholder
        function fillclientsforsavestakeholder() {
            var defaultFilterParameters = {
                ProjectID: $("#CboProject :selected").val()
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetClientsForSaveStakeholder',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    $("#ulinheritcontct").html('');
                    var li = '';
                    var contactli = '';
                    var input = '';
                    var label = '';
                    li = '<li class="selctallcontcts"><div class="custom_chckbox"><input type="checkbox" id="inheritcntctall" class="chckHead"/><label for="inheritcntctall">Select All</label></div></li>';
                    $.each(result, function (index, value) {
                        contactli = '<li><div class="custom_chckbox">';
                        input = '<input type="checkbox" id="inheritcntct' + index + '" value="' + this['ClientId'] + '" class="chcktbl"/>';
                        label = '<label for="inheritcntct' + index + '">' + this['ClientName'] + '</label>';
                        li = li + contactli + input + label + '</div>';
                        //$("#SClientID").append($("<option></option>").val(this['ClientId']).html(this['ClientName']));
                        //$("#txtPMFilterClientId").append($("<option></option>").val(this['ClientId']).html(this['ClientName']));
                    });
                    $("#ulinheritcontct").html(li);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }


        function fillprojectname() {
            var defaultFilterParameters = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
            ProjectID: encodeURI('<%= Session("intProjectID") %>')
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/GetProjectDropDown',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    $("#CboProject").empty();
                    //.append('<option value="">Nothing selected</option>');
                    $.each(result, function () {
                        $("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));
                    });

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function ClearEmployeeDetails() {
            $("#SDesignation").val('');
            $("#Sphone1").val('');
            $("#Sphone2").val('');
            $("#SExt1").val('');
            $("#SMobile").val('');
            $("#SEmailID").val('');
            $("#SCountryID").val('');
            $("#SFax").val('');
            $("#SAddress1").val('');
            $("#SAddress2").val('');
            $("#SCity").val('');
            $("#SState").val('');
            $("#SZip").val('');
        }


        $("#SContactCategoryID").on("change", function () {
            //Added and Modified By Nikhil A on 27-Nov-2019
            //Added by Chetan M on 13th April 2020 for IssueID = 23177
            fillclients();
            // Commented and updated by Vyankat B. on 1st April 2026 for checking the default value in Group dropdown
            //if ($("#SContactCategoryID :selected").val() == "") {
            if ($("#SContactCategoryID :selected").val() == "" || $("#SContactCategoryID :selected").val() == "0") {
                // End of Commented and updated by Vyankat B. on 1st April 2026
                $('#stackDetail').find(':input').each(function () {
                    switch (this.type) {
                        case 'text': $(this).val(''); break;
                        case 'select-one': $(this).val(''); break;
                        case 'textarea': $(this).val(''); break;
                    }
                });
                // updated by Vyankat B. on 1st April 2026 for checking the default value in Group dropdown
                $("#SContactCategoryID").val('0');
                // End of  updated by Vyankat B. on 1st April 2026

                DisableStakeHolderDetails();
            }
            //End of Added and Modified By Nikhil A on 27-Nov-2019
            else {
                //End Of Added By Nikhil A

                fillTypeOfContact('');
                var getContacttype = getContactCategory();
                //$("#STypeOfContactId").removeClass("bgwhite");
                $("#SName").val('');
                $("#SNameOrganization").val('');
                $("#SDesignation").val('');
                $("#SClientID").val('');
                $("#SOrganizationName").val('');
                $("#STypeOfContactId").val('');
                $("#SNameOrganization").attr("disabled", false);
                EnableStakeholderControls();
                ClearEmployeeDetails();

                //Organization
                if (getContacttype == 'O') {
                    $("#divOrganization").hide();
                    $("#divCustmer").hide();
                    $("#divName").hide();
                    $("#divClient").hide();
                    $("#divNameforOrganization").show();
                    //$("#STypeOfContactId").val(1);
                    //$("#STypeOfContactId").attr("disabled", true);
                }
                else if (getContacttype == 'H') {
                    $("#divOrganization").show();
                    $("#divCustmer").hide();
                    $("#divClient").hide();
                    $("#divName").show();
                    $("#SDesignation").val('');
                    $("#divNameforOrganization").hide();
                }
                else {
                    fillCustomerName();
                    EmployeeDetails('0');
                    $("#divOrganization").hide();
                    $("#divCustmer").show();
                    $("#divName").show();
                    $("#divClient").show();
                    $("#SDesignation").val('');
                    $("#divNameforOrganization").hide();
                    $("#SEmailID").attr("disabled", true);
                    //$("#STypeOfContactId").val(2);
                    //$("#STypeOfContactId").attr("disabled", true);
                }
                $("#STypeOfContactId").attr("disabled", false);
                $("#STypeOfContactId").addClass("bgwhite");
            }
        });

        $(".customercount").on('click', function () {
            //if ($(this).text() != "") {
            //    var curCount = $(this).text().toString().substring(0, 1);
            //    if (curCount != 0) {
            //        fillTableData("CategoryType=''C''");
            //    }
            //}
            fillTableData("CategoryType=''C''");
        });
        $(".Organizationcount").on('click', function () {
            //var curCount = $(this).text().toString().substring(0, 1);
            //if (curCount != 0) {
            //    fillTableData("CategoryType=''O''");
            //}
            //StartLoader
            fillTableData("CategoryType=''O''");
        });

        $(".Othercount").on('click', function () {
            //var curCount = $(this).text().toString().substring(0, 1);
            //if (curCount != 0) {
            //    fillTableData("CategoryType=''H''");
            //}
            fillTableData("CategoryType=''H''");
        });

        //End Of Added By Usha Pandit On 28.08.2020 For getting correct result 
        //for Customer, Organization and other details

        //Check isPrincipleContact is already existaccording to contact type
        function isPrincipleContact() {
            var boolresult = true;
            if ($("#SPrincipleContact").is(':checked')) {
                var ObjCheckprinciplecontactparam = {
                    ProjectContactID: $("#ProjectContactID").val(),
                    ProjectID: $("#CboProject :selected").val(),
                    TypeOfContactID: $("#STypeOfContactId :selected").val()
                }

                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/IsCheckPrincipleContact',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ObjCheckprinciplecontactparam),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ObjCheckprinciplecontactparam) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ObjCheckprinciplecontactparam) ? ObjCheckprinciplecontactparam : JSON.stringify(ObjCheckprinciplecontactparam)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        boolresult = result;
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            } else {
                boolresult = false;
            }
            return boolresult;
        }

        //check CustomerGroupAvailable
        function isCustomerGroupAvailable() {
            var boolresult = false;
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                projectID = -1;
            }
            var ObjCheckprinciplecontactparam = {
                ProjectID: projectID,
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/IsCustomerGroupAvailable',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ObjCheckprinciplecontactparam),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ObjCheckprinciplecontactparam) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ObjCheckprinciplecontactparam) ? ObjCheckprinciplecontactparam : JSON.stringify(ObjCheckprinciplecontactparam)));
                    }
                },
                async: false,
                success: function (result) {
                    boolresult = result;
                    if (boolresult) {
                        if ($("#btninheritcontct").hasClass("disabledbutton")) {
                            $.each($("#btninheritcontct").find("li,button"), function (index, control) {
                                $(control).removeClass("disabledbutton");
                            });
                            $("#btninheritcontct").removeClass("disabledbutton");
                        }
                    } else {
                        $.each($("#btninheritcontct").find("li,button"), function (index, control) {
                            $(control).addClass("disabledbutton");
                        });
                        $("#btninheritcontct").addClass("disabledbutton");
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            return boolresult;
        }


        //check external contact type
        function isExternalContactType() {
            var boolresult = false;

            var ObjCheckprinciplecontactparam = {
                TypeOfContactID: $("#STypeOfContactId :selected").val(),
            }

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/IsExternalContactType',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ObjCheckprinciplecontactparam),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ObjCheckprinciplecontactparam) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ObjCheckprinciplecontactparam) ? ObjCheckprinciplecontactparam : JSON.stringify(ObjCheckprinciplecontactparam)));
                    }
                },
                async: false,
                success: function (result) {
                    boolresult = result;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            return boolresult;
        }

        //delete stakeholder contact 
        function SetDeletedStakeholderId(Id) {

            $('#DeleteStakeholderId').attr('value', Id);
            $("#deleteStakeholdermodal").modal("show");
        }

        function cancelStakeholderDelete() {
            $("#deleteStakeholdermodal").modal("hide");
            $("#DeleteStakeholderId").removeAttr("value");
        }

        function DeleteStakeholder() {

            var DeleteStakeholderId = $("#DeleteStakeholderId").attr("value");

            if (DeleteStakeholderId.length != 0) {
                var paramiters = {
                    ProjectContactID: DeleteStakeholderId
                }

                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/DeleteStakeHolderProjectContacts',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramiters),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (paramiters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramiters) ? paramiters : JSON.stringify(paramiters)));
                        }
                    },
                    success: function (result) {
                        $("#DeleteStakeholderId").removeAttr("value");
                        StakeholderDefaultFilter();
                        fillclientsforsavestakeholder();
                        $(".canclebtn").click();
                        showAlert('<%= MyBase.GetResourceString("C_Deleted") %>', 'alert-success');
                    //applybasicFilter();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            }
        }

        $("#tbl").on("click", ".btndeletecontact", function () {
            SetDeletedStakeholderId(this.value);
        });


        function fillTableData(filterQuery) {
           // debugger;
            //StartLoader("#bodystakeholder");
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                projectID = -1;
            }
            if (filterQuery == null || filterQuery == '') {
                //Added & Commented By Dipali V On 22nd April 2020 For Issue ID 23171
                //$("#StakeholderClearAllFilter").hide();$("#btnAdvFilter").css({ "background": "NONE","color": "UNSET"});
                $("#StakeholderClearAllFilter").hide(); $("#btnAdvFilter").css({ "background": "NONE", "color": "black" });
                //End of Added & Commented By Dipali V On 22nd April 2020 For Issue ID 23171
                $(".statustext>li.active").removeClass("active");
                //$("#StakeholderClearAllFilter").addClass("disabledbutton");
            } else {
                $("#StakeholderClearAllFilter").show(); $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                //$("#StakeholderClearAllFilter").removeClass("disabledbutton");
            }

            if (filterQuery == null) {
                filterQuery = null;
                //Added By Usha Pandit On 04.01.2020 For Search Filter Issue
                $("#serchstakholders").val("");
                //End Of Added By Usha Pandit On 04.01.2020 For Search Filter Issue
            }
            if (filterQuery == null) {
                var sibling = $('label[id^="Apply"]');
                $(sibling).each(function () {
                    var id = this.id;
                    //if (ApplyID == this.id) {
                    $("#" + id).parent().find("input").prop("checked", false);
                    $("#" + id).attr("data-original-title", "Apply filter");
                    //}
                    //else {
                    //    $("#" + id).parent().find("input").prop("checked", false);
                    //}
                });
                ClearBasicFilter(module);
                clearBasicFilters();
                GlobalApplyID = null;
                filterQuery = "";
                $("#btnAdvFilter").attr("aria-expanded", false);
                $("#filterpanel").removeClass("in");
            }
            var paramitersForGrid = {
                projectID: encodeURI(projectID),
                FilterQuery: encodeURI(filterQuery)

            }
            //---*******----- Remove Active Class
            //$(".statustext>li.active").removeClass("active");

            //----******----- clear all table recods
            table.dataTable({
                "pageLength": 5,
                // "scrollY": 400,
                // "scrollX": true,
                "lengthChange": false,
                "bFilter": true,
                "dom": 'lrtip',
                "ordering": false,
                "responsive": true,
                "bDestroy": true
            }).fnClearTable(true);

            //----******----- load data into table from webapi
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/GetStakeholderProjectContacts',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForGrid),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForGrid) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForGrid) ? paramitersForGrid : JSON.stringify(paramitersForGrid)));
                    }
                },
                success: function (result) {
                    //StopAjaxLoader("#bodystakeholder");

                    if (AddAccess == "False") {
                        $("#addstakeholdr").prop('disabled', true);
                    } else {
                        $("#addstakeholdr").prop('disabled', false);
                    }
                    table.DataTable({
                        data: result,
                        "pageLength": 5,
                        // "scrollY": true,
                        // "scrollX": true,
                        "lengthChange": false,
                        "bFilter": true,
                        "dom": 'lrtip',
                        "ordering": false,
                        "responsive": true,
                        "bDestroy": true,
                        "processing": true,
                        "ordering": true,
                        "columns": [
                            { "data": "Name" },
                            { "data": "Status" },
                            { "data": "Designation" },
                            { "data": "ContactInfo" },
                            { "data": "TypeOfContact" },
                            {
                                mRender: function (data, type, row) {
                                    $('[data-bs-toggle="tooltip"]').tooltip();
                                    $('[data-bs-toggle="popover"]').popover();
                                    var Result = '';

                                    Result = EditAccess == "False" ? '<a class="edit_SH_Detail editstakebtn1" href="javascript:;" title="You Dont have access to Edit" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" disabled="disabled" value="' + row.ProjectContactID + '"><i class="fas fa-pencil-alt"></i></a>' : '<a class="edit_SH_Detail editstakebtn" href="javascript:;" title="<%= MyBase.GetResourceString("C_Edit") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + row.ProjectContactID + '" onclick="EditStakeholder(' + row.ProjectContactID + ')"><i class="fas fa-pencil-alt"></i></a>';
                                Result = Result + (DeleteAccess == "False" ? '<button class="nostylebtn btndeletecontact1" title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + row.ProjectContactID + '"><i class="far fa-trash-alt"></i></button>' : '<button class="nostylebtn btndeletecontact" title="<%= MyBase.GetResourceString("C_Delete") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + row.ProjectContactID + '"><i class="far fa-trash-alt"></i></button>');
                                return Result;
                            }
                        },
                        {
                            "data": "ContactCategory", "searchable": true
                        }
                    ],
                    initComplete: function () {
                        configFilter(this, [0, 2]);
                    },
                    'columnDefs': [
                        { width: "30%", className: "text-start", "targets": [0] },

                        {
                            width: "5%",
                            'targets': 1,
                            'className': 'text-center',
                            'render': function (data, type, full, meta) {
                                if (type === "sort" || type === 'type') {
                                    return data;
                                }
                                else {
                                    if (data == true) {
                                        return '<div class="indicator indicatorGreen" data-bs-toggle="tooltip" title="Active">&nbsp;</div>';
                                    }
                                    else {
                                        return '<div class="indicator" data-bs-toggle="tooltip" title="InActive">&nbsp;</div>';
                                    }
                                }
                            }
                        },
                        { width: "20%", "targets": [2] },
                        {
                            "bSortable": false,
                            'orderable': false,
                            width: "27%",
                            className: "cntctinfo",
                            "targets": [3],
                            'render': function (data, type, full, meta) {
                                if (data.length) {

                                    var arrContactInfo = data.split("/");
                                    if (arrContactInfo.length > 1) {
                                        //Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25382
                                        //data = '<a href="javascript:;">' + arrContactInfo[0] + '</a>  /' + ' <a href="javascript:;">' + arrContactInfo[1] + '</a>';
                                        if (arrContactInfo[0] != "" || arrContactInfo[1] != "") {
                                            data = '<a href="javascript:;">' + arrContactInfo[0] + '</a>  /' + ' <a href="javascript:;">' + arrContactInfo[1] + '</a>';
                                        }
                                        else {
                                            data = "";
                                        }
                                        //End of Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25382
                                    }
                                    else {
                                        data = "";
                                    }
                                }
                                return data;
                            }
                        },
                        { width: "10%", "targets": [4] },
                        { width: "8%", className: "hoveractions", "targets": [5], 'orderable': false },
                        { visible: false, "targets": [6] }

                    ]
                });

                getStakeholderGroupByCount();
                if ($("#liCustomer").hasClass("active")) {
                    $(".statustext>li.active").removeClass("active");
                    $(".customercount").parent().addClass("active");
                    $("#tbl").DataTable().column(6).search('Customer').draw();
                }
                else if ($("#liOrganization").hasClass("active")) {
                    $(".statustext>li.active").removeClass("active");
                    $(".Organizationcount").parent().addClass("active");
                    $("#tbl").DataTable().column(6).search('Organization').draw();
                }
                else if ($("#liOther").hasClass("active")) {
                    $(".statustext>li.active").removeClass("active");
                    $(".Othercount").parent().addClass("active");
                    $("#tbl").DataTable().column(6).search('Other').draw();
                }
            },
            error: function (err) {
               // StopAjaxLoader("#bodystakeholder");
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });

            ReportFilterQuery = filterQuery;
            return filterQuery;
        }


        function clearBasicFiltersforEdit() {

            $("#btnsaveandapply1").show();
            $("#btnsaveandapply2").show();

            $("#FilterID").val("0");
            $("#QueryID").val("0");
            $("#divBasicfilter").find("input[type=text],input[type=Textbox], textarea").val("");
            $("#divBasicfilter").find('input:checkbox').removeAttr('checked');
            //$("#divBasicfilter").find("select").val("");
            $("#divBasicfilter").find("select option").prop("selected", false);
            $("#presetfilter").removeClass("active in");
            $("#basicfilterli").removeClass("active");

            $("#queryfilter").removeClass("active in");
            $("#advancefilterli").removeClass("active");

            $("#presetfilter").addClass("active in");
            $("#basicfilterli").addClass("active");
        }

        function clearAdvanceFiltersforEdit() {

            $("#btnsaveandapply3").show();
            $("#FilterID").val("0");
            $("#QueryID").val("0");
            $("#AdvancequeryFilter").val("");
            $("#queryfilterclear").text("");
            $(".order-list").find("ul").remove();
            $("#AdvfilterName").val('');
            $("#advCounter").val('0');
            $("#queryfilter").removeClass("active in");
            $("#advancefilterli").removeClass("active");
            $("#presetfilter").removeClass("active in");
            $("#basicfilterli").removeClass("active");
            $("#queryfilter").addClass("active in");
            $("#advancefilterli").addClass("active");

        }

        function clearBasicFilters() {

            $("#btnsaveandapply1").show();
            $("#btnsaveandapply2").show();
            $("#FilterID").val("0");
            $("#QueryID").val("0");
            $("#txtFilterName").val('');
            $("#divBasicfilter").find("input[type=text],input[type=Textbox], textarea").val("");
            $("#divBasicfilter").find('input:checkbox').removeAttr('checked');
            //$("#divBasicfilter").find("select").val("");
            $("#divBasicfilter").find("select option").prop("selected", false);
            $("#presetfilter").removeClass("active in");
            $("#basicfilterli").removeClass("active");
            $.each($('.btn.dropdown-toggle.bs-placeholder.btn-default'), function (index, control) {

                $(this).removeAttr('title');
            });
        }


        //Attachment start
        var PKToken = '';
        function DownloadAttachedFile(value) {

            var projectContactID = $("#ProjectContactID").val();
            var ProjectID = $("#CboProject :selected").val();
            PKToken = GetToken(2104, value, projectContactID, ProjectID);
            //var strTemp = "../../General/CLCP_Attachment.aspx?ConnectionID=&Operation=VIEW_ATTACHMENT&AttachmentID=" + value + "&PKToken=iAYA/iyNytP7a4zT9nsuUA&SubTagFromCL=1&ForeignKey=ProjectContactID&ForeignKeyValue=" + projectContactID + "&MasterTagID=2051&FromWhere=PM&SubTagPagingAlphabet=-1&ParentTagID=2104&SubTagSortBy=&STAccessFirstTime=0&SubTagSortOrder=&PagingNumber=1";
            var strTemp = '../../NewAPI/PM/PM_ViewAttachment.aspx?FromWhere=StakeholderDocuments&MasterTagID=2104&DocumentID=' + value + '&PKToken=' + PKToken + '&ProjectID=' + ProjectID + '&StakeholderID=' + projectContactID;
            window.open(strTemp);
            //    }
            //});
        }

        function GetToken(TagID, DocumnetID, StakeHolderID, ProjectID) {
            var TokenParameter =
            {
                TagID: TagID,
                DocumnetID: DocumnetID,
                StakeHolderID: StakeHolderID,
                ProjectID: ProjectID

            }
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetToken',
                type: "POST",
                data: JSON.stringify(TokenParameter),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (TokenParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(TokenParameter) ? TokenParameter : JSON.stringify(TokenParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    PKToken = result
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        //endregion

        
        //This function initializes the content inside the filter modal
        function configFilter($this, colArray) {
            gRunningID++;
            setTimeout(function () {
                $('#stakeCategoriesSearchlistname').empty();
                $('#stakeCategoriesSearchlistdesignation').empty();
                var tableName = $this[0].id;
                var columns = $this.api().columns();
                $.each(colArray, function (i, arg) {
                    $('#' + tableName + ' th:eq(' + arg + ')').append('');
                });
                $.each(colArray, function (index, value) {
                    columns.every(function (i) {
                        if (value === i) {
                            var column = this, content = '';
                            var columnName = $(this.header()).text().replace(/\s+/g, "_");
                            var distinctArray = [];
                            if (value == 0)
                                $('#stakeCategoriesSearchlistname').append('<li><input type="checkbox" id="stakeroleall' + gRunningID + '" onchange="fltSelAll()" class="chckHead" value="Select All" > <label for="stakeroleall' + gRunningID + '"> Select All</label></li>');
                            else if (value == 2)
                                $('#stakeCategoriesSearchlistdesignation').append('<li><input type="checkbox" id="stakeroleall2" onclick="fltSelAll2()" class="chckHead" value="Select All" > <label for="stakeroleall' + gRunningID + '"> Select All</label></li>');

                            column.data().each(function (d, j) {
                                if (distinctArray.indexOf(d) == -1) {
                                    var id = tableName + "_" + columnName + "_" + j; // onchange="formatValues(this,' + value + ');                               
                                    //if (d == '') {
                                    //    d='$Empty Value$'
                                    //}
                                    if (value == 0 && d != '') {
                                        $('#stakeCategoriesSearchlistname').append('<li><input type="checkbox" value="' + d + '"  id="' + id + '" class="chcktbl" onclick="performFilter(this, ' + value + ', \'' + tableName + '\');" /><label for="' + id + '"> ' + d + '</label></li>');
                                    }

                                    else if (value == 2 && d != '') {

                                        $('#stakeCategoriesSearchlistdesignation').append('<li><input type="checkbox" value="' + d + '"  id="' + id + '" class="chcktbl" onclick="performFilter(this, ' + value + ', \'' + tableName + '\');" /><label for="' + id + '"> ' + d + '</label></li>');
                                    }
                                    distinctArray.push(d);
                                }
                            });
                            content = '';
                        }
                    });
                });
            }, 50);
        }

        //Execute the filter on the table for a given column
        function performFilter(node, i, tableId) {
            var rootNode = $(node).parent().parent();
            var searchString = '', counter = 0;

            rootNode.find('input:checkbox').each(function (index, checkbox) {
                if (checkbox.checked) {
                    if (checkbox.value != "Select All") {
                        searchString += (counter == 0) ? checkbox.value : '|' + checkbox.value;
                        counter++;
                    }
                }
            });

            $('#' + tableId).DataTable().column(i).search(
                searchString, true, false
            ).draw(); 

            $(".stakeCategoriesSearchlist li input.chckHead").prop("checked", false);
            $(".stakeCategoriesSearchlist li input.chckHead").prop("checked", $(".chcktbl").length === $(".chcktbl:checked").length);
        }

        //Removes the filter from the table for a given column
        function clearFilter(node, i, tableId) {
            var rootNode = $(node).parent().parent();
            rootNode.find(".filterSearchText").val('');
            rootNode.find('input:checkbox').each(function (index, checkbox) {
                checkbox.checked = false;
                $(checkbox).parent().show();
            });
            $('#' + tableId).DataTable().column(i).search(
                '',
                true, false
            ).draw();
        }

        function ChangeView() {
            enableDisabledControlsForEdit(true);
            isCustomerGroupAvailable();
            var viewName = $('#CboProjectView').find(":selected").text();
            if (viewName.toUpperCase() == "Raci View".toUpperCase()) {
                var selectedProject = $('#CboProject').val();
                window.location.href = "PM_racichart.aspx?ProjectID=" + selectedProject;

            }
            else if (viewName == "List View") {
                var selectedProject = $('#CboProject').val();
                window.location.href = "PM_stakeholders.aspx?ProjectID=" + selectedProject;

            }
            else if (viewName == "Card View") {
                var selectedProject = $('#CboProject').val();
                window.location.href = "PM_project_card_view.aspx?ProjectID=" + selectedProject;

            }
            else if (viewName == "Metrix View") {
                var selectedProject = $('#CboProject').val();
                window.location.href = "stakebubblechart.html";
                Response.redirect("stakebubblechart.html");
            }
        }

        function GetAttachments(ProjectContactID) {
            EnableStakeholderControls();
            $("#ProjectContactID").val(ProjectContactID);

            var paramitersForAttachment = {
                projectID: $("#CboProject :selected").val(),
                ProjectContactID: ProjectContactID
            }
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/GetAttachments',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForAttachment),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForAttachment) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForAttachment) ? paramitersForAttachment : JSON.stringify(paramitersForAttachment)));
                    }
                },
                success: function (result) {
                    //if (AddAccess == "False") {
                    //    $("#addattachnebtrow").prop('disabled', true);
                    //} else {
                    //    $("#addattachnebtrow").prop('disabled', false);
                    //}
                    getAllAttachments(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function EditStakeholder(ProjectContactID) {
            //Added By Usha Pandit On 04.11.2019 for discussion panel   
            showHidePanel("show");
            collapseExpandPanel("collapse");
            ProjectContactID = ProjectContactID.toString().trim();
            currentUniqueID = ProjectContactID;
            //End Of Added By Usha Pandit On 04.11.2019 for discussion panel  
            $("#btnStakeholderDetailsSave")[0].innerText = '<%= MyBase.GetResourceString("C_Update") %>';
            enableDisabledControlsForEdit(false);
            editProjectID = $("#CboProject :selected").val();
            //$(".detailsubtabs>li.active").removeClass("active");
            $(".detailsubtabs>li.active").removeClass("active");
            $("#tabDetails").addClass("active");
            //Commented and Added BY Riddhesh Patil on 12 April 2023
            //$("#stackDetail").addClass("active");
            $("a[href='#stackDetail']").addClass("active");
            //End of Commented and Added BY Riddhesh Patil on 12 April 2023
            $("#stackRisk").removeClass("active");
            $("#StackReqReport").removeClass("active");
            $("#allAttachments").removeClass("active");
            projectContactID = ProjectContactID;
            GetRisks(ProjectContactID);
            GetRequiredReports(ProjectContactID);
            EditStakeholderDetails(ProjectContactID);
            GetAttachments(ProjectContactID);
        }

        function fillFrequency() {

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/StakeholderRequiredReportsFrequency',// Path
                type: "POST",                                       //HTTP TYPE get /post
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                async: false,
                success: function (result) {
                    frequencyList = result;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        function fillReportTagMaster() {

            $.ajax({
                url: strUrl + '/api/PM_stakeholders/StakeholderRequiredReportsTagMasters',// Path
                type: "POST",                                       //HTTP TYPE get /post
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                async: false,
                success: function (result) {
                    reportTagMasterList = result;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        function GetRequiredReports(ProjectContactID) {

            var paramitersRequiredReports = {
                ProjectContactID: ProjectContactID
            }
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/StakeholderRequiredReports',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersRequiredReports),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersRequiredReports) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersRequiredReports) ? paramitersRequiredReports : JSON.stringify(paramitersRequiredReports)));
                    }
                },
                success: function (result) {

                    if (AddAccess == "False") {
                        $("#addRequiredReportrow").prop('disabled', true);
                        $("#addRequiredReportrow").attr('title', 'You Dont have access to add');
                    } else {
                        $("#addRequiredReportrow").prop('disabled', false);
                        $("#addRequiredReportrow").attr('title', '');
                    }
                    $('#tbodyStackholderReqReporttbl').html('');
                    if (result.length > 0) {
                        var ReqReport = "";
                        var Frequency = '';
                        for (var i = 0; i < result.length; i++) {
                            Frequency = result[i].Frequency;
                            var FrequencyDDL = $("<select></select>").attr("id", "cmbFrequency_" + result[i].ReportID).attr("class", "form-select tablerequiredcontrol").css("display", "none");
                            var ReportDDL = $("<select></select>").attr("id", "cmbReport_" + result[i].ReportID).attr("class", "form-select tablerequiredcontrol").css("display", "none");

                            $.each(frequencyList, function () {
                                FrequencyDDL.append($("<option></option>").val(this['Frequency']).html(this['Frequency']));
                            });

                            $.each(reportTagMasterList, function () {
                                ReportDDL.append($("<option></option>").val(this['TagID']).html(this['ReportTitle']));
                            });

                            var action = '';
                            action = EditAccess == "False" ? '<a class="save_SH_Detail_RequiredReport" href="javascript:;" title="You Dont have access to save" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" disabled="disabled"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>' : '<a class="save_SH_Detail_RequiredReport savestakerequiredreportbtn" href="javascript:;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Save") %>" data-bs-toggle="tooltip" style="display:none;" data-bs-placement="top" data-bs-container="body" onclick="SaveStakeHolderRequiredReport(this,' + result[i].ReportID + ')"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>';
                        action = action + (EditAccess == "False" ? '<button class="edit_SH_Detail_RequiredReport editstakerequiredreportbtn  nostylebtn edit" href="javascript:;" title="You Dont have access to Edit" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" disabled="disabled"><i class="fas fa-pencil-alt"></i></button>' : '<button class="edit_SH_Detail_RequiredReport  nostylebtn edit editstakerequiredreportbtn" href="javascript:;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Edit") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" onclick="editRequiredReport(' + result[i].ReportID + ',this)"><i class="fas fa-pencil-alt"></i></button>');
                        action = action + (DeleteAccess == "False" ? '<button class="nostylebtn delete" title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"><i class="far fa-trash-alt"></i></button>' : '<button class="nostylebtn deleterequiredreportbtn delete" value="' + result[i].ReportID + '"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Delete") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"><i class="far fa-trash-alt"></i></button>');
                        action = action + '<button style="display:none;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="Cancel" class="ibtnRequiredReportCancel nostylebtn" name="' + result[i].ReportID + '"><i class="fa fa-times" value="Delete"></i></button>';
                        ReqReport = ReqReport + '<tr>' +
                            //Commented And Added By Usha Pandit On 08.12.2020 For getting correct ReportId
                            //'<td><div title="' + result[i].TagID + '" id="DivReport_' + result[i].ReportID + '" class="DivReport_' + result[i].ReportID + '">' + replaceChar(result[i].ReportTitle) + '</div>' + ReportDDL[0].outerHTML + '<span id="spanReport_' + result[i].ReportID + '" style="display:none;color: red;margin-top: -25px;float: right;">*</span></td>' +
                            //'<td><div class="DivFrequency_' + result[i].ReportID + '">' + replaceChar(Frequency) + '</div>' + FrequencyDDL[0].outerHTML + '<span id="spanFrequency_' + result[i].ReportID + '" style="display:none;color: red;margin-top: -25px;float: right;">*</span></td>' +
                            //'<td class="text-start"><div class="DivReport_Description_' + result[i].ReportID + '">' + replaceChar(result[i].ReportDescription) + '</div>' + '<textarea style="display:none;" id="txtReportDescription_' + result[i].ReportID + '" class="form-control" maxlength="700" value="" autocomplete="new"></textarea></td>' +
                            //'<td>' + action +
                            //'</td>' +
                            //'</tr>';
                            '<td><div id="DivReportS_' + result[i].ReportID + '_' + result[i].TagID + '" style = "display:none;"></div><div title="' + result[i].TagID + '" id="DivReport_' + result[i].ReportID + '" class="DivReport_' + result[i].ReportID + '">' + replaceChar(result[i].ReportTitle) + '</div>' + ReportDDL[0].outerHTML + '<span id="spanReport_' + result[i].ReportID + '" style="display:none;color: red;margin-top: -25px;float: right;">*</span></td>' +
                            '<td><div class="DivFrequency_' + result[i].ReportID + '">' + replaceChar(Frequency) + '</div>' + FrequencyDDL[0].outerHTML + '<span id="spanFrequency_' + result[i].ReportID + '" style="display:none;color: red;margin-top: -25px;float: right;">*</span></td>' +
                            '<td class="text-start"><div class="DivReport_Description_' + result[i].ReportID + '">' + replaceChar(result[i].ReportDescription) + '</div>' + '<textarea style="display:none;" id="txtReportDescription_' + result[i].ReportID + '" class="form-control" maxlength="700" value="" autocomplete="new"></textarea></td>' +
                            '<td>' + action +
                            '</td>' +
                            '</tr>';
                        //End Of Added By Usha Pandit On 08.12.2020 For getting correct ReportId
                    }
                    $('#tbodyStackholderReqReporttbl').append(ReqReport);
                    $(".save_SH_Detail_RequiredReport,.edit_SH_Detail_RequiredReport,.delete,.ibtnRequiredReportCancel ,.ibtnRequiredReportDel").tooltip({
                        placement: 'top'
                    });
                }
            },
            error: function (err) {
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        }

        //inherite contact report 
        var objInheritecontactRequiredReports = '';
        function SetInheritecontact(objStakeholderRequiredReports) {
            $("#Inheritecontactmodal").modal("show");
        }

        function cancelInheritecontact() {
            $("#Inheritecontactmodal").modal("hide");
        }

        function noInheritecontact() {
            if (objInheritecontactRequiredReports != '') {
                objInheritecontactRequiredReports.IsInheritedClientID = false;
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/SaveStakeholderProjectContactsRequiredReports',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(objInheritecontactRequiredReports),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (objInheritecontactRequiredReports) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objInheritecontactRequiredReports) ? objInheritecontactRequiredReports : JSON.stringify(objInheritecontactRequiredReports)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (parseInt(result) > 0) {
                            GetRequiredReports(objInheritecontactRequiredReports.ProjectContactID);
                            objInheritecontactRequiredReports = '';
                            showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            }
        }

        function addInheritecontact() {
            if (objInheritecontactRequiredReports != '') {
                StartLoader("#bodystakeholder");
                objInheritecontactRequiredReports.IsInheritedClientID = true;
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/SaveStakeholderProjectContactsRequiredReports',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(objInheritecontactRequiredReports),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (objInheritecontactRequiredReports) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objInheritecontactRequiredReports) ? objInheritecontactRequiredReports : JSON.stringify(objInheritecontactRequiredReports)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (parseInt(result) > 0) {
                            GetRequiredReports(objInheritecontactRequiredReports.ProjectContactID);
                            objInheritecontactRequiredReports = '';
                            showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
                    }
                },
                error: function (err) {
                    StopAjaxLoader("#bodystakeholder");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
                StopAjaxLoader("#bodystakeholder");
            }
        }

        //Start Save RequiredReport
        function SaveStakeHolderRequiredReport(a, id) {
            $(".tooltip").tooltip("hide");
            var objStakeholderRequiredReports;
            if (id == undefined) {
                objStakeholderRequiredReports = {
                    ReportID: 0,
                    ProjectContactID: $("#ProjectContactID").val(),
                    TagID: 0,
                    Frequency: '',
                    ReportDescription: '',
                    CreatedBy: '<%= Session("strUserName") %>',
                ModifiedBy: '<%= Session("strUserName") %>',
                IsInheritedClientID: 0,
                ProjectID: $("#CboProject").val()
            }
            $(a).closest("tr").find('td').each(function (index, value) {
                if (index == 0) {
                    objStakeholderRequiredReports.TagID = replaceAllChar($(value).find('select').val());

                }
                else if (index == 1) {
                    objStakeholderRequiredReports.Frequency = replaceAllChar($(value).find('select').val());

                }
                else if (index == 2) {
                    objStakeholderRequiredReports.ReportDescription = replaceAllChar($(value).find('textarea').val());

                }
            });
        } else {
            objStakeholderRequiredReports = {
                ReportID: id,
                ProjectContactID: $("#ProjectContactID").val(),
                TagID: 0,
                Frequency: '',
                ReportDescription: '',
                CreatedBy: '<%= Session("strUserName") %>',
                ModifiedBy: '<%= Session("strUserName") %>',
                    IsInheritedClientID: 0,
                    ProjectID: $("#CboProject").val()
                }
                $(a).closest("tr").find('td').each(function (index, value) {
                    if (index == 0) {
                        objStakeholderRequiredReports.TagID = replaceAllChar($(value).find('select').val());

                    }
                    else if (index == 1) {
                        objStakeholderRequiredReports.Frequency = replaceAllChar($(value).find('select').val());

                    }
                    else if (index == 2) {
                        objStakeholderRequiredReports.ReportDescription = replaceAllChar($(value).find('textarea').val());

                    }
                });
            }
            if ((objStakeholderRequiredReports.TagID).trim() == '' || (objStakeholderRequiredReports.TagID).trim() == '0') {
                showAlert('<%= MyBase.GetResourceString("C_RequiredReport_PleaseSelectReport") %>', 'alert-danger');
        }
        else if ((objStakeholderRequiredReports.Frequency).trim() == '') {
            showAlert('<%= MyBase.GetResourceString("C_RequiredReport_PleaseSelectFrequency") %>', 'alert-danger');
            }
            else if (checkSpecialCharacter(objStakeholderRequiredReports.ReportDescription, WebConfigSpecialCharacters) == true) {
                showAlert('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters', 'alert-danger');
            }
        else {
            objInheritecontactRequiredReports = objStakeholderRequiredReports;
            var getContacttype = getContactCategory();
            if ($(a).hasClass("SaveNewRequiredReport") && isExternalContactType() && getContacttype == 'C') {
                SetInheritecontact(objStakeholderRequiredReports);
            } else {
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/SaveStakeholderProjectContactsRequiredReports',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(objStakeholderRequiredReports),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (objStakeholderRequiredReports) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objStakeholderRequiredReports) ? objStakeholderRequiredReports : JSON.stringify(objStakeholderRequiredReports)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (parseInt(result) > 0) {
                            GetRequiredReports(objStakeholderRequiredReports.ProjectContactID);
                            if (parseInt(objStakeholderRequiredReports.ReportID) > 0) {
                                showAlert('<%= MyBase.GetResourceString("C_Update_successfully") %>', 'alert-success');
                            } else {
                                showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                            }
                        }
                        else {
                            showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                }
            }
            $(".tooltip").tooltip("hide");
        }

        function editRequiredReport(ReportID, a) {
            $(".tooltip").tooltip("hide");
            var tagID = $("#DivReport_" + ReportID)[0].title;
            //Added By Usha Pandit On 08.12.2020 For getting correct ReportId
            var currentReportId = $('*[id*=DivReportS_' + ReportID + ']').attr("id");
            currentReportId = currentReportId.replace("DivReportS_" + ReportID, "");
            currentReportId = currentReportId.replace("_", "");
            //End Of Added By Usha Pandit On 08.12.2020 For getting correct ReportId
            var reportDescription = $(".DivReport_Description_" + ReportID).text();
            var frequency = $(".DivFrequency_" + ReportID).text();

            $(a).closest('td').find(".ibtnRequiredReportCancel").css('display', 'inline-block');
            $(a).closest('td').find(".savestakerequiredreportbtn").css('display', 'inline-block');
            $(a).closest('td').find(".editstakerequiredreportbtn").css('display', 'none');
            $("#txtReportDescription_" + ReportID).css('display', 'block');
            $(".DivReport_Description_" + ReportID).css('display', 'none');
            $("#txtReportDescription_" + ReportID).val(reportDescription);
            $("#cmbFrequency_" + ReportID).css('display', 'block');
            $("#cmbReport_" + ReportID).css('display', 'block');
            $("#spanReport_" + ReportID).css('display', 'block');
            $("#spanFrequency_" + ReportID).css('display', 'block');
            $(".DivFrequency_" + ReportID).css('display', 'none');
            $(".DivReport_" + ReportID).css('display', 'none');

            $("#cmbFrequency_" + ReportID).val(frequency);
            //Commented And Added By Usha Pandit On 08.12.2020 For getting correct ReportId
            //$("#cmbReport_" + ReportID).val(tagID);
            $("#cmbReport_" + ReportID).val(currentReportId);
            //End Of Added By Usha Pandit On 08.12.2020 For getting correct ReportId
            $(".deleterequiredreportbtn,.editstakerequiredreportbtn").prop('disabled', true);
            $(".deleterequiredreportbtn,.editstakerequiredreportbtn").css("cursor", "not-allowed");
            $("#addRequiredReportrow").prop('disabled', true);
        }

        $(".StackholderRisktbl").on("click", ".deleteriskbtn", function () {
            SetDeletedRiskId(this.value);
        });

        //delete risk  
        function SetDeletedRiskId(Id) {

            $('#DeleteRiskId').attr('value', Id);
            $("#deleteRiskmodal").modal("show");
        }

        function cancelRiskDelete() {
            $("#deleteRiskmodal").modal("hide");
            $("#DeleteRiskId").removeAttr("value");
        }

        function DeleteRisk() {

            var DeleteRiskId = $("#DeleteRiskId").attr("value");

            if (DeleteRiskId.length != 0) {
                var paramiters = {
                    RiskID: DeleteRiskId
                }

                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/DeleteStakeHolderProjectContactsRisk',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramiters),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (paramiters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramiters) ? paramiters : JSON.stringify(paramiters)));
                        }
                    },
                    success: function (result) {
                        $("#DeleteRiskId").removeAttr("value");
                        GetRisks(projectContactID);
                        showAlert('<%= MyBase.GetResourceString("C_Deleted") %>', 'alert-success');
                },
                error: function (ER) {
                    alert(ER);
                }
            });

            }
        }

        function GetRisks(ProjectContactID) {

            var paramitersForRisk = {
                ProjectContactID: ProjectContactID
            }
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/StakeholderRiskDetails',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForRisk),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForRisk) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForRisk) ? paramitersForRisk : JSON.stringify(paramitersForRisk)));
                    }
                },
                success: function (result) {

                    if (AddAccess == "False") {
                        $("#addRiskrow").prop('disabled', true);
                        $("#addRiskrow").attr('title', 'You Dont have access to add');
                    } else {
                        $("#addRiskrow").prop('disabled', false);
                        $("#addRiskrow").attr('title', '');
                    }
                    $('#tbodyStackholderRisktbl').html('');
                    if (result.length > 0) {
                        var Risk = "";
                        var RiskFrom = false;
                        var RiskType = '';
                        for (var i = 0; i < result.length; i++) {
                            RiskFrom = result[i].RiskFrom;
                            var RiskTypeDDL = '<select class="form-select tablerequiredcontrol" style="display:none;" id="cmbRiskType_' + result[i].RiskID + '"><option title="" value=""></option><option title="From" value="1">From</option><option title="To" value="0">To</option></select><span id="spanRiskType_' + result[i].RiskID + '" style="display:none;color: red;margin-top: -25px;float: right;">*</span>';

                            if (RiskFrom) {
                                RiskType = 'From';
                            } else {
                                RiskType = 'To';
                            }
                            var action = '';
                            action = EditAccess == "False" ? '<a class="save_SH_Detail_Risk" href="javascript:;" title="You Dont have access to save" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" disabled="disabled"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>' : '<a class="save_SH_Detail_Risk savestakeriskbtn" href="javascript:;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Save") %>" data-bs-toggle="tooltip" style="display:none;" data-bs-placement="top" data-bs-container="body" onclick="SaveStakeHolderRisks(this,' + result[i].RiskID + ')"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>';
                        action = action + (EditAccess == "False" ? '<button class="edit_SH_Detail_Risk editstakeriskbtn  nostylebtn edit" href="javascript:;" title="You Dont have access to Edit" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" disabled="disabled"><i class="fas fa-pencil-alt"></i></button>' : '<button class="edit_SH_Detail_Risk  nostylebtn edit editstakeriskbtn" href="javascript:;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Edit") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" onclick="editRisk(' + result[i].RiskID + ',this)"><i class="fas fa-pencil-alt"></i></button>');
                        action = action + (DeleteAccess == "False" ? '<button class="nostylebtn delete" title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"><i class="far fa-trash-alt"></i></button>' : '<button class="nostylebtn deleteriskbtn delete" value="' + result[i].RiskID + '"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Delete") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"><i class="far fa-trash-alt"></i></button>');
                        action = action + '<button style="display:none;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="Cancel" class="ibtnRiskCancel nostylebtn" name="' + result[i].RiskID + '"><i class="fa fa-times" value="Delete"></i></button>';
                        Risk = Risk + '<tr>' +
                            '<td><div class="DivRisk_Name_' + result[i].RiskID + '">' + replaceChar(result[i].RiskName) + '</div><input type="Textbox" style="display:none;" id="txtRiskName_' + result[i].RiskID + '" class="form-control tablerequiredcontrol" maxlength="100" value="" autocomplete="new"><span id="spanRiskName_' + result[i].RiskID + '" style="display:none;color: red;margin-top: -25px;float: right;">*</span></td>' +
                            '<td class="text-start"><div class="DivRisk_Description_' + result[i].RiskID + '">' + replaceChar(result[i].RiskDescription) + '</div>' + '<textarea style="display:none;" id="txtRiskDescription_' + result[i].RiskID + '" class="form-control" maxlength="700" value="" autocomplete="new"></textarea></td>' +
                            '<td><div class="DivRisk_Type_' + result[i].RiskID + '">' + replaceChar(RiskType) + '</div>' + RiskTypeDDL + '</td>' +
                            '<td>' + action +
                            '</td>' +
                            '</tr>';
                    }
                    $('#tbodyStackholderRisktbl').append(Risk);
                    $(".save_SH_Detail_Risk,.edit,.delete,.ibtnRiskCancel,.ibtnRiskDel ").tooltip({
                        placement: 'top'
                    });
                }
            },
            error: function (err) {
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        }

        $("table.StackholderRisktbl").on("click", ".ibtnRiskDel", function (event) {

            $(".tooltip").tooltip("hide");
            $(this).closest("tr").remove();
            if ($(".addnewrisks").find(".ibtnRiskDel").length == 0) {
                $(".deleteriskbtn,.edit_SH_Detail_Risk").prop('disabled', false);
                $(".deleteriskbtn,.edit_SH_Detail_Risk").css("cursor", "pointer");
                $("#addRiskrow").prop('disabled', false);
            }

        });

        $("#tbodyStackholderReqReporttbl").hover(function (event) {
            $('*[title]').tooltip('disable');
        });

        $("#tabAttachments,#tabReport,#tabRisk,#tabDetails").click(function (event) {
            $('*[title]').tooltip('disable');
        });

        


        $("table.StackholderRisktbl").on("click", ".ibtnRiskCancel", function (event) {
            $(".tooltip").tooltip("hide");
            if ($(this)[0].name == undefined || $(this)[0].name == '') {
                $(this).closest("tr").remove();
            } else {
                var RiskID = $(this)[0].name;
                $($(this)).closest('td').find(".savestakeriskbtn").css('display', 'none');
                $($(this)).closest('td').find(".editstakeriskbtn").css('display', 'inline-block');
                $("#txtRiskName_" + RiskID).css('display', 'none');
                $(".DivRisk_Name_" + RiskID).css('display', 'inline-block');
                $("#txtRiskDescription_" + RiskID).css('display', 'none');
                $(".DivRisk_Description_" + RiskID).css('display', 'inline-block');
                $("#cmbRiskType_" + RiskID).css('display', 'none');
                $("#spanRiskType_" + RiskID).css('display', 'none');
                $("#spanRiskName_" + RiskID).css('display', 'none');
                $(".DivRisk_Type_" + RiskID).css('display', 'inline-block');
                $(this).css('display', 'none');
            }
            //$.each($("table.StackholderRisktbl").find(".edit_SH_Detail_Risk, .deleteriskbtn"), function (index, control) {
            //    $(this).prop('disabled', false);
            //});
            $(".deleteriskbtn,.edit_SH_Detail_Risk").prop('disabled', false);
            $(".deleteriskbtn,.edit_SH_Detail_Risk").css("cursor", "pointer");
            $("#addRiskrow").prop('disabled', false);
        });

        var p = 0, q = 0, r = 0;
        $("#addRiskrow").on("click", function () {
            try {


                var RiskTypeDDL = '<select class="form-select tablerequiredcontrol" id="addnewriskscmbRiskType_' + p + '"><option title="" value=""></option><option title="From" value="1">From</option><option title="To" value="0">To</option></select><span style="color: red;margin-top: -25px;float: right;">*</span>';

                $(".deleteriskbtn,.edit_SH_Detail_Risk").prop('disabled', true);
                $(".deleteriskbtn,.edit_SH_Detail_Risk").css("cursor", "not-allowed");

                var newRow = $("<tr class='addnewrisks'>");
                var cols = "";
                var action = '';
                action = EditAccess == "False" ? '<a class="save_SH_Detail_Risk" href="javascript:;" title="You Dont have access to save" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" disabled="disabled"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>' : '<a class="save_SH_Detail_Risk savestakeriskbtn" href="javascript:;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Save") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" onclick="SaveStakeHolderRisks(this)"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>';
            cols += '<td><input type="Textbox" id="addnewriskstxtRiskName_' + p + '" class="form-control tablerequiredcontrol" maxlength="100" value="" autocomplete="new"><span style="color: red;margin-top: -25px;float: right;">*</span></td>'
            cols += '<td ><textarea id="addnewriskstxtRiskDescription_' + p + '" class="form-control" maxlength="700" value="" autocomplete="new"></textarea></td>';
            cols += '<td>' + RiskTypeDDL + '</td>';
            cols += '<td style="text-align: center">' + action + '<button  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="Cancel" class="ibtnRiskDel nostylebtn" title=""><i class="fa fa-times" value="Delete"></i></button></td> </tr>';
            newRow.append(cols);
            $("table.StackholderRisktbl").append(newRow);

            $(".ibtnRiskDel,.save_SH_Detail_Risk").tooltip({
                placement: 'top'
            });
            $("#addRiskrow").prop('disabled', true);
            p++;
            q++;
            r++;
        }
        catch (ex) {
        }

    });

        $(".StackholderReqReporttbl").on("click", ".deleterequiredreportbtn", function () {
            SetDeletedReqReportId(this.value);
        });

        //delete ReqReport  
        function SetDeletedReqReportId(Id) {

            $('#DeleteReqReportId').attr('value', Id);
            $("#deleteReqReportmodal").modal("show");
        }

        function cancelReqReportDelete() {
            $("#deleteReqReportmodal").modal("hide");
            $("#DeleteReqReportId").removeAttr("value");
        }

        function DeleteReqReport() {

            var DeleteReqReportId = $("#DeleteReqReportId").attr("value");

            if (DeleteRiskId.length != 0) {
                var paramiters = {
                    ReportID: DeleteReqReportId
                }

                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/DeleteStakeHolderProjectContactsRequiredReports',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramiters),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (paramiters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramiters) ? paramiters : JSON.stringify(paramiters)));
                        }
                    },
                    success: function (result) {
                        $("#DeleteReqReportId").removeAttr("value");
                        GetRequiredReports(projectContactID);
                        showAlert('<%= MyBase.GetResourceString("C_Deleted") %>', 'alert-success');
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            }
        }

        $("table.StackholderReqReporttbl").on("click", ".ibtnRequiredReportDel", function (event) {
            $(this).closest("tr").remove();
            $(".tooltip").tooltip("hide");
            if ($(".addnewrequiredreport").find(".ibtnRequiredReportDel").length == 0) {
                $(".deleterequiredreportbtn,.edit_SH_Detail_RequiredReport").prop('disabled', false);
                $(".deleterequiredreportbtn,.edit_SH_Detail_RequiredReport").css("cursor", "pointer");
                $("#addRequiredReportrow").prop('disabled', false);
            }
            //script added by pradip for remove tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                //$('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        });

        $("table.StackholderReqReporttbl").on("click", ".ibtnRequiredReportCancel", function (event) {
            $(".tooltip").tooltip("hide");
            if ($(this)[0].name == undefined || $(this)[0].name == '') {
                $(this).closest("tr").remove();
            } else {
                var ReportID = $(this)[0].name;
                $($(this)).closest('td').find(".savestakerequiredreportbtn").css('display', 'none');
                $($(this)).closest('td').find(".editstakerequiredreportbtn").css('display', 'inline-block');
                $("#txtReportDescription_" + ReportID).css('display', 'none');
                $(".DivReport_Description_" + ReportID).css('display', 'block');
                $("#cmbFrequency_" + ReportID).css('display', 'none');
                $("#cmbReport_" + ReportID).css('display', 'none');
                $("#spanReport_" + ReportID).css('display', 'none');
                $("#spanFrequency_" + ReportID).css('display', 'none');
                $(".DivFrequency_" + ReportID).css('display', 'block');
                $(".DivReport_" + ReportID).css('display', 'block');
                $(this).css('display', 'none');
            }
            $(".deleterequiredreportbtn,.edit_SH_Detail_RequiredReport").prop('disabled', false);
            $(".deleterequiredreportbtn,.edit_SH_Detail_RequiredReport").css("cursor", "pointer");
            $("#addRequiredReportrow").prop('disabled', false);
        });

        var e = 0, f = 0, g = 0;
        $("#addRequiredReportrow").on("click", function () {
            try {

                $(".deleterequiredreportbtn,.edit_SH_Detail_RequiredReport").prop('disabled', true);
                $(".deleterequiredreportbtn,.edit_SH_Detail_RequiredReport").css("cursor", "not-allowed");
                var FrequencyDDL = $("<select></select>").attr("id", "addnewrequiredreportcmbFrequency_" + e).attr("class", "form-select tablerequiredcontrol");
                var ReportDDL = $("<select></select>").attr("id", "addnewrequiredreportcmbReport_" + e).attr("class", "form-select tablerequiredcontrol");
                FrequencyDDL.append($("<option></option>").val('').html(''));
                ReportDDL.append($("<option></option>").val('').html(''));
                $.each(frequencyList, function () {
                    FrequencyDDL.append($("<option></option>").val(this['Frequency']).html(this['Frequency']));
                });

                $.each(reportTagMasterList, function () {
                    ReportDDL.append($("<option></option>").val(this['TagID']).html(this['ReportTitle']));
                });
                var newRow = $("<tr class='addnewrequiredreport'>");
                var cols = "";
                var action = '';
                action = EditAccess == "False" ? '<a class="save_SH_Detail_RequiredReport" href="javascript:;" title="You Dont have access to save" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" disabled="disabled"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>' : '<a class="SaveNewRequiredReport save_SH_Detail_RequiredReport savestakerequiredreportbtn" href="javascript:;"  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="<%= MyBase.GetResourceString("C_Save") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" onclick="SaveStakeHolderRequiredReport(this)"><img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>';
            cols += '<td>' + ReportDDL[0].outerHTML + '<span id="spanReport_' + e + '" style="color: red;margin-top: -25px;float: right;">*</span></td>';
            cols += '<td>' + FrequencyDDL[0].outerHTML + '<span id="spanFrequency_' + e + '" style="color: red;margin-top: -25px;float: right;">*</span></td>';
            cols += '<td ><textarea id="addnewrequiredreporttxtReportDescription_' + e + '" class="form-control" maxlength="700" value="" autocomplete="new"></textarea></td>';
            cols += '<td style="text-align: center">' + action + '<button  data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="Cancel" class="ibtnRequiredReportDel nostylebtn" title=""><i class="fa fa-times" value="Delete"></i></button></td> </tr>';
            newRow.append(cols);
            $("table.StackholderReqReporttbl").append(newRow);
            $(".save_SH_Detail_RequiredReport,.ibtnRequiredReportDel").tooltip({
                placement: 'top'
            });
            $("#addRequiredReportrow").prop('disabled', true);
            e++;
            f++;
            g++;
        }
        catch (ex) {
            //alert(ex.message);
        }

        });


        $("#tbodyStackholderReqReporttbl>tr>td").on("hover", function () {
            $(".tooltip").tooltip("hide");

        });

        $("#tabReport").click(function () {
            $(".tooltip").tooltip("hide");
        });

        function editRisk(RiskID, a) {
            $(".tooltip").tooltip("hide");
            $(a).closest('td').find(".savestakeriskbtn").prop('disabled', false);
            var riskname = $(".DivRisk_Name_" + RiskID).text();
            var riskdescription = $(".DivRisk_Description_" + RiskID).text();
            var risktype = $(".DivRisk_Type_" + RiskID).text();
            if (risktype == 'From')
                risktype = 1;
            else
                risktype = 0;
            $("#txtRiskName_" + RiskID).css('display', 'block');
            $("#spanRiskName_" + RiskID).css('display', 'block');
            $("#spanRiskType_" + RiskID).css('display', 'block');
            $(".DivRisk_Name_" + RiskID).css('display', 'none');
            $(a).closest('td').find(".savestakeriskbtn").css('display', 'inline-block');

            $(a).closest('td').find(".ibtnRiskCancel").css('display', 'inline-block');
            $(a).closest('td').find(".editstakeriskbtn").css('display', 'none');
            $("#txtRiskName_" + RiskID).val(riskname);
            $("#txtRiskDescription_" + RiskID).css('display', 'block');
            $(".DivRisk_Description_" + RiskID).css('display', 'none');
            $("#txtRiskDescription_" + RiskID).val(riskdescription);
            $("#cmbRiskType_" + RiskID).css('display', 'block');
            $(".DivRisk_Type_" + RiskID).css('display', 'none');

            $("#cmbRiskType_" + RiskID).val(risktype);
            $(".deleteriskbtn,.edit_SH_Detail_Risk").prop('disabled', true);
            $(".deleteriskbtn,.edit_SH_Detail_Risk").css("cursor", "not-allowed");
            $("#addRiskrow").prop('disabled', true);
        }

        //Start Save Risks
        function SaveStakeHolderRisks(a, id) {
            $(".tooltip").tooltip("hide");
            StartLoader("#bodystakeholder");
            var stakeholderRiskDetails;
            if (id == undefined) {
                stakeholderRiskDetails = {
                    RiskID: 0,
                    ProjectContactID: $("#ProjectContactID").val(),
                    RiskName: '',
                    RiskDescription: '',
                    RiskFrom: true,
                    CreatedBy: '<%= Session("strUserName") %>',
                ModifiedBy: '<%= Session("strUserName") %>'
            }
            $(a).closest("tr").find('td').each(function (index, value) {
                if (index == 0) {
                    stakeholderRiskDetails.RiskName = replaceAllChar($(value).find('input').val());
                }
                else if (index == 1) {
                    stakeholderRiskDetails.RiskDescription = replaceAllChar($(value).find('textarea').val());
                }
                else if (index == 2) {
                    stakeholderRiskDetails.RiskFrom = replaceAllChar($(value).find('select').val());
                }
            });
        } else {
            stakeholderRiskDetails = {
                RiskID: id,
                ProjectContactID: $("#ProjectContactID").val(),
                RiskName: '',
                RiskDescription: '',
                RiskFrom: true,
                CreatedBy: '<%= Session("strUserName") %>',
                ModifiedBy: '<%= Session("strUserName") %>'
                }
                $(a).closest("tr").find('td').each(function (index, value) {
                    if (index == 0) {
                        stakeholderRiskDetails.RiskName = replaceAllChar($(value).find('input').val());

                    }
                    else if (index == 1) {
                        stakeholderRiskDetails.RiskDescription = replaceAllChar($(value).find('textarea').val());

                    }
                    else if (index == 2) {
                        stakeholderRiskDetails.RiskFrom = replaceAllChar($(value).find('select').val());

                    }
                });
            }
            if ((stakeholderRiskDetails.RiskName).trim() == '') {
                showAlert('<%= MyBase.GetResourceString("C_Risks_RiskNotBeBlank") %>', 'alert-danger');
            }
            //Added By Riddhesh Patil on 11 Nov 2024 for restricting Special characters
            else if (checkSpecialCharacter((stakeholderRiskDetails.RiskName).trim(), WebConfigSpecialCharacters) == true) {
                showAlert('Risk should not contain any of these ' + WebConfigSpecialCharacters + ' characters', 'alert-danger');
               
            }
            else if ((stakeholderRiskDetails.RiskDescription).trim() != '' && checkSpecialCharacter((stakeholderRiskDetails.RiskDescription).trim(), WebConfigSpecialCharacters) == true) {
                showAlert('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters', 'alert-danger');

            }
            //End of Added By Riddhesh Patil on 11 Nov 2024 for restricting Special characters
            else if ((stakeholderRiskDetails.RiskFrom).trim() == '') {
            showAlert('<%= MyBase.GetResourceString("C_Risks_PleaseSelectRiskFromTo") %>', 'alert-danger');
            }

         
            else {
                
                stakeholderRiskDetails.RiskFrom = stakeholderRiskDetails.RiskFrom == "1" ? true : false;

                //Added By Riddhesh Patil on 13 April 2023
                if (stakeholderRiskDetails.RiskFrom == false) {
                    stakeholderRiskDetails.RiskFrom = 0;
                }
                else {
                    stakeholderRiskDetails.RiskFrom = 1;
                }
                //End of Added By Riddhesh Patil on 13 April 2023
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/SaveStakeholderProjectContactsRisks',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(stakeholderRiskDetails),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (stakeholderRiskDetails) {
                        xhr.setRequestHeader("Params", encryptString(isJson(stakeholderRiskDetails) ? stakeholderRiskDetails : JSON.stringify(stakeholderRiskDetails)));
                    }
                },
                async: false,
                success: function (result) {

                    if (parseInt(result) > 0) {
                        GetRisks(stakeholderRiskDetails.ProjectContactID);
                        if (parseInt(stakeholderRiskDetails.RiskID) > 0) {
                            showAlert('<%= MyBase.GetResourceString("C_Update_successfully") %>', 'alert-success');
                        } else {
                            showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                        }
                    }
                    else {
                        showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
                    }
                },
                error: function (err) {
                    StopAjaxLoader("#bodystakeholder");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            }
            StopAjaxLoader("#bodystakeholder");
        }

        function getAllAttachments(result) {

            $('#tbodyatchmentTable').html('');
            if (result.length > 0) {
                var Attached = "";
                var DeleteButton = "";
                for (var i = 0; i < result.length; i++) {
                //Commented & Added By Dipali V On 10th Jun 2020 For issue ID 25038
                //DeleteButton = (DeleteAccess == "False" ? '<button class="nostylebtn" title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + result[i].AttachmentID + '"><i class="far fa-trash-alt"></i></button>' : '<button class="nostylebtn delattachbtn" title="<%= MyBase.GetResourceString("C_Delete") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + result[i].AttachmentID + '" onclick="deletAttachments(' + result[i].AttachmentID + ')"><i class="far fa-trash-alt"></i></button>');

                //Commented & Added By Chetan M On 30th Jul 2020 For issue ID 25378
                //DeleteButton = (DeleteAccess == "False" ? '<button class="nostylebtn" title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + result[i].AttachmentID + '"><i class="far fa-trash-alt"></i></button>' : '<button class="nostylebtn delattachbtn" data-original-title="<%= MyBase.GetResourceString("C_Delete") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + result[i].AttachmentID + '" onclick="deletAttachments(' + result[i].AttachmentID + ')"><i class="far fa-trash-alt"></i></button>');
                DeleteButton = (DeleteAccess == "False" ? '<button class="nostylebtn" title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + result[i].AttachmentID + '"><i class="far fa-trash-alt"></i></button>' : '<button class="nostylebtn delattachbtn" data-original-title="<%= MyBase.GetResourceString("C_Delete") %>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" value="' + result[i].AttachmentID + '" onclick="deletAttachments(' + result[i].AttachmentID + ')"><i class="far fa-trash-alt"></i></button>');
                    //End of Commented & Added By Chetan M On 30th Jul 2020 For issue ID 25378
                    //End of Commented & Added By Dipali V On 10th Jun 2020 For issue ID 25038

                    Attached = Attached + '<tr>' +
                        '<td>' + (i + 1) + '</td>' +
                        '<td>' + "<a href = '#' onclick ='DownloadAttachedFile(" + result[i].AttachmentID + ")' >" + result[i].OrignalFileName + "</a></td>" +
                        '<td>' + result[i].FileSize + '</td>' +
                        '<td>' + result[i].AttachedBy + '</td>' +
                        '<td>' + result[i].DateAttached + '</td>' +
                        '<td>' + replaceChar(result[i].Description) + '</td>' +
                        '<td>' + DeleteButton +
                        //'<button class="nostylebtn delattachbtn" id="deleteAttachmentID" title="" " onclick="deletAttachments(' + result[i].AttachmentID + ')"><i class="far fa-trash-alt" value="' + result[i].AttachmentID + '"></i>' +
                        //'</button>' +
                        '</td>' +
                        '</tr>';


                }
                $('#tbodyatchmentTable').append(Attached);

            }
        }




        $('#btnAttachment').on('click', function () {

            var isValid = false;
            var ProjectContactID = $("#ProjectContactID").val();
            var formdata = new FormData();
            var LoginType = '<%= Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var projectid = $("#CboProject").val();
        var AttachedFileData = new Array();
        var isAnyAttachement = false;
        var message = '';
        $('#atchmentTable>#tbodyatchmentTable > tr.attachments').each(function (index, value) {
            isAnyAttachement = true;
            var Description = "";
            var allColumns = $(this).find('td');
            $(allColumns).each(function (i, v) {
                if (i == 0) {

                    var curFileIndex = 0;
                    //var fileinputelement = $(this).find('input[type=file]');
                    var id = $(this).find('*[id*=Afilname]').attr("id");
                    curFileIndex = id.replace(/Afilname/g, "");
                    var id = $('#tbodyatchmentTable > tr.attachments > td:nth-child(1)>#Afilname' + (curFileIndex));
                    var gerfileName = id[0].files[0];
                    var curFlag = Flag;

                    if (gerfileName == undefined) {
                        if (message == '') {
                            message = '<%= MyBase.GetResourceString("C_Attachment_PleaseSelectFile") %>';
                        }
                        isValid = false;
                        return false;
                    } else {
                        isValid = true;
                        formdata.append("file" + index, gerfileName);
                    }
                }
                if (i == 1) {
                    Description = $(this).find('textarea').val();
                    if (message == '') {
<%--                        if (disallowSpecialCharacters($(this).find('textarea'))) {
                            message = '<%= MyBase.GetResourceString("C_Attachment_DescriptionSpecialCharactersNotAllow") %>';
                            isValid = false;
                            return false;
                        }--%>
                        if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                            isValid = false;
                            return false;
                        }
                    }
                }
            });
            var item = {
                ProjectID: projectid,
                Description: replaceAllChar(Description),
                LoginType: LoginType,
                UserName: UserName,
                ProjectContactID: ProjectContactID
            }
            AttachedFileData.push(item);
        });
        if (message != '') {
            showAlert(message, 'alert-danger');
            return true;
        }
        if (isValid && isAnyAttachement) {
           // StartLoader("#bodystakeholder");

            formdata.append("AttachedFileData", JSON.stringify(AttachedFileData));
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/SaveAttachment',
                type: "POST",
                dataType: "json",
                data: formdata,
                contentType: false,
                processData: false,
                //cache: 'false',   //IE FIX
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    StopAjaxLoader("#bodystakeholder");
                    if (result == 'file save successfully') {
                        $('.attachments').each(function (index, value) {
                            $(this).remove();
                        });

                        counterFORattachment = 0;
                        i = "1";
                        j = "1";
                        k = "1";
                        GetAttachments(ProjectContactID);
                        showAlert('<%= MyBase.GetResourceString("C_Attachment_Added_Successfully") %>', 'alert-success');
                    }
                    else {

                        $(".Stakeholdertbl").find("tr").removeClass("tropen");
                        $("#stakedetailpanel .detailsubtabs li:nth-child(2) a, #stakedetailpanel .detailsubtabs li:nth-child(3n) a").css("cursor", "pointer");
                        $("#stakedetailpanel").hide('fast');
                        $("#hidestaklist").show('fast');
                        showAlert(result, 'alert-danger');
                        enableDisabledControlsForEdit(true);//Added By Dipali V On 8th MAy 2020 For 24232
                    }
                },
                error: function (err) {
                   // StopAjaxLoader("#bodystakeholder");
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        else if (!isAnyAttachement) {
            showAlert('Please add new attachment', 'alert-danger');
        }
    });

        async function ValidateAttachments(objFileName) {
           
            isValidFile = false;
            var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>';
            //Added By Rutuja D. on 2 Feb 2021 For MaxFileSize Declaration
            var intMaxFileSize = '<%=ConfigurationManager.AppSettings("MaxFileSize")%>';
            //End Added By Rutuja D. on 2 Feb 2021 For MaxFileSize Declaration

            var FileNameCharCount = "";
            //var intActualFileSize = (objFileName.files['0'].size);
            var intActualFileSize = '';
            if (objFileName.files['0'] != null || objFileName.files['0'] != undefined) {//Added By DipalI V on 11th June 2020 For JS
                intActualFileSize = (objFileName.files['0'].size);
            }
            var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>';
            var validateExtensions;
            validateExtensions = strFileExtension.split(",");
            if (strFileExtension.length > 0) {
                var allowSubmit = false;
                var file = objFileName.value;
                var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();
                for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                    var strExtn;
                    strExtn = validateExtensions[cnt];
                    if (strExtn.toLowerCase() == extension) {

                        isValidFile = true;
                        ///*retu*/rn;
                    }

                }
            }
            if (isValidFile == false) {

                isValidFile = false;
                $(objFileName).val("");
                showAlert("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!", 'alert-danger');
                return //Added by Ajit L on 21/11/2024
            }

            if (objFileName.files['0'] != null || objFileName.files['0'] != undefined) {//Added By DipalI V on 11th June 2020 For JS
                if (objFileName.files['0'].name != '') {
                    var countOfDot = objFileName.files['0'].name.split(".").length - 1;
                }
            }
            if (countOfDot > 1) {

                isValidFile = false;
                $(objFileName).val("");
                showAlert('<%= MyBase.GetResourceString("C_File_with_two_or_more_extensions_is_not_allowed") %>', 'alert-danger');

                return;
            }

            if (objFileName.files['0'] != null || objFileName.files['0'] != undefined) {//Added By DipalI V on 11th June 2020 For JS
                if (objFileName.files['0'].name != '') {
                    FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;
                }
            }

            if (FileNameCharCount != undefined || FileNameCharCount != 'undefined') {//Added By DipalI V on 11th June 2020 For JS
            if (FileNameCharCount > 120) {

                isValidFile = false;
                $(objFileName).val("");
                showAlert('<%= MyBase.GetResourceString("C_File_name_should_not_exceed_120_characters") %>', 'alert-danger');
                    return;
                }
            }

            if (intActualFileSize != null || intActualFileSize != undefined) {
                if (intActualFileSize < intMinFileSize) {

                    isValidFile = false;
                    $(objFileName).val("");
                    showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                    return;
                }
                // Added By Rutuja D. on 2 Feb 2021 For Excceded File size Validation 
                if (intMaxFileSize < intActualFileSize) {
                    isValidFile = false;
                    $(objFileName).val("");
                    showAlert('File size should not be greater than or equal to ' + intMaxFileSize + ' bytes !', "alert-danger");
                    return;
                }
                //End Added By Rutuja D. on 2 Feb 2021 For Excceded File size Validation
            }
            //added by parth Godshelwar
            var isValidTypeExeCheck = false;
            
            //Commented and Added by Aditya J. on 25-11-2024
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            //End of comment Added by Aditya J. on 25-11-2024
            isValidTypeExeCheck = ValidExtsExe.includes(extension);
            //console.log(data);
            if (isValidTypeExeCheck) {
                //const file = objFileName.files[0];
                //await validateDocFileForExe(objFileName.files[0])
                //    .then(() => {
                //        //alert("File is valid and ready to upload.");
                //        isValidTypeExeCheck = true;
                //    })
                //    .catch(error => {
                //        isValidTypeExeCheck = false;
                //        console.log(error);     
                //    });

                //try {
                //    await validateDocFileForExe(objFileName.files[0]);
                //    isValidTypeExeCheck = true;
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.success("File is valid and ready to upload.");
                //} catch (error) {
                //    isValidTypeExeCheck = false;
                //    console.log(error);
                //    $(objFileName).val(""); // Clear the file input
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                //}
                
                //const fileNameInput = $(fileInput).closest('td').find('#FileName1');
                console.log(fileNameInput)
                try {
                    // Check if the document contains an embedded executable (EXE) file
                    await validateDocFileForExe(objFileName.files[0]);

                    // If validation passes, file is valid
                    isValidTypeExeCheck = true;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("File is valid and ready to upload.");

                } catch (error) {
                    // If validation fails (i.e., EXE content is found)
                    isValidTypeExeCheck = false;
                    var fileInput = objFileName;
                    var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                    // Before clearing:
                    console.log("Selected files before clearing:", objFileName.files);
                    $(fileInput).val(""); // Clear the file input
                    fileNameInput.val(""); // Clear the file name text input

                    // Clear the file input
                    $(objFileName).val("");

                    // After clearing:
                    console.log("Selected files after clearing:", objFileName.files);
                    
                    //$(objFileName).closest('form')[0].reset();
                    //console.log("File input cleared"); // Debug log to confirm the input is cleared

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                }

            }

            //if (!isValidTypeExeCheck) {
            //    isValidFile = false; // Set isValidFile to false to indicate an invalid file
            //    $(objFileName).val(""); // Clear the file input
            //    console.log("File input cleared after invalid EXE check");
                
            //}
        }

        function deletAttachments(AttachmentID) {

            var ProjectContactID = $("#ProjectContactID").val();
            var parameters = {
                AttachmentID: AttachmentID
            }
            $.ajax({
                url: strUrl + '/api/PM_stakeholders/DeleteStakeHolderAttachment',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(parameters),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    showAlert('<%= MyBase.GetResourceString("C_Attachment_Remove_Successfully") %>', 'alert-success');
                GetAttachments(ProjectContactID);
            },
            error: function (err) {
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        }


        function EditStakeholderDetails(ProjectContactID) {

            $("#ProjectContactID").val(ProjectContactID);
            var paramitersForAttachment = {
                projectID: encodeURI($("#CboProject :selected").val()),
                ProjectContactID: encodeURI(ProjectContactID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/GetStakeholders',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForAttachment),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForAttachment) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForAttachment) ? paramitersForAttachment : JSON.stringify(paramitersForAttachment)));
                    }
                },
                success: function (result) {

                    fillOrganization(result[0].EmployeeID);
                    setValues(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function setValues(result) {
            $("#SContactCategoryID").attr("disabled", true);
            $("#SName").val('');
            $("#SNameOrganization").val('');
            $("#SDesignation").val('');
            $("#SClientID").val('');
            $("#SOrganizationName").val('');
            $("#SName").val((result[0].Name));//Added By Dipali V On 25th oct 2020 HTML encode
            $("#SClientID").val(result[0].ClientId);
            //Added By DIpali V On 13rd April 2020 For InheritedClientID
            if (result[0].InheritedClientID != "") {
                $("#SName").prop("disabled", true);
            }
            //End of Added By DIpali V On 13rd April 2020 For InheritedClientID
            $("#SDesignation").val(replaceChar(result[0].Designation));
            $("#SContactCategoryID").val(result[0].ContactCategoryID);
            fillTypeOfContact($("#ProjectContactID").val());
            $("#STypeOfContactId").val(result[0].TypeOfContactID);
            $("#SCustomer").val(replaceChar(result[0].CustomerName));
            var getContacttype = getContactCategory();
            //$("#STypeOfContactId").removeClass("bgwhite");
            if (getContacttype == 'O') {
                $("#divOrganization").hide();
                $("#divCustmer").hide();
                $("#divName").hide();
                $("#divClient").hide();
                $("#divNameforOrganization").show();
                //Added By Nikhil A on 27-Nov-2019 for making the designation and Emailid Disable if Type is selected as organization
                $("#SDesignation").prop('disabled', true);
                $("#SEmailID").prop('disabled', true);
                //End of Added By Nikhil A on 27-Nov-2019
                //$("#STypeOfContactId").attr("disabled", true);
            }
            else if (getContacttype == 'H') {
                $("#divOrganization").show();
                $("#divCustmer").hide();
                $("#divClient").hide();
                $("#divName").show();
                $("#divNameforOrganization").hide();
                $("#SOrganizationName").val(replaceChar(result[0].OrganizationName));
                //$("#STypeOfContactId").attr("disabled", false);

            }
            else {
                $("#divOrganization").hide();
                $("#divCustmer").show();
                $("#divName").show();
                $("#divClient").show();
                $("#divNameforOrganization").hide();
                $("#SEmailID").prop('disabled', true);
                //$("#STypeOfContactId").attr("disabled", true);
            }
            $("#STypeOfContactId").addClass("bgwhite");
            $("#Sphone1").val(replaceChar(result[0].Phone1));
            $("#Sphone2").val(replaceChar(result[0].Phone2));
            $("#SExt1").val(replaceChar(result[0].Ext1));
            $("#SExt2").val(replaceChar(result[0].Ext2));
            $("#Sfax").val(replaceChar(result[0].Fax));
            $("#SMobile").val(replaceChar(result[0].Mobile));
            $("#SEmailID").val(replaceChar(result[0].EmailID));
            $("#SURL").val(replaceChar(result[0].URL));
            var active = result[0].ActiveStatus;
            if (result[0].EmployeeID != '0' && result[0].EmployeeID != '') {
                $("#SName").val('');
                $("#SNameOrganization").val(result[0].EmployeeID);
                $("#SNameOrganization").focus();
            } else {
                $("#SNameOrganization").val('');
                $("#SName").focus();
            }
            if (active == "True") {
                $("#SActive").prop('checked', true);
            }
            else {
                $("#SActive").prop('checked', false);
            }
            $("#SAddress1").val(replaceChar(result[0].Address1));
            $("#SAddress2").val(replaceChar(result[0].Address2));
            $("#SCity").val(replaceChar(result[0].City));
            $("#SZip").val(replaceChar(result[0].Zip));
            $("#SState").val(replaceChar(result[0].State));
            $("#SCountryID").val(replaceChar(result[0].CountryID));
            $("#SNotes").val(replaceChar(result[0].Notes));
            if (result[0].CorrespondenceAddress == "True") {
                $("#SCorrecpondenceAddress").prop('checked', true);
            } else {
                $("#SCorrecpondenceAddress").prop('checked', false);
            }
            if (result[0].PrincipalContact == "True") {
                $("#SPrincipleContact").prop('checked', true);
            } else {
                $("#SPrincipleContact").prop('checked', false);
            }
        }


        $("#SNameOrganization").on("change", function () {
            ClearEmployeeDetails();
            EmployeeDetails($(this).val());
            //Added By Nikhil A on 27-Nov-2019 for Making Designation and EmailId Disable if Type is selected as organization
            $("#SDesignation").prop('disabled', true);
            $("#SEmailID").prop('disabled', true);
            //End of Added By Nikhil A on 27-Nov-2019
        });

        function EmployeeDetails(EmployeeID) {

            var intProjectID = 0;
            var isEmployeeID = 0;
            if (EmployeeID == '0') {
                intProjectID = $("#CboProject :selected").val();
            } else {
                isEmployeeID = 1;
            }
            var StakeholderDetailsParam = {
                EmployeeID: encodeURI(EmployeeID),
                IsEmployeeID: isEmployeeID,
                ProjectID: intProjectID
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_stakeholders/StakeholderEmployeeOrCustomerDetails',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(StakeholderDetailsParam),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (StakeholderDetailsParam) {
                        xhr.setRequestHeader("Params", encryptString(isJson(StakeholderDetailsParam) ? StakeholderDetailsParam : JSON.stringify(StakeholderDetailsParam)));
                    }
                },
                success: function (result) {

                    EditValues(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function EditValues(result) {
            if (result.length > 0) {
                $("#SDesignation").val(result[0].DesignationName);
                $("#Sphone1").val(result[0].Phone);
                $("#Sphone2").val(result[0].CurrentPhone);
                $("#SExt1").val(result[0].ExtensionNo);
                $("#SMobile").val(result[0].MobileNo);
                $("#SEmailID").val(result[0].EmailID);
                $('#SCountryID option').map(function () {
                    if ($(this).text() == result[0].Country) return this;
                }).attr('selected', 'selected');
                $("#SFax").val(result[0].Fax);
                $("#SAddress1").val(result[0].Address);
                $("#SAddress2").val(result[0].CurrentAddress);
                $("#SCity").val(result[0].City);
                $("#SState").val(result[0].State);
                $("#SZip").val(result[0].PinCode);
            }
        }

        function ValidateImages(objFileName) {

            isValidFile = false;
            var FileNameCharCount = "";
            var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>';
        var intActualFileSize = (objFileName.files['0'].size);
        var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>';
        var validateExtensions;
        validateExtensions = strFileExtension.split(",");
        if (strFileExtension.length > 0) {
            var allowSubmit = false;
            var file = objFileName.value;
            var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();
            for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                var strExtn;
                strExtn = validateExtensions[cnt];
                if (strExtn.toLowerCase() == extension) {

                    isValidFile = true;
                    ///*retu*/rn;
                }

            }
        }
        if (isValidFile == false) {

            isValidFile = false;
            $(objFileName).val("");
            showAlert("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!", 'alert-danger');
        }

        if (objFileName.files['0'].name != '')
            var countOfDot = objFileName.files['0'].name.split(".").length - 1;

        if (countOfDot > 1) {

            isValidFile = false;
            $(objFileName).val("");
            showAlert('<%= MyBase.GetResourceString("C_File_with_two_or_more_extensions_is_not_allowed") %>', 'alert-danger');
            return;
        }
        if (objFileName.files['0'] != null || objFileName.files['0'] != undefined) {
            if (objFileName.files['0'].name != '') {
                FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;
            }
        }

        if (FileNameCharCount != "" || FileNameCharCount != undefined || FileNameCharCount != 'undefined') {
            if (FileNameCharCount > 120) {

                isValidFile = false;
                $(objFileName).val("");
                showAlert('<%= MyBase.GetResourceString("C_File_name_should_not_exceed_120_characters") %>', 'alert-danger');
                    return;
                }
            }
            if (intActualFileSize < intMinFileSize) {

                isValidFile = false;
                $(objFileName).val("");
                showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                return;
            }

        }


        $(document).on('change', '.imageUpload', function () {

            var image = this;
            var ImageBox = $(this).parent().next().find(".imageBox");;
            if (image.files && image.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $(ImageBox).attr('src', e.target.result);
                }

                reader.readAsDataURL(image.files[0]);
            }
        });


        $('#saveCommentbtn').on('click', function () {
            SaveComment();
        });


        $('#saveCommentbtn').on('click', function () {

            var ProjectContactID = $("#ProjectContactID").val();
            var formdata = new FormData();
            var LoginType = '<%= Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var projectid = $("#CboProject").val();
        var AttachedFileData = new Array();
        var Files = new Array();
        var d = new Date();
        var month = d.getMonth() + 1;
        var day = d.getDate();

        $('.cmtImageAttach').each(function (index, value) {

            var Description = "";
            var File;
            var Date = "";
            var allColumns = $(this).find('div');
            $(allColumns).each(function (i, v) {

                console.log(this);

                if (i == 0) {
                    Description = $(this).find('textarea').val();

                }
                if (i == 1) {

                    var fileinputelement = $(this).find('input[type=file]');
                    var gerfileName = fileinputelement.files;
                    formdata.append("file" + gerfileName);
                }

                item = {
                    ProjectID: projectid,
                    Description: Description,
                    LoginType: LoginType,
                    UserName: UserName,
                    ProjectContactID: ProjectContactID
                }
                AttachedFileData.push(item);
            });
        });

        formdata.append("AttachedFileData", JSON.stringify(AttachedFileData));
        $.ajax({
            url: strUrl + '/api/PM_stakeholders/SaveAttachment',
            type: "POST",
            dataType: "json",
            data: formdata,
            contentType: false,
            processData: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
            },
            success: function (result) {
                if (result == 'file save successfully') {
                    $('.attachments').each(function (index, value) {
                        $(this).remove();
                    });

                    counterFORattachment = 0;
                    i = "1";
                    j = "1";
                    k = "1";
                    GetAttachments(ProjectContactID);
                    showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                }
                else {

                    $(".Stakeholdertbl").find("tr").removeClass("tropen");
                    $("#stakedetailpanel .detailsubtabs li:nth-child(2) a, #stakedetailpanel .detailsubtabs li:nth-child(3n) a").css("cursor", "pointer");
                    $("#stakedetailpanel").hide('fast');
                    $("#hidestaklist").show('fast');
                    showAlert(result, 'alert-danger');
                }
            },
            error: function (err) {
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
    });


        //script added by pradip on 06-11-19 for inherit contact dropdown

        /*inherit contacts dropdown*/
        function myFunction() {
           <%--Commented & Added By Dipali V On 24th March 2023 For Inherit Contact Funcationality not working--%>

            //document.getElementById("myDropdown").classList.toggle("show");
            if ($("#myDropdown").css("display") == "none") {
                $("#myDropdown").css("display", 'block');
            } else {
                $("#myDropdown").css("display", 'none');
            }
         <%--End of Commented & Added By Dipali V On 24th March 2023 For Inherit Contact Funcationality not working--%>

        }

        function filterFunction() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            div = document.getElementById("myDropdown");
            a = div.getElementsByTagName("li");
            for (i = 0; i < a.length; i++) {
                txtValue = a[i].textContent || a[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }

        // save client into stakeholder
        $("#btninheritcontctok").click(function () {
            if (CheckProjectIsSelect()) {
                StartLoader("#bodystakeholder");
                var chkckedcount = 0;
                var successcount = 0;
                var ClientIds = '';
                $("#ulinheritcontct").find("li .chcktbl").each(function (index, chk) {
                    if (chk.checked) {
                        if (chkckedcount == 0) {
                            ClientIds = chk.value;
                        } else {
                            ClientIds = ClientIds + ',' + chk.value;
                        }
                        chkckedcount++;
                    }
                });
                if (chkckedcount == 0) {
                    showAlert('<%= MyBase.GetResourceString("C_InheriteContact_PleaseSelectInheriteContact") %>', 'alert-danger');
            } else {
                var objstakeholdersprojectcontactforclient = {
                    ClientIDs: ClientIds,
                    ProjectID: $("#CboProject").val(),
                    CreatedBy: '<%= Session("strUserName") %>',
                    ModifiedBy: '<%= Session("strUserName") %>'
                }
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/SaveStakeholderProjectContactsForClient',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(objstakeholdersprojectcontactforclient),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (objstakeholdersprojectcontactforclient) {
                            xhr.setRequestHeader("Params", encryptString(isJson(objstakeholdersprojectcontactforclient) ? objstakeholdersprojectcontactforclient : JSON.stringify(objstakeholdersprojectcontactforclient)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        if (parseInt(result) > 0) {
                            fillclientsforsavestakeholder();
                            myFunction();
                            StakeholderDefaultFilter();
                            showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                        } else {
                            showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
           <%-- if (successcount == chkckedcount && chkckedcount > 0) {
                
            } else {
                 showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
            }--%>
            }
            StopAjaxLoader("#bodystakeholder");
        }
    });

        //checkall_filter_section
        $(document).on("change", ".inheritcontct-dropdown .chckHead", function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(this).closest(".inheritcontct-dropdown").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", true);

                });
            } else {
                $(this).closest(".inheritcontct-dropdown ").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", false);

                });
            }
        });

        //close inherit contact dropdown
        $(document).on("click", function (event) {
            var $trigger = $(".inheritcontct-dropdown");
            if ($trigger !== event.target && !$trigger.has(event.target).length) {
                $("#myDropdown").removeClass("show");
            }
        });


        $(document).on("change", ".inheritcontct-dropdown .chcktbl", function () {
            var checkedtbl = $(this).is(':checked');
            if (checkedtbl) {
                var allchkchecked = 0;
                var allchk = 0;
                $(this).closest(".inheritcontct-dropdown ").find("ul .chcktbl").each(function (index, chk) {
                    if ($(chk).is(':checked')) {
                        allchkchecked++;
                    }
                    allchk++;

                });
                if (allchkchecked == allchk) {
                    $(this).closest(".inheritcontct-dropdown ").find(".chckHead").prop("checked", true);
                }
            }
            else {
                $(this).closest(".inheritcontct-dropdown ").find("ul .chcktbl").each(function () {
                    $(this).closest(".inheritcontct-dropdown ").find("ul .chckHead").prop("checked", false);
                });
            }
        });
        //end script

        //Added by pradip on 09-04-2020
        function myFunctionUI() {
            // Declare variables
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("serchstakholders");
            filter = input.value.toUpperCase();
            table = document.getElementById("tbl_wrapper");
            tr = table.getElementsByTagName("tr");
          
            var curQueryText = 'd_tbl_PM_ProjectContacts.Name Like "%' + filter + '%"';
            //Added By Dipali V On 16th Dec 2021 For 16th Dec 2021 For if no filter then clear all link should not come
            if (filter.trim() == "") {
                curQueryText = null;
            }
            //End of Added By Dipali V On 16th Dec 2021 For 16th Dec 2021 For if no filter then clear all link should not come
            fillTableData(curQueryText);

            //End Of Added By Usha Pandit On 04.01.2020 For Search Filter Issue
        }

        //Added By Rutuja D. on 3 Jan 2021 For Filter crash was coming because of single quotes added in text field
        function GenerateBasicFilterQuery(module, AllFields) {
            var strqtext = "";
            for (var i = 0; i < AllFields.length; i++) {
                var strvalue = '';
                var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();
                if ($("#txt" + module + "Filter" + AllFields[i]).val() != null) {
                    strvalue = $("#txt" + module + "Filter" + AllFields[i]).val().trim();
                }

                //Commented and added by imran on 20-12-2021
                //if (strvalue != "" && strvalue != "0" && strvalue != null && strvalue != "null") {
                if (strvalue != "" && strvalue != null && strvalue != "null") {
                    //End Comment by imran on 2012-2021

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
                        strqtext += AllFields[i] + " = ";
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
            }
            strqtext = strqtext.replace(/'/g, "''");
            return strqtext;
        }
        //End of Added By Rutuja D. on 3 Jan 2021 For Filter crash was coming because of single quotes added in text field

        //Added By Rutuja D. on 23 Dec 2021 for Client Onchange Name is not display
        function ClientOnchange() {
           
            var client = $("#SClientID").val();
            if (client != "") {
                $.ajax({
                    url: strUrl + '/api/PM_stakeholders/GetClientContactPerson',
                    method: 'Post',
                    data: JSON.stringify(client),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (client) {
                            xhr.setRequestHeader("Params", encryptString(isJson(client) ? client : JSON.stringify(client)));
                        }
                    },
                    success: function (result) {

                        for (var i = 0; i < result.length; i++) {
                            $("#SName").val(result[i]["ContactPerson"]);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            } else {
                $("#SName").val('');
            }
        }

        //Added by Parth.G
        //commented by Aditya J. on 25-11-2024
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
        //End of comment by Aditya J. on 25-11-2024
        //Ended by Parth.G


        //End of Added By Rutuja D. on 23 Dec 2021 for Client Onchange Name is not display
        function stopPropagation(evt) {
            if (evt.stopPropagation !== undefined) {
                evt.preventDefault();
                evt.stopPropagation();
            } else {
                evt.cancelBubble = true;
          }
        }
        function thdFltr(e) {

            stopPropagation(evt);
            e.stopPropagation();
        }





    </script>
    
    <%--added by Vishal Mahajan 12-11-2019--%>
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1"></script>

<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <%--end--%>
</body>
</html>

