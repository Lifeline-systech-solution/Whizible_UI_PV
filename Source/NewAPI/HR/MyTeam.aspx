<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyTeam.aspx.vb" Inherits="PbNIT.MyTeam" %>


<!DOCTYPE html>
<html>

<%CommonFunctions.General.PlotPageHeadTag("My Team")%>
<head>
 
    <!-- Commented by Gauri on 19/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>My Team</title> -->
    <!-- Tell the browser to be responsive to screen width -->
    <!-- <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1"> -->
    <!-- bootstrap select -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2"> -->
    <!-- Font Awesome -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2"> -->
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2"> 
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <!-- <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />  -->
     
</head>

<style type="text/css">
            /* / css Added by Madhuri.K content 03-Sep-2024 / */
           #tableCalVeiw thead tr td{
    position: sticky;
    top: 0;
    z-index: 9;
    background: #e7edf0;
}
             .PRrolename a.projectCRmenu {
             background: none;
                 border: none;
         }
             ul.dropdownlinks li a {
                color: #1359a6 !important;
                background-color: #fff !important;
            }
            ul.dropdownlinks li:hover a{
                background-color: #e7edf0 !important;
            }
                /* / css Added by Madhuri.K content 03-Sep-2024 / */

    .PRrolename a.projectCRmenu {
    border: none;
}
    th.sorting_disabled::after, th.sorting_disabled::before{display:none!important;}
     .spntotal {
         float: right;
     }
     /*Added by imran on 02-08-2022 */
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

     .clsShowHide {
         display: none !important;
     }
     /*End by imran on 02-08-2022 */

     /* .alertify-notifier .ajs-message.ajs-error{
 color: #000;
 background: rgb(179, 45, 0);
 text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
 }*/
     .dataTables_scrollBody thead tr[role="row"] {
         visibility: collapse !important
     }

     a.clearalllink {
         font-weight: 700;
         margin: 7px 0 0 8px;
         display: none
     }

     .filter.float-end {
         margin: 2px 0 0 8px
     }

     table tr th {
         vertical-align: middle !important
     }

         table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
             margin-right: 0
         }

     .notebox {
         padding: 10px;
         margin-bottom: 10px;
         border-radius: 4px
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
         width: 0
     }

     .dropdown-submenu > .dropdown-submenu:hover a:after {
         border-color: transparent transparent transparent #464a4c
     }

     h5.pgtitle {
         margin: 6px 0 0;
         font-weight: 700;
         color: #4263c1;
         font-size: 16px
     }

     .dblock {
         display: block
     }

     /*New css end here*/

     .lightgraybg {
         background: #f5f5f5
     }

     .informationtbl {
         margin-bottom: 15px
     }

         .informationtbl tr th {
             text-align: right;
             font-weight: 500
         }

     body .informationtbl tr td {
         text-align: left
     }

     .informationtbl th, .informationtbl td {
         padding: 2px 4px
     }

     body .informationtbl tr td.pr-3 {
         padding-right: 3em
     }

     table.informationtbl {
         width: 100%
     }

     td.Agpm {
         color: #eb1c24
     }

     .togglerup .collapseup {
         display: block
     }

     .togglerup .collapsedown {
         display: none
     }

     .togglerdown .collapsedown {
         display: block
     }

     .togglerdown .collapseup {
         display: none
     }

     .infoToggler {
         margin: 5px 0 0
     }

     .hideprofitabilityinfo {
         position: absolute;
         right: 10px
     }

     .profitabilityinfopanel .panel.panel-default {
         padding: 0;
         position: relative
     }

     .profitabilityinfopanel .panel-default > .panel-heading {
         padding-right: 35px;
         background: #e7edf0
     }

         .profitabilityinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus {
             color: #464a4c
         }

         .profitabilityinfopanel .panel-default > .panel-heading a span img {
             opacity: .5
         }

             .profitabilityinfopanel .panel-default > .panel-heading a span img:hover {
                 opacity: 1
             }
     /*Information table End here*/
     .clsShowHide {
         display: none !important;
     }

     .informationtbl td, .informationtbl th {
         vertical-align: top !important;
         font-size: 14px;
         line-height: normal
     }

     .informationtbl tr th {
         min-width: 120px
     }

     .table-stripped tbody tr.totalrow {
         background: #ccc
     }

     .innerpgsection {
         clear: both;
         display: flex
     }


     /*legends*/
     .legend {
         background: #fff;
         background: rgba(255,255,255,0.8);
         padding: 5px 0 0;
         border: none
     }

         .legend ul {
             list-style-type: none;
             margin: 0;
             padding: 0;
             overflow: hidden
         }

         .legend li {
             float: left;
             margin-left: 5px
         }

             .legend li:first-child {
                 margin-left: 0
             }

         .legend span {
             display: inline-block;
             width: 22px;
             height: 15px;
             margin-right: 0;
             border: 1px solid #ddd;
         }

     /*simple pagination style*/
     .simple-pagination {
         display: inline-block;
         padding-left: 0;
         margin-top: 1rem;
         margin-bottom: 1rem;
         border-radius: .25rem
     }

         .simple-pagination li {
             display: inline
         }

         .simple-pagination .page-link, .simple-pagination .ellipse, .simple-pagination .current {
             display: inline-block;
             position: relative;
             float: left;
             padding: .5rem .75rem;
             margin-left: -1px;
             color: #0275d8;
             text-decoration: none;
             background-color: #fff;
             border: 1px solid #ddd
         }

         .simple-pagination li:first-child .page-link {
             margin-left: 0;
             border-bottom-left-radius: .25rem;
             border-top-left-radius: .25rem
         }

         .simple-pagination li:last-child .page-link {
             border-bottom-right-radius: .2rem;
             border-top-right-radius: .2rem
         }

         .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
             z-index: 2;
             color: #fff;
             cursor: default;
             background-color: #0275d8;
             border-color: #0275d8;
             background: #1359ac
         }
     /*End of pagination style*/
     .tdlgdHoliday {
         background: #f5f5f5;
         position: relative
     }

     td.tdlgdHoliday::before {
         background: red
     }

     .tdlgdWFH {
         background: #eee
     }

     td.tdlgdWFH::before {
         background: #81cf09
     }

     .tdlgdLeave {
         background: #eee
     }

     td.tdlgdLeave::before {
         background: #f0f
     }

     .tdlgdHalfday {
         background: #eee
     }

     td.tdlgdHalfday::before {
         background: #9370d8
     }

     .tdlgdPD {
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     td.tdlgdPD::before {
         background: none
     }

     .tdlgdPH {
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     td.tdlgdPH::before {
         background: #eb1c24
     }

     .tdlgdPWFM {
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     td.tdlgdPWFM::before {
         background: #81cf09
     }

     .tdlgdPL {
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     td.tdlgdPL::before {
         background: #f0f
     }

     .tdlgdPHD {
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     td.tdlgdPHD::before {
         background: #9370d8
     }

     td.tdlgdHoliday, td.tdlgdWFH, td.tdlgdLeave, td.tdlgdHalfday, td.tdlgdPlannedday, td.tdlgdPH, td.tdlgdPWFM, td.tdlgdPL, td.tdlgdPHD {
         position: relative
     }

         td.tdlgdHoliday::before, td.tdlgdWFH::before, td.tdlgdLeave::before, td.tdlgdHalfday::before, td.tdlgdPlannedday::before, td.tdlgdPH::before, td.tdlgdPWFM::before, td.tdlgdPL::before, td.tdlgdPHD::before {
             position: absolute;
             width: 2px;
             height: 96%;
             top: 1px;
             content: "";
             left: 0
         }
     /*end legends*/
     .dropdown-menu > li > a:hover {
         background-color: #e1e3e9;
         color: #333
     }

     .table-fixed-header thead tr th, .table thead tr th {
         padding-top: 6px;
         padding-bottom: 6px
     }

     .calviewTbl tr th:first-child {
         min-width: 200px
     }

     .modal-body {
         padding: 30px !important
     }

     .mb-1 {
         margin-bottom: 10px
     }

     ul.dropdownlinks li:hover a, ul.dropdownlinks li a {
         padding: 5px 10px
     }

     span.checkmark {
         color: #9dd824
     }

     .filterpanelbody > .row > div:nth-child(5n), .filterpanelbody > .row > div:nth-child(6n), .filterpanelbody > .row > div:nth-child(7n) {
         width: 50%
     }

     .lgdHoliday {
         background: #eee;
         border-left: 1px solid red !important
     }

     .lgdWFH {
         background: #eee;
         border-left: 2px solid #81cf09 !important
     }

     .lgdLeave {
         background: #eee;
         border-left: 2px solid #f0f !important
     }

     .lgdHalfday {
         background: #eee;
         border-left: 2px solid #9370d8 !important
     }

     .lgdPlannedday {
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     .lgdPH {
         border-left: 2px solid red !important;
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     .lgdPWFM {
         border-left: 2px solid #81cf09 !important;
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     .lgdPL {
         border-left: 2px solid #f0f !important;
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     .lgdPHD {
         border-left: 2px solid #9370d8 !important;
         background-image: repeating-linear-gradient(45deg,#fff,#dfecff 1px,#fff 3px,#fff 4px);
         background-size: 50px 50px
     }

     td.resrsmain.text-start {
         background: #e7edf0;
         font-weight: 700
     }

     #tableCalVeiw {
         border-collapse: inherit
     }

         #tableCalVeiw thead {
             position: sticky;
             top: 0;
             z-index: 9;
             background: #e7edf0
         }

     .modal .dataTables_scrollHeadInner {
         width: 100% !important
     }

     #RUtbl_wrapper table, #proallmodalTbl_wrapper table, #leaveDtlmodalTbl_wrapper table, #skillDtlmodalTbl_wrapper table {
         width: 100% !important
     }

     #inprogressgridTbl_wrapper .dataTables_scrollBody {
         overflow-x: hidden !important
     }

     #TskdetailgridTbl_wrapper .dataTables_scrollBody {
         overflow-x: hidden !important
     }

     #RC_proallocationTbl_wrapper tr th:first-child {
         min-width: 100px
     }

     .calviewTbl td > a {
         font-weight: 500;
         font-size: 12px !important;
         min-width: 24px;
         display: block;
     }

     .calviewTbl > tbody > tr > td, .calviewTbl > tbody > tr > th, .calviewTbl > tfoot > tr > td, .calviewTbl > tfoot > tr > th, .calviewTbl > thead > tr > td, .table > thead > tr > th {
         padding: 4px
     }
     /*New css applied after change version*/
     .tblmnthname {
         text-align: center;
         font-weight: 600;
     }

     .PRrolename a.projectCRmenu {
         background: none;
     }

         .PRrolename a.projectCRmenu::after {
             display: none;
         }

         .PRrolename a.projectCRmenu:focus, .PRrolename a.projectCRmenu:hover,
         .btn.projectCRmenu.active:focus-visible, .btn.projectCRmenu.show:focus-visible, .btn.projectCRmenu:first-child:active:focus-visible, :not(.btn-check) + .btn.projectCRmenu:active:focus-visible {
             background: none;
             border: none;
             outline: none;
             box-shadow: none;
         }

     .form-inline .form-select {
         display: inline-block;
         width: 160px;
     }

     .voidrow td:first-child {
         box-shadow: inset 2px 0px 0px 0px #eb1c24;
     }

     .onholdrow td:first-child {
         box-shadow: inset 2px 0px 0px 0px #4263c1;
     }

     .voidrow td {
         background: #f8d7da57;
     }

     .onholdrow td {
         background: #4263c112;
     }

     select.form-select.input-sm {
         height: 33px;
     }

     .cust_tabpanel .nav-tabs > li > a:focus, .cust_tabpanel .nav-tabs > li > a.active {
         background: #1359ac;
         color: #fff;
     }

     .table thead tr th.thHoliday {
         color: #eb1c24;
     }
     /*.calviewTbl thead tr:nth-child(3) th.thHoliday {color: #464a4c;}*/
     .dataTables_scrollBody table {
         width: 100% !important;
     }

    /* .PLNdividerline {
         display: block;
         margin: 0px 0px;
         padding: 0;
         height: 0px;
         border-bottom: 1px solid #ccc;
     }*/
 </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed" id="PlannedvsActual1">

     <%--Added by imran on 02-08-2022--%>
    <div id="PlannedvsActual" class="preloader"> </div>
    <%--End by imran on 02-08-2022--%>

    <div class="bgwhite PlannedvsActuald clsShowHide">

        <div class="col-sm-12 pt-1 pb-1 text-end graybg px-3" style="overflow:hidden;">
            <h5 class="pgtitle float-start text-start"><%= MyBase.GetResourceString("MyTeam") %></h5>
            <a href="javascript:;" class="clearalllink" style="display:none;" onclick="clearAll()" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" id="AdvanceFilterIcon" title="Filter" autocomplete="off"><i class="fas fa-filter" style="font-size:15px;"></i></button>
            </div>
            <div class="clearfix"></div>
        </div>


        <div class="innerpgiframe">
            <!--filter panel-->
            <div class="clearfix"></div>
            <div id="filterpanel" class="filterpanel collapse">
                <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                    <div class="cust_tabpanel">
                        <ul class="nav nav-tabs">
                            <li class="nav-item">
                                <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true" class="nav-link"><%= MyBase.GetResourceString("Filters") %></a>
                            </li>
                        </ul>
                    </div>
                    <div class="Fwrapper">
                        <div class="tab-content">
                            <div id="basicfilters" class="tab-pane">
                                <div class="notebox graybg mt-3"><small><strong><%= MyBase.GetResourceString("Note") %> :</strong> <%= MyBase.GetResourceString("Note") %></small></div>
                                <div class="filterpanelbody">
                                    <div class="text-center hidden-xs centerbtn">
                                        <button class="btn btnyellow" onclick="ApplyFilter()"><%= MyBase.GetResourceString("Apply") %></button>
                                    </div>
                                    <br />

                                    <div class="row mb-3">
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("Resource") %></label>
                                            <div class="col-sm-8">                                               
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtResource", "txtResource", "form-control input-sm",, 100,,,, ,,,, "autocomplete='off'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("Role") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Exec usp_sel_whizible2_tbl_PM_Role_Role",,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("Designation") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "Exec usp_sel_whizible2_tbl_PM_DesignationMaster_Designation",,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("Skill") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "Exec usp_sel_whizible2_tbl_PM_Tools_Skill",,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("BusinessGroup") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboBG", "Exec usp_sel_whizible2_tbl_PM_Employee_BusinessGroup " & Session("intUserID"),,, "class='form-select input-sm' onChange='javascript:BG_onChange(this.value);'", False,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("OrganizationUnit") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboOU", "Exec usp_sel_whizible2_tbl_PM_Location_OrganizationUnit Null," & Session("intUserID"),,, "class='form-select input-sm' onChange='javascript:OU_onChange(this.value);'", False,, ) %>
                                            </div>
                                        </div>
                                        
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("DeliveryUnit") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_sel_whizible2_DeliveryUnits null,null," & Session("intUserID"),,, "class='form-select input-sm' onChange='javascript:DU_onChange(this.value);'", False,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("DeliveryTeam") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDT", "Exec usp_sel_whizible2_tbl_PM_GroupMaster_DeliveryTeam null,null,null," & Session("intUserID"),,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("EmployeeType") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboEmployeeType", "Exec usp_Sel_whizible2_tbl_RTS_ProjectSpecificControlData_Employeetype 'EmployeeType'",,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>
                                        
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("Department") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "Exec usp_sel_whizible2_tbl_pm_Departmentmaster_Department",,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("Deployable") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "Exec usp_sel_whizible2_Deployable",,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("ResourcePool") %></label>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboResourcePoolID", "Exec usp_sel_whizible2_tbl_PM_ResourcePoolMaster_ResourcePool " & Session("intUserID"),,, "class='form-select input-sm'", False,, ) %>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row mb-3">                                        
                                        <div class="col-sm-4 row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("MyTeam") %></label>
                                            <div class="col-sm-8">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="myteamIDchk">
                                                    <label for="myteamIDchk"></label>
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
            <div class="clearfix"></div>
            <div class=" container-fluid pt-1 pb-1">
                <div class="row">
                    <div class="col-sm-4 form-inline">
                        <div class="form-group">
                            <span><%= MyBase.GetResourceString("Month") %><% CommonFunctions.HTMLControls.DrawTextBox("txtMonth", "txtMonth", "form-control input-sm ", 60, 2,,,, ,,,, " onkeypress='return Field_OnKeyPress(event)' autocomplete='off'", ,, True,,,,) %></span>
                            <span><%= MyBase.GetResourceString("Year") %> <% CommonFunctions.HTMLControls.DrawTextBox("txtYear", "txtYear", "form-control input-sm ", 60, 4,,,, ,,,, " onkeypress='return Field_OnKeyPress(event)' autocomplete='off'", ,, True,,,,) %></span>
                            <span class="pl-1"><button class="btn btnyellow" onclick="Show()"><%= MyBase.GetResourceString("Show") %></button></span>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        &nbsp;
                    </div>
                    <div class="col-sm-4 text-end">
                        <div class="legend float-end">
                            <ul class="">
                                <li><label><%= MyBase.GetResourceString("Legends") %></label></li>
                                <li><span class="lgdHoliday" data-bs-toggle="tooltip" title="Holiday" data-bs-container="body"></span></li>
                                <li><span class="lgdWFH" data-bs-toggle="tooltip" title="Work From Home" data-bs-container="body"></span></li>
                                <li><span class="lgdLeave" data-bs-toggle="tooltip" title="Leave" data-bs-container="body"></span></li>
                                <li><span class="lgdHalfday" data-bs-toggle="tooltip" title="Half Day" data-bs-container="body"></span></li>
                                <li><span class="lgdPlannedday" data-bs-toggle="tooltip" title="Planned Day" data-bs-container="body"></span></li>

                                <li><span class="lgdPH" data-bs-toggle="tooltip" title="Planned and Holiday" data-bs-container="body"></span></li>
                                <li><span class="lgdPWFM" data-bs-toggle="tooltip" title="Planned And Work From Home" data-bs-container="body"></span></li>
                                <li><span class="lgdPL" data-bs-toggle="tooltip" title="Planned And Leave" data-bs-container="body"></span></li>
                                <li><span class="lgdPHD" data-bs-toggle="tooltip" title="Planned And Half Day" data-bs-container="body"></span></li>
                            </ul>
                        </div>
                    </div>


                </div>

            </div>

            <div class="content pt-0">
                <div class="tablewrapper">
                    <table id="tableCalVeiw" class="table table-bordered calviewTbl paginated">
                        <thead id="BodytableCalVeiw"/>
                        <tbody id="pginatebody"/>
                    </table>
                </div>
               <div class="row" style="margin-top: 5px">

                    <div class='buttons col-sm-10' style="width: 90%; margin-top:10px;">
                        <span class="spntotal" id="TotalRecords"></span>
                        <span id="" class="spntotal"><%= MyBase.GetResourceString("TotalRecords") %></span>
                    </div>

                    <div class='buttons col-sm-2' style="width: 10%" id="Pagination">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-end">
                                <li class="page-item" id="btnprevious">
                                    <a class="page-link" aria-label="Previous" onclick='PrevList()' title="Previous" id="LinkPrevious">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>
                                <li class="page-item" id="btnnext">
                                    <a class="page-link" aria-label="Next" onclick='NextList()' title="Next" id="LinkNext">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div id="pagination2" class="float-end"></div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="clearfix"></div>


        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("SaveFilterAs") %> </h5>
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
                                            <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("FilterName") %></label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow float-start"><%= MyBase.GetResourceString("Save") %></button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end"><%= MyBase.GetResourceString("Cancel") %></button>
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
        <!-- Show all details Modal start here-->
        <div class="modal custmodal fade" id="showalltaskmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("InProgressTasks") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="InProgressTasksclear()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">

                        <div class="form-inline row mb-1">
                            <div class="form-group col-sm-5">
                                <label><%= MyBase.GetResourceString("ProjectName") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtInProgressProjectID", "txtInProgressProjectID", "form-control",, 100,,,, ,,,, "autocomplete='off'", ,, True,,,,) %>
                            </div>
                            <div class="form-group col-sm-5">
                                <label><%= MyBase.GetResourceString("TaskType") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectTaskTypeID", "Exec usp_sel_Whizible2_PlanVsActual_TaskTypes",,, "class='form-select input-sm' onChange='javascript:cboInProgressTasks_OnChange(this.value);'", False,, ) %>
                            </div>
                        </div>
                        <div class="pt-1 pb-1">
                            <div class="float-start"><strong><%= MyBase.GetResourceString("TasksDetailsFor") %></strong> <span id="TaskEmployeeName"></span></div>
                            <div class="float-end"> <b><%= MyBase.GetResourceString("FromDate") %> </b> <span id="TaskFromDate"></span> &nbsp; <b><%= MyBase.GetResourceString("To") %> &nbsp;</b> <span id="TaskToDate"></span> </div>
                            <div class="clearfix"></div>
                        </div>

                        <strong><%= MyBase.GetResourceString("InProgressTasks") %></strong>
                        <div class="table-responsive">
                            <table id="inprogressgridTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("TaskName") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedEndDate") %></th>
                                        <th><%= MyBase.GetResourceString("ActualStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("ActualEndDate") %></th>
                                        <th><%= MyBase.GetResourceString("Work") %></th>
                                        <th><%= MyBase.GetResourceString("ActualHrs") %></th>
                                        <th><%= MyBase.GetResourceString("ActualTillDate") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyinprogressgridTbl"> 
                                </tbody>
                            </table>
                        </div>

                        <strong><%= MyBase.GetResourceString("NotStartedTasks") %></strong>
                        <div class="table-responsive">
                            <table id="innotstartedtasksgridTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("TaskName") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedEndDate") %></th>
                                        <th><%= MyBase.GetResourceString("ActualStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("ActualEndDate") %></th>
                                        <th><%= MyBase.GetResourceString("Work") %></th>
                                        <th><%= MyBase.GetResourceString("ActualHrs") %></th>
                                        <th><%= MyBase.GetResourceString("ActualTillDate") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodynotstartedtasksgridTbl">
                                </tbody>
                            </table>
                        </div>

                        <strong><%= MyBase.GetResourceString("CompletedTasks") %></strong>
                        <div class="table-responsive">
                            <table id="incompletedtasksgridTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("TaskName") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedEndDate") %></th>
                                        <th><%= MyBase.GetResourceString("ActualStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("ActualEndDate") %></th>
                                        <th><%= MyBase.GetResourceString("Work") %></th>
                                        <th><%= MyBase.GetResourceString("ActualHrs") %></th>
                                        <th><%= MyBase.GetResourceString("ActualTillDate") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodycompletedtasksgridTbl">
                                </tbody>
                            </table>
                        </div>

                        <p>Activities marked as <font color="red">RED</font> are Void and <font color="blue">BLUE</font> are OnHold</p>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Show all details Modal End here-->
        <!-- Resource Utilization details Modal start here-->
        <div class="modal custmodal fade" id="ProRsrsUtilizationmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("ResourceUtilization") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="ResourceUtilizationclear()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <div class="form-inline pb-1">
                            <div class="float-start"><strong><%= MyBase.GetResourceString("Period") %></strong> <strong id="txtPeriodName"></strong></div>
                            <div class="float-end">
                                <div class="form-group">
                                    <label><%= MyBase.GetResourceString("Period") %></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPeriod", "Exec usp_sel_Whizible2_DateRange_For_ResourceUtilization", 200,, "class='form-select input-sm' onChange='javascript:cboResourceUtilization_OnChange(this.value);'", False,, ) %>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="table-responsive">
                            <table id="RUtbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("Month") %></th>
                                        <th><%= MyBase.GetResourceString("Resource") %></th>
                                        <th><%= MyBase.GetResourceString("Hrs") %></th>
                                        <th><%= MyBase.GetResourceString("Hrs") %></th>
                                        <th><%= MyBase.GetResourceString("%") %></th>
                                        <th><%= MyBase.GetResourceString("Hrs") %></th>
                                        <th><%= MyBase.GetResourceString("%") %></th>
                                        <th><%= MyBase.GetResourceString("Hrs") %></th>
                                        <th><%= MyBase.GetResourceString("%") %></th>
                                        <th><%= MyBase.GetResourceString("Hrs") %></th>
                                        <th><%= MyBase.GetResourceString("%") %></th>
                                    </tr>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th><%= MyBase.GetResourceString("InstallCapacity") %></th>
                                        <th colspan="2"><%= MyBase.GetResourceString("Available") %></th>
                                        <th colspan="2"><%= MyBase.GetResourceString("Planned") %></th>
                                        <th colspan="2"><%= MyBase.GetResourceString("Actual") %></th>
                                        <th colspan="2"><%= MyBase.GetResourceString("Billable") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyRUtbl"> 
                                </tbody>
                            </table>
                        </div>
                        <%--<div class="text-center"><a href="javascript:;" class="btn borderbtn">Print</a></div>--%>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Resource Utilization details Modal End here-->
        
        <!-- Project Allocation details Modal start here-->
        <div class="modal custmodal fade" id="Proallocationmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("ProjectAllocation") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="ProjectAllocationclear()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <div class="form-horizontal pb-1 row">
                            <div class="form-group row mb-3">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("ProjectName") %></label>
                                        <div class="col-sm-8">
                                           <% CommonFunctions.HTMLControls.DrawTextBox("txtProjectAllocationProjectName", "txtProjectAllocationProjectName", "form-control",, 100,,,, ,,,, "autocomplete='off'", ,, True,,,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("ReportingTo") %></label>
                                        <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtProjectAllocationReportingTo", "txtProjectAllocationReportingTo", "form-control",, 100,,,, ,,,, "autocomplete='off'", ,, True,,,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group row mb-3">
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("Billable") %></label>
                                        <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectAllocationBillable", "Exec usp_Sel_Whizible2_ProjectAllocation_BillabeYesNo",,, "class='form-select input-sm' onChange='javascript:ProjectAllocationBillable_OnChange(this.value);'", False,, ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row">
                                        <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("Active") %></label>
                                        <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectAllocationActive", "Exec usp_Sel_Whizible2_ProjectAllocation_ActiveYesNo",,, "class='form-select input-sm' onChange='javascript:ProjectAllocationActive_OnChange(this.value);'", False,, ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <p class="mb-0"><strong><%= MyBase.GetResourceString("Resource") %> : </strong> <span id="ProjectAllocationUserName"></span> <span id="ProjectAllocationRoleDesc"></span></p>
                        <div class="table-responsive">
                            <table id="proallmodalTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("Role") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("PlannedEndDate") %></th>
                                        <th><%= MyBase.GetResourceString("ReportingTo") %></th>
                                        <th><%= MyBase.GetResourceString("Billable") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyproallmodalTbl"> 
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Project Allocation details Modal End here-->
        
        <!-- Skill details Modal start here-->
        <div class="modal custmodal fade" id="Skilldetailmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("SkillDetails") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">              
                        <div class="pb-1 form-inline">
                            <div class="float-start">
                                <p><strong><%= MyBase.GetResourceString("SkillDetails") %></strong></p>
                            </div>
                            <div class="float-end text-end"><p class="mb-0"><strong><%= MyBase.GetResourceString("Resource") %></strong> <span id="skillUserName"></span> <span id="skillRoleDesc"></span></p></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                        <table id="skillDtlmodalTbl" class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th class="text-start"><%= MyBase.GetResourceString("SkillCategory") %></th>
                                    <th><%= MyBase.GetResourceString("Skill") %></th>
                                    <th><%= MyBase.GetResourceString("Proficiency") %></th>
                                    <th><%= MyBase.GetResourceString("Experience") %></th>
                                </tr>
                            </thead>
                            <tbody id="BodyskillDtlmodalTbl">                              
                            </tbody>
                        </table>
                        <div class="clearfix"></div>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Skill details Modal End here-->
        
        <!-- Leave balance Modal start here-->
        <div class="modal custmodal fade" id="Leavbalmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("LeaveDetail") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <div class="pb-1 form-inline">
                            <div class="float-end text-end"><p class="mb-0"><strong><%= MyBase.GetResourceString("Resource") %></strong> <span id="LeaveUserName"></span> <span id="LeaveRoleDesc"></span></p></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="table-responsive">
                            <table id="leaveDtlmodalTbl" class="table table-stripped table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("LeaveType") %></th>
                                        <th><%= MyBase.GetResourceString("LeavesTakenInFinancialyear") %></th>
                                        <th><%= MyBase.GetResourceString("LeaveEntitlement") %></th>
                                        <th><%= MyBase.GetResourceString("LeaveBalance") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyleaveDtlmodalTbl">                                  
                                </tbody>
                            </table>
                        </div>
                        <div class="leavcount">
                            <p class="mb-2"><strong><%= MyBase.GetResourceString("MonthlyLeaveCount") %></strong></p>
                            <table id="leavecountTbl" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("Apr") %></th>
                                        <th><%= MyBase.GetResourceString("May") %></th>
                                        <th><%= MyBase.GetResourceString("Jun") %></th>
                                        <th><%= MyBase.GetResourceString("Jul") %></th>
                                        <th><%= MyBase.GetResourceString("Aug") %></th>
                                        <th><%= MyBase.GetResourceString("Sep") %></th>
                                        <th><%= MyBase.GetResourceString("Oct") %></th>
                                        <th><%= MyBase.GetResourceString("Nov") %></th>
                                        <th><%= MyBase.GetResourceString("Dec") %></th>
                                        <th><%= MyBase.GetResourceString("Jan") %></th>
                                        <th><%= MyBase.GetResourceString("Feb") %></th>
                                        <th><%= MyBase.GetResourceString("Mar") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyleavecountTbl">                                
                                </tbody>
                            </table>
                        </div>

                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <!-- Leave balance Modal End here--> 
        <div class="clearfix"></div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->

    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
    <!-- jqueryUI js -->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>
    <!-- <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/CommonLoader.js"></script>

    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserId = '<%= Session("intUserID") %>';       
        var UserName = '<%= Session("strUserName") %>';
        var ProjectId = '<%= Session("intProjectID") %>';
        var intNoOfDaysInWeek = '<%=intNoOfDaysInWeek %>';
        var intStartingDayOfWeek = '<%=intStartingDayOfWeek %>';
        var CompanyHolidays = '<%=CompanyHolidays %>';
        var CompanyHolidays1 = [];
        var ajaxResult;
        var TotalRecords = 0;
        var intPageNo = 1;
        var PageSize = 10;
        var SearchRecords = "0";
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        var AllFields = ["Resource", "Role", "Designation", "Skill", "BG", "OU", "DU", "DT", "EmployeeType", "Department", "Deployable","ResourcePoolID"];

        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });

        $(document).ready(function ()
        {
            $('.btn').tooltip({ trigger: 'hover' });
             
            CompanyHolidays1 = CompanyHolidays.split(",");

            //StartLoader("#PlannedvsActual1");
            var Result = AJAXCallWithResult("/api/PlannedVSActual/GetCurrentMonthYear", '', false);
            Result = Result.split("~");
            $("#txtMonth").val(Result[0]);
            $("#txtYear").val(Result[1]);
            //CompanyHoliday(intNoOfDaysInWeek, intStartingDayOfWeek);

            TBodyHeadFill();
            
            $("#PlannedvsActual").removeClass("center");
            $("#PlannedvsActual").removeClass("preloader");
            $(".PlannedvsActuald").removeClass('clsShowHide'); 

            $(".PRrolename").on("click", ".projectCRmenu", function () {
                $(".PRrolename").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
                $(this).closest("td").find(".dropdown-menu, .dropdown-toggle").addClass("show");
            });              
        });

        function CompanyHoliday(intNoOfDaysInWeek, intStartingDayOfWeek) {
            //alert(intNoOfDaysInWeek + ' ' + intStartingDayOfWeek);

            switch (intStartingDayOfWeek) {
                case 0:
                    day = "Sunday";
                    break;
                case 1:
                    day = "Monday";
                    break;
                case 2:
                    day = "Tuesday";
                    break;
                case 3:
                    day = "Wednesday";
                    break;
                case 4:
                    day = "Thursday";
                    break;
                case 5:
                    day = "Friday";
                    break;
                case 6:
                    day = "Saturday";
            }
        }

        //datatable
        $('#RUtbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#proallmodalTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#leaveDtlmodalTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#inprogressgridTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 3,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#skillDtlmodalTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#RC_proallocationTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 5,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });
        $('#TskdetailgridTbl').dataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 3,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
        });

        $(".modal").on('show.bs.modal', function () {
            $(".table").resize();
        });
        $(".modal").on('shown.bs.modal', function () {
            $(".table").resize();
        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        // $('#healthshetprojectList').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.tablewrapper').css({ 'height': tblheight - 165, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            //$(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });
        
        function BG_onChange(BU) {
            var BGID = BU;
            if (BGID == 0) {
                OU_onChange(0)
            }
            else {
                $("#cboOU").html('');
                var Parameter =
                {
                    TagID: 21034,
                    BGID: BGID,
                    UserID: UserId
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/PlannedVSActual/FillOrganizationUnit", param, false);
                var s = '';
                for (var i = 0; i < Result.length; i++) {
                    var ObjRateCard = Result[i];
                    s += '<option value="' + ObjRateCard.LocationID + '">' + ObjRateCard.Location + '</option>';
                }
                $("#cboOU").html(s);
            }
        }

        function OU_onChange(OU) {
            var BGID = $("#cboBG").val();
            var OUID = OU;
            $("#cboDU").html('');
            var Parameter =
            {
                TagID: 21034,
                BGID: BGID,
                OUID: OUID,
                UserID: UserId
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/FillDeliveryUnit", param, false);
            var s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.ResourcePoolID + '">' + ObjRateCard.ResourcePoolName + '</option>';
            }
            $("#cboDU").html(s);
        }

        function DU_onChange(DU) {
            var BGID = $("#cboBG").val();
            var OUID = $("#cboOU").val();
            var DUID = DU;
            $("#cboDT").html('');
            var Parameter =
            {
                TagID: 21034,
                BGID: BGID,
                OUID: OUID,
                DUID: DUID,
                UserID: UserId
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/FillDeliveryTeam", param, false);
            var s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.GroupID + '">' + ObjRateCard.GroupName + '</option>';
            }
            $("#cboDT").html(s);
        }

        //Only Apply Filter
        function ApplyFilter()
        {
            TotalRecords = 0;

            var QueryText = "";
            var isActive = $("#myteamIDchk").is(":checked");
            QueryText = GenerateBasicFilterQuery('', AllFields);
           
            if (QueryText == "" && isActive == false) {
                alertify.error("<%= MyBase.GetResourceString("A_AtLeastOneField") %>");
                return;
            }
            else
            {
                intPageNo = 1;
                StartLoader("#PlannedvsActual1");
                TBodyHeadFill();
                $("#filterpanel").removeClass("show");
                $("#AdvanceFilterIcon").addClass("activefilter");
                $(".clearalllink").css("display", "inline-block");
                $(".filter .fa-filter").css("color", "#1359a6");

                $("#AdvanceFilterIcon").addClass("activefilter");
                $(".clearalllink").css("display", "inline-block");
                $(".filter button").css("background", "#1359ac");
                $(".fa-filter").css("color", "#ffffff");

                //alertify.success("Filter applied Sucessfully");
                alertify.success("<%= MyBase.GetResourceString("A_FilterappliedSucessfully") %>");
                StopAjaxLoader("#PlannedvsActual1");                    
            }
        }

        function GenerateBasicFilterQuery(module, AllFields) {
            var strqtext = "";

            for (var i = 0; i < AllFields.length; i++) {
                var strvalue = '';
                if ($("#txt" + AllFields[i]).val() != null) {
                    strvalue = $("#txt" + AllFields[i]).val().trim();
                }
                else if ($("select#cbo" + AllFields[i] + ' option:selected').val() != null || $("select#cbo" + AllFields[i] + ' option:selected').val() != undefined) {
                    if ($("#cbo" + AllFields[i]).val() != 0) {
                        strvalue = $("#cbo" + AllFields[i]).val();
                    }
                }
                if (strvalue != "" && strvalue != null && strvalue != "null") {
                    if (strqtext != "") strqtext += " AND ";
                    strqtext += AllFields[i] + " ";
                    strqtext += '="' + strvalue + '"';
                }
            }
            strqtext = strqtext.replace('Over', '[Over]');
            strqtext = strqtext.replace(/'/g, "''");
            return strqtext;
        }

        function TBodyHeadFill() {

            $('#tableCalVeiw_wrapper').dataTable().fnDestroy();
            $("#BodytableCalVeiw").html('');
            var Resource = 'Resource Name';
            var tmonth = $("#txtMonth").val();
            if (tmonth <= 10) {
                tmonth = tmonth.replace("0","");
            }
            var Parameter =
            {
                TagID: 21034,
                UserID: UserId,
                Month: tmonth,
                Year: $("#txtYear").val(),
                strName: Resource
            }
            var param = JSON.stringify(Parameter);          
            var Result = AJAXCallWithResult("/api/PlannedVSActual/TBodyHeadFill", param, false);
            $("#BodytableCalVeiw").html(Result["m_StringValue"]);

            TBodyFill();
        }

        function TBodyFill()
        {
            var MyTeam = 0;
            if ($('#myteamIDchk').is(":checked")) {
                MyTeam = 1
            }
            var month = $("#txtMonth").val();
            var year = $("#txtYear").val();
            var CurrentDayOneMonthYear = month + '-' + '1-' + year;
            var CurrentlastDayMonthYear = month + '-' + LastDayOfMonth(year, month) + '-' + year;
            var Fromdate = new Date(CurrentDayOneMonthYear);
            var Todate = new Date(CurrentlastDayMonthYear);
            Fromdate = convertDate(Fromdate);
            Todate = convertDate(Todate);

            if (TotalRecords == 0) {
                //Total Record Count
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    EmployeeName: $("#txtResource").val().replace("'", "''''"),
                    CurrentDayOneMonthYear: Fromdate,
                    CurrentlastDayMonthYear: Todate,
                    BGID: $("#cboBG").val(),
                    OUID: $("#cboOU").val(),
                    RoleID: $("#cboRole").val(),
                    Designation: $("#cboDesignation").val(),
                    Skill: $("#cboSkill").val(),
                    DUID: $("#cboDU").val(),
                    DTID: $("#cboDT").val(),
                    EmployeeType: $("#cboEmployeeType").val(),
                    Department: $("#cboDepartment").val(),
                    UserID: UserId,
                    PoolID: $("#cboResourcePoolID").val(),
                    Deployable: $("#cboDeployable").val(),
                    MyTeam: MyTeam,
                    PageNo: 0,
                    PageSize: 0,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/PlannedVSActual/TBodyFill", param, false);
                var tgReportingName = '';
                for (var i = 0; i < Result.length; i++) {
                    var ReportingName = Result[i]["ReportingName"];
                    if (tgReportingName == '') {
                        TotalRecords++;
                    }
                    else if (tgReportingName == ReportingName) { }
                    else if (tgReportingName != ReportingName) {
                        TotalRecords++;
                    } 
                    tgReportingName = ReportingName;
                }
                $("#TotalRecords").text(TotalRecords);
                  //End of Total Record Count
            }
            
            $("#pginatebody").html('');
            var strHtml = '';
            var gReportingName = '';
            
            var Parameter =
            {
                TagID: 21034,
                UserID: UserId,
                EmployeeName: $("#txtResource").val().replace("'","''''"),
                CurrentDayOneMonthYear: Fromdate,
                CurrentlastDayMonthYear: Todate,
                BGID: $("#cboBG").val(),
                OUID: $("#cboOU").val(),
                RoleID: $("#cboRole").val(),
                Designation: $("#cboDesignation").val(),
                Skill: $("#cboSkill").val(),
                DUID: $("#cboDU").val(),
                DTID: $("#cboDT").val(),
                EmployeeType: $("#cboEmployeeType").val(),
                Department: $("#cboDepartment").val(),
                UserID: UserId,
                PoolID: $("#cboResourcePoolID").val(),
                Deployable: $("#cboDeployable").val(),
                MyTeam: MyTeam,
                PageNo: intPageNo,
                PageSize: PageSize,
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/TBodyFill", param, false);
            for (var i = 0; i < Result.length; i++) {
                var EmployeeID = Result[i]["EmployeeID"];
                var EmployeeName = Result[i]["EmployeeName"];
                var ReportingTo = Result[i]["ReportingTo"];
                var ReportingName = Result[i]["ReportingName"];
                var RowID = Result[i]["RowID"];

                var Html = FillActualPlan(Fromdate.replace(/ /g, "/"), Todate.replace(/ /g, "/"), EmployeeID);
                Html = Html.split("~");

                if (gReportingName == '') {
                    strHtml += '<tr>';
                    strHtml += '<td class="resrsmain text-start" colspan=' + Html[1] + '>';
                    strHtml += '<strong>[' + ReportingName + ']</strong>';
                    strHtml += '</td>';
                    strHtml += '</tr>';

                    strHtml += '<tr>';
                    strHtml += '<td class="text-start dropdown PRrolename">' + EmployeeName;
                    strHtml += '<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown"  data-bs-auto-close="outside" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>';
                    strHtml += '<ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllTask(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")> Show All Tasks</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowResourceUtilization(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")>Resource Utilization</a>';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllProjectAllocation(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")>Project Allocation</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllskills(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")>Skill Details</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllLeaveDetails(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")>Leave Details</a > ';
                    strHtml += '</li>';
                    strHtml += '</ul>';
                    strHtml += '</td>';

                    strHtml += Html[0];

                    strHtml += '</tr>';
                }
                else if (gReportingName == ReportingName) {
                    strHtml += '<tr>';
                    strHtml += '<td class="text-start dropdown PRrolename">' + EmployeeName;
                    strHtml += '<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown"  data-bs-auto-close="outside" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>';
                    strHtml += '<ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllTask(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")> Show All Tasks</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowResourceUtilization(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")>Resource Utilization</a>';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllProjectAllocation(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Fromdate.replace(/ /g, "/") + '")>Project Allocation</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllskills(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Fromdate.replace(/ /g, "/") + '")>Skill Details</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllLeaveDetails(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Fromdate.replace(/ /g, "/") + '")>Leave Details</a > ';
                    strHtml += '</li>';
                    strHtml += '</ul>';
                    strHtml += '</td>';

                    strHtml += Html[0];

                    strHtml += '</tr>';
                }
                else if (gReportingName != ReportingName) {
                    strHtml += '<tr>';
                    strHtml += '<td class="resrsmain text-start" colspan=' + Html[1] + '>';
                    strHtml += '<strong>[' + ReportingName + ']</strong>';
                    strHtml += '</td>';
                    strHtml += '</tr>';

                    strHtml += '<tr>';
                    strHtml += '<td class="text-start dropdown PRrolename">' + EmployeeName;
                    strHtml += '<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-bs-toggle="dropdown"  data-bs-auto-close="outside" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>';
                    strHtml += '<ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllTask(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")> Show All Tasks</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowResourceUtilization(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Todate.replace(/ /g, "/") + '")>Resource Utilization</a>';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllProjectAllocation(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Fromdate.replace(/ /g, "/") + '")>Project Allocation</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllskills(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Fromdate.replace(/ /g, "/") + '")>Skill Details</a > ';
                    strHtml += '</li>';
                    strHtml += '<li>';
                    strHtml += '<a class="dropdown-item" href="javascript:;" data-bs-toggle="modal" onclick=ShowAllLeaveDetails(' + EmployeeID + ',"' + Fromdate.replace(/ /g, "/") + '","' + Fromdate.replace(/ /g, "/") + '")>Leave Details</a > ';
                    strHtml += '</li>';
                    strHtml += '</ul>';
                    strHtml += '</td>';

                    strHtml += Html[0];

                    strHtml += '</tr>';
                }
                gReportingName = ReportingName;
                //if (RowID > 0) {
                //    TotalRecords = RowID;
                //}                
            }
           
            $("#pginatebody").html(strHtml);
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
            if (strHtml == "") {
                alertify.error("<%= MyBase.GetResourceString("A_DataNotAvailabe") %>" + $("#txtMonth").val() + " and year:" + $("#txtYear").val() );
            }
            Pagination();

            //Table Pagination
            //$(function ($) {
            //    var items = $("#tableCalVeiw tbody tr");
            //    var numItems = items.length;
            //    var perPage = 10;
            //    items.slice(perPage).hide();
            //    $("#pagination2").pagination({
            //        items: numItems,
            //        itemsOnPage: perPage,
            //        cssStyle: "light-theme",
            //        onPageClick: function (pageNumber) {
            //            var showFrom = perPage * (pageNumber - 1);
            //            var showTo = showFrom + perPage;
            //            items.hide()
            //                .slice(showFrom, showTo).show();
            //        }
            //    });
            //});
        }

        function FillActualPlan(Fromdt, Todate, EmployeeID) {
            var StrHtml = '';
            var ActualHrs = [];
            var ActualHrsHHMM = [];
            var PlannedHrs = [];
            var PlannedHrsHHMM = [];
            var DaysName = [];
            var Parameter =
            {
                TagID: 21034,
                UserID: UserId,
                CurrentDayOneMonthYear: Fromdt,
                CurrentlastDayMonthYear: Todate,
                EmpID: EmployeeID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/TBodyFillAginstEmployee", param, false);
            for (var i = 0; i < Result.length; i++) {
                ActualHrs = Result[i]["ActualHrs"].split(",");
                ActualHrsHHMM = Result[i]["ActualHrsHHMM"].split(",");
                PlannedHrs = Result[i]["PlannedHrs"].split(",");
                PlannedHrsHHMM = Result[i]["PlannedHrsHHMM"].split(",");
                DaysName = Result[i]["DayName"].split(",");
            }

            var Holidays1 = '';
            var Holidays = [];
            var Leaves1 = '';
            var Leaves = [];
            var HalfDayLeaves1 = '';
            var HalfDayLeaves = [];
            var WFH1 = '';
            var WFH = [];
            var Parameter1 =
            {
                TagID: 21034,
                UserID: UserId,
                FromDate: Fromdt,
                ToDate: Todate,
                EmpID: EmployeeID
            }
            var param1 = JSON.stringify(Parameter1);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/TBodyFillLegends", param1, false);
            for (var k = 0; k < Result.length; k++)
            {
                Holidays1 = Result[k]["Holidays"].split(",");
                Leaves1 = Result[k]["Leaves"].split(",");
                HalfDayLeaves1 = Result[k]["HalfDayLeaves"].split(",");
                WFH1 = Result[k]["WFH"].split(",");
            }
            
            for (var z = 0; z < Holidays1.length; z++)
            {
                if (Holidays1[z] == "" || Holidays1[z] == '') { }
                else {
                    var g = (parseInt(Holidays1[z]) - 1);
                    Holidays.push(g);
                }               
            }

            for (var z = 0; z < Leaves1.length; z++) {
                if (Leaves1[z] == "" || Leaves1[z] == '') { }
                else {
                    var g = (parseInt(Leaves1[z]) - 1);
                    Leaves.push(g);
                }
            }

            for (var z = 0; z < HalfDayLeaves1.length; z++) {
                if (HalfDayLeaves1[z] == "" || HalfDayLeaves1[z] == '') { }
                else {
                    var g = (parseInt(HalfDayLeaves1[z]) - 1);
                    HalfDayLeaves.push(g);
                }               
            }

            for (var z = 0; z < WFH1.length; z++) {
                if (WFH1[z] == "" || WFH1[z] =='') { }
                else
                {
                    var g = (parseInt(WFH1[z]) - 1);
                    WFH.push(g); 
                }                          
            }

            for (var k = 0; k < ActualHrs.length - 1; k++)
            {
                if (Holidays.indexOf(k) !== -1)
                {
                    if (PlannedHrs[k] > 0) {
                        StrHtml += '<td class="lgdPH">';
                    }
                    else if (Holidays.indexOf(k) !== -1) {
                        StrHtml += '<td class="tdlgdHoliday"> ';
                    }
                    else {
                        StrHtml += '<td class="">';
                    }
                }
                else if (Leaves.indexOf(k) !== -1)
                {
                    if (PlannedHrs[k] > 0) {
                        StrHtml += '<td class="lgdPL">';
                    }
                    else if (Leaves.indexOf(k) !== -1) {
                         StrHtml += '<td class="tdlgdLeave"> ';
                    }
                    else {
                        StrHtml += '<td class="">';
                    }
                }
                else if (HalfDayLeaves.indexOf(k) !== -1)
                {
                    if (PlannedHrs[k] > 0) {
                        StrHtml += '<td class="lgdPHD">';
                    }
                    else if (HalfDayLeaves.indexOf(k) !== -1) {
                        StrHtml += '<td class="tdlgdHalfday"> ';
                    }
                    else {
                        StrHtml += '<td class="">';
                    }                    
                }
                else if (WFH.indexOf(k) !== -1) {
                    if (PlannedHrs[k] > 0) {
                        StrHtml += '<td class="lgdPWFM">';
                    }
                    else if (WFH.indexOf(k) !== -1) {
                        StrHtml += '<td class="tdlgdWFH"> ';
                    }
                    else {
                        StrHtml += '<td class="">';
                    }
                }
                else if (PlannedHrs[k] > 0) {
                    StrHtml += '<td class="lgdPlannedday"> ';
                }
                else {
                    StrHtml += '<td class="">';
                }
                // Company Holiday Fill
                var tw = 0;
                for (w = 0; w < CompanyHolidays1.length; w++)
                {
                    if (DaysName[k] == CompanyHolidays1[w])
                    {
                        tw = 1;
                        var planned = PlannedHrs[k];
                        //if (ActualHrs[k] > 0 || parseInt(planned) > 0) {
                        if (ActualHrs[k] > 0 || parseInt(planned) > -1) {
                            //StrHtml += '<a href = "javascript:;" data-bs-toggle="modal" title = "Actual" onclick=ShowAllTask(' + EmployeeID + ',"' + Fromdt + '","' + Todate + '")>' + ActualHrsHHMM[k]  + '</a >';
                            StrHtml += '<a href = "javascript:;" data-bs-toggle="modal">&emsp;</a>';
                        }
                        else {
                            StrHtml += '<a href = "javascript:;" data-bs-toggle="modal">&emsp;</a>';
                        }
                    }
                }
                if (tw == 0)
                {
                    var planned = PlannedHrs[k]; 
                    StrHtml += '<a href = "javascript:;" data-bs-toggle="modal" title = "Actual" onclick=ShowAllTask(' + EmployeeID + ',"' + Fromdt + '","' + Todate + '")>' + ActualHrsHHMM[k] + '</a >';
                    //StrHtml += '<a href = "javascript:;" data-bs-toggle="modal" title = "Planned/Actual" onclick=ShowAllTask(' + EmployeeID + ',"' + Fromdt + '","' + Todate + '")> ' + planned + '<span class="PLNdividerline"></span>' + ActualHrs[k] + '</a >';
                } 
                //End of Company Holiday Fill

                StrHtml += '</td>';
            }

            StrHtml = StrHtml + "~" + (ActualHrs.length)
            return StrHtml;
        }

        function Show()
        {
            if (ValidateMonthYear() == true) { }
            else {
                    intPageNo = 1;
                    StartLoader("#PlannedvsActual1");
                    TBodyHeadFill();
                    StopAjaxLoader("#PlannedvsActual1");
            }
        }

        function LastDayOfMonth(Year, Month) {
            var k = new Date((new Date(Year, Month, 1)) - 1);
            var finaldate = convert(k);
            return finaldate;
        }

        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            //return [date.getFullYear(), mnth, day].join("-");
            return day;
        }

        function convertDate(str) {
            const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            const yyyy = str.getFullYear();
            let mm = month[str.getMonth()];
            let dd = str.getDate();

            if (dd < 10) dd = '0' + dd;
            if (mm < 10) mm = '0' + mm;
            const formattedToday = dd + ' ' + mm + ' ' + yyyy;
            return formattedToday;
        }

        function ValidateMonthYear() {
            var Flag = false;
            if (isBlank(Trim($("#txtMonth").val())) == true) {
                alertify.error("<%= MyBase.GetResourceString("A_MonthCannotBeBlank") %>");
                $("#txtMonth").focus();
                Flag = true;
                return Flag;
            }

            if (isBlank(Trim($("#txtYear").val())) == true) {
                alertify.error("<%= MyBase.GetResourceString("A_YearCannotBeBlank") %>");
                $("#txtYear").focus();
                Flag = true;
                return Flag;
            }

            if (Trim($("#txtYear").val()) <= 0) {
                alertify.error("<%= MyBase.GetResourceString("A_PleaseEnterValidYear") %>");
                $("#txtYear").focus();
                Flag = true;
                return Flag;
            }
            var k = $("#txtYear").val().length
            if (k < 4) {                
                alertify.error("<%= MyBase.GetResourceString("A_PleaseEnterValidYear") %>");
                $("#txtYear").focus();
                Flag = true;
                return Flag;
            }

            if (Trim($("#txtMonth").val()) <= 0 || Trim($("#txtMonth").val()) > 12) {
                alertify.error("<%= MyBase.GetResourceString("A_Pleaseentervaluebetween12month") %>");
                $("#txtMonth").focus();
                Flag = true;
                return Flag;
            }
        }

        
         
        function PreviousMonth() {
            $('.tooltip').removeClass('show');
            $("[data-toggle='tooltip']").tooltip('hide');
           
            if (ValidateMonthYear() == true) { }
            else {
                StartLoader("#PlannedvsActual1");
                intPageNo = 1;
                var month = $("#txtMonth").val();
                var year = $("#txtYear").val();

                if (month == 1) {
                    year = parseInt(year) - 1;
                    $("#txtMonth").val(12);
                    $("#txtYear").val(year)
                }
                else {
                    month = parseInt(month) - 1;
                    $("#txtMonth").val(month);
                }

                setTimeout(function () {
                    TBodyHeadFill();
                    Pagination();
                    StopAjaxLoader("#PlannedvsActual1");
                }, 1000);  
            } 
        }

        function NextMonth() {
            $('.tooltip').removeClass('show'); 
            $("[data-toggle='tooltip']").tooltip('hide');
            if (ValidateMonthYear() == true) { }
            else {
                StartLoader("#PlannedvsActual1");
                var month = $("#txtMonth").val();
                var year = $("#txtYear").val();
                intPageNo = 1;
                if (month == 12) {
                    year = parseInt(year) + 1;
                    $("#txtMonth").val(1);
                    $("#txtYear").val(year)
                }
                else {
                    month = parseInt(month) + 1;
                    $("#txtMonth").val(month);
                }
                
                setTimeout(function () {
                    TBodyHeadFill();
                    Pagination();
                    StopAjaxLoader("#PlannedvsActual1");
                }, 1000);
            } 
        }

        var gEmpID = '';
        var gFromDate = '';
        var gToDate = '';
        function ShowAllTask(EmpID, FromDate, ToDate)
        {
            StartLoader("#PlannedvsActual1");
            gEmpID = EmpID;
            gFromDate = FromDate;
            gToDate = ToDate;
            var strHTML = "";
            $("#TaskFromDate").text(FromDate);
            $("#TaskToDate").text(ToDate);

            var Parameter =
            {
                TagID: 21034,
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProgressTasksEmployeeName", param, false);
            for (var i = 0; i < Result.length; i++) {
                $("#TaskEmployeeName").text(Result[i]["EmployeeName"]);
            }

            // Start In Progress Tasks
            $('#inprogressgridTbl').dataTable().fnDestroy();
            $("#BodyinprogressgridTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                FromDate: FromDate,
                ToDate: ToDate,
                TaskType: $("#cboProjectTaskTypeID").val(),
                TaskProjectID: $("#txtInProgressProjectID").val(),
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProgressTasksDetails", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var EmployeeName = Result[i]["EmployeeName"];
                    var ProjectName = Result[i]["ProjectName"];
                    var TaskName = Result[i]["TaskName"];
                    var IsUserStoryTask = Result[i]["IsUserStoryTask"];
                    var TaskID = Result[i]["TaskID"];
                    var PlanStartDate = Result[i]["PlanStartDate"];
                    var PlanEndDate = Result[i]["PlanEndDate"];
                    var ActualStartDate = Result[i]["ActualStartDate"];
                    var ActualEndDate = Result[i]["ActualEndDate"];
                    //var Work = Result[i]["Work"];
                    var Work = Result[i]["WorkHHMM"];
                    //var Actual = Result[i]["Actual"];
                    var Actual = Result[i]["ActualHHMM"];
                    //var TillDateDuration = Result[i]["TillDateDuration"];
                    var TillDateDuration = Result[i]["TillDateDurationHHMM"];
                    var IsActive = Result[i]["IsActive"];
                    var TaskOnHold = Result[i]["TaskOnHold"];
                    if (IsActive == 1 && TaskOnHold==0) {
                        strHTML += '<tr>'
                    }
                    else if (IsActive == 0 && TaskOnHold == 0) {
                        strHTML += '<tr class="voidrow">'
                    }
                    else {
                        strHTML += '<tr class="onholdrow">'
                    }                    
                    //strHTML += '<td>' + EmployeeName+'</td>';
                    strHTML += '<td>' + ProjectName + '</td>';
                    strHTML += '<td>' + TaskName + '</td>';
                    //strHTML += '<td>' + IsUserStoryTask+'</td>';
                    //strHTML += '<td>' + TaskID+'</td>';
                    strHTML += '<td>' + PlanStartDate + '</td>';
                    strHTML += '<td>' + PlanEndDate + '</td>';
                    strHTML += '<td>' + ActualStartDate + '</td>';
                    strHTML += '<td>' + ActualEndDate + '</td>';
                    strHTML += '<td>' + Work + '</td>';
                    strHTML += '<td>' + Actual + '</td>';
                    strHTML += '<td>' + TillDateDuration + '</td>';
                    //strHTML += '<td>' + IsActive+'</td>';
                    //strHTML += '<td>' + TaskOnHold+'</td>';
                    strHTML += '</tr>';
                }
            }             
            $("#BodyinprogressgridTbl").html(strHTML); 
            $('#inprogressgridTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#inprogressgridTbl tbody tr td").prop("colspan", 9);
            }
            //Completed In Progress Tasks

            strHTML = '';

            // Start Not Started Tasks
            $('#innotstartedtasksgridTbl').dataTable().fnDestroy();
            $("#BodynotstartedtasksgridTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                FromDate: FromDate,
                ToDate: ToDate,
                TaskType: $("#cboProjectTaskTypeID").val(),
                TaskProjectID: $("#txtInProgressProjectID").val(),
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProgressNotStartedTasksEmployeeName", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var EmployeeName = Result[i]["EmployeeName"];
                    var ProjectName = Result[i]["ProjectName"];
                    var TaskName = Result[i]["TaskName"];
                    var IsUserStoryTask = Result[i]["IsUserStoryTask"];
                    var TaskID = Result[i]["TaskID"];
                    var PlanStartDate = Result[i]["PlanStartDate"];
                    var PlanEndDate = Result[i]["PlanEndDate"];
                    var ActualStartDate = Result[i]["ActualStartDate"];
                    var ActualEndDate = Result[i]["ActualEndDate"];
                    //var Work = Result[i]["Work"];
                    var Work = Result[i]["WorkHHMM"];
                    //var Actual = Result[i]["Actual"];
                    var Actual = Result[i]["ActualHHMM"];
                    //var TillDateDuration = Result[i]["TillDateDuration"];
                    var TillDateDuration = Result[i]["TillDateDurationHHMM"];
                    var IsActive = Result[i]["IsActive"];
                    var TaskOnHold = Result[i]["TaskOnHold"];
                    if (IsActive == 1 && TaskOnHold == 0) {
                        strHTML += '<tr>'
                    }
                    else if (IsActive == 0 && TaskOnHold == 0) {
                        strHTML += '<tr class="voidrow">'
                    }
                    else {
                        strHTML += '<tr class="onholdrow">'
                    }
                    //strHTML += '<td>' + EmployeeName+'</td>';
                    strHTML += '<td>' + ProjectName + '</td>';
                    strHTML += '<td>' + TaskName + '</td>';
                    //strHTML += '<td>' + IsUserStoryTask+'</td>';
                    //strHTML += '<td>' + TaskID+'</td>';
                    strHTML += '<td>' + PlanStartDate + '</td>';
                    strHTML += '<td>' + PlanEndDate + '</td>';
                    strHTML += '<td>' + ActualStartDate + '</td>';
                    strHTML += '<td>' + ActualEndDate + '</td>';
                    strHTML += '<td>' + Work + '</td>';
                    strHTML += '<td>' + Actual + '</td>';
                    strHTML += '<td>' + TillDateDuration + '</td>';
                    //strHTML += '<td>' + IsActive+'</td>';
                    //strHTML += '<td>' + TaskOnHold+'</td>';
                    strHTML += '</tr>';
                }
            }
            $("#BodynotstartedtasksgridTbl").html(strHTML);
            $('#innotstartedtasksgridTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#innotstartedtasksgridTbl tbody tr td").prop("colspan", 9);
            }
            //Completed Not Started Tasks


            //Completed Task
            strHTML = ''; 
            $('#incompletedtasksgridTbl').dataTable().fnDestroy();
            $("#BodycompletedtasksgridTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                FromDate: FromDate,
                ToDate: ToDate,
                TaskType: $("#cboProjectTaskTypeID").val(),
                TaskProjectID: $("#txtInProgressProjectID").val(),
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProgressCompletedTasksEmployeeName", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var EmployeeName = Result[i]["EmployeeName"];
                    var ProjectName = Result[i]["ProjectName"];
                    var TaskName = Result[i]["TaskName"];
                    var IsUserStoryTask = Result[i]["IsUserStoryTask"];
                    var TaskID = Result[i]["TaskID"];
                    var PlanStartDate = Result[i]["PlanStartDate"];
                    var PlanEndDate = Result[i]["PlanEndDate"];
                    var ActualStartDate = Result[i]["ActualStartDate"];
                    var ActualEndDate = Result[i]["ActualEndDate"];
                    //var Work = Result[i]["Work"];
                    var Work = Result[i]["WorkHHMM"];
                    //var Actual = Result[i]["Actual"];
                    var Actual = Result[i]["ActualHHMM"];
                    //var TillDateDuration = Result[i]["TillDateDuration"];
                    var TillDateDuration = Result[i]["TillDateDurationHHMM"];
                    var IsActive = Result[i]["IsActive"];
                    var TaskOnHold = Result[i]["TaskOnHold"];
                    if (IsActive == 1 && TaskOnHold == 0) {
                        strHTML += '<tr>'
                    }
                    else if (IsActive == 0 && TaskOnHold == 0) {
                        strHTML += '<tr class="voidrow">'
                    }
                    else {
                        strHTML += '<tr class="onholdrow">'
                    }
                    //strHTML += '<td>' + EmployeeName+'</td>';
                    strHTML += '<td>' + ProjectName + '</td>';
                    strHTML += '<td>' + TaskName + '</td>';
                    //strHTML += '<td>' + IsUserStoryTask+'</td>';
                    //strHTML += '<td>' + TaskID+'</td>';
                    strHTML += '<td>' + PlanStartDate + '</td>';
                    strHTML += '<td>' + PlanEndDate + '</td>';
                    strHTML += '<td>' + ActualStartDate + '</td>';
                    strHTML += '<td>' + ActualEndDate + '</td>';
                    strHTML += '<td>' + Work + '</td>';
                    strHTML += '<td>' + Actual + '</td>';
                    strHTML += '<td>' + TillDateDuration + '</td>';
                    //strHTML += '<td>' + IsActive+'</td>';
                    //strHTML += '<td>' + TaskOnHold+'</td>';
                    strHTML += '</tr>';
                }
            }
            $("#BodycompletedtasksgridTbl").html(strHTML);
            $('#incompletedtasksgridTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#incompletedtasksgridTbl tbody tr td").prop("colspan", 9);
            }
            //End of completed task

            StopAjaxLoader("#PlannedvsActual1");
            $("#showalltaskmodal").modal("show");
        }

        function cboInProgressTasks_OnChange(TaskID) {
            ShowAllTask(gEmpID, gFromDate, gToDate);
        }

        jQuery('#txtInProgressProjectID').on('input', function () {
            ShowAllTask(gEmpID, gFromDate, gToDate);
        });
        //End of Task

        //Project Allocation
        var gPAEmpID = '';
        var gPAFromDate = '';
        var gPAToDate = '';
        function ShowAllProjectAllocation(EmpID, FromDate, ToDate)
        {
            StartLoader("#PlannedvsActual1");
            gPAEmpID = EmpID;
            gPAFromDate = FromDate;
            gPAToDate = ToDate;
            var IsBillable = $("#cboProjectAllocationBillable").val();
            if (IsBillable == "Select Billable" || IsBillable == null || IsBillable =="") {
                IsBillable = 2;
            }
            var IsActive = $("#cboProjectAllocationActive").val();
            if (IsActive == "Select Active" || IsActive == null || IsActive == "") {
                IsActive = 2;
            }

            var ProjectName = $("#txtProjectAllocationProjectName").val().trim();
            if (ProjectName == "") {
                ProjectName = 0;
            }
            var ReportingTo = $("#txtProjectAllocationReportingTo").val().trim();
            if (ReportingTo == "") {
                ReportingTo = 0;
            }

            var strHTML = "";
            var Parameter =
            {
                TagID: 21034,
                EmpID: gPAEmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProjectAllocationResource", param, false);
            for (var i = 0; i < Result.length; i++) {
                $("#ProjectAllocationUserName").text(Result[i]["UserName"] + '-' + Result[i]["EmployeeName"]);
                $("#ProjectAllocationRoleDesc").text('[' + Result[i]["RoleDescription"] + ']');
            }

            $('#proallmodalTbl').dataTable().fnDestroy();
            $("#BodyproallmodalTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                EmpID: gPAEmpID,
                ProjectName: ProjectName,
                ReportingTo: ReportingTo,
                IsBillable: IsBillable,
                IsActive: IsActive
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProjectAllocationData", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var ProjectName = Result[i]["ProjectName"];
                    var RoleDescription = Result[i]["RoleDescription"];
                    var ExpectedStartDate = Result[i]["ExpectedStartDate"];
                    var ExpectedEndDate = Result[i]["ExpectedEndDate"];
                    var ReportingTo = Result[i]["ReportingName"];
                    var IsResourceBillable = Result[i]["IsResourceBillable"];
                    if (IsResourceBillable == 1) {
                        IsResourceBillable ="Yes" ;
                    }
                    else {
                        IsResourceBillable = "No";
                    }

                    strHTML += '<tr>'
                    strHTML += '<td>' + ProjectName + '</td>';
                    strHTML += '<td>' + RoleDescription + '</td>';
                    strHTML += '<td>' + ExpectedStartDate + '</td>';
                    strHTML += '<td>' + ExpectedEndDate + '</td>';
                    strHTML += '<td>' + ReportingTo + '</td>';
                    strHTML += '<td>' + IsResourceBillable + '</td>';
                    strHTML += '</tr>';
                }
            }            
            $("#BodyproallmodalTbl").html(strHTML);
            $('#proallmodalTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#proallmodalTbl tbody tr td").prop("colspan", 6);
            }
            StopAjaxLoader("#PlannedvsActual1");
            $("#Proallocationmodal").modal("show");
        }

        function ProjectAllocationBillable_OnChange() {
            ShowAllProjectAllocation(gPAEmpID, gPAFromDate, gPAToDate);
        }

        function ProjectAllocationActive_OnChange() {
            ShowAllProjectAllocation(gPAEmpID, gPAFromDate, gPAToDate);
        }

        jQuery('#txtProjectAllocationProjectName').on('input', function () {
            ShowAllProjectAllocation(gPAEmpID, gPAFromDate, gPAToDate);
        });

        jQuery('#txtProjectAllocationReportingTo').on('input', function () {
            ShowAllProjectAllocation(gPAEmpID, gPAFromDate, gPAToDate);
        });
        //End of project Allocation

        //Skill
        function ShowAllskills(EmpID, FromDate, ToDate) {
            StartLoader("#PlannedvsActual1");
            var strHTML = "";
            var Parameter =
            {
                TagID: 21034,
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProjectAllocationResource", param, false);
            for (var i = 0; i < Result.length; i++) {
                $("#skillUserName").text(Result[i]["UserName"] + '-' + Result[i]["EmployeeName"]);
                $("#skillRoleDesc").text('[' + Result[i]["RoleDescription"] + ']');
            }

            $('#skillDtlmodalTbl').dataTable().fnDestroy();
            $("#BodyskillDtlmodalTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/SkillData", param, false);
            if (Result.length > 0)
            {
                var gCategoryName = '';
                for (var i = 0; i < Result.length; i++)
                {
                    var CategoryName = Result[i]["CategoryName"];
                    var Description = Result[i]["Description"];
                    var Proficiency = Result[i]["Proficiency"];
                    var Experience = Result[i]["Experience"];

                    if (gCategoryName == '') {
                        strHTML += '<tr>'
                        strHTML += '<td>' + CategoryName + '</td>';
                        strHTML += '<td></td>';
                        strHTML += '<td></td>';
                        strHTML += '<td></td>';
                        strHTML += '</tr>';

                        strHTML += '<tr>'
                        strHTML += '<td></td>';
                        strHTML += '<td>' + Description + '</td>';
                        strHTML += '<td>' + Proficiency + '</td>';
                        strHTML += '<td>' + Experience + '</td>';
                        strHTML += '</tr>';
                    }
                    else if (CategoryName ==gCategoryName)
                    {
                        strHTML += '<tr>'
                        strHTML += '<td></td>';
                        strHTML += '<td>' + Description + '</td>';
                        strHTML += '<td>' + Proficiency + '</td>';
                        strHTML += '<td>' + Experience + '</td>';
                        strHTML += '</tr>';
                    }
                    else if (gCategoryName != CategoryName)
                    {
                        strHTML += '<tr>'
                        strHTML += '<td>' + CategoryName + '</td>';
                        strHTML += '<td></td>';
                        strHTML += '<td></td>';
                        strHTML += '<td></td>';
                        strHTML += '</tr>';

                        strHTML += '<tr>'
                        strHTML += '<td></td>';
                        strHTML += '<td>' + Description + '</td>';
                        strHTML += '<td>' + Proficiency + '</td>';
                        strHTML += '<td>' + Experience + '</td>';
                        strHTML += '</tr>';
                    }
                    gCategoryName = CategoryName;                     
                }
            }            
            $("#BodyskillDtlmodalTbl").html(strHTML);
            $('#skillDtlmodalTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#skillDtlmodalTbl tbody tr td").prop("colspan", 4);
            }
            StopAjaxLoader("#PlannedvsActual1");
            $("#Skilldetailmodal").modal("show");
        }
        //Skill End


        //Leave Detail
        function ShowAllLeaveDetails(EmpID, FromDate, ToDate) {
            StartLoader("#PlannedvsActual1");
            var strHTML = "";
            var Parameter =
            {
                TagID: 21034,
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ProjectAllocationResource", param, false);
            for (var i = 0; i < Result.length; i++) {
                $("#LeaveUserName").text(Result[i]["UserName"] + '-' + Result[i]["EmployeeName"]);
                $("#LeaveRoleDesc").text('[' + Result[i]["RoleDescription"] + ']');
            }

            $('#leaveDtlmodalTbl').dataTable().fnDestroy();
            $("#BodyleaveDtlmodalTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/LeaveDetail", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var LeaveType = Result[i]["LeaveType"];
                    var LeavesCount = Result[i]["LeavesCount"];
                    var NoOfLeaves = Result[i]["NoOfLeaves"];
                    var LeaveBalance = Result[i]["LeaveBalance"];
                    strHTML += '<tr>'
                    strHTML += '<td>' + LeaveType + '</td>';
                    strHTML += '<td>' + LeavesCount + '</td>';
                    strHTML += '<td>' + NoOfLeaves + '</td>';
                    strHTML += '<td>' + LeaveBalance + '</td>';
                    strHTML += '</tr>';
                }
            }
            $("#BodyleaveDtlmodalTbl").html(strHTML);
            $('#leaveDtlmodalTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#leaveDtlmodalTbl tbody tr td").prop("colspan", 4);
            }

            strHTML = '';
            //Financial Year
            $('#leavecountTbl').dataTable().fnDestroy();
            $("#BodyleavecountTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                EmpID: EmpID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/LeaveDetailYearly", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var Apr = Result[i]["Apr"];
                    var May = Result[i]["May"];
                    var Jun = Result[i]["Jun"];
                    var Jul = Result[i]["Jul"];
                    var Aug = Result[i]["Aug"];
                    var Sep = Result[i]["Sep"];
                    var Oct = Result[i]["Oct"];
                    var Nov = Result[i]["Nov"];
                    var Dec = Result[i]["Dec"];
                    var Jan = Result[i]["Jan"];
                    var Feb = Result[i]["Feb"];
                    var Mar = Result[i]["Mar"];

                    strHTML += '<tr>'
                    strHTML += '<td>' + Apr + '</td>';
                    strHTML += '<td>' + May + '</td>';
                    strHTML += '<td>' + Jun + '</td>';
                    strHTML += '<td>' + Jul + '</td>';
                    strHTML += '<td>' + Aug + '</td>';
                    strHTML += '<td>' + Sep + '</td>';
                    strHTML += '<td>' + Oct + '</td>';
                    strHTML += '<td>' + Nov + '</td>';
                    strHTML += '<td>' + Dec + '</td>';
                    strHTML += '<td>' + Jan + '</td>';
                    strHTML += '<td>' + Feb + '</td>';
                    strHTML += '<td>' + Mar + '</td>';
                    strHTML += '</tr>';
                }
            }             
            $("#BodyleavecountTbl").html(strHTML);
            $('#leavecountTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#leavecountTbl tbody tr td").prop("colspan", 12);
            }
            StopAjaxLoader("#PlannedvsActual1");
            $("#Leavbalmodal").modal("show");
        }
        //End of leave Detail


        function clearAll()
        {
            StartLoader("#PlannedvsActual1");
            for (k = 0; k < AllFields.length; k++) {
                if (AllFields[k] == "Resource") {
                    $("#txtResource").val('');
                }
                else {
                    $("#cbo" + AllFields[k]).val(0);
                }
            }
            $("#myteamIDchk").prop("checked", false);

            TBodyHeadFill();
            $(".filterpanel").removeClass('in');
            $(".clearalllink").css({ "display": "none" });
            $(".filter").css("color", "transperent");
            $(".filter .fa-filter").css("color", "#464a4c");
            $(".filter button").css("background", "none");
            StopAjaxLoader("#PlannedvsActual1");
        }

        //Resource Utilization
        var gUEmpID = "";
        var gUFromDate = "";
        var gUToDate="";
        function ShowResourceUtilization(EmpID, FromDate, ToDate)
        {
            gUEmpID = EmpID;
            gUFromDate = FromDate;
            gUToDate = ToDate;
            var Period = document.getElementById("cboPeriod");
            var Periodvalue = Period.value;
            var PeriodName = Period.options[Period.selectedIndex].text;

            $("#txtPeriodName").text(PeriodName);

            var strHTML = '';
            $('#RUtbl').dataTable().fnDestroy();
            $("#BodyRUtbl").html('');
            var Parameter =
            {
                TagID: 21034,
                EmpID: gUEmpID,
                UserID: UserId,
                Period: Periodvalue
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PlannedVSActual/ResourceUtilizationMonthly", param, false);
            if (Result.length > 0) {

                var gInstallCapacityHrs = 0;
                var gAllocatedHrs =0;
                var gAllocated = 0;
                var gActualHrs = 0;
                var gActual = 0;
                var gBillableHrs = 0;
                var gBillable = 0;
                var gCapacityHrs = 0;
                var gCapacity = 0;

                for (var i = 0; i < Result.length; i++)
                {
                    var Month = Result[i]["Month"];
                    var ResourceName = Result[i]["ResourceName"];
                    var InstallCapacityHrs = Result[i]["InstallCapacityHrsHHMM"];
                    var AllocatedHrs = Result[i]["AllocatedHrsHHMM"];
                    var Allocated = Result[i]["Allocated%"];
                    var ActualHrs = Result[i]["ActualHrsHHMM"];
                    var Actual = Result[i]["Actual%"];
                    var BillableHrs = Result[i]["BillableHrsHHMM"];
                    var Billable = Result[i]["Billable%"];
                    var CapacityHrs = Result[i]["CapacityHrsHHMM"];
                    var Capacity = Result[i]["Capacity%"];
                   
                    gInstallCapacityHrs += Result[i]["InstallCapacityHrs"];
                    gAllocatedHrs += Result[i]["AllocatedHrs"];
                    gAllocated += Result[i]["Allocated%"];
                    gActualHrs += Result[i]["ActualHrs"];
                    gActual += Result[i]["Actual%"];
                    gBillableHrs += Result[i]["BillableHrs"];
                    gBillable += Result[i]["Billable%"];
                    gCapacityHrs += Result[i]["CapacityHrs"];
                    gCapacity += Result[i]["Capacity%"];
                   
                    strHTML += '<tr>';
                    strHTML += '<td>' + Month + '</td>';
                    strHTML += '<td>' + ResourceName + '</td>'; 
                    strHTML += '<td>' + InstallCapacityHrs + '</td>';
                    strHTML += '<td>' + CapacityHrs + '</td>';
                    strHTML += '<td>' + Capacity.toFixed(2) + '</td>';
                    strHTML += '<td>' + AllocatedHrs + '</td>';
                    strHTML += '<td>' + Allocated.toFixed(2) + '</td>';
                    strHTML += '<td>' + ActualHrs + '</td>';
                    strHTML += '<td>' + Actual.toFixed(2) + '</td>';
                    strHTML += '<td>' + BillableHrs + '</td>';
                    strHTML += '<td>' + Billable.toFixed(2) + '</td>';
                    strHTML += '</tr>';                      
                }
                strHTML += '<tr class="totalrow">';
                strHTML += '<td>Grand Total</td>';
                strHTML += '<td></td>';
                strHTML += '<td>' + gInstallCapacityHrs.toFixed(2).replace(".",":") + '</td>';
                strHTML += '<td>' + gCapacityHrs.toFixed(2).replace(".", ":") + '</td>';
                strHTML += '<td>' + gCapacity.toFixed(2) + '</td>';
                strHTML += '<td>' + gAllocatedHrs.toFixed(2).replace(".", ":") + '</td>';
                strHTML += '<td>' + gAllocated.toFixed(2) + '</td>';
                strHTML += '<td>' + gActualHrs.toFixed(2).replace(".", ":") + '</td>';
                strHTML += '<td>' + gActual.toFixed(2) + '</td>';
                strHTML += '<td>' + gBillableHrs.toFixed(2).replace(".", ":") + '</td>';
                strHTML += '<td>' + gBillable.toFixed(2) + '</td>';
                strHTML += '</tr>';
            }
            $("#BodyRUtbl").html(strHTML);
            $('#RUtbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 12,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHTML == "") {
                $("#skillDtlmodalTbl tbody tr td").prop("colspan", 11);
            }
            $("#ProRsrsUtilizationmodal").modal("show");
        }

        function cboResourceUtilization_OnChange(Period) {
            ShowResourceUtilization(gUEmpID, gUFromDate, gUToDate);
        }

        //Resource Utilization End

        //AjaxCall Function
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Dashboard"));
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

        $(".PRrolename").on("click", ".projectCRmenu", function () {
            alert();
            $(".PRrolename").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
            $(this).closest("td").find(".dropdown-menu, .dropdown-toggle").addClass("show");
        });
         
        $('body').on('click', function (e) {
            if (!$('.dropdown.PRrolename').is(e.target) && $('.dropdown.PRrolename a').has(e.target).length === 0 && $('.show').has(e.target).length === 0) {
                $('.dropdown.PRrolename .dropdown-menu').removeClass('show');
            }
        });

        function InProgressTasksclear() {
            $("#txtInProgressProjectID").val('');
            $("#cboProjectTaskTypeID").val(0);
        }

        function ResourceUtilizationclear() {
            $("#cboPeriod").val(3);
        }

        function ProjectAllocationclear() {
            $("#txtProjectAllocationProjectName").val('');
            $("#txtProjectAllocationReportingTo").val('');
            $("#cboProjectAllocationBillable").val('Select Billable');
            $("#cboProjectAllocationActive").val('Select Active');
        }

        var specialKeys = '';
        function Field_OnKeyPress(e, fieldId) { 
            var keyCode = e.which ? e.which : e.keyCode  
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) { 
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<%= MyBase.GetResourceString("Pleaseenteronlynumericvalues") %>");
                }
            }
            return ret;
        }

        //Added by imran on 19-12-2022
        function Pagination()
        { 
            var currentRecord = (intPageNo * 10);

            if (parseInt(intPageNo) == 1) {
                $("#btnprevious").addClass("fa-disabled");
                $("#btnnext").removeClass("fa-disabled");
                $("#LinkPrevious").removeAttr("Onclick");

                if (parseInt($("#TotalRecords").text()) == currentRecord) {
                    $("#LinkNext").removeAttr("Onclick");
                }
                else {
                    $("#LinkNext").attr("Onclick", "NextList()");
                }
            }

            if (parseInt(currentRecord) > parseInt(TotalRecords) && intPageNo == 1) {
                $("#btnprevious").addClass("fa-disabled");
                $("#btnnext").addClass("fa-disabled");

                $("#LinkPrevious").removeAttr("Onclick");
                $("#LinkNext").removeAttr("Onclick");
            }
            else if (parseInt(currentRecord) >= parseInt(TotalRecords)) {
                $("#btnprevious").removeClass("fa-disabled");
                $("#btnnext").addClass("fa-disabled");
                $("#LinkPrevious").attr("Onclick", "PrevList()");
                $("#LinkNext").removeAttr("Onclick");
            }
            else if (parseInt(intPageNo) > 1 && parseInt(currentRecord) < parseInt(TotalRecords)) {
                $("#btnprevious").removeClass("fa-disabled");
                $("#btnnext").removeClass("fa-disabled");
                $("#LinkPrevious").attr("Onclick", "PrevList()");
                $("#LinkNext").attr("Onclick", "NextList()");
            }
            if (parseInt(SearchRecords) == "1" && parseInt(currentRecord) >= parseInt(TotalRecords)) {
                $("#btnprevious").addClass("fa-disabled");
                $("#btnnext").addClass("fa-disabled");
                $("#LinkPrevious").removeAttr("Onclick");
                $("#LinkNext").removeAttr("Onclick");
            }

            if (isIE() == "IE") {
                if ($("#btnprevious").hasClass("fa-disabled")) {
                    $("#btnprevious").addClass("clsPaginationEnableDisable");
                }
                else {
                    $("#btnprevious").removeClass("clsPaginationEnableDisable");
                }
                if ($("#btnnext").hasClass("fa-disabled")) {
                    $("#btnnext").addClass("clsPaginationEnableDisable");
                }
                else {
                    $("#btnnext").removeClass("clsPaginationEnableDisable");
                }
            }
            //$("#TotalRecords").html("");
            //$("#TotalRecords").html(TotalRecords);
        }

        function isIE() {
            var brwser = '';
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                return 'IE';
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'CR';
            }
            else if (M[1] === 'Firefox') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'FF';
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            return brwser;
        }

        function PrevList() {
            StartLoader("#PlannedvsActual1");
            if (intPageNo <= 1) {
                intPageNo = 1;
            }
            else {
                intPageNo -= 1;
            }
            setTimeout(function () {
                TBodyHeadFill();
                Pagination();
                StopAjaxLoader("#PlannedvsActual1");
            }, 1000); 
        }

        function NextList() {
            StartLoader("#PlannedvsActual1");
            intPageNo += 1;
            setTimeout(function () {
                TBodyHeadFill();
                Pagination();
                StopAjaxLoader("#PlannedvsActual1");
            }, 1000); 
        }
        //End of comment by imran on 19-12-2022

    </script>
</body>
</html>